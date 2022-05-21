Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351F852FF9D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 23:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346629AbiEUVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 17:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbiEUVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 17:36:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06462CE11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:36:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h186so10540496pgc.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ovbs7SznoJE1sVxkoT4HN7MF5cA4tFBx5ooIOKpQ5rI=;
        b=HtMT4pCc5uH63EO6XlkrHpLrHOUT2F/DcCheEuURYYK0r2GEGrJzb/3oD1DgUHGgbS
         DTZvc7agujFsGc8vMopNkC6FjfuUA9MJkZ1FHzoiTFJd0SVGVTNnT9W5ykihOzFgtLAr
         S0EWv4ixlw92AThV7s6hF6xrQQfmjkH1fSqJgR9tQztQtG03xBmGq0UWxi5Sdtkykpri
         hadLh08mZRRFMRw+n0UWus3QJC6eVtN5cCmJjI/1F727JI4G0yv5iVqGWpauiYPRlPlx
         kfbkguPiTMODEoDYwaJS3f5Na9KWMUkMa3aNy8bN+imxqdX4Zat5tfu6XlyOAvSHZtLF
         apBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ovbs7SznoJE1sVxkoT4HN7MF5cA4tFBx5ooIOKpQ5rI=;
        b=cAuJ7wCGZeiA+DmG5ct43hM1Xs+x1/Pdl7VvO2uf2FyBzHnEftZGeLEkTtrOfll9ca
         SggBaU8QdoRqSExli1DRF6/uaZTYzJ2mv6tJgdNWhOehMtqhP3xR60FxwAfR5m+Dy9Qm
         FEs6B4ycBUDsvoarznFIfryqIL3OjMgOBTgaHxaoKj1Utk/O8a3cQnZtAoPFcWDGtdPR
         SBVfbBO0jUv39bxjc1TIw0P9vevsNFzLwIBpXx1QF+S+No/8gKCct1/lHimXEjrWrOGd
         05Zx5FnLWmIcwBJXsrzV3A+vH9cPzva2zpjbeNbvikny5s6RtUr4oEUqumqF4cBhUyu6
         A1dw==
X-Gm-Message-State: AOAM530CE5HS19hf0gNlLsBFjeoRluaiI7eX78gUWGBQBZQREm5Z8VJ/
        0NlAkEy1mw266Nkcvtqyju8FAN+tN+t0axNJgH3MiA==
X-Google-Smtp-Source: ABdhPJzCleNN7K0mPF5p8/6nUwtQrfjp2U5OUs4q6huEQPlWDTeftyFsrNyDhBBoOzO6JkJ+fig1rh0AruZPfG7iBVQ=
X-Received: by 2002:a63:f0a:0:b0:3c6:e825:2431 with SMTP id
 e10-20020a630f0a000000b003c6e8252431mr13968312pgl.166.1653168962273; Sat, 21
 May 2022 14:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <Yn6aL3cO7VdrmHHp@carbon> <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
In-Reply-To: <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 21 May 2022 14:35:51 -0700
Message-ID: <CALvZod6qeh_rNVVpZ5N8RMauhvxjQ=wLJUpK-QBCa9AXDNqi_g@mail.gmail.com>
Subject: Re: [PATCH mm v2 6/9] memcg: enable accounting for percpu allocation
 of struct cgroup_rstat_cpu
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 9:38 AM Vasily Averin <vvs@openvz.org> wrote:
>
> struct cgroup_rstat_cpu is percpu allocated for each new cgroup and
> can consume a significant portion of all allocated memory on nodes
> with a large number of CPUs.
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
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
