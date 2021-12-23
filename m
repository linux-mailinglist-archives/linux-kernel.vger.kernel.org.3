Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F9B47E54A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbhLWPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:01:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49640 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239868AbhLWPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:01:21 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNEiLPp008916;
        Thu, 23 Dec 2021 15:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qkqiJSFCa6Su5NQ+PFN8e5X28c25p0IeYGEzYkOcRe0=;
 b=HZWR4nmH9/1fmdcxsu8vSQ574MoIlvVQGgsqVKIu0G1dqbGgMNIXOdtmrTjr0KKMxdfA
 /evdyGDTPkWspCZx3SjV8nu6GESUbqI6v/gvQiv8phaZFVTJKx/v/n6MjJMABJ8IXJOD
 32EpdWBUsoeNhgmQTj7Q5s42RqFuogoKYK2rPB13xzFc2eX1iZJgsiGj8jXx6aWEBFuZ
 a14W2BLEtRxvs01ZBRYpdjCw35vLoUSxc9CDjIAO/GLpOD1JnLS1wsRsU4GQTQy/xrPE
 2O7RtSubrEqw00dI6VRavKm6cxruVM6daBNKftXSkQ4xwsXmG3wAtSVNMAS59XZHONl6 hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d4maw8va1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:00:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNEuZPe090910;
        Thu, 23 Dec 2021 15:00:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3d193rraph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0xM4CHg60DvDEa3FwBBAGPYxjwBE95t7B3j/7WM749RqcI4NUqWXD9tx1YbmM3euy6wg0Y1gCO0EWsukvEFA9ykZEqiO+kPIxzS6TEgEWFyAa6CpEsIZMtLHSqnMnsr9CoGZXpBdBmpaMKFk9NjaHcHa0k98JV7DoiowU/Qeww1nXOw5NTC+uYII88avJUccDnPUbHBnaA6/+hTVj9+mDhZRBmB9BcofA9JVu3VFW173DZ+EUohcKmQeFwTjxBxcoeY3Rc37M7qKkOBofQi2WWWerNlpA8CRD0A7vyXh0BEB5TIHsdU08XK/dVtJ8fELTXD6xEDFv3f5wrNIw95YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkqiJSFCa6Su5NQ+PFN8e5X28c25p0IeYGEzYkOcRe0=;
 b=DwYSxdHpSR1Nt15sfA1frE2wiRo/8cA7jB2uwaNmcaVS7DANcDjROg7lB8H1TcXs2TkVErrjgQDsXiQtprTBql7NE3Y/j85UyqcDrgGSyuQI8Je4xlVqgZFRglFuNJYcqHvLuVLThx6kfVqxHGgj4CLiVEvVYxVzvRtfAA5l3F+KQi5FIB3HKSfXoKc+QnTYrDP2vBWyxgueo6tRFeBEFuZFprrceSnSlY/uw/TMjqHzK/6lNpIE46LOKz2/gy4m7b2cWaBroydhTyigMw27mxztCmjMY5pZh1Yhi7oOtsLV5FFo010/M5+uv/NuVOCCwT2eOu5fUknkneTSf2tSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkqiJSFCa6Su5NQ+PFN8e5X28c25p0IeYGEzYkOcRe0=;
 b=t/CAVwlVIYn0P61+DeReOmqdwToofVbeTac1otYs6Z6yfaDfL0dy8uIkVMianrklaIoNwnB5sA5vRruihlI5SngBTPLY4RYYv88Ef5Y60rZHcIZiuDdyn44J25oFOEh7IR3zxJKPiBLzfI8tn4C1VtOBPZtYHXmihuAWGNzFZok=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO6PR10MB5458.namprd10.prod.outlook.com (2603:10b6:303:138::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 15:00:31 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4801.020; Thu, 23 Dec 2021
 15:00:31 +0000
Message-ID: <beb50d46-e3ce-92fc-98b8-ea8c8222bd04@oracle.com>
Date:   Thu, 23 Dec 2021 09:00:20 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/3] mm_zone: add function to check if managed dma zone
 exists
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, kexec@lists.infradead.org, 42.hyeyoo@gmail.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com,
        x86@kernel.org, bp@alien8.de,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-2-bhe@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211223094435.248523-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0357.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::20) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98cd9e20-7766-491f-4a93-08d9c624f720
X-MS-TrafficTypeDiagnostic: CO6PR10MB5458:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54589D0ECF2931CC9F8A9ACAC77E9@CO6PR10MB5458.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emk5BQSMDDiPL5HjdT4/qqK5x3qF3xnfRx3fPSJPCr7yzOeH7v5IaTdEeqFgplsqYs/wds0Bu5lkZo7zhbQaw8vsQ43mZgoGBHzoUW4MP0gXdbt/7oq0pA2I3rX18VPHTQGGaTc9Z7dCDIjutr7rUANebRJRgo0dL3+aRioX1kAgYhAUKDAelswdreEU0IYq6j7NAlbQfBqked8CzGO/iqZXsI8OTML1IGORozMALS/iOHOPqb/urvhSp9DtfCXvEQ1BT3yQStSAaIV7+Tvz1y6U7owqkjKW7Rn1+7C0iXO5lckcYIMz0FaZ6sOddx1TxqypRGfubzfasHRqBhRCMJB8xJtkFDFO+Lmvio7sw2iuoFbzCagx3CohsHbqF44iydgWZ/THZQCRyS8tT4pBDCavWcGU5IJWU5WoaLXeEvP2g8KXY8Scd9cAfaRIiTh03WL3aOKOrFf16xInhiRNkQuuxYfUAKx2grBnRxagq9J7XCw2tXGwYweYtSQur1mz7EHzp0EReEAtH2wmQOJy55O3oYrO0ji0vQrDMyp4TjjVoJNR8NiXWzH9gWEBFLx5SweYdtJfKPyT/kBN5p+1DoyDICA3AlETj+BbLOU6anOBTeMxTVY6iFhuOugf8mnBDNd3RV4XwKnsmiNSlc08iZ/yi3OmyT/DLm34cWMuqR+JsEJYubM5B4rmAafHoU5dWWJfkeuwenWGSi7kORUaQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(9686003)(6512007)(4326008)(6486002)(38100700002)(107886003)(86362001)(66556008)(66946007)(6666004)(2906002)(66476007)(8676002)(8936002)(2616005)(7416002)(31696002)(26005)(508600001)(5660300002)(186003)(36756003)(6506007)(53546011)(31686004)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGdSZ1ZwVVRyZytUTDMvYS9lN2sySkxUUWV6UDlZQ29veGVOUHFnVUgxL2xt?=
 =?utf-8?B?T3Q3WEtUZTlhMkNvaVJSaTV0ajFSWVhRZVZkT3h1aWxKV2lwTW1UVkNFMkRw?=
 =?utf-8?B?ZXh5WFovVUV0MTMvUHpUQ3hTWjlHMEFjZTBBS2dpdis2a0dCUCt1L0g2akdY?=
 =?utf-8?B?Ykt2d0E1Zm02YXErZW90ZEJFZHNuTW5PUjNrZm9PdUxTT3RQT2dVUkhOWVQ0?=
 =?utf-8?B?R0p6NHJqVVhDNWdVN0laUDU1RERxSGQvR3l6Q0Q1NWZqOG1RMG1LY1A3VEJD?=
 =?utf-8?B?M3lNSFIyVjI2TUY4MWM0aG1CRmxDWm1rQTdiZXFvdEVndXdvTmtUck5NRmQy?=
 =?utf-8?B?WTVLQURIeFcyTGo2TGVzQlNmRGdTYjVlZnBNV25EVGs0OTI5SWNMWXhpZWdp?=
 =?utf-8?B?VUdOM0dTMUpUTGNNYnR6UzVDUE5iR1Z4YzlYbXovM253UlBHUEhFRjc1WTg3?=
 =?utf-8?B?Y2tSaEZ2bkJtUzFQL2xMeUg2MCs2S1pJTGZlNlNsSnpzUnV6aTNvaVRMUmNl?=
 =?utf-8?B?MVdlaEdRQWNjZzNhcTVwY25XcFYzNlY0WjNkNkNPWGdkemJ1b1BZQ2FRSHNz?=
 =?utf-8?B?YU1mU2YvYS9lTkZEeTBLRUJGNzhhVGNLTUNGcGJFS1NrZ1VjbzFXMTIzWnQv?=
 =?utf-8?B?OXZwY2ZjcHoxNUVzb1kzUzRGbmp3TXhTdU9yb0lTcmRic1ZkSkJsSWtxTTlZ?=
 =?utf-8?B?SFY4RnRrY2hGaDFIOVdyQXVvczBIa0FCaEF5MS9VaWY0VzV6UU1MZ21Nai9q?=
 =?utf-8?B?dCtJSUo5UjY0OU5qbnVIYWI3NzUzVklGUXlGL1VPVnljYnEvOEEyYTFxbUJT?=
 =?utf-8?B?SFZLei90Qnh4WEdnN3RTZFQyK1IrZi9RVEV5VmNTczk4UWtKRVNWcFgzYUlq?=
 =?utf-8?B?b3pSTzVhVkM0YlRQLzArMUh4QXpONzV5RkR1WGJpeFhCZWV0WFZ0K2ZCWjJw?=
 =?utf-8?B?RUpvcTUrNkg3NjhiQlFqQ0NmYnJBK0IxbWpJUWRETU5uajVwczBaaG5VamNP?=
 =?utf-8?B?TWpoNHJlZHBIb3ArWmpVM2FKYzE4K3MrbmYrNTJMeDlsSHFrNHpjWTVmZTJx?=
 =?utf-8?B?VHlRazJDVXJKeklIMm11ak5vOEJSaGFzUXBnTHRZWCtrWHdUdkplWFB4Zkx1?=
 =?utf-8?B?cDY4VEhqdXR0QzJja1hqSFFJS1dKRU9CSkdIQndidkF6KzFTQWY1QmNGZ2Ny?=
 =?utf-8?B?TjByR2pNSmxNL3BDYVpTSFJkUElkQWErM3U4WWsyd2J1RjZSc2JZY3crcStm?=
 =?utf-8?B?cnhYVTIwT0ZtVmE0Z3NwanpBT0pRdFZUem1hYkhxekZlZFpya3ljbkxkcXpz?=
 =?utf-8?B?SHltdVJJSkd5NjhQOFRzUjVDRStNck01cVFheHZ2MHArL2RIaFR3VUQxNHB2?=
 =?utf-8?B?TksxNWl1cWNMbGJFdTZtWEdHS1o3TjFMZThvYnVkSUdaZ2RQKzFJem1YazEr?=
 =?utf-8?B?UlFqdlJNeHdvcGhhc0R3djdPYkZjbnREamhyQ2trTGJXVGtBL0hRMmd0WWFB?=
 =?utf-8?B?VDRCYmpUaDVNWmczaitwT2pxTi9VSnJvQm9ZVjZsdGtEYTI5TnFZcStMVERX?=
 =?utf-8?B?T0owSTFUa2l2UEtLWmQyWWZNRmtLWmY1eDlUd2MvMVRnV0dLUlJJWUg0c1Ju?=
 =?utf-8?B?U3kyQnhtdnpUZU1YQzNjZTBIUW1QK3lkTGZwaUNYZFBoY2FjRHIxQjVXMDJC?=
 =?utf-8?B?YXozM2xmMDI2OVhVemNMQWhHVEJWUk9aZXJZamdYMzByVTg2bzg0ZkFscVU5?=
 =?utf-8?B?cnlvVUlqeW1wVVZKQnVmaTV4ZDZ3b0JybWUwcDA3djFYOE9IM0NMUlo4dEcw?=
 =?utf-8?B?eURuQnR4YkQzLyt0Ymk0dERaWUoyWnZxaGZZSHgrSnRWMEVXNEdRc0QrUFU3?=
 =?utf-8?B?L2RsNjAwUS84a2tuaGZ4RkY5ci9MTEdrNkFQenNMUWh0eHhtL0NEQm9JRjJU?=
 =?utf-8?B?V01oaEgyVSswY3Z5K2YrbnpCM0hlQUVXTVBkREVUUXlJbzNlQ09QSmJTcTFi?=
 =?utf-8?B?WGwyd2ZmSEphV3RQTis1VXFqWDdhTWtmQjJJK1E5MjdSU3BOTHpnbGN3OXVX?=
 =?utf-8?B?di9peHpHR3p3Q1VaLzhLTVlxdXJZUlo4NzVRMll1akFxS3RBTFlBTUxsellP?=
 =?utf-8?B?aW11YkhWZ0p0VGEwTUNUZWg0dlk3Z0NnR1ZGOStCdkk0K0F5aW1zNVVOQ0cy?=
 =?utf-8?B?YjdxS3UwN2p0UkgyWGFMK3BHSTY1YWxtYzI3MTV0ZVgvcHIzVm9oZUllOUNh?=
 =?utf-8?B?Uk5yRDB3VVM1K2JRdjNjd0RkRmNRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cd9e20-7766-491f-4a93-08d9c624f720
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 15:00:31.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQfTWmQhpk2FxNYHSrEN1egCGi4wTXfsGEvjg7tjdja8xlFc4mK3PLUENJhl5lT0+G2tSbfK4qw2WBTiDBfTS0W6ur8XpZYTq62dz1qJGyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5458
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230081
X-Proofpoint-GUID: DVByPfXiCysPSGh9AGJp5J4I-J3TIbK2
X-Proofpoint-ORIG-GUID: DVByPfXiCysPSGh9AGJp5J4I-J3TIbK2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 3:44 AM, Baoquan He wrote:
> In some places of the current kernel, it assumes that dma zone must have
> managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
> E.g in kdump kernel of x86_64, only low 1M is presented and locked down
> at very early stage of boot, so that there's no managed pages at all in
> DMA zone. This exception will always cause page allocation failure if page
> is requested from DMA zone.
> 
> Here add function has_managed_dma() and the relevant helper functions to
> check if there's DMA zone with managed pages. It will be used in later
> patches.
> 
> Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/mmzone.h |  9 +++++++++
>   mm/page_alloc.c        | 15 +++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..6e1b726e9adf 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1046,6 +1046,15 @@ static inline int is_highmem_idx(enum zone_type idx)
>   #endif
>   }
>   
> +#ifdef CONFIG_ZONE_DMA
> +bool has_managed_dma(void);
> +#else
> +static inline bool has_managed_dma(void)
> +{
> +	return false;
> +}
> +#endif
> +
>   /**
>    * is_highmem - helper function to quickly check if a struct zone is a
>    *              highmem zone or not.  This is an attempt to keep references
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..7c7a0b5de2ff 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9460,3 +9460,18 @@ bool take_page_off_buddy(struct page *page)
>   	return ret;
>   }
>   #endif
> +
> +#ifdef CONFIG_ZONE_DMA
> +bool has_managed_dma(void)
> +{
> +	struct pglist_data *pgdat;
> +
> +	for_each_online_pgdat(pgdat) {
> +		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
> +
> +		if (managed_zone(zone))
> +			return true;
> +	}
> +	return false;
> +}
> +#endif /* CONFIG_ZONE_DMA */

