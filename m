Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2624F20EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiDECx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiDECxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:53:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA331A29F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:01:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t13so9796497pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XCPmRc0IVgYgnGswAlG4yXz+KuFMoJ3P6+aO8i17Nyw=;
        b=JegdvKFJkQly7ZyOveDWGt3k2Kyk57pEOEbrjKjqlmrb8+N+YI46tYuhBKqNuRYMro
         9/zY4m8gN/H7O3MEMJvKvagY3bW6+TAP61AK+EbqU+iunqW56CxOIdlXHYEePfaLXvHo
         fAmn8QSljckU4vKvpTPybkSn8jmlyKRYfzgTo3NOlY86VWS27hx7ohejcDgv28D1xnVr
         QJS6lZE4K8+HG3gDQYEGqHFnqwP1EDMJkpvm9ZHYEDMeeJbT45cpU72jDzpeqMHW8PzC
         9KoInl5KIBPSzgpVM0H3ep5cUrlvGTHSxLDMjqzVi/UH4VxEDup/tGbViIWle/Lr4I0L
         t3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCPmRc0IVgYgnGswAlG4yXz+KuFMoJ3P6+aO8i17Nyw=;
        b=gp6zM+yOHAdL/Ogm05curz2IRkzjNCP/p9hOhuXfGmRhEE5tuKJ5MEdgTpQGi7eCxY
         Ye+leXRgmK/9l0GZnG9G4K8NMq5XI883x+VBMRfjZkmPipU97/TSBvREgU8Rq18pxmbZ
         Rq+28wDfISVS7xaQ3bABmxXmM5Lcr5qh9IHHMEQWO7+il41LX0dHyLT1KKW0EaNfYrub
         wOvbrAKD0zv3s3KiBkOODKV0SRHwE8IAYG6cunCv0jTgDeKaN63j/VtJy2pRioPJ7rFR
         Qyczu7aG9jk9/72l1sR2nvwjSpV0GIhV6dijdGoR1qnPuKm9KxYzf7xFUKEJ9xRrQHn3
         za8w==
X-Gm-Message-State: AOAM531DZ916yep6jGlAibn/yfvuNP35JCQ5bt9qg7JV1xkTNnZuVvaS
        MHGYFyW3YWZ88S/NPAUy//c=
X-Google-Smtp-Source: ABdhPJx8ODqukr4ThTQP2Zolc7rN01PScQwudBUJ4+CZTh017i28ntS57/D4l+okojym+X/7MmPsCg==
X-Received: by 2002:a63:b24b:0:b0:398:9894:b8be with SMTP id t11-20020a63b24b000000b003989894b8bemr947415pgo.108.1649124066161;
        Mon, 04 Apr 2022 19:01:06 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id q27-20020aa7961b000000b004fdf7a4d49esm6458763pfg.170.2022.04.04.19.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 19:01:05 -0700 (PDT)
Date:   Tue, 5 Apr 2022 11:00:58 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zqiang <qiang.zhang@windriver.com>, linux-mm@kvack.org
Subject: Re: [mm/slub] 555b8c8cb3:
 WARNING:at_lib/stackdepot.c:#stack_depot_fetch
Message-ID: <Ykui2prpzkMvaWBa@hyeyoo>
References: <20220323090520.GG16885@xsang-OptiPlex-9020>
 <20220324095218.GA2108184@odroid>
 <YkcfNjZJSXNsAlLt@hyeyoo>
 <YkpgjgM/aSXd29uj@hyeyoo>
 <Ykqn2z9UVfxFwiU+@elver.google.com>
 <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
 <CANpmjNMupGGbTDD-ZEY=acTbqguvWgLzb1ZVRbG9TyuF50Ch+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMupGGbTDD-ZEY=acTbqguvWgLzb1ZVRbG9TyuF50Ch+Q@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 05:18:16PM +0200, Marco Elver wrote:
> On Mon, 4 Apr 2022 at 16:20, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 4/4/22 10:10, Marco Elver wrote:
> > > On Mon, Apr 04, 2022 at 12:05PM +0900, Hyeonggon Yoo wrote:
> > > (Maybe CONFIG_KCSAN_STRICT=y is going to yield something? I still doubt
> > > it thought, this bug is related to corrupted stackdepot handle
> > > somewhere...)
> > >
> > >> I noticed that it is not reproduced when KASAN=y and KFENCE=n (reproduced 0 of 181).
> > >> and it was reproduced 56 of 196 when KASAN=n and KFENCE=y
> > >>
> > >> maybe this issue is related to kfence?
> >
> > Hmm kfence seems to be a good lead. If I understand kfence_guarded_alloc()
> > correctly, it tries to set up something that really looks like a normal slab
> > page? Especially the part with comment /* Set required slab fields. */
> > But it doesn't seem to cover the debugging parts that SLUB sets up with
> > alloc_debug_processing(). This includes alloc stack saving, thus, after
> > commit 555b8c8cb3, a stackdepot handle setting. It probably normally doesn't
> > matter as is_kfence_address() redirects processing of kfence-allocated
> > objects so we don't hit any slub code that expects the debugging parts to be
> > properly initialized.
> >
> > But here we are in mem_dump_obj() -> kmem_dump_obj() -> kmem_obj_info().
> > Because kmem_valid_obj() returned true, fooled by folio_test_slab()
> > returning true because of the /* Set required slab fields. */ code.
> > Yet the illusion is not perfect and we read garbage instead of a valid
> > stackdepot handle.
> >
> > IMHO we should e.g. add the appropriate is_kfence_address() test into
> > kmem_valid_obj(), to exclude kfence-allocated objects? Sounds much simpler
> > than trying to extend the illusion further to make kmem_dump_obj() work?
> > Instead kfence could add its own specific handler to mem_dump_obj() to print
> > its debugging data?
> 
> I think this explanation makes sense!  Indeed, KFENCE already records
> allocation stacks internally anyway, so it should be straightforward
> to convince it to just print that.
>

Thank you both! Yeah the explanation makes sense... thats why KASAN/KCSAN couldn't yield anything -- it was not overwritten.

I'm writing a fix and will test if the bug disappears.
This may take few days.

Thanks!
Hyeonggon

> Thanks,
> -- Marco
