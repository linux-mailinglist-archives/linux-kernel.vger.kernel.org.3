Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7649CDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbiAZPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:19:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40270 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242665AbiAZPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:19:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QF2Mjx009994;
        Wed, 26 Jan 2022 15:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YFLgSo8ir3qewXTjKTzDNtpArJr+jvQCtaH/AsxqyPA=;
 b=rm39eUpHOZXegiut0FMeGBNSSWWdjj2gwAZT8v2x+w9nr+WRQOTQ0Tep9MZjIGGyhxfj
 Vm688xd6kyrUkdDInSQFsxMVee7iq+MIVYuh0GPn2qSiz8iFizqyng8B/506o0zb6jki
 xelJbKRNiauqvoxjQoXn9ixt1fhr3NA1nLFKE5Ua5G+M2C3/jUr2y3aaKDq7ydGWIyyk
 YfN6aXBSyzdr9YvM50FwN4HwU/eRd4KpZZISsh0RyaPIyCjsXn4mZI/mv2+O8nkvRR4B
 XtI6FN9nUTm+SJR6NesH/DR5UAcUYQdrIMHUNU839BlqoQrutqnCdsWwH5CRQV8waiLN qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfp5nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:18:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QFF20Z122724;
        Wed, 26 Jan 2022 15:18:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3030.oracle.com with ESMTP id 3dr721cdhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0tMqqZygYDQRhN23ReIfDcLnIbUnKEE/ByXlmqTUP/Knhipz9cEkpmfanJpuY+SaucD4SlC1FxVglVD6/a82EdjIjLiyrCJf43QHDei5e1Z91vfyxhTnTIdTLxlKPG2cP5T86bbnpiZAFvk9QbiI6a4xoSSQCE2APi9xN/Qae8wi1zpBGS6krRuhsriYg+7V/4NTDIOeKhrozUmgqLKsOYT2kqoSfrid0O0gf/xmGHT166NsXi5AvgFTjrLjQz19qvf+la+PaVVoVpcBn0w6Ky0o+TNo3cSDBH66Us7lPYSlMvXCpU36d6pZDSj91w0uKe9CNePkpWo2xUFkC2lVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFLgSo8ir3qewXTjKTzDNtpArJr+jvQCtaH/AsxqyPA=;
 b=kVQwPaCvKF9m9U5BrRmEnrqJNa4Em+s9ctWIPRNYwGKlfRQMHteK3xUCb8vq5fh/+w//CfLKIEazWoT5Qlh6qZsuozyBUFK4OVGsYUUX0Ahnpo7lNzXZe1dLcY5Q91HGSl1hZIzh/D96HomlXKDwEfeSL+2AfYLM6FP95VqFhrBWWvLJq56bQM9a3ImgczSnpRD9Axe8Cv9aq4FFFao9OjYGCTCnYjGf4Dq3oliNzCSS2SySWBuTsbhDMtwbQPi0lvJ+KvlCb9H8hMSLWBw7CLoPLriSfHiNFu4IvpLtnvROt6Ql/7WSxkCDiDSgQuTR6ywctBNogTycDv2hyfo0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFLgSo8ir3qewXTjKTzDNtpArJr+jvQCtaH/AsxqyPA=;
 b=ZkXcOLo6fRvyPyfbymy0ydrbhWIvIGEdOjxRIiBXjxRl3gZ9qJedIaHBUt+qGLB2PHlb/V5knbCPwvN1cShWT6GbT/v3M9rp4+Or4zq4zJFrGz80xK9jxkQErPRNkBO/+ANlsdbrgsqBBfQDE1Gm6x0JKlhQV5d0AKPa1KHSI4I=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 15:18:34 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 15:18:34 +0000
Message-ID: <48e9f8e8-be1e-fa62-1cbd-61be4a73658e@oracle.com>
Date:   Wed, 26 Jan 2022 09:18:18 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v20 3/5] arm64: kdump: reimplement crashkernel=X
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
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-4-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220124084708.683-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::35) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b461942a-c7a1-4ff3-f95d-08d9e0df1e63
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45427412D5A3F6A9F0F2B89EC7209@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofue1b5QIL0jLP3r00uUDv27io9mmwChPuiw3jSMVtIqgMQq5vVCXOmD72ANMrpLwxJW9g1EvmEtG2AQHnTcUCqZD6qflLaeX1sYEzDEO+E+z8rTG0iKId0igZ7423GEKJ1tmyYooZ9ekH5MUkpebGcJwBLJEuKuAYzFshPdd3D28Xn5Y37sVVLKc/Gbo1yVF4RIgbDJ7bbqRPnCCeyrhyXg0v1FFnN2asYcOLZpdPhvecGygsyKEJvV9bumwX3K963Hfwz2nThUbyL7ZjfJ+5Du5iX1ylZLgVS0HQY/n1n74+zFB3D09skWv1BxTCPULEJ6QFwp9nfdZQAYVbQTwjLrL03hST91UAQho+r4/I13JBNXeuWuxVYS1HTAUFovICDrJOmuB1oor9nvMh+TFUyo4vl/xTak0+gRaGm1VipmEVfpGQg6fO7WlObmIPx1vVPME7N2kctqPXHhv9wBe8kqzVntYFZruXNwk1QmKcBzRDekLqBw3DxiKtmcE6kQ3cgfI5zQIPTQBKawGbaV0ohM6XwmRmGlzZa1QJxO86iE+6ip/oFlx4hrB9I8Y17Sm6O7pOUVdHeSh/PnDnOzDWyhJ6UH/16gf8s0lnNlY9F4w+aMPhSOiqEZCXhj0GZTcT7siey7H/pIgeDjpDPDh5gg3MUujmgPA0VOgq0nI82Cyh7PJqoAzcGl+EXeIGlppr//ZGgghHZzFAJTIJ4BVq1FsLiXwJ04YBFk3pP+KTjDaovjzX1jjA6lWlBuNo/b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(107886003)(26005)(8936002)(8676002)(86362001)(36756003)(31696002)(316002)(38100700002)(31686004)(83380400001)(921005)(6486002)(6666004)(2906002)(508600001)(186003)(5660300002)(6506007)(54906003)(110136005)(2616005)(9686003)(53546011)(66556008)(66476007)(6512007)(4326008)(66946007)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFo3NXY5YnNETVdzZUQ5Q05VeTF1cGNDa2xLdmRoWUZDVHg0cFRCdEluT3Jn?=
 =?utf-8?B?aWw4eC9TRDNNRHJ0ZFFHZWs1cFoxb3RjYllzVVlLa3dQL2RMeEhvUXJpb3cx?=
 =?utf-8?B?eWQvNmtJS09DK3QyOWJEek5GaG5GM2FMWndLWWhHSGJkY2lRT1ZURmd5QlBo?=
 =?utf-8?B?SG5ZMGoxL21CbE13MEd1TFdkVk1IOGxVSEh5SWpjV08zaU5UQjJOM0wzNURX?=
 =?utf-8?B?VktCcGxJRFZycStqVEpCUUtEWCtOZ0k2b21wR0RhU3dlK3Voa29HT092Z1h4?=
 =?utf-8?B?alRKZy9kaW1vOEZ2SGFqaEIyZUR0ZnVyS3JTdmVJczVIR3Y4U21GQnFHU0Fm?=
 =?utf-8?B?Ni90OVFOdWpTc3BlaGJuVWZHZVlqUXhsSm9MekpJaHpXN2FIemxqS0VwRjZn?=
 =?utf-8?B?ckwzZi9sVDJseUMvNUVGaGd3dlA1eVRwV1Ryd0hWQ1hxNzhGS3Z2Nmt6cit3?=
 =?utf-8?B?NG1xQ0ZxRXNiVVRrM1lRb0NEai9CUnFxYzE3dGhGQmtiTThURTFMSGJEK0FF?=
 =?utf-8?B?NUE1WEsrTFVBTks0ZG5nOHhJMjVtSlYyMDJ5bDNHczNzcEo2RDNCSUtUUWYy?=
 =?utf-8?B?YWlqbFFHRnpON1FOazFFWFoyZU5Bbjlwc2s1NXJwYVNNaThLVjZIWWZVQXZz?=
 =?utf-8?B?RTRGVm5rZ3YrZ1NpWUJQSlBDdHFmaXV5R2RaV3phVFFnSjY2cGJaYUFmcmw0?=
 =?utf-8?B?ZjA1T3VUQUJIUnRJSldmdWhuV2ljNXNFaGpzTFhtTldDcUtHWVlvWGtvY3hi?=
 =?utf-8?B?c052M0ZyNURmWVVXM211YUhOWUZWWHNPbWN5cTYxemh2QjIrOUNFVmsrbmt2?=
 =?utf-8?B?YVVBQkVSSUQwZVgxbU9NY3FuR0VoWVRQai94Yi84ZnROdmNjT3dtQ3pIVlc5?=
 =?utf-8?B?S2RyRlNLcmJSL0RDaGU0MWJnK29KTlorOGR5RS9VOWZEczZkczAxZ3laWlhJ?=
 =?utf-8?B?bWVPemloK3BJSUtLTFVXQ1dhQXBpR3M3MEI0NjhGYWxjUnNLSkFYWGNEb3pZ?=
 =?utf-8?B?MVVFa2U1N000SFdSOUI0T0NRdUtJWnBNd1QwcEVRSUJIMTNtSittbWFYS0E1?=
 =?utf-8?B?Q09tR1BLL0pSOEpXYjA0WUtxdVV6dDdMRFMwajVsVVBhL3p3ZnFxK2d3Z2Y5?=
 =?utf-8?B?Sk83WHdRbjhhTnhOUFFQancvU1VVU3oyenAycVZKWElDeWREQ1pVMUtrUzJG?=
 =?utf-8?B?aGRZeXllTG1qSWxSS2NTdzhUQWorRkpDMHh0ZXVGWExHRERPakFPTzZSMTVs?=
 =?utf-8?B?RnYvTVphMmo0NjRMRjVYQUc4R29VNjVxdzNQVTEvOXM5NUsyRVNtQXp4bkdT?=
 =?utf-8?B?QWY3N29GTmVmRXlUTUVpemRlSUtaeEdLd0tMMWluRkhBTks2VG5lbXh0R3Jm?=
 =?utf-8?B?SW1VWmdzcktKQUNKYTVMeGIrTW82Z2VKU3hYbE00bStpd1E2THo4OWYvMngz?=
 =?utf-8?B?dmtoV1RUdXRVZzNiQytPemU0SUNCS0VWclo4TlhBVVIyVUY2L28zTC9WMTkw?=
 =?utf-8?B?VHFzQklKUUFCNVRJc2ZlblQxek5qeUpqekYrSGljV3gvalRWWmxCZ3hMOENp?=
 =?utf-8?B?bTk5ZURkTWtGdFV5Z1VRNEIrK0ROSWI3ODFTZW5zVFRCRWFTOGZxcVZiQU96?=
 =?utf-8?B?WG1kbXZtYStyd2xsaWRSVFlBckQ5Mnh6TUFPNG82ZVdqcWFJNWZPQ1VRRUhC?=
 =?utf-8?B?N2N1SjlmaEUwS0FoK1J0SzR0bmJxa1ZSeFdrMVUrQ0x3b2dsTU8rUkQ2WWpk?=
 =?utf-8?B?VzVPQzJtTlY3RU5kejF4OEppWGN6NjVwVForMUdJSmtXOU9lTGpUMG0rTXZQ?=
 =?utf-8?B?WlVIaXRHVGJNREVpWGN4WGdMOWtaYm1zc2w3K2U2U21PNlc3VmFDM1BYRDE1?=
 =?utf-8?B?MEU3emZBdFc1ellwVGhUYkNEWm83UnRqREZMa0JyV0MvdjRzRUl6TS9sNnN1?=
 =?utf-8?B?d1F0UHJRY0V6ZUdNb0NOd3hwZksyRkZXVDU5TmpEWHdYcTVwQUxLdUF5Zzg0?=
 =?utf-8?B?YkRteTlkVUtUU3NqYlNiU1pOVnVmOWV4T0VFUWRpbXc3Qm1VWVlBVE84cWt3?=
 =?utf-8?B?S3ZvU2lPZDBEenVub3BDeS96QXV4QzVTb2FhRXgxZjlEcFhnWnBacFBpOGh6?=
 =?utf-8?B?YmdJZHVOSExKZm94RFZWNm1ZbW1ndXcrdXViZzZkRUF1VXgrWE5xMFZZb1VY?=
 =?utf-8?B?Qno3Uy9kc2MwNWpCYnNXRTF2bk1MUjB3RFZqVnNCazdPeGJ3Z3JQNElhRnJy?=
 =?utf-8?B?YmpRdm9kSmRyODI4WnorcGo2NGV3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b461942a-c7a1-4ff3-f95d-08d9e0df1e63
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:18:34.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIaetIdhkbpF5ZdEWBvIyqieLe1OshDTeWNE7pC98jlZG6eQQTuHJTEx0QiZEgRJ3TCUM9+BUVqN0R0+KyxHidRGnaDZ2X8HqjMGPu6yqYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260095
X-Proofpoint-GUID: a3YgHPUUe7ZHsEaoSSvRBJ19l24rxIPu
X-Proofpoint-ORIG-GUID: a3YgHPUUe7ZHsEaoSSvRBJ19l24rxIPu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 2:47 AM, Zhen Lei wrote:
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
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>


Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   arch/arm64/kernel/machine_kexec.c      |  9 +++-
>   arch/arm64/kernel/machine_kexec_file.c | 12 ++++-
>   arch/arm64/mm/init.c                   | 68 ++++++++++++++++++++++++--
>   3 files changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index e16b248699d5c3c..19c2d487cb08feb 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -329,8 +329,13 @@ bool crash_is_nosave(unsigned long pfn)
>   
>   	/* in reserved memory? */
>   	addr = __pfn_to_phys(pfn);
> -	if ((addr < crashk_res.start) || (crashk_res.end < addr))
> -		return false;
> +	if ((addr < crashk_res.start) || (crashk_res.end < addr)) {
> +		if (!crashk_low_res.end)
> +			return false;
> +
> +		if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
> +			return false;
> +	}
>   
>   	if (!kexec_crash_image)
>   		return true;
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
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6c653a2c7cff052..a5d43feac0d7d96 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -71,6 +71,30 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   #define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
>   #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
>   
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +	unsigned long long low_base;
> +
> +	/* passed with crashkernel=0,low ? */
> +	if (!low_size)
> +		return 0;
> +
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	if (!low_base) {
> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("crashkernel low memory reserved: 0x%llx - 0x%llx (%lld MB)\n",
> +		low_base, low_base + low_size, low_size >> 20);
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +	insert_resource(&iomem_resource, &crashk_low_res);
> +
> +	return 0;
> +}
> +
>   /*
>    * reserve_crashkernel() - reserves memory for crash kernel
>    *
> @@ -81,29 +105,62 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   static void __init reserve_crashkernel(void)
>   {
>   	unsigned long long crash_base, crash_size;
> +	unsigned long long crash_low_size = SZ_256M;
>   	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>   	int ret;
> +	bool fixed_base;
> +	char *cmdline = boot_command_line;
>   
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +	/* crashkernel=X[@offset] */
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>   				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> +	if (ret || !crash_size) {
> +		unsigned long long low_size;
>   
> +		/* crashkernel=X,high */
> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +
> +		/* crashkernel=X,low */
> +		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
> +		if (!ret)
> +			crash_low_size = low_size;
> +
> +		crash_max = CRASH_ADDR_HIGH_MAX;
> +	}
> +
> +	fixed_base = !!crash_base;
>   	crash_size = PAGE_ALIGN(crash_size);
>   
>   	/* User specifies base address explicitly. */
>   	if (crash_base)
>   		crash_max = crash_base + crash_size;
>   
> +retry:
>   	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>   					       crash_base, crash_max);
>   	if (!crash_base) {
> +		/*
> +		 * Attempt to fully allocate low memory failed, fall back
> +		 * to high memory, the minimum required low memory will be
> +		 * reserved later.
> +		 */
> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +			crash_max = CRASH_ADDR_HIGH_MAX;
> +			goto retry;
> +		}
> +
>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>   			crash_size);
>   		return;
>   	}
>   
> +	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
> +		memblock_phys_free(crash_base, crash_size);
> +		return;
> +	}
> +
>   	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>   		crash_base, crash_base + crash_size, crash_size >> 20);
>   
> @@ -112,6 +169,9 @@ static void __init reserve_crashkernel(void)
>   	 * map. Inform kmemleak so that it won't try to access it.
>   	 */
>   	kmemleak_ignore_phys(crash_base);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
> +
>   	crashk_res.start = crash_base;
>   	crashk_res.end = crash_base + crash_size - 1;
>   	insert_resource(&iomem_resource, &crashk_res);

