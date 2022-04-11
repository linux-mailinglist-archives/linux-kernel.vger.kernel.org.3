Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535154FC2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348753AbiDKRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348739AbiDKRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:12:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4EDE9F;
        Mon, 11 Apr 2022 10:10:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so19270874edw.6;
        Mon, 11 Apr 2022 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXYI7jas27KXQFWzQAqCjxbvW9SNZ9FrO2KKjkUfn0k=;
        b=VTXUTMM8/MVPRxc7Dj8tuvwskdeJ2OL3vjFhCYJjaL7PT8yjgolt0IrOwBQF4CIuaV
         1QvMjeVI+WJvJ/RpGs/CnsXytir4GHRcHL6zapzw+8WocEdElNfeWnm9dwNq/qCfXAty
         ntyM2100cVWknYXIFfPG8PNxs81t4Jxe+pi2t65vgrrpUQrlGGFvMvGUam1h3QCAIRdF
         rxn1S9XmmDq7K2Y3V7IoVjLooqMxNYqYTCTcF7BHlpEaSDc0xPGiOHFW0FstDB8B+uAO
         zop20r0dXRU5zORi5/uArwPzcq9xNJPejLFvLFl09Dly+Ua/D0Q+C+10QOQQn0djfvqz
         lDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXYI7jas27KXQFWzQAqCjxbvW9SNZ9FrO2KKjkUfn0k=;
        b=VDyVwgucSf+VQsBR+4ljtjdi045cXxNFhFl2agGD6meKd5OGTmEULVsCjS7sjp7/0r
         zEROMVAVFgeeSJgrjjP1ZbMna9dlmltHdMQRzJEPpupsc/bLSCMGcjAB9SWz2G+FIVOB
         kegTuCnH82KOaQpZnR3FQoVXBZX+KxGj6OC9//ujWDIO81Cvc+fqcBiSyTraVPRvBpvS
         /j/qlPxn5Gq744VG+tj+EZ7sEQPzxidct1ZFCbYcECOYEV7I7cTdpPupV0V3IMbq+yy/
         jbZ5nMqGUloumYybVOMsMUVj9Q1NzUqTpO8Iulo8wPyD6RQtc4LNfS1QUqH2ySEl1y3l
         wdJg==
X-Gm-Message-State: AOAM531Wa8ObLNFepjlz/c+q1qyAHY2Up4V8rL/+XMVQrXakPwrObbg7
        HTZFhx8ezyGXZpXpm+Ab2xidyLhGIFobyIGk05M=
X-Google-Smtp-Source: ABdhPJw9xLUS4WGM4zeOtEBtedr4s97anadMlmsyHgl4E+GO4fVj7RlJfDmCSp5DWYDyKqMJeEW6PPURDHgW7jz33ZU=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr34275976ede.218.1649697034913; Mon, 11
 Apr 2022 10:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220411162033.39613-1-eajames@linux.ibm.com>
In-Reply-To: <20220411162033.39613-1-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 20:06:21 +0300
Message-ID: <CAHp75VeXCMobbcpvcWPt2eeDXeHs5caB=fsAFC0xy4_0DT2miA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] leds: pca955x: Add HW blink support
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, patrick@stwcx.xyz,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>
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

On Mon, Apr 11, 2022 at 7:20 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> This series adds support for blinking using the PCA955x chip, falling
> back to software blinking if another LED on the chip is already blinking
> at a different rate, or if the requested rate isn't representable with
> the PCA955x.
> Also included are some minor clean up and optimization changes that make
> the HW blinking a bit easier.

Don't see any big issues here, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

But please consider two things for the future improvements:
1) switching to regmap API;
2) switching to bitmap API.

You may find some code in drivers/gpio/gpio-pca953x.c. It might be
that some common code can be split to the generic bitmap/regmap
operations.

> Changes since v2:
>  - Split the cleanup patch
>  - Prettier dev_err calls
>  - Include units for blink period and use defined unit translations
>    rather than just a number.
>  - Use positive conditionals.
>
> Changes since v1:
>  - Rework the blink function to fallback to software blinking if the
>    period is out of range of the chip's capabilities or if another LED
>    on the chip is already blinking at a different rate.
>  - Add the cleanup patch
>
> Eddie James (4):
>   leds: pca955x: Refactor with helper functions and renaming
>   leds: pca955x: Use pointers to driver data rather than I2C client
>   leds: pca955x: Optimize probe led selection
>   leds: pca955x: Add HW blink support
>
>  drivers/leds/leds-pca955x.c | 341 ++++++++++++++++++++++++------------
>  1 file changed, 232 insertions(+), 109 deletions(-)
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
