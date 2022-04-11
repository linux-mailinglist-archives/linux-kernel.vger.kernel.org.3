Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB94FC6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350190AbiDKVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350082AbiDKVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:36:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E863CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649712854; x=1681248854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lwYlk3Lc+fhYL/Ns/qnzoRzJrnjLeOeJ5KfkkVfSHpg=;
  b=YWn9F++A2FBwq7Qe5zGQEr+jF6riaXck/HS8N8gBVJJAla0g8BoQaAa1
   0HM4AE7fXqlwpBQuUtegYR3dQjh4Iwl0l0K5QTkecL16m7muDbp8SOT2R
   F6q2vzkh3rVn7kThcNiefp4Iz2rML+NYa7LUJsG2sC+Cc4xdDgxC/X3nR
   NLG5ZNm6vsINWbXNV7MjCDXtkCqqof+vwZp05u5MLNaUOq/2QH8JRbbmz
   Rhmb+JHSFVrHFE+Reo/KW/TtcUjg7BQgsVPG5k99RbKQWDx3jkomDzcfZ
   gr4qrTjLXRogTpM4VwfowIuk0nP/NQ8Bav4bHbdxg/kC8T0qbTBNd+mJS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348658695"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="348658695"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 14:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="507277791"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 14:34:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 14:34:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 14:34:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 14:34:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 14:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRgCJvOcmRx8am5ZL0T/qNAuUFLTQo9EGlDTsUHdS/ucBTkG8WcRsMt/FY32Ph4eMdBBMjbtfwlIEGBfWnhZVrT47RTd+m3qxGk00tJH6l4AnSJpO7kOfHTyHApqVJvJqK26IwdCI+kkFtvnTYJjj8vawE1CmRo3sSMCCkLW8NY8J9hD2xFU+ffyvWeh8a9FdBDxdN/mAwMMClWt4rh1l0ddKZ3J7gCy3WYVcTC/WygJEBdyq1NefI4oUTa5svy8a0+EeKPGjTtvCMylIZnynypfuH/B2AE4/39EE5ectjjdjALDL3e9R8MTWREa9DQFZGI3toxOwChM4QNYRw6kPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAXGHrgUotrGoRpEsf1mrsbA/y5jlaTcLSPlcrJnBys=;
 b=JzOGFeSHmbVszt5icVVXhrFtPnvudO8Z1AQS8vQel3K1Ye/x9pS0RrmE0vgh83WpgN0s0fvBJKwMsoJHANIOECey0ZisYE1bsXLYLAvMIgo7Ou3/ola7o5XIjJPXjM2eo5u+hj/bts5TlXSrxebgvxLEG7jFeJnHbtb71zUqUGtG1z/IHBXVbD+nU19kQniSJtF1F+fbz1PVGpAoFWc9nZyAJgOr95eIGCe8KlC+uQx6OHZZA6U8koGkbYSLAaaxcW4dLnNAXT/jd67599kzBCi4jZ/X8v2IAlutv+g0s+BTC5fXFX5QDgEJBbH257I7Es4gvex5EdbKgMiSOPc5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 BYAPR11MB3445.namprd11.prod.outlook.com (2603:10b6:a03:77::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 21:34:09 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 21:34:09 +0000
Message-ID: <d0591904-d6dc-1f9a-f710-ee4e64d9a738@intel.com>
Date:   Mon, 11 Apr 2022 14:34:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH 08/20] drm/i915/gsc: add slow_fw flag to the
 mei auxiliary device
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
 <20220407125839.1479249-9-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220407125839.1479249-9-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cfebbeb-45a2-4e43-f334-08da1c03031d
X-MS-TrafficTypeDiagnostic: BYAPR11MB3445:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB34454E2E07A79658E62ACFDFF4EA9@BYAPR11MB3445.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX9gAwoxW0wW0rLvwdGdWzNr/pff/piWLu5+8WLmFJz3IwzzIc0QwVmuDYZIwQMNKKNBqX2Fnq7PvKBmjLxAgXYfx6KL3qtVQE+n3V4Uu7vkb69+1B6L32HRJd3GdZmznqAzlghfMCmb2UDg2dyGR0vE4oV96nxHg/nOQQIx2kapJQOfJNFSkhoI+TtnXt3n5ZhcR7o3fY3XzeaFwToDdlN8+qilXsRXJfg9jX1PBlVlELmjfNDgxXJFRHzUt7gledSNY1e8ZaaqNj2RcTAhV8mA4XA0xEgURrFWEmJ3+pWErvrGDdS57NveG7n5coF+E9UF8VEr/CHxLWfraLhF5Q166N+OC2l1XzaoHNPwj8yTkRDUgAISx+NKCkVgh9YqDTObkcE1TrSlacyQpxgRMPSd6pRi7vBOe/idp1qJ+AeXQLDJOPHxptCmBi4wOg+ddVKtBBc9dtHJqHo0bFreU3yE4DAgOrbu2IDett3bD9I11nWn0YRkYquMZsTbxxaVHDaWP8tdwNWtXrSYjnUyyp12TUS1MeG+yP2OnypRaS9nOZzxIg/W0lIYg7nM0A6E/B5nujhEmiY18fwBr87Wg7Vz31tbelLsn0WrvEI/yrY4qa2vBbT+6LOoPNtgD9KAJpqPnEtvaDmZalMVm02UnWLTA/kfbrJul9SVF5ftmyBwQlEpyr4oQH+/69Ob4QCV+46lYylE1DjJrQA1PYxBahJHttKGIFQNqT8dnAy77yKVGu/CDkGBSDgQTEJifxJn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(110136005)(36756003)(66946007)(66556008)(6486002)(86362001)(31696002)(316002)(82960400001)(4326008)(8676002)(38100700002)(2906002)(508600001)(66476007)(8936002)(5660300002)(186003)(53546011)(26005)(6506007)(6666004)(6512007)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk90WFlaWWVCN1lUOFcrT01XY0M2YlZ3TU9lNjNFaFZRZkRFOHExTzBiNUtN?=
 =?utf-8?B?aS9aMVlTbXNKMENxa0R4RkV5ejZDeFRSK3pNcFpLeHMzeXJNS21XUnE3WDdN?=
 =?utf-8?B?YkVKbnI4UEFCTWpEWlEvMC9RS0RrNmxDWnJpYm5YYlViRzN5RFJkZW4zWHZY?=
 =?utf-8?B?ekd3TUdHUGpobXMyaWg5VnBLKzBtdVoweVBQQWVsVDh2TEUrTmszc1d3QUoy?=
 =?utf-8?B?ZTlHSDhqVzVxRnFDSnRMc0JnYnhaUnFrcDA0bEdxZDl3L2wwODU2R3dXYmJQ?=
 =?utf-8?B?czExNkpHOTNxb1p1dkQvcjlmMXJ0dG5OcHJWVUhsekxaNjBpZVNpYXBTbGZZ?=
 =?utf-8?B?bmhkbVZJTFd6UTBNVWo1b2t3Zmw4dENLaGl5S0RNVXh5VXJZNE1rK0xhOWJD?=
 =?utf-8?B?MWZBZVpmSnBoQXdDZkMxWDlVWUVYQ1dSd254SzVZblBFK09kUGNTRFRkbGNw?=
 =?utf-8?B?alNOTVhVVlFyTDAySlFyb3hvV2ZpaWxWM0FuMmhuUHJDbXdGdnpESkJoM045?=
 =?utf-8?B?QVZIRnlYL0lNc2NjcFZWWTR2eVdadnJueXNMMHpCdU5ENzd3cVRWSFZ4V3li?=
 =?utf-8?B?eHZCdUJSdFQ3VS9JZ0NUR1ZYTmR0cTNKdTZ4TlVQeitLUjNxc0JIa0FXaXhK?=
 =?utf-8?B?aEVQay9HUlo0REk2MjhMemhaVHl2elYyYnVQT0xQWHltYXR2RTZxM243Tm85?=
 =?utf-8?B?bTlvaVpIZ1VWckVtdktFa0hTKzRMMGY4RHUxT0Y4TVAvZzV2WVprRTh4WjYr?=
 =?utf-8?B?QnIzMFFxdm84NzNLUVczbEcyejVneDVOOUVQUTQ5L1hmbmlJUzVOQ1dwWGdS?=
 =?utf-8?B?ankzMTNFNUc0cVgxWHA4VWxsNjUyOEFrSDM2Z0QwamJyZjVGNVB0cWdqa2dn?=
 =?utf-8?B?dTZjNG9nZ0lkUjlEYTgvYm92WWhGMklXVjRWVklJNjNzUEE2ZTA2ZFl4Sko1?=
 =?utf-8?B?WXBsc0V4T2V5YWFYQS9LaXVsVjk2QXo4U3RQUXZndmJJY1U3ejJ2emlLQU9D?=
 =?utf-8?B?M0RSS0FqNStDTU8yZVBNSmJYSEhvSTYzWVRpL0ZtNkh1TkZ5ZncwclBNcHkr?=
 =?utf-8?B?Ym92ZjlsbENrUmpXSVBFMFRIVGcvbmcwZXlFU1Bpdk12dUlBUzgvK2JXZGI5?=
 =?utf-8?B?YUJiVVRqV3M3V2NVRXpxaEJ2ZUJtaTF5akxjaTNDcVNrTDlXcGhJdUJ2ekc3?=
 =?utf-8?B?dFljTTRFUXJGMEVPUElQbWVVbjREd0RUT2Z4MStSTlJ0VzMzRE1tSm1oeTJC?=
 =?utf-8?B?WEdjQXptVFBpc0paS0src2tLTFhUNzZrdkVKdW5DRVhQbzgwM2srbDA2Zlhk?=
 =?utf-8?B?dFlEOHhoTXZoU0VPKzJCY3g3Q2dzbEZyTXQyR1FmbjBETVZ2RXdCUmZSQy9H?=
 =?utf-8?B?V094MWExT2tYRXFSaW5KZUVkY25CZXhIak1ia054bEhUZ2hnSGZBZWZpMlFO?=
 =?utf-8?B?cC9RL0FjZmQ1Qm9hL3NJdXhoTjMyRnBhY0JjZHBPanBMaEw1SXp4NjhVWWJS?=
 =?utf-8?B?eGlPT1hsT1BvSGV1ZGVyd24rMklJUGIybkgvdkJid2JjYlM0UFZxQ0pNWTh2?=
 =?utf-8?B?NVRJQmM5d3pkT1gwZllUaHRFcDY2eUROOWhHdWVjSDVPZ2ZrdXVnSERrZmoy?=
 =?utf-8?B?bGZOeDV2alV0blhUQmRoNlJiSC9MWk85Mm94SzBjMWFCd0xUY25GUVlXYlFv?=
 =?utf-8?B?THYzYmF5VVdkL25jY0FXMTdwN0xKcWg1akRRVjhPZjJMdWp2eUtJcFV4ai9q?=
 =?utf-8?B?RnlEa1Zic2g5bUxDWU92MUR1dTRNN2NHZHN3MklLdGlPMk5wMVFCai8veW81?=
 =?utf-8?B?VURGNUFuMEJqMVM1MWdsRjA0TjBsN0kzYWJoeldyUHdBV1NDWkxlZm5uU3c0?=
 =?utf-8?B?dWxpSzVpRm0wcFhvSnEwbUlyY2h4QXRaSHJTS0t5UXhITnkrdUt2Yll4MGFs?=
 =?utf-8?B?djgwdGRLVGgzQnFxWDYrRjNkSVRwbldZcko3SFdmMUlUU3hBVkJLYmtzQ2FE?=
 =?utf-8?B?dkxQYjB6cGU0ajl5ZTdlc2U1SlQxRElCRTd6WkJzQmkzZ3FraDI3T0Rmc1c0?=
 =?utf-8?B?RThzcmJzRm14VGtPTVVVQlZHeVJUY0hoZmNXSTZGb09oNU15djhrNW9vMGtW?=
 =?utf-8?B?WGJuZ1lZdWFqUVl2bm96WUdKVk9GZGJkYkd1THBCNTZWY0lPZkc1dHNZc1R3?=
 =?utf-8?B?eDF4dFRWREl5RDdoVTlrNmtYeDI0UHBHQVd4bHhjOXE4bG9xQ2R5STNMbkVE?=
 =?utf-8?B?Q05yQzBZTXVVNjExSWFTL0ZFaGtpUWh6NGhNZlUvdVcwaERqblArVkZCTVBp?=
 =?utf-8?B?UmhRTk01cStPdm1VUlNBTmNjd2dzQ05qWUlVckttYXV6VjZ2V1V4TGFKc29Q?=
 =?utf-8?Q?CVOuBK0pDQ59PHXrZxNMp4Sp3EubP2Ihu7zjt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfebbeb-45a2-4e43-f334-08da1c03031d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 21:34:09.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISpPdq5TadgRNqQsJdBuHo3JEjHLIRftL8DHsuV5FhwIM+IJcYUelIBS4FubEJC35rwEYMH3himtMYOM8U4NJhaTzui7vdx9ImEI9jx5QUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2022 5:58 AM, Alexander Usyskin wrote:
> Add slow_fw flag to the mei auxiliary device info
> to inform the mei driver about slow underlying firmware.
> Such firmware will require to use larger operation timeouts.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Might be worth squashing this in one of the patches that makes use of 
it, but I can see the benefit of having the interface added in a patch 
that's neither mei nor i915.

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

> ---
>   include/linux/mei_aux.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> index 587f25128848..a29f4064b9c0 100644
> --- a/include/linux/mei_aux.h
> +++ b/include/linux/mei_aux.h
> @@ -11,6 +11,7 @@ struct mei_aux_device {
>   	struct auxiliary_device aux_dev;
>   	int irq;
>   	struct resource bar;
> +	bool slow_fw;
>   };
>   
>   #define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \

