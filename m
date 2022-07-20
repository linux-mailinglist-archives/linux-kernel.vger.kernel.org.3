Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0330B57B525
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiGTLOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:14:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E557E16;
        Wed, 20 Jul 2022 04:14:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y8so23331625eda.3;
        Wed, 20 Jul 2022 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=6fuIJMKJDv+3Plx8Fx6qWnLCEEoGbGCg+Qja+GkKCJs=;
        b=iJ4ni6ck1e+u/ktiSbJ7gEAgoLM8tAChQrEnqcBJeleznKeWqEzrZTCZUE6VAlIrk7
         qwJWGzApoK9GCJxqBA3DcubTZQ7zURgO0IJ6mwtY38/NLQadIRNh+gfy2UavYq7LDs6S
         T0r/QB3FRbbJqGxbbJzg28u8Www4gvPzTZR7fDAV418ZrNTH9k0UWD6qy5Oc8H2NexmR
         JA+GL5JaVE/RiioqKRdrghKojOokzXRIe1jVI6oZSv/qs/sdq3Rq14jCm2h28YnXI0PY
         sSI35ltFfWxd7slljLcqzBucpUnKL9XyJ8NZwmEMHNtH1u8/lDPH8j5PiBM0uR2MDNZw
         nzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6fuIJMKJDv+3Plx8Fx6qWnLCEEoGbGCg+Qja+GkKCJs=;
        b=tE+vZ7B9kI6eJvc1Za+7/yHkhGL2qCsm1MKUmJtvUiajTgIr7R6B4N4ho4cIPY2YWP
         3i0hDzjiG0DI9VlzXcV1+92sfp6JI45dWuBny/BKxVtDNckNDRKJ7PEjGIoUmyycgULu
         PuRZ61RO7F3yvYylX6RTTIG2ZWCF2uw61MWNRSIKqg2FEnO54U3tPvNhZRfYLnbSfPTA
         zypkphUwLCbfs6j3w8s2d5HpEA6fDbtPtoMHJNnwFNmngJbXT/Q5KNNChNYWosrxCc6g
         /0/9fUYZh9byNIe7XFcUsOE1p6RJnGRrch0Rv2Q/qYAawB22fOJ/2NseLWuurHl/9nnS
         Hvzw==
X-Gm-Message-State: AJIora/MyHO/KEM7YruuyIDoe+s9wnEm3mFuS/AD2ECcRvmOFFukWL2z
        LBm4YU7vAvTXfN9Xq7Phyc41yCZ7XCc=
X-Google-Smtp-Source: AGRyM1vtLTuhIh6tetw/IB/3DS6kCwS8iCfJGBlL9PAjDfMyOuDeQWHqeMPTFa8n8l0VgTAeOj6AOg==
X-Received: by 2002:a05:6402:2281:b0:43b:5d77:12d9 with SMTP id cw1-20020a056402228100b0043b5d7712d9mr22457228edb.295.1658315684096;
        Wed, 20 Jul 2022 04:14:44 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id ec21-20020a0564020d5500b0043ba24a26casm2095165edb.23.2022.07.20.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 04:14:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: davinci: remove CPU type detection for DaVinci DM644x and DM646x
Date:   Wed, 20 Jul 2022 13:14:32 +0200
Message-Id: <20220720111432.18321-1-lukas.bulwahn@gmail.com>
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

Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
support for DaVinci DM644x and DM646x boards.

Hence, remove the CPU type detection for those boards as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-davinci/cputype.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/mach-davinci/cputype.h b/arch/arm/mach-davinci/cputype.h
index 4590afdbe449..4cba566371d6 100644
--- a/arch/arm/mach-davinci/cputype.h
+++ b/arch/arm/mach-davinci/cputype.h
@@ -25,8 +25,6 @@ struct davinci_id {
 };
 
 /* Can use lower 16 bits of cpu id  for a variant when required */
-#define	DAVINCI_CPU_ID_DM6446		0x64460000
-#define	DAVINCI_CPU_ID_DM6467		0x64670000
 #define	DAVINCI_CPU_ID_DM355		0x03550000
 #define	DAVINCI_CPU_ID_DM365		0x03650000
 #define	DAVINCI_CPU_ID_DA830		0x08300000
@@ -38,25 +36,11 @@ static inline int is_davinci_ ##type(void)				\
 	return (davinci_soc_info.cpu_id == (id));			\
 }
 
-IS_DAVINCI_CPU(dm644x, DAVINCI_CPU_ID_DM6446)
-IS_DAVINCI_CPU(dm646x, DAVINCI_CPU_ID_DM6467)
 IS_DAVINCI_CPU(dm355, DAVINCI_CPU_ID_DM355)
 IS_DAVINCI_CPU(dm365, DAVINCI_CPU_ID_DM365)
 IS_DAVINCI_CPU(da830, DAVINCI_CPU_ID_DA830)
 IS_DAVINCI_CPU(da850, DAVINCI_CPU_ID_DA850)
 
-#ifdef CONFIG_ARCH_DAVINCI_DM644x
-#define cpu_is_davinci_dm644x() is_davinci_dm644x()
-#else
-#define cpu_is_davinci_dm644x() 0
-#endif
-
-#ifdef CONFIG_ARCH_DAVINCI_DM646x
-#define cpu_is_davinci_dm646x() is_davinci_dm646x()
-#else
-#define cpu_is_davinci_dm646x() 0
-#endif
-
 #ifdef CONFIG_ARCH_DAVINCI_DM355
 #define cpu_is_davinci_dm355() is_davinci_dm355()
 #else
-- 
2.17.1

