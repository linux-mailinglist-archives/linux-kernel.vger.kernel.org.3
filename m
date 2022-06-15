Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1DF54C731
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiFOLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiFOLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:11:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7541627
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:11:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1B4F21F38D;
        Wed, 15 Jun 2022 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655291500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rItd1ojkTsOwmaVczGGbIEFSm9A7rqtW6hIDanRzN4=;
        b=Coxyj/JBf7TTWY4B+qracSbRGznAkf6jOmVjaP+KpeSYgTI6s6ELGfQ/VB3v8AiGQdfWHv
        ks1V+v1QKORYwiiukKRiGiVVo/9VOqjHxpf1xmGva00W9hi73lhWyqxIWiwN9nW/sBfZuQ
        UfXwQ8R92LSa3pa8XeAY29Aacud9TK4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 245E52C141;
        Wed, 15 Jun 2022 11:11:37 +0000 (UTC)
Date:   Wed, 15 Jun 2022 13:11:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [RFC PATCH 0/3] Cgroup accounting of memory tier usage
Message-ID: <Yqm+ZnHfkxuyuzyD@dhcp22.suse.cz>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655242024.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-06-22 15:25:32, Tim Chen wrote:
> For controlling usage of a top tiered memory by a cgroup, accounting
> of top tier memory usage is needed.  This patch set implements the
> following:
> 
> Patch 1 introduces interface and simple implementation to retrieve
> 	cgroup tiered memory usage
> Patch 2 introduces more efficient accounting with top tier memory page counter 
> Patch 3 provides a sysfs interface to repot the the top tiered memory
> 	usage.

I guess you meant cgroupfs here, right?

> The patchset works with Aneesh's v6 memory-tiering implementation [1].
> It is a preparatory patch set before introducing features to
> control top tiered memory in cgroups.
> 
> I'll like to first get feedback to see if 
> (1) Controllng the topmost tiered memory is enough 
> or
> (2) Multiple tiers at the top levels need to be grouped into "toptier"
> or
> (3) There are use cases not covered by (1) and (2). 

I would start by asking why do we need a dedicated interface in the
first place. Why the existing numa_stat is not a proper interface. Right
now we only report LRU per node stats. Is this insufficient?
What is userspace expect to do based on the reported data?

-- 
Michal Hocko
SUSE Labs
