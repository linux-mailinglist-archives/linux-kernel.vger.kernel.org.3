Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26650C11A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiDVVhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiDVVhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:37:40 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDF6400EDA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:40 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id r85so10313081oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FeuhW6y4os5v9CoDi1x5cL69WTrNP7orQRjD5u2f2Q=;
        b=SWA5JCifyGGgXC8kg9oqcVEfzGpcJyubvgXISY/tkiQ4LkAnBvdJQ4x+SDJdCcN5r5
         l/D5Xwmleml/wGOTyuQey0sip6/0Tgoq+rQ7CHZro/fqIgNVa0LsvarIkgGhhvY5j1sF
         LMm1oOI3X0eDdolQ9LpFcFBcvkgDAo4IEFQp7an7GZ4F5A6E9vw8lZlu+PJZ8/F/XeaE
         2XrN/+haQevXPxaL9uHcm3fCWmwsIiDq4XpsMffkJ/1dAHzee/+nBWc5FxrRuv2Yv75v
         ot9Gi+ioqe4rUavjZ2Ml02hMsz+UFQFITKvVGI/dulXXz+ZeW0uqaldMetwuQxNGpPe6
         t/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FeuhW6y4os5v9CoDi1x5cL69WTrNP7orQRjD5u2f2Q=;
        b=4MlbXWArR+Cz5opcS7HSSeCoGSQj45gUh9z4EzJW5/GXYFRuDmhtJfbZ402RTEc05t
         i0b6351yxsOWMwyxD5wkySPv9CfaRgMXOOoctl7RUdLnQmUgYw/xhT3jDpJKSsrghD/H
         5w+UBBT8UyvuCMFUelxWKA4W92W8yH1nFYsGR/Rxu4g5TeUA679jqJGNEjARqOd5iycp
         5uHBn7KcQU+XBQ8GvZc8qdE1sYMRcVXd2gDIk+2Ws42GXzF4ZNGYH4LuUWSyUBr80gyu
         lzV2Ovm+ORFWNdw6VozdZrX+TXy9uBH+rl+CzpZBYv//BsdzlZaAwheHwzGLiO1ekxJ5
         RyyQ==
X-Gm-Message-State: AOAM531LqcwCdunnjzn1vPzpPhBhFfIFupUIL0mBd0l8F8glU6+Ih2x0
        2kONGQVbLKO9hZMCVS4y/ZTsRWRApapG5NaDL7cgve41SRg=
X-Google-Smtp-Source: ABdhPJxCip4JkFs0bch4l1aLRcJlX/rZIBmOxuo46xJlHa8tYFRtgabnDRNRUlP/nwaE4268Bz4NxqEBLVaSJWXdjEQ=
X-Received: by 2002:a17:90b:1d84:b0:1d0:6472:e0a3 with SMTP id
 pf4-20020a17090b1d8400b001d06472e0a3mr18058060pjb.207.1650658963307; Fri, 22
 Apr 2022 13:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <46c1c59e-1368-620d-e57a-f35c2c82084d@linux.dev>
 <55605876-d05a-8be3-a6ae-ec26de9ee178@openvz.org> <CALvZod47PARcupR4P41p5XJRfCaTqSuy-cfXs7Ky9=-aJQuoFA@mail.gmail.com>
 <964ae72a-0484-67de-8143-a9a2d492a520@openvz.org> <e9cd84f2-d2e9-33a8-d74e-edcf60d35236@openvz.org>
In-Reply-To: <e9cd84f2-d2e9-33a8-d74e-edcf60d35236@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Apr 2022 13:22:32 -0700
Message-ID: <CALvZod7ys1SNrQhbweCoCKVyfN1itE16jhC97TqjWtHDFh1RpQ@mail.gmail.com>
Subject: Re: [PATCH memcg RFC] net: set proper memcg for net_init hooks allocations
To:     Vasily Averin <vvs@openvz.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 1:09 PM Vasily Averin <vvs@openvz.org> wrote:
>
> On 4/22/22 23:01, Vasily Averin wrote:
> > On 4/21/22 18:56, Shakeel Butt wrote:
> >> On Sat, Apr 16, 2022 at 11:39 PM Vasily Averin <vvs@openvz.org> wrote:
> >>> @@ -1147,7 +1148,13 @@ static int __register_pernet_operations(struct list_head *list,
> >>>                  * setup_net() and cleanup_net() are not possible.
> >>>                  */
> >>>                 for_each_net(net) {
> >>> +                       struct mem_cgroup *old, *memcg = NULL;
> >>> +#ifdef CONFIG_MEMCG
> >>> +                       memcg = (net == &init_net) ? root_mem_cgroup : mem_cgroup_from_obj(net);
> >>
> >> memcg from obj is unstable, so you need a reference on memcg. You can
> >> introduce get_mem_cgroup_from_kmem() which works for both
> >> MEMCG_DATA_OBJCGS and MEMCG_DATA_KMEM. For uncharged objects (like
> >> init_net) it should return NULL.
> >
> > Could you please elaborate with more details?
> > It seems to me mem_cgroup_from_obj() does everything exactly as you say:
> > - for slab objects it returns memcg taken from according slab->memcg_data
> > - for ex-slab objects (i.e. page->memcg_data & MEMCG_DATA_OBJCGS)
> >     page_memcg_check() returns NULL
> > - for kmem objects (i.e. page->memcg_data & MEMCG_DATA_KMEM)
> >     page_memcg_check() returns objcg->memcg
> > - in another cases
> >     page_memcg_check() returns page->memcg_data,
> >     so for uncharged objects like init_net NULL should be returned.
> >
> > I can introduce exported get_mem_cgroup_from_kmem(), however it should only
> > call mem_cgroup_from_obj(), perhaps under read_rcu_lock/unlock.
>
> I think I finally got your point:
> Do you mean I should use css_tryget(&memcg->css) for found memcg,
> like get_mem_cgroup_from_mm() does?

Yes.
