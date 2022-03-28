Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2267F4EA17E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345861AbiC1Uao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbiC1Ua2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:30:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622CBC26;
        Mon, 28 Mar 2022 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648499326; x=1680035326;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IGVugh1HYSECR8TID8PYJHfQEpN1OL/PWVzCqoZqr7U=;
  b=fUo22G9SNPKKjqy9IgCpU7fPf5LImzQtOND50nBhGiKneu0+AtjPNYMj
   BLoXpDXvvp09bvgXYoG8VuxWhI8WuQUc8m5pT7lxHM9244bnPAJJaAi4z
   45SOW0eaEseqoCM3mxtbLp6JDrY0TDSMbOxLbg54J8C5fY5ZKZLa41cVn
   Oqge7l3z3rPqc4jOsRyIPKs5rqvkYGwNunkkFEE3fEGaOnJaVcgNReCgM
   DMwCBr1MAVO6dAC/XaKHvIVI8aSPaLurIB4rWpLTJEVMBpc5tPRtX8Tlq
   nUTklwJFekXHXybW17QyRNtMDkJawQgr74+g6ScE69VO1ECb/jrmFo/UF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="257925344"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="257925344"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 13:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="604293830"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 28 Mar 2022 13:28:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 13:28:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 13:28:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 13:28:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 13:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeGXsMfz1fIA1Wj8uX7W9IfuZTxm/2CTU3u8Xgb1JefBG++4WamTy7Ov/aQmYMI41WiTbG3bNhkeQe09W6PZfJawfJ/nOSd8F9IMb9oPENxiaCishw4oHm9zM4XlVroZasXiyW9NrCF2EpkF3cafCgosXkFAbRtFxRqBckTrQrzga/eec77yCXTDLWwMlDWdnR5gzVc7e5/X3VZtdW6CgIOou4mhhus5H8pHl6YvA+pYuFvolofZRQJL9ulb1/XPQ2QkYHWB0XIKxTTht2rnhUry9YjbA9/3W8Te8wa95GBE23oXh/45qXo+w9eT1SDUiOtTDa3LJk43jXVRkIX0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64fLRiPsWAH+P8CYeK1tOrk7b5WMZWG8XUHU/ZdGVYY=;
 b=UHvhwyVBKH2dcdJp5JGFGxcUwrcl5bOapMBSR7JsIY2UwleyftMl9NUy/0+KkRzhdLrxCk3TI46tWRjsBasU+kujZGbi6M46iYExjTUssixJXst4kyc0YLkUdkmFSsPI/kCtwdGiMvzlKN+QshCr2EVb9ZIdr19iBBXyeeL35m/1rWDxSwAc0soHJpcZ3YPai9uJz91T2CPS5rXnkstM2hMDJtkUWiRyDFKbeye4Chqcafg5tg+7f30WxWkt5ILCklikxcbMBxlzZKl3AXaX86yTGq9K2OFJzpvy++qzSrmCTJN49psNxiwubpx0AXDDG3AlP+kVG0pDkRC0y1RmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR11MB0014.namprd11.prod.outlook.com (2603:10b6:301:64::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 20:28:43 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 20:28:43 +0000
Message-ID: <e838769b-8b90-79f9-d149-e495667493b5@intel.com>
Date:   Mon, 28 Mar 2022 13:28:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH] x86/sgx: Allow RW for TCS pages
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220319163010.101686-1-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220319163010.101686-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f92eb39e-a2f0-4b09-8b16-08da10f98d3b
X-MS-TrafficTypeDiagnostic: MWHPR11MB0014:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB00140DA6FA3734C6700232A1F81D9@MWHPR11MB0014.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0Nc3Cy5rTLf0WLrhNtuvJ4zdUaAWzvAOBW+aSCDR80LfhBV1l1Fx5ztY2ggCuY0AQbXbxleOSttZWhD17uQNWIQazOu50a/5pYczjcQVgc2yCPZlwa63SS0NQPeTGExggtfLrsKr0MamX49dKSc1W/0AYRu+KWu/pOcaGWe9l6NPAuVBs2f1pfL2lYrVxoiAdbQqe8aEA1px50FUUnKevXT+H970/0DIFnj7BkdHSK0094A7MVqzAAX/KclXigj3B5cwvNF6ztysSF7asEO8V3jTjiBdBGnYNToCNt/Bvt00CCIHtLERdzx1GxINDt/sqeZrXBAVGk9AJrnMAzVAWCCjJSm19jZN8TAkf47RHeoRFfenQsA4be1wwBSEyI02YF/WIrjFyTinMb0D2uZ7gFaCEPd8SjV1hVLmvOnETJ4dCg5c6g7IH17jhIuRqlYqlcoFP/2RawVh4Dwmx3PsQoK5G5xMHh+QpuiRa1oKBxGyinpz1rXRBBT+vrJTMtGUVVMR+8s6GjbEg8YCQ66vSlZOoVVHDfRtZGyH9FftAPUtqexOY0NdRFkhKxDML61T74d/QEwnY6z3FZ/UfSQ/DS/UMnIE+1o9TZOdlhU2/GsWVWv+Oz5/xlpHMrBuxz8PwEFU9GzEiXi66ZvCLTKai7lfLUCnAFa7OmjZ3wAB16buCpElSYuAryOU/BrYVYGic2VTehxHJBR/oRGIFnrB4rHWcQowvG572F4ozhgLhP2sU9pL3RjgMoICLAHlCCj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6506007)(53546011)(6512007)(2906002)(31686004)(86362001)(5660300002)(36756003)(31696002)(6666004)(2616005)(66946007)(4326008)(316002)(508600001)(8936002)(54906003)(6486002)(38100700002)(66556008)(66476007)(26005)(8676002)(83380400001)(82960400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZOZlFpOUNVbTFSbC9KY29iWVNKVWk3TkR3Q0RoMFZ1TndPS3UxWW1jZjRF?=
 =?utf-8?B?Vzlud1QwN0ZKNjdGSkxkNFRkbDlJR0ZMelZJQ1ZjTzQ2aStLODNWcWk1K1pQ?=
 =?utf-8?B?Z0s4Vk9MZEI2YjZyYWZHTEpYUTN6c2pSMGpJTDQ1TGp4eCs4MWZwUUkyQXlJ?=
 =?utf-8?B?T1BvaUt3UmMrWmE1VExYQWVQcC81cGhzS2h1dC9IYVJxV2hicWRaazNidEhs?=
 =?utf-8?B?ZHRyMWtnVlBVL3FOemlhSXhFcUoxTFhFN3NDNE5tRnJocnBVVEVyRDYrWEFs?=
 =?utf-8?B?RHRvMS9RMU5PNklWeGdERkg4ZmxZSk9CNU9MWmVBWUVWVW5hc2U0VnZkMy8z?=
 =?utf-8?B?Uy9RbDB0bVlOTFpoa0N5cDNRN1dwVW5Zb2IzcEs4NjYzRExvN09lNjUyNEdS?=
 =?utf-8?B?a0RDVXFMcWN5cFNsbk9ZMnFMZ0JSWDhkY3dTV2RCd2R3d3NTZHVwdThmUk02?=
 =?utf-8?B?MlRuVDRsSTVuTEpyNXEyQy8wWUk1bVpGUGpmaEdQM3c1ZDFtbG5UZm9FTnR0?=
 =?utf-8?B?U2NvczY4elF4WmMyOHdJY01lTUVoYTlnQU41VVBZa3g5d1B3ZVZSZTMyWHI2?=
 =?utf-8?B?eFhwcHZac2x2YTZUcEEwQnZ1TGVESDJsOU5oNTBqbDFZTmVhcDBEK3VNTzNG?=
 =?utf-8?B?cEhjUDAybERnTTFhQmxTSGhsS1luWEtBWEVHVG5GSi9GUzFUR2FEM3haTWZS?=
 =?utf-8?B?L0UyZnlGMHJhR2ZTZVNRVkp5b2hTNFhDeGw0V3dBMDdBUVhZaCtKK1ZwSDNH?=
 =?utf-8?B?WU5uWkhWMEJ6MVBJMWVnRmd4cDloMWMwVyt2dmNFV1ZWRm14RW5oY3VFSzhn?=
 =?utf-8?B?ZUoyTURBSEI1VjVxSWtpVzlzQUVUZ3RJYStTRWFiWm1xNFEraytCb2lJQnBw?=
 =?utf-8?B?RHE5Z0NselgzTWtQaTRZYTE3Njk1SEFSZ2Y1WHN0WG40S2l0YlN6OENuYmRk?=
 =?utf-8?B?Y2hlaTg0TjlCNERRWk5HSjRpYm9VN3ROaU0rWDMxZkhIWFRmMTY5bWdOUWJR?=
 =?utf-8?B?QUZ6Z0F2a2hoTm43YkZqTFNmK1A1UDdNak82NVJQZnFHYk5MRU0vUGhHa3B2?=
 =?utf-8?B?K1BwN0FteGk3YVFORVd5MFFVUGhZeFp2OVd5cDNDNnQ5QmZnK25ocjZLU3FW?=
 =?utf-8?B?U08waXh4SzFBN3FvU0RDWDdieHMyZWh4M1M0WldyWEdjZHB2ZTYzSjBpSHBh?=
 =?utf-8?B?MG1RamNEUVRuRk9jTXV4akcxWDdjU0c2ekhwTEJmVXJ2dFdERDRQYy9RclN1?=
 =?utf-8?B?N3B0MWkrb01DSWI0RkIvUCtEYnVuUnJ4d0grM09kZGc3M2IzQ2dLVmI4MnNu?=
 =?utf-8?B?aUN2K2M1TVE0VkxydWtCS3FJSjRzdXNhVFZFcmpvY0cxWDdvTDVwVHY4UWsw?=
 =?utf-8?B?VVdOdi9qNEMxOWVSN0ZJbk5pUGRlYWRBTms2WVFmSThqVnZlRStuU0RBajNU?=
 =?utf-8?B?QmFIWW1GTGVVSWFha09QdlZEM0pVN1VQcVRtSEw5QldUQVV5TGs3cnpVeHJF?=
 =?utf-8?B?RnN0RGtNZkgwenkwWFdLRjBGNkExMXA2RnFoZ0JGVTBQWFFwWnJBMk5mYzJX?=
 =?utf-8?B?dUk1QkQvMER4YUZzQ21HckMvWExlWThjSmdNQ1h2Q3NwVVE1TGVNWTdvYVpE?=
 =?utf-8?B?M2FUekc3R2xFSVpmTGJpbFJIaXFCclFIUVdISUNPMjNHTE1GMGxVSmc0UlZp?=
 =?utf-8?B?L0dod0Y5c3RJb1Y2M2hyL2xFUDlBcnUrcjVFZzVtV0hnOXEvdmNrMnRvejZy?=
 =?utf-8?B?UnhMaWpYbEtrdXNRR2pHcS8wQzRwY2x5VHA1WXZqczJWcldma1pDY2poUmJs?=
 =?utf-8?B?SDEzR3lmRDNSVjI3Sm5MT1FyNllsVUNzYXd3cXpNaitrdXVaU1BvOVJxQzlS?=
 =?utf-8?B?eXRkTGl1OGd6Qkpma2NiY0Q1MkdsWXZSZUhaSHdNNXBlWTFDbExSOFRvck83?=
 =?utf-8?B?aDV5WkUzRXZDdDRtSktRa1JpS29rcU8xVFNpNEhwN1c4eDA0c2NsNWFKL3dX?=
 =?utf-8?B?RU9FWkkyRjA2c3lhTUR6d2xmUktCUGtEQ3pzY29LemE1MGhBZnY5NjlYZ1hY?=
 =?utf-8?B?WWNETlFsc0k5KytJc0V6Y3I5UVFkNm5DL1ZweXJTcHNjSlhrZWgycUZMd2Nu?=
 =?utf-8?B?UDJ3R011WFpxWmc1UEdQckNOUUp2UjdueEdyWHZKcER1VlRsVG5kT3dEOEhO?=
 =?utf-8?B?QTl3ZlloN2ZhTDZzSU9vTmhMVGhINGNFNlJqekJscXZ1K3NvNGFPMTMxMlgv?=
 =?utf-8?B?REJ0N3ppcWtSWkE5RGNueW5NNFZobEtDZncvREZSejhRaUwwZ20zZGltQmdR?=
 =?utf-8?B?dUtSQUtMOGJiZ0lIWmx3Q3MzMDBySGRLUEhhR01jaUhTRkpmbFRZejR5Y1RJ?=
 =?utf-8?Q?vBDczyZA5FCf94ks=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f92eb39e-a2f0-4b09-8b16-08da10f98d3b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 20:28:43.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siL8q6h6wTMSB8ZwH3Z2rICbotCgRjbWgewH0T8r6kyQK9zSG0pRb+gdM7Pz2S0oxmG8iz9BETcPF/1PJvcC+504WWC7zn3XC4FLODj0008=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0014
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/19/2022 9:30 AM, Jarkko Sakkinen wrote:
> Not allowing to set RW for added TCS pages leads only to a special case
> to be handled in the user space run-time. Thus, allow permissions to be
> set RW. Originally, it would have probably made more sense to check up
> that the permissions are RW.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 83df20e3e633..f79761ad0400 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -215,7 +215,7 @@ static int sgx_validate_secinfo(struct sgx_secinfo *secinfo)
>  	 * CPU will silently overwrite the permissions as zero, which means
>  	 * that we need to validate it ourselves.
>  	 */
> -	if (pt == SGX_SECINFO_TCS && perm)
> +	if (pt == SGX_SECINFO_TCS && (perm != 0 || perm != (PROT_READ | PROT_WRITE)))
>  		return -EINVAL;
>  
>  	if (secinfo->flags & SGX_SECINFO_RESERVED_MASK)

The comments above sgx_ioc_enclave_add_pages() seem to indicate that zero 
permissions are required:

"A SECINFO for a TCS is required to always contain zero permissions because
 CPU silently zeros them. Allowing anything else would cause a mismatch in
 the measurement."

Reinette
