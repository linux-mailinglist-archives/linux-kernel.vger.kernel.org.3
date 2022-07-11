Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615FD570485
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiGKNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGKNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:41:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67A4D4CB;
        Mon, 11 Jul 2022 06:41:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31bf3656517so48914067b3.12;
        Mon, 11 Jul 2022 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdwpzHws2jwe9e9bTdjMo364Spj9w7i0w60w+KBGqzo=;
        b=fr4fWushiyeFwkSE3Elj1GJcVBKEkH9TYQXwt6wz4kbsYFKBJI//8iBtjTkvh5m1td
         lY7TfolHcZmJ1dz6rDPtdUYujjlmqX8ciG2fNQFd6hLW4eyu6FDKmhH2pkRUHFKE2cyb
         VcpAzYU5hrNR9Se+wAlsoJT68cGW/HkJfwHyRGy4EyXLKfDxzpAviP/RMPn3mk8PQHkJ
         fzYAho6X6h0SaNwiRPu1MB7smEYPPCAQj+9wCvOJG2yKAW4hOVeubiw84h25f62ViSY3
         jX8Sblb4eOdlN4bvdVBGvcccQVyr96nWK5fH5xIEcqkV28GBuVvCEnGA17epZDLIdr5I
         vZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdwpzHws2jwe9e9bTdjMo364Spj9w7i0w60w+KBGqzo=;
        b=wWZW+V7Zsh/7lRYxYwu8gokQbVT7gpvg9wMWskr24Si1LRGkCKi3/p+VOW8pF2oiMs
         LGVvYiIjIHg99c8HSYGaYtsaO6DvKdEte1al/C+bYX86JBxgfOq91P3MQXLijr7G7iZG
         aeehT8S8ZT4bHnxzPFLvBh1fNk7QO8H6gsBWmkIyDQ4Hz1ZtyTIgbmWuhzkGfdnI8+X6
         sZQLEDkKKfRapJG/trv4FrtVtx0Tam4bkTwQuDq68YLecpuVZnbC9JeaqJJOghMY+TfJ
         D43TlAh6SRWb8rmomoGav/1F/Uv01ZhrudkM3tAIMGdjQTKz7cRBNLprBNxBq4SrECpj
         tByA==
X-Gm-Message-State: AJIora/TSI0NGsWPf6tO2Uwt5LJEx4gv7w2R91DVabJDPfdenJc4aC9r
        is0A7APo3Oo4kB1lGHPVQTKkcUkwrMZFUrmmVbE=
X-Google-Smtp-Source: AGRyM1tI/w/ZyWN7kdnWCxqnewu9nCeJj2Kvs5+rlCAMnMcXkfOmVTzc/oG13/3jVJYvAQaO4QiD90BliyiLgVIU1gw=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr14590130ywa.185.1657546905261; Mon, 11
 Jul 2022 06:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711112900.61363-1-shreeya.patel@collabora.com>
 <20220711112900.61363-3-shreeya.patel@collabora.com> <CAHp75Vf3NDsep5_819=e8yrna_AGh5cew=fs+hHe1q8LCa-PyA@mail.gmail.com>
 <c90e7334-5921-886b-2f9c-869fb55216ca@collabora.com>
In-Reply-To: <c90e7334-5921-886b-2f9c-869fb55216ca@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 15:41:08 +0200
Message-ID: <CAHp75Vf=FOt+N6azar5gifvig8FL4sS3LX1kO8CzNCh2yOk-DQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: light: Add support for ltrf216a sensor
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com, dmitry.osipenko@collabora.com
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

On Mon, Jul 11, 2022 at 3:39 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
> On 11/07/22 18:36, Andy Shevchenko wrote:
> > On Mon, Jul 11, 2022 at 1:30 PM Shreeya Patel

Please, remove unneeded context when replying!

...

> >> +static const struct regmap_config ltrf216a_regmap_config = {
> >> +       .name = LTRF216A_DRV_NAME,
> >> +       .reg_bits = 8,
> >> +       .val_bits = 8,
> >> +       .max_register = LTRF216A_MAX_REG,
> > Why do you use regmap locking? What for?
>
> Why do we want to skip the internal locking if it doesn't bring any
> benefits?

Can you elaborate on the "no benefits" part, please?

-- 
With Best Regards,
Andy Shevchenko
