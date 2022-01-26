Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A749D0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiAZReW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:34:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243802AbiAZReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:34:20 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFocPo024339;
        Wed, 26 Jan 2022 17:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2q5tDZG63EP2PavLrlsfqVLtSsVknsFr+nG+9MUWtaw=;
 b=g3/dWra9vlHkQOto+JdHV1qKkN/Nl1xxUunpOtjR2ZAkzfzJngysSsG/8UPlpD2CyyoY
 B/muReyb6RWrAzxSjm/bktb3SMC/KigtBAqT1veF2vl6dR5wWQrLxyUwbfwhDt+Ztsc3
 DJxpKSgzpaDJh/4LF7y5PeL1Gs5PUqBi39XZsUTev+SG02OfGJKnBEXLtvg1CWqwQkDJ
 K5QNytelftu7tRUxsegQi+dqOaEWRakPHDuPNkrPrCl0hnoUzwVOwyBEroC/BjtGG27K
 UQZY9xPg1yRIqSupMu+Sc7kuAWVOvX6+nt4MOfo1ge+ZNXnPND+ajrEibMIhnxpIJBlB RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s6pqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:33:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QHV4t9069478;
        Wed, 26 Jan 2022 17:33:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3dr721nssw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEJ7ZpToIWICT82U5AIxsOXMHxLrGL94m9wqWoJd9S4QJDndqO2Xj2HfZoFVLN8hgCQ9wBzTZAlneQbWdw8fmUnwHXY9VrTB0PronlaupLjN6jyIBTnZNV2FlUx+bd1Ub3gcEbdSD8zeXjoXBVaAxbN2+1eBPBm7uhOkQh01SPGYEKU3CU75Je34SuvdKhgB/0w6EEOwjBCGi7w5T3iE0w38YVLhqz5xKaAqDFCAHc3KlUpAZ9Jfj0AzeJcjj8zjeOOfr/n5N6X4m3ZmNhjy3tsRdjZVPaTh1LEgjCQyl0Hvgg9Sy9fz87T2S4Z5eMQUBFw4WVIkO0A7gyyroxuQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q5tDZG63EP2PavLrlsfqVLtSsVknsFr+nG+9MUWtaw=;
 b=LBAs2cV3I0ihRP6q8L7xWSLmLYMEn7xOdDdjXzM2mcW/UKAYdGi+VHjNPHn21bTPRNK/t2QsGtvs7yDPXB99eq0YHId57uN28d+7MtJl8KBwUKg7dDtnvWECPfWM4wy2bVr1R7WpvrSpnCzY07+HkFFszSrNl5gJFViyHmzVgtndUfCmwYueIGncf0XV8HoAwf/zR2Yk3EkEEYWEW/45Fa0iJurJkUk1m6Aa9CiA5SXnegbyiyh9xbxzEpIiIN9TONN3i56SrJPOPcGu8lWqNjMxl1dlFehB7PuDVORovCrA6/eh+e7fla9Fc4vo6VhugPjvdbdIf8C9sq8Mw5uobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q5tDZG63EP2PavLrlsfqVLtSsVknsFr+nG+9MUWtaw=;
 b=sqFuCVO1JlVF3JCc3T436xwqNczz4DRyW/Z/J9qrIw6195gjkv4YODhVApfHikYvVxOtLIO2XkUabke8QfjFkM29dNZDLC6Uo73PlFIkW4l9xC+eHlaQrUoKFVNfX6tHeIV/B7rCozL/21m0PGuFtTJravMgVinSyCLLHCVhad4=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by SA1PR10MB5783.namprd10.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 26 Jan
 2022 17:33:49 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 17:33:49 +0000
Message-ID: <cfee81a4-ef97-deb8-411b-d02c8bf67fed@oracle.com>
Date:   Wed, 26 Jan 2022 10:33:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, surenb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
 <20220126134247.fadtwbvyknh3ejpe@box.shutemov.name>
 <YfFYUWOieZw9wap7@kernel.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <YfFYUWOieZw9wap7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:903:77::32) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d0bf27-307f-4c6f-530c-08d9e0f2034b
X-MS-TrafficTypeDiagnostic: SA1PR10MB5783:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5783DEF02DBBE760BA06C39186209@SA1PR10MB5783.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7yFi9K+JRii3TMuqmELYd6dH5il678OB0+jXSss3ryaOPEAvwGhqyacjaEgIEkqRMPvmGVkItPl06A4flr9eYsNGX/uJ3s220455jCl/UiZnLCeKZJH+8tyco7KfuL4XjOpCHtvj75TcbRVVaWSxHGmxDfNzrlSm/TRC6rssSBBGDxnFdyvQVjjVTE6EjuT5dTzmOFgBF6Gdg1IecvMKWb960J3hIX0ocYWm3CFhCZ9syw/rDLCw1DGGwmDJJofMrmHZJUI1q3ih/tEG0qvaUTrosFipsWjVOdwvTgdpmIq6n6iNi9NS4To3THMj2SL7hcwKhYDZQ62udlQM+JWqsVMVMjGKq79/5KGlAniw7x83HpkxPaf1UO7Ur2RJtSbUyLkcLg0PQpGvUtK+o3WRfP9tjG4fKjHFsf4APx+f588Qwe9YlGYZJ44Ae3aOzq/J3mNA11uanrHmjJ3/ZUEa50PeFuQeqQuj8PTIT5/YEYnKTdEgyv8KmuxUG9s/khe3Q29oGxXm3jo8nBo7O08jHroT8i8szELiSGoqhbixj1RUuDwGQ3zobVfRxojKddWs9euxs3E/12kDuK0ORw4bXKRqMj+Kin/lRNr1d3G9rPfKLc4E8msesyKi+YQrCIxYfPj7FcQghs/Hw7sorHWSeig5XaSO4IfeMe2DG4sy8fqCPt2XpR+6XyVQr0zJGS9ngNjoTUV+cqOdejQWp9X9mjLlO1xmFwcgT5k+vNOhoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(110136005)(36756003)(2906002)(316002)(5660300002)(2616005)(508600001)(186003)(7416002)(8936002)(38100700002)(6486002)(66476007)(66556008)(4326008)(53546011)(6506007)(8676002)(86362001)(83380400001)(6666004)(31696002)(44832011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGxFY05JcVc5bWdkM08yR0ZYZGNaRkxKbnJCZW9FcEJNbWZScHBqa3NBREFl?=
 =?utf-8?B?LzZ0dzBMbmlpY3VwYVdVWW96eENqZWppUG92aGJzcHVDMzI3WGl3ampPWnVZ?=
 =?utf-8?B?ZUtHMW1SV2lnbFlMSnlmVjFFVEFUaXlBWnFrUkZHZWRJbUdpbWlHcVpmNmg1?=
 =?utf-8?B?bjZUZjhIVmFUZEFINjVVRk1DSWdXQ0haSTVCc3ljK1RHaVBjUmptbGNNdEtG?=
 =?utf-8?B?c0RMTUVuWmt6eFY2NGpSL2pabnU4ZEkzL2RaT0lsMnAvU1pVODN3ZkhDeHRR?=
 =?utf-8?B?MVN6cUF6RVpOL3drbDJhOThadmNDbXVkVFBZMTh5VlJRaENoL1cvSEF4SWtp?=
 =?utf-8?B?eXQ2NE82cVk2TEdJeVErQ1Vtemt2NFVSSXpmWGZUSGl0SkpRSUJpaXJOL1ht?=
 =?utf-8?B?VCtxdEhQdlJSZjY2cU9icjU4MVFxN3NEbTc0cU16NDdsS01jbVV0d1BtTUhJ?=
 =?utf-8?B?TitKWVFaVHZVTjV1QUJqTmdvN3NKM0M0bkNWQkMwZ2FmSTBoaTNGU0V3cldp?=
 =?utf-8?B?OXQybFhHMmlubUtYbklPM2pHdlZBTHFBT3JpNG96c0pPZmVTMHJ6djdKSTVu?=
 =?utf-8?B?K0ljeENJaHh0cktjYkVSQUlrQVhLYzJFZXZlU3owY3JXUlZxc1FZQTZlN3pw?=
 =?utf-8?B?aDdEUUxYbEtuZlgrdlgyelR4VjVmMGlISlZRYkZ1VjRIbGRKSWRHQ0lzSlpr?=
 =?utf-8?B?eXBKL3k0cFB1VythWVdmNzMvR3VSVmFDSGZ4S0JaZzFwN3h6dzRjbXBLTzRk?=
 =?utf-8?B?eEVJZVllNkxIamdrcEp1SVkwc3dHM1IzRlFsODN2M2NGTTJBNzNSMytTc1NI?=
 =?utf-8?B?K2l5K2pzZGZGWDBuNklaNzhMVWRuM1JsRk9UZm1uU2RSMDFWNCtBSS93bmhS?=
 =?utf-8?B?L1JSaHRNMnkvaSszUGx4eHkyTjhZOU5vQ3h2aUdlNnF2TWJCT1RPd3ozS3Bk?=
 =?utf-8?B?TVIxcWp6ZkI3MXNCektOZzhPcDdpSVYzNUNYcVlob3BKNjNKNVJmdTh2aEsx?=
 =?utf-8?B?bjFsNEJpRjQwemhMVEw2SFlDMHh4d293N1VMbEVHY0s2M25BbCtYeVYxTnZZ?=
 =?utf-8?B?eXJXTmt6cWdaMzVWT2E2d3dNc1RjejNkQldyOW91M3picnFYb2ZMTUVpYzc1?=
 =?utf-8?B?SDFJNkFxMWlpWXc0WkZkRFlwZDIvTk50REl3ekxnc1dobk9uZE9nNzJoTEVx?=
 =?utf-8?B?d2I0WG5QdEp3ci9ES1FuQlRDMG1QejNWNWFZL25vWWpxQnM5MHp2SFdYalJk?=
 =?utf-8?B?ZFBnaHdjNXVTK3oxN3BXZ0lzYTNFUE84UWtPdVgzWTlnam9QdUpOYkJpVy9S?=
 =?utf-8?B?WDR3MjNtenFzNzhIaGYvNUN3Wko4M3dHYXBoTjk4SzVwbG5XRGhCV3pSWHJ3?=
 =?utf-8?B?cmI3ekJXQnlhUEdNekFkeTFTZG1iTnI5ZmdwZ0N4L0lBNDlXbUxyRC92Y2hF?=
 =?utf-8?B?ODJoNS9MV2Y1L1hXaDhyejFGWVFNVFRaaVh1aDJyMEUzcjlwcllUV3REYXpW?=
 =?utf-8?B?blMvcEVXN29CbU84QWtwM3JmTHFxVlNGTzdUdFFtbG1WRVMvck83aXJweGxW?=
 =?utf-8?B?cDdqRVpXWU9GdUVpUFQ4ZHBtWmdFaUZIaXl5bTd0UFlJZDlBTEpPM3JlbmVS?=
 =?utf-8?B?Tjg1bHVQMlY2NE0zelZSZlQxOUdzMkF3OS8zZ1g5SGhDcG9yd25sS0hJSmJ5?=
 =?utf-8?B?L1dWUFJnM0ZtaWtaQTk0UDQ2Tmk3blJrL0VBby9pNmxlM2tLUVc5SXlYMkhZ?=
 =?utf-8?B?M05VdXFCeHp4UG1oVE9maHJUSko0OC9VMk9oZHdGN0Frbzhja1NzejRwTU1M?=
 =?utf-8?B?TjFFeVNrUnVDNTRId0Z0MUVHNnhybFhGU3lXTVYxUjFDeHhKMjJiNDBGTDRx?=
 =?utf-8?B?WUtmeVdYYzBSUGhUb29tV3QrL0ZKSmFFTEw0YXNaUXFHVkJpOVppakdLUFFn?=
 =?utf-8?B?RndIc3YrQjdZU3hyNjZmM2w0eU1UVmVoRzRtNGw2VURCUWZsdXhic0p3akNG?=
 =?utf-8?B?UGh2c0ZqNUhrYXFQNmlvQjA5QU1XMVQvQWtrYkFUaDNxdW16bEc3cGRZcGZJ?=
 =?utf-8?B?V1FGQi80M3hVQXRRYk5jdTlaek5ZSkdaU3Z2Yk81bncrZDQwTTN4b2dWZGlK?=
 =?utf-8?B?OGNMSFZueG9UWWNYejVoY3hEUWNCZjlRNHZhTXpxUlc3ZkNsQzQyUTVmejFH?=
 =?utf-8?Q?1a6/7S6eaBBLQWufUuIhQCgo7oBwmPKcfIkViNrOLF9I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d0bf27-307f-4c6f-530c-08d9e0f2034b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 17:33:49.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EuaEOcnqEULDpttNz8omsju7Ssz34DlV9G3vtWVQ39E7+0yDkuhPCTcm96GsvjxspVCJZ1dgaH5Kjzz/IJ52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5783
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260107
X-Proofpoint-GUID: 4L8jOZCO6teyvyFT5Q7aJpjKAFeF6B41
X-Proofpoint-ORIG-GUID: 4L8jOZCO6teyvyFT5Q7aJpjKAFeF6B41
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 07:18, Mike Rapoport wrote:
> On Wed, Jan 26, 2022 at 04:42:47PM +0300, Kirill A. Shutemov wrote:
>> On Wed, Jan 26, 2022 at 04:04:48AM +0000, Matthew Wilcox wrote:
>>> On Tue, Jan 25, 2022 at 06:59:50PM +0000, Matthew Wilcox wrote:
>>>> On Tue, Jan 25, 2022 at 09:57:05PM +0300, Kirill A. Shutemov wrote:
>>
>>> So how about something like this ...
>>>
>>> int mcreate(const char *name, int flags, mode_t mode);
>>>
>>> creates a new mm_struct with a refcount of 2.  returns an fd (one
>>> of the two refcounts) and creates a name for it (inside msharefs,
>>> holds the other refcount).
>>>
>>> You can then mmap() that fd to attach it to a chunk of your address
>>> space.  Once attached, you can start to populate it by calling
>>> mmap() and specifying an address inside the attached mm as the first
>>> argument to mmap().
>>
>> That is not what mmap() would normally do to an existing mapping. So it
>> requires special treatment.
>>
>> In general mmap() of a mm_struct scares me. I can't wrap my head around
>> implications.
>>
>> Like how does it work on fork()?
>>
>> How accounting works? What happens on OOM?
>>
>> What prevents creating loops, like mapping a mm_struct inside itself?
>>
>> What mremap()/munmap() do to such mapping? Will it affect mapping of
>> mm_struct or will it target mapping inside the mm_sturct?
>>
>> Maybe it just didn't clicked for me, I donno.
> 
> My understanding was that the new mm_struct would be rather stripped and
> will be used more as an abstraction for the shared page table, maybe I'm
> totally wrong :)

Your understanding is correct for the RFC implementation of mshare(). mcreate() is a different beast that I do not fully 
understand yet. From Matthew's explanation, it sounds like what he has in mind is that mcreate() is a frontend to 
mshare/msharefs, uses mshare to created the shared region and thus allows a user to mprotect a single page inside the 
mmap it creates using the fd returned by mcreate. mshare underneath automagically extends the new page protection to 
every one sharing that page owing to shared PTE.

--
Khalid

>   
>>> Maybe mcreate() is just a library call, and it's really a thin wrapper
>>> around open() that happens to know where msharefs is mounted.
>>
>> -- 
>>   Kirill A. Shutemov
> 

