Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA3573265
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiGMJ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiGMJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:26:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94CCEF9DA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:26:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so2693006pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vQEG1g5aM3Tjy/jRcXsLvnY4WNvgT+rmdCcMcFykq/0=;
        b=JUlmieSVVqSEZ9LhE/KCwIwkX6WoOfcIzrg+8if5/LvHSy0O7VM3vl1JErx0I1YeZH
         eGBjdCY2Lb8Su/nARyD5liPLOZCf+r3VXv7niv6gASrPeoBDE6Ahc0n37LM+w/1doTc6
         n2uPmlBcUBQ0VqfZU4d1/XYvQaSTcYGiKwmKyBRNZS/ozfZT1TovE+vhkpOp/CLFLx86
         aPZm207VqtXAM4aUP3wXY4yMiNZ5bHRtiFgr+hcw/aad3AHDZSCEyzVcO2pW2eCEpgJt
         jRjqPqpYqrLfGVq1fbdkr2TS8Ple8gVywscsXBjn7O79Z2B0UtKmw5ochTRIxwr8r4D6
         wqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQEG1g5aM3Tjy/jRcXsLvnY4WNvgT+rmdCcMcFykq/0=;
        b=NLZT/ZfPffMkrEcwyQRWFcpo0xvUkvR2U9z3HWe2Ps4Hsh70lzLrB3mgiqIwSsvphR
         mPSLYL0E4ksnBdXdz3Aq9tKdjuy8N431Pbg1tPeiF8o9IJ6KWUO+bsT5QF8a0STQJqhM
         fTWT7i33IsTTpGGoCIpueF3hMOliPYdLZy9dPQ6kHiRplXFfI5frsh+3nlaJeVT50HwE
         r1yzCzs/R5v5xyngYEDV3GVvGGruKwbhEl8tR2IqTgZHU4p1OG9t/mOBsnBWTEh9h+Bw
         wAV1GX7k0efclR7/C2G7nI8W86qEZxIobmaxFVdL4Z4Xu1Och7o8K1FHasRNTq/Stku4
         Dd+Q==
X-Gm-Message-State: AJIora+7J7jhqfXJNObCClw9dc42GFPerI2777ZIA1RPDcBRZlHyaLWK
        5IfVuSJT6LpmS0oQp0iKOEU=
X-Google-Smtp-Source: AGRyM1tsuoRCK6Jp4dz6GTmxO1McHEIzj8GM1jydMubRZRPWegfaivwvP6g3pGtHMWu32032Q4FOjQ==
X-Received: by 2002:a17:90b:38ce:b0:1ef:c5bd:e2bd with SMTP id nn14-20020a17090b38ce00b001efc5bde2bdmr2873563pjb.149.1657704365217;
        Wed, 13 Jul 2022 02:26:05 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-77-58-189.ap-northeast-1.compute.amazonaws.com. [35.77.58.189])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b001677fa34a07sm3693091ple.43.2022.07.13.02.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 02:26:04 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:25:59 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in
 __ksize()
Message-ID: <Ys6Pp6ZPwJTdJvpk@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-17-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 05:13:44PM +0200, Christoph Lameter wrote:
> On Tue, 12 Jul 2022, Hyeonggon Yoo wrote:
> 
> > __ksize() returns size of objects allocated from slab allocator.
> > When invalid object is passed to __ksize(), returning zero
> > prevents further memory corruption and makes caller be able to
> > check if there is an error.
> >
> > If address of large object is not beginning of folio or size of
> > the folio is too small, it must be invalid. Return zero in such cases.
> 
> Why return 0 if there is an error and why bother the callers with these
> checks. BUG()?

I thought BUG should be used when there is no other solution.

> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 1f8db7959366..0d6cbe9d7ad0 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1013,8 +1013,12 @@ size_t __ksize(const void *object)
> >
> >  	folio = virt_to_folio(object);
> >
> > -	if (unlikely(!folio_test_slab(folio)))
> > +	if (unlikely(!folio_test_slab(folio))) {
> > +		if (WARN_ON(object != folio_address(folio) ||
> > +				folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
> 
> Hmmm... This may change things a bit. Before this patch it was possible to
> determine the storage size of order-0 pages using ksize(). Now this
> returns 0?
> 
> I guess this is an error since the order-0 page cannot come from slab
> allocations.

comment in ksize() says:
	"The caller must guarantee that objp points to a valid object
	previously allocated with either kmalloc() or kmem_cache_alloc()."

It should not be used on order-0 page that is not allocated from slab. No?
