Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B846350CFD3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 07:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiDXFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 01:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiDXFUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 01:20:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732C19C18
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 22:17:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c12so19911974plr.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 22:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZFmcLn/pFDeMh7htjVTnOwoz+IWHDFfopBWIvebvgp0=;
        b=YGE4UXFLnip6exfD2cJSFWxbiaj7cAu6LzDoNlPoMrLOxxldp0fZz7H0jHfW45wkgp
         jNJCH2lk+KZN5gcKDnTJs0+2mx7jfrn5Z96zDe0oLk1jZGZm4ZmgTiHIIN+46omPKruq
         0teFHFOA8bUCBxk6dQNd2OTw+8EOtS9gr5xL4R/MMJtizZ13s2AIMWPTeCdmsDY0zltO
         t8kahNA2gIF1wDoHq89e7oRgnp900/YNk5lAsMpmC0e6w5eMwgKW0xY0HvQU+fLkXnq/
         0JSHw8BxCY7rl56qY6pOIeHlfFf9Fy9LWEDCUCHJfArtoYg1vNpcyhM1GDOZK7947ozH
         7B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZFmcLn/pFDeMh7htjVTnOwoz+IWHDFfopBWIvebvgp0=;
        b=n+vqw5QnguQ+QTTxEfwJlQzvEddDPq0SE0l7OIhIMaNT9e9wX8zdTlwV9kg9BszNH6
         3LEDYiPt8PaDQNcMl9eF0MgqHPndP63lh2PNTHqgmSUTK5z0RLhzVtq7KThYbxA1OFE7
         /Gae3Fcp1aKf2+DxQ4Z/EDQykpAvlu7iWvChi9wtDsEklcdSpFMU+JvpaLhBR1pjcfwz
         8H0etAS8/3E1EdFEYOyCtKzaq4Vf5Hsjxvtf9MMh0PDldR8rfMGg7mIgrMD4FjM1iaQK
         Eu4jV8hDgmpOae5wihib7E2xSRs1XhBy0ZBLKJOLHpPyCQszQRkDvetcS0vuOeUlVRz9
         Bu5A==
X-Gm-Message-State: AOAM531tc+7qEh9xH2+UOW60TyRPiuOqLWWmMOEilW4PuHaunkOm4qxI
        WzCmK0iuIu7jEQSse50sXmA=
X-Google-Smtp-Source: ABdhPJzvC57/wrSdVCHMu1tWX2JdBDgQh+aIgHUgOyKw5Vbvc9NKP12PEMhkj6DEpT0WJv4E0DoC+g==
X-Received: by 2002:a17:90a:730c:b0:1d9:3f5:9a00 with SMTP id m12-20020a17090a730c00b001d903f59a00mr8862014pjk.109.1650777429249;
        Sat, 23 Apr 2022 22:17:09 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id x129-20020a623187000000b0050835f6d6a1sm7109881pfx.9.2022.04.23.22.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 22:17:07 -0700 (PDT)
Date:   Sun, 24 Apr 2022 14:16:58 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>, cl@linux.org,
        roman.gushchin@linux.dev, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mm: make minimum slab alignment a runtime property
Message-ID: <YmTdSq/OcXls6scP@hyeyoo>
References: <20220421031738.3168157-1-pcc@google.com>
 <YmFORWyMAVacycu5@hyeyoo>
 <CAMn1gO5xHZvFSSsW5sTVaUBN_gS-cYYNMG3PnpgCmh7kk_Zx7Q@mail.gmail.com>
 <YmKiDt12Xb/KXX3z@hyeyoo>
 <CA+fCnZdTPiH_jeiiHCqdTcUdcJ0qajQ0MvqHWTJ1er7w6ABq5A@mail.gmail.com>
 <CAMn1gO4WOcFqwkcAFi1mXbBrPxz-BqgQ027unx31iCO2fyL=2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO4WOcFqwkcAFi1mXbBrPxz-BqgQ027unx31iCO2fyL=2A@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:40:08AM -0700, Peter Collingbourne wrote:
> On Fri, Apr 22, 2022 at 9:09 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Fri, Apr 22, 2022 at 2:39 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > >
> > > > > kasan_hw_tags_enabled() is also false when kasan is just not initialized yet.
> > > > > What about writing a new helper something like kasan_is_disabled()
> > > > > instead?
> > > >
> > > > The decision of whether to enable KASAN is made early, before the slab
> > > > allocator is initialized (start_kernel -> smp_prepare_boot_cpu ->
> > > > kasan_init_hw_tags vs start_kernel -> mm_init -> kmem_cache_init). If
> > > > you think about it, this needs to be the case for KASAN to operate
> > > > correctly because it influences the behavior of the slab allocator via
> > > > the kasan_*poison* hooks. So I don't think we can end up calling this
> > > > function before then.
> > >
> > > Sounds not bad. I wanted to make sure the value of arch_slab_minaligned()
> > > is not changed during its execution.
> > >
> > > Just some part of me thought something like this would be more
> > > intuitive/robust.
> > >
> > > if (systems_supports_mte() && kasan_arg != KASAN_ARG_OFF)
> > >         return MTE_GRANULE_SIZE;
> > > else
> > >         return __alignof__(unsigned long long);
> >
> > Hi Hyeonggon,
> >
> > We could add and use kasan_hw_rags_requested(), which would return
> > (systems_supports_mte() && kasan_arg != KASAN_ARG_OFF).
> >
> > However, I'm not sure we will get a fully static behavior:
> > systems_supports_mte() also only starts returning proper result at
> > some point during CPU bring-up if I'm not mistaken.
> >
> > Thanks!
> 
> Yes, either way we are going to rely on something that hasn't
> obviously been initialized yet, so I think we should stick with what I
> have since it's used by the rest of the KASAN code as well.
>

Okay then we should anyway rely on something not initialized at early
stage of boot process.

And I don't expect much problem on current version.

Thanks!

> Peter

-- 
Thanks,
Hyeonggon
