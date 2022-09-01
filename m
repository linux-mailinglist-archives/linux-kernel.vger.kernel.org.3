Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B905AA170
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiIAVUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiIAVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:20:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3662B845
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662067200; x=1693603200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6RtG18R1c0IL0kcYtq7RhgarqiCYu8q+Buas5jgXQlQ=;
  b=mrgv2cF4kByIMT2OOHvxtlbOweK/no3aPag8OUvaBZbIyqSbhACz0aeK
   aGG6IIYlHwwWPW043Aw4Dz191CPpkQQ8dgWdr1Douyih2nBlNn8BBInwp
   w5Fu6spDKXCnfVcBGeBrqwi4S8Sm3fQcqGCIshljE/lgNJw29yA2iP5Ht
   Y1SSWt/FLBjlyEF/Trp/jKdsMd+7IuVsJthzA7trgOPUM4yOFPIutr2q7
   2MmgyThb672C/GDaAsQOA/VR0iQXkyqUGD2zS7gXAWK91qqv+VDahtD9j
   WjBPzJ+h7TPLZRXMgd1I36hrOTGNGleO76XPBMcCTwmcycg5he+858vmM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297114210"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="297114210"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 14:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="857999680"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2022 14:19:54 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 14:19:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 14:19:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 14:19:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 14:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1Ye5ugBEmfS6gmL0iA705jh6pf9Rgqzxdikvs+bLZx/uOaoAS4ITxqGZ7YeN/hbfb+RRyXz4yis6Xt5s6jrRjr3NUL+3Gp4hlcUKsDjFxXHat744A4PGt0KTM0tH7NVFYp7E3+l8lUlRR/pHEZVWqioKC9F5hiBuWP6CNTkUItIhfdAMbp6WxSocjgIDjmXMjrM1wnMxe+ACah/WrteyCoMrje83l+XUdQ8oGJfyBdLai4fHjgksfj35gIU++8Yx4HEJNH/xfowm3THHSRP3xbfLbhnfFuhS1gead3Itc3QRAQH15fHBAd+P+jp2W9VvPH5n1PVMBku4mL0Z3rM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0r7uQxGvEUHn03ks7+HRuEJhZygWA5cdqWJS8oKdJ0=;
 b=asEjb4+9vxneuespjv1wk8hRjdf1ahI29ztTK1ACxwAOfNpCAAe7Xatxsb2pdtG5cpOeZvHFXX2b9rFfhLsKbVUDVzEl940Ngh1GiWFeyY9yPas3ZoBkEkSrYPTh8KSC3XL6JQSIP3Vlqt0w71XfkrHt3L3vapa10xBiPsOTlb4udTg/ymcbKus4Kdf+1Kn5xZdrTFAZpJKksXzWewqhIInGMsELpdUSngPIrtoVy4tg3iiKU2dxRuzuqyQn5BL+Jt1Iw+GCSJZscjg08Mw4U/kWQTJW7JIgm0dr68zkKncJVNN6qHTxwKdwqbZxBb3zh0+Gs0H0/b8UHXukm/vg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 PH7PR11MB6930.namprd11.prod.outlook.com (2603:10b6:510:205::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Thu, 1 Sep
 2022 21:19:50 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 21:19:50 +0000
Message-ID: <c043ee8d-0961-f533-1085-274f3e7d08d4@intel.com>
Date:   Thu, 1 Sep 2022 14:19:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 12/15] mei: gsc: add transition to PXP mode in resume
 flow
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Alexander Usyskin" <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-13-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-13-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::46) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 872ae640-47bf-4167-f334-08da8c5fb490
X-MS-TrafficTypeDiagnostic: PH7PR11MB6930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqnuOnZe+6mkq93PXwtJq3O4xwDtj7h37F2xDCZhMJ7QmHF7IwWOUw4CgR8g/ruR+ChCG7Y2PQkBblxT7q5XO6gw2jECVUH1YRDCjJwTRaa5dpwvBtj5nOF59hYz1AfCW4aieW8gN6VMLKlqwjRP2T1MuJNOiwIydXFi7PHZdiRekBkMTBRd3cARLXoJN/M43XTsrsrHqVCZH5NzxIt7dcojwwXAd2mWjKL368LvLZoNRVLhKo49zfG+B6b2X/mXuMh82BdEtVsIj2KRBDrrdZ8PjZfFnngd366abqKDDOx+YDq9/mnuSdsVYQsyI1Iy0Cb1W11qJRaqGivOKlvcAtDg4wsd8zproEY4YI9R9UYT1bW8w4SUNV2Ij8KAcZQSdLKy09yPijZn5laBEjzVVp2gMT6yJz+83Eg+4nCNjQ/OXkvAhdVnK52YvZQtAqMR80wBhB9/Fmy5sfLSJi9PXwURlI3ZTUu+t53kwCfKFVVaBROOQbvH1snn18R4X/0n2acim99h8yJYADoVYyRpcwVHRFrCVMKfP2B0MHtD+2dPIpyVz4ZpU3YzVfR7ZrvflYtt5yEWPIXPb4TdeksPu7qvUPQTJMxTSl1gNNLz+H+46PGB7T/eCNoF0Ou579UOdUs494epdBpJdevurpssnYAMA23oeHTX3yv6KyB8fvP4bl07n6xKWZ0Hh6ujB2WPMU42KVq0bhoIFKyxYGvL424AYiyESv1qIMebrZRspxwGWsmckuyCpwkIfJiRQ8T3TeV73GXQqIib0EDsvlVqglGh7Fc2KtX1+26cSQLQnjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(396003)(136003)(6506007)(6666004)(6512007)(6486002)(41300700001)(26005)(478600001)(53546011)(38100700002)(86362001)(31696002)(36756003)(82960400001)(8936002)(31686004)(83380400001)(2906002)(186003)(2616005)(66946007)(66476007)(5660300002)(4326008)(8676002)(66556008)(54906003)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDA2MCtlR3dxTGxGOXE2SUJRQW96UmJPSXlxaDNXSnNPRUYzZEhqOWlCQUR5?=
 =?utf-8?B?dkFCTEdDc1pXcjVDSmNTVHdyMytVMk1wMkkvSXkxSGRWcHgxMVl2SWRESDJo?=
 =?utf-8?B?RGJrdS9FbW5CbFE2REZaRWE4b1IvWmNiVHRpNHNKWDJ5YTBVNGlhSDlZVDEr?=
 =?utf-8?B?RXlsK0VNb0lwYTJkZVJWNjNaNkliS2dycFl5U2VramFuMUZiWkN5R1VwWThh?=
 =?utf-8?B?Rm1QbEpKclNIbHZqL1FKK2ZETW9WMDUwRDFWYUsrWG9rTVUreGJJdjA1MEVi?=
 =?utf-8?B?MndCenV5b3FKYlpHbDlqUEsrVjlFNjRHUk04ejUxTmRZZ0xxcEgvakl1QzVZ?=
 =?utf-8?B?WFFyZmhNdnNTS0ROVHU2cjBLTUcyY0JUUGxsZFJZM2N4RW9lVkI2YWUrVE11?=
 =?utf-8?B?bjhXVzRmWlNieDZma25MQzcxd0o5dFUyeEI3RTlXSXFXaHh2OUFvbW4xU2NB?=
 =?utf-8?B?NzRuK2xNOUlTUzBudFQrOFppSmdGQ2gxMGwwd3l3OFFMbnBRZ0VDNHZpU09z?=
 =?utf-8?B?S3I3bkY3eTZiNllTeEs5aUwveXVObjBYc3JPbVZtV0NqbTViMStKK3RwMTdQ?=
 =?utf-8?B?eU9GVGFGblJteDl0U29IQjBsS0pSNW0zLzliWWhUc0xkN0t2Y3lkOW5iTGdH?=
 =?utf-8?B?Ni9nZE1IdXpXTW05UThvYW1HNVJGcmx0am0vcWxXaWFoTE5ZK0QyNllSZHoy?=
 =?utf-8?B?SXBxcVlBRGxUTm1OV0NDQS9qWmMxN2xOWjF0NjQrMGh3VytWUlNUWjJuNEs1?=
 =?utf-8?B?TlNNTUhrMldzbnpTcHRyUitBWU1XdE9FNU5jQVJzUyt1eEhyM1JIQnpOL210?=
 =?utf-8?B?VXhSbGhDeUJxbmtXU2VxcUphemdLakhlQlluelFXNnBnWXpjSExEU0hTR3Yz?=
 =?utf-8?B?dkNhWVRYbDhqT25WelE1TkZyQ0RtSEZ4dzV2UHdWQnYxNGNmUWNMWTVSdnZu?=
 =?utf-8?B?cWRHeE45c1JqOHFLazhyY1EzSHFlOFBYU2FCN1NaL1BOSUdwOXBJVWowRC9U?=
 =?utf-8?B?MVRhVC8wZUl0dHlaTVRRTXl3OUkvaFcwNG5SeW02T1VkdGZURXUxWm1jWjRH?=
 =?utf-8?B?Qk1INnlRRXRsbXZBVWRYUVQwU3JrWXdNbVFSVnBEUGQ3UU05clE3aVljdlZa?=
 =?utf-8?B?c2tSRkdWQVlWR3d6SlZ5RFFUc05NbnhIbWtXSXlyUmZKb0wwMVQ4VXVoV25O?=
 =?utf-8?B?eHFSYnpnVldKYWVPMlQ5STdEUEtNMEEySW0wTWtQM250K0hsZFBBVkd0U3pq?=
 =?utf-8?B?NmZCNzM1cmZnOU9qZ1EzeDRvaHdQUlVwM1N1T1dWd2FlL2pXVENzU25PTldC?=
 =?utf-8?B?Rm9BeDg2UmtlSnlqODhHUVAxTWF4RFBya0RiTmhPQUlkdGdNNCtzZHcyQ1o5?=
 =?utf-8?B?NXBEYWdNZnc1SzllRmlyM1lDVHYxQk9mQzlGZ3NhNlpWQVJnVTM1WWk4RkQx?=
 =?utf-8?B?V0VkaXZ2UjVXVG0yQkFielhrWFRmbk1DYnc0Z2VEazQrVnZNeUFXVlB4MEJK?=
 =?utf-8?B?OFJGQ3BCU2pnOXk5SlB2UUdhcVA4THlaNkhZV0FHTWVmYS9ZRURJektEcjIz?=
 =?utf-8?B?Q0pwK3FGSTlSTk8xYXFlcXoxOXpOcXhHeW5OVVkyZWxrVktJM3hQb09weGlm?=
 =?utf-8?B?MFcxNlBZK1owQ1NHUkhNVkxVeEFtald1czExcmpsb2RlckwrYXE2QVltRU5N?=
 =?utf-8?B?Z2pXNXIrUmozcEJVaTRXY2pCS2ZTSGhaMTgrR0VFQ1RWTFlQeUEySHdIUEsx?=
 =?utf-8?B?RkhZVFRSczNsWG9hVnhyUmRjcC9tNXhhTlc4SGpzWk11cjFoamFkTHA3Wm1a?=
 =?utf-8?B?Z0V4UFhFcWdMaGZ1R21Td3FZQW9LZ0RLRTl0amdhaUcvajZIVWZCRDJmcjBD?=
 =?utf-8?B?N3FuK2N0UjAxckh5UlM4SCtRbzF1OWkxL2dQaGpRWGRybGdoREhQbjRlVXYr?=
 =?utf-8?B?ZXJpR3N5NnUxTE9FL1BETTJHcWtRWDRzdkcydTIvVnFEOEdzSXNud09KQmdI?=
 =?utf-8?B?eUs0WkFvQXk3NGpoMWRNdnVPOXFxdVFobTgrZ09UbTVpd3BlZ1lLb0tDWmZO?=
 =?utf-8?B?cm1DYkN6bDIxYmdPK09RUnoveUxvOUZxZ3NKSzc2aCtpbnpFMHhwOHh4Zndx?=
 =?utf-8?B?ekNPNzY1SjM3SEljU09VVlk0a21XYzhjZFVzU0N1dWFlN081TGE5L0NPdnE2?=
 =?utf-8?Q?ELXHPrrRnVz15DGVlMLdpU8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 872ae640-47bf-4167-f334-08da8c5fb490
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 21:19:50.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL6gWuTYAwBNiRi+vPcWip0U0OynIKJKBSlWodUB9K8bWzqZrG/9uBNaYf1eQqFOd2a8tO7ct4bpugGCQUifpaJuRGMp7X4TKoekZJTNk4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6930
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



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
>
> Added transition to PXP mode in resume flow.
>
> CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/gsc-me.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index 6b22726aed55..75765e4df4ed 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -182,11 +182,22 @@ static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
>   static int __maybe_unused mei_gsc_pm_resume(struct device *device)
>   {
>   	struct mei_device *dev = dev_get_drvdata(device);
> +	struct auxiliary_device *aux_dev;
> +	struct mei_aux_device *adev;
>   	int err;
> +	struct mei_me_hw *hw;
>   
>   	if (!dev)
>   		return -ENODEV;
>   
> +	hw = to_me_hw(dev);
> +	aux_dev = to_auxiliary_dev(device);
> +	adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +	if (adev->ext_op_mem.start) {
> +		mei_gsc_set_ext_op_mem(hw, &adev->ext_op_mem);
> +		dev->pxp_mode = MEI_DEV_PXP_INIT;
> +	}
> +
>   	err = mei_restart(dev);
>   	if (err)
>   		return err;

