Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9155A7F49
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHaNxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiHaNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:53:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CCD51E9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:53:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h5so16947522ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qCFKBCshFxCZkTA7wPsRFv4K+TP8z0HvHgBKmfL+tX4=;
        b=hXugw4WFK9xiaD0ujfmVvgUEVXtEl22pvyborwblEtGrXY+9/qC82Gi+QWfLGmF9+L
         6s7PaeOph9riij42lvZ9WKvJZLNplGx4t+1G5vLJjcqKCMr3RVMcc9UV4CsDeT53dWFD
         FobrUdhWTUE+s/OG7IKwFPFmThSb4V5Qu5fPBI1UQN6IZLgVhrCZ8cdFPaqplLx/YFya
         tyTur/H+Na7ZvsAQKxsSmzytBy9OzU6gHTJUUpDvwgHeUiAHl74mOZlyStaxp7JswkRA
         mPfQSYW85x2jn0XQAr17zP/eOAedVs+LxICagzJYbLqs1Wo71wK5v9tQ5lmvCPTD2yW5
         omrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qCFKBCshFxCZkTA7wPsRFv4K+TP8z0HvHgBKmfL+tX4=;
        b=A6/h4SXrgyblmpN0dSek4c8GieNufeWWdEp4xLAecMg0GAxq8d7bJsXWIJtj8XVxUE
         16XTIQKjycdGMM5kCBPA9yzy4Ou5Sx2GVi92/1gKtWjlU3tmpe9fQJiAn7gobwo9y8CP
         fM+BU7AY4E9Mss7lw+mBBR/tRwC1tgKlx8XLoa2fmGUJLELflo61W+UBJHwaUgvprTTz
         k4YGdPYpwgkD5To9b+yr3UEYmhcEc3neofXgXjAPWA9YoVl5mrgbcFSOuowULO7W5/QM
         Ei+3ZfZmmgHU9KDcZcK7QRULywrSUqvH3XwAAfgnGGkFqugf6O52U40ibWHec4uIDUyb
         uGrg==
X-Gm-Message-State: ACgBeo1ZcsCY8H7iHxyqDfZXRU+ds8AdVIcOZBSsZWL9FB8D5z4pv1E4
        deqNxo43ZetAcLERSJoYCUz72/zb6j7Ughhch7viCw==
X-Google-Smtp-Source: AA6agR66PUMI3NeWwQ5XuYbnrXxr7gJ8zCpLbXbI0G/I16dHLaRY3u4lhiIjjt0A2xVJHfzo3kUBkvP1VHNvVdJebWs=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr11431806ejc.203.1661954006840; Wed, 31
 Aug 2022 06:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220816204832.265837-1-linus.walleij@linaro.org> <Yw46t9Y1PYoMLSKq@smile.fi.intel.com>
In-Reply-To: <Yw46t9Y1PYoMLSKq@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 15:53:15 +0200
Message-ID: <CACRpkdZEVYDAPbBkATr=6sea8gu6JmuAjU_sDRV=ZgswfhD-Kg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5] regmap: Support accelerated noinc operations
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 6:36 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Tue, Aug 16, 2022 at 10:48:31PM +0200, Linus Walleij wrote:

> > +                     ret = regcache_write(map, reg, lastval);
> > +                     if (ret != 0)
>
> if (ret) ?

This was done to follow the style of the rest of the .c file.

Could be patched everywhere though.

> > +             dev_info(map->dev, "%x %s [", reg, write ? "<=" : "=>");
> > +             for (i = 0; i < val_len; i++) {
> > +                     switch (val_bytes) {
> > +                     case 1:
> > +                             pr_cont("%x", u8p[i]);
> > +                             break;
> > +                     case 2:
> > +                             pr_cont("%x", u16p[i]);
> > +                             break;
> > +                     case 4:
> > +                             pr_cont("%x", u32p[i]);
> > +                             break;
> > +#ifdef CONFIG_64BIT
> > +                     case 8:
> > +                             pr_cont("%llx", u64p[i]);
> > +                             break;
> > +#endif
> > +                     default:
> > +                             break;
> > +                     }
> > +                     if (i == (val_len - 1))
> > +                             pr_cont("]\n");
> > +                     else
> > +                             pr_cont(",");
> > +             }
>
> I'm wondering why we can't use hex_dump_to_buffer() approach? Or even better,
> introduce eventually dev_hex_dump() (as it's done for seq_file and printk)
> and use it.

Hmmmmm this is under regmap_should_log() which turns on
dev_info() simple prints like x <= y and y => x to the console.
e.g. dev_info(map->dev, "%x <= %x\n", reg, val);
It would be rather print_hex_dump() the problem being
that hex_dump_* accessors assumes line oriented
linebufs "must be 16 or 32" (values per line), and here we probably
don't want that:
we want to show what we shoehorned into the FIFO.

Yours,
Linus Walleij
