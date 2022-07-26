Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16683580F82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiGZJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiGZJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:04:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F012CE26
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658826249; x=1690362249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s35tvsiaXT2vI3gXcs+h5kk3b/4zHjUJdeTWLuN9ox0=;
  b=jugrfinSYMXpdgW2AclxbOnHEHIOnmJd/x30+yfNsqyl5H4wgm4bwwGo
   zZpDqkiEE4Qv7H4y4EE/XnTYQqUPJDsu9yHj32TSy8a59g/FK5EDO6f0J
   LNastK0j2XAQ/X2lEyk26tptOegcO72EiMK4NqD+x0JzC2iXkqYRaX3xW
   4H5mWzup1bnGZjw6JyeZlfVohSuSfgHaIu1l49jQLXYI1OdGMspb9IIfw
   OBh2gClOvhksrGZ1FCHRP0gLMK62XZRTHqPX5DPxAQ1Sn1SZQe1gq+o4u
   i2yQ+chL2+Y5kN6kWHVTmIWCa8zhX5YtCyG22fZPCrhyTh6Uz2H8RzhRT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="313663880"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="313663880"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 02:04:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="550326121"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2022 02:04:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 02:04:08 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 02:04:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 02:04:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 26 Jul 2022 02:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4jy32Wljq2hxwHAoFb+XDkL+F6Ttz0l6whgtbNG8REE6aANrQERJymws8NdrwBAvg6S3kg5vqm+AP30CDR3/kaiVh6EoXeQPQjYDwi7AOTRYjrdj5c4yQXiwiFdYU2qpDPrkJURWYG4ZBk3w4JwoXq4gaffgz/4vSoKnJ8hJ0tcCadp5109rRWuHxvD8d9fgNKrV/byzKyddBdWPiaufQXzPc8zEnj5cYzTqUmbf5W0xlgJoGZGatvwsrhpU7HsuPY4+zQblVUyXh5h7q9YjqNWcbm97YR4CnPMPdB7gWCYKrCJEWXXkabaZ8I4SVenbnjydfUnaIt2RmZT/izj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcXVA+t++2SMMpKSGyqvcAzPLl2srKKZwudF3GbN9mE=;
 b=Ql5RktzugMmdSonU7ahHWxbhHuSE0rcYDrw2NmGE2vlxt3Jae0uwGxhKIBvVzV/T11T3ALDsWl0iPPEJptFGmX/TqAvMUAAZfKgGRsCBMnhvnisHuZXh15LiGvmscq4acs11nxajxNRtvD6zTAlEHQ34R2yq97zG8819E19EIY1mboWql41wBLFYrQHld/SBJVRPapjXw+zbTuqP8lT/pRKYloDwfqzFjszIJnvAV/8epxlWkYy/53A39K5KYSl8IYCctzHGac8Aai5Lw4lQMpT5CgwtlMlPWDy+kqmkrAeVI5gM57Q8S8fiteRA1vNic5myyUR0+wEmdbxaTskbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 09:04:05 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::c4c:c434:b2ba:2899]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::c4c:c434:b2ba:2899%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 09:04:04 +0000
Date:   Tue, 26 Jul 2022 17:03:55 +0800
From:   'Yi Sun' <yi.sun@intel.com>
To:     David Laight <David.Laight@aculab.com>
CC:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "heng.su@intel.com" <heng.su@intel.com>
Subject: Re: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Message-ID: <Yt+t+zlen1xHXhS1@ysun46-mobl1>
References: <20220723083800.824442-1-yi.sun@intel.com>
 <20220723083800.824442-2-yi.sun@intel.com>
 <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad34615-70d6-40e4-329a-08da6ee5c9a6
X-MS-TrafficTypeDiagnostic: CY4PR11MB1286:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwUaWMttin8rNST1vsob8OqpxUa/RQ6sPmut8+BxyPutHHpsvpt36FRE42Khzh/YLVZHEMzAjGjWJsNaOjHVM1wYsVxUMxXTcaBO/tpXCIFaQhX4EsiuAyGPpdJF8TnN8DxJnbA8OAlsWEwQGE3ebo4FpCCgRefq+29++yuCZw0g920bo5GeJov/Y+VVuBDJRW6X+J9fXzcbOPk/DsWEraXJOdoVpC10tCyglvXr7u3ytbPdAY0sKEJkMy/WIZHjrSg9oVpu57NDxjGiU8d1J+qaT2rjJXRGyuEvAkNtye/xGhWUJdHH8ZmNX6PQkIxU6UB9YpaZjpi80wcqJ2r3oraC655wgQfitOf0X004jYPiQfTaq1fO01GmhG867aZnjimnuXx+g7xCPidoQmfXTyf1mq8I5XUx5fziYAewTAkWWUbK2lVAFVspycarIA4sf54DZL5gii8nP4ln9L22OgUsYfJU0ghz9pwoCCL5UtFgV6iZNTSVtW4UMhppFuM47FfMPf84XKiWg/jgTZDcNUzNH+VYCfftWQIUeSAy1VCUYoaM4ft5TMtwLOQ8QxDMpdZs0KVYkkf4jW8mmetiq9qcz55WyXFFDo1NyTUdtur1iVYn4M8UVRJiacrMjEkZpBN+34aHowG94sHAMe4sspp73IJwp6N9ObWxklFQn8grEokRxuOmn+zaL1C1akbRjoxGdNiCZMCnFiaBUKNQ02mJajUm/pXFddskMbkiHbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(39860400002)(376002)(346002)(136003)(186003)(107886003)(8676002)(4326008)(66946007)(66476007)(83380400001)(66556008)(54906003)(6916009)(9686003)(6506007)(6512007)(53546011)(6666004)(41300700001)(2906002)(26005)(86362001)(38100700002)(33716001)(5660300002)(316002)(6486002)(82960400001)(8936002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFFRW1mclp0ZTR1eU5jY2tEbnNFZ2NCY0ZsemptOC8wYjFiajZtcXFSZDRX?=
 =?utf-8?B?YVVkY3FVMHlKeEs3L1FnTTBCR0FqYnFDNFNIM2dibllmMVNkTHZUYTR0cVlp?=
 =?utf-8?B?a3F4Q2EwTzhUNDMzclN5RHVtN05aQXlpb3R5dFgvcEtEaGJROTNYa0JJbnpF?=
 =?utf-8?B?bUd0TGcveXUwQUhBQ3JRcjY5UlY2VVNtWEFwWG9UR3hDMTlzNDZMTTFRenpD?=
 =?utf-8?B?d3h1RFp2VHFUYTBGMEVlRk8zcm9weTlmUW5BM3RBQWw0c1BjQXJZcEthUm42?=
 =?utf-8?B?V0Z3WittNFJtRVFpeUpLVlBkSnhmem5ZZmFOU2RZWUhrakhFT0VwZVZ0QUdT?=
 =?utf-8?B?N2k2TnlDc21BMTFnTmhmZ1hVNmpEaXVRUmNMaHdtZnBtZEtYb2Z6aTRmVkNK?=
 =?utf-8?B?RWZJQXo1RU9ibGIvZEdJTWpPaGdZKzc5R1ZTRWRLd3czdVZ4Q2FDQzI2TnhJ?=
 =?utf-8?B?MmFFQk5PUklSYkwxZ0pBemFwWUZtREZwQVN4dEpvL0lKVDZPb1lrT3hiTkkv?=
 =?utf-8?B?NFgrdFpQV1Q5K1NrOEZTSnR6cGEvakJSMmZHa2hrNk9pVTMyZy9nM3pYYnB0?=
 =?utf-8?B?dGxpME90NkJNdnM3eWZxd0hJK1NkVHNzMFlIcjNoZUdLNG9oK3Q3UzM1c3d0?=
 =?utf-8?B?SmZFR3Btdm5JS2xZRWI4SGFMaUNTOG8zbG10Y2xtL3UyVTJMM2piajFlc3dE?=
 =?utf-8?B?eHdXZXMvUDZlR09MNmR3Z2tlWVNOZm1wQVpYeGtuOXRWd1Z6cmRmSnBVYzFm?=
 =?utf-8?B?dzRSZTVFejFZUUlVMmlyZFMwdFdyaXl5YzYwRWVVcnRTSVU1WVVaWFkwKzJX?=
 =?utf-8?B?aXNLTXJPc1B3bTZ6K2IvbjF5NnYvaTRGWHlqRy83V1FoekFCNGNNRkY1eEdJ?=
 =?utf-8?B?UHJ4SDVhMzJFUnFrWFh1MithN043VHZwQ29mWVFsZXpBSWJqK3dXK1FZd0pp?=
 =?utf-8?B?SFZiMGs4MHdoaHUvOUF0ZHF0NzBGYXZMeTVZczkxZGtVTUhCbU9abjVGQ1lT?=
 =?utf-8?B?M1RYOFJJUnhWeG10dnNGL1dmSXdGYW5Rc00zSDkyeWx3dXM0c0tvNEVRcEo4?=
 =?utf-8?B?WUlTWno5R2tPVlFFNVhqMVUzT1ZRQkltTmxGWmVISEUrRTRzTnpnb0dQdExM?=
 =?utf-8?B?VE5FQ2hoMVpkdFdiclRhQjVPSlBZU0hJZ0FUV3h1djZBVnVtVDQ5dE5MMU45?=
 =?utf-8?B?dE5udnphNjZ5ZzFHdFRTaGs1dytpSjJmVzJHdzVJUmMrUGRQRTFnWXRLdk96?=
 =?utf-8?B?amp3Tzh5K2lWclNrak4zZlBDbHBWZUNVd1hicDFmNTA1Qk5OYzZ5UmFlcjZV?=
 =?utf-8?B?d212Rm15S2JHNzB4RGQ1K3hGT2JKZlNoVExUNEZwTzJ4Wlo3Z1gwSUtCRGhP?=
 =?utf-8?B?M2lpWjMzTEIyekhiaXpkNlRVS2paWTNtN2hBKzBwRTFXSGFUSWpIUnJVbUQr?=
 =?utf-8?B?Mk9vYlZ2dzIrbjhZQzdlS2FxT1p1dTZNYWxyNUVKZENtT3lIZzh3SXk5blZF?=
 =?utf-8?B?WEovM2dNQWhSd1J6aEhVRlA0c1hTRURLUkVaTHVxWUcrYTd6SXU4MVltSTlv?=
 =?utf-8?B?YW96YUtMU1IxUDhmMFFVVm01Z25tcDM4TGhVWmpXZ1llMUl2VUhpMlRLNWwx?=
 =?utf-8?B?SzRxT1JZVjZvSHB5N1F2dElhN25nVnp0cE5Qd2JMaGI1b2xIWGNiVHdGeTBi?=
 =?utf-8?B?bkhnUW1FMW5KeWw0SjhxNVNPeVJKYm4zK0tiQWFVcGZud3MvQ0QwRWczVksy?=
 =?utf-8?B?cUNCeHZhdS8zVy9Lb1B2NjBLQWNXQ3YwbHVxL0g5Tit4YWVZK2JqUHBEZklJ?=
 =?utf-8?B?cjc0MXFZWlZOaHk0ZXlDaG9MR0RVMGZ3QzZ4eTFuZVlTLzN6aDh0ekNRaE5h?=
 =?utf-8?B?a1NIL0RWb0R0WXl6S3lqYkRIbC9RTENGWnlMTXUweUJwTXRQV2FxeXpmS1ZF?=
 =?utf-8?B?bzdFSDNGZmNWYzRjMEJENHVSa3B5ZWRuODNWc0V3cmI2NVh0eHhKcllHamw5?=
 =?utf-8?B?bnhXTmNZM25LWnhDS0wzV1k3Z2xCbmRQMHR6cVRoQ3NsREoydDdHZkpKeWc2?=
 =?utf-8?B?ZFVKdnpZR2xOWmp0YmdxRHRMUm9NMXBFZUhiYXJtTzdzR1gwYUQ0UkNVeHFm?=
 =?utf-8?Q?h5n9SdOtZkHr4mD+2LA6ElMPB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad34615-70d6-40e4-329a-08da6ee5c9a6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:04:03.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RBZbIl74QnSh7n/n0f42cfP7iGcvVc+34y9ghkkfmOFcVsoEZSyDcJEv0Dulbr8zYdBN/umZA9g6vaeUer0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1286
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2022 20:54, David Laight wrote:
>From: Yi Sun
>> Sent: 23 July 2022 09:38
>>
>> Calculate the latency of instructions xsave and xrstor with new trace
>> points x86_fpu_latency_xsave and x86_fpu_latency_xrstor.
>>
>> The delta TSC can be calculated within a single trace event. Another
>> option considered was to have 2 separated trace events marking the
>> start and finish of the xsave/xrstor instructions. The delta TSC was
>> calculated from the 2 trace points in user space, but there was
>> significant overhead added by the trace function itself.
>>
>> In internal testing, the single trace point option which is
>> implemented here proved to be more accurate.
>...
>
>I've done some experiments that measure short instruction latencies.
>Basically I found:
>1) You need a suitable serialising instruction before and after
>   the code being tested - otherwise it can overlap whatever
>   you are using for timing.

The original comments here are kindly not so exact. The patch actually
makes use of trace_clock to calculate the latency but not TSC directly.
The precision here is "at most ~1 jiffy between CPUs" which is probably
acceptable to this usage.
I would like refine the comments if it made confusing.

Thanks
   --Sun, Yi
