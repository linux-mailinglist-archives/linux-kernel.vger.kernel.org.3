Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A14D4FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbiCJRKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiCJRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:10:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6915C194
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:09:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id s11so5632653pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=9vsxDLv0jRYrdMWCdK+DvGUDoE+ZiEKYs1dLFeqWbTY=;
        b=E4BgBkJ+Xq4T2ddFS5W7BfSpnvoEsJJgEbqQef7Yz2rjMCUEx+9alT20ZbC1rEb5oG
         JduZegrQo51xuIG9Wun90nbMjAe4Kn+rTq63gKtbGdUA1oJF2fTgQygIQ7a+xHmQYcp3
         tAuJOoQNKvuQHvR5y24LzV3AQawgUieAiAvEiar4r+dkwSVtEKVHIDecem1aIftRqrVt
         1MJ9eABNl8N+ADd8QmEy4KCj5+ZZwupUvhbRh5ks6abaD65Xxvl/md65Sao4OShh9ihh
         prBEsm6wEV5SSpbiRoUoARtmFfSy3e3D0YTBBepuQVX5Ph36/8eyH69OooluxSbheTIq
         Qh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=9vsxDLv0jRYrdMWCdK+DvGUDoE+ZiEKYs1dLFeqWbTY=;
        b=S+WRIITU6mbSZSPKfNNo78ZJ2rf/Nja7PEiuroMgRU0iV1bT4g75bjnkQtpQ6TBnRs
         vnhnDYUKxZjIEXX3yAXXNOTfXKLR0/MQpR5nATlBhaC+Cly8KYpMKQEcSMNWBWgs14KF
         oNzqQ+J1+62VSK+C7WbHbHhL5cCpWAN8Xx4j6BuXJ+SM4TDF0zd3Z1LKRLk3SDO9XCWw
         yedWuyKR/fWWzubVz5vUFO0mCUjIO29OtjBTKFivzIbM+AGSqLNraaDw4vmg0wR3+OHV
         Bx+Xqz1yOPwWpW2P4x+dZZXCN2vVtZ5BIba0WvZsvs20ubDaZejYLti9IJIvKVLmTlhZ
         3qXg==
X-Gm-Message-State: AOAM531Xdyhl1RL1EOStw9ZnuzFQIoJTMvOq6bP8o6V3IgIFjJRAwDbW
        wndNx8xCQQuxRqY73ysXLc8IXw==
X-Google-Smtp-Source: ABdhPJxnz9epEpZ/4W/EkXe8NMBZnqltyihGTRilS5fQnFLc6+e4CXAYBKGHy5Viezd+couNh+TERQ==
X-Received: by 2002:a63:121e:0:b0:380:8c48:e043 with SMTP id h30-20020a63121e000000b003808c48e043mr4837588pgl.356.1646932176183;
        Thu, 10 Mar 2022 09:09:36 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id z11-20020a056a001d8b00b004f74f8268cbsm6372992pfw.85.2022.03.10.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:09:35 -0800 (PST)
Subject: [PATCH] RISC-V: Add CONFIG_{NON,}PORTABLE
Date:   Thu, 10 Mar 2022 09:08:45 -0800
Message-Id: <20220310170845.17614-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The RISC-V port has collected a handful of options that are
fundamentally non-portable.  To prevent users from shooting themselves
in the foot, hide them all behind a config entry that explicitly calls
out that non-portable binaries may be produced.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---
This came up in the context of the no-M patch:
https://lore.kernel.org/lkml/CAK8P3a3mzax-OiaxBcxM_RgKNsd6N8HW0odRmw38u2jKE5aYaQ@mail.gmail.com/

I'm not sure I strictly need both PORTABLE and NONPORTABLE, but it's the
only way I could come up with to force things like EFI.  I'll poke
around Kconfig a bit more, but I figured this is going to lead to a
discussion so it'd be better to just send this crusty version so we at
least have something concrete to talk about.

I've only given this a smoke test (ie, defconfig looks OK).  I'll go
through all the configs if folks think this is the right way to go -- I
figure it's better to have the discussion on a more focused patch than
on that M patch, as this is really an orthogonal issue.

I'm not really sure what the right option is here: I'm not selecting
things like errata and basic drivers, but I could buy the argument that
disabling those results in non-portable systems.  I am selecting EFI,
that might not be strictly required now but it's the direction we're
going so I figure we might as well start now.  I've also hidden 32BIT
behind this, I could see that going either way but my guess is that
users of 32-bit systems won't care about portable binaries.  I'm also
not sure if this should be tied to something like EMBEDDED or EXPERT.

My biggest worry with this is that users might get the feeling that
current kernels will be compatible with new hardware, that's just not
how RISC-V works.  I tried to write the help text indicating that, I'm
not sure I like how it reads so I'll almost certainly take another shot
at it (though suggestions are, of course, welcome).

I'm also a bit worried that vendors might get the feeling we're not
going to support systems that need modifications to these portablity
requirements.  That's also not the case, as there's really no way for
vendors to make sure their systems continue to run portable kernels
aside from just releasing them publicly so we can test them.
---
 arch/riscv/Kconfig | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..de0916d7aca7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -9,6 +9,7 @@ config 64BIT
 
 config 32BIT
 	bool
+	depends on NONPORTABLE
 
 config RISCV
 	def_bool y
@@ -485,6 +486,7 @@ config STACKPROTECTOR_PER_TASK
 
 config PHYS_RAM_BASE_FIXED
 	bool "Explicitly specified physical RAM address"
+	depends on NONPORTABLE
 	default n
 
 config PHYS_RAM_BASE
@@ -498,7 +500,7 @@ config PHYS_RAM_BASE
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on MMU && SPARSEMEM
+	depends on MMU && SPARSEMEM && NONPORTABLE
 	# This prevents XIP from being enabled by all{yes,mod}config, which
 	# fail to build since XIP doesn't support large kernels.
 	depends on !COMPILE_TEST
@@ -538,9 +540,31 @@ endmenu
 
 config BUILTIN_DTB
 	bool
-	depends on OF
+	depends on OF && NONPORTABLE
 	default y if XIP_KERNEL
 
+config NONPORTABLE
+	bool "Allow configurations that result in non-portable kernels"
+	help
+	  RISC-V kernel binaries are compatibile between all known systems
+	  whenever possible, but there are some use cases that can only be
+	  satisfied by configurations that result in kernel binaries that are
+	  not portable between systems.
+
+	  Selecting N does not guarntee kernels will be portable to all knows
+	  systems.  Selecting any of the options guarded by NONPORTABLE will
+	  result in kernel binaries that are unlikely to be portable between
+	  systems.
+
+	  If unsure, say N.
+
+config PORTABLE
+	bool
+	default !NONPORTABLE
+	select EFI
+	select OF
+	select MMU
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
-- 
2.34.1

