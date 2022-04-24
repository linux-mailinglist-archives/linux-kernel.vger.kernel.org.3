Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3981550D00C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiDXG3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbiDXG27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:28:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCB140E2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:26:00 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23NNN31r015432;
        Sun, 24 Apr 2022 06:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=LZJlq9zwnUkZtE+F5OhAKjewzlr3Qmgy6mt3uTKQ3mg=;
 b=tJU5prwkyOwTo2WlZg0r7JOMQqNgXBRMgm0IU7ryUiuvlHFLrnj3Q3tc0f/NDFrIpzWa
 kR30aioCaZWrmCXghJMxcHFqnwj6O9J/9GeN6Rk4D+ujP+0xh7t6eVRsg2FlEmJTMtWt
 1DZAeEbSD9t6W3RtAvDUOrVNo/zzMSJjFekauq/4mjfmBS374jHSqV79iuTbL6eidLc5
 T05FeMduzwMlob5Dq2kWA6JXX7+JC0mNHZUTEACcj8JMTdT8wLMBOIzYrE0yZMPIe/mY
 66M1f/fCgtF0DBDvQ3auSvUieDRQ+7F97+3JecqvlpcXWNJa4C9iLrT9HIjv2whiF45t Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmu333g36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Apr 2022 06:25:55 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23O6Ps8X027357;
        Sun, 24 Apr 2022 06:25:54 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmu333g31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Apr 2022 06:25:54 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23O6L6QH008235;
        Sun, 24 Apr 2022 06:25:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3fm939fubm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Apr 2022 06:25:53 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23O6Pqka24576398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Apr 2022 06:25:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D01ABE058;
        Sun, 24 Apr 2022 06:25:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20FC2BE04F;
        Sun, 24 Apr 2022 06:25:48 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.19.81])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 24 Apr 2022 06:25:47 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, shy828301@gmail.com, weixugc@google.com,
        gthelen@google.com, dan.j.williams@intel.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v3 3/7] drivers/base/node: Add support to write
 node_states[] via sysfs
In-Reply-To: <20220422195516.10769-4-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <20220422195516.10769-4-jvgediya@linux.ibm.com>
Date:   Sun, 24 Apr 2022 11:55:45 +0530
Message-ID: <87o80rgfpy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xSQO3BoPSK5Rnnk4FQylZxnF72s0ll3p
X-Proofpoint-ORIG-GUID: z7UN3MxzdvRBsja6F2Y5k_Xk2A-k7q9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-23_01,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204240028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jagdish Gediya <jvgediya@linux.ibm.com> writes:

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
> ---
>  drivers/base/node.c | 62 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6eef22e6413e..e03eedbc421b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> +#include <linux/migrate.h>
>  
>  static struct bus_type node_subsys = {
>  	.name = "node",
> @@ -1013,6 +1014,7 @@ void unregister_one_node(int nid)
>  struct node_attr {
>  	struct device_attribute attr;
>  	enum node_states state;
> +	int (*write)(nodemask_t nodes);
>  };
>  
>  static ssize_t show_node_state(struct device *dev,
> @@ -1024,23 +1026,57 @@ static ssize_t show_node_state(struct device *dev,
>  			  nodemask_pr_args(&node_states[na->state]));
>  }
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

Does this require locking to avoid upating
node_states[N_DEMOTION_TARGETS] while a parallel
set_migratiotn_target_nodes() is running. 

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
>  static struct node_attr node_state_attr[] = {
> -	[N_POSSIBLE] = _NODE_ATTR(possible, N_POSSIBLE),
> -	[N_ONLINE] = _NODE_ATTR(online, N_ONLINE),
> -	[N_NORMAL_MEMORY] = _NODE_ATTR(has_normal_memory, N_NORMAL_MEMORY),
> +	[N_POSSIBLE] = _NODE_ATTR_RO(possible, N_POSSIBLE),
> +	[N_ONLINE] = _NODE_ATTR_RO(online, N_ONLINE),
> +	[N_NORMAL_MEMORY] = _NODE_ATTR_RO(has_normal_memory, N_NORMAL_MEMORY),
>  #ifdef CONFIG_HIGHMEM
> -	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
> +	[N_HIGH_MEMORY] = _NODE_ATTR_RO(has_high_memory, N_HIGH_MEMORY),
>  #endif
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
>  };
>  
>  static struct attribute *node_state_attrs[] = {
> -- 
> 2.35.1
