Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF18346974F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbhLFNoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:44:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64592 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244619AbhLFNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:44:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6D40pI006632;
        Mon, 6 Dec 2021 13:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FTSWx2zpYLbbOuaN9PiB/j55Kh0iAWfbOK3m5GF2lPY=;
 b=cFq0LNqvpJzRYah7P4URkNIAL+F3GPgbBGJvdAJ0UGsMBS5VK/1wk6esHL4TtEbFddiD
 A+JwM95uGgPabVWA6fTYBa/JI8xyKhBoNDgxAmhrclp4HwZ5QBuLmqiiGpQgQN5qUq90
 UYctfyAwRZndKfULMbM4ea07MZye9dLZ4k+XYpSKBYo+VHchE3YvjHPcVr+5ys0hJOBc
 J0cHwtx0vYX0+DiXVnAUh7Er5hfMETCn4svi8J2xU7JKqsu43hGzsr5cFSV9Jvh8UuCv
 iMw95KXNdXAxGF8E4ORsgiuPuXA8bvvsWEk72RK/3DDzj95SoW2Z8Nr+OrlgEKlfi1jo 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72a1pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:40:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Da3pJ089851;
        Mon, 6 Dec 2021 13:40:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 3cr053e60h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC6kIJOjoUzzLOvT73dD+gGpwmn8EPUA1kAIbjgbv70YiQvkhMTC7IzTooMZ/eT75RF01lBewR1f3kG/k/v7/YC3e3uvia6HsXpyJSqL5lLN8AKn46o44L6YTV5TpgawQm4/0Ha5O3LdnQmZKP0zGvUSPsSc7hC8kCRi1mnb7lj0smDc2qoxzTkqNwvCglxkZXeI8SarDTy7XDOZd1TPrV/tJR/zVSCinjNT7pdfiHKbb7yD5PJONoZ4WnJPULL2AOvCjn60m8HExtLJpS4C0It4D5VXlyfC2Qffj1dx2ZdzF2HYBpokUnZBzh1WlKtM5RLl4h494ougjMk5sbDkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTSWx2zpYLbbOuaN9PiB/j55Kh0iAWfbOK3m5GF2lPY=;
 b=EIIg6if26uQ2+5Kw5v/KM7l+rvI5grtQGaSbIv+WYNaALJtKfZvumbCW7Q/10UTiUUPA4uAoAggiEFGau3cdkH1HORj7doApyy5pmLji/+Q6POp8icChc75oUhD9T00clLy4c61Dh/tw7hgAG1QoKRDEgPmqVgwPSwRE5htokLKHbH8Z1pd0K/foLfOEoMupgh+dvvzpkUTKuTxigkTdAM2ajhvx66eDoBGSEoKJZ2oFedooIevXeiQP6fH0r2Luw34ja147sMwb20tdjBo9VScaAs/PUttZthNO+WNNTUPkPDA8Ph+WI6GlVIM+z7CwS3wIE1p7EM66K3rC+5RCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTSWx2zpYLbbOuaN9PiB/j55Kh0iAWfbOK3m5GF2lPY=;
 b=Db2nm9wtiLU41o46JP4TC6M3SLK66jCv8rs8MVVXmcuzMpdiQPlbnUzOgEILckPqzV8vMvBet0tVsOBJ3yVwO9jijeZreXwyewzF6Ioy+zTeC8c5ssAqn0gGGCn5wMiKjnEJz2K3pz6QOIOYXmjayrkZxzf2CsAcNHbrxxZEBqU=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL0PR10MB2978.namprd10.prod.outlook.com (2603:10b6:208:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 13:40:02 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 13:40:02 +0000
Message-ID: <5a687e9c-f375-d9cc-f781-37cd5bedacb9@oracle.com>
Date:   Mon, 6 Dec 2021 08:39:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be
 brought up again.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, linux-kernel@vger.kernel.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20211122154714.xaoxok3fpk5bgznz@linutronix.de>
 <87y25djhaj.ffs@tglx> <4d04ea65-ea74-dcfd-5b0e-984b44f91961@oracle.com>
 <20211206112555.ubscfwwxnn5bnyte@linutronix.de>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20211206112555.ubscfwwxnn5bnyte@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:805:106::36) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.106.57] (138.3.200.57) by SN6PR2101CA0026.namprd21.prod.outlook.com (2603:10b6:805:106::36) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 13:39:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320bff4b-b5fe-4841-b299-08d9b8bde7bc
X-MS-TrafficTypeDiagnostic: BL0PR10MB2978:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2978A395237B15D45F7E631B8A6D9@BL0PR10MB2978.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iz8VjNkWoZlUUu5M2gkdJJUMpnyt48j6FMNskSRzgEBIwJCsjtAwc3F1bKBuUXFpWNBR1nCwIQnnlmdcLPsrfyWHLYdBcuCwYbQ5xy6D7ep1p6zmv8qeMn6IXxdwhZWsK538YFix6lB7GpKZ8N2FiVUBlptCrkKKByhgVkoRmv7UJS+BCUzF0wPLkwch+3v28+cF3y0dZDzhQ2faD1SpNGvikXCYVJgj8EJIf62qcJJbrCwkHWDq7I1YGmn3yzzxkjAh6td7M1p3bclSL9S4NE8x4tCu/yoZ0hWONN0/rbA+PgRp1WPWkNpkEUWwXhIzalhigaWzYEp701eNqUuMAgy9SWObCxqeYKBT3sSJ1C42G8BW0gkehI27V2PkEWXFwqqJ5Lwq05TjUwkOPhwu4CNp1+4dF0/JSif6hDLkvyMZBA+2DwFQepBNMvz9uPr2Nt0EyfOk50Y1RREYtnT6LG6ioLqsSyt0yBFbgnhmzbLcvUjbBdJF0oDgaYUCIBQaC6ZJEfucnkWIvpG4WGOfv2YP3oetX0xQ4MgO940QoZ2dZEQy/5uF+GveUrCx5Br8K7o3aIL1PqRn+CQVjpTel4Qym4ck4fnJ3mIMMokjv0yfex9LMeif6x6CObD3uZ8ufcntT81Wg5nUjGExD2Ve64o+Zk3ZcWdsL+CfNSHGU0UH0AaSU173zQchIHim3CNSgT6daI7CRD8v7BqGK+P0td3LkOEvLByGX05KJv93ZGV3lfrK2EoHQ0f5sxn9l1xi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(8676002)(508600001)(8936002)(4001150100001)(66946007)(38100700002)(66476007)(66556008)(6666004)(956004)(53546011)(44832011)(26005)(2616005)(186003)(36756003)(2906002)(6486002)(86362001)(5660300002)(31686004)(7416002)(316002)(54906003)(4326008)(31696002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUd4NXJMV1diY0o3aDdFMGlqeTBaUktsRjk3Y2FyNXJ5U0lEV09MTzNiU0hq?=
 =?utf-8?B?UjZHNk1xNSt4MjZCNXVFYU02NmE0VGJpOTZqUVA2Wlg2OXM1cmFTQ09Nd1pz?=
 =?utf-8?B?cjlmc0FBdUpKQlRHNmtSR2RvL0FDb0ZFYnU5TkhmWE9TaVhwTzRsZVhwZDll?=
 =?utf-8?B?VlRXSVdGaFlaaGFsaUVodENHUmp5VGlsblk3TG45VlFnUkErK1pXS3kvczJs?=
 =?utf-8?B?MlphZ1Y3VE1BSGxQZFpqQVZqaWZBdHFIS3ZYMkRCTE9UZVJkVmRyQnJjdHFq?=
 =?utf-8?B?QThyTUdtQzNjV2VzY1AxRktCNG9KTlpzdnlBR291ZThDYlhVSHVUQ0IveVZi?=
 =?utf-8?B?bE11dHZWVlkzMlRKdldTUjE2WXhZdFhkRE05R2JvM3BraWlpcXRwUkt6NnZL?=
 =?utf-8?B?bmZXaG8vQ2YyV28zbStWdnhaeEpCS01lMW9Pdkxvb2hBUldabmpBL1Vuelg2?=
 =?utf-8?B?V0R0NDVjaEIraHBjT3V3SW1YaTh4THhTYnpUL3RvY1lZM3FsSXNaMFd1SjNt?=
 =?utf-8?B?c2poZzJJb0tFT0locnNYZi82QmhjcU5zRS9aajZYak5QZzJCM3ZpVUNTS3lO?=
 =?utf-8?B?VlNoQ1lrUjhpU2tsb3dHU25LZUM2NkRlak84RVdFeUV3WUhldGI4UURvYkh3?=
 =?utf-8?B?T3gzZUZxNmJ1a2VwOHN4eFFJMW9iUnVyQ2tUeGwzQ1BLQXRjS0tOOUxuYURF?=
 =?utf-8?B?UGhha2l6bFR1UDNSOVJnZ2lQNlVDcUNYN0RvR2xyOEcyY24vdTJOdGl5dk5L?=
 =?utf-8?B?ampONjk1WXRWZi9mNlFmdnRVVk93VWdtSk9aMUhmc3g4Y2paZ1E4d0txRHdE?=
 =?utf-8?B?aEVVdjZRSDV4QXJhanNDN2kvZjExK05oRkJ6M1FicXF6VEFNdlN2SjNzNFhh?=
 =?utf-8?B?ZURXQzhPV0dPWFh0a3Vudy9pbzdmUUNPZGF1bXpPSi9zUFFFVzJNZ3lnbGp0?=
 =?utf-8?B?Q3FoMldHc2ovWWJRNjFOY29SZU13bHB1SzhLTmhOZUt6SjJRUHlWc3hydnRE?=
 =?utf-8?B?TXdLWjJBNExxVUhQMkhneHBQdnB3SzkvQXRsQ2IwcXBtclByWTlveVZIUWhw?=
 =?utf-8?B?ZzNMMFZMWDlTTkI4cTVFLzlPSVZkdThnd0hPdWtYdmtYb0dTR3hra2hOekFJ?=
 =?utf-8?B?Q2pGS0dJb3M2dkdXdmhUczJsWnBTMWd4cksvK2ZwbGUrME1CMTQ2bjFUNklv?=
 =?utf-8?B?UytiTURodE9iU2FFWWkxUlJZS1VmVithbVhJUGZHMFRCeGwveXRXbjZnSUZu?=
 =?utf-8?B?L0Zzdk5PRWtIUy95eEtoSlFuQmJ0bHFBUTkxcWswM21ER0ljODFrZnZFaVhy?=
 =?utf-8?B?a2syanErdnFZRFNVVFlBY05XRy9CSWFxRkcrbWZ3M2dxWUNuaXBlZGVVVnp3?=
 =?utf-8?B?ME52M1RLYmV0RzcxWWgyZU5raXpSYlZkdFBLeFJhNytNc0hxVVoyc092dndM?=
 =?utf-8?B?LzNuenNHRUc5RHRZTC9jSUh2YlN1Sm52eWxRL09DcHcrcUlTSkVPSEpuNFNt?=
 =?utf-8?B?ellZOWM4S3VSaURkSzFyYkNpQWwzbWNpRVFUV3B3eHRWSWI4Rmg3c0JtQ1N3?=
 =?utf-8?B?ZlJRTU9OQ3VLdksvUU1Cb3FTRC9uUVhqU2tSUDBzQnVKd0ltZWdHYi9GRTlp?=
 =?utf-8?B?TTFEOGUrTXhmWXByUVloN0VCM1c4SlpqYk9LY3BmNVdsZzVQek4yYXpTTEEy?=
 =?utf-8?B?aTlCWG1HZ0VVQmhaaXc2aCtVQUJZdnJMcHpWOWN5c1JFMTUxZUtiZGRmUCtN?=
 =?utf-8?B?Njl4bjNZSGdhOEs0K0I3dEd6N1k5L2ZkaGZtVDZHQjJGK0pYRHRzbE5IRXhP?=
 =?utf-8?B?cVdlb2hiaUlPQUhpY2hzOWMwWkhZQjVxY09mYXFWdnBDTXp4TDUyOTVzTjZn?=
 =?utf-8?B?ZWlZMzBGTHpRZ3JLR3ZVdUgzRWZqMEpJQnYrdmwwSWRPekVRYzBoS0lxVGJp?=
 =?utf-8?B?dHdwZmdBa0JNNHRDN29ERmJFczRnb2ZUK1phVnJjUUFCZmJjaC95Q0pLODB3?=
 =?utf-8?B?TjNoeEQrY3dWMVBMYkJtSDdCc3ZqUS93eE1JK1pFU2xEWG1VQzZ2VWVBV0RJ?=
 =?utf-8?B?SFlzVTdzY1hoVHpVSU1YK3J1bGlucWVVZ1U3TjdzWkVCcHBaWGp6WldQeHg3?=
 =?utf-8?B?b1hqRERXb0N4Ujl2amFZbUE2U2ZrQ1hvWlBnc2MwdHFRQUk0VGFEdmVQYmlY?=
 =?utf-8?B?NVFQZzF5NnRpSC92UEp6dmowcDFZR1BFbGdPWWN1RStrZllxOTZPU2JJKzMr?=
 =?utf-8?Q?uzE60qXnbkZf9r5cPVaKChwVvYh2ztyL/AR5PKKl7w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320bff4b-b5fe-4841-b299-08d9b8bde7bc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:40:02.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkjaqUObnPSxKDefcTwHWi/5Ke+PRss1uc4DUIp+cMtJ+q+vBI+/u1GsO8yKa6wye1IkhhJ+O54oq400EFJSxoAhEBA++kdyEw4bD9GAfRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2978
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060084
X-Proofpoint-ORIG-GUID: 3geAe5Ak03wp3KAmWXAZp0du-t9lWZEL
X-Proofpoint-GUID: 3geAe5Ak03wp3KAmWXAZp0du-t9lWZEL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/21 6:25 AM, Sebastian Andrzej Siewior wrote:
> On 2021-11-24 21:17:34 [-0500], Boris Ostrovsky wrote:
>> On 11/24/21 5:54 PM, Thomas Gleixner wrote:
>>> Any comment from XEN folks?
>>
>> If memory allocation in cpu_initialize_context() fails we will not be
>> able to bring up the VCPU because xen_cpu_initialized_map bit at the
>> top of that routine will already have been set. We will BUG in
>> xen_pv_cpu_up() on second (presumably successful) attempt because
>> nothing for that VCPU would be initialized. This can in principle be
>> fixed by moving allocation to the top of the routine and freeing
>> context if the bit in the bitmap is already set.
>>
>>
>> Having said that, allocation really should not fail: for PV guests we
>> first bring max number of VCPUs up and then offline them down to
>> however many need to run. I think if we fail allocation during boot we
>> are going to have a really bad day anyway.
>>
> So can we keep the patch as-is or are some changes needed?


I think for the sake of completeness we could add


diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 6a8f3b53ab83..86368fcef466 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -277,8 +277,11 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
                 return 0;

         ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
-       if (ctxt == NULL)
+       if (ctxt == NULL) {
+               cpumask_clear_cpu(cpu, xen_cpu_initialized_map);
+               cpumask_clear_cpu(cpu, cpu_callout_mask);
                 return -ENOMEM;
+       }

         gdt = get_cpu_gdt_rw(cpu);


-boris

