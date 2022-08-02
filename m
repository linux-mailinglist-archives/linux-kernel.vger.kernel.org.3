Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6998587FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiHBQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiHBQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:03:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858A23D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659456190; x=1690992190;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FSPCEqsYveaMrsftrcsj04lHGY4OgT3j1VGIoAe75gE=;
  b=THDJHnYAwj6XDn2B3oXKY36D55eOtO4Mw1+OJCPbcuavJzURuCHmw/lQ
   kHzWY6kZIgJYSnluJvCQQ4Gjhtsa95d1Z5qwTIndehyoJzrqStUxwtVCw
   PbfNWLPkY7A66o0lOm7pR3Sgvxaa9t+txFwtPfmI6h7xfVo4iwAowFN1y
   eGg5yW9bBD+zy56sUVRQkglrQ7SPbUuS+/c+kBq4Z7e/zxv5rVJBuXFMm
   ZFtf3gu0nIrmneDhOVJ+how1IB/+FkmymdQaHrWcPiinZsiSwodaKhEhH
   ambvu64nLYmjNBCBIU1hvpjLLuRhT+WlGWIF9e1yLZcFTxw/VBZYg2WgK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290664936"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="290664936"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 09:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="728879670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2022 09:03:09 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 09:03:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 09:03:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 09:03:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoOUgxynlFNiKEubokJrIuAsi8kFwsFKuBkWPxA7/njBmwg2zd1k3flx+ou7HQueQP7glhU5LFmOD+tw1SnndZgP/hI3ygZgvMj/0ScpifHkUAt9YDCuVPqFkNiQhFKurReVGclpm8Jig1T1ctLAJJdQWmbWb2Sv+ahCGggnpz3/YwN39uMhBB8rpZymmUImBy94xevxq4wG9OCZUXRiMd651mWvs1b82tWllgROxfboSYPBZwqb/oHHgIGUnt6IwtEByjCPSQTImLE6sRTVCueihQ2pzx6K8qa9xi+BTu4OQddWscNcDWcvkwCDV1ce/e5Hvu32I2/o2DTZqAOuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqjYYWWq3gOYs5VyQcyfnNaw9K6Ttvlj5+fR0/jjcfU=;
 b=XSPwQmQwtBllfqsU4ixaNTd/TFZy/ctnnD7mvDjZtPcXsFw3k9SZdLQKyFBfTROfHDibmlX/Qq6yU63HGFfe+DtzCZU7e+rW1gMXufHSlLKZmpegQHExgJARpfoD68kf1Rrtn8Ru1TaCwE3QU+4ItloX2nTjlsy4eVWBlVFcTQr+yBpN2ca66ErcFCJ3SUyxQ/WRl1mkrcaQWuzd1KQlr4yNT8I9alw8/HHy3kHBMn8WVpsTvCkiHWS2Q8TtzfAgNPUT+JDGKTTft9kFXrMdaIqpzSHstbI+mMw60IjeF/qJTrIcAp7iKR16QIWCZhCBEd1DHCQW7mbfoPEZAY54Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 16:02:41 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%9]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 16:02:41 +0000
Date:   Tue, 2 Aug 2022 12:02:37 -0400
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <peterz@infradead.org>, <mingo@kernel.org>, <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <eranian@google.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <tilak.tangudu@intel.com>
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
Message-ID: <20220802160237.uqgez4f3ctm7rpyc@ldmartin-desk2>
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
 <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
 <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
 <8c122462-afa5-bdf2-8bfb-910ff59ada03@linux.intel.com>
 <20220723185617.vz3swht66lbtuwzl@ldmartin-desk2>
 <bec1bc73-b3bc-50da-8aa7-0aab2328d62f@linux.intel.com>
 <20220802142213.d2f6qzwl2w3sfm5g@ldmartin-desk2.lan>
 <b0bd2b88-2ac8-42f2-22dd-587a21a7e9dd@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0bd2b88-2ac8-42f2-22dd-587a21a7e9dd@linux.intel.com>
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 422a015e-74fb-4abe-9e55-08da74a06d82
X-MS-TrafficTypeDiagnostic: CY5PR11MB6137:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+xkq9Do/F2QFUDIwS5QV75y7yL+keQKHL3mslhgKS4EQsWLTjcdQ0nCvLyUkTHbyscYLXNUp58s4Q4pRtPhhZW/QxQmwJqWRX2OkcSYMu6ERXzTl91GYrFa3UaRMxMf1IgsNEnTbHS4sDirbK1VOCMmgXYciwrgLVKZbvJiRjGN0MVNdTCkYTNhDubWr7HIc3afYxqlGmv9/10WgkZGo5iN6+hbe/RSzEPDO5K0drkGFO796nvWM3FPmDu5+DUSBbaieBAJ9GMuu/OOmPIHVyWR8yqTJD+YQkYKNP0KST3rNzS/f4UXPhuNsTGMqWuU3RHqRn9XRlHhtrZQxYPYvaknOfja6pflgrGnXlzuuhJwKswxa+wG8A7WSVnwJQ1zNo+XYFUK8HPq+66RwW5VOAulVWLbXopN4VT6ethnPk4hkqpXrVTqAbxJIbWF9Yz5gUF8apdUPCg2rhesiV+SLh9Z3J5wSzs4cGARZQIK+m0sVfh2mI6xZ0+ICwzMLBmXse9XB2JQ2+RHykHHAXXFhoegWUOXlWSwWSoNZdF2smycCzuP0lfqYjlkrRRV1ubnFmhZnbg0hHjWvmL9oAtWToPc2pH43Ap0km+B3rvG+SZJoYhYFoA2eTPzV9+A2DNnNC1R9bFF13+a8JpZtqz6qHpmcYwt/o1b0q/BtKj+jDoH1C0npvQ1Ft61c55qVi0W3qg4rBlJBNxpaUbxPcyHa0GvQj9Ucd0nzkoIHb+tFZ8bpgHQTh+t72RzRcpmxjJVV2C6X13bgOu8JuOH5DdEpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(136003)(39860400002)(376002)(1076003)(186003)(86362001)(83380400001)(8936002)(5660300002)(4326008)(7416002)(66946007)(66476007)(8676002)(66556008)(2906002)(33716001)(478600001)(966005)(41300700001)(38100700002)(6666004)(6486002)(26005)(316002)(6506007)(6512007)(9686003)(53546011)(6916009)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hHO22GYXwxkyEMaAzT8C3vAybdyvHyovjJBN2vSmlUWGp0O5XxifDRf9Y0?=
 =?iso-8859-1?Q?A0+6BNXKR8WiRcThrhuRQg3WRBZCDJ13kNxcfDkTzyrM9Jn49kWLk7P4rJ?=
 =?iso-8859-1?Q?DrJeCCec/nbXwC2BakTid9xz93Fdtc0ZKwyDIfzqxXPyEC+hT/t0oWFBJy?=
 =?iso-8859-1?Q?giasbAbXbGgWdbjiVgt27NnKkp6hsp9lUuwdqMarVD1p4txPVw/v61N36L?=
 =?iso-8859-1?Q?/AwrptLTD1ZmzLeLYe2m1ymkfiELXYtat2XjEG7NZkAUxA80HgGWdWnbQ/?=
 =?iso-8859-1?Q?wVnxNY2ZpWQSP9XsXBuF7LSRtyq36giJYMSSmTTe9SKwnAcF2xgZLin8eZ?=
 =?iso-8859-1?Q?byN1IcpbekR/zbtTNRvAez8HTiq8y1Ep9z2QudSUoTL9XywMOd2VGFR5TT?=
 =?iso-8859-1?Q?QneSWsiy+o6OsGNsoZj5pxEpJ3YPTUVwXBPByRJjk48Lsys9dnp36zYr/+?=
 =?iso-8859-1?Q?zzIeYD0NhSSX5dRaNIBh7zwYOoZvV7PmmLMhEaBhO9FHeD54OxSyIko/1d?=
 =?iso-8859-1?Q?sLqTlrqmNDTm4U/CFIfX2EC+Xokrqar0/QXJGmrRpix7LJq8kCWxMQcPxs?=
 =?iso-8859-1?Q?EY9TWs6Mv/rkZsUCkA7VKmvs2uWff5MPMhfNlZsrwRE0UVknHAubqwPNcz?=
 =?iso-8859-1?Q?0oyouBR7qw2dvJQ+/mcLIJq54SFTIMO3ETt0cXMETKfPcFVaFlr6dF36Ga?=
 =?iso-8859-1?Q?PRCZS0JKbV+Cc+LBSHxf6nXu5KwfuZJxOqlkSNOx0gDs0TldhZNRLy3Hqi?=
 =?iso-8859-1?Q?YabCjD+tQHt975X4zQKUa+b5AAkn/j4teJTVkP9nRZa5Y5ALiYXs0INnCt?=
 =?iso-8859-1?Q?e1O2+4g8aPfXpg89Im4rKwI8j1/BJVnZ2x794wUAHn5eUBA5hFYG0aGCv+?=
 =?iso-8859-1?Q?XyOqx9lMznrTV5Ocl1VYUS9toslaed9eJTbs3WFpztAfbVcrQwdrrcfjxk?=
 =?iso-8859-1?Q?cAk7QV1xiIY/pXB+9a0vFH3y4UoHQpIRqpGUPNW/517WE9ljYZP1uLiQ6P?=
 =?iso-8859-1?Q?Hhz9Kz6gSBmu6BifWiZhJXK89+M8l/b0pfNYIO/caDmNN1fL8B1Htejcbw?=
 =?iso-8859-1?Q?v234obUGoqrFlKZ7TInU8pByQR5z08SQSA5LEeBB6DdVNtlQqmO8K83tPf?=
 =?iso-8859-1?Q?tgBqz5qV21mlHrrYso4Z46DKXAkPyrU9fmh59r5IcW+QpAVi7yuClLZ5PA?=
 =?iso-8859-1?Q?YpqTO6iF9gcFAlz57vfCLslrV3X/v6kcZTGESfBLixi0JUJAxp3gjrtc5n?=
 =?iso-8859-1?Q?yyAauMuTSBAC77peDdvA1t7qEdyFmsHwXZS+K+eOP+WunSWWAlgMAKjtQt?=
 =?iso-8859-1?Q?x913UspFBthzYFKbBYKl1P9ZKy2b2kpg79sCT2qCpmTI2sNx52yY9asN+G?=
 =?iso-8859-1?Q?2ulrJ3ucwdxW5Fit0NYq2bkIpFiVT/aijJ6UyYnDCEmeNVT1PRiakDtw/C?=
 =?iso-8859-1?Q?84iw2lzgOlMJAZ3IFdfo+TV0MwnGgJaHr2UIQDYDdnSRCWnNVfWb1JXYio?=
 =?iso-8859-1?Q?EO3aS/vQVLar5lZ+Py4+++R1YV7C/83eQoukfUaqKDfTYAb/LayeWwgldT?=
 =?iso-8859-1?Q?WS4D3jwtrWstlHvlbkhl0XMl/WD6yIKFQid/24rQzJBSodDUfYLYbs0cLq?=
 =?iso-8859-1?Q?0o2SJ/9hy2UTaSAvKp6i6Ry0msi7zeDYcODnCQM67hC/2i1ZfEGuRzBw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 422a015e-74fb-4abe-9e55-08da74a06d82
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 16:02:40.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDpVTpjB6QyUaUhmD91NQ3ZIup29RWvKULxb9gPx4Wqyu0BAyBBwHZLcXj1XVWxExGnSDLEjy4THEx+JIl7tnJMSJ8uJWEp6HRpHp20IjVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:43:36AM -0400, Liang, Kan wrote:
>
>
>On 2022-08-02 10:22 a.m., Lucas De Marchi wrote:
>> On Mon, Jul 25, 2022 at 10:51:44AM -0400, Liang, Kan wrote:
>>>
>>>
>>> On 2022-07-23 2:56 p.m., Lucas De Marchi wrote:
>>>> On Fri, Jul 22, 2022 at 09:04:43AM -0400, Liang, Kan wrote:
>>>>>
>>>>>
>>>>> On 2022-07-22 8:55 a.m., Lucas De Marchi wrote:
>>>>>> Hi Kan,
>>>>>>
>>>>>> On Wed, Mar 17, 2021 at 10:59:33AM -0700, kan.liang@linux.intel.com
>>>>>> wrote:
>>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>>
>>>>>>> A self-describing mechanism for the uncore PerfMon hardware has been
>>>>>>> introduced with the latest Intel platforms. By reading through an
>>>>>>> MMIO
>>>>>>> page worth of information, perf can 'discover' all the standard
>>>>>>> uncore
>>>>>>> PerfMon registers in a machine.
>>>>>>>
>>>>>>> The discovery mechanism relies on BIOS's support. With a proper BIOS,
>>>>>>> a PCI device with the unique capability ID 0x23 can be found on each
>>>>>>> die. Perf can retrieve the information of all available uncore
>>>>>>> PerfMons
>>>>>>> from the device via MMIO. The information is composed of one global
>>>>>>> discovery table and several unit discovery tables.
>>>>>>> - The global discovery table includes global uncore information of
>>>>>>> the
>>>>>>>  die, e.g., the address of the global control register, the offset of
>>>>>>>  the global status register, the number of uncore units, the
>>>>>>> offset of
>>>>>>>  unit discovery tables, etc.
>>>>>>> - The unit discovery table includes generic uncore unit information,
>>>>>>>  e.g., the access type, the counter width, the address of counters,
>>>>>>>  the address of the counter control, the unit ID, the unit type, etc.
>>>>>>>  The unit is also called "box" in the code.
>>>>>>> Perf can provide basic uncore support based on this information
>>>>>>> with the following patches.
>>>>>>>
>>>>>>> To locate the PCI device with the discovery tables, check the generic
>>>>>>> PCI ID first. If it doesn't match, go through the entire PCI device
>>>>>>> tree
>>>>>>> and locate the device with the unique capability ID.
>>>>>>>
>>>>>>> The uncore information is similar among dies. To save parsing time
>>>>>>> and
>>>>>>> space, only completely parse and store the discovery tables on the
>>>>>>> first
>>>>>>> die and the first box of each die. The parsed information is
>>>>>>> stored in
>>>>>>> an
>>>>>>> RB tree structure, intel_uncore_discovery_type. The size of the
>>>>>>> stored
>>>>>>> discovery tables varies among platforms. It's around 4KB for a
>>>>>>> Sapphire
>>>>>>> Rapids server.
>>>>>>>
>>>>>>> If a BIOS doesn't support the 'discovery' mechanism, the uncore
>>>>>>> driver
>>>>>>> will exit with -ENODEV. There is nothing changed.
>>>>>>>
>>>>>>> Add a module parameter to disable the discovery feature. If a BIOS
>>>>>>> gets
>>>>>>> the discovery tables wrong, users can have an option to disable the
>>>>>>> feature. For the current patchset, the uncore driver will exit with
>>>>>>> -ENODEV. In the future, it may fall back to the hardcode uncore
>>>>>>> driver
>>>>>>> on a known platform.
>>>>>>>
>>>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>>
>>>>>> I observed one issue when upgrading a kernel from 5.10 to 5.15 and
>>>>>> after
>>>>>> bisecting it arrived to this commit. I also verified the same issue is
>>>>>> present in 5.19-rc7 and that the issue is gone when booting with
>>>>>> intel_uncore.uncore_no_discover.
>>>>>>
>>>>>> Test system is a SPR host with a PVC gpu. Issue is that PVC is not
>>>>>> reaching pkg c6 state, even if we put it in rc6 state. It seems the
>>>>>> pcie
>>>>>> link is not idling, preventing it to go to pkg c6.
>>>>>>
>>>>>> PMON discovery in bios is set to "auto".
>>>>>>
>>>>>> We do see the following on dmesg while going through this code path:
>>>>>>
>>>>>>     intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff
>>>>>> 0xffffffffffffffff 0xffffffffffffffff
>>>>>
>>>>> On SPR, the uncore driver relies on the discovery table provided by the
>>>>> BIOS/firmware. It looks like your BIOS/firmware is out of date. Could
>>>>> you please update to the latest BIOS/firmware and have a try?
>>>>
>>>> hum, the BIOS is up to date. It seems PVC itself has a 0x09a7 device
>>>> and it remains in D3, so the 0xffffffffffffffff we se below is
>>>> just the auto completion. No wonder the values don't match what we are
>>>> expecting here.
>>>>
>>>> Is it expected the device to be in D0? Or should we do anything here to
>>>> move it to D0 before doing these reads?
>>>>
>>>
>>> It's OK to have a 0x09a7 device. But the device should not claim to
>>> support the PMON Discovery if it doesn't comply the PMON discovery
>>> mechanism.
>>>
>>> See 1.10.1 Guidance on Finding PMON Discovery and Reading it in SPR
>>> uncore document. https://cdrdv2.intel.com/v1/dl/getContent/642245
>>> It demonstrates how the uncore driver find the device with the PMON
>>> discovery mechanism.
>>
>> ok, this is exactly the code in the kernel.
>>
>>>
>>> Simply speaking, the uncore driver looks for a DVSEC
>>> structure with an unique capability ID 0x23. Then it checks whether the
>>> PMON discovery entry (0x1) is supported. If both are detected, it means
>>> that the device comply the PMON discovery mechanism. The uncore driver
>>> will be enabled to parse the discovery table.
>>>
>>> AFAIK, the PVC gpu doesn't support the PMON discovery mechanism. I guess
>>> the firmwire of the PVC gpu mistakenly set the PMON discovery entry
>>> (0x1). You may want to check the extended capabilities (DVSEC) in the
>>> PCIe configuration space of the PVC gpu device.
>>
>> However here it seems we have 2 issues being mixed:
>>
>> 1) PVC with that capability when it shouldn't
>
>This is a firmware/HW issue. If PVC doesn't support the PMON discovery
>mechanism, the PVC and its attached OOBMSM device should not enumerate
>the discovery mechanism. However, the PVC enumerates the discovery
>mechanism here, which doesn't comply the spec.
>
>The uncore driver prints errors when the in-compliance is detected.
>That's expected. There is noting more SW can do here.
>
>The firmware issue must be fixed.

yes, that's what I said. It's exposing the capability when it shouldn't.
That's being worked on from the firmware side already.

>
>> 2) Trying to read the MMIOs when device is possibly in D3 state:
>
>The uncore driver skips the device which doesn't support the discovery
>mechanism.
>If 1) is fixed, the uncore driver will not touch the MMIO space of a PVC
>device. The power issue should be gone.
>
>I've already sent you a patch to ignore the PVC added OOBMSM device, you
>can double check with the patch.

(2) is a more generic issue that I'm mentioning. Forget for a moment we
are talking about PVC - that will be fixed by (1). We are trying to read
the mmio from a device that can be in D3, either because it started in
D3 or because a driver, loaded before intel_uncore, moved it to that
state. That won't work even if the device supports the discovery
mechanism.

Lucas De Marchi

>
>Thanks,
>Kan
>
>>
>>     /* Map whole discovery table */
>>     addr = pci_dword & ~(PAGE_SIZE - 1);
>>     io_addr = ioremap(addr, UNCORE_DISCOVERY_MAP_SIZE);
>>
>>     /* Read Global Discovery table */
>>     memcpy_fromio(&global, io_addr, sizeof(struct
>> uncore_global_discovery));
>>
>> Unless it's guaranteed that at this point the device must be in D0
>> state, this doesn't look right.  When we are binding a driver to a PCI
>> device, pci core will move it to D0 for us:
>>
>>     static long local_pci_probe(void *_ddi)
>>     {
>>         ...
>>         /*
>>          * Unbound PCI devices are always put in D0, regardless of
>>          * runtime PM status.  During probe, the device is set to
>>          * active and the usage count is incremented.  If the driver
>>          * supports runtime PM, it should call pm_runtime_put_noidle(),
>>          * or any other runtime PM helper function decrementing the usage
>>          * count, in its probe routine and pm_runtime_get_noresume() in
>>          * its remove routine.
>>          */
>>          pm_runtime_get_sync(dev);
>>          ...
>>
>> But here we are traversing the entire PCI device tree by ourselves.
>> Considering intel_uncore is a module that can be loaded at any time
>> (even after the driver supporting PVC, which already called
>> pm_runtime_put_noidle(), it looks like we are missing the pm integration
>> here.
>>
>> On a quick hack, just forcing the device into D0 before doing the MMIO,
>> the PM issue is gone (but we still hit the problem of PVC having the cap
>> when it shouldn't)
>>
>> thanks
>> Lucas De Marchi
>>
>>>
>>> Thanks,
>>> Kan
