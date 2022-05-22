Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED4C530175
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbiEVHFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbiEVHFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:05:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E341FA6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 00:05:37 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h9so2937321pgl.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tjn5cOhPCJTjLCzK5W9G1YBEVUEJ+0rPrDGESwiPuzc=;
        b=6ErhHO7dbpgMH9Zx1cY/WLrWxTcKKKUhBSAT93UR5AofH7RZKOvRzTXakMcnc2c3dv
         aXUDK/yYpi8AmTnCO3FonlmbFvIu1zOwNVQl+h4ZQJxvAV/rtJW5HzM8FMCpXHfIzZVX
         WWdhwSOi8CcGHFD4pvZgcqQH6MaQx4gVhsNsVunDicjqZHhEHiz0ZLYEH7l7cK2MJlnH
         zR6ehqjLoecSj/Kqxbuqv36LJW8RmENI3lcHeIpu13z0t4bYtOOHnElmYnW2AWCw0ud5
         NzPchRJnnw0c9EbC7vo6XwrEdMb1Vs61l0PZ9h5Z0ReOFO28/hjFsqXBtMr99F/WT0/6
         RyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjn5cOhPCJTjLCzK5W9G1YBEVUEJ+0rPrDGESwiPuzc=;
        b=rkscDtalJGkMwzWwviEmLA2HOyqPRKniKE91fxEU15lyxBf3A8X4m1VWqqtuoaRgw9
         ritswmfavZBuHnvrqSVFhrtSy+Oc/BN24D8F+jys2j98iLMbM4nRBElIBoJl8lFGo7nt
         lWVlYEiS1Dyy20EnYheBNj2h8vaAsonQaO3BQSeMcrZD2ayJYY/7IpMBn9INzL+e923g
         Y0GYgRrJ0oDbewVmA7QIJWgyA5I/mA0yHxMKvH1Ua7VyjlTzsA8+kB1njm7I8CL3W0fs
         30LH7WL1WfXIPMrrpQ5sl9ktCCApgtqYme/54LQns2M6b1C2UcOW1Nixe/sivNOYXw8E
         h8lA==
X-Gm-Message-State: AOAM530JKtJSUcONBKidwlMPUdWI5b0lVTtsDvRDUcLl7BT3NORNPKnh
        bvlg2HYXjtyCwNWf2kJQ82jr0A==
X-Google-Smtp-Source: ABdhPJw5cRdHzRZx9lTBuuKwc2V4JIXzSWocp2ibl1WRe0b2e2nweOStW9WpfmJBpS3lWWsSkfZ55w==
X-Received: by 2002:a63:63c7:0:b0:3f5:faf8:c45e with SMTP id x190-20020a6363c7000000b003f5faf8c45emr15856429pgb.234.1653203136578;
        Sun, 22 May 2022 00:05:36 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b0015e8d4eb2b4sm2575828pla.254.2022.05.22.00.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 00:05:36 -0700 (PDT)
Date:   Sun, 22 May 2022 15:05:33 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 1/6] mm: memcontrol: introduce mem_cgroup_ino() and
 mem_cgroup_get_from_ino()
Message-ID: <YongvYP26K2hZ3Sf@FVFYT0MHHV2J.usts.net>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-2-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509183820.573666-2-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:38:15AM -0700, Roman Gushchin wrote:
> Shrinker debugfs requires a way to represent memory cgroups without
> using full paths, both for displaying information and getting input
> from a user.
> 
> Cgroup inode number is a perfect way, already used by bpf.
> 
> This commit adds a couple of helper functions which will be used
> to handle memcg-aware shrinkers.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memcontrol.h | 21 +++++++++++++++++++++
>  mm/memcontrol.c            | 23 +++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fe580cb96683..a6de9e5c1549 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -831,6 +831,15 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
>  }
>  struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
>  
> +#ifdef CONFIG_SHRINKER_DEBUG
> +static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
> +{
> +	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
> +}
> +
> +struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
> +#endif
> +
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
>  	return mem_cgroup_from_css(seq_css(m));
> @@ -1324,6 +1333,18 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_SHRINKER_DEBUG
> +static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
> +static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
>  	return NULL;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 04cea4fa362a..e6472728fa66 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5018,6 +5018,29 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  	return idr_find(&mem_cgroup_idr, id);
>  }
>  
> +#ifdef CONFIG_SHRINKER_DEBUG
> +struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
> +{
> +	struct cgroup *cgrp;
> +	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg;
> +
> +	cgrp = cgroup_get_from_id(ino);
> +	if (!cgrp)
> +		return ERR_PTR(-ENOENT);
> +
> +	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> +	if (css)
> +		memcg = container_of(css, struct mem_cgroup, css);
> +	else
> +		memcg = ERR_PTR(-ENOENT);
> +
> +	cgroup_put(cgrp);

I think it's better to use css_put() here since the refcount is get
via cgroup_get_e_css() which returns a css struct.

Thanks.

> +
> +	return memcg;
> +}
> +#endif
> +
>  static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  {
>  	struct mem_cgroup_per_node *pn;
> -- 
> 2.35.3
> 
> 
