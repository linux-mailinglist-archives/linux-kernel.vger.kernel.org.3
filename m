Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED47573B34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiGMQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiGMQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:27:40 -0400
X-Greylist: delayed 82505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 09:27:39 PDT
Received: from 19.mo581.mail-out.ovh.net (19.mo581.mail-out.ovh.net [178.33.251.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48160DE2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:27:39 -0700 (PDT)
Received: from player759.ha.ovh.net (unknown [10.108.20.216])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 7A5192441A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:09:06 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player759.ha.ovh.net (Postfix) with ESMTPSA id 3AE122CA29113;
        Wed, 13 Jul 2022 16:08:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004d41d503d-8019-4142-ac48-19dc98630b84,
                    E7234B73E98B8DBC7B685B4C32F27E263784F647) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Stephen Kitt <steve@sk2.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86/Kconfig: specify idle=poll instead of no-hlt
Date:   Wed, 13 Jul 2022 18:08:40 +0200
Message-Id: <20220713160840.1577569-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17159277531323926235
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 27be45700021 ("x86 idle: remove 32-bit-only "no-hlt" parameter,
hlt_works_ok flag") removed no-hlt, but CONFIG_APM still refers to
it. Suggest "idle=poll" instead, based on the commit message:

> If a user wants to avoid HLT, then "idle=poll"
> is much more useful, as it avoids invocation of HLT
> in idle, while "no-hlt" failed to do so.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a293a30e4cdd..bb4fa31bec4d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2517,7 +2517,7 @@ menuconfig APM
 
 	  1) make sure that you have enough swap space and that it is
 	  enabled.
-	  2) pass the "no-hlt" option to the kernel
+	  2) pass the "idle=poll" option to the kernel
 	  3) switch on floating point emulation in the kernel and pass
 	  the "no387" option to the kernel
 	  4) pass the "floppy=nodma" option to the kernel

base-commit: 50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc
-- 
2.31.1

