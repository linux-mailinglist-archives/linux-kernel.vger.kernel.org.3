Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3874E19BC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 06:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiCTFPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 01:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiCTFPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 01:15:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3145AC7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 22:13:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n15so10162426plh.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EAirw9TzH9yRiO3FVLxnQmXcScVQSG59Av9LfC7vTXM=;
        b=d/rEb3FNRzgIWM4dhJiriJjljFDt/dGzflV5Zhp1t/CFJ+ZRhYbOZJw6SdkAod0aNd
         iI3UZr6lF4/1Gw1UiVR9qU1YaiAVxghmi7lzQ7bKJ/AICvj/Hcpvm8gFf/cnrwDADEI0
         yWrYIhJti3eOarVWQEJKMvgTIh1cEQw2S2GXhnL2ShGdwBBYwHefNjrBKjNb1DEayVqd
         v34EwUYh94U/GpBUQOL2y/6wMK+4y5zZ4AQxwkw9YufwaRXudj+v7CtYYELZyIxED1z2
         0pd2JxpEhZ3424XQZi3Iht42VZ4v0nLtfK8TTdUxe9w6hUP1WPtA9ftPT+rrpiUfZNWn
         w+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EAirw9TzH9yRiO3FVLxnQmXcScVQSG59Av9LfC7vTXM=;
        b=JnlfShrbTxmiRqA/NS3GZfc67cKVELpeh20OMuxhNj0tLawhtPdEfpaxPShzWbNuBt
         Jxo20hBChIhHbgS1qXPnW3EsqC0tDFj8IsFUJSA6pNqYHRvUIagrFcjyYRtHTZHPskOd
         Xq6GShiVNzt2XRWM1EnQHnole0PETWrXdBKev+2QrMfEC6o356wpn2ilZAB1dL5fjdCO
         o+1heraP9kgoZFa0IpUToVI61zl1HEYtpELSG6/yBtuaoSLkVNGiHley2mPrOxXIDEAP
         xd92NbDoBGeCWzSJWUx5JIUQA2wUW+b5niOPTM3WaOIfaoX454UjC1dWMrv0E4sKm2Kc
         +FXw==
X-Gm-Message-State: AOAM531fe3uNxCCSCEI6KDNgn2jQD1OF55nG7EYIXcLvsOUZfndxAeUr
        iwb57AZ72z9pENtxcarufnc=
X-Google-Smtp-Source: ABdhPJzVaRj2iSzWfKS5IqverOFzfEb1xE3rhcpwtEGhja45tyWPl9GYzNoY0aRnozs1wD4ttnoc2A==
X-Received: by 2002:a17:90b:388e:b0:1bf:49ca:2fc0 with SMTP id mu14-20020a17090b388e00b001bf49ca2fc0mr29994516pjb.226.1647753223518;
        Sat, 19 Mar 2022 22:13:43 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b001c701e0a129sm505028pjb.38.2022.03.19.22.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 22:13:42 -0700 (PDT)
Date:   Sun, 20 Mar 2022 05:13:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 1/2] mm, slub: change percpu partial accounting from
 objects to pages
Message-ID: <Yja4AlOHkpcKLu59@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20211012134651.11258-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012134651.11258-1-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vlastimil. I know it's too late to review, but I want to give my
opinion here.

On Tue, Oct 12, 2021 at 03:46:50PM +0200, Vlastimil Babka wrote:
> With CONFIG_SLUB_CPU_PARTIAL enabled, SLUB keeps a percpu list of partial
> slabs that can be promoted to cpu slab when the previous one is depleted,
> without accessing the shared partial list. A slab can be added to this list
> by 1) refill of an empty list from get_partial_node() - once we really have to
> access the shared partial list, we acquire multiple slabs to amortize the cost
> of locking, and 2) first free to a previously full slab - instead of putting
> the slab on a shared partial list, we can more cheaply freeze it and put it on
> the per-cpu list.
>

Right. This is how we put slabs to percpu partial list. 

> To control how large a percpu partial list can grow for a kmem cache,
> set_cpu_partial() calculates a target number of free objects on each cpu's
> percpu partial list, and this can be also set by the sysfs file cpu_partial.
> 
> However, the tracking of actual number of objects is imprecise, in order to
> limit overhead from cpu X freeing an objects to a slab on percpu partial
> list of cpu Y.
>
> Basically, the percpu partial slabs form a single linked list,
> and when we add a new slab to the list with current head "oldpage", we set in
> the struct page of the slab we're adding:
> 
> page->pages = oldpage->pages + 1; // this is precise
> page->pobjects = oldpage->pobjects + (page->objects - page->inuse);
> page->next = oldpage;
> 
> Thus the real number of free objects in the slab (objects - inuse) is only
> determined at the moment of adding the slab to the percpu partial list, and
> further freeing doesn't update the pobjects counter nor propagate it to the
> current list head. As Jann reports [1], this can easily lead to large
> inaccuracies, where the target number of objects (up to 30 by default) can
> translate to the same number of (empty) slab pages on the list. In case 2)
> above, we put a slab with 1 free object on the list, thus only increase
> page->pobjects by 1, even if there are subsequent frees on the same slab. Jann
> has noticed this in practice and so did we [2] when investigating significant
> increase of kmemcg usage after switching from SLAB to SLUB.

Indeed. SLUB could grow percpu partial list too much before this patch,
especially in case 2). number of objects being equal to number of slabs
is too imprecise.

> While this is no longer a problem in kmemcg context thanks to the accounting
> rewrite in 5.9, the memory waste is still not ideal and it's questionable
> whether it makes sense to perform free object count based control when object
> counts can easily become so much inaccurate. So this patch converts the
> accounting to be based on number of pages only (which is precise) and removes
> the page->pobjects field completely. This is also ultimately simpler.
> 
> To retain the existing set_cpu_partial() heuristic, first calculate the target
> number of objects as previously, but then convert it to target number of pages
> by assuming the pages will be half-filled on average. This assumption might
> obviously also be inaccurate in practice, but cannot degrade to actual number of
> pages being equal to the target number of objects.

I have to agree that this half-filled assumption works pretty well and
I believe the too-long-partial-list problem has gone. we're controlling
its length clearly after this patch.

But my one concern here is that actual number of objects in
percpu partial list can be decreased when we cannot allocate high order pages.

e.g.) oo_order(s->oo) is 3 and we can only allocate order-2 page,
it can be shortened 2 times in worst case because the accounting logic
assumes order of all slab in the percpu partial list is oo_order(s->oo).

I think using object based accounting, and assuming every slab is
half-filled would be more consistent when the system is highly
fragmented.

Thoughts?

-- 
Thank you, You are awesome!
Hyeonggon :-)
