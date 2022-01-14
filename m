Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95AB48E8F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbiANLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:11:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:39785 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbiANLLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642158708; x=1673694708;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6V7HkiqUJ1dBfbdVwlHKyFVdxxHvOaUElUQEydEIT9Y=;
  b=Ol784292++jliwPEkbA5N6KMq77Zn6NkEvoISkMjOTpoaPD5mHoOxaHx
   mPJX/8Q5TUKQi9FEHrIS0ua5dw95U2jG33pP2lAOdEnH6NIf64dlt8ALl
   eA6gjrBGsyKmUcaei3hxsT33HCC3vqX1/m7YvEDFKzjTt8ropPQZwJP9y
   zgCp8Sry2LUdCMagU9J0kkBduchwY6+C8mSt6/osHX0ZIhQ/ZrhcE0UIl
   xWX/nK1IM8mctYdiapkC1gu93NdYbu+KXf2e9hKrdygFy7JoKrBvFuVXf
   Ggc+m1vYhwRNju2jqYMWCOv/Fue3TEwNr+MOGEdXTwcMwY/t+OYz7Pi8z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224915914"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="224915914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 03:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="530195417"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 14 Jan 2022 03:11:47 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 03:11:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 14 Jan 2022 03:11:47 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 14 Jan 2022 03:11:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/DzVvjuNciosns5fr0yOjYfYJkQjj/GlLrcYSTcIPYDMSpQMvokS8wA3cOeUDLe7gWWTRCtgBRm2bCGSEah9Acu+0b/e1oiq7/9ti3jHGIzuzcSsTubNngxTeSTSekxdyd8rEX0DjkA8zdSyCYfTUSt4agCmVGKL+o5B5aVzVaNz52Xwe9HJbuYrKUPfernDp4sRZDCcuq3/8VPp000TlQfSIlDg3VmLFc/lZbryJR2YB8TvdAD9dxkIjnX4Sa1GMh+5UY2shZc3b3Pjd5xFrDM+0v856rnjsFPo1t0OvynjmrMlLj4bpIghVMo/C5FDzE4ceVmLVUQ9eVUI1dZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqPhNx+Lmdox7RcITSq8wzNqiqNgXnd1xDq02V1Pyks=;
 b=cS/IcnTJqZadhTPU+Tv0pztB37aQoDAO9GR+jrfWpjmCOW/G3F5porF2xiJin8RManM0cXd8ic6fVwXbPcrnJ9i9BB2hrnXJSudpkxGnkPTQt96854zaoSr8CBc6SAC7wuLOHfKzlIrYAlxppRcqfK6Q64XCbfa87FJa78Ys1T9Nap6X6wkVGHC8T3vk7S4ThM2uhsuw6nHeRZHuUH+zYEV8AE6y8NqWfcHUc7VS6uYTdTfMHRch0MA0VgaZ1J+qnTMWlNgnvshgyfEC/c15SepYuMXVn4L5iPE2Ney4xpo9u7b1JXqjggWGiZEkI7v3hwAaTaTBTpY9wYG2mkxHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Fri, 14 Jan 2022 11:11:45 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d%3]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 11:11:45 +0000
Message-ID: <86b76e9f-96b0-7d54-bd38-449745e30aa2@intel.com>
Date:   Fri, 14 Jan 2022 12:11:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [v9,2/3] drm/mediatek: implement the DSI hs packets aligned
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
References: <20220114092110.12137-1-rex-bc.chen@mediatek.com>
 <20220114092110.12137-3-rex-bc.chen@mediatek.com>
 <4076cb55-4546-6bbd-1a1f-19395dcd9ccd@collabora.com>
 <f858dd4aaa35fa3eb969baf887f038c3593232e5.camel@mediatek.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <f858dd4aaa35fa3eb969baf887f038c3593232e5.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0074.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::20) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a5cc8fb-5241-4489-2e37-08d9d74ea6d2
X-MS-TrafficTypeDiagnostic: DM6PR11MB4674:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB46741694C3C576470DCDDF2DEB549@DM6PR11MB4674.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqpgb0NUBbLOonDYgzhgIybJLovMgZ8Bnvvviv0RvI4eml7lKI+R/m6nSipfoxswytr1aXiQWuy64T9ws1LQTvOipL/WAbRSL9rtPGPEU7XuYocNZnN8/RTAyRdYwZg5sPN5gdmsdVYLb3YpXftNE35Fmu9xEGVMzebwmvBk98f5goQwbpz1M51XKi5TSBzogaZDNlXCtgN2nicG89eoWHqRtNyhYvGVDtjuj78fLP3ESA7Yx3jyQpDEE0TrIkLFzTCZuz0Cf49IASX/1rAIrRKCC+LJ61CEyegK3ahj5oBZx3Y+ceGvq6uDWSNepE9YOopHMg9uVVLGXFjm1AfcH3kFuiFRHP9Yx5UCm2eu9Ib1ahZfJieAzrXoLC1GbH8saRENjKJUjzZf+TklRlm1uPRh39nbZIQgkB5PEq2EBMZ/7ehUCM2qHC+EFU3waopFvo0RdmOtPhGgZ2SX5RI6xGtakVVcNm3Itsgo6crGKdfPIa7j9o1xjYDKdH1xbT/MsahgQlRoJs37vbWXuF8d4FmI3QEHbSM/88LW653wcLCSP/0aVr5EUnHdaS5QC4KNijrQfo0Lebq2K2hvn3IfCIMSQk6g5c7TVCf2VFjq5QEgRYc4AM66giVVMTgv2f17ZARjG8QBxJQ4n+6nNW0jf1ibtyRqLNLNGkRp0K5cVuMfNxwehcv7wYCgZ5/IxSd+l9/438umEzPZBPKQ4XDRRS8QCjHG5RMZgVDVILLI1sM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(2906002)(508600001)(31686004)(66556008)(66476007)(36756003)(186003)(36916002)(44832011)(38100700002)(86362001)(2616005)(31696002)(26005)(110136005)(4326008)(6512007)(8676002)(7416002)(316002)(66946007)(6486002)(5660300002)(53546011)(82960400001)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNxaWZsRmRKQXFGZktEZG52ZGJEOXVBNjRjM0dLeUJKV0c5dE1vT1pBSFAv?=
 =?utf-8?B?SEs0T0pGNDc4OUhqeWxKd2Q5ak4zcmFzejRsb2ZtQ2R1dTZ3TnlXZzJPWnk1?=
 =?utf-8?B?ZmpRZ2Vsc0diYkFrdGorQ3FCZU1vci9MUlhNSkx6Ni9qdTdMYmx6Zm9sTEZP?=
 =?utf-8?B?VzBrL2VKdTlaYTFaWTdNTDhUd0VYV1RUeURZaWNlaHp4empIMzZYeVM2c0Y5?=
 =?utf-8?B?R0pjUmM5U1o2dU9FWHVqZHBDblYzd3N3Z2t5REh4WTdxWlA4bWx2WmhBWUxZ?=
 =?utf-8?B?b2JDSUE3M21kYUV1cjlCeklNM0x2UHp3bG9pcXNHMzJtQVIyQTVOT1MweFFy?=
 =?utf-8?B?MjY1cVcxQUlYNzdPNEg4V2xYSkt3Q1NrSGJXa1VTMU5FcThMYkxpK3YyRlRn?=
 =?utf-8?B?NHFEZVRXVzBDNEVDcVBWUytPQVg4UnJoeHZFY0pObDEvQTZsNm0wYU96Vjky?=
 =?utf-8?B?bFQvU2RzMU1PWlRxb09TQUROUVVZaysxZ1JXNmtUUndBVnZ1VTZyeDRjUmZ2?=
 =?utf-8?B?cXhtOUUyNDE4L01tRnhwMDRoNWlJRlY0eStQOFJaTUVFem9MTU5MTnc5YTl6?=
 =?utf-8?B?V2dDb3pQSFJ4WFUvSmIyQUZhbDgvdXBIMTVVdG9vOFFuVTh0TzNKeXFCOExl?=
 =?utf-8?B?MGhYZ0RUb3p3UGFpVmwreU9vUXEvS3BjTmNhdGJwNkc5VmFXZ2VUalczbmhm?=
 =?utf-8?B?ZUdmSm9aZ2Z6aXFkbFd1VXh2SmNhdHdzVm5Xd3FtUGRoTmJCZFdNRU9NR2hN?=
 =?utf-8?B?ZjdBWkZ1WjdlL0ZVczZnekEwWVFRd3hpSXhRUXdkUXNUMHB1THptUEhpY0JF?=
 =?utf-8?B?MXprVkhjZFc4OEZQZlFRY2hkY1hlODdsUFZvdXgyN0xtb2wzaXZtNTlZUCtk?=
 =?utf-8?B?eXJHaW5lS2QxUlltWXJsWTVsOHZWMzBxNnl6ZWVucUlHZmY5VWZTUGJXdjF6?=
 =?utf-8?B?Yk5HYmZyUkVLcmNrYm5FZEF3Y2tETFdCVVZoWUZqR0Q3YkxEcWtFRTBTY2xx?=
 =?utf-8?B?NVk1SkVoQlZ6dVRBRkE4NmNWb1NoSHFIQm1TdmVnUDJUWFBQSFNQdzIxVkt0?=
 =?utf-8?B?NWNLZHQzWFYybGtIL25hQm5RZjdBM3ZydzBVcGNyMDg0MTdvUUZyY1BmQzk5?=
 =?utf-8?B?Y2QvMDRITHZISzM1Wk5ucmc1WjgxbUxjU0kwQW42cGtRZ3piTm5OQ3NVNURH?=
 =?utf-8?B?S0RIb3N3Um9DaTMybk1YVHRFVVhTeW1teGlPNWQzdmNvSTZlcDFFdS9NOFJC?=
 =?utf-8?B?MEFLb3VvYWNlVExrc3MwdjYxMGR5M0xENWNEVVhHaWgwV28zdmdLV1BVd3N6?=
 =?utf-8?B?cWt4dGpoMk5NL0wzaXpDWkxnNWdQTE55N01qdHpxV1NsbGlrSGJQS3diNXhQ?=
 =?utf-8?B?Wlp0Z1BJMUxSM0Y1WHo0R29kYmhTbzVmbFBxWEJRQkNkOWxkZ2tlN053aGtj?=
 =?utf-8?B?N2pTdXZWSWE5aytzY0cwR0pqdTVvNzBQNFlnanpXakFxM0ZTOHkxMHlMR3Fi?=
 =?utf-8?B?cE0wbUg1dEIwVmVqVk1HWHlYYThpK0IzSkIvalYvVnV2K0lyeW5iUmxyeXho?=
 =?utf-8?B?aUl4Vm81SXFzZDNhRE9tRlBKREpuOEdncWlKdTV0cGw2NUtpYzZCTzh6TXdN?=
 =?utf-8?B?WHhMSTEvVFFKeE9YSzFpOER6bE5CaDkwSlJYVFlkSmM2RDV6VjVuaTR4eEwr?=
 =?utf-8?B?Yk9RU0I3azUxam5sZWZVM3JRbEZEYVgvV2pIYWYwNmlsQ3JuMHBCRE9OTUlG?=
 =?utf-8?B?NjVxYUFwSk1IQS8wTFN2Y05rOERGNGtybDJBR1lLNW9mbFdYVDRucWdYYTBy?=
 =?utf-8?B?ajZ0UTJtc282bmQ3d1lkY0REUVhuMFZiMjZnNFNYVTFBbmxZOUkrMFcyRHJH?=
 =?utf-8?B?dG9nMEN4T0hCTE5MZ2RQUFRMR3dTcGJWdVIrL0FIYk8rdjB2OXFHc2JQNlBP?=
 =?utf-8?B?MWpxTVFUVHkxU25wNS9leU1GcnBYVmFaOTdpZVIyZ1l6UUI4cFRaZ0ZJNjJ2?=
 =?utf-8?B?bUhyUFR4OXRjaHpaYmlRcEJwV2IyQkdCTHA3NUVPc0swWm8vaXZCZk5UREdC?=
 =?utf-8?B?Wkx6T0FKamZGZURweDRFMzNZVm1xZlBWTDBVQ1BKMHE5cWh5cDJWL1VmZkg1?=
 =?utf-8?B?bDVFbHBhanBHWSsyeW1jbS9KWjZsVlU3K2ZGMnl5UGFydkRpejVJK0FjYWtv?=
 =?utf-8?Q?6J3Q2SkftXnfuf3ETfnGusE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5cc8fb-5241-4489-2e37-08d9d74ea6d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 11:11:45.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvvCdWAzvBG1y+h5LhkvpDJDyRtdnnotvpyESsIJhFnFTjacwgHfiwjJ+TWENcHABO6gDeDBjF3NgLYufuIyag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14.01.2022 11:20, Rex-BC Chen wrote:
> Hello AngeloGioacchino,
>
> Thanks for your review.
> I will modify this in next version.
>
> BRs,
> Rex-BC Chen
>
> On Fri, 2022-01-14 at 10:36 +0100, AngeloGioacchino Del Regno wrote:
>> Il 14/01/22 10:21, Rex-BC Chen ha scritto:
>>> Some DSI RX devices require the packets on all lanes aligned at the
>>> end.
>>> Otherwise, there will be some issues of shift or scroll for screen.
>>>
>>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>> Hello,
>> thanks for the patch! However, there's something to improve...
>>
>>> ---
>>>    drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> index 5d90d2eb0019..ccdda15f5a66 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> @@ -195,6 +195,8 @@ struct mtk_dsi {
>>>    	struct clk *hs_clk;
>>>    
>>>    	u32 data_rate;
>>> +	/* force dsi line end without dsi_null data */
>>> +	bool hs_packet_end_aligned;
>> There's no need to introduce a new variable here...
>>>    
>>>    	unsigned long mode_flags;
>>>    	enum mipi_dsi_pixel_format format;
>>> @@ -500,6 +502,13 @@ static void mtk_dsi_config_vdo_timing(struct
>>> mtk_dsi *dsi)
>>>    		DRM_WARN("HFP + HBP less than d-phy, FPS will under
>>> 60Hz\n");
>>>    	}
>>>    
>>> +	if (dsi->hs_packet_end_aligned) {
>> You can simply check mode_flags here:
>> 	if (dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) {
>>
>>> +		horizontal_sync_active_byte =
>>> roundup(horizontal_sync_active_byte, dsi->lanes) - 2;
>>> +		horizontal_frontporch_byte =
>>> roundup(horizontal_frontporch_byte, dsi->lanes) - 2;
>>> +		horizontal_backporch_byte =
>>> roundup(horizontal_backporch_byte, dsi->lanes) - 2;
>>> +		horizontal_backporch_byte -= (vm->hactive *
>>> dsi_tmp_buf_bpp + 2) % dsi->lanes;
>>> +	}
>>> +


And if you could add comment explaining the magic here it would be nice.


Regards

Andrzej


>>>    	writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>>>    	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>>>    	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
>>> @@ -794,6 +803,9 @@ static int mtk_dsi_host_attach(struct
>>> mipi_dsi_host *host,
>>>    	dsi->lanes = device->lanes;
>>>    	dsi->format = device->format;
>>>    	dsi->mode_flags = device->mode_flags;
>>> +	dsi->hs_packet_end_aligned = (dsi->mode_flags &
>>> +				      MIPI_DSI_HS_PKT_END_ALIGNED)
>>> +				     ? true : false;
>> ...so there's no need for this one, either.
>>
>>>    
>>>    	return 0;
>>>    }
>>>
>> Regards,
>> - Angelo
>>
