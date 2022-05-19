Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F952D9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiESQOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiESQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:14:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49558C6E66
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:14:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C735C1F45E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652976848;
        bh=rfIX7T1vrLJCiPikRvVRNfxxyu38980k27vFI1IQdo8=;
        h=From:To:Cc:Subject:Date:From;
        b=oKM8pdgKa1t9qM2com5SF7AqoSdEe+EA9I1xdAm8WYcWB0ahj8mUoIj8JYvNuhcSy
         k44S3tO8DOXFkiEV+qsK4s/Cw5e7oJGJaMqVSV2+/IJfTkTvBwYcLMNi7kYFe/wtBa
         l7jDJgsD/pFJJCmxvKDeaUXCRCJPIpONX+QuiD1fwFpabxQd6f3be/tMbc61gLP1qV
         DpffxxiQC3dHlPt6YXYQfsxZR2cJ5nWKRU5bStYs+LXUv0fnCQoyPMHaRyjpdcT7Iq
         T3sXz+sfOytVsZxPZS4w44OxwravQEGqnBOZwOVlasbf9jVIfum+GjKVQJsF5v476A
         Gk7HmLkFKQNeg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: Silence proc-v7-bugs.c spam about disabled Spectre workarounds
Date:   Thu, 19 May 2022 19:13:10 +0300
Message-Id: <20220519161310.1489625-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print message about disabled Spectre workarounds only once to stop
endless spam into KSMG each time CPU goes out from idling state.
This spam makes system unusable with CONFIG_HARDEN_BRANCH_PREDICTOR=n
for those who don't care about security and wants maximum performance.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm/mm/proc-v7-bugs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index fb9f3eb6bf48..f9730eba0632 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -108,8 +108,7 @@ static unsigned int spectre_v2_install_workaround(unsigned int method)
 #else
 static unsigned int spectre_v2_install_workaround(unsigned int method)
 {
-	pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n",
-		smp_processor_id());
+	pr_info_once("Spectre V2: workarounds disabled by configuration\n");
 
 	return SPECTRE_VULNERABLE;
 }
-- 
2.35.3

