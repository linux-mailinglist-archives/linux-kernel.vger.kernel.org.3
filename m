Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D458F52C16D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbiERRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiERRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:45:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2321F60B;
        Wed, 18 May 2022 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652895953; x=1684431953;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wDZHOF+uht3wNtPWbSu0WdoCsoXbeSOWwE8EG3rbEZg=;
  b=lc3WS+SnlPmdta4YAMlAfUU4AyqMmUTKasQkPMLYRcoYhz4NN2QNxgVk
   V4TrkUg4VsM0KrgcY8rDXGZv2Tymzxs5taVZzjpZIOwEtj/jvSLLViz+Q
   IUgarAXJsMOWLEt6knf799dcsA4Z/x+NPui6kfwsk426wmg7UvxyA1Lv2
   73OIhVhaRl1aIE+E15DVnGEDgKYSAq1EmA6+LxKUrr9kLO4OLY7g74reT
   5FhiQBKcdpBln/7XQse1F+18XzNsAOYBPU+lEA/Tj+b7p0SIopBM0Wx5V
   SXH28JfoylecvYkE960N04rQ00/sPjdIeTaCkfp5PToZnKFyLd16DL5A4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="252318277"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="252318277"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="569639147"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2022 10:20:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 10:20:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 10:20:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 10:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgdCI2j/tbjhk0KD/XcKCyh9xV+eCq7Z8Jta8GUv8+EYt9wfAtwWMto/oESoE07x1MehDw+po7CNv1LlbsyOx1Mnh+9tjt4uGCZ/fS7II8rRgug9J0EVKTq2z2OheKberSn29QvwvFuJI/wXAQpFqIyFTGs8X+L0U0jiyBhbE66+PNx+59kJjMk2DNZ3giDcHRUfaqRV6hs4BkwKNM3iE8AHp/ltc/MTipcsxKgBXQxu440SvpjqF8db+nCzMjTPh1a9JhEjtAw3PMNfMM6adglTuK/nw3a4jadfUOVq0UoSZmdxHx7RAzS5k9oJe9gP6kWMAHLPc5bwuHT3gzXlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp0UQ5ox2Mf8kWkQHBN5zSwC9mIH3jT7XNDdHEfMCPQ=;
 b=YBlfnDM4wfvJ/Vn6rL//FHI4R2qFbHjNWX8Um6t5CS7E/kd5uKhbFtZ51DAlMs+tWcTSrkDILqiOmumwBj2JGFsrLL7SFUpAb6+SwlEl9Nqpuy6Auv/Pwip4EHhSdb1e7CwAye2ONVspXL933Otdy4otrB/o1B0+wLKnye6Z0fcyl9cou+0HO3ghtHOYSkw1y485ZShf94K0DXDBRyTfYDgEm5CbzRgp4/2Jl0FdxjVtW9MgoOowx/fjcKN4EVpH5iy06pcMoJxQEf22Ung1dcnjJSWmN846VJxOzcPIPKquvVCdPVVlWfDS2OPfUioMEzv53zb+9LpwDqSylxptJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN7PR11MB2833.namprd11.prod.outlook.com (2603:10b6:406:b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 17:20:15 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::1c70:a7e4:c7e5:1c9c]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::1c70:a7e4:c7e5:1c9c%8]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 17:20:15 +0000
Message-ID: <d081a3f8-4a66-f411-f1cd-e80d752d3851@intel.com>
Date:   Wed, 18 May 2022 10:20:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <tglx@linutronix.de>, <dave.hansen@linux.intel.com>,
        <peterz@infradead.org>, <bp@alien8.de>, <rafael@kernel.org>,
        <ravi.v.shankar@intel.com>
References: <20220517222430.24524-1-chang.seok.bae@intel.com>
 <20220517222430.24524-2-chang.seok.bae@intel.com>
 <25a2a82f-b5e5-0fce-86c8-03d7da5fcdd1@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <25a2a82f-b5e5-0fce-86c8-03d7da5fcdd1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9802e098-49f7-4ac6-f20c-08da38f2ac76
X-MS-TrafficTypeDiagnostic: BN7PR11MB2833:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB283378635A514EB278BCA0EBD8D19@BN7PR11MB2833.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t04l2rgUyzpFUwffUCHcK5ShkVPxPZvxoMS3PKaBxt8L4bmEWEoP1Z+VO3eK8mSRppZB/r5DPyUntwe4Yz9Ya1U8dt1H1qD+lmPJQsCIiNlBhHcwh5YdA34/z9EngC1ZAgGOqV6Wla8jXjQuuLPW0dCGlf2f94hfkJiC3cOm7y1toCs/M+ncdsekhIqnacFn08nAkltSRbsREuLxBvvXNFwQmB4nwZirPtmslAARFWb9VyF+7QlY5Mg+LV21oWU4ZAybXrYDm7dUdVbJaCEHnJxTZ1kfQhYuIFpvsFR+d87A6kfLRs/1cu65lkCb4apLJtXV6nBr9yLloVz/LGJr31LPxiEZereXHSs3NVvdCPD+CDVWvnf0FeN6oeGJUm/dnk+/Kx4TzDMwK9yzFeI+M2fyNuQCnBNiKj0+MmclG0/K5ruozPZGGDBEevVNdTcUV0tjFX9u/ggAfGbndt6U8fVqV0Kl+WdAuNwSPaXJFiNFghg3Y2uSrvA8QnwzlJSfYUFmZulW4Nof7WIiK1mXGUOJYN+DGvYnvEN/JEl3slO074WtHDfIH/h4hOtDiKkmdJo1JZ8Vsn4dRqCzxAc18JJgTdFrb73qyf7RNRbzsHoVvfB/viiclKPujZPECY4L3C8sL9xEC+1Pb7/pO+omQO2vXmfhShiVhomJocXTaswQQwx+CkoZErwmX5UXi55EmroFdtrOvvnPHMT7NckitZSG6I2yRJSNaQxz0dN8KMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(2906002)(508600001)(31696002)(4326008)(316002)(86362001)(8676002)(66946007)(83380400001)(66476007)(5660300002)(8936002)(66556008)(31686004)(36756003)(53546011)(186003)(6506007)(2616005)(6512007)(26005)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTB6elVzdkU1V0hlV08xemlVbDFRV2plYUV6ekZSOUUvVU5ia2lPZ0lFZjJL?=
 =?utf-8?B?UUhwNVRoSXR5b2lqQzBlWTErWkxEKzhMZGtrUlF6ZnRqZHp2aDhGVjNKSzRk?=
 =?utf-8?B?b2hhMU9YbEFKNERLWG9jbEtsR1Jka1RHNDcxbS9kOFNvcHZDQ09qVjRGVHFK?=
 =?utf-8?B?V1FBUmJ5ekI3NkFGb21ZbS8vWlJQSkxsbjlveDJqQTNGUTJJcWNIZG9iY0p5?=
 =?utf-8?B?L2pseHUvZ0toWFJ1ZmpUZ3NBYmVPQ2lOZWUzNFVCSDd6cnNWeEc3YWtiYWJs?=
 =?utf-8?B?Sk5BcUJoaklqaHIxdHAzYWNaRjlZTmNnZ0dDSkVQeHhNYndDRzFlczJDbC9P?=
 =?utf-8?B?MTgwVFVBL0VqYWN6YU50cFdKejZRdHl1WE90Z25ibk95cE1nUTR4YmJYRlBz?=
 =?utf-8?B?YmtscjBkRnBFczR1Vy95R3RSN0FRcDJlNlpSL1lmZzhSbE0wSGNJUmwyc3Yv?=
 =?utf-8?B?K3dGMUFrRlNpODhpRm01S0FybW5hb2tIcyswS0JscVlFd2cwUXBpckJNOGZi?=
 =?utf-8?B?V0ovTkkzaXpiaTNOQlFwQmxCWk5NNGlBRkpWVWtvOEEvSDhtNTlSUTZJY0FY?=
 =?utf-8?B?Z280dnhhNFdjWXVBNjFHcHI2U1IySXFuZFFGdnVvNVdVUE0rRC9JZXNTZnU0?=
 =?utf-8?B?bzQrdlRYSDZzYUg0SjVFbkhRYzgzL0NFak9qRVAvY3pJUVpEeU43OXpVcjRj?=
 =?utf-8?B?SGp4Yzg1aVNHWWlacWJwQzQ3dlg4OEhEeTBTMmorMWxza0EvUkVTMGNjUHo3?=
 =?utf-8?B?NFNsTFQrL1l4OUdUVWl1cUdUeE5zSkpyeVNtRmt5RXNTNWdOaTY2Q3MyZkQy?=
 =?utf-8?B?a1F0VktHakpid1Y0QzJmU2pLNERlVUxWNDIrdG55ZUpJbDdKWVhDK0V3QitL?=
 =?utf-8?B?TWQ3b0R3ajBmcTVOWnJyMGhiTUN2dHZHOWY0RjFOeGlQN1luSG5rUEhtS0k1?=
 =?utf-8?B?cVYxRW9aU3VKTk9vcGhCaDJtVnNqV1dRbGlHR09DaWRwZnZCTSszY2lsMXBJ?=
 =?utf-8?B?c1hRV0FOZlB1SXVTWWhTVzYwSmsrSERMbGZaZXVBbERwVEVJMHY3VmhFNkdE?=
 =?utf-8?B?RThseS85ZEhKVHFBeGprZWlFRDQ2eTFxL1BYWENDTFhQaGF1ZFhTUmkvWnJV?=
 =?utf-8?B?d09UNXVVKzliRzVBdXhsR2xBQXRWWGEzS091QlMyYlZ0RmN3NjhFNFBpN3d5?=
 =?utf-8?B?OVRjSG1uVmhUUnNpOVhsRGtiNnRFL0hZUzR1Sm5mUEg1N0NOTE9XNW8wRjkv?=
 =?utf-8?B?ckRRbFNMYlZGRGRwcE1XZ1RNU0lzU3FOa2xkQXRiWTh4YytGVTJGWk5kdDl0?=
 =?utf-8?B?ZG1EaDRLTE52K3FXSHYrd0FlSWZMaXhvQ3RxTHk2b3g2aGZ3b1RvUEp5Q3VE?=
 =?utf-8?B?djA2RE9WSFBTb2t2L0FhWUppaUVTZkRLS3FhR3dpUU81ZzRxYzdZeFF1Z3Aw?=
 =?utf-8?B?R3JNQURBSFhFdDB2Wk12VzE2c2QwOEpMMFdncDF6T1JQbHplVnFnVnpOcjhr?=
 =?utf-8?B?dHQyWVYxOE42emhrbWNNcVk3eVhBYmZmb0lkQWR5TllNbDZUVzk0Zit4N1Yy?=
 =?utf-8?B?SUQvWE4zc3BUcXNjTjhwRFlESGRCUGlUVkJsQXgrK3BIM01iMG5FUHRja1FR?=
 =?utf-8?B?ZWdQd0ltaVlyMFpOcUxyaUdabzRQMURXWVV5QVJKaFhtQjdrajlLS3RQMVdY?=
 =?utf-8?B?RWdxUkc2bmhLNm9peWh6Vmk4bFY1eGQ5UytTTStDSDJBNWdpRzdEMDRaMmZU?=
 =?utf-8?B?MzE5MkZHNGwwMnJaK2xwai9pdFo3SFB4WVdzQ1F3dm9mU09oM04rNXEwcWMr?=
 =?utf-8?B?eFdvbnU2aVBNWWlYVVN6OFZDOVc1ZHJCQVo5bTJZWlFwUExWemV4bUNZa3Ur?=
 =?utf-8?B?anNmeng2SGppZk1VMzZSQUJ1ODdPaDNDRCtWYkFSYUwySDB3ZWxRTzc5SC9D?=
 =?utf-8?B?czkxV29OUzBBQ0Q1aEZKckNrNWNKcUZ6bzNlZVBHQkNLeGdybUNWbGdGdHBk?=
 =?utf-8?B?bTY1T1Q1ay8rRXZITWxGZzc1YlhPbW5nK2pBTWRadWxYejhsbnpCOE5QaEM0?=
 =?utf-8?B?MFFEenN5MjhMYloxN2o0R3J0OVRBT2ErRnVuS0RaU09zOXlMako0UjZHdGRW?=
 =?utf-8?B?NWFvVFlEVWhaSkowNTVCZDM5QTFaM1VPNVdUTVlFS1g0T2NmcU85Wk90V0t2?=
 =?utf-8?B?V01rNldLU1VUMitEUXAyYnorekdDL3BSU1QvdmE2ZmVWQ2QxeEJQSmFqV1FI?=
 =?utf-8?B?SjByelp0QmJzdEFkSnJaMGswMXFpd2RlNkQ0YmdDbXlkYUtGNUEwd1QrSFMx?=
 =?utf-8?B?dE45Z2JKejg1REtxZXVpeVNBODQ3a0JaVzhOTDNUOUUyYkZHRXBiMW9RdHB3?=
 =?utf-8?Q?Zwd/lPLKEJf/4v6Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9802e098-49f7-4ac6-f20c-08da38f2ac76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:20:15.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga+oXcvb5w9ih1B8lVQC9OgPcHlf/9/6g4KEk3da6+2uY2jki+WW6UFhjFjC7gF8BP3bqJZom3ak/81WJyxIuYnoSADz2w42ewJpRY6SFCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2833
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2022 8:41 AM, Dave Hansen wrote:
> 
> This is a pretty minor nit, but:
> 
> X86_FEATURE_XFD depends on X86_FEATURE_XGETBV1
> 
> and
> 
> X86_FEATURE_AMX_TILE depends on X86_FEATURE_XFD
> 
> via cpu_deps[].  So there is an implicit dependency all the way from AMX
> to XGETBV1.  It's also not patently obvious what X86_FEATURE_XGETBV1 has
> to do with the rest of the if().
> 
> Would this make more logical sense to folks?
> 
> 	/* Note: AMX_TILE being enabled implies XGETBV1 support */
> 	if (cpu_feature_enabled(X86_FEATURE_AMX_TILE) &&
> 	    (xfeatures_in_use() & XFEATURE_MASK_XTILE)) {
> 		tile_release();
> 		fpregs_deactivate(&current->thread.fpu);
> 	}

With the note, I guess people will have no problem with AMX->XGETBV1. 
But I would leave this question to others who can tell.

> 
> That also has a nice side effect that non-AMX systems will get to use a
> static branch and can also skip over the XGETBV1 entirely.

Yes, but FWIW, as it is non-architectural, the function should be 
consumed only by drivers for AMX systems.

> 
> The downside is that there's no explicit XGETBV1 check before calling
> xfeatures_in_use().  But, I don't really expect the AMX->XGETBV1
> dependency to go away either.

Yes, as long as AMX is wanted as a dynamic feature I think.

Thanks,
Chang
