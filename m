Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C8B500AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiDNKWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiDNKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:22:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580053ED05
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:20:17 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EA4xDx021537;
        Thu, 14 Apr 2022 10:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=aNpphxHThkzEtrZc2fLcC5ErHlMuuPFyRh1X8QdZc0g=;
 b=HCCEn2npDif1IC2xZZF3RsIVJydUGLqCPyjUNYP71u1GtfLhrLP6R9roQK8Qp9iGzQYy
 r/7893StWqLttb3vNdLVLIw7rfI2RpLC1rAcxiFbvD0lOVJMAPVTNxP1lNvTDl0Ahjen
 1DQCyWcrw/tUkt68jin2LjJ9/T9NDGOn9fa1bk2M6lccQ9DXjSJ10beza/W3s6cFf1aO
 CTdQJaOfUVhxCgweC0QEHt+TthR8blH/+0zcCLGbjSuL1DO0PuunM1bWEFkIW3St0rQG
 XNOvn10kVvwn5kJzU3EkpHiz8G+8k4MrGyG0GCDgu2csjMO09J2LHa+ar5tdidmPYFli nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fegst17qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:20:12 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23EA5ZJd023612;
        Thu, 14 Apr 2022 10:20:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fegst17pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:20:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EAI6j2023448;
        Thu, 14 Apr 2022 10:20:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s9075n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:20:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23EAK7lw16253360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 10:20:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 928AE11C04C;
        Thu, 14 Apr 2022 10:20:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9047B11C04A;
        Thu, 14 Apr 2022 10:20:03 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.11.20])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Apr 2022 10:20:03 +0000 (GMT)
Date:   Thu, 14 Apr 2022 15:49:55 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, Yang Shi <shy828301@gmail.com>,
        Wei Xu <weixugc@google.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <Ylf1S+Pw2W5USCgI@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j6HWoYtydV3sjd5YznKZ_Kjio3UbNdot
X-Proofpoint-ORIG-GUID: IjcSua9KDGlkV8qZtMD7-UYa3faF24PK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_02,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:00:46PM +0800, ying.huang@intel.com wrote:
> On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > Current implementation to find the demotion targets works
> > based on node state N_MEMORY, however some systems may have
> > dram only memory numa node which are N_MEMORY but not the
> > right choices as demotion targets.
> > 
> > This patch series introduces the new node state
> > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > is used to hold the list of nodes which can be used as demotion
> > targets, support is also added to set the demotion target
> > list from user space so that default behavior can be overridden.
> 
> It appears that your proposed user space interface cannot solve all
> problems.  For example, for system as follows,
> 
> Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
> node 0,
> 
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus:
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 2 3
> node 2 size: n MB
> node 2 free: n MB
> node distances:
> node   0   1   2
>   0:  10  40  20
>   1:  40  10  80
>   2:  20  80  10
> 
> Demotion order 1:
> 
> node    demotion_target
>  0              1
>  1              X
>  2              X
> 
> Demotion order 2:
> 
> node    demotion_target
>  0              1
>  1              X
>  2              1
> 
> The demotion order 1 is preferred if we want to reduce cross-socket
> traffic.  While the demotion order 2 is preferred if we want to take
> full advantage of the slow memory node.  We can take any choice as
> automatic-generated order, while make the other choice possible via user
> space overridden.
> 
> I don't know how to implement this via your proposed user space
> interface.  How about the following user space interface?
> 
> 1. Add a file "demotion_order_override" in
>         /sys/devices/system/node/
> 
> 2. When read, "1" is output if the demotion order of the system has been
> overridden; "0" is output if not.
> 
> 3. When write "1", the demotion order of the system will become the
> overridden mode.  When write "0", the demotion order of the system will
> become the automatic mode and the demotion order will be re-generated. 
> 
> 4. Add a file "demotion_targets" for each node in
>         /sys/devices/system/node/nodeX/
> 
> 5. When read, the demotion targets of nodeX will be output.
> 
> 6. When write a node list to the file, the demotion targets of nodeX
> will be set to the written nodes.  And the demotion order of the system
> will become the overridden mode.
> 
> To reduce the complexity, the demotion order of the system is either in
> overridden mode or automatic mode.  When converting from the automatic
> mode to the overridden mode, the existing demotion targets of all nodes
> will be retained before being changed.  When converting from overridden
> mode to automatic mode, the demotion order of the system will be re-
> generated automatically.
> 
> In overridden mode, the demotion targets of the hot-added and hot-
> removed node will be set to empty.  And the hot-removed node will be
> removed from the demotion targets of any node.
> 
> This is an extention of the interface used in the following patch,
> 
> https://lore.kernel.org/lkml/20191016221149.74AE222C@viggo.jf.intel.com/
> 
> What do you think about this?

It looks good, will implement in next version.

> > node state N_DEMOTION_TARGETS is also set from the dax kmem
> > driver, certain type of memory which registers through dax kmem
> > (e.g. HBM) may not be the right choices for demotion so in future
> > they should be distinguished based on certain attributes and dax
> > kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> > however current implementation also doesn't distinguish any 
> > such memory and it considers all N_MEMORY as demotion targets
> > so this patch series doesn't modify the current behavior.
> > 
> 
> Best Regards,
> Huang, Ying
> 
> [snip]
> 
Best regards,
Jagdish
