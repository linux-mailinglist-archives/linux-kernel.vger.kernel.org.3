Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A34E7E71
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiCZBbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCZBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:31:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9D65D22;
        Fri, 25 Mar 2022 18:29:48 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 85so7286228qkm.9;
        Fri, 25 Mar 2022 18:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0DdVLSUcC07GOA7YCsdp/ReN/FeYz9xl0dhfJXTph2Y=;
        b=NYGDT1hpkwAmj4qNgRwTVfk/nDGVn7ICfXt11j7tqy1L2Qg6LSZi8sZmKfMfI77yT2
         U3j7UPKGJfdXv+JQBHL/teQOYC8R4XmnCjT6b1Xye9cuLGIGQUcaa2pKDHXVGHI06IZG
         7LUph476kAay71Z5SlaAZtc4tVof6JuDqCFOsOlcoDVwHB3dykuM6jA5GFiKxAMncXks
         x25+i7ohNfL7koiEv5JM0N2ZjYSszZ0dpFC2R7KiNywxTZBYIGsNyZK+UhjN7UK9LHS2
         iIKYGAaOb8jcrrVhz2hPt7DHQrvF3JtReG1zT6akS1+dZUQ5ppZDV6WoYb/dFMVbL8rg
         gQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0DdVLSUcC07GOA7YCsdp/ReN/FeYz9xl0dhfJXTph2Y=;
        b=m9jgoiqW3LNPjcea089lzG7dHZBr5QpILSZAaVPCnaFE/frewKJAN5QaFmplowXW8c
         sGTAK36jhKgUC+SNnlwu8HL56SuodW6zqfIySRapjtjcrpk5ih5K/NahQW8E7HowslZp
         9hoJD+2e5vKVM5Ohdzn+E0JIZX2x5USx+OXhPYdua0e1i8irtRm9ysISbKLnTkzcK3Xz
         tTP8wtUAJQinLJi2QRYME8YoUsFFwsoAuy7P02Iqru0vXTZZ4Hntx6VrS4yKS4eB2Mon
         //5PVoOdjF7Uj7Dt5dqigkdrBPaqv1jLrfQjTuSfEX3CroE1y9E0gMmtcZ/D2gGIMe8l
         513w==
X-Gm-Message-State: AOAM5302MIDYY7x3Fm1quD1SpjCt3G4uUrFhkyMd8HuaSwDW4lvai9kA
        LE/zBLzPwYqHFURRNh2erB8=
X-Google-Smtp-Source: ABdhPJxwSYziXTXZa6eWMGSDKJEcAKSR4zyp/bDDcexpV7c+glHyWVK+7ttSr1PQSnpunzQvgNDJTA==
X-Received: by 2002:a37:6784:0:b0:67b:32b3:ba71 with SMTP id b126-20020a376784000000b0067b32b3ba71mr9105252qkc.595.1648258187600;
        Fri, 25 Mar 2022 18:29:47 -0700 (PDT)
Received: from localhost ([98.242.65.5])
        by smtp.gmail.com with ESMTPSA id t67-20020ae9df46000000b006809a144ac1sm4329977qkf.99.2022.03.25.18.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 18:29:47 -0700 (PDT)
Date:   Fri, 25 Mar 2022 18:29:45 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <Yj5siWiBVKUgtbxz@yury-laptop>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <YjtNJe4Pgp3WIwOa@sirena.org.uk>
 <YjtXbDyCWZxKnf4Y@smile.fi.intel.com>
 <YjtvsYs+x3LRaLVP@sirena.org.uk>
 <Yjw4yjgordnSo+7M@smile.fi.intel.com>
 <YjyAFNYpDjSQnIN1@sirena.org.uk>
 <CAHp75VdFjYepcQ82e4WgNP2nQMk6O_xOALkG1yHxWPbYuHTXHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdFjYepcQ82e4WgNP2nQMk6O_xOALkG1yHxWPbYuHTXHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:09:36PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 24, 2022 at 10:48 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Mar 24, 2022 at 11:24:26AM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 23, 2022 at 07:06:25PM +0000, Mark Brown wrote:
> >
> > > > Yes, it's not needed but what meaningful harm does it do?
> >
> > > There are basically two points:
> >
> > > 1) in one driver the additional lock may not be influential, but
> > >    if many drivers will do the same, it will block CPUs for no
> > >    purpose;
> >
> > > 2) derived from the above, if one copies'n'pastes the code, esp.
> > >    using spin locks, it may become an unneeded code and performance
> > >    degradation.
> >
> > I think if these are serious issues they need to be addressed in the API
> > so that code doing the fancy unlocked stuff that needs atomicity is the
> > code that has the __ and looks like it's doing something tricky and
> > peering into internals.
> 
> I believe the issue you mainly pointed out is the __ in the name of
> the APIs, since it's case by case when you need one or the other. In
> case of spidev we need non-atomic versions, in case of, e.g.,
> drivers/dma/dw/core.c we need atomic, because spin locks used there do
> not (and IIRC may not) cover some cases where the bit operations are
> used against same bitmap.
> 
> Perhaps we might add the aliases as clear_bit_nonatomic() et al. Yury,
> what do you think?

We already have bitmap_clear(addr, nr, 1), which would call
__clear_bit() without any overhead. So, I think we'd encourage people
to switch to bitmap_{set,clear} where it makes sense, i.e. where the
object is a real bitmap, not a thing like flags. We can even invent
bitmap_set_bit(addr, nr) if needed.

What really concerns me is that our atomic bit operations are not
really atomic. If bitmap doesn't fit into a single word, different
threads may read/write different parts of such bitmap concurrently. 

Another thing is that we have no atomic versions for functions like
bitmap_empty(), which means that atomic part of bitmap API cannot be
mixed with non-atomic part.

This means that atomic ops are most probably used wider than it worth.
I don't know how many useless atomic bitmap ops we have, I also don't
know how to estimate the excessive pressure on cache subsystem generated
by this useless clear/set_bit() traffic. 

Thanks,
Yury
