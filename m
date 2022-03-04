Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADDD4CD9FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbiCDRUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiCDRUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF7221480C9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF1971424;
        Fri,  4 Mar 2022 09:19:21 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1308B3F73D;
        Fri,  4 Mar 2022 09:19:19 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] Make ETM register accesses consistent with sysreg.h
Date:   Fri,  4 Mar 2022 17:18:57 +0000
Message-Id: <20220304171913.2292458-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 * Implement Mike's suggestion of not having _SHIFT and using the existing
   FIELD_GET and FIELD_PREP methods.
 * Dropped the change to add the new REG_VAL macro because of the above.
 * FIELD_PREP could be used in some trivial cases, but in some cases the
   shift is still required but can be calculated with __bf_shf
 * Improved the commit messages.
 * The change is still binary equivalent, but requires an extra step 
   mentioned at the end of this cover letter.

Applies to coresight/next 3619ee28488
Also available at https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-register-refactor-v3

To check for binary equivalence follow the same steps in the cover letter
of v2, but apply the following change to coresight-priv.h. This is because
the existing version of the macros wrap the expression in a new scope {}
that flips something in the compiler:

  #undef FIELD_GET
  #define FIELD_GET(_mask, _reg) (((_reg) & (_mask)) >> __bf_shf(_mask))
  #undef FIELD_PREP
  #define FIELD_PREP(_mask, _val) (((_val) << __bf_shf(_mask)) & (_mask))

Thanks
James

James Clark (15):
  coresight: etm4x: Cleanup TRCIDR0 register accesses
  coresight: etm4x: Cleanup TRCIDR2 register accesses
  coresight: etm4x: Cleanup TRCIDR3 register accesses
  coresight: etm4x: Cleanup TRCIDR4 register accesses
  coresight: etm4x: Cleanup TRCIDR5 register accesses
  coresight: etm4x: Cleanup TRCCONFIGR register accesses
  coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
  coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
  coresight: etm4x: Cleanup TRCVICTLR register accesses
  coresight: etm3x: Cleanup ETMTECR1 register accesses
  coresight: etm4x: Cleanup TRCACATRn register accesses
  coresight: etm4x: Cleanup TRCSSCCRn and TRCSSCSRn register accesses
  coresight: etm4x: Cleanup TRCSSPCICRn register accesses
  coresight: etm4x: Cleanup TRCBBCTLR register accesses
  coresight: etm4x: Cleanup TRCRSCTLRn register accesses

 .../coresight/coresight-etm3x-core.c          |   2 +-
 .../coresight/coresight-etm3x-sysfs.c         |   2 +-
 .../coresight/coresight-etm4x-core.c          | 136 +++++--------
 .../coresight/coresight-etm4x-sysfs.c         | 180 +++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h | 122 ++++++++++--
 5 files changed, 244 insertions(+), 198 deletions(-)

-- 
2.28.0

