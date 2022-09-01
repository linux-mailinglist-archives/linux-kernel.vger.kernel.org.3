Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26665A9DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiIARAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiIARAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:00:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB84F662
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662051635; x=1693587635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h7ppHHVJz9w62MGLCm6P0uKpaZUHBDEkxUX2PMLSjkU=;
  b=YtwsiW1fSkJT0kI+mJTYU0Tu1D3usHtQ48ETNJarUTLZkKawGG6hVd4R
   u23j7HdyWW+XPyua6wRcZOnXGdPGwpWf0qlncGCFFpnvWpvZs8IKIqttu
   kFFKNXw57v4yDgzU1DOmEWWk+hnlRvkzbKAC9UELl8jpUjQtDGQKq5T30
   ZrLmnH90yCMBvmsPZfM3KAMaABJ3hQm67UH2tSuCqtfWf2tdD7LAjM5Ln
   ulaOcwNTvjGDxshqw/4hSi6yrS8UYDyQi+R3xfTTRedidMSdQz+2cT7vd
   VIfbMc3hwyQWD1yBSNh9sgXho7Gn00AdF7fb+dPYekknRumoJXkuK/3is
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296555482"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296555482"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="642418628"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2022 10:00:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 10:00:34 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 10:00:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 10:00:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 10:00:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mika3PVlK/6+LNP3jy5gbO1ZoWN4aGAq/zmLYy9JrRor1Kehj6OdbPyyer1D3C8oI7ssiHtWh/rczdcqaQE1NjOE+60O3kw430vADzDxeKDIb3xyrwH94ydOvDbPiYJ7ZGcLY+T1df6/auMxddz0v6GN7yCxrXgcjde5vLBpny7wta/o6H1EEZzKQ9SMDGO/fhzzPO6BY5r0tb5lbyepAwAccvjznwzUOguRHlrFXHLfaOlLVIFyaaKWL0gJX5jrk48FEtStoVgmJyuou+oJ2TiCSaubHjjrz2tj9MhnVaGuG/WJSZBsOgEpAZzqmrDaSLDr8zKaH0gKpOF/73kFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjX7367mUMXIYNy1jBebUrNlIt3mGSeOVpEh9W2Nfpk=;
 b=XkB3JW8XkfKhEtWyX46y7aOjyKNC/zQ+/LwBuMgPNHThVC/z0xmsgQ7/0j0QcTYlNkbq9DxiHhhWQYNGNWwzA3qmDhr6wthm7Du4cHZKZk+WQpAKvFnfFdErM0IriQSgzBVYP/AVvuSxi5eoV6yRK1tRxusa+faDV9SKFUrjlZd92+dw4rAp6psxPogOgaAQUqaOLuXtN+5Evdjal/baGzxZ5Bth+kBGLXDvwZY0GGHCO2l13wJg4YtDqXzou7gZ52q6xmBw/+6RbYJve88nXUXVebZgI1mWugiGM3VwSMyxIfin3WjyRMRj8nmeJVBwAriKacfwFnxPScViw8ytZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 MWHPR1101MB2317.namprd11.prod.outlook.com (2603:10b6:301:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 17:00:31 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 17:00:31 +0000
Message-ID: <6103b060-b3c8-6af0-bf68-4b2d0ddf8f9c@intel.com>
Date:   Thu, 1 Sep 2022 10:00:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v7 08/15] mei: extend timeouts on slow
 devices.
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
 <20220806122636.43068-9-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-9-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd14fafa-34c0-4d19-c8fe-08da8c3b7ab0
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNbKypy0cKqh2PYM02oC1dVmdyLJPUy2EqEETCAp00Ggmw07LuSDL4ZfbPepvrfHzESsKIi7TYxKPUhj7NwdUI6Umah+nmk2HS1rGe4rU2P8L+dH18byRXfNSYom1JZuw/xEhvft//ah5xxIU9jjgogDZekrNiscASbTzNhy2ezMxksRUPkBVcuqtJI8L7uyHx88baGYdRrvtDkBNCQLeyCLJNiQZNe1Z5yfc/DngvcW8cb3Pj1nM4T6+hsQUMq+m9UHvG434j2Z+sAVyv7cXYR5e6uBeWuaikjkugFgIFtzxeueZe/owSo79AwAN5r0fGWGEWtK9jUHsT+gSZYFk55IwN9YHegnMT2TNYTeMn84bp7aEOCz4XqOJchyzZeeaVONigaCgTtt9KAV+/TNn58ncuBWZuexVW4z+lIFy+9FTeBEKyUzqUdQ0gONzgCnd8x1iIflR+vO5UMwPFYpSVwwYyWy+39aGcC7J7btiTQXy0N/bzQOk6wej4oWb1WWRa8A8A+0UoPFQYBvDA4SamgOHgj4lucaGzEBDDVBStJNybUvlYhB/LJInhe2H6k8IIHDYhOWVbwvQo7BGaIthtjz0T2RarzK2R67Rjn2h8syv2ZCU4PVYONlGZTznRKsdF9wwz1qX9ivJND2SDsA5fPDIwYqGrhrTXNSFyK7iVX0XStk8wP7uUwS/68Nz5AgP84dHQXQTFE7Q7DACHt8NRbn3qVF0SgXqVN9J9e16biAdD4AZV3PnOpUvAYznMthX/hvpRXh9RvGKxGSIWpuAI0vY0SrP8dJKQsGxYKYrVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(136003)(376002)(396003)(186003)(2616005)(83380400001)(38100700002)(107886003)(4326008)(316002)(66556008)(66946007)(66476007)(8676002)(31686004)(110136005)(54906003)(36756003)(478600001)(5660300002)(6512007)(6666004)(6506007)(26005)(2906002)(6486002)(31696002)(82960400001)(41300700001)(86362001)(8936002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Y5amFJd3NWRzdIYXhWSjY5YXJVdTFrTjZUUjRkdU5MdURnR2RydmpTcDlZ?=
 =?utf-8?B?RnRPWmtZUkxHcEYrRHZmb0lQb25ONE5LdlZoRDByamduU2JRNjdiTFdkRUVD?=
 =?utf-8?B?cWZTcHFXcjZGRzFvQjhvUDNNbnhLOGRucXZsNWJlK0YxcXBLSFFEQk5qLzZR?=
 =?utf-8?B?OGpxUUNJWG42NUEwVFdXVlJzNENMWlplbnpLRVJ5K0dPUm5ac3RrMjNTVWRZ?=
 =?utf-8?B?bWRZdnQ3cWttdVVCczlPYUxROW96RnJNN3FWZElLNnYrT1N1Q0didXhyRGNt?=
 =?utf-8?B?ZTNNMzk3d2NSZUV2aTl2azNRSGgxNXkvSXBOV1RzUDB4bmRqT0NhekpETENX?=
 =?utf-8?B?UXJsZlRmbFB5V3pkTzV0eEQ4czl3S1lqVG1LaVpucXNMM09NSFA3M1l2VVJ4?=
 =?utf-8?B?SEkxOTFabkhLSll2cVdkOWdRK0tJbHlsUDFHTmtxcDZnVFgvQlVhN0JwYjN4?=
 =?utf-8?B?d2Jad1poUmE0VHM2V05la1o1T3ZkTFVpM2lJWUcxSDJ2enBZOE9mTkdpN3hX?=
 =?utf-8?B?aDVPT1VISjlqVmYyMzdnZTBMSHAxc3RBRk1kbmJtQ3FNQ3BZemdLM0RDSUxK?=
 =?utf-8?B?L2dKTDlWRkdvdUxvV0VzZ0dMc1U1WnYwbW5xQkhxYWp4ZlZXZWlTWEdKdmlH?=
 =?utf-8?B?RDVyTURYdmpHNmN0ZjBBSU5RQmVkcllLYlgzc3JlZU1RM3JOelpEVEJuOHJV?=
 =?utf-8?B?NjBXY1FVbFF1Q1Z4K1Z1eHYyTUZTZk9YMlRlWHFYVW9taHF4cy9RQ2Z1TUZx?=
 =?utf-8?B?RkZsZWtiT2FEdGxOYWswT3hTREZJanhaRVRzSE9oM0lOZytlV0puQUdoYllL?=
 =?utf-8?B?WjB6WXNiMStHNUhwckxnMzNISXF2dExKUUFVRHVKa0RpQjR2VkJ0Z0k5TzBB?=
 =?utf-8?B?YkNlM3RwZUFFcGNzUE54UzhXc0VCc0llNWl1azZBZnlQcEJDSWdIWHdtQ1BT?=
 =?utf-8?B?TnBzdE9ITE1Fb2hVaUJIWjJ0dVBzc0p3R2I3R0ZKQkpUTjl0Tm1QdVEyWXVJ?=
 =?utf-8?B?amR0MWIzMXIwZ2tBSEtSZElhSFE0Y1R6V01TdXVHMDJSOFRlQ210REdKbzNR?=
 =?utf-8?B?a3pOOGVRcEpuaHQxQldxVWE1TXJUdkpJdmozbmV0c3BuZGVOWjh5WTF3elR0?=
 =?utf-8?B?RWt6Sm82L2lVWmdRVTVqSG11OGIwRVU0MXZuUTZtU1lrNGRIdVZ1TFBGZEJV?=
 =?utf-8?B?TnhkZ3M4dlIzRllUMXlHZDd0QzB4TjA1Y3VUUTZkRHJRakN6eFUvdWMwR1A2?=
 =?utf-8?B?dW9DVmtBZzNFWVhqVjRBN2cxUHIxTUtLV0E3ajA5bFIybHJpWnMwWG5CRzVl?=
 =?utf-8?B?QnljNlBIay91MXI3V25Zdk1aUXR2Mi9OTXI1VUhsUFRVaysxYnJ5NFI1Yy9s?=
 =?utf-8?B?UXdGQjVUbU43SVV5d05ycDVzam1uTk1MM3kyVUc4ZVQzUm94WFNUcjg4aW11?=
 =?utf-8?B?anNkVDBTc1QxTy9mOU1uVXhzQS9GaFpHYzB3aHhQZUN1WEdqZWM4V3hDRmNx?=
 =?utf-8?B?NG1oWmRDcnBlUDFEelJCVHRKOEljSTd4eVVCRTlMUnR0TzMwWmxuNDFhZUd6?=
 =?utf-8?B?bSs2NU9PcHhQcHpDWmJoQmk3VGthcTNtR05hSnhsQmFQdElyaGp6Z0NzMHRD?=
 =?utf-8?B?Z0VrblRNc1FjeUVGU1ZJYURmbXZ1N2pnQjJvdE1kYnUvSjJBMWdXemZCbWI4?=
 =?utf-8?B?OTFoT1Q4L0dKbFY0L1N0TmovVFFIcisvcjVSeVB3ekpINEg2MnhkTmNVQ0I0?=
 =?utf-8?B?MTlyK2czdVJjc2ovUUxqMEx6WnFEcytMZlFqdWVOdW1rOFR4S1Zoc3orU3Vr?=
 =?utf-8?B?WlZsa3FTeWhmczE4UmJmYTc1bUhRNms0M0o5MUNSd0pGWmlaMFYvMFRacXdT?=
 =?utf-8?B?OFdjRzE0aFB5ajU3UnpQNUdnMHl6MzFVWXVMSkRtRFI5TFlMQUxOdFNrUWgx?=
 =?utf-8?B?M0Z1UFQ4V1RkR29KTVpIVUJkRkJqc1BPOU1DMVBORS9tc1g4N0Rvc3ZHbW1y?=
 =?utf-8?B?V01GeE9KTjNPU2k3WU9TMDFlMFdyVVhlbXBQUCt2Vm5jZEphcFJEcVNBc2JL?=
 =?utf-8?B?bWRiRVBYMVJpMllqQzQyS2Q5bzhTUGo5dXFFb0VXZ2Y0Ni9sdDBkbndNcVUx?=
 =?utf-8?B?Z3lSMDZmckNZbktIbTQzbEZlZU9ERXhsN3F1cWNiUGVSUUVTUU5vWlBQb3I3?=
 =?utf-8?Q?JdtOUJ4buQHQMKgXErzvNwY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd14fafa-34c0-4d19-c8fe-08da8c3b7ab0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 17:00:31.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rqlDImjB3XRs/z8A6roQoFn/S7Ol3bTKB6hNGAbmgxDmf3ZUCv2lZds4GTMiqs97aBLSnimwvRLCGXf7jCBakA3zHrXFFHa4LhxdE2KuD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> @@ -990,7 +991,6 @@ static int mei_me_d0i3_enter(struct mei_device *dev)
>   static int mei_me_d0i3_exit_sync(struct mei_device *dev)
>   {
>   	struct mei_me_hw *hw = to_me_hw(dev);
> -	unsigned long timeout = mei_secs_to_jiffies(MEI_D0I3_TIMEOUT);
>   	int ret;
>   	u32 reg;
>   
> @@ -1013,7 +1013,8 @@ static int mei_me_d0i3_exit_sync(struct mei_device *dev)
>   
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_pg,
> -		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED, timeout);
> +		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED,
> +		dev->timeouts.pgi);

Shouldn't this be timeouts.d0i3, given that it replaces 
mei_secs_to_jiffies(MEI_D0I3_TIMEOUT)?
Apart from this, all the other replacements look ok, so with this fixed:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

>   	mutex_lock(&dev->device_lock);
>   
>   	if (dev->pg_event != MEI_PG_EVENT_INTR_RECEIVED) {
>

