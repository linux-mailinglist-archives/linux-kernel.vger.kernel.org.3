Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A6581648
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiGZPT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiGZPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:19:25 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6824BDC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:19:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c24so11169668qkm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oU/PFM076uQxVNOZcY0Zccr8pXxC8l8aoZK0KtggnV0=;
        b=G3K1g/yFwuaU8qm6hN080k/NOsnbTDalKmxaoQZxHy0uwGW3EO23D/QO5vfWXNOBSY
         2Ua82Lrys/l3itci7BrIm9y1Ktc3VjTcJ2fTsb3kX583UaTYzRFMgyYygJLK14l1hjId
         bzwjsLqS9piEuDFTyeeORGOJJk2aHASWXLqGHBawC77mdo+c3AueS1dxDvicH6Jnor0a
         DSJOtjsV9kS3hq092jpDTNmQlAVa7BNUgog8EGhe9j+5L3a4VnlHBwszgdsI9is7pEa7
         wDOpzy9LDFFAc6O45S2vDMJIIi4oHcEFn48pBBWBvhEoB142+tkzftYuAWUQieYMBfss
         qh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oU/PFM076uQxVNOZcY0Zccr8pXxC8l8aoZK0KtggnV0=;
        b=tj/fgilOjIvfeNZTI/+PokmAJDv0t7RG6fEikKxk6DR9gkwbJz9Rc5JUodGbFwZKCn
         J6mwRFUUlGtpzwV/k0YBUmostzQ7wq0N4sZfE430AA1pWnwsXEVJuh5BcHU1tXVn2RaO
         kwCoGKKqoxU/YawaEGyqLFnY0dbIw/Mt41S4Qxxn9HcFTbtU75nRI2wBaJ+Jn2Fwj5BC
         +j6evwZVLGuQleTk0Spm7pqEoC4sqezjVCeoxpZrFcBiJPxt40sePUfQowyCTgvMAVd3
         imH49kFwHJIpYBha81pgfMUcxQwQ3XxOeNn5Ag+kBr11f62cD2Kd94u6fkdiW5kNcKS6
         fCcQ==
X-Gm-Message-State: AJIora8oM4CcYNmREFDJxrklYwb+zMj5587XclH4LD9ZvogeUdu/kfwI
        JBLFW87XOnF8Yx9XXOFEVVmXgJWm2g4=
X-Google-Smtp-Source: AGRyM1u3LM6n0ZHE1JaFrgS+gI2RKjPyiDakaF7wBubPavR1Lo9pw7bdraLDdnmDkZ/HgCUX95FYHA==
X-Received: by 2002:a05:620a:370b:b0:6b6:d59:fcab with SMTP id de11-20020a05620a370b00b006b60d59fcabmr13593141qkb.564.1658848755222;
        Tue, 26 Jul 2022 08:19:15 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id w5-20020ac86b05000000b00304bc2acc25sm9223681qts.6.2022.07.26.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:19:12 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:19:09 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in
 archrandom.h
Message-ID: <YuAF7ahr58HjMqXs@yury-laptop>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com>
 <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
 <Yt7CJj8r3eo05pKd@yury-laptop>
 <87edy8bbtp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edy8bbtp.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 04:57:38PM +1000, Michael Ellerman wrote:
> Yury Norov <yury.norov@gmail.com> writes:
> > On Mon, Jul 25, 2022 at 09:28:12AM +0200, Andy Shevchenko wrote:
> >> On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:
> >> >
> >> > archrandom.h includes <asm/machdep.h> to refer ppc_md. This causes
> >> > circular header dependency, if generic nodemask.h  includes random.h:
> >> >
> >> > In file included from include/linux/cred.h:16,
> >> >                  from include/linux/seq_file.h:13,
> >> >                  from arch/powerpc/include/asm/machdep.h:6,
> >> >                  from arch/powerpc/include/asm/archrandom.h:5,
> >> >                  from include/linux/random.h:109,
> >> >                  from include/linux/nodemask.h:97,
> >> >                  from include/linux/list_lru.h:12,
> >> >                  from include/linux/fs.h:13,
> >> >                  from include/linux/compat.h:17,
> >> >                  from arch/powerpc/kernel/asm-offsets.c:12:
> >> > include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
> >> >  1203 |         nodemask_t                      mems_allowed;
> >> >       |         ^~~~~~~~~~
> >> >
> >> > Fix it by removing <asm/machdep.h> dependency from archrandom.h
> >> 
> >> ...
> >> 
> >> >  EXPORT_SYMBOL_GPL(pm_power_off);
> >> 
> >> ^^^ (Note this and read below)
> >> 
> >> ...
> >> 
> >> > +EXPORT_SYMBOL(arch_get_random_seed_long);
> >> 
> >> It can't be like this. Brief browsing of the callees shows that.
> >
> > Is my understanding correct that you're suggesting to make it GPL?
> >
> > ppc_md is exported with EXPORT_SYMBOL(), and the function is in header,
> > so it's available for non-GPL code now. I don't want to change it.
> 
> That's true, your change maintains the status quo.
> 
> But I think we actually don't need it exported to modules, I think it's
> a private detail of the RNG <-> architecture interface, not something
> that modules should be calling.
> 
> So I think it's OK to drop the EXPORT_SYMBOL, either in this patch or a
> subsequent one if you don't want to rebase.

OK, changed.
