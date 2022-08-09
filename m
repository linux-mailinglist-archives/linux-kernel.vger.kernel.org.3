Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C142458E1C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiHIVZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiHIVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:25:28 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E545F49
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:25:26 -0700 (PDT)
Date:   Tue, 9 Aug 2022 14:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660080325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJ+FDVpBSEzK2EoXIhVyyu6wE3zilcScyC8ojStCxxI=;
        b=HKMgL2g2MTuLe3kMQ7rhzrqmOSRlArIEpu4G+sQjvFpRJVKvBIYoEuPPFu+SFlekJPp+3r
        GD3rz8CMtEbJMY8a7jajFAQKq8C+Nximk++6uZre2bbGS3uI67bi4GEj50hdCEFXe5K3h6
        6LNlP/5GkH7WEx89qwRXtFq/jYh9B80=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Tejun Heo <tj@kernel.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/3] enable memcg accounting for kernfs objects
Message-ID: <YvLQsRf7KBezyE+B@P9FQF9L96D.corp.robot.car>
References: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
 <YvKZ8zYJFhhFvRxO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvKZ8zYJFhhFvRxO@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 07:31:31AM -1000, Tejun Heo wrote:
> (cc'ing Johannes)
> 
> Hello,
> 
> On Sun, Jul 31, 2022 at 06:37:15PM +0300, Vasily Averin wrote:
> > 1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
> >    was allocated for 80+ kernfs nodes.
> > 
> > 2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
> >    structures.
> > 
> > 3) Shakeel Butt reports that Google has workloads which create 100s
> >    of subcontainers and they have observed high system overhead
> >    without memcg accounting of kernfs.
> 
> So, I don't have anything against accounting kernfs objects in general but,
> for cgroups, because cgroups are what determines what gets charged where,
> I'm not quite sure whether following the usual "charge it to the allocating
> task's cgroup" is the best way to go about it. I wonder whether it'd be
> better to attach it to the new cgroup's nearest ancestor with memcg enabled.

I also like this approach better, however Michal had some arguments against it.
I don't think there is a huge practical difference, so I'm ok with either
approach.

Thanks!
