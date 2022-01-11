Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4048B065
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbiAKPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:07:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32412 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240517AbiAKPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:07:25 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BD7IEZ018283;
        Tue, 11 Jan 2022 15:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s1BlHz67XT4KoNKLeymwUZ2Oa/9z3Kk6NJR6qfcUdKU=;
 b=slmvn9MXpJjXk9iii8C5WEKa6UWv6Aorx5buY0oBocMvTK/kcAkt6vx2F2NB5iJgP/eN
 p2egcvqfn2qkTpwhr7esKnv3Xb2tHDly631PHiNuO37pzrbzpD/UvxFOAKINMMI49V60
 uBaxO+Un4+tfNPSqnYLFZO3sdHDaNGy/bYBAJpoRQZCLD6Nz2pvLbe2D7ystCR+UMiCk
 4vBbL71gsemYi+B+/jarQkfr5r9/knpYEIO2INQCApOcR10MNJ44QtNuWr1aEivnZSys
 DH8OqxCbfmtZ+O70RoOt9nLJA+0llNizN+FMDE1O05beE6dNPLn0QKXen7CkWZ6QVcTM pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74b7hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:06:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BF1cVd183806;
        Tue, 11 Jan 2022 15:06:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3df42mvjdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2QkZbdkdruuCjArVgDQKcd5bXg4C06k1eq3pEb2bBoglg6qbbaTHieDAEB1fTTrp7lhO4TsZGF16MHEhEpXs1ObTE22plzwj3rflMWFGWr5gxPmwKSq31RTbDyCNpnwevOFdsdVF59xLXVpB84G1tNUTwFT+9/jrNVdTSv45Kv4C1QXUUuoMxQpZkmMbwxhI9ns10fzMKD2WJ3zMGzaqTYdBtQs9oPOA5axiDVSY8o23KQTTc7e3dhBcalc5sncpdaHCAurL4kUE7+4t2y3nqD1/D32oIJCi1JGY0a+FD6pdvrDlSdQyaCIv0fRArwN4sESfSczDNNcUeqkElhjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1BlHz67XT4KoNKLeymwUZ2Oa/9z3Kk6NJR6qfcUdKU=;
 b=NNtwwLhPoF0sYQbyNdYbozIqWfaKFxvneP0bbf84YH6mw7vPVpgR9/HYcVXcfgp5KNM8GlviOLnsofcGmnOZpqCPJPAb9Xl3UXNujguxSDK0hUGkzm+VycYVXwQQWgeeVMh3pN/CrLVtHx+7Sp6vDo6s3QFRRnze2WJ1n86Oxa2fXlMmvKWQbdL8poKFFW8t4oi3pOg1EueTq/qhAAcJDPDBnXJpsL2w64SuuwjBcn9xIVp63keP7hD+/6sK+nkcb251WrVWkWnTxQb0OQxnKNdLx91xn4Ptha+6spP5yMWesoQrAHAMO4IJJnqowSbg2N4SAg91BBAp/AjZt5bfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1BlHz67XT4KoNKLeymwUZ2Oa/9z3Kk6NJR6qfcUdKU=;
 b=lLT8qp8gwWDvmh/CRa1jSsLXvCRHiHiSHaCCYlBUsqAf6+e+LGpARoKNh5ZcHfsZJothP2J2EE5s67qJzf3J4fief29foOrec03SbpBvCEP+IRkgiYQY01wHrJsknX2Vw1EJTSpy4KyJsCDO7h5QOcovsustkMiKJudORjqmiLc=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 15:06:53 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:06:53 +0000
Message-ID: <f376978b-095c-7ddd-54b4-1d6d91b3a00f@oracle.com>
Date:   Tue, 11 Jan 2022 09:06:37 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v19 06/13] kexec: move crashk[_low]_res to crash_core
 module
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
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-7-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211228132612.1860-7-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0026.eurprd07.prod.outlook.com
 (2603:10a6:200:42::36) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79f8b021-3249-4774-8c70-08d9d5140026
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16955F854C4D96985F02D3A1C7519@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5MNG2AjQEVuI/O+0aTY5rZXvQQUC/ynEkMuOjqRe+JI8kfjjr+OtfL9hE7wEX4sGuvWOP3z6hFmcQ2/7ftVWgUWFCxH3CfhUJ/ZVkDd9TQBfWFxK/0tD80LpH82y8R6YMU/hEfILTlpGr7NpMlnVQvF8S9nAVJsObYg7YySus3xx6q1lm9k77xqr7FnzwkDehqMwJ+cBfX6GjmH+pTlDz9C9VaaS3NLhLCLGDty6m/nzdosxoBme6jiZZ/nS+EPqLpCq+cFIg7dIXAkJBHFP9al/FQaZkxKIxufDdjklJH1nQcfiH1fTxoC0upiKOnkW6hn12lOVg6ZFEeteQbC9jRFw2tc6ya7M0Lb1cXlyC2LZbD/jDicbxzbaLGCbajOs4hmRv/xIL6kJwkn2QJdBQUdY8d5EP2XUxjwYG5YW6Z5bYxN9+gyTI1NpP+NRQ4wipl8l74fVWr31s1u5I6reZtO8az0tE90sOmcLf7rrp4nCDX4Y5YUGYmP+GhgTUL8tTl1KgXzCkqwRb0Ep/J7TZAsXK4UcSb0Y/fsN+mimpCifh9x0WhHBxg07899j6CbB7v6VFlkk+3tfGuCZVVZX8aUw8+cMTb4lh5iYz5doh/NRaR52hMNjI0oJ8NwpgsKEOw5pzcHWjRJmIccAG0z5cDzzLk6eTCwK3x6F9PXwR6GsiLH9GniAf7eoG1JJQ2vOTNrrStG1afisGpFtS9IsMu5x263gSQRQKbfqzkBOHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(53546011)(6506007)(921005)(36756003)(83380400001)(31696002)(186003)(26005)(2616005)(6486002)(9686003)(38100700002)(6512007)(6666004)(8936002)(2906002)(110136005)(7416002)(4326008)(31686004)(316002)(66946007)(66476007)(66556008)(5660300002)(8676002)(508600001)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhycWM3VlJJUjJoWTBFcDVIWUNTM2ducGlkNVNrRHZqYjhBUEw4YU9kTFh5?=
 =?utf-8?B?NHNhaDNnM1RIY3M3MEFhVGhRUkVkOVpKM2pUMmVwYWFUZEtQcVBGNXVLMFFO?=
 =?utf-8?B?K1hxazZLNkFzNy9JMld6bDQ0MXV2MlZmMTdiNldoRmpWcUhteTFOeFo2RWQv?=
 =?utf-8?B?Y2RoZDdsNVh3MUczUWliV3czM2UrMXpQNHFndUJoUEFxU2YzcGhOMENOK29r?=
 =?utf-8?B?dmx6eU4wbG1wclB4KzdiV3NXOUlJR3NDSmRMajVJMFJrZGhTaThsNTBCclE5?=
 =?utf-8?B?NkhDQ1U4MWliOWdpZDBtL21hZWN3UGQyQ3RBWklkNDhrY005NzRIUXF3ZlVV?=
 =?utf-8?B?UFRyWGJHbDVMdHRrWk45YVd4YnhONUVQZ3RqcEhLb2Q1dWRuZUk5aC9YQjQw?=
 =?utf-8?B?ekYvMjlTbUh4cFROc2JCNUFUeWF2aitxdXFCcC8rY0VEbnUwV2x0QnU5NEp6?=
 =?utf-8?B?MUZUK2w1dkp3YTBrendDQ29CZ3VwMlduajFUdW01cWdXOFVpSWR4TGU3WEFQ?=
 =?utf-8?B?WGJ3K2kwNm93OW0xWmV3bkJJWThHeHIwZkJHbm9YN1p4YnY1cSs3SXdmZlZv?=
 =?utf-8?B?QjNrUy9Gbk0yMUlhWDVEbHYrdXNIZkpnMXhya3YxZi9hVHluRWJUMUNiVXNa?=
 =?utf-8?B?d0MyRkh6LzRZY2RUTG8yZDN0T2Z6MzdlUXBESTZrS3Q1NUNsRmcrZXI1RGZo?=
 =?utf-8?B?WDYyZ2NzdU1ZSW4wZmVzWCtUZEEzbk9uaG9jQ2FiYnU4L1FUMjNYRDhnMWd0?=
 =?utf-8?B?S2MzZW9IcnVPZGpoR2lTNkU4SnhzTFdCTCt4aEhHVGpXLzdSR0VYOEtoQlV1?=
 =?utf-8?B?T0kwVU1OL09rbWlQUHByV0lZcmN3Vzk1MGlub2tSQnJET3FZUWNMSHdOdTBk?=
 =?utf-8?B?VjJZSmp5TllQNGRpbDhVOEptSXVPajBHNWZzSlBselkxZUZJREFkZStOaU9C?=
 =?utf-8?B?YUw0ZjdEYTJQcHk2Q3U0NWNlblhyN2FDWnhHSTN6S1ZjWFFBcklXdlRCTjQ5?=
 =?utf-8?B?bUtJdXUxVjVPelhiQ1d5dzZqbXpQdndlYk9IMG1EYW15Z21wTnp0ei9QZEJY?=
 =?utf-8?B?dGluQ3BOMWI0QjRCV0ZveC82N3NTZmgvMDlqVE1pV1UzMGZkcGtYNnBsVmRW?=
 =?utf-8?B?bHN6Y1R6V3BGYkJVS3Z0WjA1T0xHTUswSGFRaWV5QUl3elJLckhTb2NIT0pD?=
 =?utf-8?B?T0ZjSXB6NXdwcGtoSDhwcjBKTCtFdEU2L0IrZDR2R0VHTExVQy9wZUJyRDdy?=
 =?utf-8?B?bGVyRmVXMnllTXBPbGtLWFpRd0l3Ni9SOHU5MWNOQTE0dkZoN1hkN21aTGJy?=
 =?utf-8?B?MTQwZnVweTd5TC8vL3VuZDUyL2J6YmptUFNRWjNxbWNzSVo0bDNISnJIZ09a?=
 =?utf-8?B?WHVXSDdCdkQxUSsrYXpxU0wwNWMybEhlTjI4aGF3alpMeEU4bkJ1Ukt6cS9U?=
 =?utf-8?B?dlZWdlQxV3V1NklCRUx0TkU3VERiZzkyeVc4K2dnZUh2V3JLNW1pd2VML3d0?=
 =?utf-8?B?UlhlSHhYMFkzZDNNSGhFUWI1MGlOdGtTell4V2lCdzFoMXZ5eDJEcFRySVZl?=
 =?utf-8?B?UUNTWTBsTVdDUmx6NzFEaHVML0xNUVNMZEllWnN3OHRKNHY5V01OMlhlQnd3?=
 =?utf-8?B?ZUU5SXBjTzFwVDB4MllyL3RHSVRFVE54dkhuZnNISDM0cUN2ZWVDek80Mkli?=
 =?utf-8?B?ZUszcXlZaVM2NUVidSsvU3I1bnMrTk0vOE01YTVLM3gvYzlMZ3B0L3FoM3Bl?=
 =?utf-8?B?dkc2dzRpTG1Ha0pjbHBONnZVYWlLTDBsVi9EU1Q4Umc4b0NoWHRXQ3Z2dzIw?=
 =?utf-8?B?QTFBS2oxeHpaU3NQWlJjeHBGbTI2Uk1nek9SbDI1UTVXS3B1ZUgrV1kxUGM4?=
 =?utf-8?B?V2F2akpjNW5EK2hva2NuenJ2anRmOUoyeXRZcnRtMDcrTGZLVVlCZEx4SnlB?=
 =?utf-8?B?MzQremkyRUF3TmlVeWVsMm0xb3FyWk14SE5PVjJQUDh4YmxTeXBFanJ3UVFo?=
 =?utf-8?B?OFh0elY2VUhsMC9sT0Rhclc0NGZRazk5c3NFVGt5T2JSV0V4cGdqVXlNMG1G?=
 =?utf-8?B?c3F2Q3pCUjBOYUpvMW50VVBHWUNYN0hPQ3Bhc2FRelpTUGp1U1FwcXlOZjJ4?=
 =?utf-8?B?TkdremNZUlBOSWVDY2lFQVpuOUh3Q1BVQURSUUhQVXllUXNObjdVd1V2alds?=
 =?utf-8?B?ZWw4TXIxWE95alNDaDJvVnBQeUdKaHlUOXdidjV4aUcwd1A0VXRRNHY0SXEw?=
 =?utf-8?B?RUNoVjZTZmVKbTJXb0NER1dJVk5RPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f8b021-3249-4774-8c70-08d9d5140026
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:06:53.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UY6T9kCPI04UBj08zmi/k/7ibT4YR5f5FHBWHAt5zANiyUkN7eDF2iUH04dFOe2jkKSZrh+MjLwuVATSwXZOwksd1a9gwl710jj+su95QvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110089
X-Proofpoint-ORIG-GUID: 75_f1IQNOD_CiIF8mvQNlzMBMtB5VG5c
X-Proofpoint-GUID: 75_f1IQNOD_CiIF8mvQNlzMBMtB5VG5c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Move the definition and declaration of global variable crashk[_low]_res
> from kexec module to crash_core module, in preparation of adding generic
> reserve_crashkernel_mem[_low]() to crash_core.c, the latter refers to
> variable crashk[_low]_res. Due to the config KEXEC automatically selects
> CRASH_CORE, and the header crash_core.h is included by kexec.h, so there
> is no functional change.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/crash_core.h |  4 ++++
>   include/linux/kexec.h      |  4 ----
>   kernel/crash_core.c        | 16 ++++++++++++++++
>   kernel/kexec_core.c        | 17 -----------------
>   4 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 598fd55d83c169e..f5437c9c9411fce 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -73,6 +73,10 @@ extern unsigned char *vmcoreinfo_data;
>   extern size_t vmcoreinfo_size;
>   extern u32 *vmcoreinfo_note;
>   
> +/* Location of a reserved region to hold the crash kernel. */
> +extern struct resource crashk_res;
> +extern struct resource crashk_low_res;
> +
>   Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>   			  void *data, size_t data_len);
>   void final_note(Elf_Word *buf);
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729e1e..47e784d66ea8645 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -350,10 +350,6 @@ extern int kexec_load_disabled;
>   #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
>   				 KEXEC_FILE_NO_INITRAMFS)
>   
> -/* Location of a reserved region to hold the crash kernel.
> - */
> -extern struct resource crashk_res;
> -extern struct resource crashk_low_res;
>   extern note_buf_t __percpu *crash_notes;
>   
>   /* flag to track if kexec reboot is in progress */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b7d024eb464d0ae..686d8a65e12a337 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -22,6 +22,22 @@ u32 *vmcoreinfo_note;
>   /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
>   static unsigned char *vmcoreinfo_data_safecopy;
>   
> +/* Location of the reserved area for the crash kernel */
> +struct resource crashk_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +struct resource crashk_low_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +
>   /*
>    * parsing the "crashkernel" commandline
>    *
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5a5d192a89ac307..1e0d4909bbb6b77 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -54,23 +54,6 @@ note_buf_t __percpu *crash_notes;
>   /* Flag to indicate we are going to kexec a new kernel */
>   bool kexec_in_progress = false;
>   
> -
> -/* Location of the reserved area for the crash kernel */
> -struct resource crashk_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -struct resource crashk_low_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -
>   int kexec_should_crash(struct task_struct *p)
>   {
>   	/*

