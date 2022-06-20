Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4244551020
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiFTGNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbiFTGNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:13:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC46146
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:13:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso11440939pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YkPqpfUX+L0hoB9Kerf1NXcOCvW4O6Wrp9vBOyavaFk=;
        b=Sppa+cznksmSnBN0Hb4tnd39OxbExYMGS14dgliIM6xPRw/js90Q5vuen3RaccDVM5
         +QsuOAQ6T9HD8irEpLB3MO7T0xKMmuoJJ0WLppjaITPcl7icv0Bq2MVpw1ms1v3D/HMS
         jJt2W+zx39RpJMloaVl7FFXL++y0Pn4GxUjeX9dHHQuFeo000sEeq5s3rvlYAO0WagjC
         SjwvH+1PBzGF1nb56G64rpo33emu3MTDoVT7HEKIq2Iz6jFVnjESTWXXB6o6tMApC3Bw
         E8zzdoHnBmgYPoiJ3VaklC+iP71Uk1xULCza4MWM+Z+egAVv/pu9bQcMgLXW83rHwh+A
         nRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YkPqpfUX+L0hoB9Kerf1NXcOCvW4O6Wrp9vBOyavaFk=;
        b=o2uo8uOwaOkbadYgZq+mA/fXkbrmvEf3xM4QK7RuPyrfkbV5e0egCsLgQa+2gDaXmL
         2GEJmvapSh0YhJwiD7zfK1hvm5lpdn8xV4CwiXJVj75rwcDb5Bc7vWomCkkEGzVz1S2B
         dbOLpFT6EtI6D7GtXUP45/rfpz3yw/QbSkmk/mOQ48EKrpFCmIfmxxdKhIVyhbkOPl06
         8MqJaSorllryaqf6rSrS9gxFdZKVPpBtm7SB/PFsciiwK+it99iq9+v5kiKBkpAATHws
         NZPORBRthGxCR6s6ppf+3fIeXtAVpGthIcdCI2hwseev3Kl90VrkBzZtaL55pYTMzOXM
         63wA==
X-Gm-Message-State: AJIora+hk1uqoymK8asrFoVJb3LScsJPWlhMaR5qea6fK/xGUMg3NOnS
        10Bcc9yJIKLkUR23RaQUEV6DZA==
X-Google-Smtp-Source: AGRyM1vb+i5Qz13vCcA6u03mQcnnNFh6BLT1nElkzwn7cdTPYhep/s6hfBC6ak+0NcZXC8GxZkB7/g==
X-Received: by 2002:a17:902:a58b:b0:168:b680:c769 with SMTP id az11-20020a170902a58b00b00168b680c769mr23332488plb.32.1655705628395;
        Sun, 19 Jun 2022 23:13:48 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id x19-20020a63b213000000b0040c9df2b060sm2363931pge.30.2022.06.19.23.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:13:48 -0700 (PDT)
Date:   Mon, 20 Jun 2022 14:13:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 07/11] mm: memcontrol: make all the callers of
 {folio,page}_memcg() safe
Message-ID: <YrAQFysifBga7H8k@FVFYT0MHHV2J.usts.net>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-8-songmuchun@bytedance.com>
 <Yq96/NEanbbUUUIW@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq96/NEanbbUUUIW@castle>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 12:37:32PM -0700, Roman Gushchin wrote:
> On Mon, May 30, 2022 at 03:49:15PM +0800, Muchun Song wrote:
> > When we use objcg APIs to charge the LRU pages, the page will not hold
> > a reference to the memcg associated with the page. So the caller of the
> > {folio,page}_memcg() should hold an rcu read lock or obtain a reference
> > to the memcg associated with the page to protect memcg from being
> > released. So introduce get_mem_cgroup_from_{page,folio}() to obtain a
> > reference to the memory cgroup associated with the page.
> > 
> > In this patch, make all the callers hold an rcu read lock or obtain a
> > reference to the memcg to protect memcg from being released when the LRU
> > pages reparented.
> > 
> > We do not need to adjust the callers of {folio,page}_memcg() during
> > the whole process of mem_cgroup_move_task(). Because the cgroup migration
> > and memory cgroup offlining are serialized by @cgroup_mutex. In this
> > routine, the LRU pages cannot be reparented to its parent memory cgroup.
> > So {folio,page}_memcg() is stable and cannot be released.
> > 
> > This is a preparation for reparenting the LRU pages.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>

Thanks for your review.
 
> The locking seems to be correct. I'm slightly worried about a potential
> perf degradation, especially on dying cgroups, where css_get() is relatively
> expensive. I hope getting it into mm-unstable will help to determine
> whether it's actually a problem.
> 

I'll send a new version based on mm-unstable ASAP.

Thanks.

> Thanks!
> 
