Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BB4565DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiGDT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiGDT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:26:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2401958B;
        Mon,  4 Jul 2022 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656962786; x=1688498786;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TPDphj8TfmcM9VKTxqqa+ytMkY+reRi7GaH45JOjRn4=;
  b=BWZsCctO1efIC9wRM8F+5DVBOUvaaRRWo6WK6hIY6iyeAQKOFFc72qta
   DvNKJ2FTS5Ye2Ibx6RHWkfY6YoO5ECcMEaolv81lSNhOYKHfMsGM1WTeX
   9wqWMiUeE84EBaATDbS0qWl45ACTA/zhOX7DupcZvdapHHwJZ+IEBI3rV
   ubjszfLZSiTTzCXIf6O+rG6734bPiBC4rRYgL12U1P5d0XleHh3Pg4nyO
   OhPLTFI2d7ifT+Dv19ySfmiWeLxbrWFawba+aETQDjdccCypDE3TaLR5O
   FeGxXXwy6EahxdjpDVMVOL3XdUjYK4t5T5YAIbTFCoSp4LSo1ds0ywvSL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="280741587"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="280741587"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 12:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="619405431"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2022 12:26:25 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 4 Jul 2022 12:26:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 4 Jul 2022 12:26:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 4 Jul 2022 12:26:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA75IsqNYq/VXtTuP2Ouqrh9gAd++0Qzyym92pdFk0uj1vBm7hpqESTk544+ZfLp9LAXkR48AsTaC0kxTXrPiUn5rMlk8GXy9Imkwa51aqAEgCOK6QYPRwzLAve50rxi7JF1w9mEALkZlQwbe3cip5C87H0gqbrgqhYDvHEOr7pOraaU8C+fbWUDYSYXkSovUMgYCZSf3xMIi2LQixVASiy9MkEGdI2nVvT7T9NYz0IzoD+mRowxl04I3OKLGt9u8qXkdPV2hzXa/54+wK9WFjhIotoBpmBodN3/QskRNsr4OfDanO9XgUR2QkOxK9Do14vGgy40mfejjmnJQK651w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slvXgEnGqG2Z4z80/vj+5kpRonoKd4jloyDtn+6taPI=;
 b=K4Wkzmwe7eD/hVA9BRCVCUfBtL7NoxlJR1gK83o/6zps/Prvq/hwE9DMcgNhuFs+mnFAzkfgMF2i64Nl5lzcoBK4YXFBbF6pFgg8LQ9WESx4d3xQ3mgKw3kd++A/X4584TxcDrzSco/DUDqLKMW78MoP/kk8pO9PfKODDUnx/iGgSKrHInxgW8vDAycu8s76R86ry3EEIU4UzqLQyn5r1E6Z1ajR30z+j6G93lDOlAysAukZJj8d3CIQTEF8HcpFWAyhtg/W+/bSXPGAfnkWydso6YaInRoVaWjP72BpmhKobeZ6o9Q2R8kzoSLinU8ppsSic0dQ5HgWxWfRst5Pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM6PR11MB3451.namprd11.prod.outlook.com (2603:10b6:5:5b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 19:26:23 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 19:26:23 +0000
Message-ID: <3110c8d7-87ab-13e7-cea2-dcac25f2be70@intel.com>
Date:   Mon, 4 Jul 2022 21:26:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ACPI: acpica: acmacros: fixed linter issues
Content-Language: en-US
To:     Javier Abrego <javier.abrego.lorente@gmail.com>,
        <robert.moore@intel.com>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>
References: <20220703003014.52949-1-javier.abrego.lorente@gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220703003014.52949-1-javier.abrego.lorente@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::6) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f4aa83-d25a-440c-91a6-08da5df314c6
X-MS-TrafficTypeDiagnostic: DM6PR11MB3451:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beIVfRjpTv6q/tqi++hBbaTN0SdmVLqM9tbRzgFPy0BtP/pZJUpusFPQyiR8jFOiF68cS61rjQAOnkw3WNPK+4vGwoCd7/4QpTwAf5Lgcrv3U/yxEQN0pPt2blUufIUaigcWO/RbbDdbMTf997Qog+VWO2wO3RzelPw1a9h6cRlRFlGX1cqRv8523dYz6ulLe5ZP3fvOmVmmRwjL37Z4C+WlgLTjdXa8m3qddL/tPg6vgLuk7Gp897Ta8h/k6gP0CONMYujw6RTlFFuWiLqNV5xt9s+iPKVqyhmAv1HISr2j35fY8Kfnmx7bvs7VrUeEcvzdPCPHmRyBxD4UoMQlSsNJBbzpd6IMTPbApE2DqNyBYKVOljVobNcA2Fibs57wHCHA0TCb6dmQwii6BSDAJbLWdLJe3MyemPwgydvfWmqCVKzKwgMgG/2ipxXxW5WFgparhaRFlkLtf8W7b4/PRSSjxFoQMb9vr2bWwz4fLSgeO7zIe98G9CaGQKIGu9slIbldaJ+HdG6d1f21XLzazzA4HGkz0rntjOgv3qmx/nRib60VWYG0MF4NS6O+O3CcEToFBqgtAeOgsOs+3mJtuIcuzoj6TgLXt6kdr7E6ZM1+ke0DnbHAKfZDdbPsqv1pm1AhMgI50GT9lSBk4GIYTSqi4XPQpHPCbS+zhI3ipifTdozr56Drc33goIxYkO0QkmC+gROj8v2FwV+G3oDYHckqdfSByAXxllSJAlBIbYezuFs25gibW1VREWcx2usm/Ovj1+9+VKAoUP3kzwwWhKORZIa7nyS2CHbB81MAUoRXqcBeptLQIFOHO9pvZBMd7jg/c23Pj9MsIVexBmt2/trbmFBQmCJR02LErmUnA24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(396003)(376002)(366004)(30864003)(2906002)(8936002)(5660300002)(186003)(36756003)(83380400001)(86362001)(26005)(38100700002)(478600001)(6486002)(316002)(66556008)(66476007)(66946007)(6506007)(82960400001)(41300700001)(6666004)(36916002)(6512007)(4326008)(53546011)(8676002)(2616005)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZwUk9WT0lMN3l3d0NVeVVWYzVxOW5XY05MeUdSY0ZuNzlBQTVrMllvb0x6?=
 =?utf-8?B?Njd5eXRFWHdxNVl5OG0zM2doT0c5WVJZckpybTVvWWMrM0xNakpBZ2dFbm5H?=
 =?utf-8?B?R2hWVjVmNVpNYjdOaWJlejIrakdxUmZPQ2kxN1JscnF3WjFiTmI1TGFYWFZC?=
 =?utf-8?B?OWRZNmZocUFIaG83QmRybFV0Nk5DMnQ4WlJ2NCtXRFVKKzRlL2VNKzEwTy8v?=
 =?utf-8?B?TmNuL2ZyS0VnZjlLNG5NaExPMTVHVlB5VEp5UVB3d2ZENnJkWTZRR3VYWDY0?=
 =?utf-8?B?c3NyUzZGbmR6TzFBRk41UUVCUmI2aytybkdhZ2NTek96cXZyYmI1c0RvT1h2?=
 =?utf-8?B?eVZzaTRXZ1FBa1N0Z0ZQVE1JZDZHc0RnN0l5dkpHdUY0cWcxSlFSSHNObjNk?=
 =?utf-8?B?RmpRMWlUSGZEaG9DOUhqZDNuQndWY3RCTVdRbktlazZTM2dubVpabkh0ZWls?=
 =?utf-8?B?SlhGU3JJUjNDb043SEY5YUptc2Frb3c4QnFtQmV3RnZaS3ZvYVdLOFlyc3VO?=
 =?utf-8?B?TVFDZnBzclpKK2w3MWxiQmYzSm1lb1hIMFpwaVM4RnV2ZTlqZkNDbjB6YnFp?=
 =?utf-8?B?RHM0NTlFb0d3Ti9OR01tTjFtOFFMVGloeU95TkRaRmlHay8vdGJleURlM2sz?=
 =?utf-8?B?a1NVVVhKTTBtb1VWb1BjeXVNdEU2KysxZk9QZEV0bkNobDJtbHowTGc3VmZ3?=
 =?utf-8?B?dlpveExuelVjcjFaQTZNdVFEMHVDYkl0UE1SOHZ2QkZnK0RyQ21udkpGNmJF?=
 =?utf-8?B?cjJtYWJ2QWZNN04xTXA3NFR6VnpqcjBnTXJYVENEQ1hwM0s4WWFlSkZmK1p0?=
 =?utf-8?B?M3I3V2NsWEV6WU9jZ3F4UWdITGlrOWNmOGVmU1ZmTytSaFNENTJROXBEZGZQ?=
 =?utf-8?B?Tlh6T0dwVE5sTGxGSUtrODhTOVEyNnp1ZUx0RjR6cjAxK1NjTFNScENWQVVi?=
 =?utf-8?B?dnd0cDVUR1R4V20xaHVqRmUzbmo5cTVELzJJOE1MSG1aR1pwQXBIdHVhNmRM?=
 =?utf-8?B?VndMeEhBcHVxSFhFbjBsVjk3K3N5eVV3Q01LaVloQncvM2JUU0hXdjVQbFAv?=
 =?utf-8?B?K0R3R2NramVqbDdEZzhLTDRDWDM5YWJuTEpHNGZDU1cwM2NKSFJnWHd2QVpP?=
 =?utf-8?B?M0RVUEd1KzFtMlpoejJ4Nllrek43MnQyRHRqQ0pSTHdNQnpHbnlWM0pOeVVI?=
 =?utf-8?B?SFZrYlBZNXhuM1NvT01jMFNVY1dLNWF6L1VRSVp4MlREOGxaQytrNTJYQ202?=
 =?utf-8?B?NUhlTjBmT2ZOQmVDbUFKbi8wcS9WUStnYk0reGZnLzY0RXhlOFo3QlBPZUtY?=
 =?utf-8?B?cE9tK0RzUzFTUnJ0b3FNa25hTVV6dEgvdDBoUjJFTjV4cHd1VlVMTTRtSy9K?=
 =?utf-8?B?cHlzSG1Jc0VJUlgvdXlobW5zK0dEL3RwSkRKYVVhZnJ3ZVRxWkllelBRMFYv?=
 =?utf-8?B?Y3ZScnZFbXFtRHhJckliMkNaM0hDRmJxTlg2c3p3blI2S1djaWV5ZWtLY3hw?=
 =?utf-8?B?VmxzVnAwRU5oRFBPZ1U3V0JlV0lCdWF1Vk53ZlI4Rm9ubUw2SGV6Q2NxVmJF?=
 =?utf-8?B?SmpjbEZaSlRVaEdaMklTTG5rN0lpU09YTHlaR2MxcFV6dzhYdVJCd2wzdnkx?=
 =?utf-8?B?Sko2Yit4MXFwVWlFekZtZ2ZLUVl0Q1JqU1BCcjE4TlhRbXFyNnBBclhGOStp?=
 =?utf-8?B?Nll2SkJFL1duSmRGdWZxTDZKTTRmMFBKNWVuaFJuVksvck1xUWNmVjRFTTRj?=
 =?utf-8?B?dDR5eHJRd3ZWOUFDa08wOEp3alkzRENFSVlod21iYzV3Wk1DS1Z0amZ5SGtt?=
 =?utf-8?B?NmM3UTFqdVZNcE5QeGRrL09ZN1JYclh1NzR5V1dLSVBNOEM1ZVRaZW1xU2ND?=
 =?utf-8?B?SFoxSFRmRS9kSC9NUyttTDlISFpBV3BXNVYybnR2bm9DYU1Zdm8yT2JmcFNY?=
 =?utf-8?B?VWIvMGhpeXBBT21ESnQ3SUhhRUxuaGppbDQ5dkdYK1NjVjBpdXRDeVFjbWYy?=
 =?utf-8?B?QUZ6UTgreXFVcXc3WDRJRHArR3c1NHJFMGthc1V0b2tTKzBwcVdrdFVFeC9B?=
 =?utf-8?B?MG1mR21XYlhYWnlTN2ZWaXpEQllHNVFTaHZyYzNicmg0VFV3bkJ4bTcyWXg3?=
 =?utf-8?B?NFc4OGtkUitNcnpIV3FUbmVJVTkvVnBGa21XV2FuS1YrQVlyVm5vOXllTHhO?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f4aa83-d25a-440c-91a6-08da5df314c6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 19:26:23.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndGxX/iaiscq+nhPYTyUF1uJ4YDg/13LevgkNsEc0K2wbXcNYt6MBvqv2VvO7tlepX2+GhUF0Y0jH9b0YHINrwQtLHF2Pnbl/f8wEq+8cKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3451
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2022 2:30 AM, Javier Abrego wrote:
> Fixed a coding style issue with the linter.
>
> Signed-off-by: Javier Abrego <javier.abrego.lorente@gmail.com>

Please note that ACPICA code changes need to be submitted to the 
upstream ACPICA project on github.

If your patch is appropriate for that code base, please submit a pull 
request in there.


> ---
>   drivers/acpi/acpica/acmacros.h | 212 ++++++++++++++++-----------------
>   1 file changed, 106 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
> index 2f3e609df..597070cde 100644
> --- a/drivers/acpi/acpica/acmacros.h
> +++ b/drivers/acpi/acpica/acmacros.h
> @@ -15,18 +15,18 @@
>    * get into potential alignment issues -- see the STORE macros below.
>    * Use with care.
>    */
> -#define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
> -#define ACPI_CAST16(ptr)                ACPI_CAST_PTR (u16, (ptr))
> -#define ACPI_CAST32(ptr)                ACPI_CAST_PTR (u32, (ptr))
> -#define ACPI_CAST64(ptr)                ACPI_CAST_PTR (u64, (ptr))
> -#define ACPI_GET8(ptr)                  (*ACPI_CAST8 (ptr))
> -#define ACPI_GET16(ptr)                 (*ACPI_CAST16 (ptr))
> -#define ACPI_GET32(ptr)                 (*ACPI_CAST32 (ptr))
> -#define ACPI_GET64(ptr)                 (*ACPI_CAST64 (ptr))
> -#define ACPI_SET8(ptr, val)             (*ACPI_CAST8 (ptr) = (u8) (val))
> -#define ACPI_SET16(ptr, val)            (*ACPI_CAST16 (ptr) = (u16) (val))
> -#define ACPI_SET32(ptr, val)            (*ACPI_CAST32 (ptr) = (u32) (val))
> -#define ACPI_SET64(ptr, val)            (*ACPI_CAST64 (ptr) = (u64) (val))
> +#define ACPI_CAST8(ptr)                 ACPI_CAST_PTR(u8, (ptr))
> +#define ACPI_CAST16(ptr)                ACPI_CAST_PTR(u16, (ptr))
> +#define ACPI_CAST32(ptr)                ACPI_CAST_PTR(u32, (ptr))
> +#define ACPI_CAST64(ptr)                ACPI_CAST_PTR(u64, (ptr))
> +#define ACPI_GET8(ptr)                  (*ACPI_CAST8(ptr))
> +#define ACPI_GET16(ptr)                 (*ACPI_CAST16(ptr))
> +#define ACPI_GET32(ptr)                 (*ACPI_CAST32(ptr))
> +#define ACPI_GET64(ptr)                 (*ACPI_CAST64(ptr))
> +#define ACPI_SET8(ptr, val)             (*ACPI_CAST8(ptr) = (u8) (val))
> +#define ACPI_SET16(ptr, val)            (*ACPI_CAST16(ptr) = (u16) (val))
> +#define ACPI_SET32(ptr, val)            (*ACPI_CAST32(ptr) = (u32) (val))
> +#define ACPI_SET64(ptr, val)            (*ACPI_CAST64(ptr) = (u64) (val))
>   
>   /*
>    * printf() format helper. This macro is a workaround for the difficulties
> @@ -51,31 +51,31 @@
>   	 /*  Hi...Lo                     Lo...Hi     */
>   /* 16-bit source, 16/32/64 destination */
>   
> -#define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
> -			  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
> +#define ACPI_MOVE_16_TO_16(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
> +			  ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0]; }
>   
> -#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d))=0;\
> +#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0;\
>   					  ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
> -					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
> +					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
>   
> -#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
> +#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0;\
>   							   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
> -							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
> +							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
>   
>   /* 32-bit source, 16/32/64 destination */
>   
>   #define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
>   
> -#define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
> -									  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
> -									  ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
> -									  ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
> +#define ACPI_MOVE_32_TO_32(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
> +									  ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
> +									  ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
> +									  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
>   
> -#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
> +#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0;\
>   										   ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
>   										   ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
>   										   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
> -										   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
> +										   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
>   
>   /* 64-bit source, 16/32/64 destination */
>   
> @@ -83,14 +83,14 @@
>   
>   #define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)	/* Truncate to 32 */
>   
> -#define ACPI_MOVE_64_TO_64(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7];\
> -										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6];\
> -										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5];\
> -										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4];\
> -										 ((  u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
> -										 ((  u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
> -										 ((  u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
> -										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
> +#define ACPI_MOVE_64_TO_64(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7];\
> +										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6];\
> +										 ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5];\
> +										 ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4];\
> +										 ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
> +										 ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
> +										 ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
> +										 ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
>   #else
>   /*
>    * Macros for little-endian machines
> @@ -127,35 +127,35 @@
>   
>   /* 16-bit source, 16/32/64 destination */
>   
> -#define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
> -										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];}
> +#define ACPI_MOVE_16_TO_16(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
> +										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; }
>   
> -#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
> -#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
> +#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
> +#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
>   
>   /* 32-bit source, 16/32/64 destination */
>   
>   #define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
>   
> -#define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
> -										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
> -										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
> -										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];}
> +#define ACPI_MOVE_32_TO_32(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
> +										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
> +										 ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
> +										 ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; }
>   
> -#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d, s);}
> +#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d, s); }
>   
>   /* 64-bit source, 16/32/64 destination */
>   
>   #define ACPI_MOVE_64_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
>   #define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)	/* Truncate to 32 */
> -#define ACPI_MOVE_64_TO_64(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
> -										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
> -										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
> -										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];\
> -										 ((  u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4];\
> -										 ((  u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5];\
> -										 ((  u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6];\
> -										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7];}
> +#define ACPI_MOVE_64_TO_64(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
> +										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
> +										 ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
> +										 ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];\
> +										 ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4];\
> +										 ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5];\
> +										 ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6];\
> +										 ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }
>   #endif
>   #endif
>   
> @@ -164,7 +164,7 @@
>    */
>   #define _ACPI_DIV(value, power_of2)     ((u32) ((value) >> (power_of2)))
>   #define _ACPI_MUL(value, power_of2)     ((u32) ((value) << (power_of2)))
> -#define _ACPI_MOD(value, divisor)       ((u32) ((value) & ((divisor) -1)))
> +#define _ACPI_MOD(value, divisor)       ((u32) ((value) & ((divisor) - 1)))
>   
>   #define ACPI_DIV_2(a)                   _ACPI_DIV(a, 1)
>   #define ACPI_MUL_2(a)                   _ACPI_MUL(a, 1)
> @@ -232,64 +232,64 @@
>   
>   #define __ACPI_FIND_LAST_BIT_2(a, r)        ((((u8)  (a)) & 0x02) ? (r)+1 : (r))
>   #define __ACPI_FIND_LAST_BIT_4(a, r)        ((((u8)  (a)) & 0x0C) ? \
> -											 __ACPI_FIND_LAST_BIT_2  ((a)>>2,  (r)+2) : \
> -											 __ACPI_FIND_LAST_BIT_2  ((a), (r)))
> +											 __ACPI_FIND_LAST_BIT_2((a)>>2,  (r)+2) : \
> +											 __ACPI_FIND_LAST_BIT_2((a), (r)))
>   #define __ACPI_FIND_LAST_BIT_8(a, r)        ((((u8)  (a)) & 0xF0) ? \
> -											 __ACPI_FIND_LAST_BIT_4  ((a)>>4,  (r)+4) : \
> -											 __ACPI_FIND_LAST_BIT_4  ((a), (r)))
> +											 __ACPI_FIND_LAST_BIT_4((a)>>4,  (r)+4) : \
> +											 __ACPI_FIND_LAST_BIT_4((a), (r)))
>   #define __ACPI_FIND_LAST_BIT_16(a, r)       ((((u16) (a)) & 0xFF00) ? \
> -											 __ACPI_FIND_LAST_BIT_8  ((a)>>8,  (r)+8) : \
> -											 __ACPI_FIND_LAST_BIT_8  ((a), (r)))
> +											 __ACPI_FIND_LAST_BIT_8((a)>>8,  (r)+8) : \
> +											 __ACPI_FIND_LAST_BIT_8((a), (r)))
>   #define __ACPI_FIND_LAST_BIT_32(a, r)       ((((u32) (a)) & 0xFFFF0000) ? \
> -											 __ACPI_FIND_LAST_BIT_16 ((a)>>16, (r)+16) : \
> -											 __ACPI_FIND_LAST_BIT_16 ((a), (r)))
> +											 __ACPI_FIND_LAST_BIT_16((a)>>16, (r)+16) : \
> +											 __ACPI_FIND_LAST_BIT_16((a), (r)))
>   #define __ACPI_FIND_LAST_BIT_64(a, r)       ((((u64) (a)) & 0xFFFFFFFF00000000) ? \
> -											 __ACPI_FIND_LAST_BIT_32 ((a)>>32, (r)+32) : \
> -											 __ACPI_FIND_LAST_BIT_32 ((a), (r)))
> +											 __ACPI_FIND_LAST_BIT_32((a)>>32, (r)+32) : \
> +											 __ACPI_FIND_LAST_BIT_32((a), (r)))
>   
> -#define ACPI_FIND_LAST_BIT_8(a)             ((a) ? __ACPI_FIND_LAST_BIT_8 (a, 1) : 0)
> -#define ACPI_FIND_LAST_BIT_16(a)            ((a) ? __ACPI_FIND_LAST_BIT_16 (a, 1) : 0)
> -#define ACPI_FIND_LAST_BIT_32(a)            ((a) ? __ACPI_FIND_LAST_BIT_32 (a, 1) : 0)
> -#define ACPI_FIND_LAST_BIT_64(a)            ((a) ? __ACPI_FIND_LAST_BIT_64 (a, 1) : 0)
> +#define ACPI_FIND_LAST_BIT_8(a)             ((a) ? __ACPI_FIND_LAST_BIT_8(a, 1) : 0)
> +#define ACPI_FIND_LAST_BIT_16(a)            ((a) ? __ACPI_FIND_LAST_BIT_16(a, 1) : 0)
> +#define ACPI_FIND_LAST_BIT_32(a)            ((a) ? __ACPI_FIND_LAST_BIT_32(a, 1) : 0)
> +#define ACPI_FIND_LAST_BIT_64(a)            ((a) ? __ACPI_FIND_LAST_BIT_64(a, 1) : 0)
>   
>   #define __ACPI_FIND_FIRST_BIT_2(a, r)       ((((u8) (a)) & 0x01) ? (r) : (r)+1)
>   #define __ACPI_FIND_FIRST_BIT_4(a, r)       ((((u8) (a)) & 0x03) ? \
> -											 __ACPI_FIND_FIRST_BIT_2  ((a), (r)) : \
> -											 __ACPI_FIND_FIRST_BIT_2  ((a)>>2, (r)+2))
> +											 __ACPI_FIND_FIRST_BIT_2((a), (r)) : \
> +											 __ACPI_FIND_FIRST_BIT_2((a)>>2, (r)+2))
>   #define __ACPI_FIND_FIRST_BIT_8(a, r)       ((((u8) (a)) & 0x0F) ? \
> -											 __ACPI_FIND_FIRST_BIT_4  ((a), (r)) : \
> -											 __ACPI_FIND_FIRST_BIT_4  ((a)>>4, (r)+4))
> +											 __ACPI_FIND_FIRST_BIT_4((a), (r)) : \
> +											 __ACPI_FIND_FIRST_BIT_4((a)>>4, (r)+4))
>   #define __ACPI_FIND_FIRST_BIT_16(a, r)      ((((u16) (a)) & 0x00FF) ? \
> -											 __ACPI_FIND_FIRST_BIT_8  ((a), (r)) : \
> -											 __ACPI_FIND_FIRST_BIT_8  ((a)>>8, (r)+8))
> +											 __ACPI_FIND_FIRST_BIT_8((a), (r)) : \
> +											 __ACPI_FIND_FIRST_BIT_8((a)>>8, (r)+8))
>   #define __ACPI_FIND_FIRST_BIT_32(a, r)      ((((u32) (a)) & 0x0000FFFF) ? \
> -											 __ACPI_FIND_FIRST_BIT_16 ((a), (r)) : \
> -											 __ACPI_FIND_FIRST_BIT_16 ((a)>>16, (r)+16))
> +											 __ACPI_FIND_FIRST_BIT_16((a), (r)) : \
> +											 __ACPI_FIND_FIRST_BIT_16((a)>>16, (r)+16))
>   #define __ACPI_FIND_FIRST_BIT_64(a, r)      ((((u64) (a)) & 0x00000000FFFFFFFF) ? \
> -											 __ACPI_FIND_FIRST_BIT_32 ((a), (r)) : \
> -											 __ACPI_FIND_FIRST_BIT_32 ((a)>>32, (r)+32))
> +											 __ACPI_FIND_FIRST_BIT_32((a), (r)) : \
> +											 __ACPI_FIND_FIRST_BIT_32((a)>>32, (r)+32))
>   
> -#define ACPI_FIND_FIRST_BIT_8(a)            ((a) ? __ACPI_FIND_FIRST_BIT_8 (a, 1) : 0)
> -#define ACPI_FIND_FIRST_BIT_16(a)           ((a) ? __ACPI_FIND_FIRST_BIT_16 (a, 1) : 0)
> -#define ACPI_FIND_FIRST_BIT_32(a)           ((a) ? __ACPI_FIND_FIRST_BIT_32 (a, 1) : 0)
> -#define ACPI_FIND_FIRST_BIT_64(a)           ((a) ? __ACPI_FIND_FIRST_BIT_64 (a, 1) : 0)
> +#define ACPI_FIND_FIRST_BIT_8(a)            ((a) ? __ACPI_FIND_FIRST_BIT_8(a, 1) : 0)
> +#define ACPI_FIND_FIRST_BIT_16(a)           ((a) ? __ACPI_FIND_FIRST_BIT_16(a, 1) : 0)
> +#define ACPI_FIND_FIRST_BIT_32(a)           ((a) ? __ACPI_FIND_FIRST_BIT_32(a, 1) : 0)
> +#define ACPI_FIND_FIRST_BIT_64(a)           ((a) ? __ACPI_FIND_FIRST_BIT_64(a, 1) : 0)
>   
>   #endif				/* ACPI_USE_NATIVE_BIT_FINDER */
>   
>   /* Generic (power-of-two) rounding */
>   
>   #define ACPI_ROUND_UP_POWER_OF_TWO_8(a)     ((u8) \
> -											(((u16) 1) <<  ACPI_FIND_LAST_BIT_8  ((a)  - 1)))
> +											(((u16) 1) <<  ACPI_FIND_LAST_BIT_8((a)  - 1)))
>   #define ACPI_ROUND_DOWN_POWER_OF_TWO_8(a)   ((u8) \
> -											(((u16) 1) << (ACPI_FIND_LAST_BIT_8  ((a)) - 1)))
> +											(((u16) 1) << (ACPI_FIND_LAST_BIT_8((a)) - 1)))
>   #define ACPI_ROUND_UP_POWER_OF_TWO_16(a)    ((u16) \
> -											(((u32) 1) <<  ACPI_FIND_LAST_BIT_16 ((a)  - 1)))
> +											(((u32) 1) <<  ACPI_FIND_LAST_BIT_16((a)  - 1)))
>   #define ACPI_ROUND_DOWN_POWER_OF_TWO_16(a)  ((u16) \
> -											(((u32) 1) << (ACPI_FIND_LAST_BIT_16 ((a)) - 1)))
> +											(((u32) 1) << (ACPI_FIND_LAST_BIT_16((a)) - 1)))
>   #define ACPI_ROUND_UP_POWER_OF_TWO_32(a)    ((u32) \
> -											(((u64) 1) <<  ACPI_FIND_LAST_BIT_32 ((a)  - 1)))
> +											(((u64) 1) <<  ACPI_FIND_LAST_BIT_32((a)  - 1)))
>   #define ACPI_ROUND_DOWN_POWER_OF_TWO_32(a)  ((u32) \
> -											(((u64) 1) << (ACPI_FIND_LAST_BIT_32 ((a)) - 1)))
> +											(((u64) 1) << (ACPI_FIND_LAST_BIT_32((a)) - 1)))
>   #define ACPI_IS_ALIGNED(a, s)               (((a) & ((s) - 1)) == 0)
>   #define ACPI_IS_POWER_OF_TWO(a)             ACPI_IS_ALIGNED(a, a)
>   
> @@ -353,10 +353,10 @@
>   
>   /* Macros to extract flag bits from position one and above */
>   
> -#define ACPI_EXTRACT_1BIT_FLAG(field, position)     (ACPI_GET_1BIT_FLAG ((field) >> position))
> -#define ACPI_EXTRACT_2BIT_FLAG(field, position)     (ACPI_GET_2BIT_FLAG ((field) >> position))
> -#define ACPI_EXTRACT_3BIT_FLAG(field, position)     (ACPI_GET_3BIT_FLAG ((field) >> position))
> -#define ACPI_EXTRACT_4BIT_FLAG(field, position)     (ACPI_GET_4BIT_FLAG ((field) >> position))
> +#define ACPI_EXTRACT_1BIT_FLAG(field, position)     (ACPI_GET_1BIT_FLAG((field) >> position))
> +#define ACPI_EXTRACT_2BIT_FLAG(field, position)     (ACPI_GET_2BIT_FLAG((field) >> position))
> +#define ACPI_EXTRACT_3BIT_FLAG(field, position)     (ACPI_GET_3BIT_FLAG((field) >> position))
> +#define ACPI_EXTRACT_4BIT_FLAG(field, position)     (ACPI_GET_4BIT_FLAG((field) >> position))
>   
>   /* ACPI Pathname helpers */
>   
> @@ -379,7 +379,7 @@
>   /*
>    * Macros for the master AML opcode table
>    */
> -#if defined (ACPI_DISASSEMBLER) || defined (ACPI_DEBUG_OUTPUT)
> +#if defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUG_OUTPUT)
>   #define ACPI_OP(name, Pargs, Iargs, obj_type, class, type, flags) \
>   	{name, (u32)(Pargs), (u32)(Iargs), (u32)(flags), obj_type, class, type}
>   #else
> @@ -421,8 +421,8 @@
>    * the plist contains a set of parens to allow variable-length lists.
>    * These macros are used for both the debug and non-debug versions of the code.
>    */
> -#define ACPI_ERROR_NAMESPACE(s, p, e)       acpi_ut_prefixed_namespace_error (AE_INFO, s, p, e);
> -#define ACPI_ERROR_METHOD(s, n, p, e)       acpi_ut_method_error (AE_INFO, s, n, p, e);
> +#define ACPI_ERROR_NAMESPACE(s, p, e)       acpi_ut_prefixed_namespace_error(AE_INFO, s, p, e);
> +#define ACPI_ERROR_METHOD(s, n, p, e)       acpi_ut_method_error(AE_INFO, s, n, p, e);
>   #define ACPI_WARN_PREDEFINED(plist)         acpi_ut_predefined_warning plist
>   #define ACPI_INFO_PREDEFINED(plist)         acpi_ut_predefined_info plist
>   #define ACPI_BIOS_ERROR_PREDEFINED(plist)   acpi_ut_predefined_bios_error plist
> @@ -467,17 +467,17 @@
>   #ifdef ACPI_ASL_COMPILER
>   
>   #define ASL_CV_LABEL_FILENODE(a)         cv_label_file_node(a);
> -#define ASL_CV_CAPTURE_COMMENTS_ONLY(a)   cv_capture_comments_only (a);
> -#define ASL_CV_CAPTURE_COMMENTS(a)       cv_capture_comments (a);
> -#define ASL_CV_TRANSFER_COMMENTS(a)      cv_transfer_comments (a);
> -#define ASL_CV_CLOSE_PAREN(a,b)          cv_close_paren_write_comment(a,b);
> -#define ASL_CV_CLOSE_BRACE(a,b)          cv_close_brace_write_comment(a,b);
> -#define ASL_CV_SWITCH_FILES(a,b)         cv_switch_files(a,b);
> +#define ASL_CV_CAPTURE_COMMENTS_ONLY(a)   cv_capture_comments_only(a);
> +#define ASL_CV_CAPTURE_COMMENTS(a)       cv_capture_comments(a);
> +#define ASL_CV_TRANSFER_COMMENTS(a)      cv_transfer_comments(a);
> +#define ASL_CV_CLOSE_PAREN(a, b)          cv_close_paren_write_comment(a, b);
> +#define ASL_CV_CLOSE_BRACE(a, b)          cv_close_brace_write_comment(a, b);
> +#define ASL_CV_SWITCH_FILES(a, b)         cv_switch_files(a, b);
>   #define ASL_CV_CLEAR_OP_COMMENTS(a)       cv_clear_op_comments(a);
> -#define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d) cv_print_one_comment_type (a,b,c,d);
> -#define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b) cv_print_one_comment_list (a,b);
> +#define ASL_CV_PRINT_ONE_COMMENT(a, b, c, d) cv_print_one_comment_type (a, b, c, d);
> +#define ASL_CV_PRINT_ONE_COMMENT_LIST(a, b) cv_print_one_comment_list (a, b);
>   #define ASL_CV_FILE_HAS_SWITCHED(a)       cv_file_has_switched(a)
> -#define ASL_CV_INIT_FILETREE(a,b)      cv_init_file_tree(a,b);
> +#define ASL_CV_INIT_FILETREE(a, b)      cv_init_file_tree(a, b);
>   
>   #else
>   
> @@ -485,14 +485,14 @@
>   #define ASL_CV_CAPTURE_COMMENTS_ONLY(a)
>   #define ASL_CV_CAPTURE_COMMENTS(a)
>   #define ASL_CV_TRANSFER_COMMENTS(a)
> -#define ASL_CV_CLOSE_PAREN(a,b)          acpi_os_printf (")");
> -#define ASL_CV_CLOSE_BRACE(a,b)          acpi_os_printf ("}");
> -#define ASL_CV_SWITCH_FILES(a,b)
> +#define ASL_CV_CLOSE_PAREN(a, b)          acpi_os_printf (")");
> +#define ASL_CV_CLOSE_BRACE(a, b)          acpi_os_printf ("}");
> +#define ASL_CV_SWITCH_FILES(a, b)
>   #define ASL_CV_CLEAR_OP_COMMENTS(a)
> -#define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d)
> -#define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b)
> +#define ASL_CV_PRINT_ONE_COMMENT(a, b, c, d)
> +#define ASL_CV_PRINT_ONE_COMMENT_LIST(a, b)
>   #define ASL_CV_FILE_HAS_SWITCHED(a)       0
> -#define ASL_CV_INIT_FILETREE(a,b)
> +#define ASL_CV_INIT_FILETREE(a, b)
>   
>   #endif
>   


