Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C059AEF9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbiHTQJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTQJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 12:09:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64F1BD;
        Sat, 20 Aug 2022 09:09:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h21so5283824qta.3;
        Sat, 20 Aug 2022 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Lb96DusjveTnQ4nO46YwZRRsRpSXWmY3e1CvSrm1dCg=;
        b=FuHx/Pv+hAPiEFudPT+38RuIefiPiJrBr8GDE+B8198YsAYpHtWKbek6Kx4mQwbI5e
         eIvVerbdXh8/d3ZUjs+eFal8cAKLyJ06ozndHtPuEGN3baDnuX7lD9Mu5DoSzOediicj
         eRpgV5KPJ7A1KhiX4RcnHw+fJ5K1jiDe3ya9N4c8yr6cO5+kPs29N1BdHcCIhkdFiygG
         DFmxMJcFnqlq9Ow+ByulHz7V2ET88aBUAfNpaf5sZAwZjA2MvMbeC8UTjUFQdcqsFwEn
         wtU1+1FMiJzyENoVkUjBXVWBAjJcucuaI+IvOopl0+AJf6245q8u6KtGrmkfsu22BtIc
         0byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Lb96DusjveTnQ4nO46YwZRRsRpSXWmY3e1CvSrm1dCg=;
        b=nbLBGf2arr9Kg+MxUnecCXODvINBvOs4ZPJstDCLx9Gb0WeINxDG6WejVD5sRYt/6k
         5HgMjZNTDmVAejpixlAA7FNpTd6GHfoTnMSmtoEhVuSTZb60prVf/fd/dcpbgfB9ml/c
         aHsMZr1HlBgGyPSDzrvze9BOMeuAZhsVo5eT3cxCXjxaidiqK9euOYPWyilgRcaSW21C
         gD50ngi9BvuRf3Tvo6SYEGMBaKZFGEgnRXMBBcMZrR01uL7TVSxYKWQua9aJc9eQJ/0I
         uqxzKzV5S4NEnN+qQ3B6UaySf/qk5cZo/HxicaPN5WlKgD2BTCWwGhUwaijphH5VJ8VH
         Mvvw==
X-Gm-Message-State: ACgBeo24AHhWsext2tJkMhoLTsMYNK3i8aVaMQDxwSo6Sx2V/pNGlAG3
        +YibseefH1NCKVipulz4W+yE7qv5ZhyJOvENFeE=
X-Google-Smtp-Source: AA6agR5NlGaa4MSH8t1hpA+wC3YLtUTlvzJybhk4RJ0+/Af5yQ8xFJBy+eZDVlaQpRYfUob8IBrPDuApfI4BLCvRaic=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr10530220qtj.384.1661011779747; Sat, 20
 Aug 2022 09:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
 <20220820122120.57dddcab@jic23-huawei> <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
In-Reply-To: <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 19:09:03 +0300
Message-ID: <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using devm_regulator_*get_enable()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Sat, Aug 20, 2022 at 4:45 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 8/20/22 14:21, Jonathan Cameron wrote:
> > On Fri, 19 Aug 2022 22:19:17 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

> >> +    static const char * const regulators[] = {"vcc", "iovcc"};
> > trivial - slight preference for
> >   { "vcc", "iovcc" };
> >
> > This isn't as important as for numeric values as we get some readability
> > from the quotes but still nice to have.
>
> Right. I'll fix it.

And also make it a reversed xmas tree order.

> > For the whole static / vs non static. My personal preference is not
> > to have the static marking but I don't care that much.
>
> I'd like to stick with the static here. I know this one particular array
> does not have much of a footprint - but I'd like to encourage the habit
> of considering the memory usage. This discussion serves as an example of
> how unknown the impact of making const data static is. I didn't know
> this myself until Sebastian educated me :)  Hence my strong preference
> on keeping this 'static' as an example for others who are as ignorant as
> I were ;) After all, having const data arrays static is quite an easy
> way of improving things - and it really does matter when there is many
> of arrays - or when they contain large data.

But still the same comment about global scope of the variable is applied.

As I explained before, hiding global variables inside a function is a
bad code practice.

-- 
With Best Regards,
Andy Shevchenko
