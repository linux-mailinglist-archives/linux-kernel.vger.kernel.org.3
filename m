Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E5A4C23D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiBXGFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiBXGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:05:20 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD490265BD9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:04:50 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so962423pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mj3HBzfCxMXhOa3AdwuiPs6C+ifSmws0Yikq8Vw4w9M=;
        b=d6VVQ0IJ1pqi3mVf1e6P765Hp49k/5tdGy44HE7lsVK2hyOHCcsDfymV0G4YwgIZBD
         nnLFNOPaNlIRaJ183BUAt3lP1TAl3ld77+JNQ907vNwqAx4XZ0AGozeZFI4bqJmNydYI
         qDzqWdzgx07IJKKk1VS7OYuGoE11bsXWg4VXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mj3HBzfCxMXhOa3AdwuiPs6C+ifSmws0Yikq8Vw4w9M=;
        b=pMc/6ZycG5adG/k6JVgNUVjJkw8SR+QMqPpj+1fz4R/3XzfpZctAxR//iMW3QBgE1o
         ZG1VEFf83CNNqsAGGXmGUQZ3m941y41DLqmDtoP0xOnGYOo+AnGyg6si+AgXFhc/GZgr
         pDqsFZQG5/lgwvGaN2eJTEu19Ix/I8UG9n/J2jnlQIBDayCvD8c90i81BPQQR6fQw1HA
         MYksgwNuNr3MLrRawHPKGiGkXj/0rfcjSV0Pcn8MPBRGYV5nXWlIlmxU0aJdR3BPvidp
         DZY5TjkhdqnBWFHhUJKP5vxV72w5fZr35vyulCZ8yBJAbKI5oJBTW7AVAGia79xMZH4I
         A5Qw==
X-Gm-Message-State: AOAM533V0dAC5A1Tcx2bFdAYUUQ5khAb4cB07jmuZY6H6XzT1CJdhJV7
        DIjo5hCI1bAYfoY5RpShRGWwVg==
X-Google-Smtp-Source: ABdhPJzSwlsZzGNXolvZfHflDUUo9DccZuM2oJWXzfDAf6N3M7FEh4wCERvjoOwptGE1QIhYhX1HAA==
X-Received: by 2002:a05:6a00:9a2:b0:4e1:a01d:cc4d with SMTP id u34-20020a056a0009a200b004e1a01dcc4dmr1420009pfg.40.1645682690423;
        Wed, 23 Feb 2022 22:04:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ms7-20020a17090b234700b001bc7e6fc01csm4874730pjb.40.2022.02.23.22.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:04:50 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] m68k: Implement "current_stack_pointer"
Date:   Wed, 23 Feb 2022 22:04:48 -0800
Message-Id: <20220224060448.1856091-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; h=from:subject; bh=aCKF6pah3jKoxmujtCWCgGTUaT8lvMY8K5EJAIOdces=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFyAAN4a59v0whmyyOqnPVE7J+A3PA2EFelV2TkSt rt3/PUOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcgAAAKCRCJcvTf3G3AJl4FEA CjjE6DKptB+L/nzq3CM7Ub5Sm3ZSDxa/x5jgke8td3/7KOI81gaNoJgu4Lh9PKnPxvZl3D1XrnVj0f WCDq7HQJuiDnOl0ETndLFW7dGLRU0xLbbRKSrcyikYLrbPtK9UCxjEhhgG17fnBGg3Ado1c4iHCQvG 9ZfK2UQ2RJIqQuwkRkuwrsV+sfQ/S/jhnECRQZOV9xGoNhRl6foqB4RxxxUDu8zMf8wSqgxalFsi83 HcCzXfyjLhIy+kh/kuyzFsIxXHCHQpbmdjBrxAUc/eKYO33nT/UEk1FV1auoDvg4GeYtn3BBgIEJMo F26Avvi065Hxe96pJAQQ1Y/A50BBElESHuAqR7l69BbCJYQ9/RZNwaBFjMdmf6IbZ4N5WKpc8IGjTF 0lCPqMvgoYASWIet/NYmLLs9fe9ngLse2drV2CzS9BSmOKdktCzFphiK87/6FwN8r3rXip5H89hpym zsv1JMl/p0pEdhFZ4S/n5GpN1nuNeNMqUMrh6uoHWbvC/miSEP2vSz85X08Vxpwshe7No14M/xSBwU 87KOHuDG3Gr7qPfJPoG5esp+lP/hDXPGXc2VInZl705I4ISARVTBKp96U0c3MKNNPX/G6OBHJnowQs 1/bmLjGB4k73Dlm6n1FfF4nnr9h/8IbtBkHFvK8F/2A8MagoYBcdxvgXtdMQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To follow the existing per-arch conventions, add asm "sp" as
"current_stack_pointer". This will let it be used in non-arch places
(like HARDENED_USERCOPY).

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/m68k/Kconfig               | 1 +
 arch/m68k/include/asm/current.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 936e1803c7c7..f0eac0e2f123 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,6 +4,7 @@ config M68K
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
diff --git a/arch/m68k/include/asm/current.h b/arch/m68k/include/asm/current.h
index 6390ef2f7f86..0c87a7047e15 100644
--- a/arch/m68k/include/asm/current.h
+++ b/arch/m68k/include/asm/current.h
@@ -24,6 +24,8 @@ static inline struct task_struct *get_current(void)
 
 #define	current	get_current()
 
+register unsigned long current_stack_pointer __asm__("sp");
+
 #endif /* CONFNIG_MMU */
 
 #endif /* !(_M68K_CURRENT_H) */
-- 
2.30.2

