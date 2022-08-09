Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF858E21E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiHIVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiHIVt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:49:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457556BD53
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660081768; x=1691617768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vzijAVA+v2jeURW3xNi0Tkwc6EjP3mgFYqfSqSkE/qM=;
  b=W/+78DZjLCgCFawjk1AWO/HlrAMVQXT9/J4q1ACk5CW69nhBKRTDfDHd
   b7dUloOUxPGNtCKu4KZPtQIsXnCxfaCWy6+oC65uPBmJRkfkug2rcvuKM
   lKZhqqJGc8MXtZK2pNSgzMf5lYo+76eu0Jjmt/yB0YtUcrLQH3B8pk8Ov
   D9G3PdyHIM+UAEgiOWO7X7mLEBaWO1Z3CXrfWIKfyvusR+JMXx0IBD7C+
   N0t3Ru1DdOTRXfTvJLzjRF6r85inM6NZk906tuu36rV1k3hMl4OvpDvux
   rJGAM8YF4X6wuvO6A3Sa7BLhh1KyGMVgXm2jaliGVdemMfYja53btsgWB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="277879456"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="277879456"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 14:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="633500490"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2022 14:49:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:49:27 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:49:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:49:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 14:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm0IlDCOnf+xlP63ci+v/099R5CeOcUhWzxOKLt1d2sVqNY8m5U4lMT1CJp2F/41U45GiYRaRErykuKyw8xM4yGnaYTWN6BvGZh753c9XscIGAAdincUYJ2tzJdMXlb7AK8mz7M9zKBHYELKtUPNWONBwjJgodz7Aoo4W7K16ZFNpbgpUUa507ZHtAGS/m+xnLNOxakhU9uI9OBoSQZ3bjtc3S3aA9YP3NOwEu5pNizZrMNe+FC04pQIzJL5wrsvJg3B4seOlfRdVQkWGq80IFmdYUUOSsUAMtGskvw3wxJrBVrJ9hn5zknSpG50hi19wC/acGcFTO08GZSy2WDJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhOOSciL8NA8yuKtRVZsWgIfAcWJa9LhgraFyHET8BA=;
 b=GQw/Ck4z682vXElq1Br+fS9qMv7WrdBNT9a62rBE3ItYXEOvlfGpKPEDwHmK5CHQVjJvv2YxQPHt/kKaHhHacfxmR5DpoYY7/NjkJEfPW+Q/8WQPv2+kWEV+x+m50YzQFPcBGL+1VLWQvy9JVsR7eJqEUD9d8reOG3a42ptIKoRaRukvVmP+qB51+kvMJAtEJ8tveFydMmMkPdzqahsBdURlRGimZoxHo5zbwWYlkT3GFAorlFsHvF5iumi220xRwb0TNb0BXzcs6wWKc4wO98SHFstnUX3lt42ZZpgzr0nkL/uziAPKV/9/5SxPqRb1wkjI3IXaVo0IYRipd+ALHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MWHPR11MB1342.namprd11.prod.outlook.com (2603:10b6:300:1e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Tue, 9 Aug 2022 21:49:24 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.019; Tue, 9 Aug 2022
 21:49:24 +0000
Date:   Tue, 9 Aug 2022 14:49:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
Message-ID: <YvLWX4NiqReB5CHB@iweiny-desk3>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com>
 <YvJNe2rzXfcogFFX@zn.tnic>
 <YvKpi/CVHko50PNQ@iweiny-desk3>
 <YvKsS3QuOu4JVzZU@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvKsS3QuOu4JVzZU@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0c14499-a713-417d-37fe-08da7a510608
X-MS-TrafficTypeDiagnostic: MWHPR11MB1342:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31t6LZsJiE3PkfkrWff6cfv5xeuYq3r58t7AIlAShdAgU+/cOHodybTi3pJdyrx8gRdoepYy2AS9Q9gS9OCBm5nCFsSmVlOu+RpFqfjvS0WOCYpwB8vsGIz3O2XD+H/BmLAAy9/GnAtEJoVKJfGP3Kaoi4pQiiN581I9T4/6smQ+y+dh3jjbFTp4WdKa6C7UfA/pmPRyYWp1rspPu0Zveyxs841MUu27NzlShVxybcK1ioMvfB3IrEv1aYALZHY5kmBEq+/XnulWgt1duHWHECUmbSGglejU5YV+XBfpdKMOSMUEbtk0TwYctr6wVIn8cqTRP9nF1ms0WjarMzgyrMd7mdDj3OL6KlCOkIlOjZe13X75V4nu/YDgpV1S+VFXv/BKNvmK6cZLzRtsq6MjZQ41d9djouXcX/fjSgaD6WPQukSSme7GiwejXMu5vzyS+hAHxMNA0ZBeohDLNbe5D1ZD0wmZcx7ZI8cYYFpZEGUkeNSPlNtKOxIpIUoUBeZ/Lggv37eg8KhIrdFbnr4kGMt7UPHps7egKrwO4QvKwVPmiYmkw6jKMslDpPJu+YArN/+G43qCp40rJXk21CYds6KvNcV4NPcv6vjwFPlw9VVMxHLi49WR9XXg9249LcAcFqdwerKFLDSWPFIZOF7b56Ws0zeaz53kL953ShFTO8mQ+DlRbDhyTcT5wbAyUk54uz0IOrxQURk+zYFT+nLdiW5K5v8FwGZJhNXGrftD3jvjkkMDVUHEvsTkYFHdy1twa3D1mk7qKa9bT2Txf9FvFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(41300700001)(38100700002)(26005)(9686003)(6512007)(6666004)(6506007)(86362001)(82960400001)(6486002)(5660300002)(83380400001)(186003)(8936002)(33716001)(4326008)(66556008)(44832011)(2906002)(66476007)(66946007)(8676002)(54906003)(6916009)(316002)(478600001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4bfD42d9948GB4bw15fc6Fq9QIgFCQ1Mv729YvBVxCsDdhyxM1EFCva18Ykg?=
 =?us-ascii?Q?uJFLvVxaPq/dSRBg1ehk4CU9hM6UlRBAEqFiOlQMQI8YfX0i2QlUTY0P8woa?=
 =?us-ascii?Q?/wADEjaX05Z2uY+BIhX7SauYZNILKsiEPy2vXrvWMdo3k23AAGqOLqYCu9t3?=
 =?us-ascii?Q?NiJ51a6z272DIoOxyUOcncMICcT4pzP14cCzj8/tRZhZpaVfUA6UI7ERjSW0?=
 =?us-ascii?Q?9CpTV/4frwzlBgtqP3Kg4NZwj6t4Q6IyqSzmRO6tE451ZVvGXME3Jg8MQbky?=
 =?us-ascii?Q?mdKQ4kg5vGJauBR+gJzHTgfsALKd7iN7eWy59YhlCE3wkMBohRvp3oozJAXX?=
 =?us-ascii?Q?UIv6QGcfwdsNnbXDEmpENaxEHJ5axr+YTg1IVgKZN3sdBFu1fZxLzZsyZuKi?=
 =?us-ascii?Q?KooF31e5lp2i5ir9Wg/W5ERJZgsfkJGJlnpNDRl3AdBFOB39WTG7oWNOqe3w?=
 =?us-ascii?Q?ThF/61utQRovZG3YfByiqNzTZnuJ4627mPV1JOY39oqII7VkIg9N9QAX5K+3?=
 =?us-ascii?Q?blmJ4iFXyq+ZRtjbXemphMLgv930EJy462oMIBe/C3kj5dRv0k03cp76O0GF?=
 =?us-ascii?Q?5BaeVB70SZJYqBml3RO9Vr+nhkS6ysPSUr+NuyLyn5BDjYIDYFf51+PdN7Am?=
 =?us-ascii?Q?dVzxOoRKjLe0MdShjfJIPV73a+UAQBD1J3WX0VHwvw+2NeoFGCwROMFhEzKF?=
 =?us-ascii?Q?V8F7VTU4cZbCXvwrH/HgAoV3Ku2m/s/sg6NRqCsDx9QZMbMdVPpv7vMlPcs/?=
 =?us-ascii?Q?e5/PQS6JKnskNPrfkt+CxXcIQVljBQg8MoBMr5iVKauKpau6TNWc1FMBhBSc?=
 =?us-ascii?Q?fEc9J1QuR+Yu6FSG9hA3Pzswia39fsJjkccO8EH/uifYcEsmIbE1ObKYXGBd?=
 =?us-ascii?Q?Bk9g6J5pwsQyfuJ9ymJ+wjwFNMvwqxI4H+Fa6faB0tKV6C7vHGBP/CKjUV3o?=
 =?us-ascii?Q?2QNU2/zODLlSHqpJSQClSVgkqZ05UVZjdQqVnPiBXw40ivLSkTbx7AKq64Hs?=
 =?us-ascii?Q?KnE1PzkgJbJDMIgUE/n5jhMoRecEW85EvmhKcnqXB6gBQm5TT77FUWLoXyG6?=
 =?us-ascii?Q?ITxdtei8pPIP8ZKorinxaIZ3TN/aNvunCnvaahOT+7xk1L7sZtLPLR4ayVrT?=
 =?us-ascii?Q?ILk/+aboanJNltGE+D5RRlai2wvPVYIUjQ7lt7IRNJ3bgAY0xZC9iXo0PTAW?=
 =?us-ascii?Q?W/qbGGlTSht4mHRe0c+bXiEyDzaFHeeouoyB081F4uQNpWilAykVucWyhG0U?=
 =?us-ascii?Q?x04EbQMQt1A6x7Y6bGvnQLA1tATkmm1kARtVCEHpPszsFbL3o8Q+VIfcFp4E?=
 =?us-ascii?Q?yBkSC4RuI8JvH3lTSIUnszidENY9QpHGw8vg1Ka8gu+eFy8v0y7GSwIOM0w7?=
 =?us-ascii?Q?9wVI/pmr9UhGLNQV8IsNx7UJFnTVxkGJ33b82nd7ujTbkGezQ71TzzRo5HrM?=
 =?us-ascii?Q?QbF5HmjNxHUJYwOHAFjqs60w5vJG8LxEp41TH0NrFVw/EIYbzaHdkUKeSBqE?=
 =?us-ascii?Q?MWOMhU/nUTccPZyGPSXRONwT6hmoNpknCizxLkX+WTFzT1fh9JBv9z/793t7?=
 =?us-ascii?Q?cvg3NADpZ7QugH2r49nOgsdiJ2DTHPqDpPk51Ql/o4+QpdmXDhLJ2WWcGSlE?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c14499-a713-417d-37fe-08da7a510608
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 21:49:24.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZuw7t7adlMXtncw4dV/wQLPbexbfZo8IYzbQ4p3wl/4FQfOqsgXJ4v/qC3oalAtAmsqORDP1WD7a1BLsFD0sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1342
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:49:47PM +0200, Borislav Petkov wrote:
> On Tue, Aug 09, 2022 at 11:38:03AM -0700, Ira Weiny wrote:
> > Thomas did a lot of work to make the entry code generic. So I was
> > keeping that work consistent. This also helps to ensure I did not miss
> > any places.
> 
> How about you worry about the other arches when you actually cross that
> bridge?

I guess I miss understood the reasoning behind Thomas' work.  No one mentioned
trying to isolate this to x86 during the PKS review.

> 
> > I don't believe this is correct because instrumentation is not enabled
> > here.
> 
> Why do you have to run
> 
> 	arch_save_aux_pt_regs()
> 
> with instrumentation enabled?

Sorry, that was carried over from the PKS series where I did need to call it.

I pulled this series over quickly to show basically what needed to be done.
But I did not review it for this detail.

> 
> Patch 5 does
> 
> +       struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
> +
> +       aux_pt_regs->cpu = raw_smp_processor_id();
> 
> only?
> 
> Why does that need to run with instrumentation enabled?

This does not.

Am I wrong that instrumentation begin/end are 0 overhead in production builds?

Ira

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
