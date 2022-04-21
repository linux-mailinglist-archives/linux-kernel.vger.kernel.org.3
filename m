Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900AA509D57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388184AbiDUKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388116AbiDUKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CBBB9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so4750370pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RX5iF0HtvkRBM2maUvoUXLZ+1rzQwjz1rJUJGgTLGgc=;
        b=CfVifOM3cHI3CnnB7pbqZiEHrIUZ8KSh9YgMU/iUgsbkX7GgNVDDJLuPLghfXfxVJs
         ALTUPSzGkgsuJL4opQTNkoYHM19lwWShNsrgXPD9cAB42eHfBT6BtsD0nM1dnOGTv2i+
         R4QarCAmnTq5xHAe7JAbH5TLeZDGIgYbrAhSmhftQYtByfNYyOP3y1Dvsduf+x543P/F
         XuAtVF2tJhlPb3muDxc1j6XDps81zCF4vgztyB3ckWge6o0tRTXYYg2fbx/Dx5yIjl+Z
         7RgBB/QB6FeDBN+ATwhcI+zL/uh08jDzOG2gga994WbI83IP7AGzSli6fm1dOBc45l73
         RHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RX5iF0HtvkRBM2maUvoUXLZ+1rzQwjz1rJUJGgTLGgc=;
        b=Z+kRJmDzkdHbLz4DC30H3SqAZD79tE/2Ggny5krqZDr2auEHjlchUs5ANc2Ji45Euz
         0sdlVzm5SRQZ2YoJ2BtJdnCUI3CBZUiwN53DOO0Xc9S+7qCf5gPKmPP9rgNaUSFfNqFE
         TJaenKgdkjQuP4MTUpUl0+7kUBSUHezruVi0ml/Um8ucU94cjQGjYBlxnrDyCw7301mC
         86iKTc8nVUAco1w2hIbD/Gkef8aYi+wZdK8xOyy+qclCC90FMZjPWIqblA+SgdR2EBiV
         3gV/wGQCO4mdUfhhttWzNomokfh3H0udODwp1HbXid4xUW5lgJmWMAK+yRbOaqA7xIfD
         vrcA==
X-Gm-Message-State: AOAM530YJbbawdDJT3x/sSBmrRjqblWVNkPlIliNRsLwP5rYaCrTrcmo
        a6VFF/cF9thPCbeZR4XDy0w=
X-Google-Smtp-Source: ABdhPJznA9iYGQjenX1DRqkxmGXQFzHF3/OwRD34uEMoP0v3Tsdgg86q7k0I/Y4qTXbPYQnka7aTAw==
X-Received: by 2002:a17:902:9a0a:b0:158:a22a:5448 with SMTP id v10-20020a1709029a0a00b00158a22a5448mr25546443plp.20.1650535860130;
        Thu, 21 Apr 2022 03:11:00 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:10:59 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 04/10] xtensa: clean up excsave1 initialization
Date:   Thu, 21 Apr 2022 03:10:27 -0700
Message-Id: <20220421101033.216394-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421101033.216394-1-jcmvbkbc@gmail.com>
References: <20220421101033.216394-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use xtensa_set_sr instead of inline assembly.
Rename local variable exc_table in early_trap_init to avoid conflict
with per-CPU variable of the same name.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/traps.h | 4 ++--
 arch/xtensa/kernel/traps.c      | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index bfdb0af61b07..514376eff58c 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -57,11 +57,11 @@ void do_unhandled(struct pt_regs *regs);
 /* Initialize minimal exc_table structure sufficient for basic paging */
 static inline void __init early_trap_init(void)
 {
-	static struct exc_table exc_table __initdata = {
+	static struct exc_table init_exc_table __initdata = {
 		.fast_kernel_handler[EXCCAUSE_DTLB_MISS] =
 			fast_second_level_miss,
 	};
-	__asm__ __volatile__("wsr  %0, excsave1\n" : : "a" (&exc_table));
+	xtensa_set_sr(&init_exc_table, excsave1);
 }
 
 void secondary_trap_init(void);
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index d6b1a0c3e319..95903f25e523 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -372,8 +372,7 @@ __init trap_set_handler(int cause, xtensa_exception_handler *handler)
 
 static void trap_init_excsave(void)
 {
-	unsigned long excsave1 = (unsigned long)this_cpu_ptr(&exc_table);
-	__asm__ __volatile__("wsr  %0, excsave1\n" : : "a" (excsave1));
+	xtensa_set_sr(this_cpu_ptr(&exc_table), excsave1);
 }
 
 static void trap_init_debug(void)
-- 
2.30.2

