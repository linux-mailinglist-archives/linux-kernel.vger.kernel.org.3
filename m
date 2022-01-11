Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2A48B05F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiAKPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:06:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20866 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243838AbiAKPGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:06:50 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BD7KTT021033;
        Tue, 11 Jan 2022 15:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=g+tGlQexhz+OVkLyDt2RdgP4/0dzItLYLb2kTn494Hw=;
 b=HsrV9lRyqQdab7QPt2RBuBQmNfy+KGdC50K3jdJkiTeC6x9clwA7j1MZaOUIfmnEjuSN
 HfoNmotCYMMvWMv7btT/D/wKpLv1QVNcEO6g5GYHlwcxUN01Dxj/LD/XJ46EcoaBVCLT
 6uG+0SEjK6/2w9COQtLbuOVfyTA7K+fsl14HFilRcKqGrrnARBs+sLn1ELMaiOpWWWW1
 8km2GneBCCtt3I9UU01gQyygGQjGo7L5xGPMp049oso4jhIUyeKyuL/E/PBUwo00k7hz
 5UKacYhFQHCWb4zL8uFFcsEEat1nIvCt4Wf4E4bAcRZgK7NIeMQBXuRVCCPy8BlPNPNs 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nk5dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:06:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BF1xdY065658;
        Tue, 11 Jan 2022 15:06:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3df2e4w1sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdAx9vqjeE+EhUn1BFbogrU9AiBC3esBOrzRwN74i+2/IhA/Y59LPhRW3h5Bt7ENoWKdlOG8x4mSRUISmZy3LQxQb64FKMbaD+iXQishMSFMpbkT3KIQLJ2ovoTNI+O0kKlSfXPwv56F7hPqcfls5y6QN2vdpROe2LX1ynP2UEJps09HCG+E+uMOYOd0BKy6hlzz01QpmkzaWKMUrO2kMVi/IH7FgrAV0dcEs4Waw2mSXjSWxfZNTr9hOLxHN6XdVtHCEJ9I/m/TxC6P+W82weRbxCEahGCXvUBbLGs9e9NeryQFGUkL5lI/3nJnvJEsZLxSZdI0Ss0MjJATytElOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+tGlQexhz+OVkLyDt2RdgP4/0dzItLYLb2kTn494Hw=;
 b=DPUkFT41VF1K++hXncQkbV7/9IlzDhvxEaeiBnf1OsiEANu6E2keGlpkfGDTYkvdSP36vjGM7g+ts8Uww5chjKG4wfqOx/WpShY2u7N84UXCB9wdoVPHzKxjVVsPDy27SSJia6AN1X/ufRRF0KaGukPTmsYFEy8UbizlcjQ3fdA8TL3bRXiiHSkApoVPH6BQA3SPEqR5unCU1G/dUdDSX3BN8tvtQNnxfRc8NVElyFgqSrJl70z0qJG1RwGR+sMrLh81kib+Wu+kU3Ey/XLbsPbClUjtdk+uWsCuilm482yXmhJouQMk7ZyapiIz0f8IAqOgKy+GTZHRkeff1m3MvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+tGlQexhz+OVkLyDt2RdgP4/0dzItLYLb2kTn494Hw=;
 b=TBGa1AYEQ5s2Q+7JHx/7e95J8xS00EsYCENMxLZIPFJ+RX6UZogXMpWCu7LtZ2bZX9NztuLTrw5V3IZjVTDYT5BHAjwZyMIfqOy1CNVNym9mmNyEeOid1om8g4ypNFFWK2ZSIaG6+WdUhpY++xeCkXoZgAb6fstT1NRvZ9sa82Q=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4803.namprd10.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:06:17 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:06:17 +0000
Message-ID: <36952970-6ce3-e17e-7997-3fa7e8f6307a@oracle.com>
Date:   Tue, 11 Jan 2022 09:06:00 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v19 05/13] x86/setup: Add and use CRASH_BASE_ALIGN
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
 <20211228132612.1860-6-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211228132612.1860-6-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6124ef66-0da3-49ba-1c31-08d9d513eac1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4803:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4803CE0068821D25174D068EC7519@CO1PR10MB4803.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKIxGO8ieRZOzrtqR0MUmgh4HtT5fvsZgruCwOCyVuONzBfmRymsOKgbF8zetBwiZj7POfdSrbKVCdIOiLCqJA5FvdZI/wVyk5nbrUvGgGEvDzmiz3NxpOlhMjMeTObHkSvTlbn6Pbta1uj10gGpHo83uQK8ye6dtEpdgH8LqWSG+mC3AuzTl5edYonJJSRKbH/t1a+YDZSUR4D7aXBLl/ttpAfFiKpSVPXy43sNUWgK2x4lfzl1MDpbgcVAUjDpC6h5Fug23jJNpu96H0n26yUlX6cqwt7CG0ZfTl1KjB2QA5fPViZgT90qrELd1oIVEvMKeVBJhxogP2uFW7y4buiIxx2SBDTyYuF/OZX8kLVooG0LWvvxbXbENgT4cTHjao+e0q8BSEhkRmC726yHgkq21BAUyCp0SuR1gm4Cf/sNm5oRdIVsg3lT1/iSu3whmfg/biejPgse6iN6oe2Uy53KLO/et3EW6h6YLezr0dIeH/DmXRX+m7SDTBYB6MJFlxM/+h6tLOOD5ML4sGke57Yc4jwFtjoVvl8Au4ruaCkDqUeJ/ofwp3oDrIb+pllokgWNXbqT6GGhNruIcglUARdpyh+9IgyOcJrwcavhm8+6e6YmdksLJLEz9aavmqgjdTLmnhhuaArIj0293bZVQMGwGQNyZH52+uOd9McJzLpcrHCStXwBm0B/oPjgEiTGVhJDLZJd6gjsncKTKz0xP2Kb/NIVuJZ+hp/VBJlXdTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(110136005)(6486002)(2906002)(5660300002)(2616005)(66476007)(921005)(508600001)(66556008)(316002)(36756003)(86362001)(4326008)(9686003)(38100700002)(53546011)(6666004)(26005)(7416002)(8936002)(8676002)(31696002)(6506007)(66946007)(83380400001)(31686004)(186003)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkE5cGQ0bmJyTjY4SnpvNXhGUnFPV044aTduSzRQd0REZkRvTHZzSjJHYlRK?=
 =?utf-8?B?TzkrR2ZPYXZEcDVOckFvdWVXUkE4T1AzckE5TURsU3duNHNaRDB5ZytVSTJR?=
 =?utf-8?B?WUhackFRMGZ6NVRXZ3dNY2xWek54YnRkZUd4eTNneUx5QVV5SHJVd3lYVVdt?=
 =?utf-8?B?WFZjdE9kT2JuZHU1c3lSODA0NG02cml3K0h0SHZ5TGxra2FsTVhwVWQvZ09t?=
 =?utf-8?B?MmgvUE80N3hHODg3WVRKMEw4SWhnN1hpVVRXeTY4dXlHZVJaS3V4ZlFGbXI3?=
 =?utf-8?B?MXhSamMwZnpleDFnSWszL1VkMUw4N3poN3lIWFU0SzJ5SXlicEhpM1JKODE5?=
 =?utf-8?B?OTVtSWYxY2RFSzlqM3VFMllMOGZXNWtqSlpyanZCTnp3UStUWHYvU25qYjQz?=
 =?utf-8?B?NlZUV2h2WC85SzI3R3dXWVhwUE9vRnc0NHpsMXNMdjRpMVk1VFZLTGxhMmVP?=
 =?utf-8?B?S0YwS2hDN0N0a1hlQUl4cmo2aERrNklPeEppS2pDN2JEbkU5SXlBaDZiVEdZ?=
 =?utf-8?B?dllUYjQ0dFJzVm9jWi9RQ2V4L1Ayd1NqOW5YOUJVSGY2cnh0UDlYMHBKU0tQ?=
 =?utf-8?B?dHBYUmpmVXQ2dmhJL2NhNnczRkx6TUFDeWZ6a2k2em1RZlBFdDJ1S0RybTgr?=
 =?utf-8?B?c05CL2FCQmhPWHZuQ2cyV2d0SWlQaUV0WXRCeVU5U1FtRVM3Rm9vcmN6RnBQ?=
 =?utf-8?B?N3BjWFZjdVVIQzhrZ3pEWFdzWFpPOGFvd3dYNDk5QitzRW9rTmxFT0lFZC9X?=
 =?utf-8?B?MStydFpYTlpOeWY0RUIwcnVxTlowNkZHM3MyeWFZS3JSR0QxcjVNdWhLOGpR?=
 =?utf-8?B?RXVQN0lxaTgyN1VjWENaR0ZSTjlKdE1qdS94T2RtRTlvdWFkbjhOZmdFRlBl?=
 =?utf-8?B?YzdReWhZR3c5WERudW9WSm03eWtmOEdoNERxN1hPdGdhMWhqV0Zxc21mT1FZ?=
 =?utf-8?B?aUlYRHFucTB1KzMyMnRJM0xNK3Fuc3h6ZVNoUWNxNzFGVmlQMElabElnNUpW?=
 =?utf-8?B?aWwzTHlJY1hIcDdoMzJKRnlIcmdRY3JaRUlGMDB4UHdNTWtIL1RUZzZFWHVl?=
 =?utf-8?B?Wk9UbE80NDQzY0lIb3lQYmFRUkRZb0VBSzVTR3FBTzJSbU5XSHQxOVUweDZZ?=
 =?utf-8?B?dVN6U3FLNEtBUlkvd2Z1ZU04TGNhSU9GZmRBOURNY1dzUmRyamgzaWJlSFVt?=
 =?utf-8?B?ZVV3Mk4vc0xWYWNWSTJxVXBxWkxhK2pSNVRHb2hDNHhqMi84NFNpRmNXMUVU?=
 =?utf-8?B?dnAzU2RFY3IzTFEyV0ZLbnFFSE1oRFMxYVI1TXo2VW05K3k1UXZuUTR1RU1n?=
 =?utf-8?B?UUE2ck91bFlyM0VSaGZxVE5WTmwwelU4SEtheFhrZVI0cnFPb2NzSGErd2dH?=
 =?utf-8?B?UlpPOElaTUFRcTdZWDJyRm9HQTh3K0Q5UWFXSDIzakFDWFhyQSs4em05ZWd3?=
 =?utf-8?B?Z3crVDJlQjNKcFVtNFlUbHpNeEo4b25jMC9tZlhIY0FCcExLMW1jcDRuQkdN?=
 =?utf-8?B?Um9jVFljbFdYd2ltRlVKUm44NllXTnhOcjA4SFBVNEluWVpycnJaWSthUUJq?=
 =?utf-8?B?UkNFUnFNWlFla3RUTlJBMEI0WVZob2IwMVFzMGdiQ3VjMmpjdlpua1VBUnhO?=
 =?utf-8?B?Q2Fud1o5aTU1aEpldHZyYXY4RkNubTdiOEhxdnp3ZFJyekwvbTVOQVVsUmVU?=
 =?utf-8?B?RGw1bytOSlB2VG9NekpDTkpsVzFNNmVJSFNUbTVrSTBzWFJMdk85QmFYRU5w?=
 =?utf-8?B?Si9Rd2gvWUdlQjlWalZ5ckxtOEp3VzhDdEJScDdZUlZGYitMOEgyNTQ5SFUy?=
 =?utf-8?B?UU9wdmVodXQ4Rzl3NFdKWEVKM0Y1VkVKSzAwODBSVjdSeWhueWJ2Q21UYUJn?=
 =?utf-8?B?T1Ird0NwTERFVUFuMmhKVFhhS0pnY1I4NTJXbGhSbGZqMGsxZjRmOTllSDhI?=
 =?utf-8?B?bHVzVzkwR3B6RGRsdHVtVCtlZmxpS2FDdmxKeGtTRzdhZVFkZVBkbTJDbFk0?=
 =?utf-8?B?QzE3T0FhM3daKzVYdUFjK2tGbzA3YThXczlWeDdic092b044ZGZmNElBTmg4?=
 =?utf-8?B?UlJ5MFByb2h2RzRLeER0SVRPeG93UE1ZR0tmd05KTDRIb2pqcy9jVVRXODNF?=
 =?utf-8?B?eXBFWTBQRnZMVU9BakFmMWpSUUREdURHTElVbDc2bS9Dem10cTdQaE0xUzhW?=
 =?utf-8?B?SDVvcndiZ2U5SS93TkkrTXRvcS9pWVpDMGJYR2dTTzVJS1lodW9EdEFta1NO?=
 =?utf-8?B?MlRQdjRCNjkzR1VWUlpyU0ZwRGpBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6124ef66-0da3-49ba-1c31-08d9d513eac1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:06:17.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1CejtDhMoUK3INo8Ra7d+P8uCZB/1iJGZsdCt58Z68UPPLCzgziB5dxZW8IxRoUEd1yDE+HR75VIERNZK9sHaOZFulMVy+/hhPCMlxmU2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4803
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110089
X-Proofpoint-GUID: nG9KeLr2EMSc6IbXDe-O40HR6aA4q4qN
X-Proofpoint-ORIG-GUID: nG9KeLr2EMSc6IbXDe-O40HR6aA4q4qN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Add macro CRASH_BASE_ALIGN to indicate the alignment for crash kernel
> fixed region, in preparation for making partial implementation of
> reserve_crashkernel[_low]() generic.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   arch/x86/kernel/setup.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 93d78aae1937db3..cb7f237a2ae0dfa 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -392,9 +392,12 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   
>   #ifdef CONFIG_KEXEC_CORE
>   
> -/* 16M alignment for crash kernel regions */
> +/* alignment for crash kernel dynamic regions */
>   #define CRASH_ALIGN		SZ_16M
>   
> +/* alignment for crash kernel fixed region */
> +#define CRASH_BASE_ALIGN	SZ_1M
> +
>   /*
>    * Keep the crash kernel below this limit.
>    *
> @@ -509,7 +512,7 @@ static void __init reserve_crashkernel(void)
>   	} else {
>   		unsigned long long start;
>   
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> +		start = memblock_phys_alloc_range(crash_size, CRASH_BASE_ALIGN, crash_base,
>   						  crash_base + crash_size);
>   		if (start != crash_base) {
>   			pr_info("crashkernel reservation failed - memory is in use.\n");

