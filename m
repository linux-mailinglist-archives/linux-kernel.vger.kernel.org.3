Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8D850F9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348720AbiDZKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348759AbiDZKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:14:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093C3BBE4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:37:59 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q9ENQC032233;
        Tue, 26 Apr 2022 09:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=N/+I1PjXq/A4RLYQ+1yEAck25zLJOjjxKFXP8Ic0FHU=;
 b=KwSiBZg2gzyYAPzEtFddRv63qQP6uly+XOs3op2bmvS+qAqZu9QMMhqVJ1952+3NmEV1
 cOPHIu4H2dCKuqCiu6AiDgxMJXY0sIuBAKLn92PijighY71az6tfT3AKrcdHkRdNpH4A
 kYxS6R9B5odnDh2duqeSB3r3TnOS9cW5QPz+AJuOoHYFFLBKoXWnQMJJssd+Uql9aY7c
 VUhjy9z2g7thDrOEby8IZTkUroe9kA7KygSgLN8IJLgvHnZzGg/vwnbz8dcepMQibRRL
 er8CGsDGOeMB5VZWAMi8bT0BMovPEE3e7Yt4Z/sA8Nd04MNCKzBP9M/f0GCMEiscRATn yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbhdkc27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:37:51 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q9Rdnq022886;
        Tue, 26 Apr 2022 09:37:51 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbhdkc1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:37:51 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q9SWGI022170;
        Tue, 26 Apr 2022 09:37:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3fm938u7fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:37:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q9bk5a40174018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 09:37:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A54FA11C04A;
        Tue, 26 Apr 2022 09:37:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8A1D11C050;
        Tue, 26 Apr 2022 09:37:43 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.82.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Apr 2022 09:37:43 +0000 (GMT)
Date:   Tue, 26 Apr 2022 15:07:36 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <Yme9YNZIek9dqnCs@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
 <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <085260285e48093f48d889994aaa500a78577bf2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <085260285e48093f48d889994aaa500a78577bf2.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gIaS9Mejq4kY3W0X8cQyqJJ4s7N93faE
X-Proofpoint-GUID: 4nk2Nor40V-4-MeYdlLWR4FLfz-9A7gD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxlogscore=745 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:55:36PM +0800, ying.huang@intel.com wrote:
> On Mon, 2022-04-25 at 16:45 +0530, Jagdish Gediya wrote:
> > On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
> > > On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
> > > > Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> > > > NUMA node which are N_MEMORY and slow memory(persistent memory)
> > > > only NUMA node which are also N_MEMORY. As the current demotion
> > > > target finding algorithm works based on N_MEMORY and best distance,
> > > > it will choose DRAM only NUMA node as demotion target instead of
> > > > persistent memory node on such systems. If DRAM only NUMA node is
> > > > filled with demoted pages then at some point new allocations can
> > > > start falling to persistent memory, so basically cold pages are in
> > > > fast memor (due to demotion) and new pages are in slow memory, this
> > > > is why persistent memory nodes should be utilized for demotion and
> > > > dram node should be avoided for demotion so that they can be used
> > > > for new allocations.
> > > > 
> > > > Current implementation can work fine on the system where the memory
> > > > only numa nodes are possible only for persistent/slow memory but it
> > > > is not suitable for the like of systems mentioned above.
> > > 
> > > Can you share the NUMA topology information of your machine?  And the
> > > demotion order before and after your change?
> > > 
> > > Whether it's good to use the PMEM nodes as the demotion targets of the
> > > DRAM-only node too?
> > 
> > $ numactl -H
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3 4 5 6 7
> > node 0 size: 14272 MB
> > node 0 free: 13392 MB
> > node 1 cpus:
> > node 1 size: 2028 MB
> > node 1 free: 1971 MB
> > node distances:
> > node   0   1
> >   0:  10  40
> >   1:  40  10
> > 
> > 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
> >    for 0 even when 1 is DRAM node and there is no demotion targets for 1.
> > 
> > $ cat /sys/bus/nd/devices/dax0.0/target_node
> > 2
> > $
> > # cd /sys/bus/dax/drivers/
> > :/sys/bus/dax/drivers# ls
> > device_dax  kmem
> > :/sys/bus/dax/drivers# cd device_dax/
> > :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
> > :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
> > :/sys/bus/dax/drivers/device_dax# numactl -H
> > available: 3 nodes (0-2)
> > node 0 cpus: 0 1 2 3 4 5 6 7
> > node 0 size: 14272 MB
> > node 0 free: 13380 MB
> > node 1 cpus:
> > node 1 size: 2028 MB
> > node 1 free: 1961 MB
> > node 2 cpus:
> > node 2 size: 0 MB
> > node 2 free: 0 MB
> > node distances:
> > node   0   1   2
> >   0:  10  40  80
> >   1:  40  10  80
> >   2:  80  80  10
> > 
> 
> This looks like a virtual machine, not a real machine.  That's
> unfortunate.  I am looking forward to a real issue, not a theoritical
> possible issue.
> 
> > 2) Once this new node brought online,  without N_DEMOTION_TARGETS
> > patch series, 1 is demotion target for 0 and 2 is demotion target
> > for 1.
> > 
> > With this patch series applied,
> > 1) No demotion target for either 0 or 1 before dax device is online
> > 2) 2 is demotion target for both 0 and 1 after dax device is online.
> > 
> 
> So with your change, if a node hasn't N_DEMOTION_TARGETS, it will become
> a top-level demotion source even if it hasn't N_CPU?  If so, I cannot
> clear N_DEMOTION_TARGETS for a node in middle or bottom level?

Yes, only N_MEMORY node also become demotion source because it is not
N_DEMOTION_TARGETS. You can clear N_DEMOTION_TARGETS from middle
or bottom but in that case, as the implementation works based on the
passes, cleared node will not be found as demotion target hence
demotion target will not be found for it, but does it make sense to
use faster persistent memory as demotion target leaving slowerer
persistent memory out of demotion list, if not, then it is not an
issue.

> Best Regards,
> Huang, Ying
> 
> > > 
> [snip]
> 
> 
> 
