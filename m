Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9709B48C65C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbiALOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:46:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55480 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241952AbiALOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:46:03 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CDqXng017586;
        Wed, 12 Jan 2022 14:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uPIoM1TDvhxm8iIrEtNvHJssiFKfz3sOBVlWfrStySg=;
 b=YrHOoHBwxw+5JfTDVmBjEwHbiMWyC/IDcCqNWATd6jRs9xf28k+awVkfw8EGpgwWyL9J
 Fs8MiDuYNZKTB4dc5+GlooeUB1jwYhxQdyCVb7ghr0P3l3ZfU41TclmT6CN4b/nfmjeb
 Prm32LQQaNrcYs2XNSrJqk94oqrjxUjQwvnYGdejDgNiH8DJvjyY2IoQyc4/3x3TWtSm
 hfUCuiTR6D+R6FMwVFt0yfHT04AVzd8JUaiMb5H0oWd0mO5gYz7OshTckJJa5BYLGLr2
 Fa0ckqAf+xWtlHpKv2UryB+QBCTg9/k5rttr8j2kcFf0LZz+daZ8Bk0mj9mZhaNx4hgf lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbxqrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 14:45:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20CEeVuJ035760;
        Wed, 12 Jan 2022 14:45:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3df0nfj907-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 14:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRKMFacKifiItyyMZrPP2xSNhQIzctfBgFERGx2ijonexm4pHFm51wp+H8MpXpocJbO8Z7MquSVcTvUanMwvTiTqTMO/5Bj3kaRsvrAjH88A+0IpIdpsm4RQlj0HlusKTnBBpwykuh3h0Rj9uKE7/X2ZuM4i88nWJb+k9hbip3M4d8tXgXeF9DqSwmPZpEl6ytXOb5nZOsT0P8G4ivHgI8A6pjnwhjtllc5xSN9bPEoSv1uon/GxWkqkkjjEP8A0xTadX73+wNsBTaIJ28VPNZPFfrgcZ3T+MtH25FI2HdxbfBMYfVFOJPAS/yVBDbcJyrReIMGzhGGF7q/SHWwc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPIoM1TDvhxm8iIrEtNvHJssiFKfz3sOBVlWfrStySg=;
 b=Xovs1YGupgw7wcTHZzDsLQMOZYGoDI1btz6B5yRt0z3Rto6TiVpm9Xfj27KsCHnEd3k5KvH777b20m08pWPFH1XqTKNp3uFuqafpK4+Rt9Aq7hTDADr0V5OZMKN3wC7M5c2wK4RvGQrKSL3PwK6lZp4Df6aGyU/tSR0nAEaRF/elBdhKYIffDOzQarSUnKf1dUXh8I2/zGtjih4TsGtOcC6O+KhzZVNvs01hKk07yEUEO7Rd6ceE0Bp3aSkrwcYukC90rkmURFWNv/IM0pPVfLZAgonb63scnaC6mxlXXxRL/oyE2LoQx2iW2qk1sYCwvjBIM9afNv4NZ8UcX3P+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPIoM1TDvhxm8iIrEtNvHJssiFKfz3sOBVlWfrStySg=;
 b=J+OXDUHiBvIad0+b2oY10xtPD1QEPcGAYfpJJVDS09juJZiA6Hr5gxoEQSOktepSPcfejUVzMJPHPipYiOUftbYct+P1nAakQQoRHILhu9pTfA+qj9dzotWHBo96JYM6ibrcbrY4lGzepFPtJero+S0tJKFV0HpjQO2TvKFVcW8=
Received: from SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 by SN6PR10MB2830.namprd10.prod.outlook.com (2603:10b6:805:cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 14:45:18 +0000
Received: from SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::9531:f662:355:ace5]) by SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::9531:f662:355:ace5%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 14:45:18 +0000
Message-ID: <e48ac849-cc3d-3c0b-e159-7408af61eece@oracle.com>
Date:   Wed, 12 Jan 2022 08:45:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v19 11/13] arm64: kdump: reimplement crashkernel=X
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
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-12-thunder.leizhen@huawei.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20211228132612.1860-12-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0067.namprd05.prod.outlook.com
 (2603:10b6:803:41::44) To SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2832dc4b-b496-4d1b-ac17-08d9d5da26d2
X-MS-TrafficTypeDiagnostic: SN6PR10MB2830:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB28302458044D9BE3A0EEF4D887529@SN6PR10MB2830.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I44MjHJYD3W+7TSb3I1jnYtGZPiHZz2KQTSnCId/u3hIvFnDLuzmM4Ha1Tv5sq0ZT+PJaIxPkEXO3chQnqg/NwCH+9d6e9haIQZ9RI7jigtwzFZLLmA7kiUWLa1/9YtAM58ytIJf7NokFNPBaak9/Gt3E8Zk9TtgTBQ0marjPex8bR9W5HJgCNpHdrjXDI94sacYpo//i5ooU3wOFU3kRlcq/DOQCXFT294RhkRpaOx+Nu2c/5cjx7dn/H6UUB4QP7cQdfa/XH3bdxzU0uvAEN5i0NpwxKFseOyMk6NSKfNZIBPc65d4QncjJmjPpXNcuFGYMD5iX1+a3kpkt95WMcsQx22heZgsDdRMqknY4EySpUwDg0SJMWg1Jf+O3dyaDb0XBDxmWb6D3T8ng+3A3MwwjOtEq4yyDnyxVUMIFgYDmnRQgfxbQzwpIS/LQ0wn3hkK6gH2gVsMsop65kLoL0qTvOrCCuxvbjujS2harvslmP8WuKYrtnRqTT7iIgMX+cqv+BkHqREqv2Kd/TepCmyb76T8pKSLl8hmMaNykx/Lg++5+8Q37FUPqReUZbnSwEpdhsOWInYyPczerADhCtm36D1JOWO757x3MPfMRCuMGa2qi4kLQBpoqbNrlaOCidqkrGjmFR7BQbWoj4cgyzr86keSYSxje+qSFS8/yQELTngrUAFfp3nTaSMbsJGZVmUaU4UA1EOK3UxIN9q/DKLJ9GLN3GeWfasFwPjjdqbMYJJqr/M+/TTOfPpv6AoY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4665.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(66556008)(6506007)(2616005)(921005)(86362001)(26005)(107886003)(7416002)(66946007)(6486002)(4326008)(66476007)(6512007)(186003)(508600001)(44832011)(2906002)(316002)(31686004)(5660300002)(36756003)(8676002)(8936002)(110136005)(31696002)(54906003)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk1hRGcwRWFJNzBXSmgvMVBOSzBTZE9BMnAwT3luUWVCd05WaDV3VnFGMG16?=
 =?utf-8?B?OWREUm5aYVZBR0N4YlI0ZkJtaUVvTE9pV1pTOE0xM2R2V3Q4YjN4SVMxL1d1?=
 =?utf-8?B?K2JVa1ptVkFmelZVNmQwOWpSYUtVODFoa3R6RHVpa0NVNGRCU0xsT29qR1Ax?=
 =?utf-8?B?YnRqSGZYOTdwaTNManMrbkVTWHRlNUFJU2lXeUplNGNZWGZkb2xTR2ozc2hn?=
 =?utf-8?B?Zis4b0lYZi80SDltY0lSeFpTYUNkQmFSTkF0dTdDOGZyR3VHSkMxTTdSdU1m?=
 =?utf-8?B?QzN4d3JQV2ZYeVRYM28yRnBabFhhcnpQTlRsckRBdUFjMXY1cVRHZVJkL2hL?=
 =?utf-8?B?VFA4RFBUYjRoNW9JOEJhZEZLTWQ1OWp1bkxURnN2aW54VUdoMFc1UXZmUU1v?=
 =?utf-8?B?eXRRVGxpeWxsQUd1WjM4RXZBTk4rRzNHektxa1Y5QitEeTJvL1hoWXU2QWZL?=
 =?utf-8?B?blU1eWluTjVCaVVBSDYvOUNlajRtL2xhcVZqejBqU05SYm1ad0N5Q096ajZZ?=
 =?utf-8?B?STdiTFRqT2xzVmFwVjA5T3ZwTDBZYlVoNENacU5FQXdrNXpCMk1yU1V5QVRZ?=
 =?utf-8?B?elcrK2ZyRkxVbnlhY2NZOVYzc0FCTG1PMnZ2Ry9tRUNOWHVVcWhmY2g4QkFw?=
 =?utf-8?B?K2syTS9kMk8zeTNiZFhKT0w0T3RtVVZGL2krN2xGVXMzQ21aTEhyd1hKNXp0?=
 =?utf-8?B?dEZnanNtUXQ0ckltaHp3ejhhSWlidytocUs1aURYYm96YUs5SFBUZVNFTW5h?=
 =?utf-8?B?eE1SSkxyak5QVDhOSUxTb0dFMGlnL0dUektQT1dZVXcxSEw1OFBKY0RJWWJ3?=
 =?utf-8?B?dit3M09TWk9ld3JyNlVQc1dmMGxQQ3RQOFFOVldUTTBCbmYrNU8xRzhyNEpB?=
 =?utf-8?B?RzVCaHI4YUZMcDB6Vkg1WHdNdVBrTU03SzhGVHg4VHRSZUY4UjRLeGFlam9v?=
 =?utf-8?B?bkh4WnVOc25rMzVKeUtHZkFRejdmZk9pcDR1V3RENU9taWpyQW12aFJ5RmJt?=
 =?utf-8?B?VnFLREw5T09KYUlTVnhEYWdLWlFBTWhuQ3E2cXpFYlM0TUMyRWxLY1g3TlNN?=
 =?utf-8?B?alFRUWxYaGMrbzdKdDYrWWsyb2tYQTBvMUxtRjhxZ2g4OUJSck9UcUNKNkhx?=
 =?utf-8?B?R2p1YmltWjV3Q1lYTURXek0zbXkrMHQrRi9qSDVsbWlCRVNXV3VqeXgzeWpE?=
 =?utf-8?B?bjNwNUhNTTdIbkdUQ3d5VEM4N3hSQitod2hJU1ZFVEFGUE9qbUFkMy95UlF3?=
 =?utf-8?B?L3V1RUJ5Q0oxVlFmcy9uTm1HSXh1UEVNMy81Zk1VNE1nTGhYV1lyYVVQdXU3?=
 =?utf-8?B?UU5ZWVdXVS82emVYSFd4VmQ2V01pOVp2aXV6TUNxSjQrV3pMYWRYajJzMW5Z?=
 =?utf-8?B?YTBLUUVsU1BPMDQzWmJIK0VJdXpCbm5ja1prQXlJSHpBVW93dVE1MmE0enZH?=
 =?utf-8?B?RHRYNk0ranRYS0l4NWpOUDh4U3k0MlJ0K05FNjRRcG41a3VsT2pIZ3ZBVGdB?=
 =?utf-8?B?RGZxTm90elRGaW5pSUVBcTdKUUxCVzNFOS9xb0dmVVVsY2U2dVZjaEtQbVlO?=
 =?utf-8?B?OGF4R0Y5NEpNWEVneTViL1NNTTFKWjJtRHZRaEptbXdtM3ZJUnkwenZtakFX?=
 =?utf-8?B?NU92QjNuaXh1VnlEZlJ2ZHZJUmJoQkZuRFZFUVNvQWl0RHgvMGdwUUZaQVd4?=
 =?utf-8?B?dEpIb2thN0lkWGE3L1hKTzFLRXZ2YWtsZmJUYWlKbDNQbVQrRWZlRlJPOUNX?=
 =?utf-8?B?SGJsUXhKdjZ0NGZIamdnQ2ZwOEhjUEpJdGtFM1JvWHNWRWZhbzlGclF3OGpP?=
 =?utf-8?B?OVJFS2llR1JRSXFycXFpWDRjY0s2YVI0VkxQVm5HNDlCQmV3d2ZoSVUxUjd4?=
 =?utf-8?B?MjkzUE1IUVZ3YWxtWWl5czJLeVR5cjlzcEhGK0FsVW5GeForN0R4Qm9zQnBB?=
 =?utf-8?B?OG03M1RTaXZ4Y0dpS3dTWUtJVFF6dGpOOG45dURvUmxGVVIvRlNZcTRFZWtl?=
 =?utf-8?B?SGNsV0EyY0JGOVRVUHJDV1RtWmlLWm4zYVJUY3UzMXRjR1A0bkFCbHVucGpE?=
 =?utf-8?B?Tmh4M2FnWi8vN0ZrM0ZDTGxqQm5tRXJaUncyUWVTQmRjY3J6LzBQK2xWaThI?=
 =?utf-8?B?RlFYdVlQbXRnemp6alpRTVdqUjhac0x2SndBZFpmS1JiY3RSWnN4dzZ1bC9M?=
 =?utf-8?B?ODNxaFdiMWJobndKRU1XTk9DU2NxczYzb09SSlR2UlFDY2dXOS9QSC9ZUXYv?=
 =?utf-8?B?WGNySys5NjZ6QlRpSkw2TDd6d2VBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832dc4b-b496-4d1b-ac17-08d9d5da26d2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4665.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 14:45:18.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVJI/R7mjT+mPd5GUCqa+dwajjv5hL6itmz412x5Lhb0/nKwUDJikSNXUcoAoNjp29SUDs74h9v/5iNEbzf8xkBfurcxJZ6RpfUDkI06Rj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2830
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120096
X-Proofpoint-GUID: UQbxr_7ZZQ-bOK1gJa1tpyYibD27cPWU
X-Proofpoint-ORIG-GUID: UQbxr_7ZZQ-bOK1gJa1tpyYibD27cPWU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:26AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 
> To solve these issues, change the behavior of crashkernel=X and
> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
> in DMA zone, and fall back to high allocation if it fails.
> We can also use "crashkernel=X,high" to select a region above DMA zone,
> which also tries to allocate at least 256M in DMA zone automatically.
> "crashkernel=Y,low" can be used to allocate specified size low memory.
> 
> Another minor change, there may be two regions reserved for crash
> dump kernel, in order to distinct from the high region and make no
> effect to the use of existing kexec-tools, rename the low region as
> "Crash kernel (low)".
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   arch/arm64/kernel/machine_kexec.c      |  5 +++-
>   arch/arm64/kernel/machine_kexec_file.c | 12 ++++++--
>   arch/arm64/kernel/setup.c              | 13 +++++++-
>   arch/arm64/mm/init.c                   | 41 ++++++++++----------------
>   4 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 6fb31c117ebe08c..6665bf31f6b6a19 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -327,7 +327,10 @@ bool crash_is_nosave(unsigned long pfn)
>   
>   	/* in reserved memory? */
>   	addr = __pfn_to_phys(pfn);
> -	if ((addr < crashk_res.start) || (crashk_res.end < addr))
> +	if (((addr < crashk_res.start) || (crashk_res.end < addr)) && !crashk_low_res.end)
> +		return false;
> +
> +	if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
>   		return false;
>   
>   	if (!kexec_crash_image)
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 59c648d51848886..889951291cc0f9c 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -65,10 +65,18 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>   
>   	/* Exclude crashkernel region */
>   	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
> +
> +	if (crashk_low_res.end) {
> +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		if (ret)
> +			goto out;
> +	}
>   
> -	if (!ret)
> -		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>   
> +out:
>   	kfree(cmem);
>   	return ret;
>   }
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index be5f85b0a24de69..4bb2e55366be64d 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -248,7 +248,18 @@ static void __init request_standard_resources(void)
>   		    kernel_data.end <= res->end)
>   			request_resource(res, &kernel_data);
>   #ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		/*
> +		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
> +		 * region in /proc/iomem.
> +		 * In order to distinct from the high region and make no effect
> +		 * to the use of existing kexec-tools, rename the low region as
> +		 * "Crash kernel (low)".
> +		 */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +				crashk_low_res.end <= res->end) {
> +			crashk_low_res.name = "Crash kernel (low)";
> +			request_resource(res, &crashk_low_res);
> +		}
>   		if (crashk_res.end && crashk_res.start >= res->start &&
>   		    crashk_res.end <= res->end)
>   			request_resource(res, &crashk_res);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index be4595dc7459115..91b8038a1529068 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -74,41 +74,32 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>    */
>   static void __init reserve_crashkernel(void)
>   {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_size, crash_base, total_mem, low_size;

low_size needs to be initialized to -1.

If parse_crashkernel() succeeds, then an uninitialized low_size will be 
passed to reserve_crashkernel_mem().

> +	bool high = false;
>   	int ret;
>   
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> -
> -	crash_size = PAGE_ALIGN(crash_size);
> -
> -	/* User specifies base address explicitly. */
> -	if (crash_base)
> -		crash_max = crash_base + crash_size;
> +	total_mem = memblock_phys_mem_size();
>   
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> -	if (!crash_base) {
> -		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -			crash_size);
> -		return;
> +	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> +	if (ret != 0 || crash_size <= 0) {
> +		/* crashkernel=X,high and possible crashkernel=Y,low */
> +		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
> +		if (ret)
> +			return;
> +		high = true;
>   	}
>   
> -	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> -		crash_base, crash_base + crash_size, crash_size >> 20);
> +	ret = reserve_crashkernel_mem(total_mem, crash_size, crash_base, low_size, high);
> +	if (ret)
> +		return;
>   
>   	/*
>   	 * The crashkernel memory will be removed from the kernel linear
>   	 * map. Inform kmemleak so that it won't try to access it.
>   	 */
> -	kmemleak_ignore_phys(crash_base);
> -	crashk_res.start = crash_base;
> -	crashk_res.end = crash_base + crash_size - 1;
> +	kmemleak_ignore_phys(crashk_res.start);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
>   }
>   #else
>   static void __init reserve_crashkernel(void)

