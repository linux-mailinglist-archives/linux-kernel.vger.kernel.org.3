Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9A51A47D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352798AbiEDPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiEDPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:55:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2F457BC;
        Wed,  4 May 2022 08:51:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a21so2203369edb.1;
        Wed, 04 May 2022 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUEDan7Dtx1KZpGoKAau2Fv0ZvExfFewSXxbANg6G8k=;
        b=Rweo0KfAB6S4ghWTiJYw6bg0FQGb4rnMWOySQR650Mz9JVBYQLQJoXd9Q8yFxEw0gO
         vaEhv2Gy5iV+aCOLz97jzQO/A46Ab3uHH3mrB9lLpmWZU/0U1Fk1ChzBbl9LdyV9udpY
         pdaOyOu9mECd54mSOyEt4X9FjPO8oTNr2Ggh4y5n3+omh99MJg1QcGUxqo6z+Z3zDLSB
         c4LLB+i5v2fX+Sx1rPYeRRFQe2+Xd8oXkCz4wWKpI9A7WmXgIpBdyvS1H6AeDQln9Pow
         z+stxHBlA9w3ZTegK8lNt1phZ6cdtA8GNGvku4n+QH98nvWxY8niwx2S+9zcE5vTPxv1
         r5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUEDan7Dtx1KZpGoKAau2Fv0ZvExfFewSXxbANg6G8k=;
        b=xynwduqUWOF6h7ETDRoYX0B23LhyIlG1GTmQDQMZPgDNfEbv662mvWeMMn/9iw+WmD
         HZPrN/dFPrmHdJAqdNRKB1SY0NOqZiGeeK3vvkE72qv6J+fY3dZtblvq2pRdALepdl9a
         +kwv14z3tj0kEn9Rtw6qApFkGK0STv0MJ8CWmcLFvmqLglelKre1LbdbAORd6NEBQ2eo
         3b3myhS08dh0h8pgLF1PlYM+qP5iJ2Ed96+HLVV+JKm1z3XRHMogi/0cAla2064GQE7g
         yulvMkLrqgjYzSIEm06zINbDve+p1css7z6DI8M1l2UgDQQuSQxYYFvCWmHmyH3ODV8A
         544Q==
X-Gm-Message-State: AOAM530MAH5WYegs9Gb4LVL0T/rlfmuZIzXQM68QqpNSJ2BGrpt/JcBZ
        E/CuFw0SmAk/eEzOQZMII1aLRYKPOaFQqt912Ho=
X-Google-Smtp-Source: ABdhPJzWeXcftsvlZGTStFal8X76u0Ucog5gaxUCa91ZoaoBu2hf96b7Mh0Dh3Qzp5Gpvk9f4sWk/7nam8QqvEVT9Bs=
X-Received: by 2002:a05:6402:d51:b0:425:d5e1:e9f0 with SMTP id
 ec17-20020a0564020d5100b00425d5e1e9f0mr23714956edb.125.1651679501072; Wed, 04
 May 2022 08:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220504153814.11108-1-markuss.broks@gmail.com> <20220504153814.11108-3-markuss.broks@gmail.com>
In-Reply-To: <20220504153814.11108-3-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 17:51:05 +0200
Message-ID: <CAHp75VdfaP4ypVHdMZ=TgMVmd1ioak-0AUA9k+Z6wNAr458+ag@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 (corrected v2) 2/2] leds: ktd2692: Make
 aux-gpios optional
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, May 4, 2022 at 5:38 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Make the AUX pin optional, since it isn't a core part of functionality,
> and the device is designed to be operational with only one CTRL pin.
>
> Also pick up maintenance for the LED driver and the yaml bindings.


The MAINTAINERS update seems like it deserves a separate patch.
But most importantly, you need to add a patch that converts the error
reporting to use dev_err_probe(). Currently code has that issue, i.e.
it will print the error message as many times as probe was deferred
due to unreadiness of GPIO.

Something like this

>                 dev_err(dev, "cannot get aux-gpios %d\n", ret);
>                 return ret;

===>

  return dev_err_probe(dev, ret, "cannot get aux-gpios\n");

with a Fixes tag added.

-- 
With Best Regards,
Andy Shevchenko
