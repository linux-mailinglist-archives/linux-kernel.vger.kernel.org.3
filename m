Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED244A7545
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiBBQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:02:40 -0500
Received: from foss.arm.com ([217.140.110.172]:39676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232626AbiBBQCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:02:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E7FA11D4;
        Wed,  2 Feb 2022 08:02:39 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6E5C3F73B;
        Wed,  2 Feb 2022 08:02:36 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] Make ETM register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:10 +0000
Message-Id: <20220202160226.37858-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on the branch broadcast change I found it difficult to search
for usages of registers and fields because of the magic numbers. I also
found it difficult to decide which style to make new code in because of the
varying ones used.

There was also a code review comment from Suzuki about replacing a magic
number so I'm proposing to refactor as many as possible into the style used
in sysreg.h which seems to be the new and most consistently used method.
For example it was used in the SPE and TRBE drivers.

This isn't an exhaustive refactor, but it does get all the basic accesses.
There are a couple of odd other cases remaining, mainly in the ETM3x code.
These can be found by searching for BMVAL.

There is one compromise to ensure this is a complete no-op and has
binary equivalence with the old version. I needed to keep two register
accesses here, where something like etmidr0 & TRCIDR0_INSTP0_LOAD_STORE
would be better:

  -	if (BMVAL(etmidr0, 1, 1) && BMVAL(etmidr0, 2, 2))
  -		drvdata->instrp0 = true;
  -	else
  -		drvdata->instrp0 = false;
  -
  +	drvdata->instrp0 = !!((REG_VAL(etmidr0, TRCIDR0_INSTP0) & 0b01) &&
  +			      (REG_VAL(etmidr0, TRCIDR0_INSTP0) & 0b10));

I think this change fixes quite a few issues like:

 * Some registers aren't referred to by name but a different variable name.
   For example eventctrl1 in mode_store() where TRCEVENTCTL1R isn't
   mentioned in that function.

 * Some bits aren't referred to by the name in the manual, even in the
   comments. For example TRCCONFIGR.RS only occurs as /* bit[12], Return
   stack enable bit */.

 * Some bits in the same register are referred to either as magic numbers
   or the publicly exported config macros, neiher of which are consistent
   with any other register accesses. For example

   config->cfg |= BIT(11);
   config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
   
 * Some fields are already partially referred to in the sysfs.h style way:
   TRCVICTLR_EXLEVEL_... etc. But other fields in the same register are not
   
 * Some fields are magic numbers that are repeated many times in different
   functions. For example vinst_ctrl |= BIT(9)

 * Some fields were referred to by magic numbers, even when there were
   already existing #defines. For example ETMTECR1_INC_EXC

 * Another benefit is that the #defines could be automatically checked
   against the reference manual because the style is uniform.

Testing
=======

To test this I used gcc-11 which doesn't have a quirk about changing
register widths in some cases (as in w -> x). I also used elf_diff which
showed me exactly where I'd made a mistake when I did
(https://github.com/noseglasses/elf_diff). But now that there is no
difference, objdump and diff also work for validation.

  make CC=gcc-11 modules
  diff <(objdump -d drivers/hwtracing/coresight/coresight-etm4x.ko) <(objdump -d ../linux2/drivers/hwtracing/coresight/coresight-etm4x.ko)
  diff <(objdump -d drivers/hwtracing/coresight/coresight.ko) <(objdump -d ../linux2/drivers/hwtracing/coresight/coresight.ko)

And for ETM3x (doesn't need gcc 11):

  make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  modules
  diff <(objdump -d drivers/hwtracing/coresight/coresight-etm3x.ko) <(objdump -d ../linux2/drivers/hwtracing/coresight/coresight-etm3x.ko)

When there are no differences, the diff output looks like this with only
the filename listed:

  < drivers/hwtracing/coresight/coresight-etm4x.ko:     file format elf64-littleaarch64
  ---
  > ../linux2/drivers/hwtracing/coresight/coresight-etm4x.ko:     file format elf64-littleaarch64

Applies to coresight/next 30d1f1c71b

James Clark (15):
  coresight: Make ETM4x TRCIDR0 register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCIDR2 register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCIDR3 register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCIDR4 register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCIDR5 register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCCONFIGR register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCEVENTCTL1R register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCSTALLCTLR register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCVICTLR register accesses consistent with
    sysreg.h
  coresight: Make ETM3x ETMTECR1 register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCACATRn register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCSSCCRn and TRCSSCSRn register accesses
    consistent with sysreg.h
  coresight: Make ETM4x TRCSSPCICRn register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCBBCTLR register accesses consistent with
    sysreg.h
  coresight: Make ETM4x TRCRSCTLRn register accesses consistent with
    sysreg.h

 .../coresight/coresight-etm3x-core.c          |   2 +-
 .../coresight/coresight-etm3x-sysfs.c         |   2 +-
 .../coresight/coresight-etm4x-core.c          | 135 +++++--------
 .../coresight/coresight-etm4x-sysfs.c         | 178 +++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h | 159 ++++++++++++++--
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 6 files changed, 283 insertions(+), 194 deletions(-)

-- 
2.28.0

