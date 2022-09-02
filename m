Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72B85AB532
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiIBPbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiIBPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:30:49 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657EA9F0E3;
        Fri,  2 Sep 2022 08:11:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cb8so1723781qtb.0;
        Fri, 02 Sep 2022 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=p+L9f1dvils07Gz1b55U5/EE7UVVpwzo5b1oBq7ObM4=;
        b=CpJmMmMtzlHbN0VrN0A01UzPiIe7pPyBa6Pksq9Yorre5LGJ/Yp2lQyyNEOPB3yoWj
         ChsMtFmg2ZwGmq15Iz9g3Fy4Qr7CVP5brUSC3pYKM43jwEYsKk5qUeP782ke72bOVmqp
         sBZ7KD31Sj4n5+V5lCods0y+0PdHcPDKhcRKjOgM7axD/vVWg7XdEMBdDPC8KMu3WQvi
         GbdUyNVy2sYNb8moQAk6TskHy38hV4apc34ViAjdUJ7JUPsyd/1uyi5Vkp2djDXoQf5o
         1s7VG0jqP5L/kHOMHT6R/sJYLoOeQsiuMISDZt9ODnq87XBnz1vQZp+LLpd5xBLX2v+y
         zGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=p+L9f1dvils07Gz1b55U5/EE7UVVpwzo5b1oBq7ObM4=;
        b=Tb1bq1G1AhBh/AjJ/gLVq5VYGxq6l+9LwJ68dlGHWCrkRmFY1wBG5W//i75t3IWgwc
         4hcYv7g2lbdgZ7T3/qsjfbqDE6u7++yaO3NNsqdTJAef7aCEybvjoW03XYuK5Z/jc7ho
         u+lutDrGeqLjcBlcqKlLRP//sv1IM/qGfnNPgshY4WeuA/ETYEN8LdGiCIlgPay6ZdYu
         i85MXr5jfOXwnO5SgFn9puL23i1bAmdGQld1PzhMjtgRZ2/262/WCvTtHMGmh1kjPMTF
         XUZZ/Huc36GTeF+R0e7h7jjg3SmOJr+al13m06J8KAawwaF6sNyeCfQ1cUWgGXgklRnS
         1ECA==
X-Gm-Message-State: ACgBeo0MbnBxw/ePX+197z6cSDOReae2P8YYpmXvn+FI5jDE1AuVe+ww
        H4RhPf/51+nmsjkdr/UyCXoS5i/PCKqz4a3SgYxoqoMU1OFnYg==
X-Google-Smtp-Source: AA6agR6Hj7YV/dIm/rkShSxzAxNZPsCrItkybiTbmt4mMrb/1gxsnlGCUGGr0ixpkRtDT/8ARD7jsf6Hcr0he2sw7gE=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr28431175qta.429.1662131477235; Fri, 02
 Sep 2022 08:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131352.1586599-1-o.rempel@pengutronix.de> <20220902131352.1586599-2-o.rempel@pengutronix.de>
In-Reply-To: <20220902131352.1586599-2-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 18:10:41 +0300
Message-ID: <CAHp75Vf8nNTUM0RtScwMwRTndOyyDNO2dE-2yVML-WOh6s4uXA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: adc: tsc2046: add vref support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 4:19 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> If VREF pin is attached, we should use external VREF source instead of
> the internal. Otherwise we will get wrong measurements on some of channel

the channel

> types.

Below are minor changes, not sure if you need a new version for that.

...

> +       priv->vref_reg = devm_regulator_get_optional(dev, "vref");

> +       if (IS_ERR(priv->vref_reg) && PTR_ERR(priv->vref_reg) != -ENODEV)
> +               return PTR_ERR(priv->vref_reg);
> +
> +       if (IS_ERR_OR_NULL(priv->vref_reg)) {
> +               priv->vref_reg = NULL;
> +               /* Use internal reference */
> +               priv->vref_mv = TI_TSC2046_INT_VREF;
> +               return 0;
> +       }

This can be refactored now

       if (IS_ERR(priv->vref_reg)) {
           /* If regulator exists but can't be get, return an error */
           if (PTR_ERR(priv->vref_reg) != -ENODEV)
               return PTR_ERR(priv->vref_reg);
           priv->vref_reg = NULL;
       }
       if (!priv->vref_reg) {
               /* Use internal reference */
               priv->vref_mv = TI_TSC2046_INT_VREF;
               return 0;
       }

...

> +       ret = devm_add_action_or_reset(dev, tsc2046_adc_regulator_disable,
> +                                      priv);

I believe it's fine to be on one line.

> +       if (ret)
> +               return ret;

...

> +       priv->vref_mv = ret / 1000;

MILLI?


-- 
With Best Regards,
Andy Shevchenko
