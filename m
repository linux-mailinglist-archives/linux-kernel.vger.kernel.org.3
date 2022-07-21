Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E557C8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiGUKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiGUKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:09:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4DA691D2;
        Thu, 21 Jul 2022 03:09:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w185so1329655pfb.4;
        Thu, 21 Jul 2022 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JsNvQYgS7LcjVv/c6iexGN5Si+fKRd5f5BAbC7QtYk4=;
        b=eAa08a3+tl/ZofuTfcSSlCIRAq8gzsE5weAOP7UsxCGX7Y3mEwbV149NCokUNAuKe5
         EN8JAjfmhP9N9CspG2jqaZSyIaGbkZUhDaW7qofKWFu8aKMXKSZIN/OslbLhdpG3vXAe
         Ur/lyWqy91Q56Es+2f1zy2dzQ+hj8jlo3qE0YiObY2S52rcdXtLGShkNUGJiecJGeLOG
         GtukmBHV1TgkmoL4837XnIBFnmUr7cQbqEUii+cPTEyr6HZ7158GO1PQ1FREaPNHpO3p
         +zxpj8UH5CIEkJ0zMqYXxrZuHhPdN0LgPYLVzbKBbdgveUmcPeMuT3v6VXPjNd763lsV
         k55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JsNvQYgS7LcjVv/c6iexGN5Si+fKRd5f5BAbC7QtYk4=;
        b=8NhrzcyPq8vo0eJhwJoQ3PDeYP8gtUM6T0S3PS/2iBRqpZ3WK2j2d02LCAXJWtijR0
         ZFvkCFt7LxfEH8kXTYAjO0gcI5ex1sCbl9kXXPbGpcCgyVfZF98nBjeLtPCrC8g/S+SO
         pxurZMjOnsWUN+dNGLSeEGRZiOkednYQcxjbSWD5mkkfGPVGdPTuqiHBSbrGwx/yRqiB
         wCgknT25M6Brs+Nsf2EWbgIUr+MNm5+v0mfKt96EF+qkLkzV+gfxtAqD+/fp/354Y303
         xSRxpMLc2M9FfDSGGgaMo6M1TwuVkktvB7K8nrE13H9RnKLNeXTCPaD6xVAorDH+Eu76
         4Ylw==
X-Gm-Message-State: AJIora/WFL/93eMT8Q7EgbhNiTf0wbblbTmaLkYxrNNSsd+bq8GvxdwU
        ygFMao6IanLXTjJ5GnbX6kM=
X-Google-Smtp-Source: AGRyM1tMdDKZ5ydOiuf36WZNOlcNoDOh7UeG2Wl5nFnV3DeSsvm2YGSyx3q8fnZshmx3L5mTpd0DGQ==
X-Received: by 2002:a05:6a00:23c9:b0:52a:cedd:3992 with SMTP id g9-20020a056a0023c900b0052acedd3992mr42915651pfc.43.1658398191449;
        Thu, 21 Jul 2022 03:09:51 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:56a:cec2:d9ce:3b52:7023:4b90])
        by smtp.gmail.com with ESMTPSA id x187-20020a6286c4000000b0052ac2e23295sm1351501pfd.44.2022.07.21.03.09.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:09:50 -0700 (PDT)
Date:   Thu, 21 Jul 2022 18:09:37 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v5 11/13] leds: mt6370: Add MediaTek MT6370 current sink
 type LED Indicator support
Message-ID: <20220721100933.GA17618@cyhuang-hp-elitebook-840-g3.rt>
References: <20220715112607.591-1-peterwu.pub@gmail.com>
 <20220715112607.591-12-peterwu.pub@gmail.com>
 <20220717084643.GA14285@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717084643.GA14285@duo.ucw.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 10:46:43AM +0200, Pavel Machek wrote:
> Hi!
> 
> > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > which includes a single cell Li-Ion/Li-Polymer switching battery
> > charger, a USB Type-C & Power Delivery (PD) controller, dual
> > Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> > a display bias driver and a general LDO for portable devices.
> > 
> > In MediaTek MT6370, there are four channel current-sink RGB LEDs that
> > support hardware pattern for constant current, PWM, and breath mode.
> > Isink4 channel can also be used as a CHG_VIN power good indicator.
> > 
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> 
> > index a49979f..71bacb5 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -244,6 +244,20 @@ config LEDS_MT6323
> >  	  This option enables support for on-chip LED drivers found on
> >  	  Mediatek MT6323 PMIC.
> >  
> > +config LEDS_MT6370_RGB
> > +	tristate "LED Support for MediaTek MT6370 PMIC"
> > +	depends on LEDS_CLASS
> > +	depends on MFD_MT6370
> > +	select LINEAR_RANGE
> > +	help
> > +	  Say Y here to enable support for MT6370_RGB LED device.
> > +	  In MT6370, there are four channel current-sink LED drivers that
> > +	  support hardware pattern for constant current, PWM, and breath mode.
> > +	  Isink4 channel can also be used as a CHG_VIN power good
> 
> Should this go to leds/rgb directory, and should it depend on
> multicolor framework?
Yes, and I may also want to change the file name from 'leds-mt6370'
to 'leds-mt6370-rgb'. Is it ok?
> 
> Best regards,
> 							Pavel
> -- 
> People of Russia, stop Putin before his war on Ukraine escalates.


