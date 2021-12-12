Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0E47190F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhLLHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:21:38 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:26465
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229450AbhLLHVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:21:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNpykRVK+eQg6dhWV95XbySmva/2gtu/vXKl/P6uPiHfDrV/JdbamYns/mYS0s53C/NJJFAiQI+31ckOUCosEtZM5zkrsYZJp4zbDZpo0FmihVji9Djo1f1T1RsxPgD2/bnzTzVFVC/eh2nSd4Ozt55AKOxc5FqVrBHdy4B71JMjTLHxQKr8hCebG7siCccC+zjF1Hj+ijTDMXx/BnqPCqbhv1ryZfM6ZUUU0/ISlUZb2f9zj1TbUf7hOCa4JIw117um4D4hioeRUo+XIDdtmcoUUL8DaM3ynEs/32Wg5McSnRDw936YtQKNE+FH38QOx/YxG7A7g0joJyIZpY0gVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYB7+0e8GCax72ezMSSNnF/oAEqJXA7SYzTIHJDNvhk=;
 b=V4nJspH8EiiOa2SvpmaW/UdrUc4J3LpZ3eK/SANttVqlxuMnD14ZyMEW58I9vAapkm3jBw15dAOU8do3hmGKA02Gmo05orkfgvZe4NLHzXFhe/X4M+1WmOL/FSbLTp8HbquvnX024JFKwgMfrT5SO8f4AsBDU02u9kB75g/kb/efoYMLzmTgtLXm/qDUx1VKwxXlGjCzjYo3KRJtz6tK5UjU6J6FYWbHWydpG4ABO0rsQoE948QGwjDaiEO/YAZww927Ld4XlhQvJjUy3LH1ZCWLeHgnT0i+EEj8EwCAs8h+ZDrOctxhRQA+HN5RWXI9v3hR7tkgUkTrZEZqT0gycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYB7+0e8GCax72ezMSSNnF/oAEqJXA7SYzTIHJDNvhk=;
 b=SGp4rQl5RgEv5DP9n89F8stCQyvnUNqjIklMxeUWo8pknEmjVDnrk3oufBGfnE82Rrd8HbSnlYt1CBpCVzzP6O3H8qIM9JaH7LcFvpyRbsQ4nIPLwi+LdJsEzZ6zFNPFRVNPWoWP39IHEFmwlRWMDXkoNJz/Hv37oe07Ath7TxzHCRgGLRFo9D5KahR1joOxPm6+TEHLD+ht0mCmLZV9h4pA8fN9UrgcAwIKnljy2kfe8WHwRQUlh04XocsPBYYVwNPmnlXNnlOdNbjo9CkYE08IvR/IevvErs3YhIT6vlY4tix96VeULjtsya0vQLnxIb2PfJNR06iT42lcddA4Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Sun, 12 Dec
 2021 07:21:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541%3]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 07:21:35 +0000
Message-ID: <782d631e-6610-c971-5800-66fbba41b425@nvidia.com>
Date:   Sat, 11 Dec 2021 23:21:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC] mm: introduce page pinner
Content-Language: en-US
To:     =?UTF-8?B?6IOh546u5paH?= <huww98@outlook.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     =?UTF-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
References: <20211208115250.GA17274@DESKTOP-N4CECTO.huww98.cn>
 <YbD8naaJrZQANahP@google.com>
 <TYCP286MB2066003B2045AD6ABE4C0295C0719@TYCP286MB2066.JPNP286.PROD.OUTLOOK.COM>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <TYCP286MB2066003B2045AD6ABE4C0295C0719@TYCP286MB2066.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2ee1db-87b4-449f-2996-08d9bd40075a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4999:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4999E52928F32FA233527A3CA8739@BY5PR12MB4999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phDf4hiBCQ8JOY6YvcGhCfIu1V3Yurzy8h0BtkISpG4WPhKxLSoVmP3ojRxF7L1EdJOH3JylIWwdDZTDkqqd4vJoi3cYV+GCtxTLeydh8AKI9u8Bdgmt/RZy8h14XLMiIcJvStlzBJBOqtVIrlliMdz5xYpVb5xUF72CzN9yDfD1wL+xNGWradG9ujRu0nTQ0moC8bSOOYIM6kThvo8nhlUh4YTvhA10RjnoOIMuH672yBOU1ZzNXGmNdl+nrlofDVuR4wiUc80hRPFlLlCkW0O+5bfdhLd5WJXp/iTGsRPrdOzr+ZEfIM95ksB7jgpyUpS/V9mbwfUV0tptffPs8bZJVbc/FJFDwJ3dmSFe0iH5h2K8GSBpBpNIkt/HBXCaeMRQBr533EZgy9g0S+hCch3UUWet3c++Jw1SThaFAQ2HQTUmA1w7bFdHJ6Tc9Yxub1Tk4O+TK9KNHYvjlL07B1tSOPOoqFpE5JtMwnfL4ibbBHTzRaghZtVzwy82sUEsd1Ff3PQSZAQJckY7AuThZ+2RpkWO9EaoXNxXOv6sMOaAx9Wb440OHmBxg+03nbrL2P+CmHZWeKh+2UXvnAGRZ0HXg0ibxtaZJ3tnqtpMPJSoxTKYK9GTY+acJfvg+Nl7vnueNwhQR8fQs0k+6LrpqOzdJ09Ebvw0fQtdNVnoZorl9WsfhWnbK8x77xsRUBbY0t+Q44uK+7ul9K354OMMcXLOgxbmbftQZiYdMfWb/aI4YS5Kt4FbUoihPJkqqTXopG8z/eqtRskZbnlkIBd4P63jc/PUZ3tJ2YuJnG+Sj5791v5EMw840F5AGncPztdnIIzxok6L2M50JBzpkJyLNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(186003)(31696002)(26005)(31686004)(53546011)(38100700002)(966005)(66556008)(86362001)(6506007)(316002)(2906002)(66476007)(508600001)(6486002)(2616005)(7416002)(4326008)(66946007)(54906003)(5660300002)(110136005)(8676002)(6512007)(8936002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hDa1NyNC96SjdnS1R4Q3RjWERiUHo2c3hZaThuMGZDKzNtK0lQemRiMHBN?=
 =?utf-8?B?aFpxUFRxWHpsNUlTaFEvL2ZmQmNPZkdTSXRXMHY2RE83SGhDNjNiZHFsL3ZK?=
 =?utf-8?B?amJKbExzQUJkb29leHpNMklXUi9rNXFMY3VWWU9VRkVTMFFLZ0lldDRtSlVh?=
 =?utf-8?B?WkdmUEtzejFQU2p1T3h5NDd2VjUxNVFaaml5SGFoaG9YbnNiV2FCMnZuQk5W?=
 =?utf-8?B?YjVvcmMzWUtITHlwYng2U2ZmWHdLN0FRdFFxZXF2WkJUbFZnNWdacFlYVlUw?=
 =?utf-8?B?U21yaVFIRzh6d3lWeFpVZFFuYnU3dzFqRmMvOG4xaVE3VThWV08rN25DelFm?=
 =?utf-8?B?OWVlVzE1SEJWZXhUMXhGWFRCUWsvR0VBRlFmVXRpWlVqT1pEd05JZTJYbk9s?=
 =?utf-8?B?cVZ2NnJFQ0x6Vjk5a1BwbDNmUERnN2FyUGlYYXdSbUxxODVpa1E1ZndYTlF5?=
 =?utf-8?B?TnFqU1pZT3YrSFJZblpqZndkK2xIVnFRMGRQWFY1b2cyNENGeE5OdWVjd0xJ?=
 =?utf-8?B?YkpWc3hxMjk2ZkQxUlQzUk40L2c3UTZCdXR1VjdESWplcnN4Szl3ZTUxdWYz?=
 =?utf-8?B?OFRiYWsrN2ViMUlCMGJMMzBtSTJxRmRpUjJCWjhtaWtFcW9zbUUyRVlxY3o4?=
 =?utf-8?B?bTdzLzhYK1l5NWJRK2NaWHFKbTVaMk9UU2dteVlzOWNvL28yVE94dUlUOFQv?=
 =?utf-8?B?WU1RVEtLWlA3bU1uZkMzbThRT2NRcW1Vd0Z4d2FvSkk1RzVTZ1FDZXBVTHF3?=
 =?utf-8?B?UkY2RjFlME5hdERwOEEzd1I1K3dDaDJ1bHdZT3JKbzFZUEx2M29IbjVaYkoz?=
 =?utf-8?B?ckZpY0JxSHJWYmNUeU1BTE40em5nbWRwVGs2cnpLTWxiaWdsYkdiTXJROU5k?=
 =?utf-8?B?UXhMQXAwVkhjdFZ3c0dZNFBYMCtJS3VOOGhaVDE4OU8xRVhLRlNDQWN1RTl0?=
 =?utf-8?B?NHVhRVJuKzl2R1hOYThuREJONkF2SVBpalpjNUl0RnQwaXpIeXozdEo4c3F0?=
 =?utf-8?B?UUc0ZFUvOVRRSlNFUjV4WmovS3ZMQjFMYzMvMk1HMWcvc2I4Rkw4Yyt5VFZN?=
 =?utf-8?B?L0Vjd2NiTmVsdnJnNjFxTHVYWnhkYUIwS3E1RWhhamxEREZIanBVZXZrTlZ0?=
 =?utf-8?B?Zk5UTkVBQis5Vm43eVJZbkJCaFdYci9JZlhtWTBFcG5YclkvVHUzVHdnMnhs?=
 =?utf-8?B?QURuY3ltQXM1aXhzclpDOEdhWUhLYnRuZTROck9jQVdkdnZsTi9uSWQ3eWJS?=
 =?utf-8?B?ZDYwU0RGMWUrcHVZQm5RNjduZ0hSOWpocmJRYnE4QXg4QTFsQy9ZdGlSUG9n?=
 =?utf-8?B?bGJMRTVTVUlVQU8wQmdYZzFFTmg1RjBPdHMzQmNrMEZCM0Q0aldlNnNTOFZF?=
 =?utf-8?B?SHBManVYQmUxWVhDR0dWbGN2WXVtZmdTN1RUekpjdnNUR1lJMFEzOEpVTDNK?=
 =?utf-8?B?QWd5MlFwQ3RqN1VYd2JXYmp5TWp3V3ozOHFFRGptdnBjbFdCZ2ZaS0MzMFJL?=
 =?utf-8?B?VVJmNlVtWU1PRU4yU2lEbFlmVEl3dklVLy9EM25qUW5wb3pxNHRNbk4yeDUr?=
 =?utf-8?B?b2loNGpydzZ5K2ZkY3FsZDlHemtIR3VrUGg5TUVQZ2tuaEtGS01hVFEzc1hz?=
 =?utf-8?B?MXQwSW9aYUFJZkdrTjZIakpVWCtwN3lVYURHUm12NzdJdXByZ3c0dWpCU25Y?=
 =?utf-8?B?dFF6UEd4Zml4eEh1Z1lzVGpESmlKQnUxWmZJaStWWnp0NzZ0dUFLUU5zU054?=
 =?utf-8?B?MW54MmpvWHMwZk9LQXRWVnpYbUhQVU13enI1NW1yaDdheDA3aW0veHFYVUlu?=
 =?utf-8?B?S1I0VzRCdmZkbFRqblpsc0F5YUsvQThmKzFRVkdrZUd0cmlWeGFKeks0dkVC?=
 =?utf-8?B?Z2FiMHpOdTFMVWY4clhNSFNFaWxPRW0va3puQ2FTQllSeXdDTUsvT0NmWlJ2?=
 =?utf-8?B?R3UyVHo5TlhyVmlsNmtpUDljcXZqZ21QUlpQNk1iS2VPZDAwRTFKMWk3VVp4?=
 =?utf-8?B?anJtZEpNV1hFUVRBQzBzdkJjWjFGenY5VzFIOHlKNE5QMGphS2pyeUlLeG5S?=
 =?utf-8?B?UDV3RnFoMHI4SmUrbmx0clFOZ0I2SFNlMlFKanB1WXlSekdKamE5c2lNYWU5?=
 =?utf-8?B?RFFpTmJzNHJZT0RSVCtQRXF4dHJ1TWVzQ0ZzR3pZdGE0Z1pCaldBVjRPaC96?=
 =?utf-8?Q?Di1wrM+ICf47KJ2VXf2vrhE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2ee1db-87b4-449f-2996-08d9bd40075a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 07:21:35.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9tXL1+1CFQDc+3ZSmYE5SOsVPEgU5pUIgCJb60eTuJ04vsHX1rLOwBcdnfILPmQ3FzEQAfOoSz3v7trk4qsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 01:54, 胡玮文 wrote:
...
>> So you are suspecting some kernel driver hold a addtional refcount
>> using get_user_pages or page get API?
> 
> Yes. By using the trace events in this patch, I have confirmed it is nvidia
> kernel module that holds the refcount. I got the stacktrace like this (from
> "perf script"):
> 
> cuda-EvtHandlr 31023 [000]  3244.976411:                   page_pinner:page_pinner_put: pfn=0x13e473 flags=0x8001e count=0 mapcount=0 mapping=(nil) mt=1
>          ffffffff82511be4 __page_pinner_put+0x54 (/lib/modules/5.15.6+/build/vmlinux)
>          ffffffff82511be4 __page_pinner_put+0x54 (/lib/modules/5.15.6+/build/vmlinux)
>          ffffffffc0b71e1f os_unlock_user_pages+0xbf ([nvidia])

The corresponding call to os_unlock_user_pages() is os_lock_user_pages(). And
os_lock_user_pages() does call get_user_pages().

This is part of normal operation for many CUDA (and OpenCL) programs: "host memory"
(host == CPU, device == GPU) is pinned, and GPU pages tables set up to point to it.

If your program calls cudaHostRegister() [1], then that will in turn work its way
down to os_lock_user_pages(), and if the program is still running on the GPU, then
it's reasonable for those pages to still be pinned. This is a very common pattern
for some programs, especially for those who have tuned their access patterns and
know that most accesses are from the CPU side, with possible rare access from the
GPU.

>          ffffffffc14a4546 _nv032165rm+0x96 ([nvidia])
> 
> Still not much information. NVIDIA does not want me to debug its module. Maybe
> the only thing I can do is reporting this to NVIDIA.
> 

...or hope that someone here, maybe even from NVIDIA, can help! :)

Let me know if there are further questions, and if they are outside of the linux-mm
area, we can take it up in an off-list email thread if necessary.


[1] cudaHostRegister():
https://docs.nvidia.com/cuda/cuda-runtime-api/group__CUDART__MEMORY.html#group__CUDART__MEMORY_1ge8d5c17670f16ac4fc8fcb4181cb490c


thanks,
-- 
John Hubbard
NVIDIA
