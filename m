Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B55B1A45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiIHKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:43:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1603057564;
        Thu,  8 Sep 2022 03:43:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d2so8240493wrn.1;
        Thu, 08 Sep 2022 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=d6JtqoCpIIPzVyif4k/dv5ZYkBUB6IfePKT1atMhkrE=;
        b=i3YpqGHjfIghBE7B2AHHQSQ4CJg/w9Q1NAB/0hUwSMbJLeYwitavOc7Mb+MAeQNKBm
         2kLB4pR34kNxJx04iAUi4R72t7ogR1J3b2ZJtDSlMI1nwWhlUECD6R73dW4OKtOUpH7Q
         kfh6AvXcJtT0l0AdZnH9USMQliFfCMRy3NJjMqmk9aCu0LUoFuwPTKk9rE8GoO49Q/rb
         +jYvwL9qWMI2k639dY+EjsJBXPTM1XWb2+1cK0V1ZJXB+haJbpCsoCUyWIyK3FIVu+z7
         Qri6B1mZPVZhGwyySj+zRJ6fg0wc6vVKrWLLAEoufmf5qxHTK2NMqCtSSsICNMEqqFqs
         QIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d6JtqoCpIIPzVyif4k/dv5ZYkBUB6IfePKT1atMhkrE=;
        b=ho6Q9Qg2IeyEinU3EMB1v5Xu02sPXzjgdNn76phPhO/yIlslLnlNd12J3j+HKaYZMT
         WhEZIRCDYhJgRkdVLe7A6nNN0FEbl+2jSp6CGxqM42GyeCjkFlf0kgzz6KDDiP6QW1aR
         BMLeSLK3sMzJMrplR/xqOaIAy5+smpX5WKDOGKZMaaRCScaRsP2CqtsYhNqNdr+MYrrM
         WJ2i0QUfasXd+VjTOf2ZA8wGNqSs0jHCsoPd1XBYfoKEi+oDKNNZm7dCKZpe0ZDa6PlZ
         uHKCmGl/KTy01bzIG8JZzhDQixvHSAfOv9E+ZmzYej88Ppn1o6oSyxVu50Dg3dGw28Zi
         saIQ==
X-Gm-Message-State: ACgBeo0D1ZImliZlpGqOK7lk19VjW/rdWgU/k+Ji/nJx5UtMj8kAb+yj
        9DB+3Utmyw+TM8dObv0tDsQ=
X-Google-Smtp-Source: AA6agR6kNO8n/M43thHg/IOEsLk/5DZrRuHF8/F0z7hpV+F/66eCJ2OY4AXF/hVn+/595I7QcY/wwQ==
X-Received: by 2002:a5d:6f14:0:b0:228:e3c6:fa2 with SMTP id ay20-20020a5d6f14000000b00228e3c60fa2mr4194339wrb.516.1662633828524;
        Thu, 08 Sep 2022 03:43:48 -0700 (PDT)
Received: from felia.fritz.box (200116b826f77600d0640cc051af4288.dip.versatel-1u1.de. [2001:16b8:26f7:7600:d064:cc0:51af:4288])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0022863395912sm17227486wrb.53.2022.09.08.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:43:48 -0700 (PDT)
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
Subject: [PATCH 1/6] arm: make config ARM_PATCH_PHYS_VIRT visible with EXPERT
Date:   Thu,  8 Sep 2022 12:43:32 +0200
Message-Id: <20220908104337.11940-2-lukas.bulwahn@gmail.com>
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

Considering the first purpose, at the point in time where CONFIG_EMBEDDED
was renamed to CONFIG_EXPERT, CONFIG_EXPERT already made 130 more options
become visible throughout all different menus for the kernel configuration.
Over the last decade, this has gradually increased, so that currently, with
CONFIG_EXPERT, roughly 170 more options become visible throughout all
different menus for the kernel configuration. In comparison, currently with
CONFIG_EMBEDDED enabled, just seven more options are visible, one in x86,
one in arm, and five for the ChipIdea Highspeed Dual Role Controller.

As the numbers suggest, these two levels of enabling the visibility of even
more configuration options---beyond what CONFIG_EXPERT enables---never
evolved to a good solution in the last decade. In other words, this
additional level of visibility of configuration option with CONFIG_EMBEDDED
compared to CONFIG_EXPERT has since its introduction never become really
valuable. It requires quite some investigation to actually understand what
is additionally visible and it does not differ significantly in complexity
compared to just enabling CONFIG_EXPERT. This CONFIG_EMBEDDED---or any
other config to show more detailed options beyond CONFIG_EXPERT---is
unlikely to be valuable unless somebody puts significant effort in
identifying how such visibility options can be properly split and creating
clear criteria, when some config option is visible with CONFIG_EXPERT and
when some config option is visible only with some further option enabled
beyond CONFIG_EXPERT, such as CONFIG_EMBEDDED attempted to do. For now, it
is much more reasonable to simply make those additional seven options that
visible with CONFIG_EMBEDDED, visible with CONFIG_EXPERT, and then remove
CONFIG_EMBEDDED. If anyone spends significant effort in structuring the
visibility of config options, they may re-introduce suitable new config
options simply as they see fit.

Make the config ARM_PATCH_PHYS_VIRT visible when CONFIG_EXPERT is enabled.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4adfa5dd3556..4b212ab1b281 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -243,7 +243,7 @@ config ARCH_MTD_XIP
 	bool
 
 config ARM_PATCH_PHYS_VIRT
-	bool "Patch physical to virtual translations at runtime" if EMBEDDED
+	bool "Patch physical to virtual translations at runtime" if EXPERT
 	default y
 	depends on !XIP_KERNEL && MMU
 	help
-- 
2.17.1

