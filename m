Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F063B5B0D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIGTUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:20:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD1A760DA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578407; x=1694114407;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gd3YTq1Oaz9K7Id5EGgEdMdJW88OpjBqsP1HrjAM33s=;
  b=ZwkCcW8XRQkNSQb0wz5MvD/3qvYBODT7Mb4F07fhhzauq4dgYAdBcZB/
   QpaSccID65/XDksbp5nHW9ROReSHIDAmVXSECcBXOk0zZDdKX1F86kHnH
   Oz7+0yzfqw4fQ8XT9qbNj80h03CMSTog6idpC3huamnj0WOYJ3snMyecv
   NBVDK8gSQT6zR9QzHNDJx3t9oWZXKnLe8IuSRL90mz26psTBjRj5klY9v
   4c6X7d/t7D8hI+sR2IZNVA9+YGROovSG0+3nrFdFdBsi0t9pXSs8LtgXO
   eeJPb1sxCR2p1v6kUksiuZmdV+IMkuacX6x+xmptoMWKKbSNLEywBNnPx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280007819"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="280007819"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="718263289"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2022 12:19:57 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:19:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:19:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:19:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsfeN2B/oKaHcXeX3avTjNKLYlfb/ovnSh+Jn/eWVRV+S+Wli4ink79SJGL5y7iKG82IWzgZe30oL0U082oF5g/VJFk1cz06Ksr8hQNVb7gBoAoQpa5LvRMw/TM1CFDBqKOSZeIccrDNEwuqfkEudWPlGT6rND2YA7w39zQlpqG+GEdVJsiAflKnoK5yx0fqGW7LhcjRRcGZsBsvwH1ae+wqJJLhutRQLDB6KWjTXjBRLnkul+/UjTdk9/ZsFsN3TK5/4aF1spRfEy28jrJqUq0HYMxeVyNQRfPFdDnxbEJmt42FkkaNy1SijX998krgIFqaDXUl1KW0Yzio8QglEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6Mmvh3iA/Zq8C659IKS+ShWLGqROgJUyuRcly9RoKU=;
 b=LaowiIc4Twx8FIN2rXkq9EVkkWEgPqIQaikl0Yw0W//lIOUuTMymOfpYnFawbgn0LSe4N1u8fPwElgFlLKSFgVpCskem2Rn1Zsrgd6JpCB7BBpnTBT3y5dgMz2/zn7v7AF8f3IpSdsTG2StyOJ7sggvDUbZXUJ9dRAGbALt2HKO5cFRZfFZ9p+lXHhxcietlTYjSUPFQ9PnBODNJil6+iWnqUgPwyhS2eIpvWskohxuZTFrWSkKPy9akFOtByVH/hUUiHtDzxVQ0ciIPMEbxF9XdHMNXf/kx7W9cZBbjoMBDeSYfw+6i5cIKli1ngfB1LIMCqkNXc54vxxaJDXZgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 MW4PR11MB7006.namprd11.prod.outlook.com (2603:10b6:303:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 19:19:54 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:19:54 +0000
Message-ID: <d83d1cb9-961e-2f34-46d8-f46836261948@intel.com>
Date:   Wed, 7 Sep 2022 12:19:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v8 09/16] mei: bus: export common mkhi
 definitions into a separate header
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
 <20220907155813.1427526-10-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-10-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd39f01d-d255-4cec-73a7-08da9105f1b0
X-MS-TrafficTypeDiagnostic: MW4PR11MB7006:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWDtGc6GT96vpRoV+z4ItRS6oOhZ08d9vHtbrFKm3lFlCeEtDlivBMYP2TCSD1g7Mr/4KgR3zjjYOeY5FgbugDX8ZhhBEZuXec44xn64xMt4PVbCNSinuS1wG66ZS782tx0rRHtnt9+VQgPiY4/8/fcJ4wg9q3xeR09FkBRYsfzGqacWCjYsMpXsUJF8jF5kPr35y54HGUgw10siRiUcvLeJ8pEqk1irRJPXep96VIseEUrip9fkEfcKBG/+WVYY3oSsxW0eyoOdy3vlyX/TakvNWv3LaYxnAaGbQXJsIWwHSYpsk6El3D/+TiOUvEvmwh1hv805t8/8aVSAy+8O+sEyhJXIJSsCFR+ZJAc3nRBeCvywl2hg391y0S1mBxCECy5tDAGmhINFMjjtPUh3hWSkgGeSkaI61Pxabd6L2epKKdcgZrJsAaPhgKR3vdOsR5dpZSSuWULxeJZEeh7G1wGqhZrxecNPgEwNG504+n2Dc86Yb2EwRHDgnYKlWVKMXQzfX3yD5tDliPbKUsbPRxNSguCB8ImRD/Q9CaXVpehWot4E4t50ten6Yhp3X7T/mWmNWmeAf6L8xjZcmUi5n5V86TWyV6JVR4Bgky09Txv6kBFEpRxG+FqGnVYQHedIv/QQMYYwjAxsOO+NTEnkUtqo+EETCnErY6IPlB/rGTjAX07a5G6LiukOIYTBTgc3Un4oOmt2zErQCbRERgy8vadjcStYW+u3kgznjI1/aX6NT9u7rK485bFOUApYXbOBdTaA+SW+3JEo/wViPDjwl3ezuRGJ3ChV0NrNB8ai4po=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(396003)(136003)(376002)(38100700002)(31686004)(82960400001)(316002)(41300700001)(36756003)(54906003)(110136005)(4326008)(66556008)(66946007)(6506007)(83380400001)(478600001)(31696002)(8676002)(6486002)(66476007)(2616005)(5660300002)(8936002)(86362001)(186003)(26005)(107886003)(6666004)(2906002)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVVJSllVREYrUW9nRjEvSm1VWEFkQk82RkpOaXJkZDRrUzZCRTFIT1hWOGFt?=
 =?utf-8?B?NHNSdTVVdjg3Zm1kSnZwUW11aUNJdFltSkdTOTZxankrR1hxVnFtbnB0TmVY?=
 =?utf-8?B?amxXWVNPdmY2c2dNOTBtMVRIcGJzTWhFdWhIL3J1L2paYzB0MlRqVkNwamVP?=
 =?utf-8?B?ZG02WlVwM1RUTGNGbW80ZUdIckEzQk5sUW9ETFV2ZU9VTlBLbnBKRVBXN3R6?=
 =?utf-8?B?d0RJOFFmdWxBUGtPeWlxK0RySy9sRnQ4MjFnM3J6a3hUZTNqV3NmWGRUYlpL?=
 =?utf-8?B?SUdycXV2eVJ3cTZIR1dsSVgvdGF3UnhBbERucjBMQS9oTlZsRFd3MFBoQ1VH?=
 =?utf-8?B?c1ovVndyNFljT0FOUHZSb0IrSkxkaklRbDlFTmd2UEtJbFJ0U3NnckU4NXdq?=
 =?utf-8?B?Rk9tTTZleGpaZ2lhNGZuZVh6L0FUVlJ4YlJTM1VNZDRrTDRtL1VwUFgxZjVm?=
 =?utf-8?B?WU9vc0NXVzA4eDNkVEFxV0gyd0plYWViam9IYmV6RzFzMUR1eTVRRUYvam1Z?=
 =?utf-8?B?cVBUd1lWbWF2OHVlK3JDa2p4TGwrTnczVFlldE9jK0RLem4rL0p2UmVRdFFq?=
 =?utf-8?B?bldJYUw4aUdORnNVT3JLeUFaVEMxOTBJbVJGM0RrcDVtNy9YZTZIK1YzRkZt?=
 =?utf-8?B?OU40TFlJM1VwanFzTExsRkVzWHREdGdqYnZvZVVUZnpkMUNNNWNSa1AzMTFt?=
 =?utf-8?B?ZElpTjFNd1pZdGdaMlFBV250V2VXVlVVbTNBVkZqdHpNejU5cHlpZXVwbU1w?=
 =?utf-8?B?SkgzdWtMWUVsdzNveXZNUWtDU08xcCtoQk9UT3RrdXNTK2c1dGF4cnZ2TzM2?=
 =?utf-8?B?amE3VVRxY293SEU1SzZIUEsrYXlQdEhIdjFyUDdLQUxIN013MGgrOFRta3RF?=
 =?utf-8?B?azByVXQyM0RRYnlYeU5qOE9NVEh6WVNhdjRKaWV6UHAzdTgrQ245NTlGcFVJ?=
 =?utf-8?B?L0FKUnlIbDVTOWo5QjdEN0wray9xRGdqcHBqVTRJNXJXbjlvRldBQ1Y1S0Vh?=
 =?utf-8?B?OSszek9lMHQwclA4SWpzQ0VkQ294SDA3VjFsS0llMzBUSlFRWkNKdVlTZEdT?=
 =?utf-8?B?TWhxeENRV3Y2aGN4VWg1Q01NRHNLMEpIeEVRaTlWM1Vpa3JGQzhMOXFZUWtW?=
 =?utf-8?B?YTJlcm1Sc3JPejk4bGxOOTVVT1hDUHgwVDVaUVV1OHVkejgzOXNXQzNEMHFQ?=
 =?utf-8?B?SkwvMnFvcTgrOE5jZUNnR1VoRVlXVmthUFJXYWI3cEVHT1hDN1hTVjJ2Wndo?=
 =?utf-8?B?cG1kV25QZWxQZUR5WHNqR2RYMkVtS2NJTGlQVkwzalY3OEYwT1k0Y0ROendB?=
 =?utf-8?B?SDhhUmg4MGRTOXZjVGVhVmVTcE1CbWRjemRabURaOUdPRmRhRHk4Q3VvVVB3?=
 =?utf-8?B?Ni8yNFc5ZTgyMHpsVDRvVWlsTmEvQm84MTZQd1hnQ1ZvcnducG8xUERYTC9K?=
 =?utf-8?B?R3dZWTE2UXVseUtQQW40RGN1OW91UDl4RndVNU5WMCs3WEVaVGszdW9PZlNI?=
 =?utf-8?B?VmwwTVg5azZFeWRiYmczc2dyY0p5Um9BVVJwK2ppOXRwbmIyWS9NQXJLNUVG?=
 =?utf-8?B?eWxtQmNlMWpTd2xHY1psSGVvaFV5a3piM0U4N3RmZEpDMjFCb1dqQW56UDJE?=
 =?utf-8?B?Q2lhSVdQbnBSWEtnMFBLdmpiRGQrQXpGaVc2SmhCcGUzdW1FVkFhNkxPSDdm?=
 =?utf-8?B?empRUUxnTWw5YkN6aFlWNXVTS1d2TEJWZndtRTR6eHN1UmFCcTVpNFljVWEv?=
 =?utf-8?B?MmM2UkljNlprYUtOOXFDdDd6clh0ZDh0a2tzTmUrTXRHZDlWUVNHSklxQ2Jz?=
 =?utf-8?B?cTdndHR3SjE3RDlGY3BUSW1YUkJKc29YMFd3YjhqREUvSC9RT2VENkJlZEx2?=
 =?utf-8?B?Q3A3WEhoRjQ5aG9YT09iS2dxSXRjNzRhR08vL0d6aHMva21RakFqUzdWSVFn?=
 =?utf-8?B?WTBUdTJyUXk1TTNxYmFjODNqZFR0OENyZGViVWo5WHdHS0FFMlBKVE1qUmhI?=
 =?utf-8?B?SFFERkVuVWhOWWdVYzcxeXpYZVBhbTJnajVGcUFWOVRDRU5UdmlMV1dkM2Jh?=
 =?utf-8?B?ckUrVTBxallRWEJRV0pvbW1xNy9hZ0kxZFprNCs5YStLY3dmekhnZW9EMzV5?=
 =?utf-8?B?Ymh1T2gveWtQOERxWEZvSHFLald0cDRMTWc5ZUcxT2FvRTRaY0Q3QWNlRjB0?=
 =?utf-8?Q?OH0MhgJPZ/1IthNvFglYCac=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd39f01d-d255-4cec-73a7-08da9105f1b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:19:54.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AwqfPAO7lmhK59hx5r2HZV+TQ7vMF4UmOji4qNaJi/6oK9B9scdVvuQaU/vVRHBeIgDfJ/SQEoRZTJcU3BZTSa5btuaZYBFb6J6VsEELwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7006
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
> From: Vitaly Lubart <vitaly.lubart@intel.com>
>
> Exported common mkhi definitions from bus-fixup.c into a separate
> header file mkhi.h for other driver usage.
>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>   drivers/misc/mei/bus-fixup.c | 31 +-------------------
>   drivers/misc/mei/mkhi.h      | 57 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+), 30 deletions(-)
>   create mode 100644 drivers/misc/mei/mkhi.h
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 344598fcf8e9..c4e527803299 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -15,6 +15,7 @@
>   
>   #include "mei_dev.h"
>   #include "client.h"
> +#include "mkhi.h"
>   
>   #define MEI_UUID_NFC_INFO UUID_LE(0xd2de1625, 0x382d, 0x417d, \
>   			0x48, 0xa4, 0xef, 0xab, 0xba, 0x8a, 0x12, 0x06)
> @@ -89,20 +90,6 @@ struct mei_os_ver {
>   	u8  reserved2;
>   } __packed;
>   
> -#define MKHI_FEATURE_PTT 0x10
> -
> -struct mkhi_rule_id {
> -	__le16 rule_type;
> -	u8 feature_id;
> -	u8 reserved;
> -} __packed;
> -
> -struct mkhi_fwcaps {
> -	struct mkhi_rule_id id;
> -	u8 len;
> -	u8 data[];
> -} __packed;
> -
>   struct mkhi_fw_ver_block {
>   	u16 minor;
>   	u8 major;
> @@ -115,22 +102,6 @@ struct mkhi_fw_ver {
>   	struct mkhi_fw_ver_block ver[MEI_MAX_FW_VER_BLOCKS];
>   } __packed;
>   
> -#define MKHI_FWCAPS_GROUP_ID 0x3
> -#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
> -#define MKHI_GEN_GROUP_ID 0xFF
> -#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
> -struct mkhi_msg_hdr {
> -	u8  group_id;
> -	u8  command;
> -	u8  reserved;
> -	u8  result;
> -} __packed;
> -
> -struct mkhi_msg {
> -	struct mkhi_msg_hdr hdr;
> -	u8 data[];
> -} __packed;
> -
>   #define MKHI_OSVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
>   			    sizeof(struct mkhi_fwcaps) + \
>   			    sizeof(struct mei_os_ver))
> diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
> new file mode 100644
> index 000000000000..43cadfb1b990
> --- /dev/null
> +++ b/drivers/misc/mei/mkhi.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
> + * Intel Management Engine Interface (Intel MEI) Linux driver
> + */
> +
> +#ifndef _MEI_MKHI_H_
> +#define _MEI_MKHI_H_
> +
> +#include <linux/types.h>
> +
> +#define MKHI_FEATURE_PTT 0x10
> +
> +#define MKHI_FWCAPS_GROUP_ID 0x3
> +#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
> +#define MKHI_GEN_GROUP_ID 0xFF
> +#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
> +
> +#define MKHI_GROUP_ID_GFX              0x30
> +#define MKHI_GFX_RESET_WARN_CMD_REQ    0x0
> +#define MKHI_GFX_MEMORY_READY_CMD_REQ  0x1
> +
> +/* Allow transition to PXP mode without approval */
> +#define MKHI_GFX_MEM_READY_PXP_ALLOWED  0x1
> +
> +#define MKHI_GROUP_ID_GFX              0x30
> +#define MKHI_GFX_RESET_WARN_CMD_REQ    0x0
> +#define MKHI_GFX_MEMORY_READY_CMD_REQ  0x1
> +
> +/* Allow transition to PXP mode without approval */
> +#define MKHI_GFX_MEM_READY_PXP_ALLOWED  0x1

Something weird is happening here. Those defs were added by the next 
patch in the previous rev, while now they're added here twice and then 
still added once more in the next patch, so they're defined 3 times. IMO 
leaving it to the next patch is better, so they should just be dropped 
from this one.

Daniele

> +
> +struct mkhi_rule_id {
> +	__le16 rule_type;
> +	u8 feature_id;
> +	u8 reserved;
> +} __packed;
> +
> +struct mkhi_fwcaps {
> +	struct mkhi_rule_id id;
> +	u8 len;
> +	u8 data[];
> +} __packed;
> +
> +struct mkhi_msg_hdr {
> +	u8  group_id;
> +	u8  command;
> +	u8  reserved;
> +	u8  result;
> +} __packed;
> +
> +struct mkhi_msg {
> +	struct mkhi_msg_hdr hdr;
> +	u8 data[];
> +} __packed;
> +
> +#endif /* _MEI_MKHI_H_ */

