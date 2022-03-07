Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A44D010F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiCGOXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiCGOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:23:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563BE6BDC2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646662929; x=1678198929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pm1gxabDd23XitQQfN6qLckEiC6y3BbiQhgin3OQJOY=;
  b=XB2s1nINV3IaJ9bpH94HK+xXjufneT+Xgrdr3SgSEirvCJO3J98m2yTZ
   oPHHk8qkb9kA+X2dPO3WY58GeWXXgVrtQFs2yJxKDu9+sFTjXMZhnadsc
   sToGxj6wedUzBSrPoSIpesJW8fPipT5TP89En9n2ZEAYL0LMp8MVpPdla
   5dtJgoYB2WLmJdsZk/geATq1XGuESCvVHC2DLuHEVwiihbKvNUdJu7u1a
   7KvVj9k9RIUtO2yMbPfy57hRZNm8a/lvm/nSjczaFqQsyW0PJlxGJNVRi
   Hk7L1B8EI4ZHcdM2RLQADtwHrHOt5IR9QkMvRBJh9t1G6eGEYImBhuZ26
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="241834612"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="241834612"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 06:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643262260"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 06:18:54 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 06:18:53 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 06:18:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 06:18:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 06:18:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuIXBUDt4+XW4JG+U/xFvmuQj9wID6hw+/DLmbii/v4juE/S8T1IIKd3JgKDAEBKnhfnASwRd80BjG3+eDAK9KgAGjuOblBOlD74jB+GaDMO91Kv/5zEgalMh1JaJ8bAZx1Y9y8LkqE5Vkd8+CiPCYBvefenn5djw5ltmKHXhfZSSW9ed//l/E26r8aaKBGbUC1phsk3VcVn1KT4cxQnu9mAwEIAG1KOPZj9HXyIz6UlKYieoryEJ/ANxF9j01cT0wpWrQZ0xEBdkw9w7NAUAnkig/dZ+1C2lXJ41xv+M5YbMf2C4kvDGfkj/7vdmw9ZJkY66y2uOFlKdphdGjd5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN9PFrln/IBqLBiPA4kd8Xeq9MD144/Q3ck3f46r8I4=;
 b=UkBltjVcglXQxQJlb5lHljladfQAT9MckYlnIOynGDmMA0jPaQltUkM7WVH1aLqmO/50hNM+eAkos727g5iII0hCyuAtROganCkm/IH/7QSyxSHOYrif2GtQkPK1c2EYf8nOUgpjC3c7TCPRQ8yLpA62+WC8Cxbi2bXPTjJR7J/WsyCACvdJROlWaFXytc2xw1q/5s3hT7V0Fe6DOQDIhU6Z7pDzpg/qp0IMu1gmWOhNyCGgM+5yQjQ+QAITOiM1uyBLbcHfpMETuJOIHuxf/MGJVttYBIYIgE1NKm0wrmZ8RB/K9F7Oeb5O/8DxH2oipfh+2eLUr3RpjlpopgmdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10) by BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 14:18:06 +0000
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::24c3:c14:92a4:22a6]) by MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::24c3:c14:92a4:22a6%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:18:06 +0000
Message-ID: <90602353-d795-6bf2-bd84-47600637b9b8@intel.com>
Date:   Mon, 7 Mar 2022 15:17:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] ASoC: intel: use asoc_substream_to_rtd()
Content-Language: en-US
To:     zhanglianjie <zhanglianjie@uniontech.com>,
        Jaroslav Kysela <perex@perex.cz>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20220305125105.142704-1-zhanglianjie@uniontech.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220305125105.142704-1-zhanglianjie@uniontech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::34) To MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d861b41-0d51-4cfa-2fc6-08da00454c49
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_
X-Microsoft-Antispam-PRVS: <BL1PR11MB5978BA64B9B6A995E150684DE3089@BL1PR11MB5978.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVaM3f+EIwvil1DQoCaB5JfqKFwDwHEN0J9LD+ZhFZ9gBIjMypttTQjWSzRrMttHcWTbRXcbMJvMeYfw5w7gKqBQPJmNTLNi8jZHLsE6Gj4PwxExfhdTK2NDOKfJeK0WcxqFBjzrtbr7h+D/fCWJRqKmt5u98Z5bBfuDsoud8RCBZKLk1jpOzu3jQHNplmGiNDW7JXRUhMmiqQIQZOQr8uoNYiQfo4P0QNVIHzp+h25nAHk6cKUNhZSXkcsUmzDEtbKzq8Khfk8ZJxO7koM+DX/yAbDlD0TLOG+KN7LwUcCmzsbT+TLx7kyAcEns23xvtRb/eCSZp3e8bWKjpSikUJXzGpnO09tJBXWL9IqgONekBRt06VSPG1CaExVySmRMtoBdEOI4JbzQ82k7FRtyu6U5P3ECtQXxoD1VfWueq07189rBHbaVGRfdeYKgYF03qQQpl4DmF/19ToDT3DSXiAw0E+Pkc0L8fDEwO9IRnukbeBe4gnHdVgZkYm87PyQUYahjXLyCRxDPuDNbT52u363fnx/xJ8GZ9e2MHJrP77ALGo03HirVdldOE+3sGX/zmzD2DsbhP9b7r4CF1pPmMbfW4YeeaBktfuBsGB/uWG8nQqjNDEL3efjyRAvAA7qYYFVOiSfaheP3Vucko764HP9wDMKf8ALUk8hgaWcCby+MLmwCVljAwRFwy9NXAaIAKWzlo9XbAoJYRUA5VPvB0Go9AqC/SqmljN9szxNHenk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2157.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(4744005)(6506007)(44832011)(54906003)(110136005)(66946007)(31686004)(26005)(6512007)(316002)(2906002)(53546011)(82960400001)(6486002)(8936002)(2616005)(38100700002)(6666004)(86362001)(36756003)(4326008)(8676002)(5660300002)(66556008)(66476007)(31696002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NuYnZqalIyZ1poOXpyNlFhd0xOMnZibzZPd1pGdFRSUWlDdkh6OHZDNTZ0?=
 =?utf-8?B?YWtRaTVZY2pNc2o4a0JZcjdhT0ZucmZhbUROeGtvWW5vR3BTMUcrNkcwLzVs?=
 =?utf-8?B?VmNXOEtqYUNYZ0pTNzVEN1VQbjhIUHNaczJZS0lZQU9IM0kxMkd3T2tXUGpC?=
 =?utf-8?B?T3ZhSEpIbm5VWFE0ZlFmeGVHdnBudXBrazVLekVlbkZxbExoT1k5NVFQbGpr?=
 =?utf-8?B?UGVTdmFOMmYzTTRXWnBmWTdsUGJ1RlRyR1d3WCtsaVlsdHA0R3RUQ3BlcVo1?=
 =?utf-8?B?K0JpN0pWd2xxVFlZcERZTGF5M3UwNityZnptUlJBOVd1M1h4RTA5WkNUaExj?=
 =?utf-8?B?ZjNGVXRDUnprVXVFcXNHNzlUUFJkQ1kzcTNDaERGU3puQ05qVi9TVDk0bXlB?=
 =?utf-8?B?ODVtSEhBMlVaYkEzS2M1VmdMdWNPMlU2eUhicHh6NGNjNURpL3BKU3lTbXFi?=
 =?utf-8?B?ZlNOdzg1NW1MU1NWQTJaSmV5QmtkOWdJby9Laks4MjVtYml1cldPRnhqYWk3?=
 =?utf-8?B?QlJhS3ppMUVBUjNzNm1jcnZYZUtjeW5BV1Q4MTFFUzltbUxCNlJYYms4Ukk1?=
 =?utf-8?B?Rk53NkVFRGVvdVBSYUt2UnpvOEhHQ3BEM2I2anc4NHBMbmUzNnF0cVlCRlAz?=
 =?utf-8?B?US9keUZvNjN1RGNTa3hMdnFBYVVHYWxhbDFzV2JFS2ZseTVuT2NpZy82L29l?=
 =?utf-8?B?MDF3K2lWbjZwc3pGSXVRYnZIK2pTT2JsQ1A0b2pEeEFqalFRZVovYXM5Skxj?=
 =?utf-8?B?dll2K1R6b05HRXRBVmhnNFl4REIwUXRiNVFpanlvQjJuVnFBa3d0M25DNWdO?=
 =?utf-8?B?QnQzZ2kxUXpwUEpUTENMWFYza3JBcFVCYUJtZDNVUVpiQ3kxamdwU01DbjNU?=
 =?utf-8?B?WEFtSnpSQy81SXpub2xMYXIzV1RDZ1hCTWRBeUFyUzExdDhLMFRhdFpFZzNz?=
 =?utf-8?B?cE9wd0xRWk1MRkltQ2l0N0ZMZVFqRzBmdlgzOHl4NHRISDV3T00rcDNzVTB1?=
 =?utf-8?B?Mlg5U0RTcGtyc1hZWEdGNkYxcllOQW5WMU5lT0crbmpNeGM5WnY1bHh4SS91?=
 =?utf-8?B?UnRzQ0l3aVZvT00xeW1NL09zNGRaMi9RazJ5NnIwWXFiNGRhRGx6VUdIT0Nh?=
 =?utf-8?B?VFl4bWZqYkw0UE5zakx2SUI1aENTQ3RLSjNTWHpteGJoa01sSnNQNlFHNElu?=
 =?utf-8?B?SC9EN3BiMEZrdXRkOGZpZFgyQ2piaGdURE81Q1R4c1QxRzNyamx6dktrRXF0?=
 =?utf-8?B?Y2MwWW8rcmVjUjlzNE5lZlE3MUlYckdEV29sZUd4Wk9PamdHVmFSdkZkTUNu?=
 =?utf-8?B?NEV2eFZCdGJjL2JvaFA3R3RTMGhhU0dJOU00WGhxbEYxbmY4aGZNanpDaWlz?=
 =?utf-8?B?ZlkvbkR3WWpXWDcyeWE0eGo1QUdySVNyM2t5QlltVkx0NHVjUWUwTTRrTmp1?=
 =?utf-8?B?dWpGbzNreWI1SUZNWTJ2cWtoSEJISlpML3krdjA2cWRFRVNoVll2Tlp2c2ti?=
 =?utf-8?B?eW5CdVFpRHFyVEpROGhMOXJ1N0cwdFAxTTE2SDVPYkRZLzcvalg3bHNiN1Nk?=
 =?utf-8?B?bXBxRWlrcW9IVm1USzJWNzczZ084T3YyY0g4ckR5V0dPQ3U1ZjBjVnBLN0hv?=
 =?utf-8?B?L2xHb2cyZmdNOG5Bbzc5WVJ0ZFI3UWNXczVDVmgxV08vMU1JV1VoMGZvSW12?=
 =?utf-8?B?ZFY3NEw3b1ZBWHhxVXhYL04vaWExc2lUSFZ0bTRybmhPdlY0dllUTldleVUw?=
 =?utf-8?B?ZlF5TmpqblNOVklGWnZEc1FOL1RtVDV3b2FrK2VjRVBiaXpHbVRzem5UYlpa?=
 =?utf-8?B?dmFmQnJVV0s0QUtmUmNLQU93NnkraDRnNmVldmFxb2x1SHppbk5objhLVTgz?=
 =?utf-8?B?SEE0VjFnNmsydk5hZmZwSWFGWVFJTjRhNHpGc0R3eXRveUVOMWE1QkdhU3VL?=
 =?utf-8?B?c0tsenhxZ0FaaXp5eVNYK3B3R0xCSDJDcWhKNDJrd2JzaTZYektGWFQyWTVi?=
 =?utf-8?B?ZmtBYVdta25MZzdqbHk1dENjMnFUTVc4eTVua2dFUUpqQW5DNCtUU2oxeGlx?=
 =?utf-8?B?YzhFYzBsWWY0VnlIeDJ4VnEvUGNmY21xVFR1R1Y1ZkhjeTNIdjNENVlGMGRQ?=
 =?utf-8?B?OHkrZ05zanV5UU93RjhFNkNyRExuU1h1OVhUNGVsNU1QS2lOM01YSi91c245?=
 =?utf-8?B?bm1kWW5qa2hSamtTT0dSNExmdlN5cGNUd1RSRVRXNmc2WlJHTFY0UEtkcUR5?=
 =?utf-8?B?VzRWVmp0aHl1Y1dpVUUxcHdJeGhBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d861b41-0d51-4cfa-2fc6-08da00454c49
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2157.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:18:06.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPM9TOsMvGqGRAUWfUM4nCNwM83/Sa/iPZgr1CM4yNTTsXW5cqKfjwEgDwjRlDlVnp6YUIixqbtHEMWDjw973y8TqfVUACMoy2jg9SyDTgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-05 1:51 PM, zhanglianjie wrote:
> Now we can use asoc_substream_to_rtd() macro,
> let's use it.
> 
> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

Hello,

Thanks for your contribution!
Commit's title does not match the requirements, though. Please see git 
log of catpt-driver and align with the pattern found there.

Regards,
Czarek
