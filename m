Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19372472F60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbhLMOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:32:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3638 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236316AbhLMOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:32:47 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBRDXf026927;
        Mon, 13 Dec 2021 14:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r7g0h+TxWGJ+tu6X0zzTD3KsoIZ14JRnPH5hZZZwWGA=;
 b=n3tbdxiluvYbEHVU+r5zxAym0zceT+6Iak9iB/EvXGj/vlhWP8jgblInvLRGdMLhZzSB
 dEfaars70XAqJkGMZ1n/gPqAV88+6AQ+xg9+Y3KTP+s7r6rArkUhRMFEul4v96nGRy4p
 fvzbAYyOh/VYgvQu88Ly30xgdvSS8AxrMV/203LrS1Aw0H3QobOlC+F0nWMz1VbrWugg
 D530wVDePp8Jrs04DjzwDZE81YZ8EmvbVkcFfCN/CH2xKt/WtKo3UBhHkpsUPZFCz7Qm
 TLfpKihEV1pFMRI6yCS7Yo5tet7OTr3aGvg5VwakK0Hb+EFD2Ihq897oC0X9SRdDm83l Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5ak8cv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:32:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEP1ca085815;
        Mon, 13 Dec 2021 14:32:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3cvnen59re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGifMfKisdQnp7qx2h7UWyfmufGQ/d3gXxU9VjZORFrGehVLeanE4RdiGvViFPR5veMW4jQaR1vK1t52z2jZrC27yYGn68DBxrwKiB5vxUuMa2/QJ0G0OHoPuGZAPl/SAnJ0/Km2eXs9k1X6NDWVx2B3HxYqmllXFtMbFyDUSskNiMzlDQoL1FvdupxpQ9mS0xh6KFr2pdN9IXZWSCvaOQN85fs2jjqzbDZ0RSVjHePjVSfim91BkY9E7SYKSYOAMlbLbl6+Vw3s6bvPBNQznE1lN/WFsZqLtn6Ti23V1NQcPwrjnioGNDV3JjYkdI3gd+7+WMTlkK621dn6Cd15kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7g0h+TxWGJ+tu6X0zzTD3KsoIZ14JRnPH5hZZZwWGA=;
 b=BgCKS0AIn7s43/hXCSCKyyXI7sfekCMt5xkIA100ZnrxrSZv9YOAGYkUcAP6JyxsZ2FlMtM0AAH+hutJql1OWCbmidDDeiYlt0QLBbzREBfiLMJtS8cJxL/OcF1N2Mv8SgJ957/6XMXozXgNA7SFaz1Zqndu3c3whNFDWggFydBy75+jTteT+3DwV3+21Rm1EdRMMWD7fCDrXLaXNtYi4/xtaVvr4FxCxHV7X/KABmLJrHILxU2OMfklCC/J+shMV2ZoZkS2aIPodxniyeXD3ZTXCf8eoywb+2g00ZObO29E1VIPCE01eu/CcNfGhBnU/zDkpyDl/r0kaOnoHKvkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7g0h+TxWGJ+tu6X0zzTD3KsoIZ14JRnPH5hZZZwWGA=;
 b=kHTmbFfBcIpe7F2jTPdmlYHeQ0gtAU4HV1XATRrIyh5up/RvUQoRg/Wz95L2rh0SLuMjnrz3z0v7c8RFMOKxveB4Sb5cnA2K0fNI4UKp2fIimX+WzVwPgfjSpKFur97gmq/Vu574Pz+Lp5mS6xWD4mkUaPLBezohykW1CK35AV8=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1933.namprd10.prod.outlook.com (2603:10b6:300:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 14:32:05 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:32:05 +0000
Message-ID: <d438592e-23de-f173-468e-712c1925655d@oracle.com>
Date:   Mon, 13 Dec 2021 08:31:50 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 07/10] arm64: kdump: reimplement crashkernel=X
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
 <20211210065533.2023-8-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-8-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0501CA0032.eurprd05.prod.outlook.com
 (2603:10a6:4:67::18) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f30a2d4-4da8-447e-5a27-08d9be45559e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1933:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1933D3346BF5C96CE053B570C7749@MWHPR10MB1933.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XaGeBjyjN2sbb0yWvnSuudEIRZRF8go9d2guak20Nyt6U+XhvnM6370+HwoPN6ncuFc4NH3sOnIAsSNjS5AFkzqhfQ2H+hVij99KqacUwRG5jXw+OSGqGIw5o+42fq7IN7dyvlQA6i3+6tUSMlPsIvZH/WquDB1n2Q7cuqXuUQjfjD7oAfL8N1+LaWfc0j92fgnuNc2tbaynpr9rCsAMxNCHudrgs1wCg2qPyGHcPKqEbJb74hNjR1j4bHNx9R4yRdwF/dRsH9a8vCu+eAPlhUejuDZtf/baL8pn9kQz6L7ilxF0kTnLwIhRvwr3spX73dkLRPQm5C3DJ8KGvx27pz6Kq8jzZx8opndm4KPU+F+bG2CpdXwdVbHcvNInWfVDyLpricIGmrC9kEfRZR6oKfXYDUB9jJ81dmqqFDjfitdM8QXjv9D3W1Y8rPsdGuPWYCwPDEpeK4lyCO9gg0T6Rw6LJf17VoRDHWamPHy9B6SpcUwOlBAhg0pOnGOg/N/brAMbMlISkrct7kkgE+M0YPYhprALCKUb99qj6/ETSqvYqetMmVmQMUlBk2G2EGykFE0YbpBPZMLpwL8FTEL32V+C5R6Pni0mIbuCucaBziMPKVwI4YvxTUchHW8pOWqutBs1QGQtkfTrHEMInyop3ccokLK4OIsF+0geCX6dIr9qiG7aKbqFU9F5fERc8ptsBoXzk7TmA90icskhbfvfWUP65Rb4+VzI7pp9UDHJ4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(508600001)(36756003)(2906002)(31696002)(8676002)(6506007)(6666004)(53546011)(921005)(316002)(83380400001)(110136005)(186003)(2616005)(26005)(6486002)(9686003)(31686004)(38100700002)(54906003)(66946007)(66556008)(66476007)(8936002)(5660300002)(6512007)(7416002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpZYmcwRXdsZEVFZlhwSDl4eFdwN3EvWmZzRjFiRFM4SzY2bGtFb0V6Lzd1?=
 =?utf-8?B?VTduemZzR0NoZVhqeElJVVUxVWFScFJNUGFWL045dW9OSXVLNDRrU0NjOTJI?=
 =?utf-8?B?cktGWWRYT2ZNdHRYd3pVVlJMUm9VdVEyRytBWXRYN0pGRlFUVWJFOWhxQjRI?=
 =?utf-8?B?RXUwaTBEZjdUcUxrSGllcFY1Mll3S1hSbTdRUXBUM0FhdlJITW9GZjdtK3NP?=
 =?utf-8?B?TGc0ck05YVBUVkllcXZ1Y0ZHc0hsUk02WCtNTG0rT2NOZmIwNWxNbmdPZFVv?=
 =?utf-8?B?dUFycDlSd09EeE9kNFk2UzZ6TWdWMHVBQlZsRm51WFYwaFdrbDE2N1ZvRDhx?=
 =?utf-8?B?Zk51TThFZ0dwZmdMWTc3eHZPRDU5SGhoN3JmcytVWGZnYUZma1A3eTFxUEFF?=
 =?utf-8?B?V0U2UGRTaG4xSVJRNkVwSHZGSGR4WjBsRGozRG94Ym94MUJhcGY3Q1EzK1hX?=
 =?utf-8?B?YVhSaGNSL1Fvd1RrMURLQ2lDQTQweFJZSEVFdnVPb0hwUktCMFRGVFJEZXQ3?=
 =?utf-8?B?dWdCUnFxZGxaSVZsQzlkc1pNNUtMZXVIaVhyWUN5OE9XalRockRsakNJR2la?=
 =?utf-8?B?TGJmME02YzNXK1kyVnBoQnJVTWFNZmhxa1RxQ21LNUhmcWdyQ0JXdTlGeHFt?=
 =?utf-8?B?cklDT2h6V085YnVYeUNpVWU4Q1NRUzlnVUlKYllFclczVjlaNW5lc1hHRFE2?=
 =?utf-8?B?K0VrUDVZLzFyQjh4azA2UzNKUkRBdTIzeDQydTg1RjlNdTkyMUQ2ZWpJbEt5?=
 =?utf-8?B?LzAwRno5VDJNSTh5UWxPVUt3cnUyc2tSUFFPclhUc3FNZkl1ZHdZcXdQVG1L?=
 =?utf-8?B?TEdRQmxhalVJYThZT1dheTRWZkZ3NUR1dWRycWtMejhaTmdySUlCdUJHNVVj?=
 =?utf-8?B?SmJsMTJMU2FXTThDbVpJZnVZWk5JU3ZBNjY5UVNWMEhJY1BaYXkycG1MZE5V?=
 =?utf-8?B?T0g0YzVUeVhDU0xzMlllcHJJUUowdEZrWXhmMHVSR00ybGtBYWt0NWp2bXR4?=
 =?utf-8?B?T3FKRHU5dFpsR3V3Rk9ybDVWMXRueWxEZi9ZTjlYMWk2WnFDZzlSOVd5V1Ux?=
 =?utf-8?B?VVE1UHpzZzFBOWZybEVKMloyemh4Ri9FTk5JblVBRjBBYm9YR2lLUndBN1lp?=
 =?utf-8?B?RW1LNTZ2aXhBU1dheEtJVU9vVVk0cEVySG9vZkpYYkRrd3ozODVSRWV0Rnox?=
 =?utf-8?B?WkxFRDkrdEJGYXJDLytnSUR1T3oyTy9KMGJzdWZUb0dGd2ViNjdnUEVqQ2Rm?=
 =?utf-8?B?RjdmL2FqZDRINUl1bFZWNEZFV2ovLzZ4UjM5OFJlbGhIUGFkZGtYajdmelh3?=
 =?utf-8?B?azFtNzNaSUtxY09UOXkzejhONzZka3FLcFJoaWFiTHZYd2o0L0VoSklBUStY?=
 =?utf-8?B?alRibmgwQ3VnMHJ2dkJSUTkwZmpTMjBIcWh1UWVNWHdJdCt0SzhwdTdLdkpF?=
 =?utf-8?B?dllrTDNZUkpFQkdnbFEwK0xWN3RJVVRXQlpxUWRYYzUrTjhPSnVkdFo3ajYv?=
 =?utf-8?B?NjFrTkVCTmFmYTZObWRLbnRyMDMyU2FUM2RmZXIzckRWUTlYekFhTG9nTHBK?=
 =?utf-8?B?MFJtUDhOQ1pSNHVhcGlzeTd6RkV3YkV0VlltczNUS1Q5TnRhb1hRSHo0Vnd3?=
 =?utf-8?B?VDBwNTZqandqU3hMdnFwZmZSc1B1TDFjTnBGQ2ExZ2RuY1d6ZUxDWnViRWxZ?=
 =?utf-8?B?MzQyTXM0cmdoTkRIZGVOUldwenJORmsvaERlaHBwNTFlSnllWjI2c3pWc01l?=
 =?utf-8?B?QjhzL2tNL1ZjL1I4QUYxUHQ4MTZQejFBaWRLdkdxSmZiQkdyRzVnYmdrc29C?=
 =?utf-8?B?K0lmSWRVdjRFdVdhRElNMWk5WlZKanpXdGlUNGlqU0lNNFlYR3N0em5acExk?=
 =?utf-8?B?LzY3d3p6NVFxVXM4T1FzTHVnZTlQdXMrbzZZWnZWb0xyMFlGY3I5NXNmcTFT?=
 =?utf-8?B?TmtBZlYwZkNoQTd1Q1o5RDJtZ3hGbmszclIrNzNHZXkwNUVqNitpZWtLTEp1?=
 =?utf-8?B?WThWT3pjRElFL1I2Zk9sUng2b0VhKzRJRllUUlFhVm5jenZ2SUYwUVlNc2VM?=
 =?utf-8?B?akZacGN4TlBVWnV5M0NpMHM0R1M3bUh3Y0hLTXFpOTI1a1RLN1BmMi9VdzJj?=
 =?utf-8?B?OFRrdDdJRmNUM3F2cEdJS3E3Smt3a1VObDBjK0lCNmFSNjJpejc4Uk8zK1Vr?=
 =?utf-8?B?R1drUTF2aHd2UU1LV2VvL2ZadjVjVTNxNGh2NmJkQmJiN0tmUkluM04wUFcr?=
 =?utf-8?B?dnEzb2ZTNjFzNlBQdEY4Z29WMWxnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f30a2d4-4da8-447e-5a27-08d9be45559e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:32:05.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlSxCbpAqKiuPJZNfejEmUJzgto33lO+9d0ySxluzBgNOyBziPRx4zu1759UcRQ0ABsbTbWLTt9jxlxrRWnpiFKUhnwjbzKsTuBMwMJDg10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1933
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130092
X-Proofpoint-GUID: pbDDAzHJii-joGWGdHuiwd4lnQSYR1sh
X-Proofpoint-ORIG-GUID: pbDDAzHJii-joGWGdHuiwd4lnQSYR1sh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
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
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/arm64/Kconfig                     |  1 +
>   arch/arm64/include/asm/kexec.h         |  4 ++
>   arch/arm64/kernel/machine_kexec_file.c | 12 +++++-
>   arch/arm64/kernel/setup.c              | 13 +++++-
>   arch/arm64/mm/init.c                   | 59 +++++---------------------
>   5 files changed, 38 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17ffb..4b99efa36da3793 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -95,6 +95,7 @@ config ARM64
>   	select ARCH_WANT_FRAME_POINTERS
>   	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>   	select ARCH_WANT_LD_ORPHAN_WARN
> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>   	select ARCH_WANTS_NO_INSTR
>   	select ARCH_HAS_UBSAN_SANITIZE_ALL
>   	select ARM_AMBA
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 1b9edc69f0244ca..3bde0079925d771 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -96,6 +96,10 @@ static inline void crash_prepare_suspend(void) {}
>   static inline void crash_post_resume(void) {}
>   #endif
>   
> +#ifdef CONFIG_KEXEC_CORE
> +extern void __init reserve_crashkernel(void);
> +#endif
> +
>   #if defined(CONFIG_KEXEC_CORE)
>   void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
>   		      unsigned long arg0, unsigned long arg1,
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 63634b4d72c158f..6f3fa059ca4e816 100644
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
> index be4595dc7459115..85c83e4eff2b6c4 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -36,6 +36,7 @@
>   #include <asm/fixmap.h>
>   #include <asm/kasan.h>
>   #include <asm/kernel-pgtable.h>
> +#include <asm/kexec.h>
>   #include <asm/kvm_host.h>
>   #include <asm/memory.h>
>   #include <asm/numa.h>
> @@ -64,57 +65,11 @@ EXPORT_SYMBOL(memstart_addr);
>    */
>   phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   
> -#ifdef CONFIG_KEXEC_CORE
> -/*
> - * reserve_crashkernel() - reserves memory for crash kernel
> - *
> - * This function reserves memory area given in "crashkernel=" kernel command
> - * line parameter. The memory reserved is used by dump capture kernel when
> - * primary kernel is crashing.
> - */
> +#ifndef CONFIG_KEXEC_CORE
>   static void __init reserve_crashkernel(void)
>   {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> -	int ret;
> -
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
> -
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> -	if (!crash_base) {
> -		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -			crash_size);
> -		return;
> -	}
> -
> -	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> -		crash_base, crash_base + crash_size, crash_size >> 20);
> -
> -	/*
> -	 * The crashkernel memory will be removed from the kernel linear
> -	 * map. Inform kmemleak so that it won't try to access it.
> -	 */
> -	kmemleak_ignore_phys(crash_base);
> -	crashk_res.start = crash_base;
> -	crashk_res.end = crash_base + crash_size - 1;
>   }
> -#else
> -static void __init reserve_crashkernel(void)
> -{
> -}
> -#endif /* CONFIG_KEXEC_CORE */
> +#endif
>   
>   /*
>    * Return the maximum physical address for a zone accessible by the given bits
> @@ -362,6 +317,14 @@ void __init bootmem_init(void)
>   	 * reserved, so do it here.
>   	 */
>   	reserve_crashkernel();
> +#ifdef CONFIG_KEXEC_CORE
> +	/*
> +	 * The low region is intended to be used for crash dump kernel devices,
> +	 * just mark the low region as "nomap" simply.
> +	 */
> +	if (crashk_low_res.end)
> +		memblock_mark_nomap(crashk_low_res.start, resource_size(&crashk_low_res));
> +#endif
>   
>   	memblock_dump_all();
>   }

