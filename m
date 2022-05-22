Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEDB530148
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbiEVGhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiEVGhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:37:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1A41637
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:37:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ev18so11348128pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SS4jw3jE67JbDZTZdbjql/HYvYPNQbA1HjLNkPGV220=;
        b=tH30EpVK2h/cCwkIA89339RbASD9rwQYzV2mpWXdJeN1f2qCoMf0aw+zavoo/5g+Im
         szoe9euSzxHQzARGh9ChqS4tUPL1BtXXyt39qSSHWItE4nzGG4KjRDUi2GXIutzNildO
         wswdljmUZs04AM1qJeN5L4dR80f/jFVvYOfM+kYYqWqT1Gn6VtxFyeRCyxWMu8VVi9z4
         rq9SjvSnZ7eSzbzO4IXPUb/T1UV/BGSnSzRpOKGBHaNJq5cqbp7YL4osznVW8jiRpg8k
         RS0QtL1EeAIbWz230hGs/rrOofuOszZl9MPmnt2Ei5ECuQJAasNZlslU1Q5OSQXKqKvf
         Pc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SS4jw3jE67JbDZTZdbjql/HYvYPNQbA1HjLNkPGV220=;
        b=SlxNpga3PjT0BVPQE+rIhsSCh4/4qe2iwx+FCXAlnco3vdL3XY5vUN4mp0bmDHAxFw
         5AWdx+mVJHGEdhoo7wOht/7SyBxYZLoJW2JRlY1lYjFByB2kX+Ao3MwMvhG24jd/rY1z
         rwdnZ9eXA8wXJUqB/7tHCv59UA9xBUjPovs7kGqrzy6P1DC+D1VbEYiBhi8YrQIodUwI
         c7w6n3fSyFBwUjmMvIQYy41U+Hp1X+Et2wdsx0V3GML2wHCNpZgC0fnleaqV4OLbXW+4
         DdUwOt6tbyXc73cBnCAagCiTmh2hmosMBavXk40rZlKMLCeVl13k/gg8iziZ1G3hPCv5
         W5iw==
X-Gm-Message-State: AOAM532agw7EFJAeeryZA5CQoiNJt+gtlj/ESz8ZrJ0N6B5xFLv7Wt3S
        gMLlDfaGhwxowIQ2y8uUGpuLig==
X-Google-Smtp-Source: ABdhPJwae3Oa4ZVDQNKMz6WWiYljvlfeozJ8gfOr2RQVSQpJHBcdMys7MiMD3hnmZRNK5ToinGGffw==
X-Received: by 2002:a17:903:481:b0:161:6392:c350 with SMTP id jj1-20020a170903048100b001616392c350mr17482105plb.17.1653201439206;
        Sat, 21 May 2022 23:37:19 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a660400b001df666ebddesm4677245pjj.6.2022.05.21.23.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:37:18 -0700 (PDT)
Date:   Sun, 22 May 2022 14:37:14 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 1/9] memcg: enable accounting for struct cgroup
Message-ID: <YonaGuR/hB9vJJMw@FVFYT0MHHV2J.usts.net>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <a76dc143-68d9-41f4-81d1-85ec15135b1e@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76dc143-68d9-41f4-81d1-85ec15135b1e@openvz.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 07:37:36PM +0300, Vasily Averin wrote:
> Creating each new cgroup allocates 4Kb for struct cgroup. This is the
> largest memory allocation in this scenario and is epecially important
> for small VMs with 1-2 CPUs.
> 
> Common part of the cgroup creation:
> Allocs  Alloc   $1*$2   Sum     Allocation
> number  size
> --------------------------------------------
> 16  ~   352     5632    5632    KERNFS
> 1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
> 1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
> 1       192     192     10504   (__d_alloc+0x29)
> 2       72      144     10648   (avc_alloc_node+0x27)
> 2       64      128     10776   (percpu_ref_init+0x6a)
> 1       64      64      10840   (memcg_list_lru_alloc+0x21a)
> percpu:
> 1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
> 1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
> 2       12      24      312     call_site=percpu_ref_init+0x23
> 1       6       6       318     call_site=__percpu_counter_init+0x22
> 
>  '+' -- to be accounted,
>  '~' -- partially accounted
> 
> Accounting of this memory helps to avoid misuse inside memcg-limited
> containers.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
