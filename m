Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D4253562B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbiEZWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiEZWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:51:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C2DFF5E;
        Thu, 26 May 2022 15:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 215D8B80686;
        Thu, 26 May 2022 22:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1FFC385A9;
        Thu, 26 May 2022 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653605504;
        bh=Tys7xlqJB6C43ppPS6C0HzRjdGQs+gMJMt+YF4tmbsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ef+SL70pMsvyPQsPAYH+ZsTywBtkq2bZgHx5o6JYGqroTpuvsWi0ijdTRarDWRZVx
         lDBXcAw5Gfh6sDLhcAxHk0p7YqZW7nWUzIcYxWOmUj6yVQ9s/2sLSQg+d9qyf1qTFP
         icuIaNfXryBM4NgzyAsey3keror4qKYz+bySAP5r+P4t/BHu4FgrFY87NWwy90zvF2
         PnnxMMhKPNbrfWfXWoyEawBDLLMeVhrTD8MPjRk2M1Loe/JjGRXrf2Qjzw8CVxsq35
         KQ7/ptAXVN1ZGda4xqdienJXCdZKc1yEYn4gtA4dzTDeeYS8NEV0ZP8xOb6MmIfYWx
         wkLG36Mt8P1Dw==
Date:   Fri, 27 May 2022 00:51:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <20220526225141.GA1214445@lothringen>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo/FGcG+uiBh88sT@slm.duckdns.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:21:13AM -1000, Tejun Heo wrote:
> On Thu, May 26, 2022 at 12:10:55AM +0200, Frederic Weisbecker wrote:
> > Introduce a new "isolation.rcu_nocb" file within a cgroup2/cpuset
> > directory which provides support for a set of CPUs to either enable ("1")
> > or disable ("0") RCU callbacks offloading (aka. RCU NOCB). This can
> > overwrite previous boot settings towards "rcu_nocbs=" kernel parameter.
> > 
> > The file is only writeable on "root" type partitions to exclude any
> > overlap. The deepest root type partition has the highest priority.
> > This means that given the following setting:
> > 
> >                     Top cpuset (CPUs: 0-7)
> >                     cpuset.isolation.rcu_nocb = 0
> >                               |
> >                               |
> >                     Subdirectory A (CPUs: 5-7)
> >                     cpuset.cpus.partition = root
> >                     cpuset.isolation.rcu_nocb = 0
> >                               |
> >                               |
> >                     Subdirectory B (CPUs: 7)
> >                     cpuset.cpus.partition = root
> >                     cpuset.isolation.rcu_nocb = 1
> > 
> > the result is that only CPU 7 is in rcu_nocb mode.
> > 
> > Note that "rcu_nocbs" kernel parameter must be passed on boot, even
> > without a cpulist, so that nocb support is enabled.
> 
> Does it even make sense to make this hierarchical? What's wrong with a
> cpumask under sys/ or proc/?

I'm usually told that cpusets is the current place where CPU attributes are
supposed to go. I personally don't mind much /sys either even though cpusets
looks like a more flexible way to partition CPUs with properties and tasks
placement altogether...
