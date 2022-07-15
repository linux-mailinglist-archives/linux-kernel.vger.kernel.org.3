Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A6576283
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiGONGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGONGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:06:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468B3D599;
        Fri, 15 Jul 2022 06:06:17 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 6so8329824ybc.8;
        Fri, 15 Jul 2022 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjk0QcLK7Qj7+zbxyz81ybo9xTsZsUl/7XEcNiCSZlk=;
        b=I/KxJOarbkD3CTr6bI1+GX+R+0NK3NiJOovyOkNmpfsXSDv2vhcKk5NI+vZftnkbGg
         MwrvPAOczLpV/PzuzznMkxCSxJ+6WcBxz2SeXhuGLsY0hH+bxgIA+vAWaqy8gXKWAq2A
         uzFOe2j4x3jy2QIvV7SK11B49LyIqafJ56HKzoiej9S7S0ggTmMqLI8tQrHvAJsSRq/z
         rNeHJ2pSwMUMYzeC8dNaH6ecQWQOtzNB7/eDnb0GxvTouw5w6xHmU0P81MLtH8ioFMQA
         fU5zDFovh6s+bvTishJ0zl5v/l4nnJ809RZNoyuqT7PXEo9cUMjGqySfB+fn2ERJmoLs
         3duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjk0QcLK7Qj7+zbxyz81ybo9xTsZsUl/7XEcNiCSZlk=;
        b=H5ztsXgtdPdhxjNfLlDvNXD2n7pVUmxlic9bMcioNNnGL3iAxoY2mKgsTvcAti25n3
         SG5BqjPUl3V9/wfI50Kicyhq0/Vy1srtnht3X2lU/Bat8u8O149jfW6YFJ55fx/2+YtJ
         BAC/zgY8yCPwTlhlwaSoCoHkI6sDz7Rgi3KnRrh28QPfWC9X/1iJlkmG1AJx02gXwauA
         Rz2Q6YqM9UMph9pNwlERWYB8pUDckUuzsZ4lJW7ndNuweU4Mexjip5nzsu271O10jk4q
         YBEIGJY30cEajjc9/FQh0akSfEcmWaSrcFgTtXWlRMpiibN/jqFSZCUpVwompp9S9NtE
         V+UQ==
X-Gm-Message-State: AJIora/zfuY0767eC++6t2Mqy1l+2KqJvtQoxIr6SYyFjwt/IpwTJWZx
        IuxZHqnBPKbC0gpAC9ChtW3hTsIpQ+HqZg5l/tc=
X-Google-Smtp-Source: AGRyM1u3gUyh808T1Pv3+nx4gv3OvZpiRmNXNk53IV5K4A6JGQG9S+KaILzgC03cdHtsws8VU8kBi0pySHUZ77kiRtY=
X-Received: by 2002:a05:6902:1143:b0:66e:eb08:4c23 with SMTP id
 p3-20020a056902114300b0066eeb084c23mr14488436ybu.570.1657890376848; Fri, 15
 Jul 2022 06:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-12-peterwu.pub@gmail.com>
 <d7157483-a6c6-1883-6fc1-d518c7095288@collabora.com>
In-Reply-To: <d7157483-a6c6-1883-6fc1-d518c7095288@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 15:05:40 +0200
Message-ID: <CAHp75VdzG4hjcMDv5Qro25gJx+adO-rNTiCx9ez30uVoUX-odg@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] leds: mt6370: Add MediaTek MT6370 current sink
 type LED Indicator support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 2:40 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 15/07/22 13:26, ChiaEn Wu ha scritto:

...

> > +#define STATE_OFF                            0
> > +#define STATE_KEEP                           1
> > +#define STATE_ON                             2
>
> I propose, instead:
>
> enum mt6370_state {
>         STATE_OFF = 0,
>         STATE_KEEP,
>         STATE_ON,

>         STATE_MAX,

Usually we don't put commas at the terminator entries.

> };

-- 
With Best Regards,
Andy Shevchenko
