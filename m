Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DE524714
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351081AbiELHg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351089AbiELHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:36:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B6322BF9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:36:49 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C640oA012149;
        Thu, 12 May 2022 07:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=sWPxOUMCtrF885mkcMhLxmucNHefmQGu8RUGsftx3+E=;
 b=MHuNYWJ9UhTziERjej4EZRjp5LFE9QKMvYJBLBCpFMeUyJz1KbxxYc6c+uIduunNiEI+
 8fTI4sNo70MAeXC472u6QV94gA4wDsWArXpb36X0Y+tX3ZTltB2v9n7zoFfkkBDR0/UW
 45GKbUOvGXe1F3IEpYtJkkG9+aSvagGWX6xoj3Cdk1J0L8XgpJM+DXdXBv5aiUTVjnvh
 S5R7M1oimFX7zFKzP4aI8uwioCej2HHAKTWL2Ynclhr0r2TSZu7krnCIQWhKXV2izOao
 V5zkJ1BJo99O+uk5K609e36C4uU0bcoIOKkVrzRtIM047vCfFUuQidRl5DPO43S69VLj oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0rcmdnr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 07:36:23 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24C7SxJ3026296;
        Thu, 12 May 2022 07:36:22 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0rcmdnqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 07:36:22 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24C7KRXH020085;
        Thu, 12 May 2022 07:36:21 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3fwgdasymx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 07:36:21 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24C7aKYH24576494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 07:36:20 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FAD26E060;
        Thu, 12 May 2022 07:36:20 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5231F6E04E;
        Thu, 12 May 2022 07:36:13 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.96.94])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 07:36:12 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Wei Xu <weixugc@google.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
In-Reply-To: <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
 <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
 <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
Date:   Thu, 12 May 2022 13:06:10 +0530
Message-ID: <87y1z7jj85.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AuowE5mPoUqTDU3ID6VFxKdVpkr8UUhI
X-Proofpoint-ORIG-GUID: JzQJHaqMgmaIHuZUNN--X5eKjkwIpBU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Thu, May 12, 2022 at 12:12 AM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 5/12/22 12:33 PM, ying.huang@intel.com wrote:
>> > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
>> >> Sysfs Interfaces
>> >> ================
>> >>
>> >> * /sys/devices/system/memtier/memtierN/nodelist
>> >>
>> >>    where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
>> >>
>> >>    Format: node_list
>> >>
>> >>    Read-only.  When read, list the memory nodes in the specified tier.
>> >>
>> >>    Tier 0 is the highest tier, while tier 2 is the lowest tier.
>> >>
>> >>    The absolute value of a tier id number has no specific meaning.
>> >>    What matters is the relative order of the tier id numbers.
>> >>
>> >>    When a memory tier has no nodes, the kernel can hide its memtier
>> >>    sysfs files.
>> >>
>> >> * /sys/devices/system/node/nodeN/memtier
>> >>
>> >>    where N = 0, 1, ...
>> >>
>> >>    Format: int or empty
>> >>
>> >>    When read, list the memory tier that the node belongs to.  Its value
>> >>    is empty for a CPU-only NUMA node.
>> >>
>> >>    When written, the kernel moves the node into the specified memory
>> >>    tier if the move is allowed.  The tier assignment of all other nodes
>> >>    are not affected.
>> >>
>> >>    Initially, we can make this interface read-only.
>> >
>> > It seems that "/sys/devices/system/node/nodeN/memtier" has all
>> > information we needed.  Do we really need
>> > "/sys/devices/system/memtier/memtierN/nodelist"?
>> >
>> > That can be gotten via a simple shell command line,
>> >
>> > $ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'
>> >
>>
>> It will be really useful to fetch the memory tier node list in an easy
>> fashion rather than reading multiple sysfs directories. If we don't have
>> other attributes for memorytier, we could keep
>> "/sys/devices/system/memtier/memtierN" a NUMA node list there by
>> avoiding /sys/devices/system/memtier/memtierN/nodelist
>>
>> -aneesh
>
> It is harder to implement memtierN as just a file and doesn't follow
> the existing sysfs pattern, either.  Besides, it is extensible to have
> memtierN as a directory. 

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6248326f944d..251f38ec3816 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -1097,12 +1097,49 @@ static struct attribute *node_state_attrs[] = {
 	NULL
 };
 
+#define MAX_TIER 3
+nodemask_t memory_tier[MAX_TIER];
+
+#define _TIER_ATTR_RO(name, tier_index)					\
+	{ __ATTR(name, 0444, show_tier, NULL), tier_index, NULL }
+
+struct memory_tier_attr {
+	struct device_attribute attr;
+	int tier_index;
+	int (*write)(nodemask_t nodes);
+};
+
+static ssize_t show_tier(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct memory_tier_attr *mt = container_of(attr, struct memory_tier_attr, attr);
+
+	return sysfs_emit(buf, "%*pbl\n",
+			  nodemask_pr_args(&memory_tier[mt->tier_index]));
+}
+
 static const struct attribute_group memory_root_attr_group = {
 	.attrs = node_state_attrs,
 };
 
+
+#define TOP_TIER 0
+static struct memory_tier_attr memory_tiers[] = {
+	[0] = _TIER_ATTR_RO(memory_top_tier, TOP_TIER),
+};
+
+static struct attribute *memory_tier_attrs[] = {
+	&memory_tiers[0].attr.attr,
+	NULL
+};
+
+static const struct attribute_group memory_tier_attr_group = {
+	.attrs = memory_tier_attrs,
+};
+
 static const struct attribute_group *cpu_root_attr_groups[] = {
 	&memory_root_attr_group,
+	&memory_tier_attr_group,
 	NULL,
 };
 

As long as we have the ability to see the nodelist, I am good with the
proposal.

-aneesh
