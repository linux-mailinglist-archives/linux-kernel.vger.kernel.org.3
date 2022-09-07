Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF25B0D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIGThq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:37:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A4BFEAD;
        Wed,  7 Sep 2022 12:37:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r17so5340530ejy.9;
        Wed, 07 Sep 2022 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ndKB7Atzyf/w1lXbEwzlKmRZsFo1D+5HTUfHps4mdmQ=;
        b=QhvIfdWKdAUVOScOUIdGm3776l+VYODIO3d9/C/f8bXO+yDukvWV0FESgq/Wmgyf1o
         u8V0sJbiU5FPvEPDNGnrCNVL+V1bQYE1bknKnEdJ5lhR4O2GoFiAPTB8lUagGGXCHzXY
         ZQmbMCUyJGI8q8HxjIGRy+20U4iVzYu+09iX+r4lKAtlyarKrLj04z4EZMKrJo6SX9Db
         gItCmnWM6t4r50i3pIMpdiiySP2nE/Kd/Mi3fwlLM54xzueNFrRcrDrGA1sAg+89V4iG
         7CxYDg6Ynb7fpqlIrQvyyTq82yJT+S2oSzpK8qJEqBDvuNZQ0b9+w0BGbl08rAodhBOe
         qzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ndKB7Atzyf/w1lXbEwzlKmRZsFo1D+5HTUfHps4mdmQ=;
        b=oP4W1IS6ldO7UDAOf9Pir7bGooUIcjeBNalEwzv8gw10Q0JZAq2y8QClUzl9RretkG
         ol6UdW64M3xgw39CyW7evS0isV4aR05CO1EjEB5zWmHsPuwCI/vQ2NkOD/NtLHd6HZ1n
         ZUVVWed4FSt+4rVtGpHAYhzz8IqRm3iFh/KEY5EVqZ0i8gk1mvffzAyvOLZT4VOrMwb/
         CAgMHrpF9PRIu8vmG72VwMVHdxXMnhgp2OI7IqueZgeyC/2KRJIfQs61QnIKv6VptRYt
         ylfienFolWzQ5272gS8ajj8nr7yg1V8/5K+swNz6Ni2wf4p5jtDkW/cknO1Lt1mAG3ZR
         u4og==
X-Gm-Message-State: ACgBeo3l0vZ4CgGbwxbkFDvxqMtskHQKmPsnUtct2eW32dejUHfKtpYL
        VsTT+MYwUG6g0K/1ngCQMvdhLzjougpPyszQ1ruDWmCpBFs=
X-Google-Smtp-Source: AA6agR7DwydpRu6XtC/zVNl1McyHODlkL/bYGYJcGJ8lGN8qaCbuq46FsrbNOrc3r4eb/7G1FcBUDYMS83PPWfsBs60=
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id
 xf9-20020a17090731c900b00740ef932ffdmr3415828ejb.584.1662579461374; Wed, 07
 Sep 2022 12:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220904044708.7062-1-jagathjog1996@gmail.com>
 <20220904044708.7062-3-jagathjog1996@gmail.com> <3ad3fb30-d56f-78be-610d-a02c9609ba42@linaro.org>
In-Reply-To: <3ad3fb30-d56f-78be-610d-a02c9609ba42@linaro.org>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 8 Sep 2022 01:07:28 +0530
Message-ID: <CAM+2Eu+xzAPEwCoGsjM5sqKjOiT5J_-dzpeB-r5XP=KoRkSXGg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] rtc: maxim: Add Maxim max31329 real time clock.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof.
Thank you for reviewing.

On Mon, Sep 5, 2022 at 8:50 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/09/2022 06:47, Jagath Jog J wrote:
> > Add real time clock support for Maxim max31329 real time clock.
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
>
> Thank you for your patch. There is something to discuss/improve.
>
> > +     max31329->rtc->ops = &max31329_rtc_ops;
> > +     max31329->irq = client->irq;
> > +     max31329->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> > +     max31329->rtc->range_max = RTC_TIMESTAMP_END_2199;
> > +     max31329->dev = &client->dev;
> > +
> > +     if (max31329->irq) {
> > +             ret = devm_request_threaded_irq(&client->dev, max31329->irq,
> > +                                             NULL, max31329_irq_handler,
> > +                                             IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +                                             "max31329", &client->dev);
> > +             if (ret) {
> > +                     dev_err(&client->dev, "unable to request IRQ\n");
> > +                     max31329->irq = 0;
> > +                     return ret;
> > +             }
> > +
> > +             ret = regmap_write(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
> > +                                MAX31329_RTC_CONFIG2_ENCLKO);
> > +             if (ret) {
> > +                     dev_err(&client->dev, "unable to configure INT pin");
> > +                     max31329->irq = 0;
> > +                     return ret;
> > +             }
> > +
> > +             device_set_wakeup_capable(&client->dev, true);
>
> Probably you should rather respect wakeup-source DT property.

Sure, I will configure wakeup based on the value of the wakeup-source
property from DT.

>
> > +             set_bit(RTC_FEATURE_ALARM, max31329->rtc->features);
> > +     }
> > +
> > +     ret = devm_rtc_register_device(max31329->rtc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     max31329_trickle_config(&client->dev);
> > +
> > +     nvmem_cfg.priv = max31329->regmap;
> > +     devm_rtc_nvmem_register(max31329->rtc, &nvmem_cfg);
> > +
> > +#ifdef CONFIG_COMMON_CLK
> > +     max31329_clkout_register_clk(max31329, client);
> > +#endif
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id max31329_of_match[] = {
> > +     { .compatible = "maxim,max31329", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, max31329_of_match);
> > +
> > +static struct i2c_driver max31329_driver = {
> > +     .driver = {
> > +             .name = "rtc-max31329",
> > +             .of_match_table = of_match_ptr(max31329_of_match),
>
> of_match_ptr without maybe_unused on the table should cause compile test
> warnings. You need both or none.

I will correct this in the next patch series.

Thank you
Jagath
>
>
> Best regards,
> Krzysztof
