Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F785B1A64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIHKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIHKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:44:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE4CE1272;
        Thu,  8 Sep 2022 03:44:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t14so18053922wrx.8;
        Thu, 08 Sep 2022 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=ItPI0MR3NN2HvuVuI/7ScAvDP5QuDEGNBgMAv6on+2k=;
        b=Qwl9qXCtUZAEXBRAr7K21sULv09wLNrYWhe7Tqgxdgq8iCs2UNVpXTmHLSihAYrMFB
         xqPp1w6KiUfXyae1qXE7yYG9/WlBAVSqzQfBQppoR0nPN8/NZV1q0qC81qPEpT25B8j9
         lv7K1Tpd3eqjlYr9uZR05QBI+Ee4WyqYEiDi9gEeYKP1NfX30ewVC9KM6uc+aeFNKGAU
         Vhb4Z4anKzyJmunTqHDt5RrnC6twaekPXm8GT/lUid5tNmlUGLYLN5l7IWiShbEWuYJt
         7sMZoOZOaRVd/OzmXh+IhauAAXAbWstN4pdCv0Z2S02OqUX22yUA5TSbAYhrseEmfD1z
         jEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ItPI0MR3NN2HvuVuI/7ScAvDP5QuDEGNBgMAv6on+2k=;
        b=WrDMYHZPbZQpVzRumXYHgVqarESs3HXnEMn1rKthqMJwFiM/LpT6s/yzeOvMuVdMm+
         mraf4r6mYlVRSvN0DszBQGuXqChTU3SZR9e18DDp74w6aZFdVQkqMryRcpR/5770u0a+
         xJOz/+81GwVVep9WUPBY4GtRgNMj0uofOqOhW5x41bLKnb1oTD/UyHZijhvx3bXAgWD3
         Zw742b2ujLYthBDClxJB75PCsCEX2Ap74lJAmrjgOQ9VZLhRkwRfokFeu/UDoAOZCK7I
         Svoy2I6H7HaNhsGhHRZPt1C8F5QgH//rkeRFpYvh1rr9gB7RNkrzFZeYk0+qNrZHZC9h
         K5sw==
X-Gm-Message-State: ACgBeo1kxTzyj2aRf8raxcFw/2lnGIA4maPCt/Bm8rkKCzOnkFfw0rH8
        ojfzxeBfg3VISLUww6aUMSQ=
X-Google-Smtp-Source: AA6agR6RYLcqVQoPCUZV9g02cRKPZpdef5LX5qakouTpz1Mv2m826gHTOyz4Ytc64G6rdcluoww9GA==
X-Received: by 2002:adf:ee89:0:b0:228:7bdf:47d with SMTP id b9-20020adfee89000000b002287bdf047dmr4535843wro.641.1662633838474;
        Thu, 08 Sep 2022 03:43:58 -0700 (PDT)
Received: from felia.fritz.box (200116b826f77600d0640cc051af4288.dip.versatel-1u1.de. [2001:16b8:26f7:7600:d064:cc0:51af:4288])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0022863395912sm17227486wrb.53.2022.09.08.03.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:43:58 -0700 (PDT)
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
Subject: [PATCH 6/6] init/Kconfig: remove confusing config EMBEDDED
Date:   Thu,  8 Sep 2022 12:43:37 +0200
Message-Id: <20220908104337.11940-7-lukas.bulwahn@gmail.com>
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

Hence, all uses of CONFIG_EMBEDDED have been replaced with CONFIG_EXPERT.

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

In v6.0-rc4, SECRETMEM is the only config switched off if
CONFIG_EMBEDDED=y. That one use was removed as well, SECRETMEM was made
configurable at build time by experts using menuconfig instead.

As there are no further uses of CONFIG_EMBEDDED and CONFIG_EMBEDDED never
lived up to its intended purpose defined above, simply delete this
confusing CONFIG_EMBEDDED.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 init/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e3fd79b089c..d7429e0b8cae 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1818,14 +1818,6 @@ config DEBUG_RSEQ
 
 	  If unsure, say N.
 
-config EMBEDDED
-	bool "Embedded system"
-	select EXPERT
-	help
-	  This option should be enabled if compiling the kernel for
-	  an embedded system so certain expert options are available
-	  for configuration.
-
 config HAVE_PERF_EVENTS
 	bool
 	help
-- 
2.17.1

