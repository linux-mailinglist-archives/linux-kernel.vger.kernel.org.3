Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2595C48FEA4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 20:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiAPTXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 14:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiAPTXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 14:23:49 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59491C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 11:23:49 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id e3so46883828lfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hU+OS4Mtwv3I0vy+iNW/4UuAtkSDs3qfMaH9agtczxw=;
        b=IXBWqMIvZmgkCjiwt9Q3j+mjCGE+6J+S4UDiBSUUpGUCfcno5XNU/zEfNYKufj9pbo
         mN46XqggL2AKWpLF0dagxWhuVQJhVngCZkW9t7ZU/R9pPe5cSQNatJ6t6mewMX7oANMP
         o5i4BneUdKCm/W9x7ztGVl2/TpDJFubZ62AkNI2JLiQKEwH0S0m+W99r1bilWzu101ML
         bqPIDTz+r6IkzCdhBBmz7iKT71B32Z+USN41d9Bb/QkL4dHC6bALBYyopRq3S85iZJ+w
         w3njQ/ET4IoYJunHTC9QAZ6JfphnkZkpJgO/tY4Gn3+B+1gN3CczulAwseNhpKLxexfF
         R3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hU+OS4Mtwv3I0vy+iNW/4UuAtkSDs3qfMaH9agtczxw=;
        b=xpMutIKG/WxvakNQcwZrdemVQxheUHy6w6I/n1O3htJph2pPMbdCm3cGulRZ6k8RjU
         crP2VO2TFnbLDJ43co0Tpe0heVpywhvhu7/Zn+WoUGNN1YwjTqcTajWht4NO8KC0ce1T
         SsXhpA0K7FVsoZgUWoviR5c/szmnRdoDIIOb3tdw05cZ3Grq+KDZzrxKJxDxvZb07Io7
         1jvol7Seis2GTMLssxf7qlARPdPDM+4VdfSq+n6XpTswccTu5IUzu+z23r8bHfLKMC6X
         u1hA0fcxpqU9mtmi/H347PP0iTdH2ZJwb2SyB2Ay9aPuXIEdQggXUhCeZ4f0FeeGE1Tu
         p4Vg==
X-Gm-Message-State: AOAM532UmnAZjj3pA/dmnBPsYNfAntpKQ/MJKV8IPb6VkFkeYMgT9Tc4
        20dOwTVym/CMcqwwRPYB1PDHsvsZYOTj/QQK088HAg==
X-Google-Smtp-Source: ABdhPJzGmmRPBzFq6kEJt5LpR69nvflMg1bsSG4dtuip0qaqVYBqdvK9cnATbBijztPoDBr9dI8dXCYnY6ktmayGy+c=
X-Received: by 2002:a2e:3804:: with SMTP id f4mr12569369lja.35.1642361027245;
 Sun, 16 Jan 2022 11:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <Yd1CdJA5NelzoK1D@dhcp22.suse.cz> <20220112004634.dc5suwei4ymyxaxg@master> <Yd6Xr7K9bKGVgGtI@dhcp22.suse.cz>
In-Reply-To: <Yd6Xr7K9bKGVgGtI@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 16 Jan 2022 11:23:36 -0800
Message-ID: <CALvZod6odMTNMXNqc2KsmOYv0vEAT-eTZ2xP-UhkQSo0pf7+bA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:56 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 12-01-22 00:46:34, Wei Yang wrote:
> > On Tue, Jan 11, 2022 at 09:40:20AM +0100, Michal Hocko wrote:
> > >On Tue 11-01-22 01:02:59, Wei Yang wrote:
> > >> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
> > >>
> > >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > >
> > >I am not really sure this is worth it. After the merge window I plan to
> > >post http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org.
> >
> > Give me some time to understand it :-)
>
> Just for the record, here is what I have put on top of that series:
> ---
> From b7195eba02fe6308a6927450f4630057c05e808e Mon Sep 17 00:00:00 2001
> From: Wei Yang <richard.weiyang@gmail.com>
> Date: Tue, 11 Jan 2022 09:45:25 +0100
> Subject: [PATCH] memcg: do not tweak node in alloc_mem_cgroup_per_node_info
>
> alloc_mem_cgroup_per_node_info is allocated for each possible node and
> this used to be a problem because not !node_online nodes didn't have
> appropriate data structure allocated. This has changed by "mm: handle
> uninitialized numa nodes gracefully" so we can drop the special casing
> here.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
