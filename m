Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491805A55D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH2VAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2VAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF57E792FF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDD7960F8B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5CBC433C1;
        Mon, 29 Aug 2022 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661806832;
        bh=fqUkC9EH2QbQ4N3nK6D1pL+48iTcPXtlyjw2oH45q/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YzLdMhsGQzY9Uo73EGzk5SeI3No3H/yNk7jOt1CK79Hn4+GmU34B45BNqijkEgJuy
         DriWl8f9UKgp7oNKDPPIuAntRS6ijcqsnwH6oySdBkq6g4Jyy707V4a8q6FKC3cq3q
         fnS4Fpjl6aJzx5MZQELGzEyfnA52DBLv2aHUmlpY=
Date:   Mon, 29 Aug 2022 14:00:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH v2] mm/demotion: Expose memory tier details via sysfs
Message-Id: <20220829140030.692cfd4dfbf7f9a8b282c951@linux-foundation.org>
In-Reply-To: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
References: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 11:37:45 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
> related details can be found. All allocated memory tiers will be listed
> there as /sys/devices/virtual/memory_tiering/memory_tierN/
> 
> The nodes which are part of a specific memory tier can be listed via
> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> 
> The abstract distance range value of a specific memory tier can be listed via
> /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
> 
> A directory hierarchy looks like
> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
> memory_tier4/
> ├── abstract_distance
> ├── nodes
> ├── subsystem -> ../../../../bus/memory_tiering
> └── uevent
> 
> All toptier nodes are listed via
> /sys/devices/virtual/memory_tiering/toptier_nodes
> 
> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
> 0,2
> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
> 0,2
> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/abstract_distance
> 512 - 639
> 
> ...
>
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -19,6 +19,7 @@ struct memory_tier {
>  	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
>  	 */
>  	int adistance_start;
> +	struct device dev;
>  	/* All the nodes that are part of all the lower memory tiers. */
>  	nodemask_t lower_tier_mask;
>  };
> @@ -36,6 +37,13 @@ static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  static struct memory_dev_type *default_dram_type;
> +
> +#define to_memory_tier(device) container_of(device, struct memory_tier, dev)

Please, only use a macro when a C function cannot be used.

--- a/mm/memory-tiers.c~mm-demotion-expose-memory-tier-details-via-sysfs-fix
+++ a/mm/memory-tiers.c
@@ -38,7 +38,11 @@ static LIST_HEAD(memory_tiers);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 static struct memory_dev_type *default_dram_type;
 
-#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
+static inline struct memory_tier *to_memory_tier(struct device *device)
+{
+	return container_of(device, struct memory_tier, dev);
+}
+
 static struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
 	.dev_name = "memory_tier",

If only so it checks the type of `device'.
