Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD757C888
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiGUKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiGUKEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:04:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882A03A4A2;
        Thu, 21 Jul 2022 03:04:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy29so2211924ejc.12;
        Thu, 21 Jul 2022 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OmiME2WjuBaxraPUdAySd/nUD3D7/qmdyLuktPj9ZJY=;
        b=GFCfEGC9t+Rf8CxbPXrlDDDL7mAzykWfdZPlI+fBTNr+n5dMUjsf+tuC24l4EUTRQV
         uYZxZMIUnKZ/dYK3Ys4b321ivYvsrZY8mdP7ERI/6fNcxjKxT85hVvUPIf9ofBm/imUR
         lLMrICWUCs04Kbu9tvpI3CGz23i3O1fwyikYJaYhalXGpIGwndbd+mISslCl2GAGS529
         oT4DDCkVyqe+s0EOcYDc/8xg8mCwsyjW2usVFuUiZBa+C1AJDGovrqcQlGvjiYu/aTdi
         NQtkB352wwNcOH7Df9yYjD+qq17DItb4Zcq3UJL0EvV99y/VciaFhTTVSEZJWLADepqT
         xtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OmiME2WjuBaxraPUdAySd/nUD3D7/qmdyLuktPj9ZJY=;
        b=d6bMXEGvyaEmNaZ7+ebkiujRO53HPrHsAgzhAWwgXLz3VPUouskTveqPUBAHxyZbVQ
         3UGy/YlI9gq7P2/IkxmdvomymNW95cP4SE7GYhLVxaYwGnrGPz6IRPuji0mYgcYGRago
         QfN3H4UEEOBw3/PWSU9qZLZouXy6FIQ68713h3Qx8uuz/Lsd0+L3mnIyNx9buuVoI7Bz
         xVIrWTdPscS5FN8Sf2uS8SEqVMG9agBn0RPAUoGmpdb/1LGufCpkFwDNmMl4s0BWKyn1
         0k2Cxuzgp/dlf8PZmVCIg1ZcOzr3J1ZBermdcsx2m4QLuJBj5eVkmz7o6fB3uMgKmB8T
         ZAIg==
X-Gm-Message-State: AJIora9teqrNhMH/flri8g8zm6t04K6DbtfFYGZuVpbtZk0cxVou55w+
        NnJcbf6eGAFRWpm1M5/CiDI=
X-Google-Smtp-Source: AGRyM1sybC+066Kqk/UJX5DtXiHoEC6YQ3pnVo6d6UN4LTBOrTUWKozREYAynqVV90hSAQRXUSsAaQ==
X-Received: by 2002:a17:907:3f29:b0:72b:91df:2c4b with SMTP id hq41-20020a1709073f2900b0072b91df2c4bmr39434382ejc.206.1658397887935;
        Thu, 21 Jul 2022 03:04:47 -0700 (PDT)
Received: from felia.fritz.box (200116b826c37500a4adcf8f67474f65.dip.versatel-1u1.de. [2001:16b8:26c3:7500:a4ad:cf8f:6747:4f65])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fe8c000000b0043a554818afsm713684edt.42.2022.07.21.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:04:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm64: adjust KASLR relocation after ARCH_RANDOM removal
Date:   Thu, 21 Jul 2022 12:04:33 +0200
Message-Id: <20220721100433.18286-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aacd149b6238 ("arm64: head: avoid relocating the kernel twice for
KASLR") adds the new file arch/arm64/kernel/pi/kaslr_early.c with a small
code part guarded by '#ifdef CONFIG_ARCH_RANDOM'.

Concurrently, commit 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")
removes the config CONFIG_ARCH_RANDOM and turns all '#ifdef
CONFIG_ARCH_RANDOM' code parts into unconditional code parts, which is
generally safe to do.

Remove a needless ifdef guard after the ARCH_RANDOM removal.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm64/kernel/pi/kaslr_early.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 6c3855e69395..17bff6e399e4 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -94,11 +94,9 @@ asmlinkage u64 kaslr_early_init(void *fdt)
 
 	seed = get_kaslr_seed(fdt);
 	if (!seed) {
-#ifdef CONFIG_ARCH_RANDOM
-		 if (!__early_cpu_has_rndr() ||
-		     !__arm64_rndr((unsigned long *)&seed))
-#endif
-		return 0;
+		if (!__early_cpu_has_rndr() ||
+		    !__arm64_rndr((unsigned long *)&seed))
+			return 0;
 	}
 
 	/*
-- 
2.17.1

