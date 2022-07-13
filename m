Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551B1573421
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiGMK1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiGMK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:27:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40927FACBD;
        Wed, 13 Jul 2022 03:27:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o12so9844164pfp.5;
        Wed, 13 Jul 2022 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a2GCjUG2efRDq3ylvffhC8tcRJPvwE5CiIKMqu7YgOI=;
        b=YtLmz3kb7V8EfNS/cCnAA5u5EYMwtig4bpy7oyssfScFgBtMHN/W7vlz7T9SdCu80a
         2uQXIvJOhSwIn342YRykz3GQmRtrovkP3bSozzN8jn+SJT2gYjnbLR+1useyvN7Y85Og
         Yehar1KN7wwSkge/QtQ7frhOiw317eHfEi41F4ZYy7fXNrb2PhGD5BVr74dlecjRf9FE
         Ml8FWlPmznl7C0tHMvfqGXGJ5MO2HgvUaCi9MhemqfS0GJSU9fyGmA/nQZOF8GGJl6fb
         C6dSI7FOzxDPgShfgmsmO9aWfBtEFXrXuVlg1tQ4L/LOsVxSuiqk3tX4AYlfVs4u76x0
         fMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2GCjUG2efRDq3ylvffhC8tcRJPvwE5CiIKMqu7YgOI=;
        b=WkYh6vBJEgNAJoaGDOwafS/d7+vjvphohg+MAwlVng1+cC1ZWXHKYV5Xp0cvNjA8pG
         EtBb5C3xOVBxH7LktvWrlp5Sh+qleB3/41oyFKstlRYBKZLWI5xezBshJyLZiGffhr8M
         wvpzBcCc/peG4cA/YelodKFK4ZVyjyNzO//GeI0gj+pnsQX5R9fzZooUsJOg3jIq8adw
         hTm5kCK45+mS1Cw6W0Huv/9OhxrtWzvZzKdGYs0FsjeCRH0WJNnOSbwcA+RUMgAudno1
         xcitRAPUtarzFCKfbTA75xzIpi7VMhfwA4vmw/PjvZywMxPFW5y+/fhSvRUJs9lnxaFM
         12+Q==
X-Gm-Message-State: AJIora+qweTdbIclhtSDW4p6k8es4fvqMpDmKZKDT6W149AmMxDHgZ5k
        s8oGIeNQPiRGIlbNYOVKtWo=
X-Google-Smtp-Source: AGRyM1sMLGrQirkFys7JTpJoPoyEJqmbln5g97Nr0J/a1rwMmi7y1cmCo95r1wU+mkabx6qxgLFbWw==
X-Received: by 2002:a05:6a00:1911:b0:525:9ffe:cffc with SMTP id y17-20020a056a00191100b005259ffecffcmr2668398pfi.54.1657708035770;
        Wed, 13 Jul 2022 03:27:15 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id gf17-20020a17090ac7d100b001ef87123615sm1224492pjb.37.2022.07.13.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 03:27:15 -0700 (PDT)
Date:   Wed, 13 Jul 2022 18:27:10 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [PATCH 4/6] gpiolib: cdev: simplify line event identification
Message-ID: <20220713102710.GB113115@sol>
References: <20220713013721.68879-1-warthog618@gmail.com>
 <20220713013721.68879-5-warthog618@gmail.com>
 <CAHp75VeRshC3Db8Q2J80fk7=UvLiRymrkoAbuWceOfncfzvr7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeRshC3Db8Q2J80fk7=UvLiRymrkoAbuWceOfncfzvr7A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:59:10AM +0200, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > Reorganise line event identification code to reduce code duplication,
> > and replace if-else initializers with the ternary equivalent to
> > improve readability.
> 
> ...
> 
> > +               le.id = level ? GPIO_V2_LINE_EVENT_RISING_EDGE :
> > +                               GPIO_V2_LINE_EVENT_FALLING_EDGE;
> 
> It seems several times you are doing the same, perhaps a helper?
> 

If by several times you mean twice, then yeah.
Not sure that reaches the threshold for a helper though.

Cheers,
Kent.
