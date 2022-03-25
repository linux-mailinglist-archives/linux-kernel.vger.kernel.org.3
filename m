Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE804E7CD0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiCYTk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiCYTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FDC24A8B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:19:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PHXncf031953;
        Fri, 25 Mar 2022 19:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fUFtmuUrmj0wdGvJ3Y9ntiZF6wI+h62FoYsP8MJZJew=;
 b=09BPjv8ugO+MVBy2VmUVIUy4njLnyPYmyQnsCKlvYB+wO9qcKhsVq4hT4OQVKbrm+t0E
 KVzeQEudvByhYIK8btfuGawxYpxzK1GkYrLJTdFB29HvkK9mk2+YKrzDcS2TeZvK1qc1
 yzETw/v+NK15/WURiy/svDYCOjd1qRA+2ql34dbizYuukXnK37fXpVTC7P0Teb8Yb/nN
 G8EKt2XJH5zLFN035bRE557GibWXgTu3olG8t101Mp4Rl+HP79xfRo8d0HWJ7zVZksiT
 Jkv8LrXlpfGT8V4iRRFArkMiaLwRGbjhBoJ+C2wP7u/vALKi7ntiJo9XOXY063Qsl7dC kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y287ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 19:19:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22PJHNwT125588;
        Fri, 25 Mar 2022 19:19:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3exawjj7t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 19:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHiBgC5MO2GYiYgYJhtVEUEuzlcMG6+rPStGp6kdi0TpvaxepbpFkLo5MEOecFbD0i0v0fEZ07EafqWdwqE6bqx+LGGIydOznZrfST4l6uB6fIjhSlky6/viCQFbrkDmOJIslMVhF4snTQyeaKAfzaGD72mk3jIRu1GEEp1kKe0gZu1xQVztXYe3LoDfdo/bgXj2VIPfSkgP4uRsLd60SIQgX+vcShJYn9E+GjIyWJ7Y/07+goVi6BxqdW4XBOLuRNsdbHY02w8j9rSRTf8oYvFy6LvL/lPLdCKCFM3HBf1Gcw/jJB/zOon6oow5Pe1Sma0w5M8Bk/vatrdoCpbPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUFtmuUrmj0wdGvJ3Y9ntiZF6wI+h62FoYsP8MJZJew=;
 b=cHiPaxKlDRNikzhRPyhO+xLkYdgz2wIdbgmrIW4Pu7vVrU4w0RmcUHjB0eonRjqNT7jeidntoBO4we9odRP4HIUqh3MtNs332+3NBScL30zuJUwcpLJz8pCqWdgvtH4eNWTEURz8g7j9AwvIjkHMVRc0urf2pzymJd59pjHSIfdl6oRxY97wtxpKLRo/yB78sotkNu+4Uv9iAcTU9uqWGdx+CWat3HCBIhIFm9Jp3HKrKrcBGDblBlA9r00himoSp84jrU6B+nkj8/kLaERNF826OMZUL9va/cJBzGOHgNlm0YqgWkSwpt2Hk+c9JjvD/3AO4I1H4Z7HNjP3CN1gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUFtmuUrmj0wdGvJ3Y9ntiZF6wI+h62FoYsP8MJZJew=;
 b=pLf8b6p5d9qrGLDuwemgcP5qh5hqsNfYpwQ9giaP10TXIRtp4cbh/nxXxZ5rBo0lVjOGwTXILoILjnnVk9/Bqfp49IF9gPIaXE3FQQ1QjoBNEzfSsQVNMxeOARG1mgOtlg4PnU0OjOVDPqwdp27usf30TLTwl6ynyjXZjIs5u3Y=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BN8PR10MB3473.namprd10.prod.outlook.com (2603:10b6:408:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 19:18:56 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%9]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 19:18:56 +0000
Message-ID: <bc63e39f-33dd-0633-f72d-df08ece23684@oracle.com>
Date:   Fri, 25 Mar 2022 15:18:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] xen: fix is_xen_pmu()
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
References: <20220325142002.31789-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220325142002.31789-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0060.namprd02.prod.outlook.com
 (2603:10b6:803:20::22) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1152988c-f18f-4c33-5273-08da0e944ea2
X-MS-TrafficTypeDiagnostic: BN8PR10MB3473:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB34737A203BFF58291FFCD6F88A1A9@BN8PR10MB3473.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jh3tVIYhZmk39I8lPra58KNcSIMLtMsvDQwHqMaITLieVPbfDD3Zo6QqIqW1BooUWI2J+GMFAya52R5Xyc8nrNRnL1KNZyQ2XR9/Z6BYh9AT0XdRJE6khB6eeeVsJBaYQGOQfWs2X2nRwGdhzZLcejGf2Uc0VPmL8mfAWVYr3tSCJDe53wNTOXrtDh4N33nXlbKF5SKEznfqQWoEJMFSy60h9gR2SkmDWY4fP7xZ1PGKlrYRNFzVcG93vH0Qqx3mWR+9Su+7uW7rb8WDR4jZFBFifGBPY5OUGDFhM80OaOFAHUeJADYPwPFc28Y1T2KYDHGnG38jxI3j5xblNtjlDV7YEOD+sYx+xncnLoq+7Gxq6rw/4TIM2k988i3AEHyz9GlROcDr+y6nNXcrhQDY1ijyB91wzgdGQC2TTOgtX69BI7w4gQQ5kiYj1vVWogoZzJ4znd8pdDtxMmIG41+EoCNttfnuF80NyIln5sTZS5vQsmcRdpnP6XS4RdT1JIPjXpj/16OEbDvH0HoSEQLcYm/ezZOsFm5GvekJDhUOcH/Bm6nHYHFPfSM0rrWvXJ+Nx1/ErbHcSr2BXZHVWta7dETl0wACuK4LVx2+ReiYIVXa+GVyi5wQ1kalOI7b/oyJ+w4s7wl6e2Nsk3PGQ1YwhvON4z74yNkIOHQct5/v84aCqz0/6dWVX8PkjedNamnLrjobjxZiHvq3Y0ViDkcCjcRWUpuoFCNPGivGD9TyfrVNmWfSWrZcZAxaMif4fuMO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66556008)(86362001)(8676002)(31696002)(44832011)(2906002)(6486002)(83380400001)(6512007)(508600001)(5660300002)(2616005)(6666004)(66574015)(66946007)(7416002)(4326008)(316002)(31686004)(36756003)(66476007)(53546011)(186003)(26005)(54906003)(6506007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmxTZ01JeDNrNlJWMkYvTlpKNnF4RWpZcWJaM1lrRElyWU5FTHpqeitHcUNj?=
 =?utf-8?B?cnlBcmFaUXpCOVlnbGV0M0t2WVJQd21ackthVDFiNG81K1RNc0lmKzRiemhp?=
 =?utf-8?B?b3JRT1oxakVsM0R4TWZNekNpN1FjYWdsOUU1UHNadFQ5WURSMG5jQjBJcS9U?=
 =?utf-8?B?TjdQVDA4WHJwbHVQWW4yandHVG5NeFB3VUM2M3djTHExalVjc0FPdzVJcGpH?=
 =?utf-8?B?SEVzM0VwclhvVzRIaFEvNFVqcC9GbHZPdHVVWThUNUhBRlk0cGgrc1M5cU5F?=
 =?utf-8?B?bzRkcVJ0QjdpZWxvUGZINHpzUWZ6R0R0QVN5ZnlLYWQvSVVzbHovQ2k3dldY?=
 =?utf-8?B?bFcvbUtHVW9oRG0wbDlOTFdoOWR5aVNuN2ZvMGZERFJ1ZHlZSnZIdGRtd0pU?=
 =?utf-8?B?QTFPZ2RVWmprNERGd25LV2ZJa3BZWGdFbFI0blhHWHhqYXpZWDFkQkZ0VkRx?=
 =?utf-8?B?OFZqUkFtOTlFeXhlZVBKL2dWSkZSN1ppdlppOWNqTjRBWEhvZ1ZMdHVxWnoz?=
 =?utf-8?B?NExUb2tweTBHRTZ1TFVrZ0lJTFhnRFpwRVVxSk9VZ0l0SU1pTG9MVFNSRkdX?=
 =?utf-8?B?RVFHMDRaTWRPZVp1UDVhOVF5NzRxMXFLVVpRdFpCeG9NRHJJU2ZvRWZpcFZu?=
 =?utf-8?B?L0gvNUp1dXZ4Tmc3OTlXTEhxZ2ZtMGlWcjl2ZHIrc3B5VFZXYlArSi93RmxV?=
 =?utf-8?B?ZWZzMVNrY0NPVUR5OGovdmNHdkVYYnR5bUFuMTdPMWYzR1d6M0cyK3FWZnRS?=
 =?utf-8?B?L2ZDeVltSk9NRjU2K2xFKzByZnd0RjQ5U2Vsd25LZHF4c2VQMmhYZ3pub0dr?=
 =?utf-8?B?cGVEQklrMFRHQk5sVWdFcXZhcExWb3Mrb2ozUDVVV2dKOXlBWGZQMlZ6Y3VL?=
 =?utf-8?B?aHVXRG9tQWErQXM0Skl4R2JHTnNxNU9JWDB4N3YyOFQrV3R6N200K2ZuMDRE?=
 =?utf-8?B?SmZtRVc5WnllZVBHK2xxSUF2VEI3UWlRVWxEVmJ6UlBrL1NGN2UwR2FXQWc3?=
 =?utf-8?B?djRlUUM1ZndCMTJ3bmp6RTRmd0x3UWZsbEZ3NmRkNkZsalI0MTJ0bHJNeGlY?=
 =?utf-8?B?VE9EdUtuZ3RhV2VncDcxS2l6bmVtcFVVL04wSkgvZ041TDczdmgxU1FVZnFO?=
 =?utf-8?B?VzRNbTRJTndyRGtEbUNVTTB4MjRla21iNW1Qay9pTU0yTHJiL1U2UG1LNk5S?=
 =?utf-8?B?eGVncVE2cDVHZDhtRWlLcG45TkhwaEt6bmtodWpDT2svNVN6bzhMU2owTC9T?=
 =?utf-8?B?eDdHZTFkVGF6b2M4RzVFcTIzYTZLRE03anpVek9WZHIvY0tWNFFLV2gvdTZk?=
 =?utf-8?B?RGRBRkRMcUF1VHk4NVYzSVlyWDdLSEY1UVlnYmR2VGFSUUVGMVdIQko4eHZz?=
 =?utf-8?B?S1dBK0FSVWk2OVFRZWFid3JEZThYNGNzSWpTcjdmMEQ1eFFRWTVUWDZHK2pZ?=
 =?utf-8?B?b3ovdStZVE1IdzNwMGhmNFEwbG0rTnFwMVl0Y0lXRkhnczJGZS93emdsNGZV?=
 =?utf-8?B?b2cyMVZRMmxHUE9QeHNIZ2ZxS1VOdW5zSjZYRXlqVlNnTWloYjlWdC9xSUlN?=
 =?utf-8?B?dlJqamNtVGUveDM0U1I5L3dtSXlPREFqRE5uY2h4eXRwTk5yaXQrS1lkSmpq?=
 =?utf-8?B?a29yMi9qZVh0Zi90bEEvNDdCa012dE5RdnhUdEFaYTI3UEtRVVNOMzBvZ1c0?=
 =?utf-8?B?WC9IMGhsUkV4TEtyckZ3ZmZNcFBSVVE4MU1CVlhtbzVxZkczUG1WWEFLSWY0?=
 =?utf-8?B?WDFiNlRhR3VHM1hONHY0K1NWNDVKbkg5M2hYb01OZzdyYlFtaEwzemNlaCtk?=
 =?utf-8?B?NFRxRDRuUFZsWWIrQkIzMVFSR3gxUW1ydTFaOU02RzV3ekw4Rkxtc0FEMzgv?=
 =?utf-8?B?K0Q3bU1iQ2w2eFpFc0ZsbVdHTCt1VVFjQkpvV1Y5MDdpZVZjd3NKekNrTE95?=
 =?utf-8?B?K1hScCtLMmI5WmFmNTNZNlJlRHorbFI2NGdEL3FZRnN0Zi8raXlXSk5vaDBs?=
 =?utf-8?B?V0Mrc21qUGFBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1152988c-f18f-4c33-5273-08da0e944ea2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 19:18:56.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lg5DXlRYHdM7/LLSHOqS2vlsgMFn4kxQ3uMPMKm3wDt1n5AFTxhV9Kow4wufriVRJa6tAN1W3LJd6PKJwefbbSl/PWHVUVGttXAMgtzdl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3473
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10297 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250106
X-Proofpoint-GUID: 6HFzpSig4kPhgDHJ4UKFromS15xH2F46
X-Proofpoint-ORIG-GUID: 6HFzpSig4kPhgDHJ4UKFromS15xH2F46
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/22 10:20 AM, Juergen Gross wrote:
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
>
> Fix that by replacing is_xen_pmu() by a simple boolean variable which
> reflects the Xen PMU initialization state on cpu 0.
>
> Modify xen_pmu_init() to return early in case it is being called for a
> cpu other than cpu 0 and the boolean variable not being set.
>
> Fixes: bf6dfb154d93 ("xen/PMU: PMU emulation code")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

