Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4727858084F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiGYXfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiGYXfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:35:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6FC5F41
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 16:35:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l9-20020a056830268900b006054381dd35so9806346otu.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 16:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DeZ0i71m7lXsgqJ3r02BqYK+cq3KZTMlnLHmvKXbYxU=;
        b=CuxM3sWsBSTPgEOjZsRT4+4fjCKRp1DD+h+q+tZsJRmUqGgttEcydVnl3HwtZDIHer
         zxXhs/Vjw76o3wJC5EHOUZ6QyEMyToO4FSwgjULATEJOuaKcPo2Yu3N0q/uewVDZD369
         YIKPwTVKdqvc2Sz8CbHeesLVfi4Ka1YUdHmIi8XTW8plTbruiqXKUMqM+8De8VVnVWJ+
         0/X1uPuvJcI8rqqJlVL9KSYPTSEyEyipCPPXvfCwwXgUwUdpMfTig+A4aZQy5s3XpeEa
         X7lgFDZHvvnS/yLDdjjKsdMVMzeeDMdKDA2q5aIH6LiG9807L2flrLQ32a1Gc5SSkaIf
         NFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DeZ0i71m7lXsgqJ3r02BqYK+cq3KZTMlnLHmvKXbYxU=;
        b=MwT9EVj8nlO5FKimiXP6itTZzyiujPonQDIS/E1Y/P41Aa0JoJT+2UYzuAGqgZBq7g
         JJDxvxlvau/cuX7n7EDi2V92bOdxFBiZB5ySiv+JUT/YuGPQAm0M1Yvs90A0JYFYW4//
         Nlouo1DUDi0NxapI7jIfZGH5cVAYRpvIvDnPzIaKHLmrMwQ0dZ51y70UkkVZyfoGvnub
         vWV8LOFJ7lpZ/GxxiuEhN0Ni2oEMOxQ9fXu5X2iU5U/qt9PxJkNuq5rIJ39gIKK+Dz7M
         RNXdSyxj4M9mfWLkL68m2CciP4LDEyfcsHYh5ixoO8r2+341ypk4YzcyA4rHYy+xZAz9
         tyUA==
X-Gm-Message-State: AJIora/vHgoJ2ryEyZPixmy0xjsTjlf/OGMUA2+e+TJRaEz3qe/FcQft
        ehVC4eh0miu88n0w50ItU40=
X-Google-Smtp-Source: AGRyM1vy8C5iqLabeXFffOkfvK810psuEvspeFasjH3OSccwMohmjm9n6GHknf3IO6BpuRysXhKSzQ==
X-Received: by 2002:a05:6830:1f3b:b0:61c:8421:6dbb with SMTP id e27-20020a0568301f3b00b0061c84216dbbmr5437090oth.263.1658792111438;
        Mon, 25 Jul 2022 16:35:11 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id l11-20020a9d550b000000b0061ca92ae442sm5450341oth.72.2022.07.25.16.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:35:11 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:32:59 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in
 archrandom.h
Message-ID: <Yt8oK1gUojEbO0WI@yury-laptop>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com>
 <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
 <Yt7CJj8r3eo05pKd@yury-laptop>
 <CAHp75VcGPQkY9ApsX2fi6sK5=3U=0vKbrHZZ3x___wUtgrFRSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcGPQkY9ApsX2fi6sK5=3U=0vKbrHZZ3x___wUtgrFRSA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:39:39PM +0200, Andy Shevchenko wrote:
> On Mon, Jul 25, 2022 at 6:19 PM Yury Norov <yury.norov@gmail.com> wrote:
> > On Mon, Jul 25, 2022 at 09:28:12AM +0200, Andy Shevchenko wrote:
> > > On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:
> 
> ...
> 
> > > >  EXPORT_SYMBOL_GPL(pm_power_off);
> > >
> > > ^^^ (Note this and read below)
> > >
> > > ...
> > >
> > > > +EXPORT_SYMBOL(arch_get_random_seed_long);
> > >
> > > It can't be like this. Brief browsing of the callees shows that.
> >
> > Is my understanding correct that you're suggesting to make it GPL?
> >
> > ppc_md is exported with EXPORT_SYMBOL(), and the function is in header,
> > so it's available for non-GPL code now. I don't want to change it.
> 
> The symbols your function calls are GPL. As far as I understand (not a
> lawyer!) it logically one may not call GPL and pretend to be non-GPL.

Can you explain what you mean in details?

The function is:
        static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
        {
               if (ppc_md.get_random_seed)
                       return ppc_md.get_random_seed(v);

               return false;
        }

ppc_md is non-GPL:
 77 /* The main machine-dep calls structure
 78  */
 79 struct machdep_calls ppc_md;
 80 EXPORT_SYMBOL(ppc_md);

And get_random_seed is initialized in in arch/powerpc/platforms/powernv/rng.c
with different functions that are static and not exported at all. 

I don't understand where arch_get_random_seed_long calls GPL...
