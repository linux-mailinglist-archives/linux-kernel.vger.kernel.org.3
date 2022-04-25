Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CCC50DD06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiDYJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiDYJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:46:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B7331522
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:43:03 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P7Q8VO025664;
        Mon, 25 Apr 2022 09:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=R4ypEaMOQY0KHvd2uV7dSmLY8n6xA4dFgKZ1nSotTI4=;
 b=f53wI8en5/EqT+SImdTTAiPovDdkHBd5HDeSvICUiMYQjIQeR+qWMdL+3Gvy8bfrMCmW
 hO93Z/YrxVE3OMEM7fOope6018wodh2dGce+pa1Ey1Z8bq2y9hbZnvtDcimruAcSlsDy
 leWcrHthoSZgqOXmKLy1hEMbxe+7zi8+fjl726IuXNBMnhknTzqhSADJpgR6RlFjLCHt
 mqP8ncGNx074c+kxouMQLdPyJ0DTSqwbPQ8NHsfDQaU7hJ3WJLhu/g76jjr4RYzMKeyd
 1Ok8AXnbokaJeNQIeOhvrA7BU678yhNZtfQrwTxBRAwBSag0qrl+5e2BbKxKnuYn+h43 Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnq8k2qvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:42:59 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23P8jgHX009391;
        Mon, 25 Apr 2022 09:42:58 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnq8k2que-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:42:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P9RHS6026836;
        Mon, 25 Apr 2022 09:42:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj25sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:42:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23P9grBK41222538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 09:42:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCFF34C046;
        Mon, 25 Apr 2022 09:42:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A3084C040;
        Mon, 25 Apr 2022 09:42:51 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.47.198])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 09:42:50 +0000 (GMT)
Date:   Mon, 25 Apr 2022 15:12:44 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com
Subject: Re: [PATCH v3 3/7] drivers/base/node: Add support to write
 node_states[] via sysfs
Message-ID: <YmZtFDMJO5Kmt/0u@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <20220422195516.10769-4-jvgediya@linux.ibm.com>
 <87o80rgfpy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o80rgfpy.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: evQEf24PuF_IuaVM4_ueBWBr80G7uCpJ
X-Proofpoint-GUID: aI2qlSCqcncFzpzDsqotX5LWGCEds5lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 11:55:45AM +0530, Aneesh Kumar K.V wrote:
> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
> 
> > Current /sys/devices/system/node/* interface doesn't support
> > to write node_states[], however write support is needed in case
> > users want to set them manually e.g. when user want to override
> > default N_DEMOTION_TARGETS found by the kernel.
> >
> > Rename existing _NODE_ATTR to _NODE_ATTR_RO and introduce new
> > _NODE_ATTR_RW which can be used for node_states[] which can
> > be written from sysfs.
> >
> > It may be necessary to validate written values and take action
> > based on them in a state specific way so a callback 'write' is
> > introduced in 'struct node_attr'.
> >
> > A new function demotion_targets_write() is added to validate
> > the input nodes for N_DEMOTION_TARGETS which should be subset
> > of N_MEMORY and to build new demotion list based on new nodes.
> >
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > ---
> >  drivers/base/node.c | 62 +++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 49 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 6eef22e6413e..e03eedbc421b 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/swap.h>
> >  #include <linux/slab.h>
> > +#include <linux/migrate.h>
> >  
> >  static struct bus_type node_subsys = {
> >  	.name = "node",
> > @@ -1013,6 +1014,7 @@ void unregister_one_node(int nid)
> >  struct node_attr {
> >  	struct device_attribute attr;
> >  	enum node_states state;
> > +	int (*write)(nodemask_t nodes);
> >  };
> >  
> >  static ssize_t show_node_state(struct device *dev,
> > @@ -1024,23 +1026,57 @@ static ssize_t show_node_state(struct device *dev,
> >  			  nodemask_pr_args(&node_states[na->state]));
> >  }
> >  
> > -#define _NODE_ATTR(name, state) \
> > -	{ __ATTR(name, 0444, show_node_state, NULL), state }
> > +static ssize_t store_node_state(struct device *s,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t count)
> > +{
> > +	nodemask_t nodes;
> > +	struct node_attr *na = container_of(attr, struct node_attr, attr);
> > +
> > +	if (nodelist_parse(buf, nodes))
> > +		return -EINVAL;
> > +
> > +	if (na->write) {
> > +		if (na->write(nodes))
> > +			return -EINVAL;
> > +	} else {
> > +		node_states[na->state] = nodes;
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +static int demotion_targets_write(nodemask_t nodes)
> > +{
> > +	if (nodes_subset(nodes, node_states[N_MEMORY])) {
> > +		node_states[N_DEMOTION_TARGETS] = nodes;
> > +		set_migration_target_nodes();
> > +		return 0;
> > +	}
> 
> Does this require locking to avoid upating
> node_states[N_DEMOTION_TARGETS] while a parallel
> set_migratiotn_target_nodes() is running. 

I think locking is needed if set_migratiotn_target_nodes() is called
form here because currently exclusion is provided by memory hotplug
events being single-threaded, but as this path is not hot-plug event,
separate lock is needed.

> > +
> > +	return -EINVAL;
> > +}
> > +
> > +#define _NODE_ATTR_RO(name, state) \
> > +	{ __ATTR(name, 0444, show_node_state, NULL), state, NULL }
> > +
> > +#define _NODE_ATTR_RW(name, state, write_fn) \
> > +	{ __ATTR(name, 0644, show_node_state, store_node_state), state, write_fn }
> >  
> >  static struct node_attr node_state_attr[] = {
> > -	[N_POSSIBLE] = _NODE_ATTR(possible, N_POSSIBLE),
> > -	[N_ONLINE] = _NODE_ATTR(online, N_ONLINE),
> > -	[N_NORMAL_MEMORY] = _NODE_ATTR(has_normal_memory, N_NORMAL_MEMORY),
> > +	[N_POSSIBLE] = _NODE_ATTR_RO(possible, N_POSSIBLE),
> > +	[N_ONLINE] = _NODE_ATTR_RO(online, N_ONLINE),
> > +	[N_NORMAL_MEMORY] = _NODE_ATTR_RO(has_normal_memory, N_NORMAL_MEMORY),
> >  #ifdef CONFIG_HIGHMEM
> > -	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
> > +	[N_HIGH_MEMORY] = _NODE_ATTR_RO(has_high_memory, N_HIGH_MEMORY),
> >  #endif
> > -	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
> > -	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
> > -	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
> > -					   N_GENERIC_INITIATOR),
> > -	[N_DEMOTION_TARGETS] = _NODE_ATTR(demotion_targets,
> > -					  N_DEMOTION_TARGETS),
> > -
> > +	[N_MEMORY] = _NODE_ATTR_RO(has_memory, N_MEMORY),
> > +	[N_CPU] = _NODE_ATTR_RO(has_cpu, N_CPU),
> > +	[N_GENERIC_INITIATOR] = _NODE_ATTR_RO(has_generic_initiator,
> > +					      N_GENERIC_INITIATOR),
> > +	[N_DEMOTION_TARGETS] = _NODE_ATTR_RW(demotion_targets,
> > +					     N_DEMOTION_TARGETS,
> > +					     demotion_targets_write),
> >  };
> >  
> >  static struct attribute *node_state_attrs[] = {
> > -- 
> > 2.35.1
