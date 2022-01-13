Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0844448D61B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiAMKv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:51:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48342 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbiAMKvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:51:55 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D7Y4iJ009146;
        Thu, 13 Jan 2022 10:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=h7hu1kaGRdNanMWT7Opdk9abWfoaX16CwcEWEjYiS7M=;
 b=c782RrkZTAYHyTLmmROPkOuMOWPGsKh6xegaTZKqXwuXV8uvDIlxdYO6RhTQnvPrslTn
 VQaNm9vFGYNQXAGCOtAQcvVvhXaKmzZwO5PAHg6sJZ8dGrWdQO/KvXRKhY9vUMM3jalP
 TY2G8UCLUnUtmJHQd5LOg33x7OYTRn4k+TA8rpZ+ay5s1DGjM6SqVkPioJODC+VW6oUu
 AutHc8b2OyiwICnXKDcMMz2puMwvNC9O5QFB+h4pEM4sHuyygEZ+/QU6lSmAr3m21Jl3
 vTT0ITckekU1+sCYWVDIyjIxVputK2qLSlX9o/SSNF+yUHgAl28O18J7x0fP/jJ01Dnp Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nrtga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:51:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DAoZ85143781;
        Thu, 13 Jan 2022 10:51:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3df0ngvnvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:51:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9ViTXRVtEhYVVGVy3H7bLhXT5OEc5umhO5nxuZYetpvNVQ3yqDtIf2AAjwHok7+2xb6xjm9idYbiDdpyLL/V3POQEIX1lnXFKS8O1fLemJb6ENOEBBqfw9iv4Y554yaKL7Csavwt3OzNX0SYlzs1hvK/G/RS5qMPAPdbBC5tz0178VkLONdyBBfWTi7aYsIjxjf32flKqXRluTCkD7CJN1ZhOP+F2YqHPivX0oo4dIL1AFjRQ6hb0hFsQqvadlh4UoDdWR0aV1E3hDpqhpEua9mdVkeIrkX68j7MtMabcXtNCWl+G4ZhNidDPBlGtmmhMWdXy6kix3qZed/yBzVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7hu1kaGRdNanMWT7Opdk9abWfoaX16CwcEWEjYiS7M=;
 b=L9cBOy3cMiJxrx+l3cKeI7Uk3UstX+jcMYze2XBpt4YMlmkNOdvZdTuqRWP/u9vDWSpzhpSCxMBCHb/VT0bEu99n9STDAeeu7AGUn3zlG/sYBOOiQNkFy/txJ2wDUn6M2Kx99yTnW3wG7FRwsPv6JG5n3tLDrb2vf2ZBz/QeRyRErTZGe1KJ+sxvEqGkzlsmV38vZ246RxK5j8ZvVANU2jdqrivveqoAT1bYLK2leMsMV4JP050KVLHdRKnVCrYyc23ck7hXPIa/2fHH0gto0roUiiREYpefRc6VmZ2krHKvHkRMtswjrZ8H9mIO+RYIu8+C5faPpnZIk/M3dHkeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7hu1kaGRdNanMWT7Opdk9abWfoaX16CwcEWEjYiS7M=;
 b=G1VIrqBW8zupLYCsyX407JFZ3VFkr3ey56IEVp+9X6qD16Ko4ioTy18HDGELsY5J/ruTE7ErkwZU8+sACHG73zc7mURl9dxPSFUA9kTDS5ynwU2JQSbbDn8Ia5IkKYKCO2ZVxQ/UjqEeGKIGkriNBP6tH1CwUC/jxRthoPHjaAE=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BL0PR10MB3026.namprd10.prod.outlook.com (2603:10b6:208:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 10:51:48 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f%4]) with mapi id 15.20.4888.010; Thu, 13 Jan 2022
 10:51:48 +0000
Message-ID: <d403d2ea-8124-9cec-eb45-7e61b9b68f21@oracle.com>
Date:   Thu, 13 Jan 2022 21:51:41 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com> <YddRVH4r6uNHt3xa@slm.duckdns.org>
 <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
 <YdivuA12i3VU8zO/@slm.duckdns.org>
 <989749c4-bae9-8055-39b4-ffc1cb6fc20b@oracle.com>
 <Yd81V5AYz/sMps9F@slm.duckdns.org> <Yd/nQSBr85tOZz58@kroah.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yd/nQSBr85tOZz58@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0008.namprd05.prod.outlook.com
 (2603:10b6:803:40::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d7de9a-8044-4515-fb6f-08d9d682b2a0
X-MS-TrafficTypeDiagnostic: BL0PR10MB3026:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3026EEA4C7CD6E77A91D7C93B0539@BL0PR10MB3026.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8iBxSfGNoaB0lPnPKgNcQ9Mg2yYhGdc5pMEysZ51N2u9KUUgZgXPLfATXMkyBVMUd9jYmIKe9m3+s1jdz33P48w5VK6yzGZmxbUWWZX4Yyp0OPlVnUe46F3O9dkh7Rwpo8u4KXDov+MYpcYGExKrXlj5A1mSoKihDavSmlpFQaomazS1jcZZycCxyaPfV0gIq1NP2yTwz2enTfqRphKDEMtI4WuF5B59V+riSx8ccBRzWxcw1QK5HVSbetE9Uiha9C9IvfMxGUk7rKvqTD+DTFzQJdYGce/g7NmmWLkNScXTpkSLf5DFaU44EM237h7jqR1fRx3gXUlXptPOMa50L0eZmMG6wLVoXQg6fChxlr+YHFVLOe9PKU7KIUwI6okBvGBHgVVSEj3HkOzAITNjatOooafWCx3sp7/9ROxEWK2JLKrZbrLpLq3vsbdfUfe/8lVLkqMgEbtKDk38Doi/q6ophYaLCebR6h3dVxYwLYHoSmhuoru9eMhXgU30Vl813Yp5RCZXKvfAUh9hmwaxzkA1v8wNzKy/DOppsbeNebv0Dr5+PRGYVJ29I96pJINljyLhiYyOVmXO4xnd0FOTNSxxT8zOhhNpVK1HY4yMeN68egf0AJeOIEpDF/hPvUd89DjIzcdJ+fUVSTMle+wL9GS7rARpJptm6pmm+a23owM1pnTppvHjhuQAN4Un1BnVhycBWRt0bu6CA6ZPL2zseKogYYgoJPDXLgPKzumc0rNxnMrI2NQ7ImGo9qHNXIYwgfJQBhntqSLzsBWEheQkDOR/MmiX+DLFgnUipFfYFHPA/EUum09o4fZMdZ68HS3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(186003)(6666004)(83380400001)(6486002)(2616005)(66556008)(508600001)(8676002)(5660300002)(26005)(31696002)(966005)(316002)(66946007)(53546011)(6512007)(110136005)(8936002)(6506007)(66476007)(31686004)(36756003)(86362001)(2906002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0VnbklXclZNMVJYNGJvYWNXeFIzSEtFdFpnT1JrSXYrQVFneENaVXlYWU1W?=
 =?utf-8?B?ZTV1OWtXbHdkSHRRUW9zR3FGVWt2dHE0WTRzbFpMbXpCQ2hlOTFpc3NEdnZm?=
 =?utf-8?B?emc3T0kvdGFmRDRWZ0NBQnBScHVheVR3YVFQNy9HeEFkV29EaU8yMGxLaUo3?=
 =?utf-8?B?RXRTRnJkdFBmZGxLa1JhMlRVbXVST3ZyNG95eVh4S2haaWV5RW0zV3VNWTJY?=
 =?utf-8?B?eWV4M3oxOTVoQmJDS0hpS1p3bHZSNDd2dWtQR3Jja3BVRGwvUTZjMWdyQXdI?=
 =?utf-8?B?OVRRK1IycTZsTDlOVUdmSGFhaWUrclhJOUd6c0Z5ZFN0L3c2STA3aSs1eklD?=
 =?utf-8?B?SHdncXQzU3lPRUVEeVNzSU9EQitNZWZ4OEl1VytoQTJ5UG9CNnpOZWI4ZDVz?=
 =?utf-8?B?bDN3dEFyMXBadzd3cUlVMzhPQTd0RWVPa3hIMnRhNWFVN0lDODhMOXRtUWtF?=
 =?utf-8?B?ZUV4QWt2Q1RPMlpyeVRqVmEwL1NCWWIvdGpFUWFodmN1TmVsWnRJUnJZR3BP?=
 =?utf-8?B?N29pTXNMVG5vOXVvUktJbExCWmhoMmU0ZDRZekZjS2RiMk00bXE3OXZKVXcx?=
 =?utf-8?B?Z24rSkhTN2UvZWtTOUZCSWRDSnljMFhEZ3B5WUxmbk5MZUo0TWtBTi90YUJK?=
 =?utf-8?B?ZFJmZzAwZEJDZWZvOTZ1TitKbUF2ay82VE91Ykh5cWtXK2k4QXZFY2RxZmRx?=
 =?utf-8?B?Z3RnL1lpOEhRalo3QjkxRkxzWC8rNUpJRHk5RHlSNG5MQUpaY0tMUDQ0Mk01?=
 =?utf-8?B?dkhWNmZjTmVud1czZGlwV3k4RmhFbzQ2NGptZ2pibkVCYkJWc2VQZnRrN1hu?=
 =?utf-8?B?b29sU2pOM0o3NWVackh0QVE0OWtYWUZoWHBJLzhsYndCcVY0bHRIUTJGQ1NW?=
 =?utf-8?B?SmlzQllwTU5PM3VBdDYwRUpaRGNTbEV1dk5EM2QxSkFJcGFIMVRDNmljaGQ3?=
 =?utf-8?B?RTJ4YkJvSHN4TDJjK0tEck9jeTZGYndiUk4yVGpDM2V5bkh4b25jNzRpU3Zv?=
 =?utf-8?B?OU9nS2h3YlZvZStSSVU0d2czNTZzdXJDSld6enByMkhwNTIzR2U1UFM2dDBp?=
 =?utf-8?B?WnNxUGRoVEpIWjlmdlZGcURtVXdpTGkzcFdHZzkzYjdiZGt3K2Zsam5ibzJh?=
 =?utf-8?B?OWx2alY0VWx4UWhpd3g0RzhNMHlMd241Wlp4eE9KRU9XU1FSV0QxT3dDREJ3?=
 =?utf-8?B?WWFqRWRWVXpFZEdsdjVGSnc3cCsxeHk4YzZjVzRmbDVTTjlwOWJCVE9mS1o5?=
 =?utf-8?B?VWVWUEJTQzZRZW5CN3kvUEZmbFRTT1JqYmRreDVUMElSV3ZrZjJib1Bqdklj?=
 =?utf-8?B?b1N1V3p3dzByb1JWTmt5TlBmYWRleXNGbjNPTWVXU3IrNjArU3hFV0QzQ3F6?=
 =?utf-8?B?Y1lzMEtPUU5pVVEyVGh3YzA3VTRYdHZvaVdua0ZaQ00zakxzTEVKcWFXdmdu?=
 =?utf-8?B?N0xPUkJ5RGJnTHBJdXc1blJwWHBWNWYyck00b2RpRHorODVlZS9hMVlSZk9I?=
 =?utf-8?B?dTMwUWVFV1dpTEp0SkZZRjJTUDhKVUNFZWdOTFU0T3NBSWpCOWx2bFY2VkJZ?=
 =?utf-8?B?MmMzeHRieXp2bnkxNU1KT1ZhRE5oREFZNjhEbUw0N0FZYk5SaUpLcDRWSG8x?=
 =?utf-8?B?UUl3Tm5RRmhYSjRpQkUxTkhjS056a2k2Tit6TElhOCtoQytSWkEvUlhOck1Q?=
 =?utf-8?B?cVNKSStad1NuMk4zTjBlRXRveGl4bmc3SVJmMnQ5dGxIdFpUNjNCekJtaVdU?=
 =?utf-8?B?ZERhSHgwaC9OR2hKRStsaTFRbjg4ZWRTOVViRk9zVjlRYlUyeGRCTXZZTnoy?=
 =?utf-8?B?WnlDa2Z4Z24wZzBaZStONkNHMjlpaXYyUTBpcWI1T3ZCOERVY01NMFRkRFA3?=
 =?utf-8?B?UDM2b3ZmMXp2U0RxUUNoamtBcjcxK2tDdCtrM2tIbU9LTHk2Q2VQYWYwV1Vm?=
 =?utf-8?B?b1RKVk4yYjV0alArL0V2Z2JkcFNETGN1akFKSG8ycGFBcUw5SFo2cUtYS3pN?=
 =?utf-8?B?TVByR3AwUERMYzdQbzY3eUtjZm9oWVdMT1ZpL0lOTlBERXB3YmVROUVPdXow?=
 =?utf-8?B?S1JqYWRFZXBJWHVHZmRiTkJiTEduaGl3NEhyUFIrdFhCVWovNHV6Z2dpdEY4?=
 =?utf-8?B?Z09TNnk2U0pYSFRzUnR1UzA3T3l4V2EvdGk5a0JTT0VtdStTcFl6cVhaNk5S?=
 =?utf-8?Q?q9raPsVwkE/7fdY87m7bpNE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d7de9a-8044-4515-fb6f-08d9d682b2a0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 10:51:48.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvGJSM9fEcnhHOVaODCAtlIKeKshQ2DYHmdfB+2knv5QATrm/y04YXejBKhw+tUCfudF4deiMj8JhFg3hEdpVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3026
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130064
X-Proofpoint-GUID: P9ZXom6sycEW36uNeGgPTMQJv72q6X4Y
X-Proofpoint-ORIG-GUID: P9ZXom6sycEW36uNeGgPTMQJv72q6X4Y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 13/1/22 7:48 pm, Greg KH wrote:
> On Wed, Jan 12, 2022 at 10:08:55AM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Jan 11, 2022 at 10:42:31AM +1100, Imran Khan wrote:
>>> The database application has a health monitoring component which
>>> regularly collects stats from sysfs. With small number of databases this
>>> was not an issue but recently several customers did some consolidation
>>> and ended up having hundreds of databases, all running on the same
>>> server and in those setups the contention became more and more evident.
>>> As more and more customers are consolidating we have started to get more
>>> occurences of this issue and in this case it all depends on number of
>>> running databases on the server.
>>>
>>> I will have to reach out to application team to get a list of all sysfs
>>> files being accessed but one of them is
>>> "/sys/class/infiniband/<device>/ports/<port number>/gids/<gid index>".
>>
>> I can imagine a similar scenario w/ cgroups with heavy stacking - each
>> application fetches its own stat regularly which isn't a problem in
>> isolation but once you put thousands of them on a machine, the shared lock
>> can get pretty hot, and the cgroup scenario probably is more convincing in
>> that they'd be hitting different files but the lock gets hot it is shared
>> across them.
>>
>> Greg, I think the call for better scalability for read operations is
>> reasonably justified especially for heavy workload stacking which is a valid
>> use case and likely to become more prevalent. Given the requirements, hashed
>> locking seems like the best solution here. It doesn't cause noticeable space
>> overhead and is pretty easy to scale. What do you think?
> 
> I have no objection to changes that remove the lock contention, as long
> as they do not add huge additional memory requirements, like the
> original submission here did.  If using hashed locks is the solution,
> wonderful!
> 

Thanks Tejun and Greg, for suggestions and reviews so far.
I have sent v3 of this change at [1]. v3 uses hashed locks and overall
increase in memory footprint will be around 100K at most (with maximum
size of hash table). I will await your feedback regarding this.

[1]:
https://lore.kernel.org/lkml/20220113104259.1584491-1-imran.f.khan@oracle.com/

Thanks,
 -- Imran
