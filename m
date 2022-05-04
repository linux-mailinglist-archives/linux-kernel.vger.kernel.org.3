Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F151AE48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355416AbiEDTtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377848AbiEDTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:49:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4892E272E;
        Wed,  4 May 2022 12:45:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g20so2870495edw.6;
        Wed, 04 May 2022 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zns0LKPTUPymGAYU2bdItgulZ/f93Vx+6vSdDM7JqFA=;
        b=CMbI6xK8GCAA6rz7awKw91AvnRgcICsbmW9dluQjGegkZ1oaBiL+xhtJf+yZRg7oOb
         T4SXaEmvfv/inhlZh2eFG/jU1J8wD96+7QXh+X9PXxtLbf8dcJ2rfDpl/GFsbjGQ06+a
         AeAlxQ6Hm1tnYUwR2yjolZ6AfDpG9jCM/7a+oaEEpAb1NJ4ToDfhV1f2Sc2sqBDVY/s/
         PTK7byMw0pt3LPxtVk5KoJ2lxD+2dxwDkOXnVo0ffUXbntNHnrq1lNEVsj1hvatLWNby
         KaZUhSXwCAB1eIWcaXGq/VYuEbVJuugLFPVWIaSGQUiC+2GzrfdFD1AnC5wdveOqbFP1
         mE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zns0LKPTUPymGAYU2bdItgulZ/f93Vx+6vSdDM7JqFA=;
        b=yQhfRXBQ4njaLfoVSYN4qtM8A8GlWEHrYBbMRgErXshwxBxz1LBpd+VFArG8vCT6za
         21wX2MX1Pi9H1XVKryVanW2VfwfKJFzkLptHnuE/BLtlAg/JklAsbbOr7RFxX6hZyvkm
         pNRvFkh7XDEgCYWW0wbrMaGNvH3+h9UzvdWJGSxszaNZAbgoEo2uUTJp0Drd+TKYDShg
         omhoAMBAZhJ6jvhvgnefFz5iIHDsOc1pSZ9sqaPyY0fIn/NsuTaMu7qth1azGW+xKUAC
         6hLJuD6rkj7LiSE3rMMzawfaY8w6RuQ+85a3amaWT+7A7EJx2jCQ/KAYZlob2RkXZBns
         rdLw==
X-Gm-Message-State: AOAM531dqkFpwAeQ66MlrtZjedyiGYGwAP+4hv8ovQa7HPIChqoGiIlY
        +IrAv1xCKdpw+xtmEA3r/YaYqy2wj/wbBhqXIGY=
X-Google-Smtp-Source: ABdhPJyY3FXKKb40yo9NMzwpK2OCm003pCXdK3zIlEoDiapiR82hP9b52sypTg6k4ccA7Lb2mmByV9W1NA6Ke1ndYr0=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr25431573edm.122.1651693526746; Wed, 04
 May 2022 12:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220504193439.15938-1-markuss.broks@gmail.com>
In-Reply-To: <20220504193439.15938-1-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 21:44:50 +0200
Message-ID: <CAHp75VeMCiwgTFFy5vGBoWYSw4mGQU6623B1eMr7apJZF_L-kg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Make AUX gpio pin optional for ktd2692
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Wed, May 4, 2022 at 9:35 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Some appliances of ktd2692 don't have the AUX pin connected to
> a GPIO. Specifically, Samsung Galaxy J5 (2015), which uses ktd2692
> for driving the front flash LED, has the pin not connected anywhere on
> schematics. Make specifying the AUX pin optional, since it is additional
> functionality and only affects amount of current going through the LED.

the amount

> Also convert the txt device-tree bindings to yaml and pick up maintenance
> over the yaml binding and the driver itself.

...

> v7:
> - drop the MAINTAINERS part

I'm not sure why it happened.

What I mentioned is to create a series out of 4 (four) patches:
1) fix the potential issue with the repetitive message;
2) update DT;
3) switch to optional GPIO;
4) update MAINTAINERS.


-- 
With Best Regards,
Andy Shevchenko
