Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06844D7E48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiCNJLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbiCNJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05758433BB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:09:24 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22E8CiGe016403;
        Mon, 14 Mar 2022 09:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H/Mn6HRsNMhv+bwCByeF0mc91VKpGPpT7Vj7Y41dm4s=;
 b=Jqtg2OJKTCOFoIj5pAa472dsohGGqKuMdU+J8nWOCjRGbw2SIXjiFtL+vVQvelGzxaHG
 sbvRdojUtJQHGReXSy7cutbiNss15BSydRLQ2JrZ4bIsqIK3ElzwcRJktyKO1o4neDFq
 /Vpa4agSDU4MWKBuHf99DUkWJ6S8qXnNCQqhq2hT6rDpNOZ8nxeiVV3srWCMqX/1Vo8S
 3vqmkikdRyh7ypiEno9uWxQOM09R+8Qnrv5gzStOlNHnpSun1balpFwDjY67n+lLZk+E
 E0E/2JdE1yxvtSx/sZNVqontccmRZ9xYR/XHtPBoplIO8+9lQV0xRNPW0YbUlnfB/3Pb hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3es56gx0rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 09:09:17 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22E8ik7m026680;
        Mon, 14 Mar 2022 09:09:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3es56gx0r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 09:09:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22E97MC0010143;
        Mon, 14 Mar 2022 09:09:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3erk58k6vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 09:09:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22E99EJR36438466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 09:09:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EDEEA5A6B;
        Mon, 14 Mar 2022 09:09:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79FF4A5B26;
        Mon, 14 Mar 2022 09:09:08 +0000 (GMT)
Received: from [9.43.4.195] (unknown [9.43.4.195])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Mar 2022 09:09:08 +0000 (GMT)
Message-ID: <222c1c94-bc9a-a253-f408-937d02512151@linux.vnet.ibm.com>
Date:   Mon, 14 Mar 2022 14:39:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220310120749.23077-1-osalvador@suse.de>
 <20220310183951.cb713c6ae926ea6ea8489a71@linux-foundation.org>
 <c3b12235-b0ee-c5c5-b876-e96519786503@intel.com>
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
In-Reply-To: <c3b12235-b0ee-c5c5-b876-e96519786503@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J4Xk-0LqknNImNWTwo8-VSyS0boIhyBQ
X-Proofpoint-GUID: E0o5cit5g5tOz2AZZP5nCnAz9zyJR39e
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140059
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/03/22 22:40, Dave Hansen wrote:
> On 3/10/22 18:39, Andrew Morton wrote:
>> On Thu, 10 Mar 2022 13:07:49 +0100 Oscar Salvador <osalvador@suse.de> wrote:
>>> We do already have two CPU callbacks (vmstat_cpu_online() and vmstat_cpu_dead())
>>> that check exactly that, so get rid of the CPU callbacks in
>>> migrate_on_reclaim_init() and only call set_migration_target_nodes() from
>>> vmstat_cpu_{dead,online}() whenever a numa node change its N_CPU state.
>> What I'm not getting here (as so often happens) is a sense of how badly
>> this affects our users.  Does anyone actually hotplug frequently enough
>> to care?
> I asked Abhishek about this a bit here:
>
>> https://lore.kernel.org/all/4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com/
> It sounded to me like there are ppc users who convert their systems from
> SMT=1 to SMT=8.  I'd guess that they want to do this as a side-channel
> mitigation because ppc has been dealing with the same basic issues as
> those of us over in x86 land.  The increase in time (20s->36s) would be
> noticeable and probably slightly annoying to a human waiting on it.
>
> I'd love to hear more details on this from Abhishek, like whether end
> users do this as opposed to IBM's kernel developers.  But, it does sound
> deserving of a stable@ tag to me.
Yes, end users also use this, especially on large systems, might want
to switch between SMT=1, SMT=4 and SMT=8.
And this is also usable for dynamic LPAR operations.
As Dave pointed out, this increase in time while manageable and just
noticeable on smaller systems, can be very clearly observed as the
systems become larger.
