Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD54FFEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiDMTST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbiDMTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:17:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF172448
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649877178; x=1681413178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ekg+BvAcxgq9Y3gyIGKR4rcYCd0hnmwJLdzfvgM/SlA=;
  b=UxG8yjG3ZmAoaRoJjHXWN2h7dql3LktLBJvL1d7XkIUvVyUIaLYOYHxi
   z+HRhEyIl49dwr2mjurPcWUccu1FCXTSCDc9OtuSwZHV/tbkyrjVdxsvU
   tmEL1jcoORZSpTGTKf0RFRP8xq2lUk922JY6UnyBiQoQufZ8ywrXs8Scu
   CvssUp3lPInBNElUsH89cJK7yF+i4ZeZBh1KSKrGK0SbVFrm1TAaeAFAp
   wJXEWpoPOKr5VXwvnOFPQcJerGxF9Esdsbr9Q94SoxUKve1N02tgd49o9
   lJB897wQZOziK7fK6914SWFak113gvncC1QoFxwHYPLcr94DnFLCaa658
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323196599"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323196599"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="527064662"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2022 12:12:56 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 12:12:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 12:12:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Apr 2022 12:12:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Apr 2022 12:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iViGY1t3lJORmevRoR4ZaYlAiFza+trI2OmNRnN9PmnRkBBFLbt4aAV21rX19QekJpKxYmBw0tYbBTTkWtIOX0sIef7WrXfHS8Qv87uTq2GwuZEd6hHJ2lhZQ6C2g68C+2RlhRAclhlurSvlw84zkASkNAgAJLK1F4cjLXL+ybHr10KztQPXpyjt5sI2iVGdX1R09nY0wOQH1hFg84MVgLCOWbVmfMhwmwQ9VD/wh2Fxsj9/7+8RYFKoflZbKyiYORg37LkXlk0UtfEUEqRfbpBrboup+EcJGs4skFswbsibi17nLBY0yVhfR85Zyi03qjxPIdoALr8npr06EToMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6dTdCAEJKIpSfypHhnjH+AT7PsLLrr0WlixkFnYA8s=;
 b=BLZksR2ZsohiLTvG2hx9szbdiJfhuP5EQi1T7pcfH8bDiZk2JbnN6nwoq5fQlb6W4Qq6NfZHwkuTNnBy8jfHTzPedBmUJGFxPbmGxfTuGC8UrNlce5XNP8oL7jng8hUavkiYHPzTYtklbg3H6wOVOJAGCDpfr3o2recNvPNst5mlWCJvm+Fbvb/WRoNh9oTXKRr+L/+WcnrZjfOQ4bRWSXGLOiF6lH07cHEP7wphTKQwVNFkLBb+hB20Pcm11ODeSmTSPc/HySxIGdLJm20JfgeT8U56bYYXfcnLs38HwaAZLAE0PygRCwHaoMSfCJjXfLlNN2igi9pFUDpZaGSHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 DM5PR1101MB2234.namprd11.prod.outlook.com (2603:10b6:4:5a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Wed, 13 Apr 2022 19:12:53 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 19:12:53 +0000
Message-ID: <6595f202-670c-a47d-dd56-e7ca39df2db2@intel.com>
Date:   Wed, 13 Apr 2022 12:12:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH 14/20] drm/i915/dg2: add gsc with special gsc
 bar offsets
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
 <20220407125839.1479249-15-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220407125839.1479249-15-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60a70ee9-9417-4091-fc07-08da1d819c16
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2234:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB223448BED830260EED2CDE79F4EC9@DM5PR1101MB2234.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAows76pl14294ateuLNEnPt24ONBWaa6FSsEIJOtGC4+Rf3NqTu3f+LaAjEsA9raFC+3/d3GIAZvFhOLkvwQj3FA17qUXolm6AFUfjOizNBTfhrSXc8ma8ZDnff99dQd3ojW1uAKAejAbIXMECIbDTLdRK0fBMOFTQ0ZXgTF8i26HxRulOHkFBJ0buvyAvxDT4DIGDRWckAppkiTzwICL5R9zE7/+DAcImI4XJIRTH8TGec0uBZLuL7N0C5PHGzVQRriviXmeJ82M5IQFYozArFi4w2bp+rD20neuzf8uqhQSL+JEznFYoGIKAzXYA1AX96XwP1dwrvfFx0S81u8yUtEidcp7WrKV77pLoq+NczDf/kjrTghv6SX2p/y7IZaneJzYxuqSllGbtDMlt/Tr7UjFMZdVjzUaL7uQNN4Zal19wxPayA9s+2Z5Ky8BU2OMPdhl3gQYmgbh+PLU0eTRifAAWSZ2nDkUJ6DddIk265uC5BzEeWIXN0PhH8Gd4xhmxXeXwyTFphoy5b85iTydlpYYLn7fHPivZFn97Cb4LtV0hpTHUHy0VClVRORMFOvvUlwuy93Ius/wWWt6rXRJ56wW/ZKj5P0vNMRtom4Nc9/6Op6qhE1CyHllaE4/60ye4FBe13iiTo/0gn/LZz3OuybmvUcOMfYfw6GurykfeZeZBHny55C1zTHzUUJvxbDRp2R/sWy+3J5AbkxkzPhJ6a4pZ9d4TKfA8bE8kRuS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(82960400001)(6486002)(508600001)(86362001)(31696002)(6506007)(5660300002)(316002)(66946007)(54906003)(8936002)(8676002)(4326008)(66476007)(26005)(186003)(66556008)(110136005)(2616005)(6512007)(53546011)(31686004)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZLMEJlcTA2THVzck9wYUk3a0VEZFJlTnk5dEVTZU9aWE1ZUkJMVlV4ak5h?=
 =?utf-8?B?UEpTaVhxU3c4NXNUYVFQS1pFa1BQcHFaUXdwdGxjSXZFMnFRMnAvN3QzMnJ1?=
 =?utf-8?B?QU5hb0Q4SHVxV2ZxUXU0VVJ4WVozemNQSDVqb2JwektDU0FyNkJ1LzZ3VmJF?=
 =?utf-8?B?ZFBnR2R0N2tzTkdhQTh5aW1jbW50M3Iwd2FNdGpxNEZTbnZWd3pqZWNxWEl3?=
 =?utf-8?B?OTFyRVd2MTFJWjlHZlRnWVgwVTdGVFdSYjVFUkpCVWhqMTdJK2RDSXFEK05L?=
 =?utf-8?B?UU5IWXkwY3V0QnE5dkdRc215N1Bucm83TXJMZUc2Zjl6S3dxQ0szbENDMEFB?=
 =?utf-8?B?WDYvK3BsT2lMb01nNjJGUEdKUUt4SzI5SHVJQXFxTXVIdjN1YzhsYjBwSlFH?=
 =?utf-8?B?d3hGTjZzNFQ3RzRTNGNLQkE0MlBlNW50bm1WTjZUdElUN0oydnd1aEtjM2JZ?=
 =?utf-8?B?RW40Z0NiY0w3dysyVk1jblB3QzRYaExMZlkzRzZSbGpvQTVhcGJqKzdNZXZC?=
 =?utf-8?B?R0pFZk5qM3djT2FXOWgyV092Nkp4WGdRN0IrNzBjUVQ5VVhRSWdDc2Z3RVJ6?=
 =?utf-8?B?ZVJTT25mOTdsSk5nTGE2NGpsR1FCUTd1R1gzQmdSakl6YWxCMzhuekFNQXpN?=
 =?utf-8?B?SmVnbWtIVm5hV04xMDhpM1NLaXVYZFpCUlk5NGE2eExXNW9RelNyTHR4VzB2?=
 =?utf-8?B?amdMTW9WYzdtVGtuSXhvV0pYL0xXTGpMS0g5Y0l0a1J0Z2tXUkhNTHJBYmEx?=
 =?utf-8?B?dXNsVHR5ZjAycWhuczc1bEFvRWs3WExVcDd5Mjgvb2dQdlNXZzRlcjNUWG5v?=
 =?utf-8?B?SEx2eUhtK0s0bkNqVEZxRFJ2Q3hhWWYvcTdMbWNHRjdSVkJNRVIrMnVVQnVk?=
 =?utf-8?B?QVkrM0tRL0VCVHk1cTlzeWw0U3pCM1craWQ5cXVwdUREODhqK2dtNWNZVVR5?=
 =?utf-8?B?K2dTWEVOVnBrRDlkZmY2WFRwU1h1UnZUTjQwTm1MaFJaUXJ5U0JEUjlIVTlj?=
 =?utf-8?B?d0U3ZGJ0RlA5OXU3YUpWK2VBVVU1d3VaaUJ2YWVGeWovbzJXdmdTTWNoNUx6?=
 =?utf-8?B?SkNQN3dDd0VTcU9DdFhWZS8rRGlmbFhVOHVFemRjUGxIU0lZOUJoZC9WYStx?=
 =?utf-8?B?UFVFMzNySnhXb0tWWHd1cStibzVjc3YzMUEyL3NwQ1l4R1VqRlk1TjdYZ0J0?=
 =?utf-8?B?Vyt1T2dVOWtCMEJ3SUxYRXpyNWYra3lpVis1N3FrWkZXR0RKZmlEYzcwNUhl?=
 =?utf-8?B?eTRWR2RDRTR2dmJjWkpNV2lwZTRyVzg5VkNXd3A1Rm1DNTlZQ3QwVGJDbDJq?=
 =?utf-8?B?a0VmVjN1MW9KRUFDczVSWmx5MnMzejB6WlFqTGptRks4UWZkRnY3Y0pscldq?=
 =?utf-8?B?Vi9JR1NZbEN2bzVIbHBzallrWXNVY2N6ekVYcURnR0VBL2RJcitEQzE0V0tm?=
 =?utf-8?B?enNBK1NwNjFCUmtrRUlvdE5SMmRBcURnd2gwNjYwZHR4Qk1HOG9LcGMyaXB0?=
 =?utf-8?B?ZGhnSEVDU054UXJ0ekZKeWlUT3VtUFFrbE4wcXZqTUpkdTgxdHZ4QVBmRmV4?=
 =?utf-8?B?c1c4WlB4S2NhWGtKaU00N1ZLd25pTnEvZHdpeXRvTUE1UXluYVNpVHhNbkVP?=
 =?utf-8?B?OEdpQzBtOWdQeTB6TkltSXk1bTRHZVRrQStINGFqaU5rSUNqNjdYelVxUHU3?=
 =?utf-8?B?QzJHbkhpSWZIUGtqL1BqVm5GeEVkcFQ1MUs2UlBUbWVCc1pnOUo4T0dJQ2pu?=
 =?utf-8?B?bEhadzgxeEFMdlZqSWROZnhQQXhMdnNMZ1Z0RnRwZ080dmdJWmtROHNzVEtu?=
 =?utf-8?B?cnVQQ3RFdXRhblBpSG1wR2FTN2xIa00rbE43K0V2RjJqckcraTFqS1QyTFlh?=
 =?utf-8?B?QWhXOVhGVW15OTFaTjJZVWw3M0lqNzVPNW53SmhFMTJkNDBtV3BxTzNoMURG?=
 =?utf-8?B?azFSUGRxaUlTWHpyVDVrZ3VHaUN3eDlTV3FPUlRQVU5Kam9RZXZkY0NxN2g5?=
 =?utf-8?B?TEk4QVNSSDZITHQ4NjJGUzAvTzhoWC9EVU83TnZJU1BVaDZ3NU1YdE9NR04v?=
 =?utf-8?B?VjR0eEtUL2ZVR29zVHVVSko4Z1ZkUFJDeEExYVU3bDRLU3dVZzBvQ3BrOGhW?=
 =?utf-8?B?RTFsWVNjYk9HdjNkYVhxUmIxSjM1ZXlENjdJVGdoRzVOb09EYUE1bFc3b2sv?=
 =?utf-8?B?VHFQK29LNG56SUNXRHUxeEgxY3JTMmdXbDRpa3hqMUZzeXlObVJCSGdnT3ZK?=
 =?utf-8?B?SXZOZ2lRYlk4dk8yMU5RZlA4MFA2OUlHamdrUCtQc0xGVDJaNHFDTmdFNVli?=
 =?utf-8?B?WERNWDdCckw5SnozaGhVNWFubVgrUXNyTjZGUDJxTEtSMVcvaTNWT1pvUGNy?=
 =?utf-8?Q?XxEmLjblDuo+0hBBgHiGQ7mAgTEDePLdh0JD0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a70ee9-9417-4091-fc07-08da1d819c16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 19:12:53.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UVmYVsD23TPXst6hp5e9ON3Uf5TbIVf7Cmgt0Dn15CMfzCc9GN6FfiycOmC6qZywkmWfHbBW9e5hwYGJAesrDB1tinF251fGzbypFDWUZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2022 5:58 AM, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
>
> DG2 uses different GSC offsets on memory bar
> and uses PXP head (HECI1).
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/gpu/drm/i915/gt/intel_gsc.c | 15 +++++++++++++++
>   drivers/gpu/drm/i915/i915_pci.c     |  1 +
>   drivers/gpu/drm/i915/i915_reg.h     |  2 ++
>   3 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> index ffe6716590f0..bfc307e49bf9 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -69,6 +69,19 @@ static const struct gsc_def gsc_def_xehpsdv[] = {
>   	}
>   };
>   
> +static const struct gsc_def gsc_def_dg2[] = {
> +	{
> +		.name = "mei-gsc",
> +		.bar = DG2_GSC_HECI1_BASE,
> +		.bar_size = GSC_BAR_LENGTH,
> +	},
> +	{
> +		.name = "mei-gscfi",
> +		.bar = DG2_GSC_HECI2_BASE,
> +		.bar_size = GSC_BAR_LENGTH,
> +	}
> +};
> +
>   static void gsc_release_dev(struct device *dev)
>   {
>   	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
> @@ -109,6 +122,8 @@ static void gsc_init_one(struct drm_i915_private *i915,
>   		def = &gsc_def_dg1[intf_id];
>   	} else if (IS_XEHPSDV(i915)) {
>   		def = &gsc_def_xehpsdv[intf_id];
> +	} else if (IS_DG2(i915)) {
> +		def = &gsc_def_dg2[intf_id];
>   	} else {
>   		drm_warn_once(&i915->drm, "Unknown platform\n");
>   		return;
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 06e6dad0d7f7..cb6dcc3f48f4 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -1051,6 +1051,7 @@ static const struct intel_device_info xehpsdv_info = {
>   	.has_4tile = 1, \
>   	.has_64k_pages = 1, \
>   	.has_guc_deprivilege = 1, \
> +	.has_heci_pxp = 1, \
>   	.needs_compact_pt = 1, \
>   	.platform_engine_mask = \
>   		BIT(RCS0) | BIT(BCS0) | \
> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
> index 1dd7b7de6002..efcfe32cd8eb 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -978,6 +978,8 @@
>   #define BLT_RING_BASE		0x22000
>   #define DG1_GSC_HECI1_BASE	0x00258000
>   #define DG1_GSC_HECI2_BASE	0x00259000
> +#define DG2_GSC_HECI1_BASE	0x00373000
> +#define DG2_GSC_HECI2_BASE	0x00374000
>   
>   
>   

