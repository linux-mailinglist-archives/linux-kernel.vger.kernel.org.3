Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B505B0CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIGTG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:06:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195D1A1D4B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662577599; x=1694113599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=89awUURDT6cbgsNq6+FtxZiow24nG3RycW6hZU2senM=;
  b=F5b+5telfzHII8st2yYDNcjwtVD+Us22CSS2EBMIw8w7yFpPAMsOf6WS
   PmH7DW9BFWjUyTmcH412zdskz1d5ond8cvCRirnUaZs0UjYTxiIZYtoZv
   hTwaVVpVRMIKR1eiEdvZvVPOJXhRJYODX9IlPqirQCsQmqF4NGE67Rex1
   wscFHGWWXUMHL2aE9MkIoXPiul9akTYhVGMh6N8n/19RcaNSGmHcXsivu
   ZOjyv98/wYSGg4NKsg5Hf0443Xmr9LwB4HcbPxTSGZGY8FjyU8l9Kq3rr
   yYEswj0uC5je7XmAUKe7Sr4lBK+n5cT+HlBKSrEnBmkifgHYYTIn+NFf7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280004280"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="280004280"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:06:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="565643561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 12:06:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:06:38 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:06:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:06:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXJFa9qLaBT/lzn8QjA4V7KLY8JRUgSCgU14VEqM2krjGkfBOYb0oOa573rxxOkzpYg759ubxOzgZ4CjBanIe3sqRglSm90AI6/BydeSKMb9MMnROFIoIoXIdjsVZQHbOvJV4Sd5IqbZPEQtJmcaveba7E1Ge8GuvNQaMT7oCDweqoh2edkMfFhRwyhJTUL0VzkjGnZKsdOV+IkFPtrjUrxS71iSsVCLtruqOShLZrLyRDFHjnUy9DhL9nFLHGHEQq1oiFKAj7NfxoyXbC6WMTCktKMWHO+y/Qp4BTg2+39XKfBpSdEZ78/23+GRqcbUDbelryxKq8cutkGEKLbyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42HqOHcB4E9KhpSi2bopvRAVWjUzrBuYrcGP1KKIdlM=;
 b=ONeYzi6z1HM7U70zgd10PsJ+8KQxDoWoD4h6hf1/TiqW+HSOp+2m9YncEwtdr5iCc8IKII3OJry5VXf1i5tsVe4hjTf9usgfkXBWD+H0RJgv31fANawP5HSDwRM1/62SQ6rykoJsPtLqSYSlMMfeBLMw20T8w1kuN4mqc63O2Ifwi2WWYarLm66NJX3uuLi4++A47x6D/0MV5tcUxa+asUkmfoioLpDOsHdM912cmNk8Wf1TQdAp8/RKaTNnZ6r3Hvrl9c8DYv9LNzdCoRQ8koDrtooW6TiFx00Ff6Rn4TxxnUdvUdUA4mlg5dQwvPQZ6Y2wfU9aVl6Ruyvs0Xm6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CY4PR11MB1832.namprd11.prod.outlook.com (2603:10b6:903:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 19:06:34 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:06:33 +0000
Message-ID: <cf73d4ca-4e19-aaff-8b45-ccd32f95a496@intel.com>
Date:   Wed, 7 Sep 2022 12:06:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v8 07/16] mei: gsc: wait for reset thread on
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
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
 <20220907155813.1427526-8-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-8-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aeef8fc-c152-47e3-b7d2-08da91041469
X-MS-TrafficTypeDiagnostic: CY4PR11MB1832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btQ76fGMc+Meud1H2g74bhoiVid8nKSCXBoR+XIZOUkwvmLlLm0vuLgTTGu6ZkIqmPMxBOxE3jrz1VZX3OvAY90+78weeEEePuqPdR7np4qRtKPYgqvVdDsh+AGAjDWFaWdhB7I+KzcNeoY9+H6LEDxZy1oDhu8OZNTEiAsdHid8L8wfDD858OasofvUyD1FCOGyr+HwtKuy86iUwTRA9hbhPvESZH9AqSH0WEca2oGNbo8Jgqcq77SHiNr4a1fY4ha+7ovLvqgaMkBzcbzl/EGPKPhkogYVKAuRY5WJrzRnlKxRS0vWWrl4o61k1RtTVgUjYZxb1ph9FrsJ49l+VuOm5O3RqX8ETKqYvqGHHqqDkFm8gjfBvg97xClKBWaafpDXF4cdQ/9QpnyIO3H2glYWwXPCVlFXE8Jet1lClyiqveUYnWRdsiOj93SJjBuW/tzMEQFs1O3IIr+StWxqZxIaxJC113sIxDgOXfPA6Mdg6SKZQwBU74b3WKIClzLu5qnkYzMwP5MA2aVStPegJQXOLXfjp5pP7fr1otoARkn6xWlynx5aIZdwuK7/HDZpY6PeyPkidOxMYsMomiisghlWfpjRJS0gHyq9GZaxXJOBqbhIMEr+qNw6BPQODFmxOFyhDt3IILRdSDl48SGQdkMNTjlc1DMu1gFm1Ibp7UD8G3w0ulFM5WfnifPl4fGgJRMaUI209oz7hMbBZE7Koe4hMnhE9B0EbtcGRe9yDwB7RlCGup96F8J8wCuSm/tQGlI9BkvYfz/g2886fpQw2J3/gutTUuTwbxFshQSV9RU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(396003)(366004)(41300700001)(6506007)(186003)(53546011)(6512007)(2616005)(26005)(107886003)(5660300002)(4326008)(83380400001)(8936002)(8676002)(54906003)(66476007)(6486002)(66946007)(66556008)(478600001)(110136005)(316002)(38100700002)(31696002)(2906002)(86362001)(82960400001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhNU0liZ0dsdXUxekhCYzRnMG5nUGxsMVhmS05RK1puTkhTMEI0TUJaMjBK?=
 =?utf-8?B?WGgzRFd2dFJhMmJDeXdmTElsVzZ5RitOSDRYaWUzcWIwNk5nalFIa1lFR1lz?=
 =?utf-8?B?aHIwUGZXaFplMStHdXZUSEhqd2F3c0dWMEM3ZjZxMWZNUEV1YlRBSnY1M3Fn?=
 =?utf-8?B?eW95cEJFWXhuOHJpWFE5alMzNGdibmVxTVNtMi9GU1VBRmFlUi9JcGhVRFZ6?=
 =?utf-8?B?dFNxN2orUGNHY3JHOXlMUXA4OFRVVTVkbkRHQkZZaTR4OEdwejJLRzlSbVk2?=
 =?utf-8?B?TGI3ZVowVjRxcUxkNlVxNi9tVzZkRFU5N3JIVEZCYmZ6N3prVnNyMFYzZGw3?=
 =?utf-8?B?V3RMYmdidEp1R0hNaHRUcEpoSmVEL05CR2pLcHlyUmJDN1haM2MrcDNHQXo5?=
 =?utf-8?B?czhsWGNrTW5FcWwwdk5HSklFdkludlVKaUxpMmRPZTA2RWVpVXhNVDI1UG1p?=
 =?utf-8?B?cHp2Q1N5NnBwVnloc0VCMFhSRmljd3RkRlp5MVdIMlFpWThzN1d3RGxKRGZo?=
 =?utf-8?B?c3B1KzlnTjlDSmcvWGk5NDB5UFVQRlVIUnJwQ1Q3Y2UxNTlVK0xHc0tKSjB2?=
 =?utf-8?B?dXZDWmM3QXhiTE84WTRSNHFHQTNTODlTclFnM3MzOVFRZ3NYSU9aTzZqUHF5?=
 =?utf-8?B?QnE2UXJJMU85akxRTDJlWnpOV1h6M1dtc3lIWSt0NDlFSExzaFY4ODFUUHpa?=
 =?utf-8?B?SnFaWTRnR1ZybzRjR3REaGRWK2VESzNpU0xtckxaK2dWL0wvSDcrb2JqYUR4?=
 =?utf-8?B?YVhickxmTWloUThrU0RRUGo2T2J4VHRDTXpzWXliclI2QS9KWFZDK0ZmdmlE?=
 =?utf-8?B?bkFNWTBacWxNQVZVdm1FM252VDZkVDJkY09GUUQrazR6ZjZndmVsdXV1MGd6?=
 =?utf-8?B?ZUNHTjEwaXdlZWI0VTlzWUZDbTh5ZzdJdllTSEMreFBOSllPOGNWOEVKNXRO?=
 =?utf-8?B?bklBNWNZNnRjT3hHU1JnWjF0WHlpVTZlZjdVQ1drT0ZxeURoYjl5KzVWT2hn?=
 =?utf-8?B?TnhuOGRnNHdRZENoSGhMNXJOeFY5OGtoQ0dEcnZFVVhZbmhac0c1eno5YTQ3?=
 =?utf-8?B?RmhRNDZFMmVncHFJSXAzRi9xbGNzdmtFVkNzb2Iwb3ZVR0xyOHNURDQwV0c5?=
 =?utf-8?B?WWxHemhZQjRXOUVDQnNDK0ljZWs0MEx0aThwRXZCZ3ZGdXhOTGdiS3JQSmIx?=
 =?utf-8?B?U0YzSS90ZTBSSng0UkZOS3EyeW9sR09qTm5JVExpUjIzOEhaRkdmRjZFaGpm?=
 =?utf-8?B?aWQ4c2NVYUg0eE4vc2pyZ3JuUGhxNkFRUUU1Mm4yVGRRamJoRzFsU0hlQ2NQ?=
 =?utf-8?B?WmlwL09URzl3UnQ1VjVhSDU1czU2M2dwOXJsMTFFbUhOV3VjcmNYNC8xQUl0?=
 =?utf-8?B?SkdsYytvaERzZkNUWGVvYmlFOFNsZlByMlp0YmxRR0QwQ2svZW80WEYzc1lI?=
 =?utf-8?B?RWw4cnIwOUxiOGhBamVuck9VMzc0VG50T3U0dko3Ukg0bEhGdDdBcm45S2ls?=
 =?utf-8?B?cmZNSVZnenZLTU5IWHhab1p6TFRCMzdBdm4xeW9xTWxhbjZPSXlqUnFlaFpM?=
 =?utf-8?B?OGVKZzc1QmxhcnIrVjE0TlllTnJ5VTJmcjRqRmJrWE04RUF1TDRYMVV3VHdK?=
 =?utf-8?B?dGx2OVRkY2dhSzlQZFRFdFdYYVAwTTh3OEtNbGQvUDFqeTFzZFhKbU5zSkYv?=
 =?utf-8?B?VFVGQlloYWkyamlYUHNPSnFWTXY5VzEyL2dvaUFQandQUjFxOFFiRHpVN01h?=
 =?utf-8?B?N2ZzRERtMGdmdWNFTFA1dnlyd2VIRWV3eUl5UUFvZzQ3dnlrcUU5dXoxUHF0?=
 =?utf-8?B?MDlCSG9JWEI0U25GS2ExR3dCU05EcDVaZVlmY25tdmtndkNtVTRBcTlTNzBz?=
 =?utf-8?B?VjVqOWd0QUNjQ0sycXE5TVJ4SnIyOG9sVW8zb0JTM2diWjZYZzF2cUREMzND?=
 =?utf-8?B?bG1Od3FOWGJXNUFuam9PaTRkUW1NNkRzR0REL3haZWpUSWtldTI3SnA2cDFw?=
 =?utf-8?B?SEtEV3dEdnJ5RHBQdnRPNXFtNWRvRHZXTG9PcXNXQmlzSnFETnNtTVVjTVBp?=
 =?utf-8?B?TnhxL01FN1JYVEhZRFkrbE9LUE5lSGZkbkM2N2I2OGJIbUdKYUVwNEpNZzhj?=
 =?utf-8?B?R29IV1FvN0dyU1ozeGxGcDFzS2kxYmFDdnE0amwxcFQ5dmhlSDlWZGxqNnNh?=
 =?utf-8?Q?3QJhFzkmP7LnGko0rqMXcBg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeef8fc-c152-47e3-b7d2-08da91041469
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:06:33.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BePYizhbEmqV0NzA4Yx+62XpgDnLgEWvNuPEEjgabfsfm2dDb5Rodwg5VLIMBfFMIVUpHmU47LM4MuzOgylmwGFme6vBe1ZGA9l5Lua2CDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1832
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 8:58 AM, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>
> Wait for reset work to complete before initiating
> stop reset flow sequence.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

This is unchanged from the previously reviewed rev (apart from the fixed 
date in the header), so this still applies:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
> index eb052005ca86..bc054baf496c 100644
> --- a/drivers/misc/mei/init.c
> +++ b/drivers/misc/mei/init.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
> + * Copyright (c) 2012-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -320,6 +320,8 @@ void mei_stop(struct mei_device *dev)
>   
>   	mei_clear_interrupts(dev);
>   	mei_synchronize_irq(dev);
> +	/* to catch HW-initiated reset */
> +	mei_cancel_work(dev);
>   
>   	mutex_lock(&dev->device_lock);
>   

