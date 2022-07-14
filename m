Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236E574089
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiGNAcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGNAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:32:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212CF5A5;
        Wed, 13 Jul 2022 17:32:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fz10so804572pjb.2;
        Wed, 13 Jul 2022 17:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MM9AZwRsJa4u3kZSBjtvlRoNVdyeEyJLv7qGDDBUOJU=;
        b=X+lYPHUDqWHSbSUn0lNMXuI0Z2lTKUlOJD5+Od036ugTsXzSbewrfRcQ1OCbtUiOy/
         iO4ogCWwajRvbkn5NoeHYaMhNCLN4bWg35lHYRZ6tBLXkPubQDyUjMlU3NucQbsm4Gf0
         ZU/yZMctKeBR1Vn1j393NnWxvUMq6CmJVkef5U8Wj8uLByLVAd7YIi8koDJkSG6yABX9
         fB9pIj2T0n4RZGmfu583yEt5qaPzXeBGPod0WshRHyqioXa1yTM8wDHbgCharifWZAmW
         7MwXMNW0YLdzKKJqJmP5SWOnQ/8Si8gTGB2kL8GkCXCulAOYfRf0LUX8BKMck83tZ268
         M4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MM9AZwRsJa4u3kZSBjtvlRoNVdyeEyJLv7qGDDBUOJU=;
        b=7acZ7GBxTyKBHB0sX06SIB19zE3hHyeT6vM6TQqLOp6Q4tNPbcz9q0hlS6MkpSYdxL
         jB/Vr71KzzrLoidwXN9q5RiS/Wpwr4ljt+lzamFFPIuVEOTu1g3pnj3c8dL49q/xuSkm
         ICNzwH1jG6jCwIJnwRmOFNYQUVpqxJjC7AfP5WWxrtouBr0G1cmKQSgSxh1Gayq7U0hk
         jCdOrtyYsEcfLhHA//HINMvqpQdRsv8ZXHgp6yjQTzsQF5oAFruhS5yQVXdOrcnGVqrJ
         fhQyZ9MREVyelM9DvDgY29qZs6uriQ7J/9Hb8TktcPa9UrlcwH2x3R9cO52tYSYIjHfN
         wBKA==
X-Gm-Message-State: AJIora/TWHF0qCoBMb5t2ax4n9Tbvwud9h0sZsr3MZymwvJYg7PRaMrZ
        FOjRJAXxM0On/y9cHOP2ckw=
X-Google-Smtp-Source: AGRyM1v+ME+NkLJuOlIz/neyJ4EiPapShH2CbglvJhujKzP00kqYfr2SuBwvpPi54PJyvF5Md59SYA==
X-Received: by 2002:a17:90b:38c4:b0:1f0:59c0:570 with SMTP id nn4-20020a17090b38c400b001f059c00570mr12706155pjb.178.1657758753470;
        Wed, 13 Jul 2022 17:32:33 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b0052a8128699fsm132310pfl.207.2022.07.13.17.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:32:32 -0700 (PDT)
Date:   Thu, 14 Jul 2022 08:32:27 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [PATCH 4/6] gpiolib: cdev: simplify line event identification
Message-ID: <20220714003227.GA18272@sol>
References: <20220713013721.68879-1-warthog618@gmail.com>
 <20220713013721.68879-5-warthog618@gmail.com>
 <CAHp75VeRshC3Db8Q2J80fk7=UvLiRymrkoAbuWceOfncfzvr7A@mail.gmail.com>
 <20220713102710.GB113115@sol>
 <CAHp75VdL4Zy=1+m5e4gcNUM7uW-q4cfJb1xof3qiQx6ZWsMSPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdL4Zy=1+m5e4gcNUM7uW-q4cfJb1xof3qiQx6ZWsMSPg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 01:24:33PM +0200, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 12:27 PM Kent Gibson <warthog618@gmail.com> wrote:
> > On Wed, Jul 13, 2022 at 11:59:10AM +0200, Andy Shevchenko wrote:
> > > On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
> 
> ...
> 
> > > > +               le.id = level ? GPIO_V2_LINE_EVENT_RISING_EDGE :
> > > > +                               GPIO_V2_LINE_EVENT_FALLING_EDGE;
> > >
> > > It seems several times you are doing the same, perhaps a helper?
> >
> > If by several times you mean twice, then yeah.
> > Not sure that reaches the threshold for a helper though.
> 
> Up to you, then!
> 

Turns out there are three instances, so a helper it is.

Cheers,
Kent.
