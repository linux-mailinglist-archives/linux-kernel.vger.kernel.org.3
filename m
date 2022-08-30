Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF95A6C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiH3Sm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiH3SmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:42:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AFB71999
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:42:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t5so12016419pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/4wRyQVPnpm0KB4dE3umHjXeWEoivMkXwHyYZflvSps=;
        b=oHW2q7g58OU5P4I1xg11aEMvZ4GqvzNeTNxgPmTS5nkgtaLrFThhrWWIbjQSHSIibI
         KNxxW61WBoZriW6aocPIyN2bG+7apSGakrbqv8pmegKsvq6KD137k3nBMgOXLhVslzP1
         1ycSlTZi2nAe+pH0XaDiQMY3Gq4LQSuXQ1pSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/4wRyQVPnpm0KB4dE3umHjXeWEoivMkXwHyYZflvSps=;
        b=fda9uqkIrCHYZ2ZehL9wGGkYqShO1At/CHz+7qjzl9+7UimiJe+pSg7Ks6hBdl7g3I
         3eDO2hk4PCaym5plg2Uad+exVKBscoSqyH9tz/omX5bPQlaESqM1cWgkDWl+fWfBIDVm
         Xsci0GO//1Bm81ZkQika9zTXrbCssLgF0KYVyQuSLf1vtjRHVO5DWYL7NJUMC4oUxXe+
         fXMDYdjQHGgm477dmZfIV0lDTAgOCEV1SEABJhr8f1vkanLcFn1a8vv0UwK4Jx4OVwCH
         Y3LN+uvGwbbf3Xn+jV32sucfX+TvWPJ6llf0ta6RiOwxMOPVAqfuGle2pSIPvWaYgLux
         M+Dw==
X-Gm-Message-State: ACgBeo1Da/MKd97riJGb5Eo9fomhh23gB0qN7jOK7RwSbmaQzf9euMPr
        iN9YGTzKCot6OM0S803TR9ptmQ==
X-Google-Smtp-Source: AA6agR5BlmQWTRcjYXPHxW7g/mCkXXJ5KQ4OLa0ngCNjDRDFz87eUdeicBGUWiZ6SHhiWRAzSV9BtQ==
X-Received: by 2002:a17:90b:4f81:b0:1fe:1716:fe20 with SMTP id qe1-20020a17090b4f8100b001fe1716fe20mr3001701pjb.63.1661884942237;
        Tue, 30 Aug 2022 11:42:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0016bf9437766sm10198594plx.261.2022.08.30.11.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:42:20 -0700 (PDT)
Date:   Tue, 30 Aug 2022 11:42:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Allow mixed type arguments
Message-ID: <202208301141.8CA10CA@keescook>
References: <20220829214550.3443472-1-keescook@chromium.org>
 <8d880425-72f5-6ba6-933f-b8b016da88cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d880425-72f5-6ba6-933f-b8b016da88cd@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:40:25AM +0200, Andrzej Hajda wrote:
> 
> 
> On 29.08.2022 23:45, Kees Cook wrote:
> > When the check_[op]_overflow() helpers were introduced, all arguments were
> > required to be the same type to make the fallback macros simpler. However,
> > once the fallback macros were removed[1], it is fine to allow mixed
> > types, which makes using the helpers much more useful, as they can be
> > used to test for type-based overflows (e.g. adding two large ints but
> > storing into a u8), as would be handy in the drm core[2].
> > 
> > Remove the restriction, and add additional self-tests that exercise some
> > of the mixed-type overflow cases.
> > 
> > [1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
> > [2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com
> > 
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: change names to "type1_type2__output-type" for better readability (Rasmus)
> > v1: https://lore.kernel.org/lkml/20220829204729.3409270-1-keescook@chromium.org
> > ---
> >   include/linux/overflow.h |  6 ----
> >   lib/overflow_kunit.c     | 77 +++++++++++++++++++++++++++++-----------
> >   2 files changed, 57 insertions(+), 26 deletions(-)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 0eb3b192f07a..ad692fb11bf3 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -63,8 +63,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >   	typeof(a) __a = (a);			\
> >   	typeof(b) __b = (b);			\
> >   	typeof(d) __d = (d);			\
> > -	(void) (&__a == &__b);			\
> > -	(void) (&__a == __d);			\
> >   	__builtin_add_overflow(__a, __b, __d);	\
> >   }))
> 
> Is there a reason to keep all local vars?
> Why not:
> #define check_add_overflow(a, b, d)
> __must_check_overflow(__builtin_add_overflow((a), (b), (d)))

Excellent point! Those were there to avoid side-effects when doing the
type comparisons in the macro, which are being removed too. :P

-- 
Kees Cook
