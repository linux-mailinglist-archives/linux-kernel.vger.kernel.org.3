Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92137571235
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiGLGXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLGXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:23:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4113C5F4E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657607020; x=1689143020;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jJL34ocHY19ESQbPaq99JDHLgOVaFFaZE9rRQoNyXuI=;
  b=b8GGSpmShjehBpbgSpwNXstyYMgXzzezZG9oWjms7suCNrIhg6l/+JCO
   3QhLf9CSih6K1pzb6KHCC4nDzvUu6pdBUnKClDqbtVPTIXgH7nUOfB1T2
   DOwuK0wHsweb+Tw7VhrmTTXSkQrmAZSiyEseinQ04g1gLJ7RAMYmLFAlk
   EZkot4u7COElqqwaX7e8XeQz4Y+KCFL7duD+tep0kvN0Ok0h23Lm3+A0n
   ygxG4el1vXhos7r0rf6KzxP1TDd4XyQbfiPGI2gqaLAJysJRmeZ8t9rEw
   TGsDNh0YI8KdAG+/J0M8Bqxd0tV6fPnZvBF2bVKAL4VXAgpm2dUz2zcPX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346533830"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="346533830"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="771773667"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 11 Jul 2022 23:23:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 23:23:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 23:23:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 23:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL0JqsGP0A9MM3uara2vQqtkwH6kGL6wD6ZI/pzzfRWD+smmeV91pDp9Bs3WBR0sJZugwEHg79Vu54fTchmsNbCFyiv//6i9O5M4Kl86huAFYOXbZl719wyi9Y0iokk8dElgLXXhLwLMNzOEJj3dnrSLLIfBfYDnuwBMQjwvK26elpZLFefbtIkBX/r/aRPSdDAAOOD2Nef7wEMnrjaXO9/AeA4rry62l35y3Skp8pUit85Ty/X0pm9e8hOhhWFqhkdqnxam0x72ioxcUd2nPMUdzuAwR8VAE/6mxQxtnFELn+JRz0j+MB16cI389kdMuUjX6fDsbSRB6ETWj6eVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+Abg6F6yu9IVrTZNL2lHnktL8Pi+/4u0jI74nA1Zh8=;
 b=NEkDj96U24Dps0kwXttooF6be35zumLS9XqFRPR9qntSkCNck36M/lG8BAX+4YIOcgHKrgqY7Gsscnt3eha4VzUgN3zkTaqHo4oQptQyowUBS7IaW8aWOzVbXXR+9nwnyvOpLp5LtmsHayjBjd6R+l2zrIjgX2jqnA7EXo29E0ELuC9hb4zIspR1T8CnlksYP2onMiXU8SOK2UrSjDFmKAWPuGTkgLhwl8Otcf1RTkI8RGL2T7bHS0ULcAb6nw6p+85/XnOiHedDOV7coXbnKkQIICNbHTsPzOkhUlMOByqcdotvPSZ8hSyJgkvB9nLBUZtmxr5GzrOoWDVfX/vQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CH0PR11MB5345.namprd11.prod.outlook.com (2603:10b6:610:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 06:23:37 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:23:37 +0000
Message-ID: <93b35388-6b7e-553a-5e09-e72332e1d168@intel.com>
Date:   Tue, 12 Jul 2022 14:23:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: [jolsa-perf:bpf/tramp_27 19/33] include/linux/bpf.h: linux/refcount.h
 is included more than once.
References: <202207111228.MrXFMOmS-lkp@intel.com>
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207111228.MrXFMOmS-lkp@intel.com>
X-Forwarded-Message-Id: <202207111228.MrXFMOmS-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a5d6790-5386-427f-2df0-08da63cf0e17
X-MS-TrafficTypeDiagnostic: CH0PR11MB5345:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbzPYXxyaojmtLIlFgJPZW/R4wjm0BnUCCheDeBM+DI58lmrPe0gzz08ryqTlB4g7dJwsO4dxSu377EqhISEovRylz+hezYFCfy321cb93vuT7Hmgc+nOZEqkc4XUwfS1/FLUGhN0827vBmIhoYwUZHLzSMrpmhwxX11jg3rRJLJoqQ/ww3QbuvFNEq4Hg59V2OiaVs327Gx8xZA5wkenniZ4OFk+l0Fsfo4FZNd0D2AY+eBVc/fRHJ6P8OlwFTHLoohCs8FI/4EfDMildcrwteHX/FDTZVUDxilmB2JLn70pYXCyV43AyBc1LMveP18CojMlL/aIWcVLAouY12IXrqf3zTYV+BW5rrj7UATt9DdjFJdOiZDeuKWm4l8tpcEy8EOqC5l2Cplp98j7V7ITHKn/J7QF69UM+wL3x6cxgIWTcaypOAulNWholFKYOSftVSp9P8GqzZqGZ3RdqYcSJcXSC7QtA+kKPyDS/oFybcu2BbzLb7EAK03EY+n4iTDfhTySFBsojmfBXutoKfk1+bu+DwVKDCq0PyTCjjvR413r2s3R6onNW4AyBdfPM3QaaF8BdpVO9y/Y54WjaC5uPRiXRKPVmCiInTzi6m2f8qGE7ptqCyrVEwVPKowDxXOyOSIa/7L8bvzWh2WZXO3PSMJR0pp8nchPFQItrNvLgiD1pw+LdVyO8D3q93aJMnGhKhQwyf4VuwLddIgocng6y38bdF0t8tzzMy0MjRiSuMhrElaZX2VQBMyFifbh5YpBe0wm+kuXLIP5fw+anrIaE9Tlr/WjXolT5YsnRSWJTFZtMDtcc3ERhdAnNqBQDVKtLS1xs0hVo/Pt+M7aEiM7GIHexUBipdKS1WoD8cypMHrNZ/SGpD/+lt4GyEIR4y5a6024CKJiLCP5e+hlFP9SfnpBtDP9BkO9Xqv6lM51M4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(376002)(136003)(39860400002)(86362001)(31696002)(8936002)(5660300002)(6512007)(2906002)(6916009)(6666004)(26005)(316002)(6506007)(966005)(31686004)(38100700002)(478600001)(186003)(4326008)(83380400001)(41300700001)(82960400001)(66476007)(66556008)(8676002)(4001150100001)(2616005)(6486002)(66946007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkc4MDNZVmdvT1FLQ1JnaUVFOXNjeDlnb3ZiMlhTRzFZeTRmQUZsbncyYmxy?=
 =?utf-8?B?bENrNTVsM3A0NVIyOGY0QUdaWnBoUkQ4NnZQd2lqY01TNTV6b3ZlMExRY21W?=
 =?utf-8?B?TVMvVytYeFkwbXhnenphN2kxQ0pEODR4MjBXSTBxenZUK0lMV3BXdjg1Rk42?=
 =?utf-8?B?anJWYS8zYlEzdFRQNVIwbmRJc1JQcnJZZkRPWTR1RE95VUpwbENMY256a2dS?=
 =?utf-8?B?eFhzZ25oWGZ4WmZwVVFZZFVQRFFwZkdOb1ljYms3dkNVQ05idVZOeXpwYUx6?=
 =?utf-8?B?RVRJaFh1RzhxQjF0KzZrdHByYitKUmNNdURPT2Y3UFFjSnRNSU5YMTVJNHRN?=
 =?utf-8?B?VXhEMXppaVhRYjNKOFZHSlpkbDd0WDRLSnZDQjQxVFg3SkVQb3NMNWhhNW1i?=
 =?utf-8?B?Ujh0aGNxYXV3Q0VqSkJUcXRuR25UaVhWL0tTQ3p5RURUaUI3WFpjZVRNZ3Vm?=
 =?utf-8?B?VURQYXdHb3dqMXh5VndCUGg3bkRGZDk1TjlaVEpRWVNRUEJIZGZqeHU3UC8z?=
 =?utf-8?B?YUk1WVdBd2Z4WFl0UGhVTTVYUTR0SUZYSUlBdlJyYWdiU2ZRR3RnODNuT2t6?=
 =?utf-8?B?TlpOVDNTMEdMeHJwSUdQR1BmZTFCZE4zanh0QkVmR1Q4bC94eUF2T1kyT2w2?=
 =?utf-8?B?REUvSFBKTkE0NDMrVFkvbkNVaFR5TjFZdjlUWCtiZUYyL3ZNdG8zV2Foc3li?=
 =?utf-8?B?bmxOZkdwckpRc3Y2Q1RpVnU4cTU1RTl5eUlDZHBDQ3lGK3Mwekp3cUNTTi9o?=
 =?utf-8?B?dXRWOXpGbnMrMFlIL3ZGa3NMbGlneTJxZWpkK0NSTTk2VXFBbUpIdGFiK3RB?=
 =?utf-8?B?WVkyZ1BFRWxGQVhDSkNyVU9TKy8rMW54ZzVEVC8vanhld09yem5rWmh2aVBq?=
 =?utf-8?B?Y2F0THhlbEFyc1ZoZEh3ci9DUWFhV2dpaG9uM214SHBVVmJtRVRlUmlGVEJz?=
 =?utf-8?B?WVhnWjlINzNiM3ErUDVONmJmSzBFU2RpQlNvaHRrUldPS1lFdXp4SEZITEhQ?=
 =?utf-8?B?RTV6a1NkNHBPSFhpTEx0TzZmb290TFBRd3M3eGcvVXQyZ3VwdzNDYlVvR1JT?=
 =?utf-8?B?UTR0N0xMdlk4V3FJVXFwK0w1WUh4NGFiQVBUcWJCSjFXbkllUFB6b3dnZlFC?=
 =?utf-8?B?eUJTSzMrYndvNGdPdnRteFR0VUlZU0d1Y2xrRW96NUZlL2lPK2NybU9YTzJV?=
 =?utf-8?B?M3hyUHZYVUVxUjgxZmVIWldrVytXZWRtcDZMYVVuelFydVUvdzA1Y0dnaVE3?=
 =?utf-8?B?V1R6c0wyZUtOYzgyTk94aTMrZ0pTS0FLTjlJYjZsVmFvZW5EMDlOYlNGZlky?=
 =?utf-8?B?c0FVMkQ5ak1oTllwL3NZcW9NaFlXSFB3eENxQ2orU2UwT01JR0c0VDZwdE5U?=
 =?utf-8?B?RzlYblhCcUF2SGxMSGNBdDNHQ1RNWE1lamFsU2VOUG8yVU1uaXpWQUhaSURX?=
 =?utf-8?B?dnlCc2Q0ZWFIWjR2THdRRmhORlZraVJHUW5pWnJ5cFZmNldwckxXMkFSQzdB?=
 =?utf-8?B?TmQ0NUYvaXFwdHVOd1Q2ZEVVWmVESTZVWEdTVWM5MUFRZW5aQzdza0dhOUlT?=
 =?utf-8?B?bDdkNUVGZzNEUmdLalJ4WXRZWTFYQ1JnaHowSEtQdWFTWmFCTjlhMUhiL1ZX?=
 =?utf-8?B?OS9SWXhxOVFQWWdOVGtCL3NwaFFRQ0hqNm9ZVXdxMFZGbnBWNnZFc0Fia2Jj?=
 =?utf-8?B?cTdXVkt6dzkzYUhWNE1samE5Ym0xZWRMcFlxUWJiY3I4YnJOUVZxckpGWnlq?=
 =?utf-8?B?Skd4eXFndWhaU1hNVVp4RDg1ZG1QbTlOYjlIQVNwMmg3NlpISktqWE1jclpa?=
 =?utf-8?B?bEtRb095UkdFSUN4UjhObTRXdUsxYkUvYXYxdjF3OEpaS0lvRXNZMWJKNzAw?=
 =?utf-8?B?K0lGNkVXU1ZqSnliMFNJUktONVZMam5hc1QvUjFnV0g4Vnk4ZHo1SHFYM3Zp?=
 =?utf-8?B?bnRSRnUxci9oelhzWitKUWlwN2R2dDVBMHo0d3Q3cGV5U2JNZU40cTBmVHJZ?=
 =?utf-8?B?NVhiOXQxQU5xNUJDdXNsd21VTGNBQVBPa3Z4NVpzanFzWEdDV0FVSWhyNjE0?=
 =?utf-8?B?dlpwVlIyWlBSckduZWVBZ1dEQkRZQ0Q0aFV3U0d4Q1NoTXczYjhRamovZncw?=
 =?utf-8?Q?PJES1cTCWikT6uBI89hy+zof1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5d6790-5386-427f-2df0-08da63cf0e17
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:23:37.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33ziAplys1Cw9Wz2AxuWkfseo6HAK5/TqPIMJoeR5KwN8Ymz3hjYVrze1QucoTnaFgZtn4WsWKenIWyOHoHD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_27
head:   08201713df8992b94d140b43fd4f20f1ad4aedb3
commit: 4e0c494bd2718df080d359785317d2b9234a79be [19/33] bpf: Add refcount_t to struct bpf_tramp_id
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> include/linux/bpf.h: linux/refcount.h is included more than once.

fc9702273e2ed (Andrii Nakryiko           2019-11-17 09:28:04 -0800   16) #include <linux/mm_types.h>
ab3f0063c48c2 (Jakub Kicinski            2017-11-03 13:56:17 -0700   17) #include <linux/wait.h>
fec56f5890d93 (Alexei Starovoitov        2019-11-14 10:57:04 -0800  @18) #include <linux/refcount.h>
fec56f5890d93 (Alexei Starovoitov        2019-11-14 10:57:04 -0800   19) #include <linux/mutex.h>
85d33df357b63 (Martin KaFai Lau          2020-01-08 16:35:05 -0800   20) #include <linux/module.h>
bfea9a8574f34 (Jiri Olsa                 2020-03-12 20:55:59 +0100   21) #include <linux/kallsyms.h>
2c78ee898d8f1 (Alexei Starovoitov        2020-05-13 16:03:54 -0700   22) #include <linux/capability.h>
48edc1f78aabe (Roman Gushchin            2020-12-01 13:58:32 -0800   23) #include <linux/sched/mm.h>
48edc1f78aabe (Roman Gushchin            2020-12-01 13:58:32 -0800   24) #include <linux/slab.h>
e21aa341785c6 (Alexei Starovoitov        2021-03-16 14:00:07 -0700   25) #include <linux/percpu-refcount.h>
d687f621c518d (Delyan Kratunov           2022-06-14 23:10:42 +0000   26) #include <linux/stddef.h>
af2ac3e13e457 (Alexei Starovoitov        2021-05-13 17:36:05 -0700   27) #include <linux/bpfptr.h>
14a324f6a67ef (Kumar Kartikeya Dwivedi   2022-04-25 03:18:55 +0530   28) #include <linux/btf.h>
8c7dcb84e3b74 (Delyan Kratunov           2022-06-14 23:10:46 +0000   29) #include <linux/rcupdate_trace.h>
4e0c494bd2718 (Jiri Olsa                 2021-10-12 22:22:08 +0200  @30) #include <linux/refcount.h>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
