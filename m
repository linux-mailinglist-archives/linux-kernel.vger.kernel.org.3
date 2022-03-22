Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD54E4726
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiCVUEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiCVUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:03:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C9BCF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:02:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MJ3r1q020972;
        Tue, 22 Mar 2022 20:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o3sT2wAYugVVZLMZFoWqzPzj2wgcJkVbnTckjo+xtLY=;
 b=KiryJ8Cxca3Lgbx1VCnUZIxRRbVoNutb3v4FPOgDODUSu065ZlaS1jFvxaf2pB9GNTp3
 yW27jCU0oMhndp0GmzT1mEMLx0QCsCjRiG3oLo5avTf3zJQahPUOZVkxVit6H4gwCX6i
 sPsCZ+p69JTBMrPKBUHps10rrduir0GlMTmXE8sR7Zx7INnjT2+63NTQHtNP1SAcCHpT
 PF+88oup5x2FsXAGVEiPLfrnHcZuV+O3trS1DQijTq/InDXfkNJm5vL5IH/A8iFqwq4z
 Lhuii5ooQ1S6/r2iyzTVMIc0ecupb52OCaUaq2e572kdzGm3YlE/NVd6DjwL/Lw6eP/E zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y1ymd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 20:00:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MJuDrP062192;
        Tue, 22 Mar 2022 20:00:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by userp3020.oracle.com with ESMTP id 3exawht6qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 20:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYMwVmMUyjgEK77qp938tKeAg2uo25sdVLAWdfwgFHr9f41MaM77KdogR2jlXcJegy8vtD/JIeXOeFMVIHaWonAH/n+YpLfXGayVz3e2I1/YOuuore+GAh77IuRHiqh17dhYHzbsoFs6ZurlHhd6sI94vcizxYUHSLBeUXGE5wMrGYszTD9pu3Hfp422e4vWewdZ5gnaKrjRQpanHP0VEqMsoS5aMoypeCxyddC3AIKnycM9UPiob+g+BrRiHQCxmkUYxW+S6DCSulS/jz6Wfj+p9m+fQT6HdinW3rpTAl+u/VZGzMxemZAbRbsYFtmRleiGI0M7mSEJpmdbF52Mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3sT2wAYugVVZLMZFoWqzPzj2wgcJkVbnTckjo+xtLY=;
 b=Ziw3DkcKMdnrNzy+Y0W9mdTLx1mClAiYZQRxmwTabubs2W+XU8ByBwR4Jk8vIrpDR3llarpW948arMA8vxatTOfUqI6ahqlyNr7KG57oT9O4sGZySsqyAQq56DgnmM5xUzneHlH2IYncTk4fApGYPYdH7bj1eWdJ1y6xSAKEibivW0TTPcnv93X2N2nflgaLP4YdG9SuuzOv2XF6P7LpMk2NFuHnmRNk9DS/FuX/qMMQCaLHD1JWDYpf0ft/KAjxLbayrD+eEGdkmuzd5gXNRnBnP2/Twft9yrwIiXU1XCNNx4uepCwJFSeqyq8sSVt2uszLFeNBBzSpCyNEIyV3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3sT2wAYugVVZLMZFoWqzPzj2wgcJkVbnTckjo+xtLY=;
 b=f4u96vpJmxVZ8PeyUuFEjmKn4P+26WXL3bgVa6ZrTdc9Nzfs9G4kJdX9ih3R9Dff4zibvanAYMxlVQPMaJL8Y6EA7fUGYdDw8L2yLNt+gJojzyKNr0uh5cwfK9osW7JIbkQmTzu+zE0vAZhyc5nDJ8IyQUMBjnlkgqNN+5DK2Yo=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM6PR10MB2730.namprd10.prod.outlook.com (2603:10b6:5:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 20:00:51 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%9]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 20:00:51 +0000
Message-ID: <bf8a41ed-3d93-9f60-5e2d-780abc177325@oracle.com>
Date:   Tue, 22 Mar 2022 16:00:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] xen: fix is_xen_pmu()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20220322155001.21979-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220322155001.21979-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e44fd6-698c-4d94-be61-08da0c3eaa2b
X-MS-TrafficTypeDiagnostic: DM6PR10MB2730:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2730F9D7674E3E24750FC7388A179@DM6PR10MB2730.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHsfcAEOQ2bUaGMLoNSjvUg3BNiuSzLCFe1jNiiNYltYk1toItw0aEj3QY+5tl/wxdrOsMbaVw5xkAd6FvcVcabKY5UPeqHO4U1GyZu9u4V10wi2A1Mq1KNAoK/1eCVG5xt3NnX5SQDPEeavUObUoI38cZpXTEkxg2yVsR3lwtNEFG34JD7+cuZAibtUyR5At796tabsS54LG6r2CVIPAMKoi8dkaz1IKE3VRu7s7dagaBC4CFjOQgfFPJHM5I9qUNES8iWslSNzR4a+k5zlRQKsC2+cR1tm7UUasvViHhM/Wgl5I0P1ESpJZZjoMqznde3AUyZi/Z9YtXBmvIEWlgwF0+jH7SZhMJ0l+YZ2bWg6X8LCO0gfgK8zZvbLSTW4ajwlStVoO/UzOOlbTQqZGEbAk0DU5fHo9C8C3rol2ymVZZcGAWKBbKALltg+Ofy9LtQ5dUQYEjNF3KGef7X398Elr1wJtdK/0RsMgwDagbuAGSxbs6mZzeP6Q8TLfa9VD2GNnlyF/y2KUXdVBoESycY04bkSMnH8HIHC5rC4DkDft7ACGB6k9s3u4EsK3bvatk5LU2MlkY93SDDV7RO2UMbJ9JrAMcszxv4UD+XmciDQKw+L/2EeqRyVh7mOvRvYfGunXobudoE3nc9fTqpbynj1XTaOK/i5ayAzFvHtMO262LDK4dNGukOrCyfyiKqU5w2EopAbOkSXxRkdABvM3S/N0J3umUAXnhtlAx+V6AY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(2906002)(66476007)(66946007)(186003)(26005)(2616005)(5660300002)(8936002)(66556008)(7416002)(44832011)(38100700002)(83380400001)(86362001)(31696002)(316002)(31686004)(6486002)(54906003)(6666004)(36756003)(45080400002)(6512007)(6506007)(53546011)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlovNXRYUlYvMWtoVWg1dktqam5tZHY4ZkprbWNtQnJTUEVlSTY0RndyRFVn?=
 =?utf-8?B?SUtVckZLYXFHdDhQeGkrMFdJWE5UZS9IeXUweTdrSkNQUU93a21qN0tZU3hS?=
 =?utf-8?B?M2xvOWtsQ2tVc2I3WXVjekJVa0JwbkZWdVpOaFp2SWJXMVo5RktaczhVaVg4?=
 =?utf-8?B?T3NNVTNjZHJYR2w2MTFGbXdWMU5DZUl6cFBTRzA2VGhicmtnTXZZeGtqZ3F6?=
 =?utf-8?B?d2FNaFdLa3poVjlCVEFDZUFRWjduOTlRZlFzUnVPWUtRVHNlQ05UVnNnOUc1?=
 =?utf-8?B?ZUlnRnVxVys2blUxZnlMeEYrZ1lTdm1MWlVyTlprYlpzcTNKVVBnd3RoWHJN?=
 =?utf-8?B?d1FVTDM1c3ZJZVlEK0h1d3VaK2JwUE1WcENpbG9JMVRyQS9yUXpSSk0yMXVX?=
 =?utf-8?B?bkdIN1FLNE5uR0VMdDlqWVVuWGxWbzZhQnR0SEREQ1l5M0dWYklOUmZjSmhx?=
 =?utf-8?B?bUs2cnZ0cXB0SEJqb2dFbWZuUUhsUTZORDZMTGxKdllFTWZ3dW9WTTUvS0J1?=
 =?utf-8?B?YkcyV3ZSSVE2L1RBYkF0RTlLRVhOVURvNisxM2ljOERkK1VmZ2c0cVo3UlFi?=
 =?utf-8?B?Qy9temlFMndxaCtxLzVkUWNtWDNkeVNEdGY5SlFmNk5wK2RqaTBpdDIxbjl6?=
 =?utf-8?B?eVlTVTBlVVV4cExyVW96Ty8wVXZjTktMbUpmc3BiaWM3c0tINjBEcndkVVg3?=
 =?utf-8?B?dzMzUEpJV3VFOXhTbk11SlNZR3Fsbk5CWE5vQkZTbXQ5aHNMT2crSFFLeU5J?=
 =?utf-8?B?OUlQZjltRmVQVkk1ZnRhaEVvZ0JHQXBuSDFFZUxNaVlQV2dGN3RmSHJ4K0JB?=
 =?utf-8?B?SzRyOG9ZTm5ibXFtV1NtbEZtVk5YcUNHRXNkaDlLM0orMDU2YlorUDBJemxH?=
 =?utf-8?B?YlFCUUhpcWpndkdOcHlaRENSVThRaEZBKy8xZEEzaDY5RHlWTHJWSU8zVUJs?=
 =?utf-8?B?Z3JhTjNJVDkrRUNuZ0R2c0NFbkk2em1YV243eXcwbHJZemxaUXpOelJZNW01?=
 =?utf-8?B?ZGtlZzFPTXN1Yk01a0VqNnZ0aHUxQ1dBYk02YnRnTFVUMFRGSDM5UkV6Z01n?=
 =?utf-8?B?cFJkbWh1eFBPaXpscWx2dDdSdVNzOFNqWEYxZzN0UEhRQjZlS1g5eW1pNnJz?=
 =?utf-8?B?RXNzUitBQ3ZldDRBdVQvS2REeHpBRVZqSVpvUkZSUy9vdGQ2OGJzM1o0aGpj?=
 =?utf-8?B?Rksza0REb3FUZlpscW8wVW9abEZZdWtJMG5ld1VvQ242aVN5U09lY2szTWpC?=
 =?utf-8?B?WksvRW8vY0UvdTJDazdtWk9EKzhTRU5SdDFJZGFnWXNjWFNtZll0dVFuM1I3?=
 =?utf-8?B?SDlENFNsZ2JHY3dWUzYxb0hyVGt2UW1YRzJwNDM2MVUycmZzL2ZvWXhCOTUr?=
 =?utf-8?B?dGN3ZTBiRVdET012UjJ3bWkzTkFOMmEvZUovTzVGUzZVRmVWRXNJM2ZKMmt3?=
 =?utf-8?B?ZVJYaXB1SXZ5OG5wSFc0dGV4L2k2K2lzc0o1dENiODFjZlJLVU5pUElWQllv?=
 =?utf-8?B?bGFlMjJ1djMzQTRURU1XZzBrZXNnVTQ3YXptYitQMTBiTEYxaXlrcGNtSGQ2?=
 =?utf-8?B?RlRZdFBEMERjQnRqdEJ4UXZnc1gyQkRwQ1JmTWhQUzRoK01vVVdVWSt6a0d0?=
 =?utf-8?B?M3A5WlIvalVSRk8wb3kySHM1L0NYamNMdisrajcxeURnOWlkbjJzNHJERkNN?=
 =?utf-8?B?dk5tMU5abnI3RWVJS09iWTl5cDg2dGY4ODU0dWdMUnUzTGNzUExsRU1pYlF6?=
 =?utf-8?B?VFV3RnlxV1JmRGhVUXUwVG9HUDFFUURVdWpRU29BV1p5R0JVZURWT0x1UWJ2?=
 =?utf-8?B?MWtHcm5mMEdNdUFxdVk0SHpxU0JVUDNlbkxrMmc5RUZMZmxjZDhTcmszVG1M?=
 =?utf-8?B?eXZuUjNGeEdSRHM5NXloVFF3UUx3SldLWmZmMSs5Skk5cTRsL0I4VksxcUxV?=
 =?utf-8?B?d0dpS0VNMmZOdnJqUXBYWUlNcWFXQmxPQ08wQU04MmFuQmFTQU1MWHpsRGFU?=
 =?utf-8?B?Y1NIUndLWDdRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e44fd6-698c-4d94-be61-08da0c3eaa2b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 20:00:50.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59BcXluEotDzo3o4rssxOAdbHSJelYaIbypuy3wMRlELB6s6bUziJ2Q5akZVP+iW8Voe3+Q8Y+RFFF3eRpBBT08jZtWZ9KMCSyXaTJMQFYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2730
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220104
X-Proofpoint-GUID: iaul_O4QrRAbRmSyqt_mwBeOGpf-C1BU
X-Proofpoint-ORIG-GUID: iaul_O4QrRAbRmSyqt_mwBeOGpf-C1BU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/22 11:50 AM, Juergen Gross wrote:
> is_xen_pmu() is taking the cpu number as parameter, but it is not using
> it. Instead it just tests whether the Xen PMU initialization on the
> current cpu did succeed. As this test is done by checking a percpu
> pointer, preemption needs to be disabled in order to avoid switching
> the cpu while doing the test. While resuming from suspend() this seems
> not to be the case:
>
> [   88.082751] ACPI: PM: Low-level resume complete
> [   88.087933] ACPI: EC: EC started
> [   88.091464] ACPI: PM: Restoring platform NVS memory
> [   88.097166] xen_acpi_processor: Uploading Xen processor PM info
> [   88.103850] Enabling non-boot CPUs ...
> [   88.108128] installing Xen timer for CPU 1
> [   88.112763] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-sleep/7138
> [   88.122256] caller is is_xen_pmu+0x12/0x30
> [   88.126937] CPU: 0 PID: 7138 Comm: systemd-sleep Tainted: G        W         5.16.13-2.fc32.qubes.x86_64 #1
> [   88.137939] Hardware name: Star Labs StarBook/StarBook, BIOS 7.97 03/21/2022
> [   88.145930] Call Trace:
> [   88.148757]  <TASK>
> [   88.151193]  dump_stack_lvl+0x48/0x5e
> [   88.155381]  check_preemption_disabled+0xde/0xe0
> [   88.160641]  is_xen_pmu+0x12/0x30
> [   88.164441]  xen_smp_intr_init_pv+0x75/0x100


There is actually another PMU-related problem on restore which was caused (or, rather, highlighted) by ff083a2d972f56bebfd82409ca62e5dfce950961:


[  116.861637] ------------[ cut here ]------------
[  116.861651] WARNING: CPU: 1 PID: 31 at kernel/events/core.c:6614 perf_register_guest_info_callbacks+0x68/0x70
[  116.861673] Modules linked in:
[  116.861682] CPU: 1 PID: 31 Comm: xenwatch Not tainted 5.17.0-rc7ostr #103
[  116.861695] RIP: e030:perf_register_guest_info_callbacks+0x68/0x70
[  116.861706] Code: c7 c7 40 e1 86 82 e8 d7 e7 ff ff 48 8b 53 10 48 85 d2 74 14 48 c7 c6 f0 0a c0 81 48 c7 c7 30 e1 86 82 5b e9 ba e7 ff ff 5b c3 <0f> 0b c3 0f 1f 44 00 00 0f 1f 44 00 00 48 8b 05 54 fd 0b 02 48 39
[  116.861747] RSP: e02b:ffffc9004016fe18 EFLAGS: 00010286
[  116.861758] RAX: ffffffff82432850 RBX: 0000000000000003 RCX: ffff888079c00000
[  116.861768] RDX: ffff888079c00000 RSI: ffffc9004016fe30 RDI: ffffffff82432850
[  116.861778] RBP: 0000000000000000 R08: 0000160000000000 R09: ffffea00000ed340
[  116.861788] R10: 0000000000000758 R11: 0000000000000000 R12: ffff888003b4d000
[  116.861797] R13: 0000000000000003 R14: ffffffff8162cf10 R15: 0000000000000000
[  116.861819] FS:  0000000000000000(0000) GS:ffff888079c80000(0000) knlGS:0000000000000000
[  116.861830] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[  116.861839] CR2: 0000000000000000 CR3: 00000000062b6000 CR4: 0000000000040660
[  116.861853] Call Trace:
[  116.861861]  <TASK>
[  116.861866]  xen_pmu_init+0x187/0x280
[  116.861879]  xen_arch_resume+0x30/0x50
[  116.861888]  do_suspend.cold+0x132/0x147
[  116.861899]  shutdown_handler+0x12e/0x140
[  116.861910]  xenwatch_thread+0x94/0x180
[  116.861919]  ? finish_wait+0x80/0x80
[  116.861928]  kthread+0xe7/0x110
[  116.861938]  ? kthread_complete_and_exit+0x20/0x20
[  116.861948]  ret_from_fork+0x22/0x30
[  116.861959]  </TASK>
[  116.861964] ---[ end trace 0000000000000000 ]---


I was going to send a patch but I think yours can be slightly modified to take care of this problem as well.



> @@ -542,6 +539,7 @@ void xen_pmu_init(int cpu)
>   	per_cpu(xenpmu_shared, cpu).flags = 0;
>   
>   	if (cpu == 0) {


               if (!is_xen_pmu)


> +		is_xen_pmu = true;
>   		perf_register_guest_info_callbacks(&xen_guest_cbs);
>   		xen_pmu_arch_init();
>   	}
> @@ -572,4 +570,7 @@ void xen_pmu_finish(int cpu)
>   
>   	free_pages((unsigned long)per_cpu(xenpmu_shared, cpu).xenpmu_data, 0);
>   	per_cpu(xenpmu_shared, cpu).xenpmu_data = NULL;
> +
> +	if (cpu == 0)
> +		is_xen_pmu = false;


And drop this hunk.


-boris


