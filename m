Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B01F47D5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344374AbhLVRdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:33:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23386 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344368AbhLVRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:32:58 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMHT2tx030529;
        Wed, 22 Dec 2021 17:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tzQ45Npi4EJYuIUqb8ei1CxIrtZpPe89rXFDMnWKo8o=;
 b=Qu8l8nM60ACIaU/bpNal+7/enBpRfaCkgxG+JemFYFngq7QuFsSC0eZ/LNXzVebIBF+Z
 rUJEihdTb2bXFvM8W5Zyj6QL+xvEwLVg+Duj5Ex9oM5/UhVOPJrvoy1CyglZjMBlB8bM
 bj0dHEJG2srpCcl7BTWUmR9517j084jcsj0AWznyIV0vEI7plNc5HA7JkL7B3gy7kSGX
 678J+b3Hs5Qsbg07Yf8vvFkKN0gyjrne7RMm100tuE30k+I6Grrn3aIXnGIDerUxvfjv
 euK3HDvvgVoob5k9dV8hFcVvo981T9zsdgWoC1OqE/CKYCTbgTjaAKUMoOpcwonCful3 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqy18q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 17:32:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BMHUugX117789;
        Wed, 22 Dec 2021 17:32:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 3d15pexmek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 17:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqD7LMzlcKgSyMfDGgFQFBopZBHad8X+flKERmsFxRltmEf5yaHItPtbeT8aMSArTjmMtzE67fQNb92EcrcDPJffHMzXPYvnvPRsYr9LM7JL1mp393e20365p4YBMnnGgf2F92JTIHCo/8lBm8JigJezCmWATdqppM9tIvfEvgHNJr7W6WespIGuZq/RBeVd2AdR/PMOh5pJ4+YvjH5SdnoajH+trxlx2k2RLgbHUgxkK5xUUBGT7x4KLrQ86ptKEmC4cKsaEQjPDwBBQdU4AHNB2VqnQMsyU9l3tCjPHjLoYuVy2wzcWNEkJeM5Xx3wPfvEZoVaHS5LiYUwUh3/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzQ45Npi4EJYuIUqb8ei1CxIrtZpPe89rXFDMnWKo8o=;
 b=RKuqr0DbD+6HfIhNaRib86ZgwA0qxvj79OACci+pCPAWmwXk3/ojS1AfHREGccRNjDh4xf8qQeCRKBgzYCXUudE6E3nR0kZBtQzsWViQQsOTPwtvVKg1KfeXuh/zN5/JeIz2o4YZX1IPJOM++H52wVzyzN5XAsRolgoHPMaUwX7C256SNkpESXwr9EIff8n1k+/iO99JMkenzOaE+jFuYBl/j5iPr3ZHFDb5TAUGkP5xFh+sxjyhB9qqom9YFOA6Rn0gvnsyO1fnpBsSKm2ZW4IDnDOdMC+nIYWigvpHYLQ4EK32EPmw2xMvUgd9h/37GRRye46XpVTnBsDzo+/mPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzQ45Npi4EJYuIUqb8ei1CxIrtZpPe89rXFDMnWKo8o=;
 b=if8Lwh0WmmG2Rmi4BgColl76KgAZDJY19r9a+fK661wWnFQPVtkQ5vqgRzs0kCvc7SKKToWIJFkDAIv3M0VSvk703IrlenGpxpiKG1P8NJdAM0DP9aOmRrsNl17HPB6aUmCzt2kTi8d+JdyWIxbdFKFAJl9FjrkdfvVCNnlMELA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5262.namprd10.prod.outlook.com (2603:10b6:5:3ab::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.18; Wed, 22 Dec 2021 17:32:27 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4801.023; Wed, 22 Dec
 2021 17:32:27 +0000
Message-ID: <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
Date:   Wed, 22 Dec 2021 11:32:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <87tuf79gni.fsf@email.froward.int.ebiederm.org>
 <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
 <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a631aa-10f3-4962-e295-08d9c57105e1
X-MS-TrafficTypeDiagnostic: DS7PR10MB5262:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB52624414AB7DBCF585B4ADEFF17D9@DS7PR10MB5262.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7hA5hOBOq/iYCDgrq841ZVRozNamr/p0Re+d2herAYGXUfESGaM8j+NfGdfqCH3cqiSQ2olXyMbypxS1EIDc00fEb9TUko32cUszRPyoV36moTwPEYfBoAn3upJHzItJ/cgoHLrmJNr7iUXP+V2InM8Igg0AD1epvlc1MU32ccfPH4z11ikHXgqpvdTUQE1bboidViIefo3DTRBVD48NaV5q2kjLgfM8lxOWHXHwHhVJUoA9cpCGGGPNY5L4flvtnKfxvO8uUsCvJ+Zf4W3RhHOpig30opnMLinhUoGGOt+7LEYIiBXEjFwqilXajqfBfkdUxRPOEekxj/lcH938p219/n0iG1Yi1ZLyVZNePy2xOI7rrVel8cgSy43VSJXhldP5eU15Uem4+ThKayQRdX7PJawZMOgTmU2uM4nw1wyBsak4avohi74MIsMmDQuDIP56Egkk5pd7ybMbnJeWFhHwoz+SuVCQ1+joMzo61wzaU8dAQS++wFS9hU+rS9D2o1UF1VPQPtxonAgIZTypFNdXXRBpK1WzBY2mIY/yeTqMPfSDQR3KG076dwALJmbgOVxL+zWRG8W6paC11SJkVsngEvV5qqh6alV3AXEA1agxnXKaQRVs25lqn3ttJXLS11Ple0+31Tvgl1DF7fDTWTfMkKr5qocRB7r/hld0OOYqNVWAJylqbLdVumzDVkZmSNetMbMxADXYzFoHlBNIJBjC2ycGVUbzPma8iV/UTvUtRqApxLsyiG/OYdsZI2Q8RiEyB40RIR/EW+B65ijMGO+U+tbhBFNFCSwgw/Oa4RXmab3ZqEcFsT5lC4YWfZKdKFXlNaVAOWDIAKGPnwjfgiLDEpHfKBHr4rZwmh2JQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(316002)(26005)(83380400001)(36756003)(186003)(66476007)(6486002)(8676002)(66946007)(66556008)(8936002)(6506007)(966005)(508600001)(5660300002)(4326008)(31686004)(38100700002)(53546011)(7416002)(31696002)(6512007)(86362001)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVtcWJPbTMxVWRjNXlSaFFIQlo1cjFjUG9hTURYR3VGSk9PTFIvaG5TczYr?=
 =?utf-8?B?b0pTNzhqWDdYSzNySW8wN1RZNkZVcHZBaG5xblJtUWVOOWJOR2NqRmZXR0d6?=
 =?utf-8?B?d3gwUWl1NGFCZUNERklaSy9oZVBVZVZyNjBwMjAybGJTL2lKNndZSTRPNWM5?=
 =?utf-8?B?d1pBUFRmdkRWZmVjK2t6YUlyVWgrZzVYeW4wWGFkaVRSZWZHZFU3YkFPeGtZ?=
 =?utf-8?B?WTRFVjRtTWdkVnhJcGMxcDRvcENacG1jUUdaYmdoaytydExiQlVkb2RHREE4?=
 =?utf-8?B?SWpMdGMvN3FBeWtNeDdlK2VwdVNqMU8rR0YvaFUxWW5iRGtVY3RxTnV3Qk9T?=
 =?utf-8?B?NmJuK2FKQkVaNU9GdmEzeXNkb0NBYU9EcDBSWEhaeUh3cVRhN0Fkdi9hb29U?=
 =?utf-8?B?YU5Fcmk2bWZpMy9qbjZTMG5EbjM4MHkvVFFJelV5L1ZWK0xqTE5QRklhRWll?=
 =?utf-8?B?UE9VQzNCWmxvYXJuSkEvbXJzbm8xUzQ2cTJPVjh6b014UU5hemZScHJ5ZXpm?=
 =?utf-8?B?cHhka0c1bklQdWdwNjhoZ25mWUNOMmZFdWpoUlJvK1U2NFVIVFBlaVYwNWFs?=
 =?utf-8?B?SnBIcktGc01lNjh3KzVaSkgyQjlvRkliRDI1NS9pRURBME5QTllKSjFhU3Fu?=
 =?utf-8?B?c1I1bE9kQzg3TEd4UkJlemkwV1FkenNudm1YQ0pSUmJad2FzWFlVL2ZtQVZ6?=
 =?utf-8?B?cXh4QW83YUs3U3dJdHVFNHY2R05uZURsOWNXMWFSM1lMZS9zYlN6dWhsRWJ2?=
 =?utf-8?B?MXdGYXBtR25QSFozaTc5bVd5SWg0dVZFa3FBdEpDaG4wWnRVZmM3aEpSdy8w?=
 =?utf-8?B?amRKUTFWa1dOMUxGc3dnU3EwT0UxS1ozMTJqNHI3VC9Id1R0enpWVDJZaTNS?=
 =?utf-8?B?ck1OOEJHdkUrL2NZYzhXdmo5VjYva3IwbUgzcWVDanl5L2pxeTdRZWQ5QzhV?=
 =?utf-8?B?ajczcVFRN0lyZVZYYzN4eTNhd3lwUjRPWVE3R1kxL21mV01yZWJUc3VkUVBy?=
 =?utf-8?B?TmJ5bW9RK2NvM0pTYm0vM2c5dHJDbHF5c3cyUlRQWElVUjVDWmk1ak82VU8y?=
 =?utf-8?B?WTI1RitwdldZaFFucjhDMkdacE5tTmJLbUxVZkR2L1ZMZVkxUTBPWUExbUVl?=
 =?utf-8?B?MFVTREIyRjc3VnhSYkVieUZmUzNmTDBzbWZtL1JXZHhIa0JySzJac081cThE?=
 =?utf-8?B?dVkyenRlb21vK0pHZW9acG5iQjFHYSs4aTNpUlZOQXhoaXBvajcxdk5CbVdX?=
 =?utf-8?B?eHBzNWo5b2RsQy9HaG9OUFhxQVMrMTFldmFXZTF3cHRQKy9RV2NkK1QzSkFM?=
 =?utf-8?B?TWR2L1NWTG9CS1YzUDlmQzN0aDlpSmtiZFN1dGdlMXYzeTUzRm00WVZONXg4?=
 =?utf-8?B?dUpzVnc1R0RoLzUzNDU2Ukd3eHFFb09MWHBoTWpudGJ5d09MRys2bVAvNURF?=
 =?utf-8?B?OVZKVjVEZUJMeFIzSUl4VmFiclNRTVluaUVCMGNxellEWWxPWGRxUlVwalpT?=
 =?utf-8?B?N0ZLZ0hHZ1FERTJUdy82bERHNktWWnV1V2RvUVZjMDRRN2VuOEQ2SFd3dlRT?=
 =?utf-8?B?RnozTDJIMnovajRaajNsdWdZUExnWjk4cCtBclhMTi96Y0FRRTR5Nlp5dUFv?=
 =?utf-8?B?ZzBHU1VEWWFEb1B5NmJyemt5TzRDWVRIZkVqczV6VU5ZajVQei9UYWhyRHY5?=
 =?utf-8?B?d0w1aThiWnN5a3VoVy9ESGh4VS9YcTMwT25OaU5mZi81Zjd6TXRpc01wcjNC?=
 =?utf-8?B?bFpINVp6bFNNK3k2V3AzbUNEMEdxdDF6SnBGZGtxRlh1WFh6Q1pCemM2Rlow?=
 =?utf-8?B?UjN0cnBrZmVERDlFU1JnME1iQkFJQzNsM2wrSXJENk5FVUxzNWE5d3g4N3hF?=
 =?utf-8?B?YlNHZFQvUi9RNkJYOTRiMm1WRWlDTmVmaTJobTRnVHRSN1pvMDlMZWFqWGlT?=
 =?utf-8?B?REdRWUlDWFpHTFZRcVFLT1NkRnJPRDRlaVFBRGJ5dVliR0xRbis0NjFaTHEw?=
 =?utf-8?B?MEhYclo4VEtPcTA1NXB1RitQS3VJWmRLRFJzR2NQN1F4eG5qQktObmdBUkQr?=
 =?utf-8?B?Z1dDSTN6RjZSbEMzcmlhMXo4M0YzNkN5STFQUGZtdXppdEcxN1BoSmlJRE9U?=
 =?utf-8?B?R0dvOTN3UVY2dzE5VFpKQjdVdE4xUXNzdFRUUkxoblI5eUc4NEp6UUo5OUNL?=
 =?utf-8?B?clBubE5USGUyMks2WUZOTitIK05WY21FZTB0VkNEcFVXWms3TTl0azlaQnlM?=
 =?utf-8?B?L1dqR01LZ1RQTnNXUjcvNTdNcXBRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a631aa-10f3-4962-e295-08d9c57105e1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 17:32:27.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfnTXgW5KJP4U3EPYoBfpC7t5zxq50jAtkvpod8NBTfjHwfHbMrpD/UCOPQ50kIvkiUlIBwleK2GsH7g3SJo/5bY3avb8rDGcHVA2CbKmpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5262
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=706 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220097
X-Proofpoint-ORIG-GUID: O1uDCKRqVt4bfH8n1kPepy8YNrRJbIdU
X-Proofpoint-GUID: O1uDCKRqVt4bfH8n1kPepy8YNrRJbIdU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 6:20 PM, Eric W. Biederman wrote:
> michael.christie@oracle.com writes:
> 
>> On 12/17/21 1:26 PM, Eric W. Biederman wrote:
>>> Mike Christie <michael.christie@oracle.com> writes:
>>>
>>>> The following patches made over Linus's tree, allow the vhost layer to do
>>>> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
>>>> io_uring does a copy_process against its userspace app. This allows the
>>>> vhost layer's worker threads to inherit cgroups, namespaces, address
>>>> space, etc and this worker thread will also be accounted for against that
>>>> owner/parent process's RLIMIT_NPROC limit.
>>>>
>>>> If you are not familiar with qemu and vhost here is more detailed
>>>> problem description:
>>>>
>>>> Qemu will create vhost devices in the kernel which perform network, SCSI,
>>>> etc IO and management operations from worker threads created by the
>>>> kthread API. Because the kthread API does a copy_process on the kthreadd
>>>> thread, the vhost layer has to use kthread_use_mm to access the Qemu
>>>> thread's memory and cgroup_attach_task_all to add itself to the Qemu
>>>> thread's cgroups.
>>>>
>>>> The problem with this approach is that we then have to add new functions/
>>>> args/functionality for every thing we want to inherit. I started doing
>>>> that here:
>>>>
>>>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!eIaEe9V8mCgGU6vyvaWTKGi3Zlnz0rgk5Y-0nsBXRbsuVZsM8lYfHr8I8GRuoLYPYrOB$ 
>>>>
>>>> for the RLIMIT_NPROC check, but it seems it might be easier to just
>>>> inherit everything from the beginning, becuase I'd need to do something
>>>> like that patch several times.
>>>
>>> I read through the code and I don't see why you want to make these
>>> almost threads of a process not actually threads of that process
>>> (like the io_uring threads are).
>>>
>>> As a separate process there are many things that will continue to be
>>> disjoint.  If the thread changes cgroups for example your new process
>>> won't follow.
>>>
>>> If you want them to be actually processes with an lifetime independent
>>> of the creating process I expect you want to reparent them to the local
>>> init process.  Just so they don't confuse the process tree.  Plus init
>>> processes know how to handle unexpected children.
>>>
>>> What are the semantics you are aiming for?
>>>
>>
>> Hi Eric,
>>
>> Right now, for vhost we need the thread being created:
>>
>> 1. added to the caller's cgroup.
>> 2. to share the mm struct with the caller.
>> 3. to be accounted for under the caller's nproc rlimit value.
>>
>> For 1 and 2, we have cgroup_attach_task_all and get_task_mm
>> already.
>>
>> This patchset started with me just trying to handle #3 by modifying kthreads
>> like here:
>>
>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1234__;!!ACWV5N9M2RV99hQ!bvqZOWy7TxQyq18L4I_a5MxP2OX0V2imOYEJrWsc-LkyVTI_zpFzxyV2pM_dgYywwH2y$ 
>>
>> So we can use kthreads and the existing helpers and add:
>>
>> A. a ucounts version of the above patches in the link
>>
>> or
>>
>> B. a helper that does something like copy_process's use of
>> is_ucounts_overlimit and vhost can call that.
>>
>> instead of this patchset.
> 
> I don't fundamentally hate the patchset.  I do have concerns about
> the completely broken patch.
> 
> With respect this patchset my gut says decide.  Are you a thread of the
> process (just use create_io_worker) are you a separate process forked
> from the caller (use a cousin of create_io_worker but don't touch
> create_io_worker).  I think being a process vs being a thread is such a
> fundamental difference we don't want to mix the helpers.
> 
>> Before we even get to the next section below, do you consider items 1 - 3
>> something we need an API based on copy_process for?
> 
> I think 3 staying in the callers nproc strongly suggests you want to
> reuse copy_process.  Which gets back to my question do you want
> a thread or do you want a process.
> 
> 
> For me a key detail is what is the lifetime of the vhost device?
> 
> Does the vhost go away when the caller goes away?

Yes. When the caller, normally qemu in our case, that created the worker
thread exits, then we free the vhost devices and stop and free the worker
threads we are creating in this patchset.

However, I'm not sure if it makes a difference to you, but we also have second
way to free a vhost device and its worker thread. The user can run a command
that instructs the the qemu process to free the vhost device and its worker
thread.

> 
>   If so you can create a thread in the caller's process that only performs
>   work in kernel space.  At which point you are essentially
>   create_io_thread.
> 
> If the vhost device can live after the caller goes away how is that managed?

When the caller goes away we free the devices and their worker threads.

Either before the caller exists it does an explicit close to release the device
which frees the device and its worker thread, or when the process exits and the
kernel does a put on its open devices that will trigger the vhost device's release
function and we free device and its thread at that time.


>   Especially when you are tied to the caller's mm.
> 
>   If your device lives on after the caller then you should be a separate
>   process forked from the caller.
> 
> 
>> Do you think I should just do A or B above, or do you have another idea? If
>> so can we get agreement on that from everyone?
> 
> Like I said.  I don't hate this patchset.  I think you just tried to be
> a little too general.
> > 
> With kthreads you are fighting very hard to get something that is not
> part of the process tree to act like it is part of the process tree.
> Which strongly suggests you should be part of the process tree.
> 
> As long as you don't have important state you will need to fight to get
> separate from the process.
> 
> If you do have important state that needs to not come from the process
> figuring out how to make a kthread work may be safer.
> 
> I don't currently know vhost devices well enough to answer that question.
> 
>> I thought my patches in that link were a little hacky in how they passed
>> around the user/creds info. I thought maybe it shouldn't be passed around like
>> that, so switched to the copy_process based approach which did everything for
>> me. And I thought io_uring needed something similar as us so I made it generic.
>>
>> I don't have a preference. You and Christian are the experts, so I'll leave it
>> to you guys.
> 
> I hope this gives you some useful direction.
> 
> Eric
> 
> 
>>> I can see sense in generalizing some of the pieces of create_io_thread
>>> but I think generalizing create_io_thread itself is premature.  The code
>>> lives in kernel/fork.c because it is a very special thing that we want
>>> to keep our eyes on.
>>>
>>> Some of your generalization makes it much more difficult to tell what
>>> your code is going to use because you remove hard codes that are there
>>> to simplify the analysis of the situation.
>>>
>>> My gut says adding a new create_vhost_worker and putting that in
>>> kernel/fork.c is a lot safer and will allow much better code analysis.
>>>
>>> If there a really are commonalities between creating a userspace process
>>> that runs completely in the kernel and creating an additional userspace
>>> thread we refactor the code and simplify things.
>>>
>>> I am especially nervous about generalizing the io_uring code as it's
>>> signal handling just barely works, and any generalization will cause it
>>> to break.  So you are in the process of generalizing code that simply
>>> can not handle the general case.  That scares me

