Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928DB4CB3D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiCCAWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiCCAWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:22:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A920113CA0C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:21:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222LxCpl028857;
        Thu, 3 Mar 2022 00:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NFC70BiF9kXdxPXApLojElkpvB7Fub06OPV7fhkw2GY=;
 b=K45CXekakFKaF401RaG4CbLTQpA60u6PELkQLEaW767pqGE40YDE6AbmPCQaEZwzVD/Z
 hrOuG1GeXWsD2Hngkv3AiGbxkESdLaW1gDdixQIW0vCE7wAplW3G7LU3p4G1B6W0Y3s0
 dbOWTnkQVuUX8FOs0q3lPM8H+EYgynidgicBneRlg0b/zjyYZKitUvLTSTWJRVFQc0vQ
 P3Z8wa7vexGOyGKt5ug/MocKI7hanZ9Zx72gzL55hQmD8NsLX7hmRJ9vIlCuot1IAh0e
 SxIMSvNYDSAMTUsK8rYJ8wyLtoue0Y0WCI9aH/fZ6w0xLXJZxL5WAd4jBd03TMcO0r9p NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14bye8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 00:20:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2230FK8p058469;
        Thu, 3 Mar 2022 00:20:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3efa8h1t10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 00:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATJ3mRXWSVjXLKWkiYE0eHj8cr5Mfn0UHMNuEDQHph/uhaxJnbh+LZaxt5OrsQOAh6iVU4htyU1103jmeWAKeKsfjb8Bn4ZUP7T4AiWbeihfKZJIoji1k2SVVZmiq4uvGtBIHr0iHeoQVR3lwx13nNMyQJGyqcQcjxQCjZj6LUxXDeNhJdvtCQwHUCD/hwuPMCp7oVkeF37tuVrYl5bNCc/sj9BwNCsIrz9RW6ZTyLdTFMiXaNk6IZT5O1oE/FlouvzrNeAnxiq68gz1dW3a0flQ04RcN4g4yS13kBJEbD/DTSa/6feYO5Bs9hV/iKZ6DUZ6CAISSZnvHCrYzJLQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFC70BiF9kXdxPXApLojElkpvB7Fub06OPV7fhkw2GY=;
 b=KmC7IVTs1y2qALM9OwiyU0q/qYdMtaiWCkM6VzA5BqIdC2+7RBm65/pVGp0hi/RM9Py2DZbhJTZClJraQTfVlzx7xmQnBWT8QXoA17daAJoBTzUdj0C2mfLztIf3sbXlH5zL6YrF7EocgDEcr0QX4Fg+d0N/9vCzdYmmGauQRsrH1Cd4B16+fSB9DCjELs0QsKofI5MQgBqvwfcNLKtvYTvDMRYENFr5hFFFXiaDD+3wmeF9TnGnIrnQba+Ut2TBrdxLHLritZtbhWdZER0sOK14Vy0duqYj2ZlwWrLfskGOelfIOSAdze9GbpebCx87MKdtEkhCeiT1BRExXdoKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFC70BiF9kXdxPXApLojElkpvB7Fub06OPV7fhkw2GY=;
 b=XgxL1hUkMet8KLa8aUaI8NFOoajUKw67wxe+XJrdk4YeCm0+b4C+1gdL6XJnB6bRS5iNDw5i3owM2RnvItEUdNgzB5QayPd6gPzhSLoF5EZwgR0OOV5U52BeqyOgpS4s+LL0Iu34soGWR1rHQGwoF3WDyc2ll95riiyoAUmWyf4=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BY5PR10MB4225.namprd10.prod.outlook.com (2603:10b6:a03:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 3 Mar
 2022 00:20:44 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 00:20:44 +0000
Message-ID: <bacae45c-9f8e-456b-1036-7f68e1e4374d@oracle.com>
Date:   Wed, 2 Mar 2022 19:20:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/2] xen: delay xen_hvm_init_time_ops() if kdump is
 boot on vcpu>=32
Content-Language: en-US
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, joe.jin@oracle.com
References: <20220302164032.14569-1-dongli.zhang@oracle.com>
 <20220302164032.14569-3-dongli.zhang@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220302164032.14569-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0047.prod.exchangelabs.com (2603:10b6:800::15) To
 BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d98bc3ed-e527-4c71-c59a-08d9fcaba80f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4225:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB42254103A80B75C67CFD4F028A049@BY5PR10MB4225.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TohYRNj8TreF5p3lAxguGZdkAVJPUL9RvZn6bYkBzZk86MgmrLF5CrpbmruTFx3Qn8SNXgIWa6bZR/8m2mDJMfjV+ArzqUhWZPhFNcu+Y3eF+dMHCHEEfTpUOnRwAegQVeVy6qL9FDCSnNwUl+H1961FdM8gSkTxw5f6Kw98hUywtjaE/IoPkHRtH4cg6xTz5pfjNkokG8MVrjERtaBVOuicHSK1npvfOHtgt72ywOP1pKWRNwQ+ooaLP4h+X77hUaHhaI0rDHzQAsZtnfYXCCgM20AN0FlQHjEDR1FS6E31dyfFRIMl6F6007uNbnyt3xvhR/lpYNkc7AvDcyAt2BvAZqNJf30F3QwwReb2qQ9eBjaEUozeFSCJPyD7RzQKWisqJpvhYFPpSgrvw5Y7QfuF0Wy3Tcg8Ge8FkKKALGuK/fyZiAw1Bm+6NMU3sKD3dky/ybTh8Fhm+gcCrIT/UOih93V21pejAdlSTT92UD7rewWYy4WC776MRMZ15J6ZqxfYGuGv6jbazO4KIlf46/pzsNLmp7e7OAhefQAs9CNneVjA6pufkhr36Y7cMKI9P0Iub+6F4GaB5imKgpO4vFK27uck8w132umhnrwDEhhzd5zBW/eud31//FvMjmNRhofpCPLBdT25c688/hCEMm4nDfp92WofBPvS/qZFDdKNH2tQQwGcx2nueR6PiFMlHYBA6PzDPxw8tz4FTvIHlRIWufIelSbaNS+hi5V1cYlNSPbLzKyDo9ftsKCZjQaJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(36756003)(66476007)(66556008)(31686004)(31696002)(53546011)(26005)(186003)(8676002)(508600001)(2616005)(6512007)(6506007)(86362001)(6486002)(38100700002)(316002)(83380400001)(66946007)(44832011)(8936002)(107886003)(2906002)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkE5UVRaQ0lqdjY4VVE0K3pVeXVtZDM3dkhWQ3VzR1E3cU9Xb1RCWHpaendn?=
 =?utf-8?B?cS9mYmtwdHFTSmtnK2NNbUN4ZzhEbDRtNGM3R1NrUWFPUUtRU2dhR3JSWTlL?=
 =?utf-8?B?Y2RrYTR5WURabm1wbVlVUGZteU1rQkxYQzBudGROdUJaU243L3BBUGhrQkdD?=
 =?utf-8?B?R0t0czIvaWV6VkVPZzBQVVZ6MkRQbVZhUTVHNU9lVlpNWHlnZ3FpV0wwR2RC?=
 =?utf-8?B?TzFTNXFQcU1BOHhZc0JRbHUyMjZkakg4a3g0anNHWGVxNDE2S01VS20yOUEy?=
 =?utf-8?B?VWh3UVo4R1BaeHdlSTJkR3dwV1pmb09CUHlEaFhlcmcxQjhtOHZLaytkYmVt?=
 =?utf-8?B?TTA3NEFCZHUvRWxtWW54MmRRa0FuYWZXTmdKVWJvZ3JmNkwxSjR2ZU1MQTc4?=
 =?utf-8?B?dmt2UlVKSUdBdENvdjJGZk5TeFFQWG16RGtqSEdPUmU0ZHhGSHd3STVrNXE2?=
 =?utf-8?B?TG1FeW93aUFuellHdE9IMk15SHVWY2k1Q3RYR3pMT2gxc3huNlVqK0JWZDNX?=
 =?utf-8?B?MHhqSmtEU1BCbVlXbithUVNCTjFJS1pFZHFLdnFVSm1oSXpUOFdLaVQ5RDl0?=
 =?utf-8?B?bFV0aVFpWFI1OG1Ka0VmVEpBSTFCaXZpcWEvcEI0OHlJblh1bHZpMzBsNXFQ?=
 =?utf-8?B?a1QrRnUzOWhJWUhCdmhvTkliZG0zU1dXVFhzVFVFWnhGZnhSNEp6TS9QQkdu?=
 =?utf-8?B?V1NxejhxYTA1ZC9SbDlITXV2MEluZVdnMjhod09YRnY3N3NZR3d0R3h3a1BG?=
 =?utf-8?B?S0pndTk2WmUraGdNaUJQY0QwTmMvUEJQUE1kek9jS2F2NEdlTEtlMkd3c2hr?=
 =?utf-8?B?V3B1VE42NjB3MStYT0h4dGlNMTdBaDVBdiszQ0pqR1lRdFliaFQ4TThXUTZB?=
 =?utf-8?B?R1BtZDlFY1R4SkRMQ1NQcTNRVHFuSnZLbC93REF3QWlvbExMUGZNWHk5WGlD?=
 =?utf-8?B?a3JKRHZRRXpBTUlaa014eTB0ZGVuc2x3TkRyYm9paXJ3c0VaTkpYTmZEbGh2?=
 =?utf-8?B?N2Q1bnpyWGRESnV0cFphb21zcTdJZnB6Y3FNd1IzMmM3Z3poaTAwRVVPWi9t?=
 =?utf-8?B?bDZXWkdKTGx3bjZpUlI4Q0pLNy9mVEY5c0VPcXpHRHRGMDczME9qcFRYdTJz?=
 =?utf-8?B?ZmlLMVB1cndGUGVmTjk1dDhvZVdsMU53dTA3bjBYOFFDYVJHSWhaYkZFcXVT?=
 =?utf-8?B?T2x3ZXU4dnBqSmE4MlZ2MzE3T2tPak1nc1JwbkFvWHBVeElUcWVLOEY2VzVS?=
 =?utf-8?B?V04ySWJodHFVQm5HU1AvWEZlblMzdzB6OFRxOHpjeWpaYzROZXB5cE04eTJz?=
 =?utf-8?B?cW92aW45Vnd4WVpCZUlEdytWY0ZmeGMwdXBua2Q5MjQzc3BKVXBwQ3d3c1Y1?=
 =?utf-8?B?cmJSdUNUR2w0ZHp6a2xxRVVJcm5YbFBkMkQxS1BFTG9NWXZNR0RqZUtNampz?=
 =?utf-8?B?Vk9OajhoSHNyb1ZqTzZFNThibksvSEFZMkZaWjB6bUZVL3RlcnhxdWpsTE9S?=
 =?utf-8?B?UkozcGhXY0crWWdHWmQ2Zy95S3pFNnN4eC9xcGxFRmJldU8rbDhtd0FQWGZj?=
 =?utf-8?B?UU5ySFRpQTJrQUluamN6bkRyc2tMNVFkVmZuYXh5OUlDaVJNbVpkVEhBMDRn?=
 =?utf-8?B?V09yT0llaTFVNXFRN1dYSWc2RDgyeCtIemVFYTZGa3AyWGllMVpheERqR0o5?=
 =?utf-8?B?T1dzRG83QkNXYTIrWklaQVRoVHRGRlJWNm5ySkh4QThFanZwNnhhaUE1bmd5?=
 =?utf-8?B?TSsvRCtBalVhdjBUK1R4Z3l5VkJ3dkJuYWJoajhyWThndDFqVVcvMjdtUkl6?=
 =?utf-8?B?MzF6cGEyc2pva0lpdzlPdHIvdHhLeldZU1I2SlgyZWg0bEpiYmIzdzZzSjN1?=
 =?utf-8?B?TXcwbW5xcW9ScldpTFdzbjBTMkxuRTk4RjVaZFFWcTRFVFlXa0NCSi9hQjBq?=
 =?utf-8?B?ckFxVHR1empkelBOMXFFbnNpcjhsZUZ3d0NHYW8xeGhYbTZvQmVSNVV2ZXhp?=
 =?utf-8?B?clUwYmlOTWFNajdPNnc4bmxGa3o0QmNLSmU1QXUrdVptd0g1eDhJbTBscHp5?=
 =?utf-8?B?YkNjNUxlUk40RkIvZlhUbVpYVWN5eVFXOXkrbFZZTWpxSFltYWRxSGpsUmRv?=
 =?utf-8?B?KzVxZDBpYU55cS83eE5IeVpmcWVqeWdmL2NJb2hzRE10RmptbVVOMi9weGRz?=
 =?utf-8?B?YkZaaysrblE1MHdnSnRXN1pNUFhidHNZbndhcDJZb3cvRFBNc0MycTdyNzhH?=
 =?utf-8?B?Z1crYnNJU3FkYzdZUWk2UDUxK2dRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98bc3ed-e527-4c71-c59a-08d9fcaba80f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 00:20:43.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWCjmova3d4zTuCrrEKG9VfCssDqhkx5x71FMioIHZ7XFIkbbTh4yFrpnuIfbLWAIwsae42I+G9YMOQctCniaHeGLkY+FDjuRgWxIfhCgY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4225
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030000
X-Proofpoint-GUID: AqtJ6_hgO6k6EjG8lvbXH9wk7Kf5d7O5
X-Proofpoint-ORIG-GUID: AqtJ6_hgO6k6EjG8lvbXH9wk7Kf5d7O5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/22 11:40 AM, Dongli Zhang wrote:
>   void __init xen_hvm_init_time_ops(void)
>   {
> +	static bool hvm_time_initialized;
> +
> +	if (hvm_time_initialized)
> +		return;
> +
>   	/*
>   	 * vector callback is needed otherwise we cannot receive interrupts
>   	 * on cpu > 0 and at this point we don't know how many cpus are
>   	 * available.
>   	 */
>   	if (!xen_have_vector_callback)
> -		return;
> +		goto exit;


Why not just return? Do we expect the value of xen_have_vector_callback to change?


-boris


>   
>   	if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
>   		pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Only MAX_VIRT_CPUS 'vcpu_info' are embedded inside 'shared_info'.
> +	 * The __this_cpu_read(xen_vcpu) is still NULL when Xen HVM guest
> +	 * boots on vcpu >= MAX_VIRT_CPUS (e.g., kexec), To access
> +	 * __this_cpu_read(xen_vcpu) via xen_clocksource_read() will panic.
> +	 *
> +	 * The xen_hvm_init_time_ops() should be called again later after
> +	 * __this_cpu_read(xen_vcpu) is available.
> +	 */
> +	if (!__this_cpu_read(xen_vcpu)) {
> +		pr_info("Delay xen_init_time_common() as kernel is running on vcpu=%d\n",
> +			xen_vcpu_nr(0));
>   		return;
>   	}
>   
> @@ -577,6 +597,9 @@ void __init xen_hvm_init_time_ops(void)
>   	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
>   
>   	x86_platform.set_wallclock = xen_set_wallclock;
> +
> +exit:
> +	hvm_time_initialized = true;
>   }
>   #endif
>   
