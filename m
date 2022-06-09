Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDD15455F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbiFIUsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiFIUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:48:44 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 13:48:41 PDT
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019518ADB0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:48:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by dnyon.com (Postfix) with ESMTP id 224455F2AE;
        Thu,  9 Jun 2022 20:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1654807359; bh=p9XvnEkj1RVqj8MmuG7tTTn6LRlcraWnGnErsk5JDSE=;
        h=From:To:Cc:Subject:Date:From;
        b=hdG6ol6agScOIyIzXZtH7R2PkZArGokK10WVqg+voD6Ho1ze8ZYWvTM7uHsIGoI3V
         +0Ts/sSp29+LkTJ9rO8ofbrpN/gBx9LODlrPh3W1JhaqLgN859/BRnv0pvRzNWVctA
         R2EgY6Z7c7VqlYL1ncB3CNA7jjF2LdKIjCpCTzf8PqAV24SapJSEJvI67LeaSWYl9L
         qqmt3G3pP1wzlerQq1SAJRUisdJ4tAb4Av6nhep4Cfn+sVRhmaVBGkyJst8tGmFseR
         l621nrm3oziyxJkukg6DlzDzX8e1S4iibuOwn5TXdozYOlHI44ft2Mh5hXlRfFQJGt
         A32Oiktwexk/w==
Received: from dnyon.com by localhost (amavisd-new, unix socket) with LMTP
        id OlTK52l_5q6i; Thu,  9 Jun 2022 20:42:38 +0000 (UTC)
Received: from dnyon.com (43.red-88-5-137.dynamicip.rima-tde.net [88.5.137.43])
        by dnyon.com (Postfix) with ESMTPSA id 06DCB5F10F;
        Thu,  9 Jun 2022 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1654807358; bh=p9XvnEkj1RVqj8MmuG7tTTn6LRlcraWnGnErsk5JDSE=;
        h=From:To:Cc:Subject:Date:From;
        b=BBKZUexg0IyeOrSHUgFNWadLJRty2BgD0zYDSFliUGxFKr5zZEglnjT+I1kemRtXl
         jAjD6FqIOq5ElX1wQiSj290kc9lf0/tNCfEOhAJCyTfwriYhNYOlqcQ0QxVK05VPYW
         iLF/lznf933MTG0WWVxnGWA+XwEt+KuQ+u9XEP+lS+r/zrd/8e9YrdD/Cyc+6PK01L
         IUv50l9zeAXI93nE/SBdmqh9JkiHFeWUEOOLTZp/O6o4xifgpqy1u1b2S/wZ+TNfg9
         Rbbgv0/Ni7tXqMYSO9HVgphPXJkX0qq8YrM185z7jmJc/x6b9T11W+QF+JEMSYpvxt
         jIsfYtiGl7zCQ==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/sysreg: Fix typo in Enum element regex
Date:   Thu,  9 Jun 2022 22:42:18 +0200
Message-Id: <20220609204220.12112-1-atafalla@dnyon.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the awk script, there was a typo with the comparison operator when
checking if the matched pattern is inside an Enum block.
This prevented the generation of the whole sysreg-defs.h header.

Fixes: 66847e0618d7 ("arm64: Add sysreg header generation scripting")
Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 arch/arm64/tools/gen-sysreg.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index 89bfb74e28de..5c55509eb43f 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -253,7 +253,7 @@ END {
 	next
 }
 
-/0b[01]+/ && block = "Enum" {
+/0b[01]+/ && block == "Enum" {
 	expect_fields(2)
 	val = $1
 	name = $2
-- 
2.36.1

