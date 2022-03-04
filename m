Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110914CD3C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiCDLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCDLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:51:46 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE5E1AA067
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:50:58 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2dc585dbb02so24721287b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QMKz41by9JRTwwLAdweIX5q4Gx6CkMA+bu/XdMpGwU=;
        b=MHERMiV3OzEHRf+oF3doL0VQqQqulIYbwiwmvY/ysTPJav11DFfh4asKH3SgRWJi5u
         m2uwY1RGax0AJ6EvROBRltNM5lW+1/7lSEVWhl8mFgYw2s+Eef1R79xadJj7r0WzZGDG
         tEqKIDEEn28WvQXYtSLQsFKhUWSiM3fFlEHZQCvb14ZLjsbLESZq87mChm5j69nvUVUP
         HWr4nTzh8pga6taIJuuWJGUzdEEdPPOPqW2iQEtBFR628dhd/tJUf8S7uLGffSTYfD21
         g9JSDqrt8ZBbkhtruGglMmKn9DD9HUl6omKKoKH3CVzAFW65h/spw/oE6qf+W1XqmU04
         Xu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QMKz41by9JRTwwLAdweIX5q4Gx6CkMA+bu/XdMpGwU=;
        b=VZiIt45SzlIhjzUInpSZFbi+5YXhKi7gLu4RM5QN1oqj2XI9SV5Zbbah4cqQOoEulh
         7jMcuxDjVg9mMoMGBPPdX9+lZJzhiQ2MZ5uD8bH2vlOpujoVVRDGQA3LFDqmvrd0NZfG
         SzMpIOno3esKAGiGCOSL0pc6X26lmtH2ws7h3GZUYcU/a1a32oJGU9u0mnBdjuIaI9WS
         uCwaX4n8r/OVPghJ0SB8wwNQxDmDDUfAW/mdlH6NLe2MzZqmPeOzhXffGRzg6qy7FVvN
         q28AWK4Vx97aJD3yJ09AAtV4YwgNWSxjQ9JbTcDk+J5uyU530zCwfd79n6ZbuD5o8yCC
         DEXQ==
X-Gm-Message-State: AOAM5301BTRbTtbwvU6k6A9DivGu2HUn3KrE95UrqnGKcdTojEmcc0q8
        ubYk+Q772ENVDccLFSos7hC68kdpbJxfu9SnbEyirA==
X-Google-Smtp-Source: ABdhPJzNQ8uG33oC4WJoKAcrp2fTVx9Gy+VaRHhWr0JwhE78dBabgNIhxzHRennaCQGr10Ej+e620fnWt1LOUbTblPo=
X-Received: by 2002:a81:9ad7:0:b0:2db:f000:32e7 with SMTP id
 r206-20020a819ad7000000b002dbf00032e7mr16196340ywg.412.1646394657601; Fri, 04
 Mar 2022 03:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
In-Reply-To: <20220304063427.372145-1-42.hyeyoo@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Mar 2022 12:50:21 +0100
Message-ID: <CANpmjNNv8+frHPdvT=0ZNuz5phUy1WRanJ6DkiiNvDTBtFraAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] slab cleanups
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 07:34, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> Changes from v1:
>         Now SLAB passes requests larger than order-1 page
>         to page allocator.
>
>         Adjusted comments from Matthew, Vlastimil, Rientjes.
>         Thank you for feedback!
>
>         BTW, I have no idea what __ksize() should return when an object that
>         is not allocated from slab is passed. both 0 and folio_size()
>         seems wrong to me.

Didn't we say 0 would be the safer of the two options?
https://lkml.kernel.org/r/0e02416f-ef43-dc8a-9e8e-50ff63dd3c61@suse.cz

> Hello, these are cleanup patches for slab.
> Please consider them for slab-next :)
>
> Any comments will be appreciated.
> Thanks.
>
> Hyeonggon Yoo (5):
>   mm/slab: kmalloc: pass requests larger than order-1 page to page
>     allocator
>   mm/sl[au]b: unify __ksize()
>   mm/sl[auo]b: move definition of __ksize() to mm/slab.h
>   mm/slub: limit number of node partial slabs only in cache creation
>   mm/slub: refactor deactivate_slab()
>
>  include/linux/slab.h |  36 ++++++------
>  mm/slab.c            |  51 ++++++++---------
>  mm/slab.h            |  21 +++++++
>  mm/slab_common.c     |  20 +++++++
>  mm/slob.c            |   1 -
>  mm/slub.c            | 130 ++++++++++++-------------------------------
>  6 files changed, 114 insertions(+), 145 deletions(-)
>
> --
> 2.33.1
>
