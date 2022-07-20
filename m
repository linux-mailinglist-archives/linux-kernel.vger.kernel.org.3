Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4057B41E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiGTJpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiGTJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:45:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B417049;
        Wed, 20 Jul 2022 02:45:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a15so17294669pjs.0;
        Wed, 20 Jul 2022 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X3mlWFpj4S2AEsT7TyVuZdiSzXmbO7C8MQMMt/vGg64=;
        b=RzIw6shq7/p2+9kSSnoLEbXRnqiI0CLXZmBib/B9u6Kz+jdHcSFA9jwb13WPFuw4Rq
         fi+khaia4vqt0KsUbkVtO8cUSAaWDP5Ofp48hzPoXCkPZvWgqhkzGT7gkdifkkVaGpHP
         Vjv3e5tTMQKX0ji35J52361j9AXAKZk5adFFy1pVLa86yW7MyrxApLc4xmk2hbLHtdMG
         Jes4+tanrARtJLDZwim6oT2dcwDiqz9CLMbWipXP/zxJit1vFscdZDO3CQ1i6W9x76Rs
         LQQiVVOsCpnwlMhlfGSqg7u3rZoTAS4/CJgRyacjIrYgPsi8ovT389k2cQ09CBUGmpVl
         CoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X3mlWFpj4S2AEsT7TyVuZdiSzXmbO7C8MQMMt/vGg64=;
        b=PXWHLZmznHKvQponPvP6u3yOx/7XdeixN+RgtWryRyN/wkoksJYXz/HRjZ+io42myz
         KuuOd2RAg+EtT/yjTo5HauAOmUrlbRxHPknyinFyWXF1xbUDt9eMFzkIZrJniVlNaHrk
         McMwm3PFN2g1Ha9mCbRpLtHqc0IqwNwPzx5SUnBFlrtRYRK0F8ZGNIY2J7DNa59PHu6M
         QxLVd0ZXsyo8/KrtwKmyu0DlEYSlfh/MLECa8CYbNm/o+3gDTYDz1jpiWapriHjlbk5i
         xvio+qFj1BkHpTeP1L1oRtARfUKaGla1qMrT1kQAt33PK7VhqxYgPYvJ9V0Pr7nvl6or
         vMTw==
X-Gm-Message-State: AJIora+RbGtdhXY6VTnu4pc8TjQnBvpjEB6yXEDc198rgNBM7yKTyxtt
        +lQRXOUMEX7+lSYPehoUttE=
X-Google-Smtp-Source: AGRyM1sQfw9FLzUYvY3KYvRCDYSTojdB7+ka4nuileRmLrHXrjld7ic/4DquoAhGcv6UAgnVdVkJ2Q==
X-Received: by 2002:a17:903:245:b0:16b:9c49:6b1c with SMTP id j5-20020a170903024500b0016b9c496b1cmr36679021plh.153.1658310326952;
        Wed, 20 Jul 2022 02:45:26 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:487:b1ec:fd78:6fba:974b:164e])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b0015ee60ef65bsm13417514pla.260.2022.07.20.02.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2022 02:45:26 -0700 (PDT)
Date:   Wed, 20 Jul 2022 17:45:15 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        szuni chen <szunichen@gmail.com>,
        ChiYuan Huang <u0084500@gmail.com>
Subject: Re: [PATCH v5 11/13] leds: mt6370: Add MediaTek MT6370 current sink
 type LED Indicator support
Message-ID: <20220720094510.GA29755@cyhuang-hp-elitebook-840-g3.rt>
References: <20220715112607.591-1-peterwu.pub@gmail.com>
 <20220715112607.591-12-peterwu.pub@gmail.com>
 <CAHp75VfyVufzf7CK38BVu_j0B4ax_d1gLAGYDE3H1zaKkuUB=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfyVufzf7CK38BVu_j0B4ax_d1gLAGYDE3H1zaKkuUB=A@mail.gmail.com>
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

On Fri, Jul 15, 2022 at 08:29:42PM +0200, Andy Shevchenko wrote:
> On Fri, Jul 15, 2022 at 1:29 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > which includes a single cell Li-Ion/Li-Polymer switching battery
> > charger, a USB Type-C & Power Delivery (PD) controller, dual
> > Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> > a display bias driver and a general LDO for portable devices.
> >
> > In MediaTek MT6370, there are four channel current-sink RGB LEDs that
> > support hardware pattern for constant current, PWM, and breath mode.
> > Isink4 channel can also be used as a CHG_VIN power good indicator.
> 
> ...
> 
> > +         This driver can also be built as a module. If so the module
> 
> so, the
> 
> > +         will be called "leds-mt6370.ko".
> 
> No ".ko".
> 
> Why did you ignore these comments? Please go and fix _everywhere_ in
> your series.
> It's basically the rule of thumb, if the reviewer gives a comment
> against an occurrence of something, go through entire series and check
> if there are other places like commented one and address them all.
> 
> ...
> 
> > + * Author: Alice Chen <alice_chen@richtek.com>
> 
> Strange, the commit message doesn't have a corresponding SoB, why?
> 
Yes, there're two authors Alice and me.
I'll correct it in next.
> ...
> 
> > +#define MT6370_PWM_DUTY                                31
> > +#define MT6372_PMW_DUTY                                255
> 
> Looks like these are limits by hardware?
> Check with the datasheet if (BIT(x) - 1) makes more sense here.
> 
> ...
> 
> > +       switch (led_no) {
> > +       case MT6370_LED_ISNK1:
> > +               sel_field = F_LED1_DUTY;
> > +               break;
> > +       case MT6370_LED_ISNK2:
> > +               sel_field = F_LED2_DUTY;
> > +               break;
> > +       case MT6370_LED_ISNK3:
> > +               sel_field = F_LED3_DUTY;
> > +               break;
> > +       default:
> > +               sel_field = F_LED4_DUTY;
> 
> Missed break;
> 
> > +       }
> 
> ...
> 
> > +       switch (led_no) {
> > +       case MT6370_LED_ISNK1:
> > +               sel_field = F_LED1_FREQ;
> > +               break;
> > +       case MT6370_LED_ISNK2:
> > +               sel_field = F_LED2_FREQ;
> > +               break;
> > +       case MT6370_LED_ISNK3:
> > +               sel_field = F_LED3_FREQ;
> > +               break;
> > +       default:
> > +               sel_field = F_LED4_FREQ;
> 
> Ditto.
> 
> > +       }
> 
> ...
> 
> > +       switch (led_no) {
> > +       case MT6370_LED_ISNK1:
> > +       case MT6370_LED_ISNK2:
> > +       case MT6370_LED_ISNK3:
> > +               *base = MT6370_REG_RGB1_TR + led_no * 3;
> > +               break;
> > +       default:
> > +               *base = MT6370_REG_RGB_CHRIND_TR;
> 
> Ditto.
> It seems you dropped them for all switch-cases. It's not goot, please
> restore them back.
> 
> > +       }
> 
> ...
> 
> > +       u8 val[P_MAX_PATTERNS / 2] = {0};
> 
> { } should suffice
> 
> 
In the above range selector, we use the 'logic or' to generate the
pattern values.

If to change it from '{0} to '{ }', is it correct?
> > +       /*
> > +        * Pattern list
> > +        * tr1: byte 0, b'[7: 4]
> > +        * tr2: byte 0, b'[3: 0]
> > +        * tf1: byte 1, b'[7: 4]
> > +        * tf2: byte 1, b'[3: 0]
> > +        * ton: byte 2, b'[7: 4]
> > +        * toff: byte 2, b'[3: 0]
> > +        */
> > +       for (i = 0; i < P_MAX_PATTERNS; i++) {
> > +               curr = pattern + i;
> > +
> > +               sel_range = i == P_LED_TOFF ? R_LED_TOFF : R_LED_TRFON;
> > +
> > +               linear_range_get_selector_within(priv->ranges + sel_range,
> > +                                                curr->delta_t, &sel);
> > +
> > +               val[i / 2] |= sel << (4 * ((i + 1) % 2));
> > +       }
> > +
> > +       memcpy(pattern_val, val, 3);
> > +       return 0;
> > +}
> 
> ...
> 
> > +out:
> 
> out_unlock:
> 
> > +       mutex_unlock(&priv->lock);
> > +
> > +       return ret;
> 
> ...
> 
> > +out:
> 
> Ditto. And so on.
> 
> > +       mutex_unlock(&priv->lock);
> > +
> > +       return ret;
> 
> ...
> 
> > +               sub_led = devm_kzalloc(priv->dev,
> > +                                      sizeof(*sub_led) * MC_CHANNEL_NUM,
> > +                                      GFP_KERNEL);
> 
> NIH devm_kcalloc(). Also check if you really need zeroed data.
>
Ok, and after the check, I also need to add one line to set the intensity to 0.
> > +               if (!sub_led)
> > +                       return -ENOMEM;
> 
> ...
> 
> > +                       ret = fwnode_property_read_u32(child, "color", &color);
> > +                       if (ret) {
> > +                               dev_err(priv->dev,
> > +                                       "led %d, no color specified\n",
> > +                                       led->index);
> > +                               return ret;
> 
> return dev_err_probe(...) ; ?
> 
> Ditto for many places in your entire series.
> 
> > +                       }
> 
> ...
> 
> > +       priv = devm_kzalloc(&pdev->dev,
> > +                           struct_size(priv, leds, count), GFP_KERNEL);
> 
> At least one parameter can be placed on the previous line.
> 
> > +       if (!priv)
> > +               return -ENOMEM;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
