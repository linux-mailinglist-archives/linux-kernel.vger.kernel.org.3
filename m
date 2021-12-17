Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED44796DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhLQWIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:08:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36524 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhLQWIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:08:47 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHLn5o8017979;
        Fri, 17 Dec 2021 22:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PKRHMNVCTbe2FH4nbKWa5KK01Alr3dQWY5Zc5ChCE0k=;
 b=dD7C/GP74sXYFkOJ0j1eiNRLE66vVJ1C3aesU7+B9mPgaHQ7s17htMhb44rhz0+nslDR
 OeoKMH1laC+tnx6/zjRt3bAGaUwnJkoa4ohYeOhMpjM5nEh4UQCrSwsuabBjIW0Nzk8E
 fFBaeToQEH69gqq3d9smMGVrqlP92EboO/hH/maMNAur9rTlMb5qTC6qc9iljDa/7qEZ
 479QmrF1KP14aVv9S31GyD+rRfkKgDzY+fEFHnr3c1tBakhF97HeprwLoz0UROH8Bawl
 EbszZRMy96hEYi+Sd+67fjUm0z37zNiHSQGTafEwQGXxkMMwWpxhaMZx724U60zYXOGn yA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrpx1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 22:08:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHLnwbd077169;
        Fri, 17 Dec 2021 22:08:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3cvnew3ggm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 22:08:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPxSHnxuEEHhhVp9jj83UZoe+VOCPsZRbNquwIa0irW5DlsrkjTTAQYsRla314utKnpcae5d3Y1FvTXm57/h6eM6wHqUA4kVnuO4B+0LBiui7c6jpYv8MXwj8nGGMoKgXNRN4FD/zHtbXcK/CQOLSUtmd5v11WlQwXrgC5M8nvBJ7TTxxfKxQd9F9Q2vt9A4QfFHto+kLlBR4bnuiZKS94iQ2sSvT1kVcEFPZyzB7PJRR2O18ozm0wiqcEHOu8zIrAxlGchv3nT4HS6U+UJ9pQZsZEF8/wDCEgcDIZWgSELsA5p/Td/opBU88DU3/FUMzhCB/Hr4gkL5oSBpTuRyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKRHMNVCTbe2FH4nbKWa5KK01Alr3dQWY5Zc5ChCE0k=;
 b=KWnWMiKOfBWNC/PVqyRKQDyunYVzQNjShtIJh7Von5DR5id8hLDspWstj7y2Icm9fBg2wDB1yMoudcjxwgwiu21pfNvNihihCtDkyi8RqRZSkAnYHjgyDUrbw1Ega+4YyzPXdFcqG2PTdpK/543VBMtX7ggqIZolywqRqmPAtYMIoINaIOKi6fV6JAcP+arCcuji3j2CQfu159z0/gG90rdQB+DOcgNOGgID1p435oT56FqbMgmAlIxn08iuGYInSApOzs+U6uvcf4N+1FvarGKC5a2vWdp0NMYu+nMZk3N4WOZEOc0kRiAnF+s3qyLDpDn3o3CZ8dHv/j7mHTjDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKRHMNVCTbe2FH4nbKWa5KK01Alr3dQWY5Zc5ChCE0k=;
 b=b/zsXAx5DOJnMPArP/1T0b5ZO5OeIQopcPceOeN2jvjn4q8pBVTUMLPTpPl0F8ZGEqf+Sy6XPoKojaAyAx4mMsjqPMTq3Hal+mAFIVsi9tLqUmz5VSW5JAwd67qMUzHjjmzRxKoNmLbkuM4v1zXSG48FeY7pM+TdoYFoI6v/vcY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3547.namprd10.prod.outlook.com (2603:10b6:5:154::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Fri, 17 Dec 2021 22:08:16 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4778.018; Fri, 17 Dec
 2021 22:08:16 +0000
Message-ID: <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
Date:   Fri, 17 Dec 2021 16:08:14 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
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
From:   michael.christie@oracle.com
In-Reply-To: <87tuf79gni.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::35) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb06a791-7df4-4268-cf3e-08d9c1a9ba0e
X-MS-TrafficTypeDiagnostic: DM6PR10MB3547:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB35473508BA209E5B94D480F2F1789@DM6PR10MB3547.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiFQRar6+jNG7XDZpUzTejm0m5TMMkDxZDWTJSF3NPhgZF8Z6Np7E/+87Y07Ew3OJyvNKl7uFuu961bU584CCVYxzNBWpenygjtwSvFuBqpZksHEJSuUAtWigQIuRwq3BveGyoBNklVhTh+wdQxg/n5f5CI89Yz1ZWh/qI8eliX2IMd7kDjFVydymVHm6WRRUk2NCuywmlcDqKQ9CM8his2BGAbkEvkcHd3qTL3ykLEXb7l0G2WMOwozWBhexYW9N1ubeaIW75wSheocKkMNIZXZqXIB7tRS+6gd+wDNPgh1wcHnPxhC5iUYCjZwwniSks4xpFlXvyadyJ9BRvx6cgAU0Kufo4GTb0tjkaXZsKEJN3x+UA8iMg77Ugb/kuQqfYgXZdEJ+bDm3x7GVQnv328fJcqc0pAFJeiVZt16yufGL6RdUujWj0slsU0TX/JAXeERchFceVDSiuPm7AzA7w8esEIF16wVnR69NP4nlYh2EzaluycCch3fDPUOsMmJ+5KMeqxObOqZvrv0z4F1tLxnVcERibJovAoNOL9k1S5+4GE92wvdILTkZTZNBVMMaq7FbVPEoZ58kBob544gXNJJFLZfp6UHOT51Wa8uVKk5Mcd4zKKso2TxHDEVE/y0TpeDXIuDbtajbmTHtXCXdCD2/TYzUdrF7iat1vn6F7ivD3NXwXE1YLE5wyuUjl+EAUZA86W886JTYg5ZkmxX5SWIWVGRREwpcLUvd9m0UwyQUXCV5s7nNYL0WAY5JWD2O0iYQi21kGnMEx2zSr+/RoJQY+Rl3XyTcBDlP/jrhqwG+hSeXYbl3qS/PVW2ummYogkODGCFyDrzlUWE8DaZ/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(53546011)(508600001)(38100700002)(6506007)(7416002)(9686003)(31686004)(36756003)(31696002)(6916009)(6486002)(2906002)(26005)(5660300002)(66476007)(66556008)(316002)(8936002)(83380400001)(2616005)(966005)(8676002)(4326008)(86362001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZuRWRodWx2QXFCOWc2SDVjWERLblBKVkkxSmhaaUFhK1ptdW9GS3EvckQr?=
 =?utf-8?B?SDM3bHNRem9jYUZTYlBjbHErVnZQMldxVW9LTEpjd1pVZG1oS1hXM0RVUFRp?=
 =?utf-8?B?MjhKR1FBZERqSWRGNmdPTVVKa2ZLOU5WMlhVQUliRjdvdlY4dDcrQVZmaE13?=
 =?utf-8?B?NElLRlhnQ0hZQ2ZEQ3J1WDRiaWF0SnZyd1ZVVWVLR0R6OVlmNlZqY2Vzb1JI?=
 =?utf-8?B?c05aWjIzazZqL0x2YVVmTXhLckVuWjNNMXlNRWtzTnVoaVVJa1daU0Q2ZHdY?=
 =?utf-8?B?WEpuV0VGakQvdElWYjF2dEtTWGFtVUIraEZRWFlHRjI4cEcrOEhXQTA4ZmVs?=
 =?utf-8?B?Y0FhK2tncmFaT3RRMGU1d0ZXbkRsZEZNc0JzUWpldjZPbFh1dWs2YjdFcmF0?=
 =?utf-8?B?blhEcGU4NU5tL3J5bHpNRHJXa25JRDByNzd1ZUYzZTNPVGpYNzZOUGUwR2th?=
 =?utf-8?B?UDRESFY3eTZDa0dPc05XQ1VtbTQzSGNWaVJwaTl4akM4U1ZxcGc2clRwbjl4?=
 =?utf-8?B?VkQzVjRKUi9FWDFzRnI5U1VvL0l2NU5WUWtuMHBnTVNuNUV3MjhLci9wYjhk?=
 =?utf-8?B?UEVsenZvR01LNkwwLzlraXVNbzVJYnJOQ2c1OXZzL05ZT1hEVng2a1FyMEg3?=
 =?utf-8?B?blhobFhKd1NZUVVWQ1loUzhFcWluV0ExNHJudHU5SGxwTEtaNTFrTHUraFEv?=
 =?utf-8?B?SzVvL005NjNDNFppaTZQdjMrV2lqeHU3MTdpUWdJNURrNkRxRXF4a1BMSTA0?=
 =?utf-8?B?YzkzS0FYamFaeTY5YVo5OU9pUmtDN2lJSE9FZ0E0VmgwNW5XY1M3eEpYY05F?=
 =?utf-8?B?c0UrcWg1b2Z0dUN1Y0xSQzNFeUNHRVcwb1ErQUNFNGVORHBHdy9xKzU0MjlY?=
 =?utf-8?B?S2t6S0tNNzQ5S3p6azh1cUhxR0ExOHh3Vld2UkpycXB3Z0drS3JGcTcyNHBk?=
 =?utf-8?B?NWFOeVkyWDBMK0VUeS9oUmFlMEpYZm1TRDZ4RUZRWkpGV2lJWlB2bDNlR1da?=
 =?utf-8?B?Szdsanl6bEVMRjZGOE53UkV2WVdyUis4ZTF0bll6QkR6NGJjSUFwQWtURDk5?=
 =?utf-8?B?UnBHV2VNeG4xUE14T3RNSU9GT3dxSVFmNW01bStHT0diZzA2enhtM3dSMU9r?=
 =?utf-8?B?dVY0M1B6UzB0Z3hlVzhvdDNjai9wMlpGVmF6TFp4SDV6VlZqY3dPUFgvUlAx?=
 =?utf-8?B?SytzVG1tU2J1bnFlTEo0aDlaY090YUpSdWRtVjNTV3lxdElTeGhJOTFnSllL?=
 =?utf-8?B?eS9QaXl6VjBXOGMzcldrVXVrZ3BjNEFGd1lBcUMwaklLaU5RdllJcEF6ZHJS?=
 =?utf-8?B?MWdSODFDeHZuajZUV1NoY2N0V05HczFIRis3dys3Q2Z0ZkloVWRobGxNMW51?=
 =?utf-8?B?NnlPUTJGck1MZ0lOTmN5NnZodE8wZXZlT1NWMWh3ckNzbkM0Q3d1MGpRKy9w?=
 =?utf-8?B?MHdJcVI5U1hYR04yN0p3U0N0SVJYN3RZRVdmaDQwaVB6MExZWFQwTGRhSVB6?=
 =?utf-8?B?Z1F4VnBucnZ5WlNYbXRpUFY3YjRBR1BQc0phZ05GR0RPOWgvYUxmNFpnNXJ2?=
 =?utf-8?B?cGlzNzBwcGl1V3NSUitxbGtNZVVFcVg2OWYzKytQTlJMeCt3SEZSbklHRzM1?=
 =?utf-8?B?bHhHci9MaW9Ra3JMM1R5S0MreEZvcDZtNlliZjZWa3ZNOVZNeHFtVGQwcnNG?=
 =?utf-8?B?UzRwQUFwd0NIYVpkVGtLbXJHL0tuTEZsMVJnd3N0cmVHdlBUYjlCRTVQaFBz?=
 =?utf-8?B?d0cySEFBekVJWHl6TlhQTThXOEp4U0o5WlljSVFQODdOWkpwUHUrWUNac0tw?=
 =?utf-8?B?bkhNUDJIempXcUR3dXhScEdGVHl1K2JLcXhRdkhWZDFYUDBnVmY5SmlNQzFL?=
 =?utf-8?B?Q1E3czZtNFJhcjFTRDRtZmQxb0p3QVl3cldWQ0o0OG5XYk44WDdBNkhkTlB1?=
 =?utf-8?B?anAvRFpTbkxLL1JYQXhTenNvb01VM1JrKzRnR1JobGZUR1YyS1EzMW94SW5O?=
 =?utf-8?B?Z3BMM3luZjFUay8wSXd6NXNYckZxUkJKMlBXSWhqWUhsbEhudkFSelhRL1Nt?=
 =?utf-8?B?Q0hoUnRiMU84TDhpY3EyZzRIc3JQVlJEaWFjUmlYSFBTalhlYitITkdheUI1?=
 =?utf-8?B?Z2FKSk5Dc0FVbDVUODIybUJiam9JdkVqeFRVaUlPUjAzQXZ6dnlVN3NoM2pw?=
 =?utf-8?B?akFoMVA5allGc1Z0RENLTEMrL1loR1JjSFFtK0t4T01aMmg1d1IzU2ZRSUNn?=
 =?utf-8?Q?spx28tucBJO+QS4kwjBxunzZDgeyUqG5M+qPJwEZFI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb06a791-7df4-4268-cf3e-08d9c1a9ba0e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 22:08:16.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2ksqaI0hYBOkDFd+AEXJcruNrsco43Ggvcp20IEVD5wT7Thv9unQ/D/3MZkYvwDyNB9WBXlil2D/ZBtDUvQR5iWwq7Dp1RDK0aXC+gBqIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3547
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=778 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170123
X-Proofpoint-ORIG-GUID: -SDVxUYVhg1fTyOyKBHyqlUcwiiFWB1X
X-Proofpoint-GUID: -SDVxUYVhg1fTyOyKBHyqlUcwiiFWB1X
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 1:26 PM, Eric W. Biederman wrote:
> Mike Christie <michael.christie@oracle.com> writes:
> 
>> The following patches made over Linus's tree, allow the vhost layer to do
>> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
>> io_uring does a copy_process against its userspace app. This allows the
>> vhost layer's worker threads to inherit cgroups, namespaces, address
>> space, etc and this worker thread will also be accounted for against that
>> owner/parent process's RLIMIT_NPROC limit.
>>
>> If you are not familiar with qemu and vhost here is more detailed
>> problem description:
>>
>> Qemu will create vhost devices in the kernel which perform network, SCSI,
>> etc IO and management operations from worker threads created by the
>> kthread API. Because the kthread API does a copy_process on the kthreadd
>> thread, the vhost layer has to use kthread_use_mm to access the Qemu
>> thread's memory and cgroup_attach_task_all to add itself to the Qemu
>> thread's cgroups.
>>
>> The problem with this approach is that we then have to add new functions/
>> args/functionality for every thing we want to inherit. I started doing
>> that here:
>>
>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!eIaEe9V8mCgGU6vyvaWTKGi3Zlnz0rgk5Y-0nsBXRbsuVZsM8lYfHr8I8GRuoLYPYrOB$ 
>>
>> for the RLIMIT_NPROC check, but it seems it might be easier to just
>> inherit everything from the beginning, becuase I'd need to do something
>> like that patch several times.
> 
> I read through the code and I don't see why you want to make these
> almost threads of a process not actually threads of that process
> (like the io_uring threads are).
> 
> As a separate process there are many things that will continue to be
> disjoint.  If the thread changes cgroups for example your new process
> won't follow.
> 
> If you want them to be actually processes with an lifetime independent
> of the creating process I expect you want to reparent them to the local
> init process.  Just so they don't confuse the process tree.  Plus init
> processes know how to handle unexpected children.
> 
> What are the semantics you are aiming for?
> 

Hi Eric,

Right now, for vhost we need the thread being created:

1. added to the caller's cgroup.
2. to share the mm struct with the caller.
3. to be accounted for under the caller's nproc rlimit value.

For 1 and 2, we have cgroup_attach_task_all and get_task_mm
already.

This patchset started with me just trying to handle #3 by modifying kthreads
like here:

https://lkml.org/lkml/2021/6/23/1234

So we can use kthreads and the existing helpers and add:

A. a ucounts version of the above patches in the link

or

B. a helper that does something like copy_process's use of
is_ucounts_overlimit and vhost can call that.

instead of this patchset.


Before we even get to the next section below, do you consider items 1 - 3
something we need an API based on copy_process for?

Do you think I should just do A or B above, or do you have another idea? If
so can we get agreement on that from everyone?

I thought my patches in that link were a little hacky in how they passed
around the user/creds info. I thought maybe it shouldn't be passed around like
that, so switched to the copy_process based approach which did everything for
me. And I thought io_uring needed something similar as us so I made it generic.

I don't have a preference. You and Christian are the experts, so I'll leave it
to you guys.


> I can see sense in generalizing some of the pieces of create_io_thread
> but I think generalizing create_io_thread itself is premature.  The code
> lives in kernel/fork.c because it is a very special thing that we want
> to keep our eyes on.
> 
> Some of your generalization makes it much more difficult to tell what
> your code is going to use because you remove hard codes that are there
> to simplify the analysis of the situation.
> 
> My gut says adding a new create_vhost_worker and putting that in
> kernel/fork.c is a lot safer and will allow much better code analysis.
> 
> If there a really are commonalities between creating a userspace process
> that runs completely in the kernel and creating an additional userspace
> thread we refactor the code and simplify things.
> 
> I am especially nervous about generalizing the io_uring code as it's
> signal handling just barely works, and any generalization will cause it
> to break.  So you are in the process of generalizing code that simply
> can not handle the general case.  That scares me
