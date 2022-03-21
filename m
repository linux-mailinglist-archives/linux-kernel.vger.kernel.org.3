Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3E4E1E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 01:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiCUAL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 20:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiCUAL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 20:11:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75224580E6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:10:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22KKn1ta008844;
        Mon, 21 Mar 2022 00:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ytQ54z5zLmv7o0OxulRh8xSnhlvBm+DgufjfKqR4YxQ=;
 b=cMnSN/XKiuhrL3SJFZBKAYWV1huUfPNY+zH5DftvTfAjJQm9Ez12JCtQr1ooxh88GCmM
 u1kwJXXu6+H33WxgVdJwkKJyIWuQyUPt2l3z9hvaeW7S5S+cUXm6+A5qdH4VhZoMmN3s
 1HgQ8IfwextwSN74CC0LKlDlJBQ4Qr/vQIKxO6+ikrcdq2ElfgtfOGwWK6ZHbAY3eVER
 wgLA6RemEatNwvEdxqiLMy0XYreKH/k18OX/B7NeUdZWyyPhLP06zMq/pU52mkVzavfh
 453I6aAPqd2pU1CABislcclhXwdIKuAYBLbPYx2qQi8RRH8pJ7mM8Qh5Xn/4Mcb2NhOr DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qt1spm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 00:10:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L074qA016137;
        Mon, 21 Mar 2022 00:10:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3020.oracle.com with ESMTP id 3exawga6te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 00:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHWk2UAYvdIHlnmwYZ/2FaoSwY6pNd0tSDgT34Ba7N+gYLFRh3Zrh9PnIc3Pfa+GwtpQ7Uv0nSxa3JUsXq2XWmzET3qeZqMxNykkqd8SwmBfvgVz7LcjnjaIxsEkWwWKsZCXzyUgcIlwhlKAdGFcYbTRV/AWw3S4BSmh26naEQxto+tNByRQPyKOafluHI+NncfFZuT63Mo2mqud4I700ubL00AkFFQgu3z97rFaXzlbdA2ZcVKNREOUNGXzc49Rhd0rBKHKLoGQV+JN9Qi6DDHaQcmxp3XN4xdbnAubFUPvMSKHeLry32AZkwKGCINqxpsFmpg+IXdo9t3hrq076A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytQ54z5zLmv7o0OxulRh8xSnhlvBm+DgufjfKqR4YxQ=;
 b=EIT1eMH0D33f3c7QLPj7/5d/zKi2DeFwcF9EOxZNskY5JgcC6iWJPf1cszAx7lqC7R01yQcSczE7+Tvx7D3qBcFExikmlMPj6qAADwF8yAvteaR8KW1ric5d63NOd+JIfDiQI2r00tFOWFkyXyCpZ51e9fALh+XQry77i0ICof5Nw/un8UU/v2tA97kjmOst2E8bGxCGrn5/rXWuj1ueNs5giBTgK5H3PUqwa6SQV8tmOqLwQHwVhZMSjIHyZZZc80+4V/8azRnbS+hCErPxVPpj8xYDu1T0eefSKaOvA6uEqZYwTpo+EMWhlUJSuJlDThdgJRXsA7XE0CvyiIlTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytQ54z5zLmv7o0OxulRh8xSnhlvBm+DgufjfKqR4YxQ=;
 b=ObZArHLlRl0pTUZO4ZhSpbiaCknG0TVMhLbs1q2NG483cK022IcXN++yf4c4OKL3OTsAcuYLplE1Eah8BmjCSAwoo+ysV0/aQUNhYz51rXm0LeL0WI5W3OdLW9eHinaLOpmKjlEcZMGYEGX2O3a15b5SqkppvOkmtAbb40BWmjs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Mon, 21 Mar
 2022 00:10:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 00:10:17 +0000
Message-ID: <6919f0a9-b3e0-b5c3-0669-4b84beed84a6@oracle.com>
Date:   Mon, 21 Mar 2022 11:10:09 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
 <87r16z191l.fsf@email.froward.int.ebiederm.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <87r16z191l.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed53af9d-3dae-4d31-15fb-08da0acf2df3
X-MS-TrafficTypeDiagnostic: DM6PR10MB4379:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4379EF5FEFA251BF0FEF7D61B0169@DM6PR10MB4379.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blEKi3e5YSrb4o8n+9o1+DLlCk9U2EYNJhvC6l0tCqgQs06Ztka6+ehgyztogHp/aYM7rgl01kIs9hzrxQe0O3HczjcSaFOUz7YgOKn3cHTsieXqH/32zhAo2cHCYAaqT0ibTuoEjJuVZHZr0vrypRfMdCZNfne9IQ4nzksZUpzTRfMvifoeOSAmKCRr8dm3xLTDbtQfaCOvoP2MD9f9O7hP4zGqdA4PtLt7vLHfZV7NIeoC9S8tAwX3/TV9SXywFV5QQu+hib7vxfzNLdO4NT5uMUBqTk7cAY3mepvXAQWlXhddKxOivEqmNnh2u1CccuolNpCHS+ygO0+rTQQqtZjGhYkkOeBU2eYjV7SGHF7DPUi7egup1mTbmG+8m05qz9WlGHZSRyyB3RkbsHahgWlUzDWg/xik42zm0QoO6VwnEE9wRyyeUrZ2rYQ6GONJ/DCky6LIFqlWoI4pMen45vYXsqS3mAfp/GanyktVfEsIhTzTA0Z+9JPvzIHRpNcxBs4ZJM0D1pnZ/RB8Hw6+NjFdS95sEftBhFBMqZJl8VPNgCTuIqD3zBJL7QRO6u7pNtQlxzz1igny74FWXivu5cgw3S/vB95vaEhxneK1l+lhCpJz40JYk0wpNUMF5CvofSFd4/e98kRT0d0xOOQOoNu9KDaYq3bqTMsH+M1L3XiutFMwgZf9otou9ZdXJVX0iv5p85IGrME83vFfPX7xRtXZoUm42HOqez9UA3BmkjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(36756003)(8936002)(5660300002)(2906002)(83380400001)(2616005)(26005)(31696002)(38100700002)(186003)(66476007)(8676002)(66946007)(86362001)(66556008)(4326008)(6486002)(508600001)(316002)(6916009)(53546011)(6512007)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG9wYWRzWGd2YXVHSFEzcXRISVlCMTg4ZmpQTFVpZnY1dHBHRHhQWWV2dTE3?=
 =?utf-8?B?aFptcDJEYSsxZC9mTUt3MXN4c0R6U29tK1JYMkc2cUlhSGQ4akk4c082Wkl6?=
 =?utf-8?B?ZXJLdzh1c0xmbmVXRTVHTXkrNG5QVnllWGZlRm5IUWdRR1lTcUl1QmNPK2xZ?=
 =?utf-8?B?Kzd6ckQrZGpodlJXM29WZUZuOThxaFRmT1NBVnZBaDhYODFmOVdlMkdKOEUw?=
 =?utf-8?B?eXVWYTJkV20wbGZYdHExSEJ4dE5mcmFjV2JOZERqanFHVURpVm5jeStlOCtP?=
 =?utf-8?B?ZkFhdDJNUjFuZEVmZXBLb2QyWHlKUmJsdEhHdTRWVVlLSnVDb2ZoRHpIQUY0?=
 =?utf-8?B?MXM5ZDMvNytnS0Jzak9Fam94SWU3dXZKdUZIY2dyYUVURE9keGxnVEdrM0x5?=
 =?utf-8?B?eVBWRW5weTl6VFVpdGpkRGIzMHcvZWtzMlZuTmZ6ZmxYWUFGRlV6Q0wvQTBF?=
 =?utf-8?B?cldYWUJUQlBvOEFiclJHZHdjbmdnQTdIMFNvQm03RzNUbFlIY2lQTWdJMGJR?=
 =?utf-8?B?S1R0T0RJNkQwUXNoeGxSTlhRSGd5Q0xDczRRS3IweUw0U0JHTG5hSDdUbnhZ?=
 =?utf-8?B?ZjZNcVhza3BTYnJhSzIyNmorNmhOUWFXRTlWclZsVUQ0UWFEUWw0c2xueFBY?=
 =?utf-8?B?QTErL0JoV1BpUURjUzNuYkwycGlTb1Buckhxc3dheWljQUFsUlFnZG1ObXlB?=
 =?utf-8?B?MU5GRXRobU0zeGNtWk5tWDNhempYZDg4amx2VGp6aCtTSlpWcXo2NldwUHJQ?=
 =?utf-8?B?YjhTbjVaVFhESkNXdk5LcDZVY2U5WFQwMG45dnpDWGl5ZnlXQkE3SXI2Ulhy?=
 =?utf-8?B?d0pEWDFBN0swZzVidC9yMDFZYitWTWorTkJxOTVjSUhldVg4ZjA4clMyZmcr?=
 =?utf-8?B?WWlCUTdzbWVWa3daS2lCQ2NNWVdCcWJBTFRwZkx2VzBhVjJKZXJyTGJVRENl?=
 =?utf-8?B?OFNnV2g1cjRvT2hBdE4yeWhTNTUzQnZiUDJMb0ZjMzZGdWkrR2FSNU8zbkRC?=
 =?utf-8?B?cFNVNVp0ZTdwTFhlRjNIVFYxMGVDUmlaRGdLb0ZYQ2VVYjNtWHJLaW8rK05Q?=
 =?utf-8?B?SGlCRm44bTJVZTNZbEJMMitUVDE5NWVCbnJ0SmhET25kRU1KNXRaaUc3cG5x?=
 =?utf-8?B?cEl5b2JNbk0rVHJHa09WenBWYVdnb3FMTGZ3ZXdUQzJYT1hCMklSdFhybjl0?=
 =?utf-8?B?RlNSZXJkSG1tbmFGUHlEbXFVdnRpYU8rVWJGckVtZ2xxcUFtNjR3cmtMUkx1?=
 =?utf-8?B?OHVDMHZpTFdZMFVsVTdnbGdqSG5OcEZzVEtpeDBpaW5KS2daZkMwR2RORzRy?=
 =?utf-8?B?TVprZkkxb3Q1QWpnU0I0VnI1eXE2QXJQaE4yME5uNEdnVE1jbnVKV0xBYTRN?=
 =?utf-8?B?Uk45eERSZW1LQ0VHWkVxVXBNVTRYYVVtVitvV05pbGJ6TngxVG5teVFodkZv?=
 =?utf-8?B?emVxbEVBVFdJUDJVZ0dpUGtnUGhONkRoSHRTaWUrbEo5VnpCTHFES1ZXOGhy?=
 =?utf-8?B?dWdVZWVFa0lNTlNsWEZ2MlRLK3VzWnVMcHBpM05hSTBiQkp0cFF5WEFJMDQ3?=
 =?utf-8?B?L2FVUHVveVQ0ZS9YcGtPaVNjaWNSN1VoSmltcndwdnBMc284OXdzWFJLVU02?=
 =?utf-8?B?SmsybDZ4bWFkb0ZjK2NMeVVqUG1LWUJ4U01Na2p6K1gwdnhNTHExcGQ2bHEz?=
 =?utf-8?B?cDNEdWtMSlIvSEpMd0hYNU1lSlhvREZtRi9EOVRCRitPZ3c1RWFCbjUxTENv?=
 =?utf-8?B?ZkZPbFdtbTh6M2FaZWtnVHJlMWREMWdTY0pvTkVOanBUZnl0YmZPSVFjaUc1?=
 =?utf-8?B?VVRkS0picG1HVWd4dW9rbGRKYldwL2ZqZmhwQTl3a0xvd0hmLzVhdEwxYW5M?=
 =?utf-8?B?VjhsRmZIQXdFTnZwSFJGYzR5OWQ4WHhzVElwb3dYayswMmFkbTcwbk1ISUdZ?=
 =?utf-8?B?TkFoa2dvRWExMmVUZWlVenV5NEpkR2RUSmUzWFRaZ2w2ejN5YUpTZ2l1UU1C?=
 =?utf-8?B?d21vS0lCNE1BPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed53af9d-3dae-4d31-15fb-08da0acf2df3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 00:10:17.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yjyd7e+LlcbCXU4dd6X/cH5jJ6APJZXOAdmrVxnvB2q+fDHynbk9R6iKtInGcGd3vRCe2Ru5gkzn/cff56UA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203200170
X-Proofpoint-GUID: IQ_pAcb8x5BdUaWthu072JAzkOaVJrpr
X-Proofpoint-ORIG-GUID: IQ_pAcb8x5BdUaWthu072JAzkOaVJrpr
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

Thanks for reviewing this.

On 19/3/22 4:10 am, Eric W. Biederman wrote:
> Imran Khan <imran.f.khan@oracle.com> writes:
> 
[...]
>>  static DEFINE_SPINLOCK(kernfs_open_node_lock);
>> -static DEFINE_MUTEX(kernfs_open_file_mutex);
>> +DEFINE_MUTEX(kernfs_open_file_mutex);
> ^^^^^????
> 
> Why when you want things more localized are you making a lock more
> global?

The idea was to keep the interface in kernfs-internal.h. But since this
mutex is used only in kernfs/file.c, I can keep the mutex static and
bring interfaces that access this mutex in kernfs/file.c. This will
cover your other query as well.

>> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
>> index eeaa779b929c..df00a5f5a367 100644
>> --- a/fs/kernfs/kernfs-internal.h
>> +++ b/fs/kernfs/kernfs-internal.h
>> @@ -164,4 +164,22 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
>>   */
>>  extern const struct inode_operations kernfs_symlink_iops;
>>  
>> +extern struct mutex kernfs_open_file_mutex;
>> +
>> +static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
>> +{
>> +	return &kernfs_open_file_mutex;
>> +}
>> +
>> +static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
>> +{
>> +	struct mutex *lock;
>> +
>> +	lock = kernfs_open_file_mutex_ptr(kn);
>> +
>> +	mutex_lock(lock);
>> +
>> +	return lock;
>> +}
> 
> Why don't these functions live in fs/kern/fs/file.c
> 

I can put these in kernfs/file.c. Please see earlier comment.

Thanks,
 -- Imran

