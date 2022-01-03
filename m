Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7084838C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiACWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:16:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60624 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbiACWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:16:16 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203K1bTn031507;
        Mon, 3 Jan 2022 22:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=v5TBhBtHIke9Y2bK8IPq6cFGotjMjqI/zf2qDUSwyR8=;
 b=JlHldi63CS8RkN64sqy42Pu1qicKLBRU6RvFq84n722pBhxB4CSETCh7fcRSWuABAXIN
 oCfbpWaDmePbBkbF11QCPU+IQqMB6nTlnZhq8U8dKbCfZWLUqkvrlp7ZIc4+XOAal5Bl
 KGvUdHo9FXCctqjjG+w/y76ExNc4RddRv5p7kIsnc9+yDkgAH/9RnuPUWUSY6gWJcp2U
 hPjh1OfiVoY6cfZbjYDAW9mLzITmi2VTLiFKu5vStTsgLEYkzwWB1BMmdbq9mx8KpNJz
 gBLyYOF0bhqBXTVdx6fRzzk01D6XbHKaGUrYmbCoJ6ieE+NYGqiw7Oe0+X2JzjbCzIqe VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4gtwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 22:16:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203MG1UH087464;
        Mon, 3 Jan 2022 22:16:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3dad0cnu7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 22:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlejhgF7ncIUuBcoA2qbXtjPnJFNuMyygY4tVpZpI75bT+3R51MBo9FyEZF9wjRsVDldA2yHqcWA/QHzJkM9R/XcR+SUbQMj4tJwbSqHNKOTS03OQ/jU0UJBD/0fDwQ/Wb2FBSmSu9/grh8dpjO8KCkElff3fL96nNueXOATQpgeHWnNZcsjf9R7C6/dhC+/D3+mPkhLCdUMhS9tUqsbNDJEaDYojEUJdHE/aK/qEk/GtyELNR8vUabb5dQ2rMIyzTTuQK+xSTY3yOVoJ7ThV3K164+LSH4HCBs0Pli5bpMi69fz/VcaNlrAMvZvmJRMrcdcBS/Yt4Xi/vospRyBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5TBhBtHIke9Y2bK8IPq6cFGotjMjqI/zf2qDUSwyR8=;
 b=UbZk7B5rxV7WJ18XAwfpyAqEVjztTAPSF2BrYmqSSefQd/J+BURJHM9A93rouZx/ILADl8a4YO/WARLDpcvK0puwbC8VbFxtY4Z93TqeOe1beohvnpJgNVdKNELjVI6OwQg1aqnKTijek/tiy3uNIjVzUg8ReiS85rNcgCX8mXYvuaenwo+z3ZQu0zMQmYjCk/l0NtzNNv6KMhSMHHoGSpnm+FWcuxwxEVDWg0QDuU0JELMggL/52Ow0upWpoxVI7ufITDQ+Y1gnwz78B2bhJ5OavcEmeNV/Wiog/W4GQ+TxCk7uwzVBexdeK+Lp/KFgsTQF0LV3R/AYDig+GKaaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5TBhBtHIke9Y2bK8IPq6cFGotjMjqI/zf2qDUSwyR8=;
 b=TpGn6d01U7akIoWFsaWr9yVEQ1SrCN4n0VwcCUm5tyyBVyRlovpTs8X2rWNO8V6Oa1Ovu6P5vu6bWOs9nlcuukAg4BQFm7rYdK0ZMMod4XvRszPJAMjpqi6rXs1+97OkaQTyD00i+BSFRZJLBmsZHt4ybuzTVvRtjo293YdG9rg=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO6PR10MB5410.namprd10.prod.outlook.com (2603:10b6:303:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 22:16:10 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 22:16:09 +0000
Message-ID: <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
Date:   Tue, 4 Jan 2022 09:16:03 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YdLH6qQNxa11YmRO@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:805:66::46) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7de69149-a162-4df2-0a13-08d9cf06a4f0
X-MS-TrafficTypeDiagnostic: CO6PR10MB5410:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB541020256545CDB033E5CB9FB0499@CO6PR10MB5410.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87rCTKikj6p+XNxLJweHsKPO9Z2zeleY2ojBQshiFprO/nyp44SR6QbfCaf3UrRFtXG2Jr2aZLN05IdBeQSsgSPt02YRbIIUdFCd5GSIJhUtBExYKzuXNYQyeA8MYgIfUdiuMVLLyQF5ouHsKt/lYrubxYOJk/DG1Md2MqlwgVSli5onIIu1a6SqO11HmAuLu/wF+gm7z8vQGCvncHcYg6G73cykV6N7LvuHshz+ElDjGu2kz2fRhn0Aw8vj0U3OiFNs0i6uYC4FsqV/KRN9LCKA4HI7lWgw+3r+ICmPTXq6iye4VqgDtOrAKhCphoL6eveGF4wgTYL1Ord+NkG9frMXa05MJCfPojl0/a2leTuc2D5JmKSq1By2TzpZQPHDMUIFiT79LyEGhM0ZZmQ43oKrl+xN4QMN23pJsqpj8t4DVXx7aOKCtXz3SLpO3e0oXC43dwCQdW6ZEp3vB9Rpf4N0XEBfHpYvAoID3s+YzQ7ybm0CY4Xk8X2NketKqBGKQDbSrule7+lRbqdnu3LFUaSwRyo4S5z4NoMhgovp0XvwecIcS3hAz8ts8WP2B1Fl6Zds0cQbiTX5sBRPlUW++nGLhEhgBvqlwwwY9pRaRyX4PgjwMz4v8lR0qam4jBzD7pOIhJveeKydRkR5gLljOZG+3ORR3XKHJLvWrFGN1puDkX2iumIaRGloN2yeJdRcZf/Q/OX22adxuM+aOmds3u53AJNHF3KGnAj0miTsI1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8676002)(6506007)(53546011)(66946007)(4326008)(66476007)(508600001)(6512007)(2616005)(6666004)(5660300002)(316002)(8936002)(26005)(31686004)(186003)(83380400001)(2906002)(66556008)(6486002)(86362001)(31696002)(6916009)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnl3eVhFTFhCbnRrZGJ0UVZ6OVIyWStHRXhKbjFLTmhHVTA0anlidGo2NVdo?=
 =?utf-8?B?TjhxdTRmeDVpeVBLTUVnSGFXOVFRMVNKUWd3V2V2TDF2cVJ3Qk1FUHMwRitr?=
 =?utf-8?B?eTBraEl1NHpGUDg2bHlBYjZMQVVOWHpWekZYOXJvWExZbVM2TElMVEFpeUV3?=
 =?utf-8?B?eG9EcnM1bG0wSXBHd2F1cUN2alRudUFpYWJZV3ZNTWFIemxkWXc1Wk5iMlZi?=
 =?utf-8?B?cFE4VlV2UkNhNGhXSzE4enRaQ0VmdklqOWxWdTN5UWRVNUJ0R2R0SFQ3eHF1?=
 =?utf-8?B?RG9RaEFuQ2UycGswang0akljTEd0M2hOZWJ1aFVidU1CL2JMZlo3N1AxaG9i?=
 =?utf-8?B?cEowMFRzOUczY2lDdi8rbHRMdnd6ZVFHT3dPdkJ6TDJmcXVkVWxCVjFFOC8z?=
 =?utf-8?B?akdicFVLeDNxSjJlY05wWGNYTGdYMUJSWE13ekJwR3ZZSTZRNjJvbFZGSDR3?=
 =?utf-8?B?L0tGcjQza3JreE83elROSUxaenB2Q3YxMHpmZWxMOEZidS9GdlhOa09KQUhG?=
 =?utf-8?B?NEoycXp6UWZKMkhKVStuR25CejMxV1JCYnpIVHBSdkNlYmlFQjlpQUVYMktP?=
 =?utf-8?B?eGFiVkpjRjVnLzNueFltNGxRaGs2WUhvR0Z5NGR6Z2JxUlJlS2ZPREx6Y1VQ?=
 =?utf-8?B?Y2JuazJEaWZnMzZEWURJOC9kN1U4TEJrUXNlWmxOZGV1cWlvV0s1bE05dzk1?=
 =?utf-8?B?cUtKbktqcVAyRGV1bFF4TzZkeFhNV2Y5T2xDcW1LTzFzdENBUmFNWXJnejlG?=
 =?utf-8?B?eUxMVkgrVkVuY2FRZUxmeldJMVk4UnRNd3BLc1VSbDdXbGxnN0p6dWxkL0RJ?=
 =?utf-8?B?NDNRODNWVGNFMUVlcG5OUnhSNWFSTVk3RTJOT3B2NVJMaHZxbm5JakFKdXBL?=
 =?utf-8?B?M1d4eDF0K0VKRmE1YjBrUGY3VXFQVGFaRjRnd0FBM2xmSTRldVZZdWZOQ0E2?=
 =?utf-8?B?bmI2bWU1OFllbHJNRnozNjhJOGFYMDFNaklzU3BFeGZJZkZzd29PbmJjTFAr?=
 =?utf-8?B?TEdwOGlzajdOYmwvdFJTajRwY083NzhtSGUrVUhXSmlnODA0dG93V2c1WEtI?=
 =?utf-8?B?UzdyZWRpbzgzUkVGSUFhUFJyclRBZTZwT01rRmV5SDQ4cGJDendrLytRT0JC?=
 =?utf-8?B?blVIKzhnWnluaklFaEJkSzh3V3FKd2NUL3QzbnFUS1lFeE5DWm5pVkxieTNq?=
 =?utf-8?B?dFNPUnVja2NoMnIxK05ndHVJRXJleHdSbktMQnNMWjBmcU5UZGZLN1cwVnNB?=
 =?utf-8?B?Y1YzOUNpSWxSR2dyT245NURmZFhJV0w1bXVXdENta29RWlNhL2J2ZW1YSmZZ?=
 =?utf-8?B?M0JiTXV2RmVzSi9oRFpFZ0lwV3BCaDk0VmltelVHS1I4QWZiQUVEM1krOFJ5?=
 =?utf-8?B?V3JmM1VMTHZyZ1lFNjh0dkVES1d2aU5xRmorK0FXT09aenRyYzBoQnJLTVkr?=
 =?utf-8?B?Sk51T3NSSmpPRGxLQjdlUkdNSCs3ZjlQWmUvV25QSDdEV2ZVOHNheklMRjB6?=
 =?utf-8?B?WDh0eDhiTDgwWTlDMFdXc2ZZZDYvWkRXdlNwT3QrKzE4RWwzbWlrcGpZZHRE?=
 =?utf-8?B?RWZDR1kzMEExaUNpYllZMUN4WFRZSkNYalRIRURTT0V1VHVyQUN3cFd0SnZ1?=
 =?utf-8?B?alpHOHZwR01STk1uUmpORE9mdkdwYmNqdEJGUnhJOTRqWHRBVHREWTlyN0p6?=
 =?utf-8?B?dEhOc0V3UDU3d28wUEFxVFM1aG1TTXJTMytjOEZRUHFvaDc2dkwwRmQzcGZw?=
 =?utf-8?B?bytCQlZtTWtiaHZCNDVyRmtEamZacWNIYnlyYUVWQm5MYmpURUI4Ymw2cVk3?=
 =?utf-8?B?SVk0Y0tvUFVPQlBRR3pjeFAxSzdTdGh0dURHV3VwNDB0emdtbG85d2FVdDhS?=
 =?utf-8?B?UTZ3WTdIWkpqajFURmo1cllUc0g4Q2wwcU5OQVJFZ3ZIR2ZaVS80cVJYRFFI?=
 =?utf-8?B?LzN3eU1ZZ3JhZWlneUNNSnRCVzBqSDJmNEJqSy9WRHdmWU51MTFLMzN4eHR1?=
 =?utf-8?B?RUFOOFZTeXZZZDYxeGZnV1RDRWdkcXJSak5SR0Y5YzVQWUEvZ3pCdDUwbGVN?=
 =?utf-8?B?YTZEMkY4Slo5Vmcxek05VlY1NG55d3gxV0QzZnAxWFRINmZQbGM2MVFSZW9R?=
 =?utf-8?B?ZnFmazM5eUpCeTVjRmppdmNORnZMVVZqQVZINlNaZUlONjRtK2JGODN2M1dm?=
 =?utf-8?Q?Hy0JodgbWRRQK6QZ6TJAN6w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de69149-a162-4df2-0a13-08d9cf06a4f0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 22:16:09.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6nrI4nPHFA3x8h4Mlh3hCnB3pTXozCEnPcPNgBlVueItABkEmY9fDLhbXr9V/L3MmLjTksMlbpgHJrydt3uOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030150
X-Proofpoint-GUID: 8u5BF3uaGHs7tlwjJA0tSPV5LvdVX4hX
X-Proofpoint-ORIG-GUID: 8u5BF3uaGHs7tlwjJA0tSPV5LvdVX4hX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/22 8:54 pm, Greg KH wrote:
> On Mon, Jan 03, 2022 at 07:45:43PM +1100, Imran Khan wrote:
>> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
>> index 861c4f0f8a29..5ed4c9ed39af 100644
>> --- a/include/linux/kernfs.h
>> +++ b/include/linux/kernfs.h
>> @@ -164,6 +164,8 @@ struct kernfs_node {
>>  	unsigned short		flags;
>>  	umode_t			mode;
>>  	struct kernfs_iattrs	*iattr;
>> +	spinlock_t kernfs_open_node_lock;
>> +	struct mutex kernfs_open_file_mutex;
> 
> Did you just blow up the memory requirements of a system with lots of
> kobjects created?
>> We used to be able to support tens of thousands of scsi devices in a
> 32bit kernel, with this change, what is the memory difference that just
> happened?
> 
Indeed, this patch increases kernfs_node size by 36 bytes ( 28 bytes for
mutex + 4 bytes for spinlock). From current kernfs_node size of 128
bytes, this will be a ~25% increase in kobjects memory consumption.
I can replace the mutex object with a pointer to it, to bring down
the overall increase in size. Will the size change be acceptable then?

> There is a tradeoff of memory usage and runtime contention that has to
> be made here, and this might be pushing it in the wrong direction for
> a lot of systems.
> 
Agree. Could you please suggest if this should be made configurable via
kconfig ? I understand that this would result in 2 versions of some
functions but it will allow systems with large memories to avoid kernfs
contention.  We are seeing the launch time of some DB workloads
adversely getting affected with this contention.

Also based on recent movement of kernfs_rwsem into kernfs_root, do you
think that the above mentioned mutex and spinlock can be moved to
kernfs_root as well. Although that change would not help in my current
case, but it could avoid similar contentions between different users of
kernfs like cgroup and sysfs

Thanks.
 -- Imran

> thanks,
> 
> greg k-h
