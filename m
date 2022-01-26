Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0180049CDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242665AbiAZPT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:19:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21530 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235943AbiAZPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:19:58 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QEidW7007713;
        Wed, 26 Jan 2022 15:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vXV6mSsxv65+ZGv7h+vu9IVHFE543pMgBx8UC9ojq/0=;
 b=TxGhfLkr2fUi7mvDSIYpFQf5lyksQhTJliBBD5JwexrSSl+1c40F9+Td3qshNCo4aOib
 nvLH0buzWrlGH+/jcOIUdqnavgEqJYQlEs90buLQbCgWgz78pWeJoCfUtsRIn4r5OPIR
 2wE9ueq/KeNT7Ay6d+1i4Ytd7FaACuCx6YyhG2L1/1O91wC+zCkVuQjXZXbxNGAph4+W
 G9Nfwl+Sm9MYZ3O8mJ4ydm4zGMa7/MqLEynRemL5URzkPul7HeDH91jmyn9Mc/tWbmb7
 DIUWdNcT9MqlQ7HP05nEK/iJxuhn3b4Gv3vjThoOezvwLTghENCkKsfC3BDoNsB1b/iR Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s696u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:19:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QFGoc4169845;
        Wed, 26 Jan 2022 15:19:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 3dtax8k9vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVNqMEYv3CaHQMUUW7aymmE29IeZrTr0HOIEVA8UUjs20OAotYlk/hXO9ZWcSVUMwFPwzi0NW8D9qU6FRdprbDYf8TM1aS10Iuj1vwcjVpLM2R4vDH3Sokx2WlwD72AadSag45MUxgVndo2Muf7nMq/xj2t+z+1TjIeEKkcFSpUut/Osn1LcFdOS20Bvk+7kovUPYCUcG0JZFVdk8mSdWs+Ba8G7s/1Kh+C+KjDDbPu/qmTrF/xodID/CkNscXnyDNzovrLE7bf/uqNtpWGvODE4tkPpL3Bq1izUygtU5CUJt+/M27RbJo1kVeqFSn31MG3P9QLn0hg2WBu4uQCRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXV6mSsxv65+ZGv7h+vu9IVHFE543pMgBx8UC9ojq/0=;
 b=STVNdE9FAeD4AOSQQhF+X9rwcSptLDYsKhpykpNlvvS8n7dGGcH+5vQT5iEVkSkR10V42yfCWNUW3Bx3XiPnIA8IwY+KSSo/9DqFdezXuj3by1ee1dpryERIt6UATRR/z3sts1Xa9NLRM+pJ46HjG/PqFCvOX8NiZA/JM5a5jUt+RvEVvcMeCY0G9em7WglSqTYwko0clHb9b96mtLovBZRaQ9X1PeyYpNZ8CZnJlGZda0Y1iUdD4QOzilnNQEkvrMDFWPAEtDy7Q9kqlaSXx6ScBv9icrJjYSOdtb2iiN4HDgDmUuAyTzNZOreJdRNcxanpbd68cQKiL0S/1eNpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXV6mSsxv65+ZGv7h+vu9IVHFE543pMgBx8UC9ojq/0=;
 b=qrW1LRMjJyQld76us+AIJhqUFjmSHG90tFGMxyoOvDOfqoanU4PV1433MKu7BuqL4fBkIYKaM+ieBCH9UxkOiB8d7SJQ/HzRn8o58IfKuKxCuD+2j63eLPjHCzD4cEhuJ2cflvq6gcNbqVPDZN6TazEQvOT/FYii0G+UgN2lDeU=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by BY5PR10MB3842.namprd10.prod.outlook.com (2603:10b6:a03:1f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 15:19:22 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 15:19:22 +0000
Message-ID: <87fee388-fe72-4c87-577d-aae07a4a6da0@oracle.com>
Date:   Wed, 26 Jan 2022 09:19:04 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v20 4/5] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
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
 <20220124084708.683-5-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220124084708.683-5-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::10) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd349e5-e128-4d9c-ef48-08d9e0df3ae3
X-MS-TrafficTypeDiagnostic: BY5PR10MB3842:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3842455D131DF7E9584D0925C7209@BY5PR10MB3842.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p10/BmBJL45qOpZzAsQXqYyV1EepqhzO9QdU1tUzT+ZGitUYVpVtTNvXso5lK/v2mISlD8eWP86O2Mc6u4N5QnYuf7qYefsVtQsaIEuRbo9bOuXbJP4z6pmVod3q7IIuxxAMDISz63VdShHePVk5sQ/vx+aM1ma4V+wpAgKPaMWdltEXXmxiayUHEda2RPJO2wQHHveLFmpQWiqp3VhZr5ZAOmw5by3KzfWGnSW7CKhUjdNScnSmAQYZtqmjwMUUvU2fAz6PiBLCVGwHYrLVfrmsFQgdyX8VzBdhZ+6HAFZRqDSJcq2DgMwW6g+Ad4zGGhDe99Is/OiYifMdAUDTbcOHRRo277ainUoDFTusaBGRJr/nMgwW2QZUkx4JGHmK0O608blQfhEuT4Ut+ThbO12hyFF32uHhbhHLNSUpi+WU1bWDXLbxwFAfuACuBMKCuW1uj3qHGWAi3M59mtrnPzq3AHBxk5SR/E1/rb5XaqwvWd0YwMjeSu9pROh1OL2bA2prk+36kN1OY+Wd2xqTwUzs93Ao6qQXkfW8xmF2PQ5d+AEXfiKyMU+o6GIWt0SfPCQqJZODD5kTAT+NmP7ASBuM5ynxmjVbyG54HNcF//xcPKUCR4nPauAP+jn4JuNm2gh417h39aEcpacjB4z8Biw1faRGLx1jrmvW/B0Z4R0uRazucRfumX2Ow68zy4Dxk3IfYfLAYBJjmEwVq3gNjXCffl+7BQYOnP0BkLUpQdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(38100700002)(83380400001)(921005)(66946007)(66556008)(66476007)(6506007)(8676002)(54906003)(7416002)(9686003)(316002)(110136005)(86362001)(2906002)(31696002)(31686004)(4326008)(5660300002)(8936002)(508600001)(36756003)(6666004)(6512007)(53546011)(186003)(26005)(6486002)(2616005)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJaKzNmejZKN2t6bUJjUWFoUDN3eXA3ZnI3dzJTN2JUdUhTaDVzSUNtWldh?=
 =?utf-8?B?aWJ5Yjd1RGdFOVA2dERVUDNoQzlZZTJrUjBNUitsc3BuN0lhd2FBUlhaVExR?=
 =?utf-8?B?djducWJ5aDV4QXBnZUFuQ2VKdUFPaGVOWUlWaTQ5UHVMclNUMWNtR2Y4OFVw?=
 =?utf-8?B?eDMzNW1lcnY3aURJT3ZmUlVKTHNQSU84cmV0S2w1Y09FRUQvcDF5NGkyV0pS?=
 =?utf-8?B?bnRvYmc5eWtyWEZJRXdRYmxSaWVXdzRCQmRpMCs4NEJGOVVYcjE1dUtRWjlY?=
 =?utf-8?B?QVd2YnlWOEJJOUN4cEJ0Qm03aEJMOUNKNzh0THBWNEM4VURodk9yS1hqbitz?=
 =?utf-8?B?SDZMRHBiRTZWdU1aN2VudEl2MHRkMzNnU1g5R2k1dnArQko2Z05TWTZGcWdG?=
 =?utf-8?B?UVBZK0U0TUdiMW10cFpnT2loMVZyU043NU1VaFdya21LRjFtUEtvNE9OdFBp?=
 =?utf-8?B?WDJFMjA4RjJ6U2lkeG9wc1I0YTUyMUFHTDVmVndvcG90aWQ1b2FYZHcvQzhB?=
 =?utf-8?B?dUNlc0NIOW82bVhpbXpVNndHKzA5NUlpdCtYZkg1NE1pL0ZadXRIQUJRTU15?=
 =?utf-8?B?R0YvUnZrd0R0bFFBYWdxTnhvK3FEdG0rZ0hOSE1uSmhMM3B6V1BmZmNEc0Rm?=
 =?utf-8?B?Rm5BRU80bml4cjVXOUdpL3BjbTAvb01HK2I0NlNaYnZXbTdvWWc3ZXdZNmlT?=
 =?utf-8?B?K3RTeFRpRTZ2VVorSjI4SHBMS3Mva3BPREFqcWVmL2gwdFhKL2hmOXZUeXY0?=
 =?utf-8?B?TUlvOXA2eVVFaWhoUHNtM3VITG5KblNBVk10NnA0NFZCWGRZNHV0WWVoNFhN?=
 =?utf-8?B?WVlkT041ekRzekxiZkZveE9GWFE4cmo1MGhTR0pFSGhGbTVzZFBWNkxFTW1m?=
 =?utf-8?B?aW5VK0tHMTZKRTZYS1FIY3dSS0haMitXS2ZzODB5RFArWVpkTDhXNENJNDBz?=
 =?utf-8?B?Z1BJMXZWbFNUM0JXVmtrNWppZWYwNG1UUkJmT3l0a0Rld1VsazltNVNKVm9j?=
 =?utf-8?B?MVZ3TkFWcWgyOWdBTzV2WDlubzZYQ013bU1YQ3h2clUwQTQvenh6dEI0STBo?=
 =?utf-8?B?eSt1RlBKT2ZmVFdBNVVFU1hRT3l0ZTVvMithNENtKzBONlJiQlZIWHhENHBv?=
 =?utf-8?B?ZFFkR3dlSkNhQS80bW96Zm9yczlCc1pYWlJXcEgrYk9mcTEwaE5mZDMwSTI1?=
 =?utf-8?B?MFU1WjNCOWVaNVRwVWRDVmRXOGhJTjB1dVdxdXhLNHlPY2lnUi94MkZWU0Rl?=
 =?utf-8?B?UVBaYUIwRTBhNVJjYnJOV0taMkRYaE51UXJzNjdta3ZxM0d3WTU0QWVxVXBK?=
 =?utf-8?B?WkFiSnRnMlQvUEh1VDVtWTVRWkVQWkpOa2FtUzRNRmJoTkNVL1MrYlZ4b0Zy?=
 =?utf-8?B?UlBVdHdLcG5WK0tWQUtsNmxrM1U2MjhETkQrMmdBMVQ1N3I5UnoyY29xRWU3?=
 =?utf-8?B?anBheFdWWWZyQStNQ3RHSU5wRHM2emZaNWZJOEN5REFIWEpaRk9xNVVZTHhj?=
 =?utf-8?B?aEsxdHRsaExxMzA4WHQzU1phblBBWkxiemN4TDIvTGdhYk9DcU5QWXJpTzhl?=
 =?utf-8?B?RTA1aE1mVDBYOUhBVkVLaXJQSkIwNnhWSUxtRW5HQ0NPQnFFM2kxMVZZY2xv?=
 =?utf-8?B?aWxWWUVhaE1rWnBoTXFLelp0dVdNZCtZQXBBZnlFeTFhRk9MeFdkdThITWpX?=
 =?utf-8?B?OXFuU1d2c0pWQlhaOVg1Z2FBeER1b1RGbzFhT3VnNms1NjY4NVdyMjg1N3Zy?=
 =?utf-8?B?R05yMDdaeE9HL3VLdVF5QnFQaE14b3ZNOXRGaDNCT3M5Z3JQVEN1cTY2dEVV?=
 =?utf-8?B?ak5pNzdhYnFZTW1RbjYwU2JnSzJUYXVtZ2ZQWm9lOHRFZVRjdEIxQVk2Y3Jm?=
 =?utf-8?B?dFFlWFFxMlVpd0RMaDQ3bDVBNFUvNVo5b0JOR0JEQVpERmxyOVE2YTRWVjZp?=
 =?utf-8?B?MWVENnBHSDJMSGRzcGlNRjVBTHlSSmlGaWFyM3liT1ZFTkVsZWxsRkFPU1lq?=
 =?utf-8?B?ZC9KTG91MXhsWC9iUXB2UkZFdWx4MlJiekNBYURHVGtkWHFxVkY5OVh1aTUv?=
 =?utf-8?B?emppN004OWc5TzZXMzhMTnhleWVtOTBvcXlyUmR5L2pCTVV3SkhpSDZqSU9n?=
 =?utf-8?B?RXplS040RWVYTFVqQk42Z3dadHhnMEpXNEtZT1ltUFlTQlRQUFpOQ201QzBR?=
 =?utf-8?B?VEU5R2VJb1dkelAvM3YwMEN2QUd5WVVMRnBWQmxDcy9ud2FKRUFBVjdNc0VB?=
 =?utf-8?B?a1B5cFVTeTNSa1p3Ym13Z1dvUG53PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd349e5-e128-4d9c-ef48-08d9e0df3ae3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:19:22.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMAoHZptLGK5hXlvJrY8jERljXILQJ2boCv6ARSovknvDPC3z+hrM3+jgIoF515iRLUrV2qTiRxgZPSmW0DN/71rsjfDEDV1jiKOvTslPUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3842
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260095
X-Proofpoint-GUID: ttafpjC5hbHG1llFqmHzfgVwTIbN3jJT
X-Proofpoint-ORIG-GUID: ttafpjC5hbHG1llFqmHzfgVwTIbN3jJT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 2:47 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices and never mapped by the first kernel.
> This memory range is advertised to crash dump kernel via DT property
> under /chosen,
>          linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> 
> We reused the DT property linux,usable-memory-range and made the low
> memory region as the second range "BASE2 SIZE2", which keeps compatibility
> with existing user-space and older kdump kernels.
> 
> Crash dump kernel reads this property at boot time and call memblock_add()
> to add the low memory region after memblock_cap_memory_range() has been
> called.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   drivers/of/fdt.c | 33 +++++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index ad85ff6474ff139..df4b9d2418a13d4 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -973,16 +973,24 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>   
>   static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   
> +/*
> + * The main usage of linux,usable-memory-range is for crash dump kernel.
> + * Originally, the number of usable-memory regions is one. Now there may
> + * be two regions, low region and high region.
> + * To make compatibility with existing user-space and older kdump, the low
> + * region is always the last range of linux,usable-memory-range if exist.
> + */
> +#define MAX_USABLE_RANGES		2
> +
>   /**
>    * early_init_dt_check_for_usable_mem_range - Decode usable memory range
>    * location from flat tree
>    */
>   void __init early_init_dt_check_for_usable_mem_range(void)
>   {
> -	const __be32 *prop;
> -	int len;
> -	phys_addr_t cap_mem_addr;
> -	phys_addr_t cap_mem_size;
> +	struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
> +	const __be32 *prop, *endp;
> +	int len, i;
>   	unsigned long node = chosen_node_offset;
>   
>   	if ((long)node < 0)
> @@ -991,16 +999,21 @@ void __init early_init_dt_check_for_usable_mem_range(void)
>   	pr_debug("Looking for usable-memory-range property... ");
>   
>   	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> -	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +	if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))
>   		return;
>   
> -	cap_mem_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> -	cap_mem_size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +	endp = prop + (len / sizeof(__be32));
> +	for (i = 0; i < MAX_USABLE_RANGES && prop < endp; i++) {
> +		rgn[i].base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		rgn[i].size = dt_mem_next_cell(dt_root_size_cells, &prop);
>   
> -	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
> -		 &cap_mem_size);
> +		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
> +			 i, &rgn[i].base, &rgn[i].size);
> +	}
>   
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	memblock_cap_memory_range(rgn[0].base, rgn[0].size);
> +	for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
> +		memblock_add(rgn[i].base, rgn[i].size);
>   }
>   
>   #ifdef CONFIG_SERIAL_EARLYCON

