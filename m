Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E55A3B13
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 04:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiH1CqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 22:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH1Cp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 22:45:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD52C650
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661654757; x=1693190757;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P91KFgeB/kKS+lbPw/UOeVeujmLmpgLNHqRRBRzS2ZQ=;
  b=PW7AdIdDiV3E3y9QU53MXVcP52N2TuKI2zXPKt6X+RbQlK1coehksuKS
   7V32OA1ID9qCtvPaYfeicUfp35lePc0M2cB4TMpPswguPl4WlAbh2VIQV
   E0hIWLSutiDPVILGySBqQKqbUV86EfxDM+hxeJZ8kxXwkCJqwyGPK76Uv
   HV6ugNSAzsDMX5WmGdar4Cx3Fq27lLrTcH+swydMttvjgo8+20/g2PKJv
   aPZ8R/JIMa35EIjhZLinKQT9OZRfW4+7YNjKwD0ALbcJSz2BqhikwZ3zW
   z5qGK8xuSq3hXG0XsDy33AMugGeSAnqTo2bFQD2ZiMbIUXDC+zft6kAWC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="292285402"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="292285402"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 19:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="610942569"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 27 Aug 2022 19:45:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:45:56 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:45:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 27 Aug 2022 19:45:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 27 Aug 2022 19:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4NNfRZpaTyMDFJayTdoEzS+W+ZVJ3+JkwNRUUK9aPo22+deHdRoGfsmQfFvtjlQsbniaeR3uGPX46j7lB/KBkz+7I0CYmZzYaale33WgEjHB3tL+1MQpGNh2H1HKUW7sOFU0oMKA83pRfUS9+y2tiMTYtCoQP3FvtDn8eOZfPY6btQe6bi/tKK/+yy4oD1RsKpEsW0i/OBzWSx3+XbfpJDZLY8A9Zcso2xfRP8Xp9Xp+MIoR2CMXbuGpQSFsTeNQpkzbxvLxBsWXqJRtJH1pRF5UoQq2iuib/r5cB/gDK6QXrH6UD60EOa+8fL7frrR7TgOgodfM9cckyXdS2AF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbbLoeuJqIy8liNfz9dC/tgdBeB7RAv1REskB6LWHjk=;
 b=N8mBIJ4vWwCdTm/upJcR+1GauCxbPV4zUanlU2qjER24VHrM48WAgukCXIpivxFV7Xayw34HkY+DJ42pryYPYFUjsCZVJL+kAETa28gStwxcAelmOwJCAeGrZFDIswkMC3FAkPmdJM6GZRH7GbGZiyzyS/l4nI1nF8BINCKcp+65Y5dd5AI/wCBg5Z4U8Pd0hCTNVRwDZVoB2Zm45HiiyxUwm0VXc5HErNEktSz2v6Ac2G6ubkjMPat8FsaLi7i2XQmJdrv0UM46UxD5fPIQuWowCIfi7C4waO7+e9Zppsa8M4//GSwvrCl1BJ+C+R5XiOeV9ZuypACaWaQkCKCNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 02:45:53 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6%4]) with mapi id 15.20.5566.016; Sun, 28 Aug 2022
 02:45:53 +0000
Message-ID: <7c1638d1-8793-05d0-14ae-0c6c1c8771dd@intel.com>
Date:   Sun, 28 Aug 2022 10:45:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/8] memblock tests: update and extend memblock
 simulator
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1661578349.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <cover.1661578349.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343f0256-b7fb-48fe-5e5e-08da889f6c5a
X-MS-TrafficTypeDiagnostic: MW4PR11MB6840:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHZveMtliBKVeUyZUO0/jpLdpeSZhoQgqjxQiBu84pXakdpIJ5EUl9pmcFAj51HH61E+WGfItlFlZ4FglyOhKirO+1tu7y1Lfc82j0b2fPBW+ioSLEw8iIfp7z6jqeDv5v3uWHelaM0FFbtJxcYdA6+vdtoqnN1X7renVpkQih67xq0TeSEzKyKoa+ky5fP5tq2A++qovwCdZk9E+rq7kle4nompcreLZ7BZG4g/apBkrvYKB7wpcU8TK00QQlEix6GOdkp3xktTlOUyZZoMcy76GhJ20XxqAt2E0WaMTPRsqGaWvQH35MwStkWLX4cYQIQmYazwOW+hOYcMR9TrDlbfsj00WCdd0O3RXjf04VMrZfLWeuOByl5SOc7qOnmTE7WlQ/BVVjVmBZFFJdaHvs0eueHW7L35saK8nT8zdY4tpKYhZUMRY9BrjB6nMtFhTGKygTge1wh29+D8zpvrQ3CCWNo0VLZRDP3YwOzu1yjF/F6qfaxHP4vYpWePy9cWFuYYIya/mGjqWqMLmKNGjm8oXq3nqx5f2pDbjq7vangX02cvGRV+E/OqrT23CmIXNcy90bMkbqfDIRjLkEyt7bzZt3C9fWUjXy99dWxrAPUBpL+y7SXIu8nronR+fR7swTfzBR1v5QxEiaLXETe37SvEJJO/H7ZZAGk4Vik79XBe2hSx+psC5aihc+hvqiehGUJ0rks59oQ55IXnSQqMBOWzrOoVS7hallSuGTOdfuN/hTmSxwR9ArCQqdVLrb2ZljsdSHPKCg1LaX8iZFa18oFASvRrpBB4BoX5nX/ez1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(366004)(136003)(31696002)(110136005)(86362001)(4326008)(8936002)(66476007)(66556008)(26005)(82960400001)(66946007)(316002)(6512007)(8676002)(83380400001)(478600001)(2616005)(6486002)(6506007)(38100700002)(41300700001)(6666004)(31686004)(15650500001)(36756003)(5660300002)(186003)(53546011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVV6VlVtbHQ1ODZuTjVvN2tCMXR0MmJWYlRza2lHYmNUMEpBcFpFbVl2YW9v?=
 =?utf-8?B?dXhuM1pPQWhaUXppWXF6RlBCMkwrNTMveFNkSFpiZDJXQzJxcExaaUVSVThD?=
 =?utf-8?B?T3NxM0xhaG5qYnd6Q2gvUVdGOXkzNFUxR0hoL201M1RibTY1ZXJlUkZ0L2Iv?=
 =?utf-8?B?ejRrZ1p4OGp5MnN3cklNSlVJLzd2NW94UTdsTUtGamJXeE51VVNzbW1qekNW?=
 =?utf-8?B?d3BGditaMW9SWElaMTZoNzVmeStDYVNIZ3I3QVNzL0hKUjFsMnVjd2lmbkNm?=
 =?utf-8?B?dlY3YjlzYlJIajBCcnY2Tm5ZSzlmVXRNeFJ3ZHZmdWphdXNTdmFVL09kNTIy?=
 =?utf-8?B?bUlSbkFvU29MUjhvWjNBcDZySG1BV2dPaWxlZzZVTThNajdKb2FHTlN0NW01?=
 =?utf-8?B?eGM1N0lDSld4VXZibE1NZVJyNjUvOWYwRzlVL0xBbkNhUFhVM1NzTWtlU3NS?=
 =?utf-8?B?a2tkS0k4eVlXdHVqMTZEYWNEWTMzbW01eDRTMEhyaElNSUdEeXZXYXRvTWZW?=
 =?utf-8?B?MkZpQnpnSGpnT0hEOHBMSHVlL21ZQjZKcGtETDJ0Qm9qQ2VxZzMvOUMyZm9y?=
 =?utf-8?B?bW9NMGRxcjY4cFhlRmFsMjNPVEl2RWdmajliOXFFcnBLTlBqQ1lFb1pYYVJN?=
 =?utf-8?B?REhmS2p1Z3E4eWpxS3o2Mk8wZC9NbGFIbERJaXhwWWNacjl4NmJFc0dBNkpX?=
 =?utf-8?B?bnQvR1pOOHE1OGMyRGc0WDZwNS9VbnBwbVRia0dpZFIzYW5xVFZvOGtmR1Ro?=
 =?utf-8?B?dFErTjErQmFuaFUzbldsZDB5WUxaL0xTK2lXRjg5bExiZEJQTGJiUlhvWG9C?=
 =?utf-8?B?NDZPWjVHR3Q2YmxsTWdtMmRJSnl6a0lRcXRwSGxLMTRRZy9RNGFvZ0NrVEt6?=
 =?utf-8?B?UkJ0NVlxQUozVko4Q0lsRW9NVkx3bmtaUTZzZ0lCdDd3QjFVN2EwL2FOL0xm?=
 =?utf-8?B?MmZ6NU5DTDl2NzJwb2k0VXdhUUp1eWVRV0Y3TTJRRWxZTEpyWC91S3FIemdz?=
 =?utf-8?B?N1E5WUJiQ0ErR1VscDRqbWd3SlJpbnlJQzBJYnZzcmtZNHQ4STIwSTExOTRq?=
 =?utf-8?B?UWs3UVRWaEgyYkp0elM1aTQxcGtORWhtUmUvdUlWZnJrd3kxRGlEc3djKzZp?=
 =?utf-8?B?LzZkazVmcDhYREhpOStrcXBjTnVOUm5VUEV6OE1lZE5xUnB4SnBoelh1SVFK?=
 =?utf-8?B?Z2xMRksrYWR2aGVNVlBOYmJSYVFXSnB0MFh4cEFiM0tINUthWDhlZk8xbGxq?=
 =?utf-8?B?cnk2SDEzNGVXSTgzU3JTZTNpK1lwQjVzMWVTN2UyY3N1QzNGT3RyRldjSEJM?=
 =?utf-8?B?MXVkY3UvL1F4ZExvVVk5bFIwbThVWk0relhkUnVqeVc3WWgxcExldXN3Zkk1?=
 =?utf-8?B?MUF4QUN6RVcxRTFrTkJoNlVjVk05Y3EzaTR5ME9EZEdvVGNmbGIyZUM2R2I1?=
 =?utf-8?B?WDRhd1NYOW5QMy81blJaZFkrVkRnZTNSVWp1U1Y0d1lBUW9JYURBMzRZWlYv?=
 =?utf-8?B?cnQyWE1NbTJHTzNoNU9kckxnWUFYc0JzY0toTzNsb3R5dWVjaEYwOGViaUts?=
 =?utf-8?B?ZmhSeE95QStIUW44NktZeUI2NDdFT2x5L09FYWUrR1FvcUFpNVkvdGdOUW5H?=
 =?utf-8?B?cUdkc0M4WFhOdG9mZzIrRXpqbUpvVnp0WmFnZTM2ekxFMHUzTGQ2VVdyR2I5?=
 =?utf-8?B?Tnowc002YzJNUy84WXRwNGttWTkybVFSU0VFcGNXaXNNSzFFWWp2RnZKZUpq?=
 =?utf-8?B?QnI0bWk4OStSTWdPKytRZVdkZ2lsZTNhbWhoUnp6dFpWR04vTk9PcERxT1c3?=
 =?utf-8?B?SW5SMzE3WENFU3ZTLzJOSWZ6SnZ1WmdZNndrU0pZc2M2emlEdVdaQmVQdW1a?=
 =?utf-8?B?dTlNdkx6cUJUVHcvZjZ5cU5MUjhaclhVYVVBSCt4b0g4ZkU0aUpYWjJSYVN0?=
 =?utf-8?B?cFRNNE8ra25UTGY4SUJFN1ViVlhOR2I2bXRaTEwrZzMxQlE1UE1YSlUySGEx?=
 =?utf-8?B?SGxXWllwMkhnelZrK3lQV3UxQ1JTc1BmUWZ0Q2NvTUw1VFdmL1h4VFdLQnc5?=
 =?utf-8?B?c0FXQk56eUtLeVZ1M3huQnhTYTgzeHpabmRIcFM5Q2VucEV2WjY2RDdOenRo?=
 =?utf-8?B?b0ZEOWVhZ2p0WC92L1NHaVZrYXpmcFFpRE1aM0Q3T3pOdnBBWk1aaGFiaEh2?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 343f0256-b7fb-48fe-5e5e-08da889f6c5a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 02:45:52.7885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT48XCtE6i+MiG0eeMBdAPl/Qtc5jVwxC6y/cPAA9NMzJ+akNtdZljvuncmIF6DhB2cXMzr4RvIAxj7KqnjdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
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

All patches looks good to me.
Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>

Thanks your effort for doing this.

On 8/27/2022 1:42 PM, Rebecca Mckeever wrote:
> These patches update existing tests in memblock simulator, add
> additional tests for memblock functions that are already being tested,
> and add test coverage for additional memblock functions.
> 
> Updated tests for:
> - memblock_alloc()
> - memblock_alloc_try_nid()
> - memblock_alloc_from()
> 
> The updates to memblock_alloc() tests include the addition of an assert
> that checks whether the entire chunk of allocated memory is cleared. For
> memblock_alloc_try_nid() and memblock_alloc_from(), the assert that checks
> whether the allocated memory is cleared now checks the entire chunk of
> allocated memory instead of just the first byte. To make this more robust,
> setup_memblock() and dummy_physical_memory_init() fill the entire MEM_SIZE
> simulated physical memory with nonzero values by calling fill_memblock().
> setup_memblock() is called at the beginning of most tests for
> memblock_alloc() functions.
> 
> Additional tests for:
> - memblock_add()
> - memblock_reserve()
> - memblock_remove()
> - memblock_free()
> - memblock_alloc()
> 
> Introducing test coverage for:
> - memblock_alloc_raw()
> - memblock_alloc_try_nid_raw()
> - memblock_set_bottom_up()
> - memblock_bottom_up()
> - memblock_trim_memory()
> 
> The tests for the memblock_alloc_*raw() functions test both top-down and
> bottom-up allocation directions. To add coverage for memblock_alloc_raw(),
> the alloc_api was updated so that it runs through all the existing tests
> twice: once for memblock_alloc() and once for memblock_alloc_raw(). When
> the tests run memblock_alloc_raw(), they test that the entire memory
> region is nonzero instead of testing that it is zero.
> 
> Similarly, the alloc_nid_api was updated to run through its tests twice:
> once for memblock_alloc_try_nid() and once for
> memblock_alloc_try_nid_raw(). When the tests run
> memblock_alloc_try_nid_raw(), they test that the entire memory region is
> nonzero instead of testing that it is zero.
> 
> The patch set also adds labels to verbose output for generic
> memblock_alloc*() tests that indicate which allocation direction is set.
> The function names of those tests do not include this information.
> 
> ---
> Changelog
> 
> v2 -> v3
> Based on feedback from Mike Rapoport:
> PATCH 1:
> - tests/common.h:
>      + Move (char *) cast inside ASSERT_MEM_EQ().
> PATCH 5:
> - tests/common.h:
>      + Move (char *) cast inside ASSERT_MEM_NE().
> 
> Based on feedback from David Hildenbrand:
> PATCH 5:
> - tests/common.h:
>      + Add comments in enum test_flags and rename its values.
>      + Rename verify_mem_content() to assert_mem_content().
> PATCH 5, PATCH 6:
> - Update commit message to explain that the memory region is initialized
>    to nonzero and should remain unchanged when running
>    memblock_alloc_*raw().
> - tests/alloc_api.c, tests/alloc_nid_api.c:
>      + Remove func_testing array.
>      + get_func_testing():
>          * Rename to get_memblock_alloc_*name().
>          * Remove else.
>      + Remove else in run_memblock_alloc*().
> PATCH 7:
> - Commit message:
>      + Change "region unalign" to "unaligned region".
>      + Change "region unaligned" to "unaligned region that is unaligned"
> - tests/basic_api.c:
>      + Change phys_addr_t alignment to const phys_addr_t alignment.
> 
> Based on feedback from Shaoqin Huang:
> PATCH 8:
> - tests/basic_api.c:
>      + Change "trimmed at the base" to "trimmed at the end" in
>        memblock_trim_memory_unaligned_end_check().
> 
> v1 -> v2
> Updates based on feedback from Shaoqin Huang:
> PATCH 1:
> - tests/alloc_api.c:
>      + Remove fill_memblock() from alloc_no_memory_generic_check().
> - tests/common.c, tests/common.h:
>      + Change fill_memblock() to file static.
> PATCH 3:
> - Shaoqin Huang and I discussed using run_top_down() and run_bottom_up()
>    even for functions with `top_down` and `bottom_up` in the name to
>    maintain a consistent output style. However, this would make the output
>    more redundant, so no changes were made.
> PATCH 4:
> - tests/basic_api.c:
>      + Rename instances of r1_size and r2_size to
>        new_r1_size and new_r2_size.
> PATCH 5, PATCH 6:
> - tests/alloc_api.c, tests/alloc_nid_api.c, tests/common.h:
>      + Change verify_mem_content() to a common function defined in
>        common.h.
> PATCH 8:
> - tests/basic_api.c:
>      + Rename instances of r2_base and r2_size to
>        new_r2_base and new_r2_size.
> ---
> 
> Rebecca Mckeever (8):
>    memblock tests: update tests to check if memblock_alloc zeroed memory
>    memblock tests: update zeroed memory check for memblock_alloc_* tests
>    memblock tests: add labels to verbose output for generic alloc tests
>    memblock tests: add additional tests for basic api and memblock_alloc
>    memblock tests: update alloc_api to test memblock_alloc_raw
>    memblock tests: update alloc_nid_api to test
>      memblock_alloc_try_nid_raw
>    memblock tests: add tests for memblock_*bottom_up functions
>    memblock tests: add tests for memblock_trim_memory
> 
>   tools/testing/memblock/tests/alloc_api.c      | 168 +++-
>   .../memblock/tests/alloc_helpers_api.c        |  20 +-
>   tools/testing/memblock/tests/alloc_nid_api.c  | 252 +++---
>   tools/testing/memblock/tests/basic_api.c      | 767 ++++++++++++++++++
>   tools/testing/memblock/tests/common.c         |   7 +
>   tools/testing/memblock/tests/common.h         |  55 ++
>   6 files changed, 1082 insertions(+), 187 deletions(-)
> 
