Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3290A48E38C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiANFW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:22:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbiANFWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:22:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20E4fKP4011211;
        Fri, 14 Jan 2022 05:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=GU/FKNbFwLs/b5lIMVaEWTo4/R6UQBdKJknPAPObmBU=;
 b=sj3jYsZtvf3NqZPIstlapKRyNfNBOBaagJu2XZh40HsKTZCBs8JllFP6lZHZ1GdXKbpl
 Og35YNNyPmAkGzZlsoiUsuAAbzruIpKqcoGDnafnaJ99pZmiuhpyfYSVsLi5H+zvNnbb
 2Yw360g5kuxE42s4WXRfF17wGACwYvUiTEEHpnL6rZUfmD+tlxFLcqmqxkGsr/cOE4Kh
 GEEPkpH6EV/YccpudT1YXLxq4cr3Vu75ufXgIaakvLe9/wzHnL8O/FRaSnSGbWtr91+S
 GhLnmDDlM+IvLKmpr220xpRTv2pGSgtz6+u2UseJlvTLuh9QNU8pnBPk5TwWtPVfJim1 bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dk1ncs7qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 05:21:20 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20E552nV008520;
        Fri, 14 Jan 2022 05:21:20 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dk1ncs7q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 05:21:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20E5Jekp016537;
        Fri, 14 Jan 2022 05:20:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3df28caq0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 05:20:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20E5KG988979420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 05:20:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A723DB2068;
        Fri, 14 Jan 2022 05:20:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 208AFB2066;
        Fri, 14 Jan 2022 05:20:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.70.147])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jan 2022 05:20:07 +0000 (GMT)
X-Mailer: emacs 28.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 8/9] mm: multigenerational lru: user interface
In-Reply-To: <YeCvd4UBPy27SYGZ@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
 <87a6g0nczg.fsf@linux.ibm.com> <YeCvd4UBPy27SYGZ@google.com>
Date:   Fri, 14 Jan 2022 10:50:05 +0530
Message-ID: <877db2opve.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w0zLCMx7I8ACP2bcHnPMWQfTMXA4eiBN
X-Proofpoint-GUID: diAQzLOWBg25n-lH32_6yQSkFrBmtws_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_01,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxlogscore=986 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Thu, Jan 13, 2022 at 04:01:31PM +0530, Aneesh Kumar K.V wrote:
>> Yu Zhao <yuzhao@google.com> writes:
>> 
>> > Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.
>> 
>> 
>> Got the below lockdep warning while using the above kill/enable switch
>> 
>> 
>> [   84.252952] ======================================================
>> [   84.253012] WARNING: possible circular locking dependency detected
>> [   84.253074] 5.16.0-rc8-16204-g1cdcf1120b31 #511 Not tainted
>> [   84.253135] ------------------------------------------------------
>> [   84.253194] bash/2862 is trying to acquire lock:
>> [   84.253243] c0000000021ff740 (cgroup_mutex){+.+.}-{3:3}, at: store_enable+0x80/0x1510
>> [   84.253340]
>>                but task is already holding lock:
>> [   84.253410] c000000002221348 (mem_hotplug_lock){++++}-{0:0}, at: mem_hotplug_begin+0x30/0x50
>> [   84.253503]
>>                which lock already depends on the new lock.
>> 
>> [   84.255933] Chain exists of:
>>                  cgroup_mutex --> cpu_hotplug_lock --> mem_hotplug_lock
>
> Thanks. Will reverse the order between mem_hotplug_lock and
> cgroup_mutex in the next spin.

It also needs the unlocked variant of static_key_enable/disable.

[   71.204397][ T2819] bash/2819 is trying to acquire lock:                                       
[   71.204446][ T2819] c0000000020e5cd0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_disable+0x24/0x50
[   71.204542][ T2819]                                                                                                 
[   71.204542][ T2819] but task is already holding lock:                                                               
[   71.204613][ T2819] c0000000020e5cd0 (cpu_hotplug_lock){++++}-{0:0}, at: mem_hotplug_begin+0x20/0x50
[   71.204710][ T2819]                                                                                                 
[   71.204710][ T2819] other info that might help us debug this:
[   71.204787][ T2819]  Possible unsafe locking scenario:
[   71.204787][ T2819]                    
[   71.204860][ T2819]        CPU0                                                                                                                                                                                                            
[   71.204901][ T2819]        ----
[   71.204941][ T2819]   lock(cpu_hotplug_lock);
[   71.204998][ T2819]   lock(cpu_hotplug_lock);
[   71.205053][ T2819] 
[   71.205053][ T2819]  *** DEADLOCK ***

-aneesh
