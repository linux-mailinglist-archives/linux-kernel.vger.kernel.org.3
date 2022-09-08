Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64FF5B1A63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiIHKoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiIHKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:44:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5044BB90E;
        Thu,  8 Sep 2022 03:43:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k17so10572338wmr.2;
        Thu, 08 Sep 2022 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=RDfo3bMr+JPT0XwUqpEkdXAA/w6q2WGGKmvqZnqv+TQ=;
        b=Fw4IKH8ap4pumBI12Nq1Lfh9UtKeAcIDpwe+b1cX00pCYnpLbbi+7TinfG2yAn37L8
         04V+5lVNVeT7IoxTbICeOOJhv1i6FAQCJB08146+bhoKQNtIDt3xvNsvk6HTXCBqHFM3
         N6LDDtIOq8qwPGklXmHEsyu6FkeprRxH3Exu5bKLnJaqtWALAamiEythWkn8NzQQ+8NC
         txG9S13vwDKVmWy390YKikVWb8EjCqwWoURsQoLOsRXaO5r05Xy2D3/TxKFA1vhOwV5l
         k/pfHLouALbI5XPTSW97BlFXSnjAB6iK1gfU5LBfKvbTddVEbjqCmqVKQqCV+KQvE2Gq
         knlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RDfo3bMr+JPT0XwUqpEkdXAA/w6q2WGGKmvqZnqv+TQ=;
        b=l4s46F7h9gmZxnGSKEZoOkCDPTH0/41fNpaqRWrhEUbNxS+xqBe+1lmlZ79Urqic71
         F6+vFiNqrtR+tNBP3D8iPv7irPW0mIjoo+PInKuq9CXItdYnGRqgVJCb/MAYI7m6MRpK
         iu2M82UWksAMmnyHpBtCtPu+PpjQewWHr+kugZmBOMiVOzL6tBxR7CIgrZWDeqS/dDOY
         /fu0xiIifnm8ZpMwrOc9cjSc2azfAwI+mMCG4xr7gPinFMifVsPKXnEu+Jx1MOQ94NhJ
         De8gZQGWYoGok6d0Z7QBj8GLnwgibsBHEJBxzQ/jyo1fBz7ALz0GdfZCet4nhUW+d6Ql
         aIJQ==
X-Gm-Message-State: ACgBeo3FeyBNoQXNnlZa6pYTWwJRo0E65uc65TCrtsrXMy1YVFgNBo3F
        GQg+JR2GeiIVqGoQmM59E+U=
X-Google-Smtp-Source: AA6agR6LWwrUGGfoOSbVk9oxNX8imZLStpZ8izPiLHM9p+m8rli2GQHNjyDS5uL1kEKQueemyub1Qg==
X-Received: by 2002:a1c:6a0a:0:b0:3a5:bcad:f2cc with SMTP id f10-20020a1c6a0a000000b003a5bcadf2ccmr1823007wmc.74.1662633836389;
        Thu, 08 Sep 2022 03:43:56 -0700 (PDT)
Received: from felia.fritz.box (200116b826f77600d0640cc051af4288.dip.versatel-1u1.de. [2001:16b8:26f7:7600:d064:cc0:51af:4288])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0022863395912sm17227486wrb.53.2022.09.08.03.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:43:56 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 5/6] mm: Kconfig: make config SECRETMEM visible with EXPERT
Date:   Thu,  8 Sep 2022 12:43:36 +0200
Message-Id: <20220908104337.11940-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
and just gives that intent a much better name. That has been clearly a good
and long overdue renaming, and it is clearly an improvement to the kernel
build configuration that has shown to help managing the kernel build
configuration in the last decade.

However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
open for future contributors to implement that intended semantics:

    A new CONFIG_EMBEDDED option is added that automatically selects
    CONFIG_EXPERT when enabled and can be used in the future to isolate
    options that should only be considered for embedded systems (RISC
    architectures, SLOB, etc).

Since then, this CONFIG_EMBEDDED implicitly had two purposes:

  - It can make even more options visible beyond what CONFIG_EXPERT makes
    visible. In other words, it may introduce another level of enabling the
    visibility of configuration options: always visible, visible with
    CONFIG_EXPERT and visible with CONFIG_EMBEDDED.

  - Set certain default values of some configurations differently,
    following the assumption that configuring a kernel build for an
    embedded system generally starts with a different set of default values
    compared to kernel builds for all other kind of systems.

Considering the second purpose, note that already probably arguing that a
kernel build for an embedded system would choose some values differently is
already tricky: the set of embedded systems with Linux kernels is already
quite diverse. Many embedded system have powerful CPUs and it would not be
clear that all embedded systems just optimize towards one specific aspect,
e.g., a smaller kernel image size. So, it is unclear if starting with "one
set of default configuration" that is induced by CONFIG_EMBEDDED is a good
offer for developers configuring their kernels.

Also, the differences of needed user-space features in an embedded system
compared to a non-embedded system are probably difficult or even impossible
to name in some generic way.

So it is not surprising that in the last decade hardly anyone has
contributed changes to make something default differently in case of
CONFIG_EMBEDDED=y.

Currently, in v6.0-rc4, SECRETMEM is the only config switched off if
CONFIG_EMBEDDED=y.

As long as that is actually the only option that currently is selected or
deselected, it is better to just make SECRETMEM configurable at build time
by experts using menuconfig instead.

Make SECRETMEM configurable when EXPERT is set and otherwise default to
yes. Further, SECRETMEM needs ARCH_HAS_SET_DIRECT_MAP.

This allows us to remove CONFIG_EMBEDDED in the close future.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 mm/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ceec438c0741..aa154c20b129 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1068,7 +1068,13 @@ config IO_MAPPING
 	bool
 
 config SECRETMEM
-	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
+	default y
+	bool "Enable memfd_secret() system call" if EXPERT
+	depends on ARCH_HAS_SET_DIRECT_MAP
+	help
+	  Enable the memfd_secret() system call with the ability to create
+	  memory areas visible only in the context of the owning process and
+	  not mapped to other processes and other kernel page tables.
 
 config ANON_VMA_NAME
 	bool "Anonymous VMA name support"
-- 
2.17.1

