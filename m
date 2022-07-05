Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B15670D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGEOUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiGEOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:20:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C71E1A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657030632; x=1688566632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGmRJMcUOv2P5uODH9h+VtbE1N+jMBAhivC3O1jQbds=;
  b=aU+vLewPIbYNCP+IHRCuDlAZBoikkJg/o5Gm1L5P40G4f52X15kTpaUM
   DQ4KIWZDN4V+B0Wy5D7rH+sCsvAhT6b4oXb2/xs6UtRiygDcXOjl2MP7o
   VB4t2ChRTGn+5hCqUThXilxYxxh+mW58hZgshuXFjFNhlTR/9qp5pn7ar
   Y32nRe5DXloucU79O9znGHaKr/zDDp1fPUYSYR4kAlyPqoJRBli6B6Jv2
   2i3BR0zDhyjgRi03qeyho8Ia3hdTG5vY1AGyoeXkOn9CEMw4m+kaV8XYd
   Ej4cWofQB+tkxccjlMwXfTsJxb6g6u/hyoXyqKG36wJh/CPM/i0isNeF8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="266391552"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="266391552"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 07:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="650168086"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2022 07:17:11 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:17:11 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:17:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 07:17:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 07:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0SEGOT/ABAIJ5NaUtITkvcM/tRyhoU2Pvx8kjOpLkQ0QoeVb0BVlakaXtuDkdlEVOQHn0HOsiEJ4xgvXGeCHrizh3K9JQS+YlFv83/hCDh5CTN1mGo7gVoo/L2KnTUsEC56u5zRbvMuKUqq+Isk55NF6+b+VJtAwRkMhyf7/hWU42bKd42Q7SV2P1hNJxcb4hXVwa1w3wYrxBN+VA3/8KCwm0OauOxk5oBNGv/fOaNUHKGyLB9pStuHeOkNs+ySHxQ4TQyi1DCeNFUJAto+Nprhhe43DCnwm9+PLVgJS83E12xuxfz+23dkaFuA7xG++ObNf4VuTCqWpAUBqt7qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw+oZ1LUSaWkxIQhbacV+zkSJyyypNJs7s67vkSFEJw=;
 b=FkVKW4ZBYTGkSe5gM0XC/F53UHdkANO/TG9fs3nWB7o3nkpSipYKzoi+OCDVB2F1pTmv90z9lXa3iabQsOgo3P4O6VFOOw305nI1PMBYlyGzNXMY10nDdxdIrwc5qH54b/dYHu2Ft0wGz3//W5Q0JiLSN9zYX0BDSZbb+NYLnQKFw240S9DhaqCz+irM8QuaszP2ImdP9V76bkFjuREHenhCmiZ2DtSfEs08zVQum6OLpGmJ+gSSnTuJ6Z8a/tW9pm7RX1d6siBFBImYrxYJIKOD+1mVOeJS4yKJ/M1yBu3noVVtU2AVqtNJsVp0pR14jVOnaH4k3POH0ssTnj2k4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BYAPR11MB2630.namprd11.prod.outlook.com (2603:10b6:a02:c2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 14:17:09 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 14:17:09 +0000
Message-ID: <f4867b7f-a8fb-e53a-a693-1ffb9c840e8e@intel.com>
Date:   Tue, 5 Jul 2022 16:17:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/4] bus: hisi_lpc: Don't dereference fwnode handle
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <john.garry@huawei.com>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::15) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf6ea6af-7b41-4c52-f25e-08da5e910bf1
X-MS-TrafficTypeDiagnostic: BYAPR11MB2630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prQsQRPnVynJ6zDjiLPfY7DXBlAbKvIxhsK/pALT1vWvPaqgZkSUgIBT92lr4REtlAohq56PuF7H0HvVFs0SNdqE8VyjEhzY8ILlVVXygxPZtDXso/AoEzXOT1uRxR/4rPNxw/xZ2x2+/Ji1qNVUqUbUHGT0O9q/ucn4t9/rdRFoORWTU7CsKPRnXqOpY0U4GV+YDMdjrMo0U+WZst5dCX6ZisV/f3epGy/TVQjIFMzetgkWZMJ4Cii+n8Sib7WYP8Cw5+hVTrg+tcQImHzl3b0NhsWu0gsqDDXWsUly32Pr5VxUgZ8MMNaFrEqS5D6CfQ43nZKLOWyAPGj+hUPUmx6mVwgPFvLGvSzIZbXeNVCJLNbSJdiuG5eR9anPBwUBYhPm0xarbhYyGjjX+M7ctjJkb8JD65RP0FPz2lfAOuUZmTZkRYbnM2SBekEPI8JpjxzthHtxalO/fLurPIKHLIJDiqRaZnEVTuDXiaXmKV6h1xyw8yFRUh9tVIX4i+yYlm9IV7Bvz79FWEEq/If8HBkC2SLF6gaWYzN6SdhN3EKQ04PZ3OFQ82L1OBTBiFrzy3Hc2GPT35QGIdl5mgHqVbGCsXsokodLbAdjQrdRmN8E1yFgsu1tWdGWwnxIATiiC0+SsnEOpkLdtD1FrIEnI+394Cac/s2xDoALG9PU0gNTvzPAYIl5Xq6mefeYLUjfYKysCf2CrX+8lU2UWQGDNfpSvWwF82goMMaZk11fJlZCs5//I1yBMLWHV+RXyLG3tv4mGrvZTsBhmVrUAr7AjkJzIb//rpTpShexCT5wvOK6zGCTQb7TTHDP9qdZcGSqEdnfTltk2ius+mTfLW4CrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(36916002)(8936002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(86362001)(41300700001)(31696002)(6666004)(316002)(186003)(26005)(36756003)(6512007)(2616005)(6506007)(6486002)(82960400001)(2906002)(53546011)(38100700002)(31686004)(83380400001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RRaHlTZ09Eb25JQlZpYU1IMFFDcmtuQzdXVUZZZ1NFOGVTZUZJL0UyMyta?=
 =?utf-8?B?RmZJRWNjaVhVeUxyYWFhSEVwcDE5bmRzS0FjV2t1VnI5VVMwUVFUZTZ1ZmpC?=
 =?utf-8?B?dzVWaUZPaVlCVkJwa0VUOEUxT0FmcldtZnUxT3pNdEhJbndtc21ldGkrSlNp?=
 =?utf-8?B?ck9zMjN6Uml5RnVTclh1Y3NQSy9rMlB2N3Y3NW0vUXlkZm1LVkxkK2czTVFi?=
 =?utf-8?B?N3EyZTFOS1BWSlZ1cFQybGxkN1pHT25tdDhDd3d6Sm5KOFhPL1pnQ1h2WTJQ?=
 =?utf-8?B?TzhLQWtGTmVOSG1zTDkwMkd1bGhDM0FjV1l0ZWt4dzF6T2NSWVRINW1mS3VQ?=
 =?utf-8?B?WnRzc1FXYWptV2d3RWpsMEpnU0tBZ0VEakFJUStCaUQ5d2JJcUxlUFRqd0M1?=
 =?utf-8?B?OGp1eHRwVk9LUWpqVXlKL2xvQTBzRVpxRy83QVd1eGFGbVVHeTc3ZytTWk9j?=
 =?utf-8?B?Wm9ObEJUTVUydUF5ODB4RHhYdEtoNjJ3R2JFWlJZMlFCR3o4L3pqbDYrMXBT?=
 =?utf-8?B?Vm96MHkwc05GbnArc0Nxc1lsem5XWkd0R2prVnpyMDE3ZHdmaEs4TVBpbDF1?=
 =?utf-8?B?Vk9ya3FER1pNU0tDS1RZTTIrQ1FxTFlkK0lzTEJ5MUY5UU1seXRCQ2krdW9M?=
 =?utf-8?B?MFNhb0pOZ2puZHNsVDRKb25FNW5kYjBJNCtIQ2FXVWtHdG8wKzJlYnVQVWF3?=
 =?utf-8?B?bjRmRXQ3a0dsN09zOXpzMFIvWlpoVng5bWJaRStRTU8zc09IZTVOcTFrSjcv?=
 =?utf-8?B?YTZ0ODJoQk9pM3AxbUFPaGhOejMvYlluL1k2dDhueWNsRWQ3NUhwQWg4bjgx?=
 =?utf-8?B?VHJkOTdtMEF5cmpGZjdtSi9WMklNSWRieWdFSG9COUNYeTNXYkNDR3hXQlNx?=
 =?utf-8?B?R0JCc1J3SzlSWXJOaEVFNzViV1MvZWNwU2VCYnJyWnVwS3VNL2Vtak5MbDdz?=
 =?utf-8?B?cmJSTC9ZL2dLSXphMXNzbmhuMkN1RWxJU0JSVDQvYXBKK0FWU3pHd2ZuMVpy?=
 =?utf-8?B?bHp0M2RJMGpMWFp6aGc1cmNucmRCQ2lJL01XMXFlK2gyTGdMWWY4ckxsRmNV?=
 =?utf-8?B?REFHTkprUGR3TmJiYXo1bTBqenRYWWlBVkM4cktKTjRSb1JEejN6QnF3Sm4v?=
 =?utf-8?B?dmhyOTYrZFlTdzRYSUxLM1NGamI5ajRJUGZDWW50S20yVERvMkxYdWJNUDVH?=
 =?utf-8?B?a2VkeXNWNDN6cVpKZnM0VWtGVlVHUGEvb0JiY2pWQ0tteWU0dHhhbG9ZSC8z?=
 =?utf-8?B?WGZVL0hJWnZsSFhpQkFRVWtmbk9jajFGbGlYRFU0WGtUMVRNSTB1MUp3YUo0?=
 =?utf-8?B?d3czQlJpbWoyNjNkNkRnbWVLSGlKYmtiMlBpRW1KMFpjTFY3ejQ4L3FMVVJ5?=
 =?utf-8?B?UFZFVncrZEs5ZjVxS1FxZ0c3OXF5Tm5LQkJxRmNIL2lqeDBrWVprbEsweXhk?=
 =?utf-8?B?djRVcy9EM3dUamd3NG5meVN2ZVJkN012K0VqVlpmL3N1SEFCeEhJd1FQU2N1?=
 =?utf-8?B?N0NVZVUxbzkvenBWMzhCL29LK21lbWFOZ2dZVUswMUN0ODFKK0JBL1RQblhp?=
 =?utf-8?B?aGZHeldOUmxpbklJcmJYTEIwMnVBeUdxYjE1N29zNElya1BZQ1VwMlRvZFow?=
 =?utf-8?B?US94ZTJ3VmhaOUEvNGxJOCtPV0lwZnJmRFRCZXE5N3ZzZkZQZ1kybUtaRVNj?=
 =?utf-8?B?S2RUVHlhcFhNSEUvVktJZGxWK3ZIYnJrTllEZEMxVHhZWmJHSW5GRjRQdmoz?=
 =?utf-8?B?NG0vR3F6cUhGVWYweURIekdJeThDMzlIRkxwci8wZlp6bUpseGw5UGZ2NVUz?=
 =?utf-8?B?TUk2bzNoRjB4YTV4NEI3eVYvbXNSR1hCUXNkZ2VxY3ZtT0ZKeDMxUmE3U09R?=
 =?utf-8?B?cXpqVWJ1a2FhUVk4aXQvMXlwc0ZmN2w4dW5ZZTB4eHpIWDJhKzdmd0JEdkJS?=
 =?utf-8?B?YlVLNVZoQlZKZ1NabW5xalgzZU42WGNwSU5BRTNybk1UVFlLQ1B6dXhwcDF0?=
 =?utf-8?B?VTd3Yjl5ZlovYUFmY2pYVjdpQkRNRW1hRTd3VnA0R2g1d24vb1RYR3prZVVh?=
 =?utf-8?B?QS83ZXZoMzFkYnkyUG55c05PMXdUckpQdEZTbW1DanNIbi9rMXVmUXhrZ3JF?=
 =?utf-8?B?KzBHUkdMZWlaakR6Wit4VVEvMEs2UWY4MWdWeTZsR3lKb0Z5aEdMdThFcmVV?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6ea6af-7b41-4c52-f25e-08da5e910bf1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 14:17:09.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eYorMVhCYtZ+PG62dlxZZ2Lk0OnsZJSH5gUCmLkS1rBo5txBAbElanwzZId3u57nbYpN84IfJBLeSOBXik2jUbpETtK2mQw57iCWb1io+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2022 1:43 PM, Andy Shevchenko wrote:
> Use dev_fwnode() and acpi_fwnode_handle() instead of dereferencing
> an fwnode handle directly.
>
> While at it, reuse fwnode instead of ACPI_COMPANION().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/bus/hisi_lpc.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 2e564803e786..6d432a07cbba 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -347,7 +347,7 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
>   	unsigned long sys_port;
>   	resource_size_t len = resource_size(res);
>   
> -	sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
> +	sys_port = logic_pio_trans_hwaddr(acpi_fwnode_handle(host), res->start, len);
>   	if (sys_port == ~0UL)
>   		return -EFAULT;
>   
> @@ -615,7 +615,6 @@ static void hisi_lpc_acpi_remove(struct device *hostdev)
>   static int hisi_lpc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
>   	struct logic_pio_hwaddr *range;
>   	struct hisi_lpc_dev *lpcdev;
>   	resource_size_t io_end;
> @@ -637,7 +636,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   	if (!range)
>   		return -ENOMEM;
>   
> -	range->fwnode = dev->fwnode;
> +	range->fwnode = dev_fwnode(dev);
>   	range->flags = LOGIC_PIO_INDIRECT;
>   	range->size = PIO_INDIRECT_SIZE;
>   	range->hostdata = lpcdev;
> @@ -651,7 +650,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   	}
>   
>   	/* register the LPC host PIO resources */
> -	if (acpi_device)
> +	if (is_acpi_device_node(range->fwnode))
>   		ret = hisi_lpc_acpi_probe(dev);
>   	else
>   		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> @@ -672,11 +671,10 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   static int hisi_lpc_remove(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
>   	struct hisi_lpc_dev *lpcdev = dev_get_drvdata(dev);
>   	struct logic_pio_hwaddr *range = lpcdev->io_host;
>   
> -	if (acpi_device)
> +	if (is_acpi_device_node(range->fwnode))
>   		hisi_lpc_acpi_remove(dev);
>   	else
>   		of_platform_depopulate(dev);


