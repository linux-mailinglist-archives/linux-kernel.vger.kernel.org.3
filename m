Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607FF508FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381567AbiDTSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiDTSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:47:52 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE61409B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:45:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d14so1647768qtw.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GydGBqVOMdxK+zuMU2QjZP5eRGEp0WUH1oQpueOfZrk=;
        b=Oaxf+YEo72YwfG3w84fbVQ6plTOWo84uA6Oh1wiSP/uezqFsO5Yh4VvRVjGHpZ4XeN
         Dq6BsrWctnlAmfSohEhtHlE8Ti25xtgN1IG1lCNY/oRJ68olqL1YdpzrV2sAl4TAruk3
         VKed6+D78UwKEBmAUp/cdqp0/UAIWHdUY4C1xsw9jF9tkWj6hdRKMLP6Ly6Ff5VvWueM
         dNgHqXATD+lvQ+cgwCgnkxMG8/yDzCVukwZvwO5lYvNLI9ydb32POZZVEmwmtXjXw4Uo
         td/OBrAgWjGH7pN+ZaCD7fahHHwotRs4BMX1chtLeRr/XvoImEMxrycMQOsuqx0E/S3i
         ES7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GydGBqVOMdxK+zuMU2QjZP5eRGEp0WUH1oQpueOfZrk=;
        b=BQE6bGGE3s3vhmjE3HNEb3PfUxYSqFBHN3wyzkpWlY2Aw35zElk9BjSyb1bOfEQB6C
         nVW+CHp/nvTD+jx+tYlewNhDA2ppBw79cMKQO2QvPGkWhIi9hnSAbBC0x9gO3oJweuFi
         46Sy/Jt9htm3+GPgcd2EaJfQJ8PuWUv4W0As1/SR97Auo7Yv07Goi6fvVoQj8c8Z3shT
         FOg5ih8BKzgD/y6919Gz4KdjqqZsc/JZI8O39uZFtq/e8N8SepEPXCZPeS8ABGC1aA0y
         Tx6Hg9TpoNUWvE1JnbAo0WESWKTQ4Qv4D/XEZXMUjs71kdu5xKrYiUzt7KttbQrt3EdG
         j0kg==
X-Gm-Message-State: AOAM531fmN+Kf7XAymh/5X/bRSbsV5+21MD2DNx1fQQFNFpXZZ7ZzvyP
        jki/aX4rIn6Cjdp1/CMeq4fdsw==
X-Google-Smtp-Source: ABdhPJwqPAuuppufV9WBAwTkX6nejkfGfKtaVxHFmZofStks6sWGafgSrL64vTdo1Sdmwi7xr/OYnw==
X-Received: by 2002:ac8:70da:0:b0:2f1:d195:cfaf with SMTP id g26-20020ac870da000000b002f1d195cfafmr14840662qtp.247.1650480304298;
        Wed, 20 Apr 2022 11:45:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:911d])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm2093902qtw.67.2022.04.20.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:45:03 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:44:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Message-ID: <YmBUkNMVDQobgK4M@cmpxchg.org>
References: <20210809223740.59009-1-npache@redhat.com>
 <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
 <Yl8Dk+a1YDwupLMv@cmpxchg.org>
 <e495901c-f2f3-cc85-10a6-0d2944255b19@redhat.com>
 <YmASIHjTVndHHoL4@cmpxchg.org>
 <bc9f5209-5c59-c921-d85e-e2e54b2375db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9f5209-5c59-c921-d85e-e2e54b2375db@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico,

On Wed, Apr 20, 2022 at 01:34:58PM -0400, Nico Pache wrote:
> On 4/20/22 10:01, Johannes Weiner wrote:
> >> My swappiness=0 solution was a minimal approach to regaining the 'avoid swapping
> >> ANON' behavior that was previously there, but as Shakeel pointed out, there may
> >> be something larger at play.
> > 
> > So with my patch and swappiness=0 you get excessive swapping on v1 but
> > not on v2? And the patch to avoid DEACTIVATE_ANON fixes it?
> 
> correct, I haven't tested the DEACTIVATE_ANON patch since last time I was
> working on this, but it did cure it. I can build a new kernel with it and verify
> again.
> 
> The larger issue is that our workload has regressed in performance.
> 
> With V2 and swappiness=10 we are still seeing some swap, but very little tearing
> down of THPs over time. With swappiness=0 it did some when swap but we are not
> losings GBs of THPS (with your patch swappiness=0 has swap or THP issues on V2).
> 
> With V1 and swappiness=(0|10)(with and without your patch), it swaps a ton and
> ultimately leads to a significant amount of THP splitting. So the longer the
> system/workload runs, the less likely we are to get THPs backing the guest and
> the performance gain from THPs is lost.

I hate to ask, but is it possible this is a configuration issue?

One significant difference between V1 and V2 is that V1 has per-cgroup
swappiness, which is inherited when the cgroup is created. So if you
set sysctl vm.swappiness=0 after cgroups have been created, it will
not update them. V2 cgroups do use vm.swappiness:

static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
{
	/* Cgroup2 doesn't have per-cgroup swappiness */
	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
		return vm_swappiness;

	/* root ? */
	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
		return vm_swappiness;

	return memcg->swappiness;
}

Is it possible the job cgroups on V1 have swappiness=60?

> So your patch does help return the old swappiness=0 behavior, but only for V2.

Thanks for verifying. I'll prepare a proper patch.
