Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498FC4C5451
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiBZHT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiBZHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:19:54 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B910856A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:19:20 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d17so6669139pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/nWriioWhTCDbXhgq6kII6jQkdhme4v3WIf5BYW8Qw=;
        b=Q5YTpZthtvysfBrdzc4noBJ4ma3kSXbtSS7u4D7zltlumAqiWbRQLdRrUaFfbnDgWV
         aT6ci8xd5ZSFJTGxJPXz52yXwg6Bquy6zbSkU59zTFo1VdGLr7HwNTwRrNqnFz7FlxU/
         kW+9ryL+a2zsurlxh52elWSk4oATd49/abO3+H1uHFuF+GIdK34bz6av1HHbejyJPnnZ
         9o+ldoQ/AGtOk/CAi5bw3P+Fq08aAxq+Z19Q/WIUI/CuiATJfaT1l1aDd5xm7PE4p0UD
         PRp7cTR+m3p9raxPGIzccwSsZkNkzt84APNv/b6T9mp89HDuzMDI+kSp1Sfn6kQlInnS
         kkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/nWriioWhTCDbXhgq6kII6jQkdhme4v3WIf5BYW8Qw=;
        b=CRdfDeBzJ736blKnnCfebk2jzNWu/ReTHFpHbhdwR9BehPptWrE0KBtEKwh8vzPD+b
         75orhluEcgGKj1oTC1ctDSgHJQBHB2CGdkUCH7AN87mNtk7cnML2LOX/r6Q0AMXO52dV
         BLeWoEUR7r+6gP5FBSNEpkJjX2/Ek0C6J0nUkGLoib1kwZucDcx+l7bN7P6il7PVI2Yj
         sREWryUxZdI1nFs+vJvVRImhN8lrrADTnavlcb92w0hMOYoke39ZTqJhW62NR2v0CFQo
         W3MxrObmI4sVQ1V30lPXfvf2DwLerM40hBn+r+GuOK3JBI/wPsicUYH6UmiNpsIzYur6
         JDWw==
X-Gm-Message-State: AOAM530J2jD/fXP99+xXsuK6s+TYHelhzi4NFZ1e7oKE0Ad8+j2Ops2i
        6uJfwJmT6ew/yxachnrKbBY=
X-Google-Smtp-Source: ABdhPJxbGmLtUJ+pAMwAQGsx9xQgcS6vz8B1z1/Fcn+J1vyx7yy603Q5p0jypvIbXgnMXtHaCMuDnw==
X-Received: by 2002:a63:7d5:0:b0:374:5575:8773 with SMTP id 204-20020a6307d5000000b0037455758773mr9166160pgh.160.1645859960339;
        Fri, 25 Feb 2022 23:19:20 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a00162200b004e0a8002697sm5347933pfc.123.2022.02.25.23.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 23:19:19 -0800 (PST)
Date:   Sat, 26 Feb 2022 07:19:14 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Message-ID: <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225180318.20594-1-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
> Hi,
> 
> this series combines and revives patches from Oliver's last year
> bachelor thesis (where I was the advisor) that make SLUB's debugfs
> files alloc_traces and free_traces more useful.
> The resubmission was blocked on stackdepot changes that are now merged,
> as explained in patch 2.
> 

Hello. I just started review/testing this series.

it crashed on my system (arm64)

I ran with boot parameter slub_debug=U, and without KASAN.
So CONFIG_STACKDEPOT_ALWAYS_INIT=n.

void * __init memblock_alloc_try_nid(
                        phys_addr_t size, phys_addr_t align,
                        phys_addr_t min_addr, phys_addr_t max_addr,
                        int nid)
{
        void *ptr;

        memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
                     __func__, (u64)size, (u64)align, nid, &min_addr,
                     &max_addr, (void *)_RET_IP_);
        ptr = memblock_alloc_internal(size, align,
                                           min_addr, max_addr, nid, false);
        if (ptr)
                memset(ptr, 0, size); <--- Crash Here

        return ptr;
}

It crashed during create_boot_cache() -> stack_depot_init() ->
memblock_alloc().

I think That's because, in kmem_cache_init(), both slab and memblock is not
available. (AFAIU memblock is not available after mem_init() because of
memblock_free_all(), right?)

Thanks!

/*
 * Set up kernel memory allocators
 */
static void __init mm_init(void)
{
        /*
         * page_ext requires contiguous pages,
         * bigger than MAX_ORDER unless SPARSEMEM.
         */
        page_ext_init_flatmem();
        init_mem_debugging_and_hardening();
        kfence_alloc_pool();
        report_meminit();
        stack_depot_early_init();
        mem_init();
        mem_init_print_info();
        kmem_cache_init();
        /*
         * page_owner must be initialized after buddy is ready, and also after
         * slab is ready so that stack_depot_init() works properly
         */)

> Patch 1 is a new preparatory cleanup.
> 
> Patch 2 originally submitted here [1], was merged to mainline but
> reverted for stackdepot related issues as explained in the patch.
> 
> Patches 3-5 originally submitted as RFC here [2]. In this submission I
> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
> be considered too intrusive so I will postpone it for later. The docs
> patch is adjusted accordingly.
> 
> Also available in git, based on v5.17-rc1:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
> 
> I'd like to ask for some review before I add this to the slab tree.
> 
> [1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
> [2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
> 
> Oliver Glitta (4):
>   mm/slub: use stackdepot to save stack trace in objects
>   mm/slub: aggregate and print stack traces in debugfs files
>   mm/slub: sort debugfs output by frequency of stack traces
>   slab, documentation: add description of debugfs files for SLUB caches
> 
> Vlastimil Babka (1):
>   mm/slub: move struct track init out of set_track()
> 
>  Documentation/vm/slub.rst |  61 +++++++++++++++
>  init/Kconfig              |   1 +
>  mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
>  3 files changed, 162 insertions(+), 52 deletions(-)
> 
> -- 
> 2.35.1
> 
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
