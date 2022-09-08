Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95D45B1A49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiIHKoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiIHKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:43:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F85E9D8ED;
        Thu,  8 Sep 2022 03:43:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 186-20020a1c02c3000000b003b26feb5c6bso1352196wmc.5;
        Thu, 08 Sep 2022 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=YcRQWeHsNHudXowYxhzrFSu3g61QameARaQdQJb5lU8=;
        b=g3G7qs40MLQJX14/onOdc/vwEuCiGg3qlXRS98ERCemYZhBI59bvkmMyGLr09yHXS/
         yFosfFbqEKXH3p/CfgCOl/rnQhKEtFaDJTjdwAl2E9NoJNZ8YIVubxdleDB/f0g4+3oo
         JIeGMlGuo3uFUW4fDwCEy9M1RHT2k/t4jVo48Ln/eFseeN1oVe9bh0vMtHB5XTVOMXlQ
         BfukHii/KG8jzkRD5yeoihVnAl+O4D3cCY+SL/5O/X6oM9T0JNIC31tvygvv5sDkdBMp
         C81T8fKmjXFOmCxs6csbtglXCTBnAX8JxPtOwKgLbEgviTauwuYqLNDYQ4p+gnFdpP+i
         HV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YcRQWeHsNHudXowYxhzrFSu3g61QameARaQdQJb5lU8=;
        b=bLws0u7gqf5mdU/P7joaZoL+Tc8iE2IyPybnfHndtMVDtAGKDG02GrhQXwqwZhYS3l
         ybzhxp2oxNYDCDKKCzNwlUDcAxAZF0GvOy+1OOQ1gF6sDkGc5X8FxHkGGcLQmsIV63qc
         KOzQ+PPdpFLvHsFtcoYut2AZe/pDxL+mIan75rSxHGm/bA65x3VJrGxk9bhD2ilTDL+k
         hRU7b61Dz+513VLqtbuYVqJPUjOKiXL7fexDBLQx5pIEC9xq0Q3S2ohNcDsXqT5UMjRn
         OjPDeBRLbL76iVNQ/gM0MHSoezU5qmvXHRWsfdil+jYakONWGcJYruXVbXTrF/E/xpfa
         tPOg==
X-Gm-Message-State: ACgBeo1uV2URTjeEcRe9aP1ptyXX75t9/P9131Nqdtj18p+pXDvZryvv
        tti0TXq8xcjn+5YUzh9W0Sk=
X-Google-Smtp-Source: AA6agR6ynOlAaxihPYz+CdT04VP+VpGksNMzS5VFetSq0N8fvehilNxf41zef99BhDZbNdGwjrNtVg==
X-Received: by 2002:a05:600c:4f10:b0:3a5:f8c8:a5b5 with SMTP id l16-20020a05600c4f1000b003a5f8c8a5b5mr1835323wmq.34.1662633830474;
        Thu, 08 Sep 2022 03:43:50 -0700 (PDT)
Received: from felia.fritz.box (200116b826f77600d0640cc051af4288.dip.versatel-1u1.de. [2001:16b8:26f7:7600:d064:cc0:51af:4288])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0022863395912sm17227486wrb.53.2022.09.08.03.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:43:50 -0700 (PDT)
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
Subject: [PATCH 2/6] x86: make config X86_FEATURE_NAMES visible with EXPERT
Date:   Thu,  8 Sep 2022 12:43:33 +0200
Message-Id: <20220908104337.11940-3-lukas.bulwahn@gmail.com>
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

Make the config X86_FEATURE_NAMES visible when CONFIG_EXPERT is enabled.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2ec0b1eabe86..7807eb1c8df8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -438,7 +438,7 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config X86_FEATURE_NAMES
-	bool "Processor feature human-readable names" if EMBEDDED
+	bool "Processor feature human-readable names" if EXPERT
 	default y
 	help
 	  This option compiles in a table of x86 feature bits and corresponding
-- 
2.17.1

