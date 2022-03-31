Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCD4ED419
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiCaGtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiCaGtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:49:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99CE1EDA1E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:47:13 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V3KCCT005044;
        Thu, 31 Mar 2022 06:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=4eLD8KWF+L403FOuygfdbWAfVw/1kOiQHwIP8k2QeXQ=;
 b=S5surkqnbx1XOKj24ec7z8+6dz2uDmu6X2Z9qnX41lGcfvKOhxqKRn5FDDlgBmnTpIfk
 w56/zVEUOBVBYCYZVF9kDz7YfEm2l3dLAuIz14wF6mt2iGD8N7XdVwpCdcUw6BcdIWT8
 hwFFlephx63oDVSPTWJwPdFEfxuOKp+1hDt3ugyyHdrM71yIW38do5r5GuqSOtyOUj2+
 CpKcl9ffLM6Vv6hwtoRqRhFv9ow0Gg+kXvKB0XgsAqZe72lXM7TZihVnX1xgyGTTyEhA
 RHBcsujKkXK8hGgLSoFgZzpMpDdhWnBpgJM0ucDxSvQ7FufkBOw0hNaLpbqci0FOVUOi Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f50smpre4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 06:46:05 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22V6eDYk002072;
        Thu, 31 Mar 2022 06:46:05 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f50smprdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 06:46:05 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22V6ddcd027459;
        Thu, 31 Mar 2022 06:46:04 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3f1tfab7a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 06:46:04 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22V6k3B57537438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 06:46:03 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EA10AC062;
        Thu, 31 Mar 2022 06:46:03 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EECCBAC05E;
        Thu, 31 Mar 2022 06:46:00 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.54.171])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 31 Mar 2022 06:46:00 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
In-Reply-To: <878rsrc672.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87lewrxsv1.fsf@linux.ibm.com>
 <878rsrc672.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Thu, 31 Mar 2022 12:15:58 +0530
Message-ID: <87ilruy5zt.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6ZHlFeB3Pcq-RuwWM0nJDbId8skoDD-M
X-Proofpoint-ORIG-GUID: 2SBiwj-h58iXE_tHH3HZBIQ6UeJyIviF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_02,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> Hi, Jagdish,
>>>
>>> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>>>
>>
>> ...
>>
>>>> e.g. with below NUMA topology, where node 0 & 1 are
>>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>>> only nodes, and node 4 is slowest memory only node,
>>>>
>>>> available: 5 nodes (0-4)
>>>> node 0 cpus: 0 1
>>>> node 0 size: n MB
>>>> node 0 free: n MB
>>>> node 1 cpus: 2 3
>>>> node 1 size: n MB
>>>> node 1 free: n MB
>>>> node 2 cpus:
>>>> node 2 size: n MB
>>>> node 2 free: n MB
>>>> node 3 cpus:
>>>> node 3 size: n MB
>>>> node 3 free: n MB
>>>> node 4 cpus:
>>>> node 4 size: n MB
>>>> node 4 free: n MB
>>>> node distances:
>>>> node   0   1   2   3   4
>>>>   0:  10  20  40  40  80
>>>>   1:  20  10  40  40  80
>>>>   2:  40  40  10  40  80
>>>>   3:  40  40  40  10  80
>>>>   4:  80  80  80  80  10
>>>>
>>>> The existing implementation gives below demotion targets,
>>>>
>>>> node    demotion_target
>>>>  0              3, 2
>>>>  1              4
>>>>  2              X
>>>>  3              X
>>>>  4		X
>>>>
>>>> With this patch applied, below are the demotion targets,
>>>>
>>>> node    demotion_target
>>>>  0              3, 2
>>>>  1              3, 2
>>>>  2              3
>>>>  3              4
>>>>  4		X
>>>
>>> For such machine, I think the perfect demotion order is,
>>>
>>> node    demotion_target
>>>  0              2, 3
>>>  1              2, 3
>>>  2              4
>>>  3              4
>>>  4              X
>>
>> I guess the "equally slow nodes" is a confusing definition here. Now if the
>> system consists of 2 1GB equally slow memory and the firmware doesn't want to
>> differentiate between them, firmware can present a single NUMA node
>> with 2GB capacity? The fact that we are finding two NUMA nodes is a hint
>> that there is some difference between these two memory devices. This is
>> also captured by the fact that the distance between 2 and 3 is 40 and not 10.
>
> Do you have more information about this?

Not sure I follow the question there. I was checking shouldn't firmware
do a single NUMA node if two memory devices are of the same type? How will
optane present such a config? Both the DIMMs will have the same
proximity domain value and hence dax kmem will add them to the same NUMA
node?

If you are suggesting that firmware doesn't do that, then I agree with you
that a demotion target like the below is good. 

 node    demotion_target
  0              2, 3
  1              2, 3
  2              4
  3              4
  4              X

We can also achieve that with a smiple change as below.

@@ -3120,7 +3120,7 @@ static void __set_migration_target_nodes(void)
 {
 	nodemask_t next_pass	= NODE_MASK_NONE;
 	nodemask_t this_pass	= NODE_MASK_NONE;
-	nodemask_t used_targets = NODE_MASK_NONE;
+	nodemask_t this_pass_used_targets = NODE_MASK_NONE;
 	int node, best_distance;
 
 	/*
@@ -3141,17 +3141,20 @@ static void __set_migration_target_nodes(void)
 	/*
 	 * To avoid cycles in the migration "graph", ensure
 	 * that migration sources are not future targets by
-	 * setting them in 'used_targets'.  Do this only
+	 * setting them in 'this_pass_used_targets'.  Do this only
 	 * once per pass so that multiple source nodes can
 	 * share a target node.
 	 *
-	 * 'used_targets' will become unavailable in future
+	 * 'this_pass_used_targets' will become unavailable in future
 	 * passes.  This limits some opportunities for
 	 * multiple source nodes to share a destination.
 	 */
-	nodes_or(used_targets, used_targets, this_pass);
+	nodes_or(this_pass_used_targets, this_pass_used_targets, this_pass);
 
 	for_each_node_mask(node, this_pass) {
+
+		nodemask_t used_targets = this_pass_used_targets;
+
 		best_distance = -1;
 
 		/*
