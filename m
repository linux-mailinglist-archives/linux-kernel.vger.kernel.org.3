Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43A472F53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhLMO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:29:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35150 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239183AbhLMO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:29:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBJNtx006749;
        Mon, 13 Dec 2021 14:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uHr/SchHsPKItD3cRAgdZsGRPrgJrBOvz/Jn7e6YrRM=;
 b=tox3uMzd1pUKvSssLPz4H6y2zN04gMlHjos5YH+VBzVeGR45qKqoypQx2xr3fPPJO5NQ
 r35PVh5E97EZXPZeFs3kovEnDFmjjuMghSvvq9NnW1fvIXkgu3cjsC+3lKj7PQFd8NVG
 xYVx49ZICRsOI+dLts+JiYedMtHYCfR9cxGil6aVakQ+sYQjWIEYKrIsWYIIPPbBkdNK
 euoBLrhon8q7UKzrzQRqQauxoKeX4tZb32X8ba/cyb2AuxvlMYFj2VI/LBOWaL6zneZA
 usvd8xRv3ZhnIOCyB9ZFR69xpOqw4Eg7jjvNrrk9EbZ3+rBccjjDPNYDela9L45W0HpN iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u0d1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:29:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEQQCB073251;
        Mon, 13 Dec 2021 14:29:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3cvkt311jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isTE5JaQ+3N2hr1g4U0iEbvytj0S0A3lu//grPLtRc9TGw55OxA+edy9sdR2sp+NK4F+7C/8/MVIsJgsl48sXWS6UpLfV0DSUzpOQynl8XY9iwYe9HZqAAOsO/DJbuGIKOzFfaG+HxptWyDvsAUgYqM9TYM8Z/X/8iK+D7PB9ipY97B4KZR4etMS6BLmrEHXf2+M8AHEdcy4VZd9v3q6d0YIGZt6K1UKLgW4Kp6BhU4+gteFRGOSIa/DGjDB0fT/W72qbneNNz1RjmNNV4JcrsibXx+cnU/Cq1+eoZhKUPec7v5SAnFjn21/OhqBXxgX3QUfaWK2oNHwy04/1uiS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHr/SchHsPKItD3cRAgdZsGRPrgJrBOvz/Jn7e6YrRM=;
 b=SpSNBqrIS/5FjJpQJaW/3rxxWi1L3qXksT1zietXZBinrVjkQYASNQByaBlmZAlaF0O/xcCWG6ADAo0FEIO7rFX4r8YFW7PBP/jTr31HzdFCXz1MaDfpgpUAMTUhFgnGcsUcG1YRDAzjnSsEK1lhtMCQYZ4v9S3rEflz+yvVmXn1rk4ZTxoZsYJGifpkfBXSZTTV6fdyAAU+LO5A9mK1ZqhVi7XzAGVO81C6Pv6nLbrkRoQmMoMK7/oC2CA0v8EXOs74tCjSG/P9/1oX7RRB0jTkRPeqgEeevolNuLWOJfg3mNhpJEdttE9T4qirGX1mT3w1zU/0jkiK/g27vMRWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHr/SchHsPKItD3cRAgdZsGRPrgJrBOvz/Jn7e6YrRM=;
 b=t7FF5Tmr/UADIB7mJLWHEszgVFFq5SnEknjzpWJHSQIhj9u3hyIOy+UFZxFtVJydiCISw0BYyIVHZjupyjVTxS0TQc9HMY7SRBkhHAGFV3C+SIHQJhElGANsItsiWOnm29fsV4M+HG6MevdCa/mcdyvAYs5/JJrWM+IOwIRlj+Y=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB2047.namprd10.prod.outlook.com (2603:10b6:300:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 14:29:14 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:29:14 +0000
Message-ID: <a9070375-e4d0-d17f-6749-a7701c1a9bf3@oracle.com>
Date:   Mon, 13 Dec 2021 08:29:07 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 04/10] x86: kdump: move xen_pv_domain() check and
 insert_resource() to setup_arch()
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
 <20211210065533.2023-5-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-5-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0166150c-ec5a-43be-8126-08d9be44eff4
X-MS-TrafficTypeDiagnostic: MWHPR10MB2047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB20474386B4CF4685F4516004C7749@MWHPR10MB2047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwyiV/goV2nM6X0JzEkhhqEpytAMHZjmaJ3dCGdb3m/McK6X7sQOQXQHzmk0oPWK+4HG5a2EQt5n3HuFNPsO5ZyeAGEVXXil+pJzdctkw/IhNgu6hC3n4rclQpAInOoMah++7Y25y1zZXVH/XQUzwsLD92Bo2ypBMbefu47m1LbdDfuxFk5b+i9M8rBc6eYzcLVVZOLHFZeXSnYLDyGxHfOmQkNmiikYgU7kc/WYycVkRVY9JBNiNGwmBx9DSVWCwyXgOQN4EnKjg9FWN1OrSc1Wy3X4yIdelpWq66bPYV+5qPVsi/1sWk5sX6WsJxq0JjrWwQAb+GQzKLmyhumXjmFe7y0/typRB7y2DMFQLMVRsE0YQV7ueUzU1j7jY669aDc2hpLbFFtFQXi3xMRmh6l4a+BQzSsqLx5bjvJiB5amv7RtmBLHJMNLpLptq6Xq082Kg45PvTOtoPoTWufYKbPxr3npts6bTz3xcWgYbMfphIZ2/d4I8vgYImeXZSD56SJ0fmWzD1HaFxvapWZ4uHA5saAWLQ15evISVAFPRsP6YNIVxbCkxWi7/eHkEjJ1V9Ckdg3B5RLX7mqO7qd4NxZW+e/UByLTONhFw5oPgwMwIKp7rzEzhWJitQhUG/Pvm3G6D95EtJ0u6Lusn5uzGaW0fAsbls4NlPHpGRgmKycvhjQjINV0tqfgEF7XdHmsZiIr8jC1heVxirQ65v+xbZ0BQMX4AxDOIcqV2FwKy0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(36756003)(8676002)(4326008)(38100700002)(7416002)(508600001)(8936002)(9686003)(6512007)(5660300002)(921005)(83380400001)(26005)(31686004)(6666004)(186003)(6486002)(66946007)(66556008)(66476007)(2906002)(110136005)(54906003)(86362001)(2616005)(6506007)(53546011)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXF1OVpMY29ZekVrOHh1N3hHS2ZMUWNSUHhQbDQ0bTQyZG9Ja3U5NFBDYUFS?=
 =?utf-8?B?YWExRTdlU0xudDNKbWpGV0pkdWluNUVkZnRZOHFxN0dTbm81U3hzQnB6czEr?=
 =?utf-8?B?akkvMHpCSW1udlBBeDM1YWhoci9lQXorYWx1dE5uTmJLSUFrNmlaS3pPbnNz?=
 =?utf-8?B?US93YzRsaHJldmxJTHR5bTBvQTZtZWJMQXM4UWovdVgzem41KzF2Z0kyY25V?=
 =?utf-8?B?RGtCaHRVdjJ2dUV0czdZYjdwanM3UXdUZ2pFSjZKMk5Gci8xNjFTVEtBU0M3?=
 =?utf-8?B?N3ZsSEd6UVlXSGhlNG9mUzVNai9Zb0ppak04R0N6MGF6eEFyeHhUUGhnOEJp?=
 =?utf-8?B?bTdqdXdqZHFhU2I3aExXcGExYVZ1UGpNWlBhZGNZWkxYWUdrY1hkN0VtOVV2?=
 =?utf-8?B?cWxCWVozKytiNEJMN1FrSkNxa2xIbnFsN3lySk5sYXBuRkRCU05RdnFhOGdQ?=
 =?utf-8?B?dkg1aFIvWWJrSFBCWjFLMGRNRGFqQWhzQVljUWx1TW4ySjZDd0pxVERMb0FT?=
 =?utf-8?B?alFnT1A4OWJGM0pIcmlPZVNkTWY1cTd6QjVlbGdTaXBmME56SHlmTE16RkF0?=
 =?utf-8?B?cHVJRjJWV3hYY1FHazB3K2pNMGtzMFY2Zi9JeDBrLzhnL2tEVXUzSzlZZ2Jj?=
 =?utf-8?B?eTc3OWpnMjUyM0xreVBNV1pSNzhJa2N5NWdnbzJUOHJwTUVIVlJVVk9YWTVW?=
 =?utf-8?B?eERCZWdiRFZXUklveCtmaFZXUzcrSXlTOTE1emcrbzZpeGFHQUNjTW5JT1dn?=
 =?utf-8?B?YW5YVE04T1M4bGpBR0Y2K3llc240dWxac0M4U04rTkQzbWp4OGtxTWlHVm1C?=
 =?utf-8?B?c05zdC93RVNPL0dUNmVNY3gxclRDd3p2eVhKVjhlSlRTa1ZYSm4vZjNwa1Rp?=
 =?utf-8?B?NHg1N0ZsTHl3cVk3RXlFZ2dlTVY4WnliT01BakoybkJBSTFXNFBaZWh1WmF1?=
 =?utf-8?B?MHhIV0pvSHNQRkxOcG5tQlQwL1RMbnNKaUpGNkc3dXZiMkRKVUpRM3VSUzVJ?=
 =?utf-8?B?Sk05dEFWdzZDM0pZY2Vud0xERXFYTWJPRWduR1FDOWNpYkVTRXdBVDQwZ0lT?=
 =?utf-8?B?RGk1amR2d3dwb1JxYlFjWEw1QXVCODZldERlZURaZE02R3ZrVDZrZFJFQytN?=
 =?utf-8?B?TmRQcmRubWNBTHR6K1VKOVIzNFFzYS9ZMjFvTnAxN013Z2FnWElNemNZbzVU?=
 =?utf-8?B?QWVaM1VLQW93em9hZ2JPRkNJQjRmekZsV0RFQlhWLzNLN0NYWVMxdk52YTlH?=
 =?utf-8?B?cGpEdzR5L2pYcXNPWFI0VnloT2Y0UzdvdWhYZk5xcitqQUx6Nng5VFdORmF3?=
 =?utf-8?B?RUFqeFdycGdjUDRlZHZGeURqUmNYNjhSaldKOTFYcFVuN2NvbXBOb3RRemdh?=
 =?utf-8?B?Z0tRNkswbmtCVFd5UFBzSm5vY3VDZ2E2RnhpWTBGY1F6UjcrRnN0elVBdzZk?=
 =?utf-8?B?Z1J5RDJ2U3hBWDBYKzc0M0JXTUZGSXRGQmZiOXNYSVdUYnpnMVRJMEhnbndM?=
 =?utf-8?B?VzdHRDRiZkY0UjVPRi9JWHVpUG9FZjhZOHZWaWpUV1F5NGdpMk1ZS0hzaFhD?=
 =?utf-8?B?U3Rwdmo1VjVZdFNYT3cySWRHaUx2LzNnelVsWnV0NjRsYlhDbmJnWUgzT251?=
 =?utf-8?B?NTB1MzhwOGJ0aTBIUTBvYlJ4Zlh5aGNiejJnMWhuVGNhK3FTL0FxZUFlSm9v?=
 =?utf-8?B?VXlKL0Z2TDBuTXRrd3doaGwremRxeVdYTDVkTjNuNGNCZXpBZzlCaHRPdzRl?=
 =?utf-8?B?NE96aUloamQ4SFprd1p1VkROQU42M2UrWjZOVmVoMUdSSW84WjgweW5DdXNr?=
 =?utf-8?B?eFZFdWUxcmdyWTE1b2pVNTFDSnNrV2pibTM3YUg2K2xpL2lrd0ExM0sybm5v?=
 =?utf-8?B?Z3Rmc0U5R3RoaVMrYWVPZXhhZkpxV2FOV2loWEtoeERvazlSRlFIeU43eWUw?=
 =?utf-8?B?dGlwRXJvTGxIWWU0aFJRNURkZFM3Zi84L1hpV1VLMXBuYmk5UVF1SGZSZlRz?=
 =?utf-8?B?cnF5VnV6Y2ZHMjJ3MXJtNEUvL0JSUUNHb1RkOUgrVUJWTGFrWDMwZTNLYVRz?=
 =?utf-8?B?dEQ2WTRnMmlWS09sRVhoUXNXMXEwa0NmZUcwQU5rcC9PSWlIclBsNHVLdVZs?=
 =?utf-8?B?YWpuV2tGOFNMU1VBUG5RTGNza05neGpWVG1zaTZxVlEyamdPblpwY2pBZDA4?=
 =?utf-8?B?WFFxcEh2ZlV5dFhPbEFXV0RjSlFQRkY4ZjlUU3NEaGJWcllVUHVXQkxjRkE4?=
 =?utf-8?B?MGRYN0VWTDhqMnRzOWloZ05pcTZ3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0166150c-ec5a-43be-8126-08d9be44eff4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:29:14.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EKgVKlMldDJTW8BNUAk1j8O9eALAMraECOsAMVL0HOo2HrFIncp+XRNivc8Qo9m9Heqs/oMQ/zOZNoW3+R7JAGIrOE9a89xfl6bla7IRBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2047
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130092
X-Proofpoint-ORIG-GUID: kuwDngmIusN6Z8Xq1JJA6-zv49i0Ux_V
X-Proofpoint-GUID: kuwDngmIusN6Z8Xq1JJA6-zv49i0Ux_V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> We will make the functions reserve_crashkernel() as generic, the
> xen_pv_domain() check in reserve_crashkernel() is relevant only to
> x86, the same as insert_resource() in reserve_crashkernel[_low]().
> So move xen_pv_domain() check and insert_resource() to setup_arch()
> to keep them in x86.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/x86/kernel/setup.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bb2a0973b98059e..7ae00716a208f82 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -456,7 +456,6 @@ static int __init reserve_crashkernel_low(void)
>   
>   	crashk_low_res.start = low_base;
>   	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
>   #endif
>   	return 0;
>   }
> @@ -480,11 +479,6 @@ static void __init reserve_crashkernel(void)
>   		high = true;
>   	}
>   
> -	if (xen_pv_domain()) {
> -		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> -		return;
> -	}
> -
>   	/* 0 means: find the address automatically */
>   	if (!crash_base) {
>   		/*
> @@ -531,7 +525,6 @@ static void __init reserve_crashkernel(void)
>   
>   	crashk_res.start = crash_base;
>   	crashk_res.end   = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
>   }
>   #else
>   static void __init reserve_crashkernel(void)
> @@ -1143,7 +1136,17 @@ void __init setup_arch(char **cmdline_p)
>   	 * Reserve memory for crash kernel after SRAT is parsed so that it
>   	 * won't consume hotpluggable memory.
>   	 */
> -	reserve_crashkernel();
> +	if (xen_pv_domain())
> +		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> +	else {
> +		reserve_crashkernel();
> +#ifdef CONFIG_KEXEC_CORE
> +		if (crashk_res.end > crashk_res.start)
> +			insert_resource(&iomem_resource, &crashk_res);
> +		if (crashk_low_res.end > crashk_low_res.start)
> +			insert_resource(&iomem_resource, &crashk_low_res);
> +#endif
> +	}
>   
>   	memblock_find_dma_reserve();
>   

