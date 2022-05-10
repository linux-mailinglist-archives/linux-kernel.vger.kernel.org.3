Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF35752119B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiEJKEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiEJKEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:04:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D2199B1C;
        Tue, 10 May 2022 03:00:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EB5201FA2E;
        Tue, 10 May 2022 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652176811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TH585TvAgnHTmSZOjM8rN1QLsQjbdV/qDVgFlTPiMag=;
        b=Pznwo8A4vEN3f9fwF/281B3RoS4rweAUqYinYMKjVgX3y4Lrxndh7JoivztKYzNUkk9wo7
        BR3907+Xk6m+OZptW749suxhN7+yeNUZJq/XkyXcI9rbCqbPgYCGqfetYZN2S6Aqpab7sf
        dZiLODZ3j4Adkj6cw3P6gLqn8oejq5s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E51792C14B;
        Tue, 10 May 2022 10:00:10 +0000 (UTC)
Date:   Tue, 10 May 2022 12:00:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
Message-ID: <Yno3pNQOn1lAMPnu@dhcp22.suse.cz>
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-05-22 01:43:38, CGEL wrote:
> On Mon, May 09, 2022 at 01:48:39PM +0200, Michal Hocko wrote:
> > On Mon 09-05-22 11:26:43, CGEL wrote:
> > > On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> > > > On Sat 07-05-22 02:05:25, CGEL wrote:
> > > > [...]
> > > > > If there are many containers to run on one host, and some of them have high
> > > > > performance requirements, administrator could turn on thp for them:
> > > > > # docker run -it --thp-enabled=always
> > > > > Then all the processes in those containers will always use thp.
> > > > > While other containers turn off thp by:
> > > > > # docker run -it --thp-enabled=never
> > > > 
> > > > I do not know. The THP config space is already too confusing and complex
> > > > and this just adds on top. E.g. is the behavior of the knob
> > > > hierarchical? What is the policy if parent memcg says madivise while
> > > > child says always? How does the per-application configuration aligns
> > > > with all that (e.g. memcg policy madivise but application says never via
> > > > prctl while still uses some madvised - e.g. via library).
> > > >
> > > 
> > > The cgroup THP behavior is align to host and totally independent just likes
> > > /sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
> > > for thp, it has no matter with host or other cgroup. This make it simple for
> > > user to understand or control.
> > 
> > All controls in cgroup v2 should be hierarchical. This is really
> > required for a proper delegation semantic.
> >
> 
> Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> Some distributions like Ubuntu is still using cgroup v1.

cgroup v1 interface is mostly frozen. All new features are added to the
v2 interface.

> > > If memcg policy madivise but application says never, just like host, the result
> > > is no THP for that application.
> > > 
> > > > > By doing this we could promote important containers's performance with less
> > > > > footprint of thp.
> > > > 
> > > > Do we really want to provide something like THP based QoS? To me it
> > > > sounds like a bad idea and if the justification is "it might be useful"
> > > > then I would say no. So you really need to come with a very good usecase
> > > > to promote this further.
> > > 
> > > At least on some 5G(communication technology) machine, it's useful to provide
> > > THP based QoS. Those 5G machine use micro-service software architecture, in
> > > other words one service application runs in one container.
> > 
> > I am not really sure I understand. If this is one application per
> > container (cgroup) then why do you really need per-group setting?
> > Does the application is a set of different processes which are only very
> > loosely tight?
> > 
> For micro-service architecture, the application in one container is not a
> set of loosely tight processes, it's aim at provide one certain service,
> so different containers means different service, and different service
> has different QoS demand. 

OK, if they are tightly coupled you could apply the same THP policy by
an existing prctl interface. Why is that not feasible. As you are noting
below...

>     5.containers usually managed by compose software, which treats container as
> base management unit;

..so the compose software can easily start up the workload by using prctl
to disable THP for whatever workloads it is not suitable for.
-- 
Michal Hocko
SUSE Labs
