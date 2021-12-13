Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A545472F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbhLMOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:38:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44740 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236562AbhLMOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:38:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDD75cA018006;
        Mon, 13 Dec 2021 14:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rIHuIQR41jzq3s5IX0SgIseajoFWg/dB0lOHLjCGzJo=;
 b=L4CUbuYaCs8T2DJxRiCZ03r2TLuqkjeD98g35hBBL8WbRzuImebYlQ9X42D+buR13We7
 TcRlZGv18zh+ZGmXPHsR76c1UJc92vOPF1cKfJZtBi9rZTDXuhGzHw6Oe02mSuIasINX
 jcWqmbWUZrOqBAkK73MJbntCTpz1efOox3ftyXlSowbQkvacEe4v+hLMVtgtGhddvbrd
 1uNjPg0woC1u54lvLoNj7RjcCCAqx7mkEG7PtQazl+7idnLgJ6WuVw+qFl37JkiJhI7t
 Hsz2AnVHTnDYzEttyeMpywNjgDj/GAMs/n5/pjjeAl6Ms34MKnFLjRabxAKGgD17Wpyg LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrrpk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:37:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEaPi4118645;
        Mon, 13 Dec 2021 14:37:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3cvkt31e6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:37:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0upUCcq5ng9fpX8O8H59H4HkuDCFTTT43CSH646x7+IvEKU5Y5u8r/nNgmdTUTKVqBZcQWKR50fA2+vobxvHSCwtSH/uZyONykzE3aS9/TizLpJYtJhJ9NTPpNB5OEWVKI8cDqNpN1o5g75j3DeSmdzpuAyjhANdf9fnneZPiytObEXybnvzBlb1RhJHLSOzWRucI41I+h13hPg1IGIQLoC2TxOdQVBDpDOcw5linUMdBowbmGDQL7eqIx6yY82rTfBxiiLfaGbL2yHDLbOZPPPlLbhMMtQDbOb0hdwgkmk46J8gS56ZwfiOITIfrOTwCrfRl4vkq+KWDs9sjyKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIHuIQR41jzq3s5IX0SgIseajoFWg/dB0lOHLjCGzJo=;
 b=CRdtDoL/OpCCUexo9tH74l/zAg6GckWMwK218etdlSqKW5MwIAG3cDpT3LNgWhCV7OOnzN9RYfzgJuu0dFP/EBCYl8IowyrmYg2ZOPntm7IwLfJvQoVH8iAiCsPKdZkElIl1UISze2r4pSx5MiGx+NXLgE5ZnPLCD3r8NQSSlC5p2m6RsfNLAemKGWuLTkEFK/chCuH3SlQ+fXRt/hhSUvRjIkz0AE5a3b+/6/c+TtJcRM6w4IE/atErl5DrPsBF0X+T0tCxlO02NFeVeyjzGuHRdEitgIouNgCvyT1rltTCrSRJytfutyhXou0wf28EPSPqr9gDwTromPKfZHhT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIHuIQR41jzq3s5IX0SgIseajoFWg/dB0lOHLjCGzJo=;
 b=wpRkltUS7CM9ixsFXAi9LAPxlkvMoKHbdCqSSKe9BHLTjneOUMYUr22I/EqPVVi/VVF1/Fv1s5EWBsMI5ObFg903NVLlTJvIq5j7jBC9pGQx4I0zEN2FLmUnUD6hcdaIHKqzVtd6EzC+9Vt/X9fQKgBKN1vHeAk8cQm+sE5Ev70=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1454.namprd10.prod.outlook.com (2603:10b6:300:23::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Mon, 13 Dec
 2021 14:37:54 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:37:54 +0000
Message-ID: <5ef3ef54-33db-3cb2-4908-8bd1254749e3@oracle.com>
Date:   Mon, 13 Dec 2021 08:37:48 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 00/10] support reserving crashkernel above 4G on arm64
 kdump
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd8b810-635c-4590-2cac-08d9be46260c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1454:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14544C307C11263B61F31BE4C7749@MWHPR10MB1454.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrGpQGYV8SuIXxJpPzzVUQvhvb1OOblvpWYznInfMPJ5Eqw1OKJpXvCzGJhT1sgQ+V7vDxZSFpqGnP0ClsKpG1cKAzb/s+Jxw95M02JLrH6he+/Ml8GWRN1Y1kI9jgCzOoKIdChn2DpZl+d+4xipoRlfkuaE9YQN1RGhVFFOyyfPUvuTI5/x5lTi2+0zBJKWTo4JxxEUUOVr0N8cBgJXt9RZlXT+cNQhJff5kEjEc7E+kZu+8dyFTkRox3GLoue3AhGAXaHS0ym9ymWD3uWZuXUr8v7O1IFMY1KcW7Ka1w7hsH90hAdrc17+/CJX32Lu9JaQKosiZf2NEHtUhITrek3pVh2HEB1p5SI/7OjH7A0SSJQNve65Th/jC1W3Qvwc1RaizZRquELbOVd1vG8a+yBntefy3QB0daxdZlVYuru5I+bMm0HU/QViWYBJYbf6r6vtEaZYNdxJqC/VZHHNwvn1tvMkY/NmabgIdaqaZ6MD2GcbGRcmigVVMcglkmBd37SS9JAJME80Ru0OU47t6/VLJGj48zP6m+wjK8gImI7e8OD/gHLMBLs1wMl/6pm2gGm9Hc8GPVCYjVa8boLbe6o/dGJDb4J/TN66qIe2XSA59sYDk7P6+0u1nNy2RAIUIsoIraNGKn2AXuSrMSSdQwRllcfwNa7m27ttX/lOUW/PCDRm10bP4NCABmIJ1BpQKqeSfxRoAXxzFfNUJZwuFhYZVWxYUy3B7xMBGC4zeOpUg1dWCyKSudslZGQIEIbZWE4htXSNlrRI3QJBczrRe1jJBXcWMo4O+4y0V4yZdZ+aZpcERLG/sUhrrtz52M0+XuNhXFHi//r6hdmLfzk6LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(6486002)(83380400001)(921005)(7416002)(2616005)(6512007)(86362001)(31686004)(36756003)(6666004)(5660300002)(66476007)(8676002)(9686003)(66556008)(31696002)(66946007)(110136005)(186003)(508600001)(966005)(26005)(316002)(4326008)(2906002)(38100700002)(53546011)(6506007)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZOcUloWjV2azF6WnJvYnBkK3hodmpZVzMyQWtTdGJyVVpuQTBCRXNORm5y?=
 =?utf-8?B?TFg3Si8zaUpxLzJzaVFrUVVsNEdPMHJCZjF2cFR1NEs2QlRMcEtyK3RiU1JV?=
 =?utf-8?B?ZjBGMEUvTi9jQUlTUU16b3luNzZBQU1vbUxQbWRCSXhLZ2dUN0JwQ1J2Z1RP?=
 =?utf-8?B?NklpZkNGcTdOOWNtRWlFQitNc0xMVHoyLyt5N00wWUJjZGtJSmZFSnZuQ0Ns?=
 =?utf-8?B?Z3EwWWN6VlpYQWt6OTFWQ1BYY2JEUGU2ZlNvRXpDWDdPbm05RTVpRnpJM215?=
 =?utf-8?B?ekl5cjJ2VlpkQmpiTGlsYjJKbEJFc05SNUY5K1ZsVWk5UXBxdDVTdFJjamNr?=
 =?utf-8?B?TWwrSzU0bmVYN3NJSlAydFExTUM2enFtUk5Hc3hURCtsRDBLQ2pWM3o1VUwr?=
 =?utf-8?B?VmhYT0kzZElsYWdZSFFPTEkybU5kT1c0RjV5L3E1a1hGZ1o2ZjV3ZW1FNDcy?=
 =?utf-8?B?Z0docWpFdnMzZEVRY1RidlFpTHp6bmZUcG8zYnN1L0laTHJObUxGZkcwRFZ4?=
 =?utf-8?B?NitkeXRVelVIcUZrcXY4TFJvUjZCczcxVk10Sm9jd3dsWFZlcEhuejhQSWJ6?=
 =?utf-8?B?S2JWS2RIL1JCcWVxeW5Pc3VZSXJTK0NSc2pqU3QyTitpaUllMGM0WTlhb0pT?=
 =?utf-8?B?RDdCazhtVVJTc3JFVTdqQzlqQ29CbFpJdCtYd3RUbnVMNEEvMEVqbGZybk9s?=
 =?utf-8?B?c0NKQm5aR3lpYzlkZEV4MHNPemFiekR5RUNnbDNVUzBNNmpGOHlGN3dEZXVJ?=
 =?utf-8?B?Mld0ek4ycmJrTjJqWnA1elNnWFdkdmFSVngrbEJoWk85MlgxM2xlRFNBR3JJ?=
 =?utf-8?B?M05tVGpjbEU0NXRFcUhpUXZvNG4zT0ZwOHJLbnpUbnc1S0lhbVoxWTR0d1Ix?=
 =?utf-8?B?L3JaMlB0YlNVMk14NEdScFlMYWZ5Y0tyamFBUzZsRjhyZHQzMThjNlJXbTVu?=
 =?utf-8?B?Szh2N3pHcytQWXhRL0lmR2w2UHJOc21TamZ0N2JIYzdSWHVzWE0wMG9ITGRh?=
 =?utf-8?B?a3FsdXJxbnlHcGZQVmtEME04RmhLU0xiTytsTjUzQjM3MGJCR29GQkZ6VVhH?=
 =?utf-8?B?TURzdktlWUhKaVpFcmRqSDdkNlFKWkl2cGlUbXRRdm5ld29WYm9DUmRnSGF1?=
 =?utf-8?B?dFFxYVl3TllMdEZmMzFYWDBSc2tlTmc0VzZmQ1IyUDhmMmJwM2tjOUdGV0Nu?=
 =?utf-8?B?akVnR3o3aXljVmphdDJpa3RTY05ja2ltRU4ycW82M1Qxb2wrVG5xTW1CLyts?=
 =?utf-8?B?SXduc3MyL1BPQWlWYXQrMDhwYkhlellDU2VxWUJDOGMxdWs5SnhPZ2szNDc4?=
 =?utf-8?B?QUJjWDYwZ0lqNEdaQm45ZFhjU0xDYmdESlVYMk5KbWZ5Y2ovM2VRN0tpcnNO?=
 =?utf-8?B?ZjhpYnIwNlZJNkI3VHF1RVFqdHJMczBTTjRDVk0zNDJkVWNtSnYrWmtYNTNM?=
 =?utf-8?B?dDRvaE9idkFvRlNtL3BRMTVmQk1QTUN2ZTJ3ZGw5T2JWWWR4UHo4eGFiUUx5?=
 =?utf-8?B?dVBMNXA0ZkZ5ZGlpZ3k1U05LeGxjSmNLVUVLWTQ1OTZnY3IvYVZZRmtpN1VQ?=
 =?utf-8?B?dm9hWmdzUVhSSml0dFBDZk9uck1HTDZieW8yR0kxaE44QWxCWnhDamQ1U2s5?=
 =?utf-8?B?em5VMXZVR0MxU0p4SmwzNHZBOVp3eG96YnlxaFo5U3c5R2VVejgrTHlsUTRk?=
 =?utf-8?B?L3RUaCtVdFArVGpQNVFDRGJ6Sng5V1VNdm1TZlpXZEpNSUpKSDQ4aXlGZ1hW?=
 =?utf-8?B?cHVsMXpRQU5wQVFuN0ZZZFVKVzlkUkhGTDRQLzAxdlI4Q1NyejFmNnEyOEpU?=
 =?utf-8?B?NGlFeXlJOHlKLzF0NkV0aU1TTnBFOWJXdDB2M2dvcEd5RlVRQ2x2dkk1eXRH?=
 =?utf-8?B?WHQrNVV3cnZWSHBXUWpqOHRCbFBVUVRBYkdWWmMybjBXQUlwUGJ5eEc1WDdm?=
 =?utf-8?B?bGpaaEppbjBIVXltSE16Q1NscUEyQm9zRG5XQTc5VXVHZ1hMMUZwSHQzUU9J?=
 =?utf-8?B?NkdqWkdsbWZ2eGs2Y3hLUE95anJXMi80Ym05UjdQemNGZFQvV1FsSWVKa1Iw?=
 =?utf-8?B?K0xxYW9GNmg5SSt2WnlKSmNUS09kQXlVeW93MGNXOUR3ZCtkM1BtRVpCVDBV?=
 =?utf-8?B?NXFkK2xwVVZJSmVYYWlPT3ZKcUdpN28wMEI2MkJUODFXK01XSlV3akRUNkMz?=
 =?utf-8?B?UktqMXo4Wi9VT3JIN3ljNkJORHUzQmZMMDdxV1k5UnpxZ202SkpiYzMwUXlV?=
 =?utf-8?B?bEhSTEs2VVZTNEhmcGJoTVU2UWJBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd8b810-635c-4590-2cac-08d9be46260c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:37:54.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfex70MkTWkvP22QmwvLDHX4zxR+5OA2ASFBKEeoGxTuKHjy7fCVZcHJFWRHKjBVcLEkpmiRx1Mwp+Xp1w7m2+E7sZUToROYbPpKDrdXFxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1454
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130093
X-Proofpoint-ORIG-GUID: u_LoPFgEIYFBA_Au4e8TEig8NNhKPhQN
X-Proofpoint-GUID: u_LoPFgEIYFBA_Au4e8TEig8NNhKPhQN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in DMA zone and fall back to high
> allocation if it fails.
> 
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> specified size low memory.
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices. So there may be two regions reserved for
> crash dump kernel.
> In order to distinct from the high region and make no effect to the use
> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> and pass the low region by reusing DT property
> "linux,usable-memory-range". We made the low memory region as the last
> range of "linux,usable-memory-range" to keep compatibility with existing
> user-space and older kdump kernels.
> 
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
> 
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
> 
> This patchset contains the following 10 patches:
> 
> 0001-0004 are some x86 cleanups which prepares for making functionsreserve_crashkernel[_low]() generic.
> 0005 makes functions reserve_crashkernel[_low]() generic.
> 0006-0007 reimplements arm64 crashkernel=X.
> 0008-0009 adds memory for devices by DT property linux,usable-memory-range.
> 0010 updates the doc.
> 
> Changes since [v16]
> - Because no functional changes in this version, so add
>    "Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>" for patch 1-9
> - Add "Reviewed-by: Rob Herring <robh@kernel.org>" for patch 8
> - Update patch 9 based on the review comments of Rob Herring
> - As Catalin Marinas's suggestion, merge the implementation of
>    ARCH_WANT_RESERVE_CRASH_KERNEL into patch 5. Ensure that the
>    contents of X86 and ARM64 do not overlap, and reduce unnecessary
>    temporary differences.
> 
> Changes since [v15]
> -  Aggregate the processing of "linux,usable-memory-range" into one function.
>     Only patch 9-10 have been updated.
> 
> Changes since [v14]
> - Recovering the requirement that the CrashKernel memory regions on X86
>    only requires 1 MiB alignment.
> - Combine patches 5 and 6 in v14 into one. The compilation warning fixed
>    by patch 6 was introduced by patch 5 in v14.
> - As with crashk_res, crashk_low_res is also processed by
>    crash_exclude_mem_range() in patch 7.
> - Due to commit b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
>    has removed the architecture-specific code, extend the property "linux,usable-memory-range"
>    in the platform-agnostic FDT core code. See patch 9.
> - Discard the x86 description update in the document, because the description
>    has been updated by commit b1f4c363666c ("Documentation: kdump: update kdump guide").
> - Change "arm64" to "ARM64" in Doc.
> 
> 
> Changes since [v13]
> - Rebased on top of 5.11-rc5.
> - Introduce config CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL.
> Since reserve_crashkernel[_low]() implementations are quite similar on
> other architectures, so have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in
> arch/Kconfig and select this by X86 and ARM64.
> - Some minor cleanup.
> 
> Changes since [v12]
> - Rebased on top of 5.10-rc1.
> - Keep CRASH_ALIGN as 16M suggested by Dave.
> - Drop patch "kdump: add threshold for the required memory".
> - Add Tested-by from John.
> 
> Changes since [v11]
> - Rebased on top of 5.9-rc4.
> - Make the function reserve_crashkernel() of x86 generic.
> Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
> and arm64 use the generic version to reimplement crashkernel=X.
> 
> Changes since [v10]
> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
> 
> Changes since [v9]
> - Patch 1 add Acked-by from Dave.
> - Update patch 5 according to Dave's comments.
> - Update chosen schema.
> 
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.
> 
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
> 
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
> 
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
> [2]: https://github.com/robherring/dt-schema/pull/19
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> [v5]: https://lkml.org/lkml/2019/5/6/1360
> [v6]: https://lkml.org/lkml/2019/8/30/142
> [v7]: https://lkml.org/lkml/2019/12/23/411
> [v8]: https://lkml.org/lkml/2020/5/21/213
> [v9]: https://lkml.org/lkml/2020/6/28/73
> [v10]: https://lkml.org/lkml/2020/7/2/1443
> [v11]: https://lkml.org/lkml/2020/8/1/150
> [v12]: https://lkml.org/lkml/2020/9/7/1037
> [v13]: https://lkml.org/lkml/2020/10/31/34
> [v14]: https://lkml.org/lkml/2021/1/30/53
> [v15]: https://lkml.org/lkml/2021/10/19/1405
> [v16]: https://lkml.org/lkml/2021/11/23/435
> 
> 
> Chen Zhou (9):
>    x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
>    x86: kdump: make the lower bound of crash kernel reservation
>      consistent
>    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>      reserve_crashkernel()
>    x86: kdump: move xen_pv_domain() check and insert_resource() to
>      setup_arch()
>    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>    arm64: kdump: introduce some macros for crash kernel reservation
>    arm64: kdump: reimplement crashkernel=X
>    of: fdt: Add memory for devices by DT property
>      "linux,usable-memory-range"
>    kdump: update Documentation about crashkernel
> 
> Zhen Lei (1):
>    of: fdt: Aggregate the processing of "linux,usable-memory-range"
> 
>   Documentation/admin-guide/kdump/kdump.rst     |  11 +-
>   .../admin-guide/kernel-parameters.txt         |  11 +-
>   arch/Kconfig                                  |   3 +
>   arch/arm64/Kconfig                            |   1 +
>   arch/arm64/include/asm/kexec.h                |  10 ++
>   arch/arm64/kernel/machine_kexec_file.c        |  12 +-
>   arch/arm64/kernel/setup.c                     |  13 +-
>   arch/arm64/mm/init.c                          |  59 ++-----
>   arch/x86/Kconfig                              |   2 +
>   arch/x86/include/asm/elf.h                    |   3 +
>   arch/x86/include/asm/kexec.h                  |  31 +++-
>   arch/x86/kernel/setup.c                       | 163 ++----------------
>   drivers/of/fdt.c                              |  42 +++--
>   include/linux/crash_core.h                    |   3 +
>   include/linux/kexec.h                         |   2 -
>   kernel/crash_core.c                           | 156 +++++++++++++++++
>   kernel/kexec_core.c                           |  17 --
>   17 files changed, 301 insertions(+), 238 deletions(-)
> 


Hello ,

After 2 years, and 17 versions, can we now get this series promoted into 
a build ?


Thank you,

JD
