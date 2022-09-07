Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36275AFDA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIGHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiIGHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75477B290;
        Wed,  7 Sep 2022 00:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D746C616EF;
        Wed,  7 Sep 2022 07:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D8C433D6;
        Wed,  7 Sep 2022 07:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662536131;
        bh=w4yJl1ATtBKrtZppiLS1T3dhPzUmlYqnc54i5qQ8Sps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rvsu/m0Cw3QykDlkVXEPIiFOzr14aMPdtu6rVrFUYLFCosaOuUO0tdDknWq9XcHvc
         57d6OdgRJND34T+1ga2dCJmNQW4wSjEvqUefUfa6zQpYQ3ReLDQigoZOmFR7JIkFZT
         g2zfN4+CoSC2AFQliouEgf4isQ0Z5iElfepniz1TLlBSzulGv2Sc3H9cDnRTDJo87K
         kPmY3zjs63kGUYaeOo4YJjJgUwyaJX6kOnEstx/jOEEDEjJxvCfL9+h+tx6r1Ibt4Z
         MfmMGUdyseAM9sifumz9HgIkpLS78lzLEqQognCEQDqurXQ8Ky2erUSL9Nkt1OOPrP
         ygRgUPqDUMWXg==
Message-ID: <3c8965c0-3bc0-252e-381d-bd057fd02af5@kernel.org>
Date:   Wed, 7 Sep 2022 10:35:26 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] interconnect: Replace mutex with rt_mutex
To:     Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_okukatla@quicinc.com
References: <20220906191423.30109-1-quic_mdtipton@quicinc.com>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220906191423.30109-1-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for the patch!

On 6.09.22 22:14, Mike Tipton wrote:
> Replace mutex with rt_mutex to prevent priority inversion between
> clients, which can cause unacceptable delays in some cases.

It would be nice if you have any numbers to share in the commit text.

> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
> 
> We've run into a number of cases internally and from customers where
> high priority, RT clients (typically display) become blocked for long
> periods of time on lower priority, non-RT clients. Switching to rt_mutex
> has proven to help performance in these cases.

I am wondering if avoiding the inversion on this specific lock is the right
solution, as there could be other locks that may cause similar issues. Do we
see similar issue with clocks for example or is it just with interconnects?

>   drivers/interconnect/core.c | 80 ++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 25debded65a8..a536c013d9ca 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -14,7 +14,7 @@
>   #include <linux/interconnect-provider.h>
>   #include <linux/list.h>
>   #include <linux/module.h>
> -#include <linux/mutex.h>
> +#include <linux/rtmutex.h>
>   #include <linux/slab.h>
>   #include <linux/of.h>
>   #include <linux/overflow.h>
> @@ -28,7 +28,7 @@ static DEFINE_IDR(icc_idr);
>   static LIST_HEAD(icc_providers);
>   static int providers_count;
>   static bool synced_state;
> -static DEFINE_MUTEX(icc_lock);
> +static DEFINE_RT_MUTEX(icc_lock);
>   static struct dentry *icc_debugfs_dir;
>   
>   static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
> @@ -47,7 +47,7 @@ static int icc_summary_show(struct seq_file *s, void *data)
>   	seq_puts(s, " node                                  tag          avg         peak\n");
>   	seq_puts(s, "--------------------------------------------------------------------\n");
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	list_for_each_entry(provider, &icc_providers, provider_list) {
>   		struct icc_node *n;
> @@ -73,7 +73,7 @@ static int icc_summary_show(struct seq_file *s, void *data)
>   		}
>   	}
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	return 0;
>   }
> @@ -104,7 +104,7 @@ static int icc_graph_show(struct seq_file *s, void *data)
>   	int i;
>   
>   	seq_puts(s, "digraph {\n\trankdir = LR\n\tnode [shape = record]\n");
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	/* draw providers as cluster subgraphs */
>   	cluster_index = 0;
> @@ -136,7 +136,7 @@ static int icc_graph_show(struct seq_file *s, void *data)
>   					icc_graph_show_link(s, 1, n,
>   							    n->links[i]);
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   	seq_puts(s, "}");
>   
>   	return 0;
> @@ -362,7 +362,7 @@ struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
>   	if (!spec)
>   		return ERR_PTR(-EINVAL);
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   	list_for_each_entry(provider, &icc_providers, provider_list) {
>   		if (provider->dev->of_node == spec->np) {
>   			if (provider->xlate_extended) {
> @@ -378,7 +378,7 @@ struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
>   			}
>   		}
>   	}
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	if (IS_ERR(node))
>   		return ERR_CAST(node);
> @@ -490,9 +490,9 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>   		return ERR_CAST(dst_data);
>   	}
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   	path = path_find(dev, src_data->node, dst_data->node);
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   	if (IS_ERR(path)) {
>   		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>   		goto free_icc_data;
> @@ -577,12 +577,12 @@ void icc_set_tag(struct icc_path *path, u32 tag)
>   	if (!path)
>   		return;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	for (i = 0; i < path->num_nodes; i++)
>   		path->reqs[i].tag = tag;
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_set_tag);
>   
> @@ -632,7 +632,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>   	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
>   		return -EINVAL;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	old_avg = path->reqs[0].avg_bw;
>   	old_peak = path->reqs[0].peak_bw;
> @@ -664,7 +664,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>   		apply_constraints(path);
>   	}
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	trace_icc_set_bw_end(path, ret);
>   
> @@ -682,12 +682,12 @@ static int __icc_enable(struct icc_path *path, bool enable)
>   	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
>   		return -EINVAL;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	for (i = 0; i < path->num_nodes; i++)
>   		path->reqs[i].enabled = enable;
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	return icc_set_bw(path, path->reqs[0].avg_bw,
>   			  path->reqs[0].peak_bw);
> @@ -726,7 +726,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
>   	struct icc_node *src, *dst;
>   	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	src = node_find(src_id);
>   	if (!src)
> @@ -748,7 +748,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
>   		path = ERR_PTR(-ENOMEM);
>   	}
>   out:
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   	return path;
>   }
>   EXPORT_SYMBOL_GPL(icc_get);
> @@ -773,14 +773,14 @@ void icc_put(struct icc_path *path)
>   	if (ret)
>   		pr_err("%s: error (%d)\n", __func__, ret);
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   	for (i = 0; i < path->num_nodes; i++) {
>   		node = path->reqs[i].node;
>   		hlist_del(&path->reqs[i].req_node);
>   		if (!WARN_ON(!node->provider->users))
>   			node->provider->users--;
>   	}
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	kfree_const(path->name);
>   	kfree(path);
> @@ -822,11 +822,11 @@ struct icc_node *icc_node_create(int id)
>   {
>   	struct icc_node *node;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	node = icc_node_create_nolock(id);
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	return node;
>   }
> @@ -840,7 +840,7 @@ void icc_node_destroy(int id)
>   {
>   	struct icc_node *node;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	node = node_find(id);
>   	if (node) {
> @@ -848,7 +848,7 @@ void icc_node_destroy(int id)
>   		WARN_ON(!hlist_empty(&node->req_list));
>   	}
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	kfree(node);
>   }
> @@ -876,7 +876,7 @@ int icc_link_create(struct icc_node *node, const int dst_id)
>   	if (!node->provider)
>   		return -EINVAL;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	dst = node_find(dst_id);
>   	if (!dst) {
> @@ -900,7 +900,7 @@ int icc_link_create(struct icc_node *node, const int dst_id)
>   	node->links[node->num_links++] = dst;
>   
>   out:
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	return ret;
>   }
> @@ -925,7 +925,7 @@ int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
>   	if (IS_ERR_OR_NULL(dst))
>   		return -EINVAL;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	for (slot = 0; slot < src->num_links; slot++)
>   		if (src->links[slot] == dst)
> @@ -946,7 +946,7 @@ int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
>   		ret = -ENOMEM;
>   
>   out:
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	return ret;
>   }
> @@ -962,7 +962,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   	if (WARN_ON(node->provider))
>   		return;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	node->provider = provider;
>   	list_add_tail(&node->node_list, &provider->nodes);
> @@ -988,7 +988,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   	node->avg_bw = 0;
>   	node->peak_bw = 0;
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_node_add);
>   
> @@ -998,11 +998,11 @@ EXPORT_SYMBOL_GPL(icc_node_add);
>    */
>   void icc_node_del(struct icc_node *node)
>   {
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	list_del(&node->node_list);
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_node_del);
>   
> @@ -1041,12 +1041,12 @@ int icc_provider_add(struct icc_provider *provider)
>   	if (WARN_ON(!provider->xlate && !provider->xlate_extended))
>   		return -EINVAL;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   
>   	INIT_LIST_HEAD(&provider->nodes);
>   	list_add_tail(&provider->provider_list, &icc_providers);
>   
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   
>   	dev_dbg(provider->dev, "interconnect provider added to topology\n");
>   
> @@ -1060,22 +1060,22 @@ EXPORT_SYMBOL_GPL(icc_provider_add);
>    */
>   void icc_provider_del(struct icc_provider *provider)
>   {
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   	if (provider->users) {
>   		pr_warn("interconnect provider still has %d users\n",
>   			provider->users);
> -		mutex_unlock(&icc_lock);
> +		rt_mutex_unlock(&icc_lock);
>   		return;
>   	}
>   
>   	if (!list_empty(&provider->nodes)) {
>   		pr_warn("interconnect provider still has nodes\n");
> -		mutex_unlock(&icc_lock);
> +		rt_mutex_unlock(&icc_lock);
>   		return;
>   	}
>   
>   	list_del(&provider->provider_list);
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_provider_del);
>   
> @@ -1110,7 +1110,7 @@ void icc_sync_state(struct device *dev)
>   	if (count < providers_count)
>   		return;
>   
> -	mutex_lock(&icc_lock);
> +	rt_mutex_lock(&icc_lock);
>   	synced_state = true;
>   	list_for_each_entry(p, &icc_providers, provider_list) {
>   		dev_dbg(p->dev, "interconnect provider is in synced state\n");
> @@ -1123,7 +1123,7 @@ void icc_sync_state(struct device *dev)
>   			}
>   		}
>   	}
> -	mutex_unlock(&icc_lock);
> +	rt_mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_sync_state);

We should also update Kconfig, otherwise i am expecting that the build will fail if
CONFIG_RT_MUTEXES is not enabled.

Thanks,
Georgi
