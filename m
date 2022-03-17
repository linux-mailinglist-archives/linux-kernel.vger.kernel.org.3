Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56534DCBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiCQRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiCQRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:01:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D3BB82CA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647536418; x=1679072418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QcgYFad0ELw3MIfgNO1v02vNHzpjUeHjfMZfAk9aw8U=;
  b=a7GSNa6SU/XD0aAqbXfHMH5b/AukO40+S+/VTwvkrGhyo1yyCit2ulkT
   /ukAqsqfcfBIHi2weLCtlexGwJgiW7Dl9TQi4OkK19sH6OjvfZ8GlOwXV
   oVAnFcFHsA1PJue+YlwDLWuPI+JIUniHn7zPEriIak3KqQAlhuGOJU7i+
   G01wzcd2IsS8GpUHG0CtLgOK8jI1ouOTRga03KMgiDjhts0Wai5xRYlz5
   hO3jvZdK1FQE6PeSDjWIXqKffpVviRW4UMgk/KfFr9PaX+MARoYaPDYKD
   jwC7pQ6yAkcDgFRPgIxIaYFcxLuPlGHKlnV+dns20PZoIIEVYjOrr8L9Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256645302"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256645302"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="498901865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 10:00:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 10:00:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 10:00:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 10:00:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 10:00:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdZ4p6+V2UoIx+LlPzEPjWFJF7Jhf7UyGXotcA5YXpL3yJbsUknYkVuZni7a/kxWYnNZfsQu8vmGv+uOL2hAgSYQTo+YiHB6YmxlxK59ZMBP0FKk5OSC/RB+6bzhqHUj1CHaFsL+DcXoyOEme/hsj/YmrViyi3WXTciIUtdxqr1fwgvBdd9Vs768zv0Q6AWxbjqOB6EW+L5WMJl1wQE6cXwMR3MdO6fD70GLbWHs+j2FkvJHVMXsHhfQ3wyt683nOSTuf1pW/QKHYWLKt1fG7VgcSquXmpAV5jLCuyMGyScegLsxAvG8SAg1tdSxYY+ko8ChPeQojaG4oggUQrT9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzaHbXKJChGi+KDFeuyH0QPt7acD3Ms7CqZQ0lGXdiA=;
 b=m8XLXY2R4YZYobVMdWrvoZphsy3+HiDRUdSot4iWUi03rVh4kRTm2ezvZVO/Soe/C5ivSd+qY50G1h6JSXCa5eqgMXgiFo9m7kL3smnVVWIISNoFDUmiq6NDi6xUO/tetMl6xlnt8OoZlxPzNlvFioA0FWvhgJMlZq8VQUOPeIPMhDhePeKfqoE3hK97TEimzX28dTr6Q0DEQG/vtKinXFYdr/6jsuC+2Acv1LJLftdZsn0PHYXVUYZM9E78/d6754aC2vth4HEfKE87UR/2JnAjQK+CByKfB4HAXeqR2t3qKg024qjPcGiqZaA+IPmauPeq9uWwpEAPfFRLo9cyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB4066.namprd11.prod.outlook.com (2603:10b6:405:82::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 17:00:09 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 17:00:08 +0000
Message-ID: <87c00fe2-e4fc-b006-f608-3dc2a209ed77@intel.com>
Date:   Thu, 17 Mar 2022 10:00:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 19/21] x86/resctrl: Rename and change the units of
 resctrl_cqm_threshold
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-20-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d2a2ea-2ac7-466e-c14c-08da0837972d
X-MS-TrafficTypeDiagnostic: BN6PR11MB4066:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB40669B7EE51806012E821C86F8129@BN6PR11MB4066.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdVKHf643DWNGUo+4b4jddpqI4ZYh4ntzYQMCQxaKjA91g0Q8R4V1GINFM+Gy7qDwT/1kSzupQ6VadJW03UH8/6/kyNDlRu4XQKAIzMuLHJVPBd+2+qxZjG87/TBoqCk/MEom/xF5TUtqblSxYDSzP/pF7M5yx4OOg3Hwo3WxtGKs5G9wvYMmuvPoECzrZOayHNIxPjvQHIhNd1/iP1fozDqNlrY4siprULakz6+oz6XQD+KvyqkjGPHc4Q/drM7a1AQzXa0A96cRKqO46vWWCmPFjgIZe9nfjhaKv4G4AxhQEmBA04xHqdeGCE7b9rnxdZdRpulY1/D2hKIRBQ3lT6edMX79g+3RV0bhpVK/n0WrirfoSsJTkvGiYugSF3ZM40zrYrCS17UVrr9liv7oHeiZJgAw2CA2wy0y6qEjNPxa+It+MT3VCY+p5UOO1Ep283v0k7XjhkuVmYsuDmXGQxjr/bjphhM7NxBWOUWqsshaoDKl/FsAU79iktKTFNqa0k8h8axGjdLXseKrxQXVv4MZtRbK2ZJcqX0RB471EwiDFrr5dyzgddAuDy9AvTzfjY6Dk4wIe2C5hlr3g7MWVCpc5ivBVZZxmTirjbYzLvr3z2zioqIi1wKdykEonwT7mlNGGFfyhnoMK6EOEeAbPHDZQDvKk+2AWLUUqUGQdycLkEGVLGBI6orp6f0/htrV7JwaeSDwr6BM6jKzmigMmlaR0YH7gkMDs6fvSTjnFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(26005)(8676002)(86362001)(6512007)(31686004)(6506007)(36756003)(31696002)(53546011)(2906002)(8936002)(5660300002)(66946007)(66556008)(66476007)(4326008)(44832011)(6486002)(38100700002)(316002)(54906003)(7416002)(6666004)(82960400001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FxQ1hzeklLZ2ZuR1ovR1p4MWt3eWNlNWtvTXRETk1UZTF5Vi9jRnJaRU5z?=
 =?utf-8?B?blZyM2tJYU5mejYwSGtHQ2FkRUNVaUtmTzdJaWVHR0ZNNjJvR01kV2N4ZE9G?=
 =?utf-8?B?cnFmNU9vZStsZXU4bVAvVDdMMkxlNWpKMnF5WGp3d1dHR0dTbDlPNzNhTzRv?=
 =?utf-8?B?UHVqSUpuUGd2MWNRWWwxdC9haG5TU2o4STQ3MUdGcmdrSWZiTHJOcHM1VENo?=
 =?utf-8?B?VHlZUHl2bC9EOWRQR3N3SVVnNFZQUXNJN2dsZ2RhSVY5MnlvNUhJcytGUHZq?=
 =?utf-8?B?TitOTHZOM0JaZ3o1SW5URERVaGpqQkpkMFR0a25VbzNCMjJKdFNtM2RhUTNU?=
 =?utf-8?B?c2ZNY0E1QVZsUXpocm5Db0U3ay9oY0NkU0d2aWFYS0hzb0dUU0VUS20xQ2Rj?=
 =?utf-8?B?OTVaRW9COW5UM0x0YlhYQVRwRDVEbzlBejgray91THZoN1BkK1d4dGpld3d4?=
 =?utf-8?B?VlQ3eVVOMHE0NUZZeFNKR0JjSUhBUTRhN2xIR0NFZ3dESlJyYS9ON08xVmkv?=
 =?utf-8?B?bEkzdW1UaHBrN3pkaWsybFNKOWsrM0NlTEFJSzlFM2src0RhY0NjK3IwT0g5?=
 =?utf-8?B?QzBuQ3kxYjZoSjc3aFhtM3BycHErYnBkaGR1c2xmTnhsaDhYa2hCUTVqRzhO?=
 =?utf-8?B?OVVmRVEyOHRWOHFHNWpubVRSZmxhM3A3TUozc003NVl5QlREbGhCZDl6K0k5?=
 =?utf-8?B?L2ZZMmNFaVF0STRCSVBoQ0ZYMDdja2NuQTRYbGdKRVRlVjR1d2F0ZjY4SkVO?=
 =?utf-8?B?NVlrdGFJS2YrZ3ozb041Wkptc2xPb0xjd1FTRUNBUjdWcE56ZFRxaXhzL0tT?=
 =?utf-8?B?b1crbER4UmVjaVh1bVZyWGtuMzNzdVdlRk9pOWN5Vm4vQ3l6OUxROThFdUht?=
 =?utf-8?B?VXVQUDZFa2VVeGRvcWgzTjl3TVRsb0ZYN2kvTjRFTVlBYkpkaVZTVnVaT1Zn?=
 =?utf-8?B?bUdHS3dxMGZtd1U5K0FYUy9HVERqTlIrM1U3YWNaamtMUGVNOFRlNHV0cjVh?=
 =?utf-8?B?c015L2g5ektSK0FiSlN4ZnlnMVQ1Q2dqVDRoOWFDOVdlZ3Z3V1RoVEdMOEJY?=
 =?utf-8?B?cHFVWEN5RFlJSXByL3dOdWJhczZscDNRUG9rUU13RERXNElqNlROK2ZGNFZr?=
 =?utf-8?B?cnJnQzBPbm9jdHgxQlNPNzdUbGlYUXdSRGw3QnROZ1FyWEZPdHJMYWNzL0JK?=
 =?utf-8?B?czhrS0dHbGNSOEU2eFRJUnB1Y3VYWTNJa0ZCT0lnNnU5QmZOK3h3ejhuRnhJ?=
 =?utf-8?B?ZFVvVTZBTEY4dWxNUUNVV1NlNFJwWm5YUURHQVc0bG5uWTlMdnoyNTEyYTFS?=
 =?utf-8?B?S1pmZVQraGJlQTJHMnZXcHFnVDNDR1ovN1pyTFhGSCtKTkJ5Mk9ic3k0bHBM?=
 =?utf-8?B?MVBqeGxpY2RsN2s3S1gzMnp1clI0VXBUNytBTk5BZTltdVVyWStXemNUbTB2?=
 =?utf-8?B?TU1SZEdtV3ZBcURRd2psbGc2VXlrV0NWdURvWlhYOEZXK3lGRzdXdk42ZlhF?=
 =?utf-8?B?ZFVtdlhYOWVmNXdpdE5HWCtMY0RxL2FJRzJNZlBUeDlQR3Bqa1hNMllya3lU?=
 =?utf-8?B?VTFaUlR6cnJpZWQ5SzJnemowOVZEQkV0WVdNbUorT3B4eHpoNTM5cUJtUUxD?=
 =?utf-8?B?NHlSU3pHL3NKeGpsL3NkZytMNzlFK3doYndVOElPaThXSWgxY25HTnBBalNz?=
 =?utf-8?B?ak1vamhLeTRwZ2VDWmpNTGJRMzllN0NKU1dBc2FoTVVhZHpOV21ZVmNvQTli?=
 =?utf-8?B?MnJjRU4zR2NkRlFNV2FkNHFBQmdtU0VhTUYrSERYVHhrMm1vekRVSVBXN0FH?=
 =?utf-8?B?Tk01dkZMaXFKZWhhSzJKQnFtQTlDOFpFaEczRFpZVFU1UTlnWFhlbEsyUzJ4?=
 =?utf-8?B?UXFNYU5uQm91VEtRaXpQLzFBQlFiYXhXU2RSV2V3SFEvZkhqRzgwaWI0T3ls?=
 =?utf-8?B?U2hFSkxNdnVaZHhKOFMwaGV5NVJGOGNzYnY0NjRZR1dxbXFZb0p2emRjWU94?=
 =?utf-8?B?REl2d3FzTVJBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d2a2ea-2ac7-466e-c14c-08da0837972d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 17:00:08.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQzqjNp8gBppjE6D1nmbAwcEOIfr9MylWPhevQgyy9dGVjGVwaGXd/6BKcLF8ZTBI+4yCjRilOOfW7jvl0OO7FqidCFq1hyJc4wtglh69k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/17/2022 10:21 AM, James Morse wrote:
> resctrl_cqm_threshold is stored in a hardware specific chunk size,
> but exposed to user-space as bytes.
> 
> This means the filesystem parts of resctrl need to know how the hardware
> counts, to convert the user provided byte value to chunks. The interface
> between the architecture's resctrl code and the filesystem ought to
> treat everything as bytes.
> 
> Change the unit of resctrl_cqm_threshold to bytes. resctrl_arch_rmid_read()
> still returns its value in chunks, so this needs converting to bytes.
> As all the callers have been touched, rename the variable to
> resctrl_rmid_realloc_threshold, which describes what the value is for.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

...

  
> @@ -762,10 +763,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  	 *
>  	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
>  	 */
> -	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
> -
> -	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
> -	resctrl_cqm_threshold /= hw_res->mon_scale;
> +	resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
>  
>  	ret = dom_data_init(r);
>  	if (ret)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7ec089d72ab7..93b3697027df 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1030,10 +1030,7 @@ static int rdt_delay_linear_show(struct kernfs_open_file *of,
>  static int max_threshold_occ_show(struct kernfs_open_file *of,
>  				  struct seq_file *seq, void *v)
>  {
> -	struct rdt_resource *r = of->kn->parent->priv;
> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> -
> -	seq_printf(seq, "%u\n", resctrl_cqm_threshold * hw_res->mon_scale);
> +	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
>  
>  	return 0;
>  }


This change has some user visible impact that I am still digesting but thought
that I would share for your consideration.

As seen in the above two snippets, the original code did:

resctrl_cqm_threshold /= hw_res->mon_scale; /* resctrl_cqm_threshold used internally */

resctrl_cqm_threshold * hw_res->mon_scale; /* this is displayed to user */

The original loss due to truncation during the division is not recovered
when the value is displayed to the user the user may see significant differences
before and after this patch.

I tried this out on a system with a large cache and the before and after 
information is significant:
Before this patch:
info/L3_MON/max_threshold_occupancy:147456

After this patch:
info/L3_MON/max_threshold_occupancy:196608

As I understand this change indeed represents the information more accurately but
I found it noteworthy that this is not just a simple "change the units" and
may thus have broader impact and may indeed result in different behavior that
should be considered.

Reinette

