Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312956426F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiGBTNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiGBTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:13:48 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Jul 2022 12:13:46 PDT
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97DDE0D3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 12:13:46 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 20668 invoked from network); 2 Jul 2022 21:07:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1656788824; bh=phIJgjbW9gbdsBNFT7abBY67sM/w1Sze6Xpin3JN2yg=;
          h=From:To:Subject;
          b=lPJnN5G0mEYZvYm3IZtGrZhhTtk8L/VLrNfIwoq18o1xT8zLGANmOBnTQB8WuRk3B
           cxvDS2XORChZREMtzhYA7AeS+4XAx6N2KmK8VNU5kdlTgeY1szqn4O3mfehICR0bsE
           2jqCMQysUddH+d8gfoCqdju0Pck0JQkhmNJ+QXiA=
Received: from ip-137-21.ds.pw.edu.pl (HELO LAPTOP-OLEK.lan) (olek2@wp.pl@[194.29.137.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tsbogend@alpha.franken.de>; 2 Jul 2022 21:07:04 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     tsbogend@alpha.franken.de, olek2@wp.pl,
        martin.blumenstingl@googlemail.com, hauke@hauke-m.de,
        git@birger-koblitz.de, sander@svanheule.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second VPE
Date:   Sat,  2 Jul 2022 21:07:05 +0200
Message-Id: <20220702190705.5319-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 8a917b0ca8e2bc46da9da215dae9b8bf
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kXOU]                               
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is needed to handle interrupts by the second VPE on
the Lantiq xRX200, xRX300 and xRX330 SoCs. In these chips, 32 ICU
interrupts are connected to each hardware line. The SoC supports
a total of 160 interrupts. Currently changing smp_affinity to the
second VPE hangs interrupts.

This problem affects multithreaded SoCs with a custom interrupt
controller. Chips with 1004Kc core and newer use the MIPS GIC.

Also CC'ed Birger Koblitz and Sander Vanheule. Both are working
on support for Realtek RTL930x chips with 34Kc core and Birger
has added a patch in OpenWRT that also enables all interrupt
lines. So it looks like this patch is useful for more SoCs.

Tested on lantiq xRX200 and xRX330.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/mips/kernel/smp-mt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 5f04a0141068..f21cd0eb1fa7 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -113,8 +113,7 @@ static void vsmp_init_secondary(void)
 					 STATUSF_IP4 | STATUSF_IP5 |
 					 STATUSF_IP6 | STATUSF_IP7);
 	else
-		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
-					 STATUSF_IP6 | STATUSF_IP7);
+		set_c0_status(ST0_IM);
 }
 
 static void vsmp_smp_finish(void)
-- 
2.30.2

