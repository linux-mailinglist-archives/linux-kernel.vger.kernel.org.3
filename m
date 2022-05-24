Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61E532080
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiEXCAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiEXCAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:00:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920ED7CB0E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:00:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so15209857pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ks5fHZGz5K1moEIff4MSVWwvyiI+uYKrM7vKXg28rC0=;
        b=RuIliZvWTgzJRnlripHHDX+9nt0tRt6Z47armgptC9p5cIznXN3wsoEbwY4Hkm8DZx
         CpUbOaTMMt3sCq3O0k7/6ATXu7gn5Pvh8jSw4dehpmbHMojeJxmSUIu+L5CFVDowf4xx
         fYAGOlEM3P7pY8D//c3l8fuqIbK7TuZ7mXMIqnU5fA27Ak0p7r0YmGOzkq6IaF2L0SF4
         3QU5OfF3vMUXMMdToNC5hJKuvY4M0j+exO01qpxAWWeRFeKK/KN4oltqFU1Rl60HNDmZ
         qOfgx+XkvEn6Huu65Yl0YUKdm8RhI4PHz9CoC4tSaKhr/u5ihuBavphenfGMiBgEBgQG
         nQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ks5fHZGz5K1moEIff4MSVWwvyiI+uYKrM7vKXg28rC0=;
        b=E3olVNwbUB6zxkFicq0Srn4IH7UJqxNFLz53j/zmQzcF3BgicuCDjqLJgcRTIj5RG9
         kcAsYjUpC5ne/CbE6SsfOZgDfrBoFMXfQRH+0tOHgp7hFEZLItq7lyo4i1N9K4L788dA
         yymPutsvnC8yw4YdR1hyheoZyVCfXcIjhlWa6IkFL/Neop9XngISMUthXtkpS7KK/2wN
         en9M2P51coJfKoOS002MmqXQSmSz4wP7JZtO/AphyWposSOfYHHvixz7Q8JV7oHPdjEk
         v3TGeDMdZ5syBgEdFC5TqFlWPV8f+i6SBABlSLXAkqEaltv1LN7aPt4m/FRBSf7jJtyU
         jMBg==
X-Gm-Message-State: AOAM532/2osZI09x6fDlNcNXzNGNwW/OI/mkUpmBfperMSspOHI6a+Xb
        G5VxfQob8S7z23ciNn3Jloh7uA==
X-Google-Smtp-Source: ABdhPJytnwSaStOgTzWHURP9QGPnEoymAUGruoeUxElkd7F90wuj4W/hyTnpA0OJdKiPBtAw0J0jWA==
X-Received: by 2002:a05:6a00:1a03:b0:510:a1d9:7de0 with SMTP id g3-20020a056a001a0300b00510a1d97de0mr25807224pfv.53.1653357632063;
        Mon, 23 May 2022 19:00:32 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902f09200b0015e8d4eb23bsm5767658pla.133.2022.05.23.19.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:00:31 -0700 (PDT)
Date:   Tue, 24 May 2022 10:00:26 +0800
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
Message-ID: <Yow8OkW+BYF0HeuK@FVFYT0MHHV2J.googleapis.com>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-2-roman.gushchin@linux.dev>
 <YongvYP26K2hZ3Sf@FVFYT0MHHV2J.usts.net>
 <YovOfEdoGHClHUK+@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YovOfEdoGHClHUK+@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:12:12AM -0700, Roman Gushchin wrote:
> On Sun, May 22, 2022 at 03:05:33PM +0800, Muchun Song wrote:
> > On Mon, May 09, 2022 at 11:38:15AM -0700, Roman Gushchin wrote:
> > > Shrinker debugfs requires a way to represent memory cgroups without
> > > using full paths, both for displaying information and getting input
> > > from a user.
> > > 
> > > Cgroup inode number is a perfect way, already used by bpf.
> > > 
> > > This commit adds a couple of helper functions which will be used
> > > to handle memcg-aware shrinkers.
> > > 
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > ---
> > >  include/linux/memcontrol.h | 21 +++++++++++++++++++++
> > >  mm/memcontrol.c            | 23 +++++++++++++++++++++++
> > >  2 files changed, 44 insertions(+)
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index fe580cb96683..a6de9e5c1549 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -831,6 +831,15 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
> > >  }
> > >  struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
> > >  
> > > +#ifdef CONFIG_SHRINKER_DEBUG
> > > +static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
> > > +{
> > > +	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
> > > +}
> > > +
> > > +struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
> > > +#endif
> > > +
> > >  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
> > >  {
> > >  	return mem_cgroup_from_css(seq_css(m));
> > > @@ -1324,6 +1333,18 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> > >  	return NULL;
> > >  }
> > >  
> > > +#ifdef CONFIG_SHRINKER_DEBUG
> > > +static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
> > > +{
> > > +	return NULL;
> > > +}
> > > +#endif
> > > +
> > >  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
> > >  {
> > >  	return NULL;
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 04cea4fa362a..e6472728fa66 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5018,6 +5018,29 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> > >  	return idr_find(&mem_cgroup_idr, id);
> > >  }
> > >  
> > > +#ifdef CONFIG_SHRINKER_DEBUG
> > > +struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
> > > +{
> > > +	struct cgroup *cgrp;
> > > +	struct cgroup_subsys_state *css;
> > > +	struct mem_cgroup *memcg;
> > > +
> > > +	cgrp = cgroup_get_from_id(ino);
> > > +	if (!cgrp)
> > > +		return ERR_PTR(-ENOENT);
> > > +
> > > +	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> > > +	if (css)
> > > +		memcg = container_of(css, struct mem_cgroup, css);
> > > +	else
> > > +		memcg = ERR_PTR(-ENOENT);
> > > +
> > > +	cgroup_put(cgrp);
> > 
> > I think it's better to use css_put() here since the refcount is get
> > via cgroup_get_e_css() which returns a css struct.
> 
> cgroup_put() is matching cgroup_get_from_id().
> 
> The reference grabbed by cgroup_get_e_css() shouldn't be dropped
> because mem_cgroup_get_from_ino() has a "get" semantics.
>

My bad. I have misread it here. Thanks.

