Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B0747E54D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbhLWPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:02:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15680 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239868AbhLWPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:02:23 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNEiQjn008953;
        Thu, 23 Dec 2021 15:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D4qd6VJUvGEjR+D0DCj6v9yAvMnn6qpYlyHBs8QT3bo=;
 b=ed6YmndA18vW3aXYOlHbZxdczXyaQYvXforzMEzRUgiHXfoFjKQxhCuKgrRD54LvkZNb
 HXZ4ACeVNU9E+YjJAoBvb2lhjwGyduMwHd4Lf3qH1klv3GCJR1Opp0dU+yjos5sWahHf
 2x5XXbqX5Q7yFZpgiZ5N7iBUjRIra3iBohI1nzrO+kAiY0YEI3z1wbcMKfu8FiCB3A/9
 9+y3edIR03r9PjkJhTQp5OdzDdRzDanNCFoQB+iey3+4l5iWpe7Zgyu2hK27npXrcnyv
 IHjtddXI4MOWfCkSpB2H7crarnUEh8mq7njljSaqxNX/s8qbtIcYjy+6b5P69xs27/UB Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d4maw8vdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:01:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNEv43J179232;
        Thu, 23 Dec 2021 15:01:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 3d14s07tv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+bmc/YQTF+P+E4rAGVxFqCnsOZxNJVT7cwDYNMdOJpProGtZElbfUJQoqYRF50boku4i7v4VFtNP0hSQEwv24hZZSAJ2DlQ0vtgJOBodrQ7ePBr7dQhgvmd8W03peFjHrXNe3ulLIpxZXFG9SxZgw1FVvOZiMKrfpnpYD4Buschf92rUMg2o8FW8rOXadJA+mEuFVdHHWBLFae81pQXiQchqm6b+3Q8smBF27tv1Dy16Fpw0P/g+goGY+nTyCZ/gKJqTFsumeP+cLiYpMlCN5ccJkxycyvWYLKJ2QYrkN/AQrl7w1Xk8em+2CsjqwL6nDdtC5ZuLuj8EPt21OlE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4qd6VJUvGEjR+D0DCj6v9yAvMnn6qpYlyHBs8QT3bo=;
 b=HKt5Fh9cGUp1/HDlZMBAYC7Pa4gef9RoFGM9bO7iVV+LMpzhZMdWS5wh6rmmA9bW9Q/96CMwLCwznbpw7auue8vyLjZ/TacqRcEBska2ObSm8khMGghjUOHhcBUs4QhjIqWQUbKqiGSCVpZrRhls1HQ0eHgd3oqg2Ah4KoicuBRHyfjhi7MnflQxHB70hpuSPWUZdle99Y/GHjpN4h7aohDLc4dbIwKdO/V51fxz1/H6IH2zjMnOuRvkaQEWq/PifOwt12dNqLnGulcvUWln/9P3xrSgrwZx8oHVQBdzt/U6gJiH1hIVtNN1JuZRitQ9JNh92zc8tWhXsOoQAYAL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4qd6VJUvGEjR+D0DCj6v9yAvMnn6qpYlyHBs8QT3bo=;
 b=cICIw68VtRXYyZuSP0uYL3pphDDOOVIHrWtZ3pMA15Iks8pgyBYw33D2Z3if91vmKWMvakGnkDpBMFyG250wzVFwGvm75rq1FH4tU6XHcgV4+jZXQRDSMfO6X0lpQqe5808bziqB7EKc0XP8rN2nUaUa4U1EneYON+Dzd21x/5g=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1806.namprd10.prod.outlook.com (2603:10b6:300:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Thu, 23 Dec
 2021 15:01:50 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4801.020; Thu, 23 Dec 2021
 15:01:50 +0000
Message-ID: <a5bbe855-2980-0e99-dbf6-6f860bffe491@oracle.com>
Date:   Thu, 23 Dec 2021 09:01:38 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure on
 zone DMA if no managed pages
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, kexec@lists.infradead.org, 42.hyeyoo@gmail.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com,
        x86@kernel.org, bp@alien8.de,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-4-bhe@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211223094435.248523-4-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7ba067b-56f9-49ec-4051-08d9c62525b0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1806:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB18069F17CC0D3BA668BB5A97C77E9@MWHPR10MB1806.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ayt31ujw+znrv7AD3w9hsUL5CObhCOzslw1iasjTVGQFQHwV/AS/0f8K8F4e8DKuZDI5EfFrMSg8odPeNfvM45szsbHuD/U3iXWVAh8tAMz/WVaiunuTdXrJV87beuvIDOIQnl44JfA0Yzbqxz6234Zj8aVGPYFp7y5owQRfBcFswYE5Yh1xblzjRcWyJw88ptt1xybk+kcAoWXudK32WlOVf8+gkK7bdq2D6rKGAl05nRu0ceJNggyss+2PVKUOPjMPRxZftxrSLdit0mZTYdOHwres5DyRQhCXnGjbkbiNwN5Z7+t7LXSYDBGF9VeerJEm9PSOJLbNEY3MRKdhFReP7WwOQMMKtzFO890cgnuo+cXcME6Uhl9Rbv1rF0PHl5TT+X3WwHimI8UhVO8RtalxZEyg6YoW08+75z9idl/2+LVhPVoIJLV9UeDlg84gHjv4OIuE7Sbg80EMu+0TmRJCsrjAnjTH666vDINRwongbrofAtEaeK2nMQmPiKVG+IbTJPX6EDzXPy4gKMJIFbtJyEHpqG47rSLKuuK3uA4YR5+dMXItpq7buQczjI5TRIyj1EXs9o5ELPh3YnSY+rtVfneJnC6dH3H7hdOUUlgzWWcbFwJ0One15sNuKurkw3kni5N9tFnrTOLv1M6dojM1JnkkPdSwMiPkmLoe+hNBt4HgyZNz2Tnoc5BjNQXtgdVoddLnK556pGErUBzemQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66946007)(5660300002)(66476007)(6666004)(31696002)(316002)(66556008)(86362001)(8936002)(9686003)(26005)(31686004)(38100700002)(6512007)(4326008)(8676002)(36756003)(6506007)(107886003)(6486002)(186003)(2906002)(53546011)(508600001)(7416002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFArV1RpbFE0b2h6azVPa2FvMTRHR2JQaGd4aW9FcFM0bVJlazJiVldGSTJV?=
 =?utf-8?B?VU9KU2VDMDVNOFg1SXB4bGQ4VktZaUhaRy9yRFlyeWF2UXY2SUVwYUhySFAr?=
 =?utf-8?B?RjE5M3YyRnh1ZmxaTkw1TXAyTUZPUDdvdGl2UzkxZUVnK1dRSU1paVlhYlFn?=
 =?utf-8?B?YTdFMThnNnVNR3RnSDhDaTFUWVNKM3FBbnUyREwwMTYvaWFUUlhYU1hoRVR4?=
 =?utf-8?B?YmpDOE14OVJqaGFBNVpOSTZXZVppMno5djlmbHcrWjZiQ2t4WG5jTlAxbEpJ?=
 =?utf-8?B?OHU2MHBXMlBRN1AzekpRMDV5SkRxNTEvdEtsa2ZLSjZYLy9uQ0gra3JnbFV2?=
 =?utf-8?B?dzlhYzhoYkdyeUREV1ljQlFMNXBCeEowMnU5bUdXSGN1MkJiZ2pCYWdBVytN?=
 =?utf-8?B?WXc0eGxOMGcxK0l1Q1Q3L2NaQks4eEJLTXNKV2lEaGg4Z2dKRitlR004V091?=
 =?utf-8?B?eHJ4WUJBcGJGTEkyV09Ga3ZCWE9lWks2THVRUnRrYVYvaFYxZmdpa0F2RWYx?=
 =?utf-8?B?b0ltQlltbVgzVTBvN2hRazJjT0Z0UEU0ck5aK1pRV2JLckpVREo4QWt2VDll?=
 =?utf-8?B?V0IxamhjUUdYQzdMa29FMmJUalBvUVQySVpaR3lQTmhETDZ0a0M5V2Ixblhj?=
 =?utf-8?B?MFJsZ095c0hhTThSSTd1c0xYODZ4dXYzaGh4bEdrQ1F4TVZOeVRrTjd0VVQy?=
 =?utf-8?B?cW1EMDl3alNLaXRjUzRJUTJIQ1R2bVNrdmZITkhuSHJzZG9WOS9FWUx1VW9G?=
 =?utf-8?B?WGZWVXNoUHppK285bzRUOTZTaFZCSVdqK0w2WnJWNGZQWHhiZ3FLYmFEYnh5?=
 =?utf-8?B?TTc5Y1duL0pPUEJnclF0MjcxWGd5a29GdUU2Wjh6d1hMM0JIR3Fwc3c3cnlS?=
 =?utf-8?B?dEVreHRjTEYzMDhHejBFSk8ybXBaNVFiUkQ1SDlqQkV2WFVEQWFqcForMjJS?=
 =?utf-8?B?U3JCRWJTQzJqeGdHbzk1M1hJamtpQmdranovVTdxN1NHU3FyMEdpRlowMjlr?=
 =?utf-8?B?TmtPR0tEcDdhUFFVZ2FLaVo1YU9NQWN1ZmdETHBnRVhsdlh1ZnA4Wk5WRDRa?=
 =?utf-8?B?RWc0V21LaFBYOEZyNDdKWDVNQlpvMCtDOEhDdVRpNXVCTWVzYzJJOVdqZkQ4?=
 =?utf-8?B?NjhscUNHeXR4QksrUEQ0YXJnWnM3RDlFbktORzFGS2h1MmRjMDU0NjBsTWFr?=
 =?utf-8?B?NG5LVUFoWkNFYzZjY1o0QjVPS1ZTYlFRQlo1WjFVcVhZMUJmcFJaL0RZM2JX?=
 =?utf-8?B?S3liak13QTJPYlkxbmlXbmdaemdBRitsMTVhL3FzL3JIdjdhNDR1K3hDYUFY?=
 =?utf-8?B?OFgxeDJvcUhQNjZTZURydEd0YStQMDhsdmpMZmgxQXMyNDFuY3ljbGxoMW1t?=
 =?utf-8?B?cnVqb3VCaEdlQzBoN0R6RC9aZVhoaXpPaGJzUTEyUVBQOG15Z2daNlBNbE5F?=
 =?utf-8?B?ZHdvRXdYV3lvL2VPdnEzMGc1T1MyWEh6SjJxTmpseVczc3hUSmNJVzdhM1Ey?=
 =?utf-8?B?ZjN6MDNaclN1K0tQaGkrYVArekNQMGFCWHVKZGljL2pneE1va0FzRFg0Yzkw?=
 =?utf-8?B?WjF1VFZmSFRKN00xenNnRXhtS1pCNjhtaDZWWlN1bFNadFB1Y0Y0N2p2bUNY?=
 =?utf-8?B?SXpFUmdlMC9KMitDdlBZRXA0d0sxbTJFQXNva0NBT0c2S24vNHNvUk1nSk9J?=
 =?utf-8?B?RlgxdU9NZk9kRCt1b3RLbUpXelAvQ29DZDhzd3JXMEdoS0tpdGVCQThKNWIw?=
 =?utf-8?B?OXVjd3J1SVp2dzhmZHJXaEI1Qk5iNDY5amRjZ21hNlozSWJzZjZIZkQ2TTJB?=
 =?utf-8?B?czhERW9FVWowdmVjWStqZmRINEZlRGNDbm0vSFovaG5sa2cyelNyQnYzaWZh?=
 =?utf-8?B?SHRJQkZmS3dlNXltcHQ2QjllYW00Y0VxU21pVkdYWk1IZDA5WkwyS2N3MXg4?=
 =?utf-8?B?cjVrcHVsTXZjK0NnUUFJOEhzNm1wNEJNcmhuSzd4ZW5ZWHZST1k4SW5tUEc1?=
 =?utf-8?B?eHkzY1ZIWU9tdUxwbHYrYUVFU1N4V0RYRTFuUGZaN0dlVzcvWHJ0aCsrbzFi?=
 =?utf-8?B?UTRMaHhHdlhSYlk0RVllVWNXZWFtbE9RZFVHZkNJcXFETXM1QmEvdEN3d1Bp?=
 =?utf-8?B?ZG5vUWVlS05FbEoxNGFUQVZpVVFoZ1BHRllKaGJXRy8rd1N1SHQ3V0xxa3hj?=
 =?utf-8?B?emJnejMvTXl1b1h5QnhqWFhKKzZ4K0tYczhHdkxXY01KUzZ2bVNVTDREWDFv?=
 =?utf-8?B?WWZXaE0raTk1QXI5WEZjMWNNY1Z3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ba067b-56f9-49ec-4051-08d9c62525b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 15:01:49.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRfkBqM9ZqVZNzGa2szb0hgYz89KW5NbsBegvEchKUujQOizDFWpxphI4hLb/uOSC0I1JPKwuLfpP2CJnJ8pnT2szJtaP3P6yCekDuiSdzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1806
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230081
X-Proofpoint-GUID: FiE-WyxL5Kd5FO-cyFbta5c9FsNo47El
X-Proofpoint-ORIG-GUID: FiE-WyxL5Kd5FO-cyFbta5c9FsNo47El
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 3:44 AM, Baoquan He wrote:
> In kdump kernel of x86_64, page allocation failure is observed:
> 
>   kworker/u2:2: page allocation failure: order:0, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>   CPU: 0 PID: 55 Comm: kworker/u2:2 Not tainted 5.16.0-rc4+ #5
>   Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
>   Workqueue: events_unbound async_run_entry_fn
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x48/0x5e
>    warn_alloc.cold+0x72/0xd6
>    __alloc_pages_slowpath.constprop.0+0xc69/0xcd0
>    __alloc_pages+0x1df/0x210
>    new_slab+0x389/0x4d0
>    ___slab_alloc+0x58f/0x770
>    __slab_alloc.constprop.0+0x4a/0x80
>    kmem_cache_alloc_trace+0x24b/0x2c0
>    sr_probe+0x1db/0x620
>    ......
>    device_add+0x405/0x920
>    ......
>    __scsi_add_device+0xe5/0x100
>    ata_scsi_scan_host+0x97/0x1d0
>    async_run_entry_fn+0x30/0x130
>    process_one_work+0x1e8/0x3c0
>    worker_thread+0x50/0x3b0
>    ? rescuer_thread+0x350/0x350
>    kthread+0x16b/0x190
>    ? set_kthread_struct+0x40/0x40
>    ret_from_fork+0x22/0x30
>    </TASK>
>   Mem-Info:
>   ......
> 
> The above failure happened when calling kmalloc() to allocate buffer with
> GFP_DMA. It requests to allocate slab page from DMA zone while no managed
> pages at all in there.
>   sr_probe()
>   --> get_capabilities()
>       --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
> 
> Because in the current kernel, dma-kmalloc will be created as long as
> CONFIG_ZONE_DMA is enabled. However, kdump kernel of x86_64 doesn't have
> managed pages on DMA zone since commit 6f599d84231f ("x86/kdump: Always
> reserve the low 1M when the crashkernel option is specified"). The failure
> can be always reproduced.
> 
> For now, let's mute the warning of allocation failure if requesting pages
> from DMA zone while no managed pages.
> 
> Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>


> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/page_alloc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7c7a0b5de2ff..843bc8e5550a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>   	va_list args;
>   	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
>   
> -	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
> +	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
> +		(gfp_mask & __GFP_DMA) && !has_managed_dma())
>   		return;
>   
>   	va_start(args, fmt);

