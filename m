Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E537948D377
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiAMITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:19:36 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:17132 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbiAMITf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1642061975; x=1673597975;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8bp8FKrTEUjqpGTGgV1by4+xj1+qlkc5SGm08bGMoT4=;
  b=HXsfB4NHSEOvrOLU3kalkwqrc5T+/dbJRhjVJ+AxakL6jIa9j21ccAHw
   PLWtTKqWHUybLmMBwkL1RKtGacejuKwPX8gGgSPRdV8u+F97qYmoeS9yp
   Pi37+nH4IhW5k2HhNM83qGxHGz8tpqgCv6pnurvWMLjZ227HXIiZXfn6h
   OpLGK8Zc400md/VlSwHYcXly4nB/JyZrhqS5b+nRdwUO0aIp6RlViAhXD
   jEED7rwvLoR6M7tpcP7NX4bdundLv5VnezoGiO0r4kTKVElZHT5OiMa1R
   8B93hmCU7ZOo4ol3WyK9evSpPOfLBqIbou7xrsTEbF27MSpqu+RaQkmB9
   w==;
X-IronPort-AV: E=Sophos;i="5.88,284,1635199200"; 
   d="scan'208";a="21474406"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Jan 2022 09:19:34 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 13 Jan 2022 09:19:34 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 13 Jan 2022 09:19:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1642061974; x=1673597974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8bp8FKrTEUjqpGTGgV1by4+xj1+qlkc5SGm08bGMoT4=;
  b=Bwrxvf6wgVTZutEgv9eBhNR2h/uk0/6kzFJl5NsltWagk3WTYNtm+oPa
   pCtxRJGs+ciRU5mOLeg8DHSJR8KUUUu+ov241d6+Ljjx2SOnsRrGZvp67
   4r4AcvMtRF7ZU5zrfg1AH2GYsDr+B+sGQ8AN5V2uXDVFeR/ZNT1+G769C
   W+MB4wNoXR4hMJ83A0rDq/4J2dJDx7o0wkR3JOmfK/8Iduu48vlKpXQ85
   3Fvb4d7cTO+TgKOmhnQpqi/YkplYoIe/9YA/efDu8wvzD8Q4rJGIesqpU
   +dzGM96jhI9gatxNJVp40hdGw9PUymh1XMfnlXePRCWDiSEtPHCnfwicE
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,284,1635199200"; 
   d="scan'208";a="21474405"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Jan 2022 09:19:34 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 83E2F280065;
        Thu, 13 Jan 2022 09:19:33 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] scripts/dtc: dtx_diff: remove broken example from help text
Date:   Thu, 13 Jan 2022 09:19:18 +0100
Message-Id: <20220113081918.10387-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtx_diff suggests to use <(...) syntax to pipe two inputs into it, but
this has never worked: The /proc/self/fds/... paths passed by the shell
will fail the `[ -f "${dtx}" ] && [ -r "${dtx}" ]` check in compile_to_dts,
but even with this check removed, the function cannot work: hexdump will
eat up the DTB magic, making the subsequent dtc call fail, as a pipe
cannot be rewound.

Simply remove this broken example, as there is already an alternative one
that works fine.

Fixes: 10eadc253ddf ("dtc: create tool to diff device trees")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 scripts/dtc/dtx_diff | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
index d3422ee15e30..f2bbde4bba86 100755
--- a/scripts/dtc/dtx_diff
+++ b/scripts/dtc/dtx_diff
@@ -59,12 +59,8 @@ Otherwise DTx is treated as a dts source file (aka .dts).
    or '/include/' to be processed.
 
    If DTx_1 and DTx_2 are in different architectures, then this script
-   may not work since \${ARCH} is part of the include path.  Two possible
-   workarounds:
-
-      `basename $0` \\
-          <(ARCH=arch_of_dtx_1 `basename $0` DTx_1) \\
-          <(ARCH=arch_of_dtx_2 `basename $0` DTx_2)
+   may not work since \${ARCH} is part of the include path.  The following
+   workaround can be used:
 
       `basename $0` ARCH=arch_of_dtx_1 DTx_1 >tmp_dtx_1.dts
       `basename $0` ARCH=arch_of_dtx_2 DTx_2 >tmp_dtx_2.dts
-- 
2.25.1

