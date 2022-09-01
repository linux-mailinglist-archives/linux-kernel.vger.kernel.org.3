Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657155A9C98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiIAQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiIAQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:08:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3F6915DF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662048486; x=1693584486;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/gjl0yNMlRAxLidGFsNqow2T9ofMHBHmKToaUu2yuXY=;
  b=PJNwfEk6XAtR/L59NWgUY70p9easwHyZSOi/+M233tioj8nhthMXwLzV
   bP1eWNNSf6Vq/idWyTKgn3oCts18rpgRPFuQ9BDr0JPtb6wAeTBGKKOgn
   CMuUFs9okaq2YbTRITdRLIYBhiNNbecePcWMdTtRg5iguGNgSpH3l43oH
   rB27GImnk5AFMQEuc+OvGRBcZKIViEbKSYkcgoxLlIxp/P9qmT/OLT2I/
   amMUQkDEJw1xLX5lQl5Wkwmxcb4SaYsdkOWx5zCsovzkiJSxub8eKHZUw
   Lbn166AGBFKdDd8HsEG71xT6mf3Xt8InKRrLf7bJRAQdP0gIUt0Q5b9wu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295766710"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="295766710"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 09:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="615389867"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 01 Sep 2022 09:07:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 09:07:42 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 09:07:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 09:07:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 09:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIDyhA9+phWavtfleLbXcxdWZeIGPGBWWWBQjoEVbnxzqGmq2GDuAbpMP+k7I6hE1gAjRXQm4AZ8OTrS2r4dfIlorsT2PDZz/XZ8BZU921HTHHN8aMJuGROaL+AtZSO7LOqHMxoRqOSaJrQLilV7IfWiwgsRb5PPt/k7/y8avciwD4TGw0Bw+tZCgJWjoAy678HTsILB9JkRwcenYDSjPAqUydEkXZl2UENaDG23XsoDAzsOFQNMPBEUiNKSxPkkaNvFXKiEloS6KwrO7VxydgLW3ofyFp5RLmzw9XvetHV9M8WaURVnPFEfIj9Z8uiMsrbAerL8dzJGj/Kb835uQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMdFyBS5BzfLPjG9nix2r7lvvHnZi77IWHpURfIUJso=;
 b=mVWEokjmwVS3chNiTRZEHYPYkl8uXXXpulqQjkMKuLVImZuGS9cVcyYB+7sNjAGymKBRkG1Si8Rhwaq8X5AcfXwcvUXVH7SLNwFwzlaHG93pZ3/dfwk1X1j7Tm5l1HMSDroF8d3+kCaxMiiv/j5rMJKvCQzMBxLNm1ZJ93HTAS3PoiSf9Imu9JIaexK2GO7YNlyEZaeqNstzRyMwWS9vTD+KhWHyQu0T13h6XtZfJThZhWqi8tGPUruBybMdef+wtluMZD6gj0svreQTLqmArJZu/ww2kl1eU2XpbolwbjYotwFm1wIFgGEwWjCIqlXMVZhEq6/Pl4yVPNu80XTnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 MN2PR11MB3807.namprd11.prod.outlook.com (2603:10b6:208:f0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Thu, 1 Sep 2022 16:07:39 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 16:07:38 +0000
Message-ID: <d50fec5e-eeb3-01e6-d81c-14032cf5e766@intel.com>
Date:   Thu, 1 Sep 2022 09:07:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v7 07/15] mei: gsc: wait for reset thread on
 stop
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-8-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-8-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ea4f2f-f54f-4d98-f874-08da8c341780
X-MS-TrafficTypeDiagnostic: MN2PR11MB3807:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elVflLekXpCCt18qC+6P6sdoNYe3atAHRzrY5NhuSo5Tp4UXMMUhMaDdWXwoUN3RuC4vEmLjq/4/JmB+gT4SV87Zv/7K5cZy3qvdHrKr+ng7cZTrHGfmstNzO7Vm5YlJPop3KHAELRNkhfELQcti2dSQN0sCc5fk0Tef1qgauPNxbPH7tdfGZq6+cmGCl/AZ09pge8Q8PWw2rSS7I42+b5byyh/Jt9Cw6RJO9kErT2U62/zN6+4Xi480KwwH7LRjJXV8WAp2MPyRwrwMkKll15noPMjV+0+Y3OcxnxhN0IF46+Ew25KJn2oicfFaOVL55/TZ6EQMnQDFle8C+ImHT5BN4lFqEjpznllqE7rolBhXlr2xnHx+EZXSLjlILgzVOEU/OSxeTatuTjtb5/t6sK0yY8OrpClXv+kcTCaNNPn7GLWNmAmh6dqSek7ivuP4YzCRi6bhn4zjZCFnMEAgs43go7jqrWiVuDhQkyHHAEYrF89GEO875QKL3b1GOjavm89y4ag4+X8obMlbt5nlYep3WrXjrpqRTlQSjQA0fWkrFWz8JnnT4uMxMrMirVBjTQwldkOHvXjqo9OWnAqZ+Mn5OEGjSIWuaGbTnN00LGJsYE4hgFHeucYNVglOL6lqM3RfG3ccHC1iJjn5M9q+66DDn7f6pZB20yxeVkQi0tcUaJ9Waqg2Gyl96YhF3NAci13MDVRNOKClF//IMC6FmaEJEsXAMxcYFYPdSh6jjNTZosQWG8DCCxOZbA6rX2BcXs5FEtOsLqwpBJtrn1TW9QBq4rgJtq8FQRuXLpD1QUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(39860400002)(346002)(6486002)(4744005)(2906002)(8936002)(66476007)(5660300002)(66556008)(2616005)(53546011)(26005)(83380400001)(6512007)(478600001)(186003)(41300700001)(66946007)(4326008)(8676002)(38100700002)(31696002)(107886003)(110136005)(316002)(54906003)(6506007)(36756003)(31686004)(86362001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlrYWkzVUoycTlWSEhVZC82TzV6OFBGRzFEcjZuWk04Y1I4N0d2Ly8vdWc5?=
 =?utf-8?B?S2xUZzBiZTQ4OVFzNUdnTmMrNFlBQTRVcFFmQyswRFdoS2lLazZvSmF0ZG9K?=
 =?utf-8?B?SUMrZS9mSnREYzBwTHlUOFZlOU9qTDJQOEk4aUJXZ05LcGZVWFdWaXpJalRJ?=
 =?utf-8?B?ZmhVMWEwS2Fub2lvRmRQMDRkVVdpYkxyNUZhZGNoeGR1dHM2eDRGeUp0eDI1?=
 =?utf-8?B?TnhMZmtNUUNlcTVZdHNkRU9WajNVKzdZQnppbDlUVVprTlgwWXRHRXlsdHlE?=
 =?utf-8?B?WnRPb2pDTHUraGI0NFY0KytNZXVZT2R1VzlhanFrK0lWWFYweGgwZmJmZS9S?=
 =?utf-8?B?Um1LWnBkUlBSTEpiLzFnY1NCcXNzRjREU215SzArV1cvb2FKeFJ5cUlCUFZq?=
 =?utf-8?B?NjVZVlhGY2lHTE9HWnhBbXdyWG9tNHF6SDZLdTM1TjI2aURnemFMSUhySTlM?=
 =?utf-8?B?MVQ4Mmk4bDgrb0E4d055OE5sRm5CdEFDTy9WWkJBa1RQUXlUQjljRHFFb2JS?=
 =?utf-8?B?MGRLRk10WlZmVnVJOS9YOEJjcm9zam9FZnVidGR4OHM1bDk1R3BLUERIWEFK?=
 =?utf-8?B?WjZncVpkWFpnODBnMGpZcEo4ZE9CWVdwRW04bDRjTzdpNjJvc3J0TXdDbnBC?=
 =?utf-8?B?QU03Q1c3anQ5N0JqZDk0TkhCVGJuTGk4TVV1cVVOTVRRMGhyaEdsbUZNTzEz?=
 =?utf-8?B?T3hvM1RXNE9rQkpON1VnaHNvSWhmOHkxa3pERU9KSFFDSlAwbXo3QVdWSjFu?=
 =?utf-8?B?RDR4WUFwdnUyS295UUh5ZkpvVmc3azZLTllpMjZxZ21XaXpVL2RvcjFRVWd4?=
 =?utf-8?B?QWprSFhXREtRRUh4ZmtlYVBGS3dTa0twN05lOU1SeCtFSldIK2g3UmVsZnhQ?=
 =?utf-8?B?OGRrRGpTZXViYVJTTEdJUEpnd29LQ1lNNVE1dkpMdGZxT0YrV3k5VTZlMUZx?=
 =?utf-8?B?K24wWStycXVlQ1hzVmRXVkhoaDVPMGprbG1FdXdJTVVRa0p3NmFiY2lyL1Fx?=
 =?utf-8?B?TEhidlR3bE54UmE1OXNxUlJsRllPc2lVcHEyanFWVnQvZmZGc2pWU1JDZnFl?=
 =?utf-8?B?UjFMamVLcFhXbmh3YWdWS2hncFc1NVRXL1kxcXlQbXNYZFFoZmRWeUQvWXl1?=
 =?utf-8?B?UnVmUDBEMDZhUjRlMjRuNzZBRDV0NDR3MzJyOE8rNnY1RzJoQS9nc3dhQ2lS?=
 =?utf-8?B?RVEwMnhnZHNEOElHUVgxenhqdDZ4cHFTQlk2RU14akR5WUsrYjFuMDFMT2V1?=
 =?utf-8?B?Vk5ObzNMU2xYdFlCWWVFcFBQN2RmRTB4dFA0Ky84TlcwNDRITmpPVkhqbDN3?=
 =?utf-8?B?ckJsUFhSNXFpSW5WR1pvRWgzTDF4SHgxTXlkcU83Zm9DNXJGbVdrVnl3OG5J?=
 =?utf-8?B?bkJ2NkxQcUR3akU5Tm9wUDFhNVd1Mm5yMlNQVVQ4NWtxQ2t5UHZHRm5mMDFp?=
 =?utf-8?B?L250UVJDVTJyTWc3RmI4ZXJ0a2hvVEtEM25ETWpSQXc2WGJsemRFY1pYVzR0?=
 =?utf-8?B?cDJwNHlZUTJ6U0pMdjJaT2FBeHVXSXNQK1F0UVB5M0dOSlNjUXhuQ0t4SnNm?=
 =?utf-8?B?UzRRNmtNT1ZFbDNwYWI2a3Bxb1dEVll2cXM1RjdWTUlERWpFb25EeGtlMXpX?=
 =?utf-8?B?SlpQeGQxRnd1aSszWWhRZHA3OXI5aXJscjhmQlg1cUNwZk81cTIyMmpmeFMv?=
 =?utf-8?B?WW80ZFVJR3VTZTkvd0twc0NTRE93YnhTZVpkeDBiVlhzTThJcm1EWWlVVUFQ?=
 =?utf-8?B?OUxEQUVralBSTGc2TW1zdlVwUnJpQWRUZDFzUWJJeVBhVExRU213ZTEvbll0?=
 =?utf-8?B?TE1tUnJlZDE0M1V0TTlHUGxLcmVqa3FMQ1BJdXBHSzBlVTBaV3hMd3RJaS9Q?=
 =?utf-8?B?QVRWdmFYdnZRZDVyM1BJWXJBMmdVVWlxUFpFMHlROXQ0cXFzcDgzRXhzUDRh?=
 =?utf-8?B?V0RFLys0OWRiVTh3Yi85RW93Y2lwWTNFT0lJKy8zQXdTcUVNdnFPdGRuY3Vs?=
 =?utf-8?B?MHh0bHQ5clNaZ1Q4RVRMQlYrbERiUDk3dWo0c2E3cjV3MlloclJZWEFFUXcv?=
 =?utf-8?B?eFpLcUxLYmY1T3EzS2RjWVVlM1ordS9QbmlZWHd4SHJJci9VajVYbExhT1Jo?=
 =?utf-8?B?TExWRjdhSjM4cG5sU3hHVDF5T28vV1QyaUMxRERiZEtvblVlWklpaE9IbkhU?=
 =?utf-8?Q?qFE/x8M3YlmZhb5mnUnVdCY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ea4f2f-f54f-4d98-f874-08da8c341780
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 16:07:38.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqnuCa8/iOkEh9G3o9uJowr7uzHm4mSc+ayK1CsXQ/bWtHpkIyFRJEZSblTI45Yk1tB/+1GDBJX8ros9hs24kN0HMP/fqeLGytt6Yl7GXgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>
> Wait for reset work to complete before initiating
> stop reset flow sequence.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/init.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
> index eb052005ca86..5bb6ba662cc0 100644
> --- a/drivers/misc/mei/init.c
> +++ b/drivers/misc/mei/init.c
> @@ -320,6 +320,8 @@ void mei_stop(struct mei_device *dev)
>   
>   	mei_clear_interrupts(dev);
>   	mei_synchronize_irq(dev);
> +	/* to catch HW-initiated reset */
> +	mei_cancel_work(dev);
>   
>   	mutex_lock(&dev->device_lock);
>   

