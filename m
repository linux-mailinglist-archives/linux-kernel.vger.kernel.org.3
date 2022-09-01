Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F05A8A6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiIABPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiIABPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:15:18 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231057210;
        Wed, 31 Aug 2022 18:15:15 -0700 (PDT)
Received: from grover.sesame (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 2811DDtu004311;
        Thu, 1 Sep 2022 10:13:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 2811DDtu004311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661994794;
        bh=pSLA7lAlGxKHbICT8gTY7i5Zp2giDjasDzYgClZZbNY=;
        h=From:To:Cc:Subject:Date:From;
        b=qID+LEtprhEh9OzWC/QN0PYJNs5/bV9Yf3wWeIehxq6QVxx1Qrfi1dBZy4N3dHPQw
         h3Hw5f0kjWFaP4dS5Ix7dittJ4MidYbEIBUw1PJFnoMhjbvy32oFsrvRWP+30lYLdW
         aFhZHBX8mFEmEMOUZoTk7FTTfe1r9mGp+/gcxt7d2cLATiGhjQAQBWzVodLvalrK9V
         Uqlyz013HHH2cxFkYyF+Z/TQVy1W1XlvVdR/fgaJjpy6ln1xvk6/Nt0giw+GYZCSFL
         NW2AsX7J7P82MpQZ914zQFNWWqTxAAVivHrQBwGPRbVlZDJntbN+9cD7voBgRfI7bZ
         VouolwA3KaAJA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: disable header exports for UML in a straightforward way
Date:   Thu,  1 Sep 2022 10:12:52 +0900
Message-Id: <20220901011252.550830-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously 'make ARCH=um headers' stopped because of missing
arch/um/include/uapi/asm/Kbuild.

The error is not shown since commit ed102bf2afed ("um: Fix W=1
missing-include-dirs warnings") because UML got
arch/um/include/uapi/asm/Kbuild.

Hard-code the unsupported architecture, so it works like before.

Fixes: ed102bf2afed ("um: Fix W=1 missing-include-dirs warnings")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9d40255d1557..8d2047a4de9b 100644
--- a/Makefile
+++ b/Makefile
@@ -1304,8 +1304,7 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 
 PHONY += headers
 headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
-	$(if $(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/Kbuild),, \
-	  $(error Headers not exportable for the $(SRCARCH) architecture))
+	$(if $(filter um, $(SRCARCH)), $(error Headers not exportable for UML))
 	$(Q)$(MAKE) $(hdr-inst)=include/uapi
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
 
-- 
2.34.1

