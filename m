Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4450D013
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiDXGcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiDXGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:32:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E404184F1B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650781770; x=1682317770;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEtVeQ8xCV3wRzfhM2vTLT+erRs7nKtFKJ5thWlpl3k=;
  b=TOmGcRPxvJ6/DeHMyQQOH8kSopho1o0eBvF6v8sMmIE+v3Wi0FJ6GUcr
   mX9ZCDot+9UdfKlZvmz0gu29wUm975Xy5mqUHCFBzcFw+yxlMIgykU/2i
   gniInuvwHhZ6bylr23h+gZx37zJeJlLVbwuVyr9qMZ3xVkiu27svLX77t
   OivYyUMJNL/MGGNFEq8FmGKH7YPJrqBMy5OsWQSsCPaHM6l8bvAYnbsy2
   pDRNzCP/3jtzvsHaUQrA1JvPLCJPDyYKDum9dL/+ceK93fATodfhRQwHH
   6liTxx49lGfD0b32p9k1EfNtXfBX4KNRz3fj8lZhUtvdN1sV6wx8eQxFe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="351452877"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="351452877"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 23:29:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="674991629"
Received: from yilinhua-mobl1.ccr.corp.intel.com ([10.254.215.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 23:29:25 -0700
Message-ID: <deb904ae622792fbc1d05f70e89e57838fa84c68.camel@intel.com>
Subject: Re: [PATCH v3 3/7] drivers/base/node: Add support to write
 node_states[] via sysfs
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com
Date:   Sun, 24 Apr 2022 14:29:21 +0800
In-Reply-To: <20220422195516.10769-4-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
         <20220422195516.10769-4-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
> Current /sys/devices/system/node/* interface doesn't support
> to write node_states[], however write support is needed in case
> users want to set them manually e.g. when user want to override
> default N_DEMOTION_TARGETS found by the kernel.
> 
> Rename existing _NODE_ATTR to _NODE_ATTR_RO and introduce new
> _NODE_ATTR_RW which can be used for node_states[] which can
> be written from sysfs.
> 
> It may be necessary to validate written values and take action
> based on them in a state specific way so a callback 'write' is
> introduced in 'struct node_attr'.
> 
> A new function demotion_targets_write() is added to validate
> the input nodes for N_DEMOTION_TARGETS which should be subset
> of N_MEMORY and to build new demotion list based on new nodes.
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>

How about discussing the ABI design firstly?  I started a discussion in
the following thread.  I think we can start with the requirements.

https://lore.kernel.org/lkml/200e95cf36c1642512d99431014db8943fed715d.camel@intel.com/

Best Regards,
Huang, Ying

> ---
>  drivers/base/node.c | 62 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6eef22e6413e..e03eedbc421b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> +#include <linux/migrate.h>
>  
> 
> 
> 
>  static struct bus_type node_subsys = {
>  	.name = "node",
> @@ -1013,6 +1014,7 @@ void unregister_one_node(int nid)
>  struct node_attr {
>  	struct device_attribute attr;
>  	enum node_states state;
> +	int (*write)(nodemask_t nodes);
>  };
>  
> 
> 
> 
>  static ssize_t show_node_state(struct device *dev,
> @@ -1024,23 +1026,57 @@ static ssize_t show_node_state(struct device *dev,
>  			  nodemask_pr_args(&node_states[na->state]));
>  }
>  
> 
> 
> 
> -#define _NODE_ATTR(name, state) \
> -	{ __ATTR(name, 0444, show_node_state, NULL), state }
> +static ssize_t store_node_state(struct device *s,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	nodemask_t nodes;
> +	struct node_attr *na = container_of(attr, struct node_attr, attr);
> +
> +	if (nodelist_parse(buf, nodes))
> +		return -EINVAL;
> +
> +	if (na->write) {
> +		if (na->write(nodes))
> +			return -EINVAL;
> +	} else {
> +		node_states[na->state] = nodes;
> +	}
> +
> +	return count;
> +}
> +
> +static int demotion_targets_write(nodemask_t nodes)
> +{
> +	if (nodes_subset(nodes, node_states[N_MEMORY])) {
> +		node_states[N_DEMOTION_TARGETS] = nodes;
> +		set_migration_target_nodes();
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +#define _NODE_ATTR_RO(name, state) \
> +	{ __ATTR(name, 0444, show_node_state, NULL), state, NULL }
> +
> +#define _NODE_ATTR_RW(name, state, write_fn) \
> +	{ __ATTR(name, 0644, show_node_state, store_node_state), state, write_fn }
>  
> 
> 
> 
>  static struct node_attr node_state_attr[] = {
> -	[N_POSSIBLE] = _NODE_ATTR(possible, N_POSSIBLE),
> -	[N_ONLINE] = _NODE_ATTR(online, N_ONLINE),
> -	[N_NORMAL_MEMORY] = _NODE_ATTR(has_normal_memory, N_NORMAL_MEMORY),
> +	[N_POSSIBLE] = _NODE_ATTR_RO(possible, N_POSSIBLE),
> +	[N_ONLINE] = _NODE_ATTR_RO(online, N_ONLINE),
> +	[N_NORMAL_MEMORY] = _NODE_ATTR_RO(has_normal_memory, N_NORMAL_MEMORY),
>  #ifdef CONFIG_HIGHMEM
> -	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
> +	[N_HIGH_MEMORY] = _NODE_ATTR_RO(has_high_memory, N_HIGH_MEMORY),
>  #endif
> -	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
> -	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
> -	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
> -					   N_GENERIC_INITIATOR),
> -	[N_DEMOTION_TARGETS] = _NODE_ATTR(demotion_targets,
> -					  N_DEMOTION_TARGETS),
> -
> +	[N_MEMORY] = _NODE_ATTR_RO(has_memory, N_MEMORY),
> +	[N_CPU] = _NODE_ATTR_RO(has_cpu, N_CPU),
> +	[N_GENERIC_INITIATOR] = _NODE_ATTR_RO(has_generic_initiator,
> +					      N_GENERIC_INITIATOR),
> +	[N_DEMOTION_TARGETS] = _NODE_ATTR_RW(demotion_targets,
> +					     N_DEMOTION_TARGETS,
> +					     demotion_targets_write),
>  };
>  
> 
> 
> 
>  static struct attribute *node_state_attrs[] = {


