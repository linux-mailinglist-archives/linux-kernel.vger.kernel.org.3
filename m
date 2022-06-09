Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE45443DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 08:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiFIGex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 02:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbiFIGef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 02:34:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741F3A73B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 23:34:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e24so20598635pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 23:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6j98NSoKnUr9VnwQS2PEzCXDhqhV9EXqhkIDqAKCugY=;
        b=FIHP8e4looCFOxHpTEaOYxAwDT9jQDecl2TPThxKGZfkp5wuldi/YzCt9hjYONbF1Q
         dC/ttLvcJqiAlMYmaJWMFKrwU+YLAvTbL4Iw/0c7p21w2/hT1vTfP8rclmGQ2kMTdNpj
         8/nkmty3vfxS1A1MxmWbd6ZvJjBC9yLePbi6vzs6ILJSHNpBESBXGzrokNkDrRUFbTdP
         gkpBc1RE5I+7B2Xk8creW4U0N2Jgh9FkctcUiNpkmY9Yxz/vQ5a5IEFYIHcflonzfMxS
         GUYtJD1uNxpSuHYlgedXXnjYrm2KbRa/adn9aeyebPZdwXVufK1b90Af5uIsD2vTewvQ
         a6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6j98NSoKnUr9VnwQS2PEzCXDhqhV9EXqhkIDqAKCugY=;
        b=UcLsrI7axoZLoZvU0bxaC91EoWAb4vaCEFpKjgDz5tnP8ZQiNsgocs0WQ/m+RI2gzI
         7G7+3MWm0pdeW3j7dkYJfbrJLFAcFf8XZNXE+9+pDVvafB0I7/Bf0jOhSZ5Y1xCRkbPR
         4ZMPU+biHnc0phrTDJi5HQE4B+oGLK9Kt9bPyvId/GKqzT7ertUAKDGnAGjGwzWVGy+z
         RqtntmkoJTAJwTRxGtQ60XXh+q9zYCF7vHtR8VsrZpPYrh7HTK6LyuPqd9FEBe3fhQQL
         MWEEhfa/vFMCX3rCP6CBqYxG7U9JqTJCYEcZswZHVcoHo1Nmbu+U/iaJWqyLOeweQ0DT
         FS0w==
X-Gm-Message-State: AOAM532P/ak2zLxy/c2w5lt1LXYo5H2X82aH0f6o00P5j59NqE8wTKik
        Th8+k2DAGIj9MV6UAbaynZjuXw==
X-Google-Smtp-Source: ABdhPJzr1mZzXcfCMQrT0ISITKrFNsB2jvroULWWEPJkOrwyOfKOn7ksOdfXBq5UD59hmzwFDap5PQ==
X-Received: by 2002:a17:902:f353:b0:167:7bc1:b1b9 with SMTP id q19-20020a170902f35300b001677bc1b1b9mr19710778ple.117.1654756468878;
        Wed, 08 Jun 2022 23:34:28 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 187-20020a6204c4000000b0051bc721b838sm14553742pfe.188.2022.06.08.23.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 23:34:28 -0700 (PDT)
Date:   Thu, 9 Jun 2022 14:34:23 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH v2] mm: slab: optimize memcg_slab_free_hook()
Message-ID: <YqGUb0s5Jw5EgKne@FVFYT0MHHV2J.usts.net>
References: <20220429123044.37885-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429123044.37885-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:30:44PM +0800, Muchun Song wrote:
> Most callers of memcg_slab_free_hook() already know the slab,  which could
> be passed to memcg_slab_free_hook() directly to reduce the overhead of an
> another call of virt_to_slab().  For bulk freeing of objects, the call of
> slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
> Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
> those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
> freeing in slab_free().
> 
> Move the calling site of memcg_slab_free_hook() from do_slab_free() to
> slab_free() for slub to make the code clearer since the logic is weird
> (e.g. the caller need to judge whether it needs to call
> memcg_slab_free_hook()). It is easy to make mistakes like missing calling
> of memcg_slab_free_hook() like fixes of:
> 
>   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
>   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> 
> This optimization is mainly for bulk objects freeing.  The following numbers
> is shown for 16-object freeing.
> 
>                            before      after
>   kmem_cache_free_bulk:   ~430 ns     ~400 ns
> 
> The overhead is reduced by about 7% for 16-object freeing.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Hi Vlastimil,

Wolud you mind picking it up? I did not see this patch on the
slab tree.

Thanks.

