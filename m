Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AA5A3EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiH1Rk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiH1Rkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:40:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7667DF5BB;
        Sun, 28 Aug 2022 10:40:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id d1so4859433qvs.0;
        Sun, 28 Aug 2022 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i1mP7jpO74pdVbtbN8wurpi9V0XxlBqETkezrbartW4=;
        b=C7VYoiTHyjEKDMKv7Tn1E999lqOQzQ5G3EpP5v7YPSA3+kQiQdK2xMfOh4UQ15mUj1
         YGBlk+Y49Cm4y93H3AgOqvpdVQm68g1hA5S0EmCvpcNeUHXZR1i4Xlm84itGMWqaFGGI
         Yf8dXr1OC1SyY7t+MahbhB5QsSSM1h5/frzzvWJJpjO9XUtaeGFCTxUfyDAFgE2p51he
         hkLARtPbxPvfjOas2bflSY/59VuOR/683N+klAQ//ymPiubI1Lmi4hGxPF24c41LV9bY
         1JRWtO6Vsgq4M/FsUNNJdrZzFp/7PaDDdyqBFYGgaF69eo0FuobdWrQf4C4SSbhkCXRF
         6m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i1mP7jpO74pdVbtbN8wurpi9V0XxlBqETkezrbartW4=;
        b=CfO374k7i8iefkqNBsT1w3aF0cLLoTsxwL+eYp/o6lCW+s/SR5W8uXJRU5pBwUoNvN
         pB+UAr30b71t7j/xDIAv93Kkl1vIbqO6M4zcazVVbjrhDc46DMC1+ZsfvXNdf1oY+jbz
         GS4gf9Cr7kdlNlzFDX6FrSCi/om4ojZEPhaKQnvg7tDAN/qQH8L3pmfYTDQGpGBQvk5E
         GT+QkVTNwjQ0ETNNlCS9bryGEJGm7p+MaL3VeESDZottstgoCe4i1MvjMj5ejwv83sIk
         7vuL0nGMH7MTU3wlESxKDrc12KbnY/OR8UPyL+UvsgMZro7AQDpS98qxS6XdrsVXRVSf
         GxzQ==
X-Gm-Message-State: ACgBeo29YVhHl4xbeukr35lL0DzuY0XjjPEEbNVMQBxbH9V1lkeRkDO0
        66L//3zXen0DcgY5jbOfUliRC2QUma3HBLVFoKk=
X-Google-Smtp-Source: AA6agR4dyOgKbc28f9U6twJgejAX93ewftPnq24/a9NjlEEfNdniG38HZ7i66aOh+Qc9chmz9zQDREs1aoxfjnpPzXI=
X-Received: by 2002:a05:6214:2022:b0:497:2c03:61 with SMTP id
 2-20020a056214202200b004972c030061mr7749081qvf.11.1661708451573; Sun, 28 Aug
 2022 10:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-4-andriy.shevchenko@linux.intel.com> <5ba98dbd91dc981ec7384484b2a498805abef6b0.camel@perches.com>
 <CAHp75VfY5RgAju5ASvAp565oF6VmYYiuowNsPTGSm=+1iFJ98A@mail.gmail.com> <2e158f8dc433b6b78d47d209495bed678d92369a.camel@perches.com>
In-Reply-To: <2e158f8dc433b6b78d47d209495bed678d92369a.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Aug 2022 20:40:15 +0300
Message-ID: <CAHp75Vc0NtYcuSUP106V54U6EBYsj3LMx2FDJT4_pfB3gAtpPQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: sysfs: Utilize an array for polarity strings
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
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

On Sun, Aug 28, 2022 at 4:46 PM Joe Perches <joe@perches.com> wrote:
> On Sun, 2022-08-28 at 09:40 +0300, Andy Shevchenko wrote:
> > On Sunday, August 28, 2022, Joe Perches <joe@perches.com> wrote:
> > > On Fri, 2022-08-26 at 20:07 +0300, Andy Shevchenko wrote:
> > > > Code is smaller and looks nicer if we combine polarity strings
> > > > into an array.

> > First of all, please remove unnecessary context when replying.
>
> I am _very_ aware of context.
> I specifically left the code in.
>
> > > It's less robust though as PWM_POLARITY_NORMAL and _INVERSED
> > > are now required to be 0 and 1.  As the only 2 values in
> > > an enum they are, but that's not really guaranteed unless
> > > you read the enum definition.
> >
> > So, what do you suggest here and in many other similar places (yes, ABI
> > implied) in the kernel?
>
> Leaving the code alone.

It's good that PWM maintainers look at this differently.


-- 
With Best Regards,
Andy Shevchenko
