Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB765B1A44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiIHKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:43:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF9076951;
        Thu,  8 Sep 2022 03:43:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k17so10572068wmr.2;
        Thu, 08 Sep 2022 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s67Ye6wDoYkB1kk6bJRzdsh3rRxMa1cRr67bsMc2dUs=;
        b=AVHpqF5L9S9Rg0dyawFMEMFDJ56WV8tWYx6jWwYeBL2YhGXfPVSBw/OtNPAkx6x0Oj
         9YUBJa8EDIZjghd0wW6YLFFqw9PXO8POL03OQbAvXuLqEHlmxSErMVsjUqIiEnjdBbXy
         jBgJwVve/L3EOWGQ1bO6vO2ciPuLMNXYb+egeD9Inwqdn6Z/7W68eMr1kjy/qL97f09Q
         sesgqE7e/UrH1D7jsk6mtUoLH+IDn5hKV2uV+nsCrCyUrvzUkMfphRTpyo4GlPt7YAuf
         lHKAQkxEDDaXaixZDmsrmSr5gy7REIwLzko/mUn8+sugSJziaGNKsDPdZo3Z6J2kcNnY
         5q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s67Ye6wDoYkB1kk6bJRzdsh3rRxMa1cRr67bsMc2dUs=;
        b=u3iEtc4jkD0HIP15Fbux+rxlkVr6oUMiPf6EEMHJh6kzXHNqJ0vceoNSb3knqKHpEI
         svIzN8Sgg3XecEwwGlfqpmC/l6pZStZlM7ZZcPsKRn2n6Dhg42RvyQKfDf4IXVomAmG3
         P4EwxtFCQIAqAzmv6vSVl9E043hGnjT2pnYFKv7ht6pkkw6VGzuxXnbh4XRX1rTM4oNQ
         Uj7bRLHdKLGFS5xgEXiuXJMWJgfyA2pY45RGIvkVfbFaiT2QPslwogAKLSOj9EKigDgO
         risBNA0KykMS3KBagWpXY3Bdq9TcF5ChuyZo0Hjl9Pm2H9lTvU7rqM5xQWn1FmjjDkh6
         KXWA==
X-Gm-Message-State: ACgBeo0WOz6+l4Z8zlWAhM/Byw8r8p+d28ibmb+ZWKqZKGbLHEg+8iFg
        OUNAWYdSgvTgFJDGtk7avIQ=
X-Google-Smtp-Source: AA6agR66kMztJ719W/lSRghqI54eoFp7/i7XmP4c9ZKnwWZ3SgVLwjTcfclP30ct9oVGD3Q6aPtKDA==
X-Received: by 2002:a05:600c:4e45:b0:3a5:f383:b917 with SMTP id e5-20020a05600c4e4500b003a5f383b917mr1780608wmq.61.1662633824976;
        Thu, 08 Sep 2022 03:43:44 -0700 (PDT)
Received: from felia.fritz.box (200116b826f77600d0640cc051af4288.dip.versatel-1u1.de. [2001:16b8:26f7:7600:d064:cc0:51af:4288])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0022863395912sm17227486wrb.53.2022.09.08.03.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:43:44 -0700 (PDT)
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
Subject: [PATCH 0/6] Remove CONFIG_EMBEDDED
Date:   Thu,  8 Sep 2022 12:43:31 +0200
Message-Id: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,


While attempting to configure the kernel build, I encountered the option
CONFIG_EMBEDDED and I wondered what this option was all about:

config EMBEDDED
	bool "Embedded system"
	select EXPERT
	help
	  This option should be enabled if compiling the kernel for
	  an embedded system so certain expert options are available
	  for configuration.

In the end, I hopefully understood its history, evolution and all the
consequences, but I concluded that there is no point for anyone else in the
future to try to untangle the riddle behind this option, as I did in the
last few hours. It is much easier to just remove this whole riddle from the
kernel build configuration.

The story all starts with commit 6a108a14fa35 ("kconfig: rename
CONFIG_EMBEDDED to CONFIG_EXPERT").

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


In summary, in the last decade, CONFIG_EMBEDDED never lived up to its
intended purpose defined above. Let us delete this config and live happily
ever after. It is needless to say that the kernel build configuration is
still highly complex, removing one needless bit of complexity might not
make a big difference, but let us get one bit of complexity out of the way
for good.

Patches 1 to 4 make the additional config options, that are visible with
CONFIG_EMBEDDED, visible with CONFIG_EXPERT instead.

Patch 5 makes secretmem configurable and visible with CONFIG_EXPERT.

Patch 6 finally removes the CONFIG_EMBEDDED, as it not used anymore
throughout the tree.

I am happy to get some feedback on this patch series.


For these minor changes in a few subsystems, I would hope that:

  Patch "arm: make config ARM_PATCH_PHYS_VIRT visible with EXPERT"
    is picked by arm architecture maintainer Russell King.

  Patch "x86: make config X86_FEATURE_NAMES visible with EXPERT"
    is picked by x86 architecture maintainers.

  Patch "media: remove reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER"
    is picked by media maintainer Mauro Carvalho Chehab.

  Patch "usb: chipidea: make configs for glue drivers visible with EXPERT"
    is picked by Peter Chen or usb maintainer Greg Kroah-Hartman.

  Patch "mm: Kconfig: make config SECRETMEM visible with EXPERT"
    is acked by Mike Rapoport, and
    is picked by mm maintainer Andrew Morton.

Once all of these patches above have been merged to mainline:

  Patch "init/Kconfig: remove confusing config EMBEDDED"
    can probably just be picked by the kbuild maintainer Masahiro


Best regards,

Lukas


Lukas Bulwahn (6):
  arm: make config ARM_PATCH_PHYS_VIRT visible with EXPERT
  x86: make config X86_FEATURE_NAMES visible with EXPERT
  media: remove reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER
  usb: chipidea: make configs for glue drivers visible with EXPERT
  mm: Kconfig: make config SECRETMEM visible with EXPERT
  init/Kconfig: remove confusing config EMBEDDED

 arch/arm/Kconfig             |  2 +-
 arch/x86/Kconfig             |  2 +-
 drivers/media/Kconfig        |  2 +-
 drivers/usb/chipidea/Kconfig | 10 +++++-----
 init/Kconfig                 |  8 --------
 mm/Kconfig                   |  8 +++++++-
 6 files changed, 15 insertions(+), 17 deletions(-)

-- 
2.17.1

