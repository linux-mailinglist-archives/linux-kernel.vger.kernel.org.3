Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C6451C6BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382992AbiEESKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiEESKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:10:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169404EDDC;
        Thu,  5 May 2022 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651774019; x=1683310019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AkNoq17JDr96PyGL9QhvxRRdSggExemcGsndU0ORQjw=;
  b=GLaAw3J+4LCO5sSLzPMVg9RI8fZwKE2wZ/2oEgL+tMiIvfQlmxSs0y5U
   D3Rpl52yKEYKeY8Zkk+UpTNwuPCWHVr3KsdF2ZfRZTzb0dGr406lkoAJp
   awmvJwqLe/St6NNLTZenJGnZ27qhFJFw3nbTH0eFQusQBQYBSiCK0aH8Z
   SsBRhXl3lmiO3/kV6GVeSBitFUCVWwpNBw94LUkXq+yO536UWHZZuwn8O
   Udy1K40UQRchrAb2IAr4OCNCnNDYe1DABct4tzSbSwkY0A4+3yih8buHR
   KozkoY8t92ftwjaWs3PUabfuHi4iUydZmxF3TFp8pOSq7+81U8qw1gP1D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250191782"
X-IronPort-AV: E=Sophos;i="5.91,202,1647327600"; 
   d="scan'208";a="250191782"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 11:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,202,1647327600"; 
   d="scan'208";a="735030458"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2022 11:06:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 11:06:57 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 11:06:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 11:06:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 11:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHADzPp9hVxKBg2ktV5YdIl60KauKkllWUmLWU05claxkMj9m8dQj+GISibqH8cJVWr1wAPjNx8GjDjtP7vOhtLISGA3QMk2z0ZP8PDFSFSx7K5YJMwaF/aKhz59n1sK3kPTGmhuomFrxu/pnBolk2jR2cQ8KY77o89/MZCa+rgHjBIQwtz6WabPQMrCMse7o8Lz3bXaG3+J5fdveVOPl6IyInm2i/y7c4gnrtJIhOf8lHUBaHua872xv+W40mY1gfJnCpx7t6Aho7cc0t0qS2HmWcUhTS18nTgogopEr5Nz5BRHJWGnkC22rAb/EYEpsCrwjsefR0w9/PEUB9GA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWOsnix51Z3sU2jwOCPXmN+ZtdgJg0wWmZsd5Fon+Nw=;
 b=OExL98wVhqPwQ0CwqwRHi8akoIJ6ADCVnNBGWd/IlKUcEYPOm0ZsPjMt4AMbgLiqfLZuM8AIQ4BqMu64GhBf0lmdxvy+lVtCv55YBSCoY5EICqe0NCDgj+wIcYBR1/m2tz2JHetkfgg9zy/N3KGhnwk4Ki7BV7or9BjyGOcohk8p6JXqxcmygA2ovl61a0zFRiYErE74C7ogBAQADJVgUa8SmIykPmgW/bQ9uSbDI/OOsZ/goF0gbLiynpvsw886NJZZGHQgylVhc8s7JE+Kdyw2l2OPNnhie63RFJtnsQiyxz4lDPEj/Qj5lZDttJufz8WEVtgnMjcXL3opjpL0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 18:06:56 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 18:06:56 +0000
Message-ID: <0e261e3b-af75-0227-dbc9-5daff71fd020@intel.com>
Date:   Thu, 5 May 2022 11:06:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v2] test_firmware: fix end of loop test in
 upload_read_show()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Tianfei zhang <tianfei.zhang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <YnPMt/syJAqqOBh3@kili>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <YnPMt/syJAqqOBh3@kili>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9509ead-8f72-4557-1747-08da2ec20a75
X-MS-TrafficTypeDiagnostic: DM4PR11MB6168:EE_
X-Microsoft-Antispam-PRVS: <DM4PR11MB6168294B1E0997CCC695F78BC5C29@DM4PR11MB6168.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf2K2Xi/lpnt5wQHwngxXhSb5Si/OzaH5IRjGXi0dmnLgC+JY8IvnVjvvQzIE7AssgGdrvb4JuEo3uvFLwMC2GEZU6P7lMnzeEPruqTH8TzZlZcJJJrRovdRPgWyMkGdSBGzGjYsqeG+XvdnU3fWBqobCEQoHMyq4tGb52XQzZB9GBY+7uj4ZrPgFhTy2RgHzX5A6Pou2GVc9EGiMQnAn2aA0+zy8ecqqaq5Sy0BDyTVpC9aD39jjx2YMBXaP2nlCB3v7pDNuUiUfOgD49uAKBmLGDnfYOT1q3jPNNeei+7HmFHt5XMZGG03PXeF4Zz6/bVJXkg/XYffLaonZtqD0rpu6C9+1iQ67EuIJvb1CZI7wcY4kiTbuuHIio2h/OyLc2EEo6FIDeXOUoMhZPHXho6xI+cgS7G9m10pH0Xo60o57Fem6DaXrj26h9WRA9svnSTrz/hnxundc6LaWxieQUgWqB5ok0d8v9Af/vd9kgqPRcWlGzlyHGr/tUen2L4FoH3MZdn8LGopHBG0JLX8Kbe1oisWolJAEBm27mVH2kQI5f/L8Rcovm/Cb/yxVcO9UBqoZpusO0LWGWQ8aC5RSzDVqfqYkm3zkd7Ds2M+eWqY4/Sx7SjrGqvSwpNyTFDElENbYwxsRyIN8VS71Ssl+L+onxBnQVRMEKaLvwanIkD5Ap+YV5gL3Q77HYUktE4oTfX6LghLiv5Wm4y5ZpCP6Tl/ournYhhUtMXTlLHDKkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(508600001)(82960400001)(31686004)(5660300002)(6666004)(38100700002)(110136005)(36756003)(8936002)(6512007)(6506007)(53546011)(83380400001)(186003)(66946007)(31696002)(26005)(6486002)(2906002)(316002)(66556008)(86362001)(66476007)(8676002)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlmL3lMQUdteC9RTFQxTTBZTFI0bUloNVFIZkNaQ2plUnV0TFdWRDNWUDRY?=
 =?utf-8?B?eGtka1NGNDczQmdZb3A0UTU3eUduV3JwQ2xUa1NWSkxhcTFneFBXd0pRbmdZ?=
 =?utf-8?B?dlN0cUd0R0xMV09wTlhSbmNGMGdTNjNwcXhETXNBaEd2bnNYWHlRKzBnNzU2?=
 =?utf-8?B?RzdFMXkrTmxwLzRjNWJmOEEyblVHVUJJSFZqVk4wb0E0SlppVnRLdWdSSENJ?=
 =?utf-8?B?MGdzcFlSNmorQUY1Wk4yc3dFUlRVZzRjRXJodTNtSlpoTm5LYzA2dEZ3dHpP?=
 =?utf-8?B?YWJNZysyNFlUOW5GQVp2SGlVNWtxdU96RlRHMWtvOXZYN3pNakloRHR1c3lJ?=
 =?utf-8?B?aXBQNnlralBvYnQwVDUrT1g5Tk82YXk0UHl0TmZBd0EzS1A5ZWdVM1cwdEdk?=
 =?utf-8?B?Zmxud1drU1NrNTFwN1ZoM1JmYnc0VTlQeGVET0R1a0w3Yis1Q1BxOTlQa0Qx?=
 =?utf-8?B?d1pKZ3ZmOTdJVFRUa2JRUWNKSHJ3M2ZBdEZhMHU5ZjM1eUorL3p3alpXMlly?=
 =?utf-8?B?YVd2ZHExWEx2R2pHRzJsK2prbFI3d09kMmE1VjJvdEhvWWx1OG9TZnUwaG8w?=
 =?utf-8?B?ajRzcXVZZUtFUjA4Z2JpUlV5bkdTNDJGVzlrRlUwRW1RcmRXckNJem9aUkxG?=
 =?utf-8?B?WmE4ZWtLYjdGTlljeWRZYzlBaFE2WmQ3dEdnbEhkNnR4MmNIWHNoVU5HWjR6?=
 =?utf-8?B?eFhuYmtEeXBTU1NRbnp6algyM3M3bEVMNEd1TkRXd0NQSC9VM1ZSekd5QU1r?=
 =?utf-8?B?SG95Q1d6c21idEl5SUtUdFZtTmEvVFQ0QVk3b3RDblJtNG9mdno3RVVFT004?=
 =?utf-8?B?Y0RQVlF3V0Y3ZnV6eG1YbTNyZTVCTDVYcGFVamViL0pVNklGK29tL1VkemYr?=
 =?utf-8?B?OVdwZWhoSElVU21YOTJwU09kUnNhZ3NuSGVWdTV6OFBHbndub2UzSDFnSzZM?=
 =?utf-8?B?bi9tVUdWcjM4VUJncW8xcGpUMytaTHQxNC9WRHFiTXFSRmluWWJsUG1TczE5?=
 =?utf-8?B?WVg5cE1seDIxSXBSdDJDU0VOTG5zOHZCV2ZlTE5BOFdPa05OOTBaRm1JbmVW?=
 =?utf-8?B?OUxrRFpPSXpBYjkwejU0UWZkMDcyVXBPU1FndGVRZzI5VzgxN2N3UmpiODcz?=
 =?utf-8?B?c1kwZVl1cDFYU0t1SFZ4UlJQejFWYmZlT2V1Y2k1NW5EUXdnS3hTVzF5L0Fz?=
 =?utf-8?B?VHFDdW9IYnljMEVRRUhlQ2ZQYmI0VTFFUVNCTlFpcDg2SEVuRDgzT1JQUnND?=
 =?utf-8?B?d1FVZ0NaVGFEY090T0xvQXFnZ3p4OC9qamU1eXdmK3dFdU9EU2diNnUvdk9O?=
 =?utf-8?B?QVF3a0duaEF2ZTZOTnB1d3RtTVE0cVVvZFpGdjhtVE41NWJTNXFycWhwN2RM?=
 =?utf-8?B?dkFuVGpXUlBnZUVaeC9SMHIvRCs0aW5XNDIreFdqbUZsd25QMGhqcHkrWU81?=
 =?utf-8?B?NWkrK1NybTNaQmJnU29jUml5QXdra2NHblorVXR0UHZlUnBiaDJDeXVQcnQx?=
 =?utf-8?B?SXdhNjg2dm5zczRyWU5CNW9XT3ZsNTVKL2xHcXJjd3ZKU2F1UTRQelFsRDV5?=
 =?utf-8?B?ZGxpMWNrL2tsWlR5dnpZQmVEclB5SEw2amhwSGhMbEp2YWYra3MyNUxFVkow?=
 =?utf-8?B?SUhqY1BneFdkQTBWK3lwUmg4a0krR0dBeUlZN2JyTjBnY0twY2xOd2tjTC9Y?=
 =?utf-8?B?c0lKTUljWmhnd1RDb1ZuajhFYnErd0xybEhxZFZta2RWbDBpb1AwSDhoTXRB?=
 =?utf-8?B?OWhvMkJBQ3J1cW1ZWWVNZWV1c0YvWEFWR2QrRHZBa2h3aldvN1h2cUs5TC83?=
 =?utf-8?B?Z29ZV2VrTS9GeVNTYUMrV3c4NWFHQ2xReHdpK0VoN0RPSFJVTktpbjNseGRI?=
 =?utf-8?B?Mmd4VUFST2pNbnBablZkaHloZFNmQmErVkJURVBMc0swZDhjR0ovQitsY0FK?=
 =?utf-8?B?MlhENlFDZW0zczBGNElyRzh0ZVk5ZlVCOEx6ekUxaXBEQ2pvOWRsSERJMlpD?=
 =?utf-8?B?L3llb0Yvbk9KZFpjbEsvV1FyYmZsTitUNnZUY3Jjb05DQ3FGVXdIQ09oM1Ix?=
 =?utf-8?B?dXNrcGRldGdsU00xK05NNnhhTXZsMDBCSjM4TG1tRVQwYVp5VVdaaTBjUUN6?=
 =?utf-8?B?ZFYva3FzTVY5Sm9SeVVJTGx4dWM3bVJBT0ZlNnphcW1PUnh6aEtFQUFyMkhm?=
 =?utf-8?B?NEcvdkxyR3VaS0ZWSHRrR2xIVks4Q3MxeW9SRzIxTkI1V1JsNEJPY2pCWjdJ?=
 =?utf-8?B?aG9STHJGVitpY2t1eTNyNUt2SVBhazdXRGhKZmE4aU5vcUFQbmVIZ25MbzRy?=
 =?utf-8?B?UG1rMjZRbWpkb0RNQUNrRFo4U1dQQzBrd1F1dnoyQndSK1NJM1djUkR1Sy9p?=
 =?utf-8?Q?JXRfUBuwbjXXE8NE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9509ead-8f72-4557-1747-08da2ec20a75
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:06:56.2044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YB0hjqbytK4Mw74vB0REuk/tSbcwfV4VPPFm+1grUixyjupmKGMklm6HmPHTLYtMJhrPOrLSJ1kg1lNUaKlvn2nkgkzOycjyEGVUUvHJg8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/22 06:10, Dan Carpenter wrote:
> If a list_for_each_entry() loop exits without hitting a break statement
> then the iterator points to invalid memory.  So in this code the
> "tst->name" dereference is an out bounds read.  It's an offset from the
> &test_upload_list pointer and it will likely work fine most of the time
> but it's not correct.
>
> One alternative is to fix this this by changing the test to:
>
> 	if (list_entry_is_head(tst, &test_upload_list, node)) {
>
> But the simpler, trendy new way is just create a new variable and test
> for NULL.
>
> Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
Reviewed-by: Russ Weight <russell.h.weight@intel.com>

Thanks,
- Russ

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  lib/test_firmware.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 76115c1a2629..c82b65947ce6 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -1392,7 +1392,8 @@ static ssize_t upload_read_show(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
>  {
> -	struct test_firmware_upload *tst;
> +	struct test_firmware_upload *tst = NULL;
> +	struct test_firmware_upload *tst_iter;
>  	int ret = -EINVAL;
>  
>  	if (!test_fw_config->upload_name) {
> @@ -1401,11 +1402,13 @@ static ssize_t upload_read_show(struct device *dev,
>  	}
>  
>  	mutex_lock(&test_fw_mutex);
> -	list_for_each_entry(tst, &test_upload_list, node)
> -		if (tst->name == test_fw_config->upload_name)
> +	list_for_each_entry(tst_iter, &test_upload_list, node)
> +		if (tst_iter->name == test_fw_config->upload_name) {
> +			tst = tst_iter;
>  			break;
> +		}
>  
> -	if (tst->name != test_fw_config->upload_name) {
> +	if (!tst) {
>  		pr_err("Firmware name not found: %s\n",
>  		       test_fw_config->upload_name);
>  		goto out;

