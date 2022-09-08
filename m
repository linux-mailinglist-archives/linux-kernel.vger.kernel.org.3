Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74445B1A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiIHKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiIHKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:44:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F01901B9;
        Thu,  8 Sep 2022 03:43:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so20317382wrm.10;
        Thu, 08 Sep 2022 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=DAvW/j/5PxDjN0idhO6jbr+d99JWnLewou5/uVrgjpw=;
        b=BjftNcUlKNzBBVcZwF15+1/SUUs6ojyiGx+bmwJqOwI5zKTtIVhoNVvdW8TIaVaAps
         aFmzTJUK0Ef6cg7zBmV6LX/dGZoPVKPVveNp1rNUaW++nGkfDSyUmRTu68aOk96Ga0kb
         fSRCjPZQ3DYljHvB7IJp1AYr6FdAu44RzyJZFwdMk6cECanW5F4IsNN8672rXQmOhGgT
         w5Q43+vhG98S2dBXQrlNbW2OC34mTsABkWOS4wxUoD2d1eAAAGk1Qotds/77Bze+3n9P
         EXcygbRWdDU5R1rHXmu76wKLlz4ntHJmGuu2+SKMsGn0qkR8sbyLSpyCEz6H6QMxjmAq
         pTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DAvW/j/5PxDjN0idhO6jbr+d99JWnLewou5/uVrgjpw=;
        b=z2en7F8eCx7xUmmrP3FKhd51vbRcFayAo7F/LBSAFgjXx25ma5NFWgY6GQCd4imf6J
         GojwT0ktSmwdBEHvgU2cz6AuhCrp/ylhL9pGtm8W5pSZLruSJvNcjWaUJgALy90H+VqM
         /zy5C0aQ6JKrmdur5Yax3yr8EdTkzbB/0v8tK+/rgKwxTrf8tX+3LIU8ofh90YmElpEK
         pTrFs36D9xVUk2t6N0RBLMU3jJa/eGZzgV2RvJl1oOXJPhRyp//IKEH688QciPuC2U0c
         ysXO/zE/4FHTYf/GAGubR5TzSuLDapQZsZE9oROmxjUgjbisLehv69eUOn4vncD2zy3L
         iJ6A==
X-Gm-Message-State: ACgBeo17pfV3rRNgyD+iBiomz/tZf48U2ohQa/u/2g/2QR7QWg/aZ/IE
        1jCjVyjM424hAusW0J8NjNY=
X-Google-Smtp-Source: AA6agR5QOaqvtIoVx5Bin2x+wiRcH4moEJJlXrbG8Yn8LK7Igv7M/jtpddN3oejEBKPK9FGt4HnrHg==
X-Received: by 2002:a5d:6802:0:b0:228:d6e9:6dd8 with SMTP id w2-20020a5d6802000000b00228d6e96dd8mr4963144wru.710.1662633834261;
        Thu, 08 Sep 2022 03:43:54 -0700 (PDT)
Received: from felia.fritz.box (200116b826f77600d0640cc051af4288.dip.versatel-1u1.de. [2001:16b8:26f7:7600:d064:cc0:51af:4288])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0022863395912sm17227486wrb.53.2022.09.08.03.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:43:53 -0700 (PDT)
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
Subject: [PATCH 4/6] usb: chipidea: make configs for glue drivers visible with EXPERT
Date:   Thu,  8 Sep 2022 12:43:35 +0200
Message-Id: <20220908104337.11940-5-lukas.bulwahn@gmail.com>
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

Make the configs for usb chipidea glue drivers visible when CONFIG_EXPERT
is enabled.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/usb/chipidea/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 661818e8fed6..c815824a0b2d 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -34,26 +34,26 @@ config USB_CHIPIDEA_HOST
 	  ChipIdea driver.
 
 config USB_CHIPIDEA_PCI
-	tristate "Enable PCI glue driver" if EMBEDDED
+	tristate "Enable PCI glue driver" if EXPERT
 	depends on USB_PCI
 	depends on NOP_USB_XCEIV
 	default USB_CHIPIDEA
 
 config USB_CHIPIDEA_MSM
-	tristate "Enable MSM hsusb glue driver" if EMBEDDED
+	tristate "Enable MSM hsusb glue driver" if EXPERT
 	default USB_CHIPIDEA
 
 config USB_CHIPIDEA_IMX
-	tristate "Enable i.MX USB glue driver" if EMBEDDED
+	tristate "Enable i.MX USB glue driver" if EXPERT
 	depends on OF
 	default USB_CHIPIDEA
 
 config USB_CHIPIDEA_GENERIC
-	tristate "Enable generic USB2 glue driver" if EMBEDDED
+	tristate "Enable generic USB2 glue driver" if EXPERT
 	default USB_CHIPIDEA
 
 config USB_CHIPIDEA_TEGRA
-	tristate "Enable Tegra USB glue driver" if EMBEDDED
+	tristate "Enable Tegra USB glue driver" if EXPERT
 	depends on OF
 	default USB_CHIPIDEA
 
-- 
2.17.1

