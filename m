Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ED0533CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiEYMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiEYMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:38:04 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A77A821
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:38:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id p8so533402qtx.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TZc5omLz/Jq7pdQu2KMjXRAJ+8quAYgmF0qQ6A24hk=;
        b=QY59JJr7TItWYVE8/m9ruAVMHFqijACLGhysmIiQ0darsQg/VQAoJB8gF2m9BF41wz
         /Rd0O1W076eZNqnGHu+DAxpqOcIiVcSLvKUEJhqY5OvDGbpFy0ESGC/p0jK+bP/sZRHW
         YNyl6oYfbkJuFFI6vKpdAcbbhDbc+4NhyBATsREKtv7w8AFx45S9N8cPppNXnNRlDe2Y
         ne1zDiEaRvCpbvIraoD3UJZCi+i5D7sCQ1Fx97kmRCaKSd2nKy8uX0l6sSmwKWrK8mEJ
         OJtY07A4EPFFeowbysgfs+AsI1e7SZbI3MrQiHJ9fZAJee4hJExZh8khNM6L17ZOG7ue
         zwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TZc5omLz/Jq7pdQu2KMjXRAJ+8quAYgmF0qQ6A24hk=;
        b=mnFy2le2iEiQulBE8pKPLeWvUbJpt8UkQIWmKEFor1CNeumhyarClyDOX1YBNO5s7O
         Uzb32R0Vmen/r5MiZjEZyUN/sGvwZO0uNB7DfKLvfalhgw0CvXyxvEQygqU3tvowmeeI
         MwQuHv/bmEF/ikv8Rhxt7HQiCIJTjOk0WXNGSAz2hwcR4huzbhDTMkRKjOLqvB5o3Tb4
         DhG5NoiMyS3z/GMNmIX0YVL9Q270HfmLZeGRmYgNK31mTFPhq2A89qGSBMCEhKdePF6n
         6n1wgc0Um2j7J0D886g+DisGGqt4uuM2sGR0/ZhiuA1s8UaTXHJhV72q3UuiuNlW5BNK
         +rqA==
X-Gm-Message-State: AOAM5311ys1SFWwqbAk3dois1CNZtbZiB0DL4Y44BzGzr+SxNAKeMEoi
        pH8wPqq7m6qLlOv9ze0MmsEVew==
X-Google-Smtp-Source: ABdhPJwxkvvQWVThY7jxwjBZ8PVDb6IWuwhfcpUVnJ434BMIv9seVYQmuiG8fIWf3ZO7e8ut9FUP8Q==
X-Received: by 2002:a05:622a:248:b0:2f9:3ea2:c11d with SMTP id c8-20020a05622a024800b002f93ea2c11dmr8378034qtx.600.1653482279980;
        Wed, 25 May 2022 05:37:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8774b000000b002f90a33c78csm1219613qtu.67.2022.05.25.05.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:37:59 -0700 (PDT)
Date:   Wed, 25 May 2022 08:37:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, mhocko@kernel.org,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <Yo4jJjBksFVeJHxA@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-2-songmuchun@bytedance.com>
 <Yo2WKADtPy2rekRh@carbon>
 <Yo3hXe8bF3boWx5C@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo3hXe8bF3boWx5C@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 03:57:17PM +0800, Muchun Song wrote:
> On Tue, May 24, 2022 at 07:36:24PM -0700, Roman Gushchin wrote:
> > On Tue, May 24, 2022 at 02:05:41PM +0800, Muchun Song wrote:
> > > -	memcg_reparent_list_lrus(memcg, parent);
> > > +	memcg_reparent_list_lrus(memcg, parent_mem_cgroup(memcg));
> > We effectively dropped this:
> > 	if (!parent)
> > 		parent = root_mem_cgroup;
> > Is it safe? (assuming v1 non-hierarchical mode, it's usually when all
> > is getting complicated)

Yes, it's correct. But it's a quiet, incidental cleanup, so I can see
why it's confusing. It might be better to split the dead code removal
into a separate patch - with the following in the changelog ;):

> Since no-hierarchy mode is deprecated after commit bef8620cd8e0
> ("mm: memcg: deprecate the non-hierarchical mode"), so
> parent_mem_cgroup() cannot return a NULL except root memcg,
> however, root memcg will not be offline, so it is safe. Right?
