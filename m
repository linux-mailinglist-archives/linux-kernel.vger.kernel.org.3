Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DED5AC40B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIDK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiIDK65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:58:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E03DF2E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 03:58:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u22so5956099plq.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Y1gR7e1PQuUOnfe4Q+PhjAwNNQGKAewl720r1GJyD2s=;
        b=VV7shxrBU77p+TcGyUZBmHkujuebHJbChMeEuyKmGFS9napMdsAmE8z9PqVwNaeFn7
         Z+g2ZI2bIDwX25TK1zG0KvNZd6u1Y52n8iNTHX4ngRozxSyUx0Wlh7fTkiU1MX8UNivI
         n58rwj1tlMQ+l7NJZp37TFyHbYA9DDa8MEaFW+8qT6lSNL8R+pw0FYcvWMb4ir/327pc
         UM5PappO32ZVumnu9NGZDn1P2rFmJoEYObwfGvrQwxDPeZqiaueh0P9PXIWXFGbz9JQC
         LAJnA0jQNczL4CQHdMem5IovYJM5Xyc+sBy5X40gvxZAyKNFGIHvqcKT0av+sRu7R0fa
         5EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Y1gR7e1PQuUOnfe4Q+PhjAwNNQGKAewl720r1GJyD2s=;
        b=yaai3uyDGO98D6Z9grr8cRnGbNktvX8jUsVganheNxPGeVQqGkNQg7xxxeR73uCYpq
         K7RrvC5KR65gYnDLApxlK50ca6B/v3CVMWmoC3WioKdMc4qTR/qCINbInfWBNBLQFJ9t
         V0jBnorCprNAXCUsbKUk2WTAngVsxRer7nuqIcoE9zr4BYWK7JcMIk9CGXUcW6Ul9Yrs
         tokWt/+h+mNUjXXP2YlyAjHIPtT64i/6QaGd00ka9dIZR5rfpevE+QFrokDF/J51kfT0
         9TlMNBc2y8CVI3eUHF9yq/Q+rkv7s9ZMJzSb0YWM/wxxqqELhNDFX17WanSFeVtS6C3V
         Nceg==
X-Gm-Message-State: ACgBeo2no5SzXOJ5+OaEoPNe7r18bJRQIyiLYDBitpPMGHLPzReDCjEj
        ebV2LTXcR10gHwnItqy3ZIo=
X-Google-Smtp-Source: AA6agR43WivJ5n9DybEFsqFAJyKm77SN9zl396bmwfcC1aJPgmJH9nzc64wRma1HfcVBC3Q1bKxR+A==
X-Received: by 2002:a17:903:2441:b0:174:7f19:41e3 with SMTP id l1-20020a170903244100b001747f1941e3mr37309073pls.79.1662289135877;
        Sun, 04 Sep 2022 03:58:55 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b0016dbaf3ff2esm5169078pls.22.2022.09.04.03.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 03:58:54 -0700 (PDT)
Date:   Sun, 4 Sep 2022 19:58:49 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxSE6XmHl3itv4JY@hyeyoo>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx>
 <YxRp5uz9KSY0S9id@hyeyoo>
 <YxRzCX8WqOv3KESJ@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxRzCX8WqOv3KESJ@feng-clx>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 05:42:33PM +0800, Feng Tang wrote:
> On Sun, Sep 04, 2022 at 05:03:34PM +0800, Hyeonggon Yoo wrote:
> [...]
> > > > 
> > > > This patch is okay but with patch 4, init_object() initializes redzone/poison area
> > > > using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
> > > > Why not do it in init_object() in the first time?
> > > > 
> > > > Also, updating redzone/poison area after alloc_single_from_new_slab()
> > > > (outside list_lock, after adding slab to list) will introduce races with validation.
> > > > 
> > > > So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.
> > > 
> > > Yes, this makes sense, and in v3, kmalloc redzone/poison setup was
> > > done in alloc_debug_processing() (through init_object()). When
> > > rebasing to v4, I met the classical problem: how to pass 'orig_size'
> > > parameter :)
> > > 
> > > In latest 'for-next' branch, one call path for alloc_debug_processing()
> > > is
> > >   ___slab_alloc
> > >     get_partial
> > >       get_any_partial
> > >         get_partial_node
> > >           alloc_debug_processing
> > > 
> > > Adding 'orig_size' paramter to all these function looks horrible, and
> > > I couldn't figure out a good way and chosed to put those ops after
> > > 'set_track()'
> > 
> > IMO adding a parameter to them isn't too horrible...
> > I don't see better solution than adding a parameter with current implementation.
> > (Yeah, the code is quite complicated...)
> > 
> > It won't affect performance to meaningful degree as most of
> > allocations will be served from cpu slab or percpu partial list. 
> 
> Thanks for the suggestion! I'm fine with it and just afraid other
> developers may dislike the extra parameter. 
> 
> The race condition you mentioned is a valid concern, and I have thought
> about it, one way is moving the set_orig_size() after the redzone/poision
> setup, and in 'check_object()' we can detect whether the 'orig_size' is
> set, and skip that check if it's not set yet. As the manual validate_slab
> triggered from sysfs interface is a rare debug activity, I think skipping
> one object shouldn't hurt much.

That will require smp_wmb()/smp_rmb() pair to make sure that
effects of set_orig_size() to be visible after redzone/poison setup.

Isn't it simpler to add a parameter?

> 
> Thanks,
> Feng
> 
> > -- 
> > Thanks,
> > Hyeonggon
> > 

-- 
Thanks,
Hyeonggon
