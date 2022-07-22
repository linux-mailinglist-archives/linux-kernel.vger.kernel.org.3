Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA4457E1B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiGVM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiGVM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B228F57E07
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658494564; x=1690030564;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F9ysdQFs5g2C18DSjn5rMqQYps+8B0BioYnYp9YXai4=;
  b=mkRsXvEV+HE2g1b38T6O1n1HNsLh+82aLWONMhsSHPMR1MhL2J3ocGmk
   zjIYx5wY7uPeTvCik3tPGeNZm2xErJO2qPsa2Sy2r75VgcK/QgnIIsWiy
   w17OgS08UXHHGqZYmP2sC87TNYYAWJ4OfZa7L5sudGONCD9RakN0Hwfto
   /5Qyql1GSRA3GDuz/fQMM5R2b6es5xvv8b2qHWnysW2ZTVcNM9FBNWX6w
   iViqfMZARFYifkTP9KlY3a2B4Ik76L9bM2cfsMiRjrrkWt+XYwmksUT+4
   SwwTczEsmhBRQXw+uLldjhGD+h22h6nUBLNiZh9gTOquwkuI0SGtHuYRr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267080735"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="267080735"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 05:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="741044535"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2022 05:56:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 05:56:03 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 05:56:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 22 Jul 2022 05:56:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 22 Jul 2022 05:56:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvpDOXdPJ3GxOEA5kOYeI8+fvALUouVZ70jqfpRfBP/DVligV36PADWkCfLj1It7DOVtrTTILol+BTWdh+Y1H2rESeRxxfsPoVCt2htuLejn6gm53PhHb6MDcdLEft86cx0qjPVgNbvo6ByBLYGKh0zxKXIziwD1GVsvok7VoTgcwBeiC8F9rNR4yWHqoPaOWyqTgF9ioLSbFSuOtqnuVW14ssO8XjIPV4lOkly0NDK4nmEDGrh008H5wGbkzbS4irNJShb8lYlIDOE2WOFZYf4q5Hgajei1K4Uo0J5YKvdW2p3KpL4qFi6svfgVo4Dk4qLOVGHE1Hp32V4Q7SuB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTwJ7tqApyqgmT6ECLZxul0gOHbuhhqrdUnx3cUxDtQ=;
 b=Lp+pl82Ucyp3V2UxJlINZvdhGVXu7SsPNcc8lURu+kqrJE6MbrR0zyeFc18xOsrd18hlDpJt2FFYHpxdv2A215p88PfkXs4o7j7gJutiK2EVGaaL8G4sJrkJtfpJraugQfJe/UD20tkWsDHUM1WJWrhtREus1hIme4NAqADgAneil/S9hMz/tiS1wg+sstiCkL/k1HaKUv4x/kK0LMPb7g7jyPZVschnRbCPynou+BVT3RXnsDY6GxUL2H9oJ6AeesuPuF+MW9F8Qmduckr+C8yUE79jliMSMLq+SrSi3Mh5MMj6w/x3RyHff4ezK0rWVAemGSJlDX06ypPV243NIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 12:55:58 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:55:58 +0000
Date:   Fri, 22 Jul 2022 05:55:52 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     <kan.liang@linux.intel.com>
CC:     <peterz@infradead.org>, <mingo@kernel.org>, <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <eranian@google.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <tilak.tangudu@intel.com>
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
Message-ID: <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
 <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b7651f-3943-403b-5d4e-08da6be185c3
X-MS-TrafficTypeDiagnostic: CO1PR11MB4948:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCdj55YYsgB0G09mIiIjma+gRrpr7dYadqZoeMNUM5+OeVsUmTWWkR2sqT3pX27hM3yfsSisqTC4cN8NjSO1K0vAOmGMWS3Bc1nZL80gE4Tp66tO3pQwwkdS5rFAxtsLJi1D5Dlysej7BgjNd1fZX1Jlv5yxqaThFaa0gXXT9tBuu5y0BglxRUt8pDj/fNjxUQn6lrNwi/MR/HJGvCtbvl9VAwIigzld60Yneoj7ML11z19WNfMnI5xubR9dwDDoQjlQh3q5/bOUWTwyYKPs6jI/eCwcRaU4KzHBCpVbZqni6QceFIKRGUq78LrNPYGfIT4rywy01atZIy2tfhAxewXOo9TMBHIcTlzc3YIEeuTNxVMKYQliH5Jqkk2KfZQhKRu+YLM4n4bIcIUMl8y6Xzorv9HMtjnYBPW+KgLrTbaLelRK8ksNpQML9TTQ/VjjEoWtHgCYcEpNTXfPTggoR1td+NOfxgeDpDrUJC5ROf3Nd/Z/Hzht5CphLer1GdcSqweX6ZGY7XL3+MOwr+FZirdT1JzrPG8hFTLhAlSSbGQMMWJ/TAtnJ6cmiaz1qcCIuHSj33tKr0lBQyKknLfMsaZV6ciDRFw6r7qU5zIPpoEDD0tBl9eWMJhaU9//Q4P/Sd/mwqEOCN/k/itfsi6pIzlEDBlJ5BCY90NoFsseLptLbF9XcBLOrMD5o/sX7WwZ5nWJNsFSXRYzudoRcoU5UlA2K6TNpa4M3mz+YEzy46yQFSxctJ6wC0OjLBpS6qEI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(376002)(346002)(366004)(39860400002)(66556008)(2906002)(38100700002)(66476007)(316002)(66946007)(6916009)(8676002)(33716001)(82960400001)(6512007)(86362001)(30864003)(1076003)(9686003)(8936002)(7416002)(83380400001)(6666004)(5660300002)(6506007)(478600001)(41300700001)(6486002)(4326008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zYgUFNqsjFB8rH0gpbyPPdx+nXvEjNWLRam827pzNz2kz68ETt2lQfmFG93d?=
 =?us-ascii?Q?nDC7K3oDBX0JFz+/4qjgyoudcXeMgxEvW4Bu3jq960JOJ6bR5SzHRnYiagcC?=
 =?us-ascii?Q?Aubi4w3bkKdtVSmartbdsZVmIb1bPOCah+qo+qHql4YwEDK01eKREbvCKnEG?=
 =?us-ascii?Q?dGor/p/YZapBkhiviX4y5a+It/LHb912HzwtLxGL4usPTVjg20chWJ0xG68j?=
 =?us-ascii?Q?/LT4dC60Pp3j9HzfqBeDcC6E+W0YLwkyD5vEC+cD9JqnpFusy4REMUR5xsjw?=
 =?us-ascii?Q?8GGn2Au+lAs6DgDeSTKQ4AtESzBcqiJevDbIHj2iCD0eRc1bO7wRO0t0PlR8?=
 =?us-ascii?Q?iGuR5kA0fY9JStNttnpLcCiFJ8qVmJ4qIJc+DoIzgtrwFlIzgKNc9T/Um0qs?=
 =?us-ascii?Q?oQG9WhOkgT7+fDvafRTd3qtKZwrzbZuswn7lRTyi6/1qyHmQZgNIM1Km8njz?=
 =?us-ascii?Q?eddXUqKRuFZiWNIddtda0cYDwMZzK715jv+JjNLegejMEx8bvdY7s9hyMLBw?=
 =?us-ascii?Q?dn/IP9U6VjaNtIym0Gh5maXB62sxL2aeKf7cFV9SwHdj5F/a81qew0pc5HL1?=
 =?us-ascii?Q?4Qo+y2Xs1lSpgSiEwdr0gUXcg12H3HMWKOjTKsUUxbVebKGS3iJg/4gaQ0GN?=
 =?us-ascii?Q?Rp9o/R7kEk4vWTJgotaXOsinxd5seV7M0Bec/OlHHsMhOMoubV0GNjQ4buYF?=
 =?us-ascii?Q?qzkSPlR6mH2YCD49ndZt1u+rneVYlLBnOziWBe8t/PbevRh1JBxxyagD0S9l?=
 =?us-ascii?Q?p/9dyaBvgf1J5wl2H5q0o2MlyZLXBeTGnLwTvykr9ui8ml4yYvfgZySkUq9a?=
 =?us-ascii?Q?VMiasLIQt1Pm/4HNkevLVSDsLZ1KMN6yRcKl9g7mzZxXoYHY2PVCNKOEndJ3?=
 =?us-ascii?Q?EStqcqCZCTla1CH30kXpzGhDeWlNOi+YViQ5nAiwtOLbJ1RIqMDTU71qVAQT?=
 =?us-ascii?Q?fFxfCkWxXgU/kySDTwNrTdpbbJU6Bhjr4gtyjLb2BJKbbn0o4bz9aGLgkq4+?=
 =?us-ascii?Q?ReOSLwaG/tC8FUFKw0b9ab3I1VJXLk4CCBPR0LX2Gz2egUJNWDOYH9E9gdDy?=
 =?us-ascii?Q?AL//rFXPVqhaJUQOptKgfs6ifAES+XGzisW2WUGYFRS7wE4UIp4i6X7heCPU?=
 =?us-ascii?Q?VUuTwf07sca9QXIOF6Bm8Yq/czvt9klIxFFv4HNInCaF3fQ4Gty+UKFOela+?=
 =?us-ascii?Q?j8dQ6MMm2eYMGbHU68C0wZeIIiyo8zx1maT8witOVnT3AthxXdQpANv7G00E?=
 =?us-ascii?Q?KuNNDWamgG/rIOHV8HlkFWw8UlcECSYgN+z9ThJqlHO68zNY4Dfq8AvjRfsT?=
 =?us-ascii?Q?NLMBgsVfQq0kXOOId35eY1S2iAqo0wIPKO8IIWFZLkTK/mIjSc4mdrgO+VrX?=
 =?us-ascii?Q?76jbjXNGPpziSOVMKuEXeBKLH+ynistKlyJ2mlrsP83ZE+rKkwJvaLnY/rwc?=
 =?us-ascii?Q?XO2Zhc3s6tQLrIQjtJUyX3NW45DtNkPNFvSTK2yArGtdDTftYDTZtaU81CHh?=
 =?us-ascii?Q?JcjfSh7fZh/Yb8BveTABRB6Kv0KnP2FX9EHnAE5RGu/+42m26I6pIIayJowe?=
 =?us-ascii?Q?ETsK5jnX7uqX3HntMd/t3ZFDjQ75Y6+VjTIIazRfPp9Et1qTA+DQCkbL+RSv?=
 =?us-ascii?Q?M61BvNvE0sKHmdR6y+B4W7ym9UyJjK8RzShdBdlVwq5x681UoTLprxOx6YNS?=
 =?us-ascii?Q?nIYqhg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b7651f-3943-403b-5d4e-08da6be185c3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:55:58.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlPrDNkNctMz52P/NLH+CBU0RVkcUfRUNJ6XkIIPVwVmOB2wOvpFCx9UdDnNIzO8kl9Pkc7vtVytpsjaBo8iGY16/s18t9knPu9egXJ+L1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Wed, Mar 17, 2021 at 10:59:33AM -0700, kan.liang@linux.intel.com wrote:
>From: Kan Liang <kan.liang@linux.intel.com>
>
>A self-describing mechanism for the uncore PerfMon hardware has been
>introduced with the latest Intel platforms. By reading through an MMIO
>page worth of information, perf can 'discover' all the standard uncore
>PerfMon registers in a machine.
>
>The discovery mechanism relies on BIOS's support. With a proper BIOS,
>a PCI device with the unique capability ID 0x23 can be found on each
>die. Perf can retrieve the information of all available uncore PerfMons
>from the device via MMIO. The information is composed of one global
>discovery table and several unit discovery tables.
>- The global discovery table includes global uncore information of the
>  die, e.g., the address of the global control register, the offset of
>  the global status register, the number of uncore units, the offset of
>  unit discovery tables, etc.
>- The unit discovery table includes generic uncore unit information,
>  e.g., the access type, the counter width, the address of counters,
>  the address of the counter control, the unit ID, the unit type, etc.
>  The unit is also called "box" in the code.
>Perf can provide basic uncore support based on this information
>with the following patches.
>
>To locate the PCI device with the discovery tables, check the generic
>PCI ID first. If it doesn't match, go through the entire PCI device tree
>and locate the device with the unique capability ID.
>
>The uncore information is similar among dies. To save parsing time and
>space, only completely parse and store the discovery tables on the first
>die and the first box of each die. The parsed information is stored in
>an
>RB tree structure, intel_uncore_discovery_type. The size of the stored
>discovery tables varies among platforms. It's around 4KB for a Sapphire
>Rapids server.
>
>If a BIOS doesn't support the 'discovery' mechanism, the uncore driver
>will exit with -ENODEV. There is nothing changed.
>
>Add a module parameter to disable the discovery feature. If a BIOS gets
>the discovery tables wrong, users can have an option to disable the
>feature. For the current patchset, the uncore driver will exit with
>-ENODEV. In the future, it may fall back to the hardcode uncore driver
>on a known platform.
>
>Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

I observed one issue when upgrading a kernel from 5.10 to 5.15 and after
bisecting it arrived to this commit. I also verified the same issue is
present in 5.19-rc7 and that the issue is gone when booting with
intel_uncore.uncore_no_discover.

Test system is a SPR host with a PVC gpu. Issue is that PVC is not
reaching pkg c6 state, even if we put it in rc6 state. It seems the pcie
link is not idling, preventing it to go to pkg c6.

PMON discovery in bios is set to "auto".

We do see the following on dmesg while going through this code path:

	intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff 0xffffffffffffffff 0xffffffffffffffff
	intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff 0xffffffffffffffff 0xffffffffffffffff
	intel_uncore: Uncore type 6 box 0: Invalid box control address.
	intel_uncore: Uncore type 6 box 1: Invalid box control address.
	intel_uncore: Uncore type 6 box 2: Invalid box control address.
	intel_uncore: Uncore type 6 box 3: Invalid box control address.
	intel_uncore: Uncore type 6 box 4: Invalid box control address.
	intel_uncore: Uncore type 6 box 5: Invalid box control address.
	intel_uncore: Uncore type 6 box 6: Invalid box control address.
	intel_uncore: Uncore type 6 box 7: Invalid box control address.

Any idea what could be going wrong here?

thanks
Lucas De Marchi

>---
> arch/x86/events/intel/Makefile           |   2 +-
> arch/x86/events/intel/uncore.c           |  31 ++-
> arch/x86/events/intel/uncore_discovery.c | 318 +++++++++++++++++++++++++++++++
> arch/x86/events/intel/uncore_discovery.h | 105 ++++++++++
> 4 files changed, 448 insertions(+), 8 deletions(-)
> create mode 100644 arch/x86/events/intel/uncore_discovery.c
> create mode 100644 arch/x86/events/intel/uncore_discovery.h
>
>diff --git a/arch/x86/events/intel/Makefile b/arch/x86/events/intel/Makefile
>index e67a588..10bde6c 100644
>--- a/arch/x86/events/intel/Makefile
>+++ b/arch/x86/events/intel/Makefile
>@@ -3,6 +3,6 @@ obj-$(CONFIG_CPU_SUP_INTEL)		+= core.o bts.o
> obj-$(CONFIG_CPU_SUP_INTEL)		+= ds.o knc.o
> obj-$(CONFIG_CPU_SUP_INTEL)		+= lbr.o p4.o p6.o pt.o
> obj-$(CONFIG_PERF_EVENTS_INTEL_UNCORE)	+= intel-uncore.o
>-intel-uncore-objs			:= uncore.o uncore_nhmex.o uncore_snb.o uncore_snbep.o
>+intel-uncore-objs			:= uncore.o uncore_nhmex.o uncore_snb.o uncore_snbep.o uncore_discovery.o
> obj-$(CONFIG_PERF_EVENTS_INTEL_CSTATE)	+= intel-cstate.o
> intel-cstate-objs			:= cstate.o
>diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>index 33c8180..d111370 100644
>--- a/arch/x86/events/intel/uncore.c
>+++ b/arch/x86/events/intel/uncore.c
>@@ -4,7 +4,12 @@
> #include <asm/cpu_device_id.h>
> #include <asm/intel-family.h>
> #include "uncore.h"
>+#include "uncore_discovery.h"
>
>+static bool uncore_no_discover;
>+module_param(uncore_no_discover, bool, 0);
>+MODULE_PARM_DESC(uncore_no_discover, "Don't enable the Intel uncore PerfMon discovery mechanism "
>+				     "(default: enable the discovery mechanism).");
> static struct intel_uncore_type *empty_uncore[] = { NULL, };
> struct intel_uncore_type **uncore_msr_uncores = empty_uncore;
> struct intel_uncore_type **uncore_pci_uncores = empty_uncore;
>@@ -1637,6 +1642,9 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
> 	.mmio_init = snr_uncore_mmio_init,
> };
>
>+static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
>+};
>+
> static const struct x86_cpu_id intel_uncore_match[] __initconst = {
> 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&nhm_uncore_init),
> 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_uncore_init),
>@@ -1684,17 +1692,21 @@ static int __init intel_uncore_init(void)
> 	struct intel_uncore_init_fun *uncore_init;
> 	int pret = 0, cret = 0, mret = 0, ret;
>
>-	id = x86_match_cpu(intel_uncore_match);
>-	if (!id)
>-		return -ENODEV;
>-
> 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> 		return -ENODEV;
>
> 	__uncore_max_dies =
> 		topology_max_packages() * topology_max_die_per_package();
>
>-	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
>+	id = x86_match_cpu(intel_uncore_match);
>+	if (!id) {
>+		if (!uncore_no_discover && intel_uncore_has_discovery_tables())
>+			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
>+		else
>+			return -ENODEV;
>+	} else
>+		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
>+
> 	if (uncore_init->pci_init) {
> 		pret = uncore_init->pci_init();
> 		if (!pret)
>@@ -1711,8 +1723,10 @@ static int __init intel_uncore_init(void)
> 		mret = uncore_mmio_init();
> 	}
>
>-	if (cret && pret && mret)
>-		return -ENODEV;
>+	if (cret && pret && mret) {
>+		ret = -ENODEV;
>+		goto free_discovery;
>+	}
>
> 	/* Install hotplug callbacks to setup the targets for each package */
> 	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_UNCORE_ONLINE,
>@@ -1727,6 +1741,8 @@ static int __init intel_uncore_init(void)
> 	uncore_types_exit(uncore_msr_uncores);
> 	uncore_types_exit(uncore_mmio_uncores);
> 	uncore_pci_exit();
>+free_discovery:
>+	intel_uncore_clear_discovery_tables();
> 	return ret;
> }
> module_init(intel_uncore_init);
>@@ -1737,5 +1753,6 @@ static void __exit intel_uncore_exit(void)
> 	uncore_types_exit(uncore_msr_uncores);
> 	uncore_types_exit(uncore_mmio_uncores);
> 	uncore_pci_exit();
>+	intel_uncore_clear_discovery_tables();
> }
> module_exit(intel_uncore_exit);
>diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>new file mode 100644
>index 0000000..9d5c8b2
>--- /dev/null
>+++ b/arch/x86/events/intel/uncore_discovery.c
>@@ -0,0 +1,318 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/*
>+ * Support Intel uncore PerfMon discovery mechanism.
>+ * Copyright(c) 2021 Intel Corporation.
>+ */
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
>+#include "uncore.h"
>+#include "uncore_discovery.h"
>+
>+static struct rb_root discovery_tables = RB_ROOT;
>+static int num_discovered_types[UNCORE_ACCESS_MAX];
>+
>+static bool has_generic_discovery_table(void)
>+{
>+	struct pci_dev *dev;
>+	int dvsec;
>+
>+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, UNCORE_DISCOVERY_TABLE_DEVICE, NULL);
>+	if (!dev)
>+		return false;
>+
>+	/* A discovery table device has the unique capability ID. */
>+	dvsec = pci_find_next_ext_capability(dev, 0, UNCORE_EXT_CAP_ID_DISCOVERY);
>+	pci_dev_put(dev);
>+	if (dvsec)
>+		return true;
>+
>+	return false;
>+}
>+
>+static int logical_die_id;
>+
>+static int get_device_die_id(struct pci_dev *dev)
>+{
>+	int cpu, node = pcibus_to_node(dev->bus);
>+
>+	/*
>+	 * If the NUMA info is not available, assume that the logical die id is
>+	 * continuous in the order in which the discovery table devices are
>+	 * detected.
>+	 */
>+	if (node < 0)
>+		return logical_die_id++;
>+
>+	for_each_cpu(cpu, cpumask_of_node(node)) {
>+		struct cpuinfo_x86 *c = &cpu_data(cpu);
>+
>+		if (c->initialized && cpu_to_node(cpu) == node)
>+			return c->logical_die_id;
>+	}
>+
>+	/*
>+	 * All CPUs of a node may be offlined. For this case,
>+	 * the PCI and MMIO type of uncore blocks which are
>+	 * enumerated by the device will be unavailable.
>+	 */
>+	return -1;
>+}
>+
>+#define __node_2_type(cur)	\
>+	rb_entry((cur), struct intel_uncore_discovery_type, node)
>+
>+static inline int __type_cmp(const void *key, const struct rb_node *b)
>+{
>+	struct intel_uncore_discovery_type *type_b = __node_2_type(b);
>+	const u16 *type_id = key;
>+
>+	if (type_b->type > *type_id)
>+		return -1;
>+	else if (type_b->type < *type_id)
>+		return 1;
>+
>+	return 0;
>+}
>+
>+static inline struct intel_uncore_discovery_type *
>+search_uncore_discovery_type(u16 type_id)
>+{
>+	struct rb_node *node = rb_find(&type_id, &discovery_tables, __type_cmp);
>+
>+	return (node) ? __node_2_type(node) : NULL;
>+}
>+
>+static inline bool __type_less(struct rb_node *a, const struct rb_node *b)
>+{
>+	return (__node_2_type(a)->type < __node_2_type(b)->type) ? true : false;
>+}
>+
>+static struct intel_uncore_discovery_type *
>+add_uncore_discovery_type(struct uncore_unit_discovery *unit)
>+{
>+	struct intel_uncore_discovery_type *type;
>+
>+	if (unit->access_type >= UNCORE_ACCESS_MAX) {
>+		pr_warn("Unsupported access type %d\n", unit->access_type);
>+		return NULL;
>+	}
>+
>+	type = kzalloc(sizeof(struct intel_uncore_discovery_type), GFP_KERNEL);
>+	if (!type)
>+		return NULL;
>+
>+	type->box_ctrl_die = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
>+	if (!type->box_ctrl_die)
>+		goto free_type;
>+
>+	type->access_type = unit->access_type;
>+	num_discovered_types[type->access_type]++;
>+	type->type = unit->box_type;
>+
>+	rb_add(&type->node, &discovery_tables, __type_less);
>+
>+	return type;
>+
>+free_type:
>+	kfree(type);
>+
>+	return NULL;
>+
>+}
>+
>+static struct intel_uncore_discovery_type *
>+get_uncore_discovery_type(struct uncore_unit_discovery *unit)
>+{
>+	struct intel_uncore_discovery_type *type;
>+
>+	type = search_uncore_discovery_type(unit->box_type);
>+	if (type)
>+		return type;
>+
>+	return add_uncore_discovery_type(unit);
>+}
>+
>+static void
>+uncore_insert_box_info(struct uncore_unit_discovery *unit,
>+		       int die, bool parsed)
>+{
>+	struct intel_uncore_discovery_type *type;
>+	unsigned int *box_offset, *ids;
>+	int i;
>+
>+	if (WARN_ON_ONCE(!unit->ctl || !unit->ctl_offset || !unit->ctr_offset))
>+		return;
>+
>+	if (parsed) {
>+		type = search_uncore_discovery_type(unit->box_type);
>+		if (WARN_ON_ONCE(!type))
>+			return;
>+		/* Store the first box of each die */
>+		if (!type->box_ctrl_die[die])
>+			type->box_ctrl_die[die] = unit->ctl;
>+		return;
>+	}
>+
>+	type = get_uncore_discovery_type(unit);
>+	if (!type)
>+		return;
>+
>+	box_offset = kcalloc(type->num_boxes + 1, sizeof(unsigned int), GFP_KERNEL);
>+	if (!box_offset)
>+		return;
>+
>+	ids = kcalloc(type->num_boxes + 1, sizeof(unsigned int), GFP_KERNEL);
>+	if (!ids)
>+		goto free_box_offset;
>+
>+	/* Store generic information for the first box */
>+	if (!type->num_boxes) {
>+		type->box_ctrl = unit->ctl;
>+		type->box_ctrl_die[die] = unit->ctl;
>+		type->num_counters = unit->num_regs;
>+		type->counter_width = unit->bit_width;
>+		type->ctl_offset = unit->ctl_offset;
>+		type->ctr_offset = unit->ctr_offset;
>+		*ids = unit->box_id;
>+		goto end;
>+	}
>+
>+	for (i = 0; i < type->num_boxes; i++) {
>+		ids[i] = type->ids[i];
>+		box_offset[i] = type->box_offset[i];
>+
>+		if (WARN_ON_ONCE(unit->box_id == ids[i]))
>+			goto free_ids;
>+	}
>+	ids[i] = unit->box_id;
>+	box_offset[i] = unit->ctl - type->box_ctrl;
>+	kfree(type->ids);
>+	kfree(type->box_offset);
>+end:
>+	type->ids = ids;
>+	type->box_offset = box_offset;
>+	type->num_boxes++;
>+	return;
>+
>+free_ids:
>+	kfree(ids);
>+
>+free_box_offset:
>+	kfree(box_offset);
>+
>+}
>+
>+static int parse_discovery_table(struct pci_dev *dev, int die,
>+				 u32 bar_offset, bool *parsed)
>+{
>+	struct uncore_global_discovery global;
>+	struct uncore_unit_discovery unit;
>+	void __iomem *io_addr;
>+	resource_size_t addr;
>+	unsigned long size;
>+	u32 val;
>+	int i;
>+
>+	pci_read_config_dword(dev, bar_offset, &val);
>+
>+	if (val & UNCORE_DISCOVERY_MASK)
>+		return -EINVAL;
>+
>+	addr = (resource_size_t)(val & ~UNCORE_DISCOVERY_MASK);
>+	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
>+	io_addr = ioremap(addr, size);
>+	if (!io_addr)
>+		return -ENOMEM;
>+
>+	/* Read Global Discovery State */
>+	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery));
>+	if (uncore_discovery_invalid_unit(global)) {
>+		pr_info("Invalid Global Discovery State: 0x%llx 0x%llx 0x%llx\n",
>+			global.table1, global.ctl, global.table3);
>+		iounmap(io_addr);
>+		return -EINVAL;
>+	}
>+	iounmap(io_addr);
>+
>+	size = (1 + global.max_units) * global.stride * 8;
>+	io_addr = ioremap(addr, size);
>+	if (!io_addr)
>+		return -ENOMEM;
>+
>+	/* Parsing Unit Discovery State */
>+	for (i = 0; i < global.max_units; i++) {
>+		memcpy_fromio(&unit, io_addr + (i + 1) * (global.stride * 8),
>+			      sizeof(struct uncore_unit_discovery));
>+
>+		if (uncore_discovery_invalid_unit(unit))
>+			continue;
>+
>+		if (unit.access_type >= UNCORE_ACCESS_MAX)
>+			continue;
>+
>+		uncore_insert_box_info(&unit, die, *parsed);
>+	}
>+
>+	*parsed = true;
>+	iounmap(io_addr);
>+	return 0;
>+}
>+
>+bool intel_uncore_has_discovery_tables(void)
>+{
>+	u32 device, val, entry_id, bar_offset;
>+	int die, dvsec = 0, ret = true;
>+	struct pci_dev *dev = NULL;
>+	bool parsed = false;
>+
>+	if (has_generic_discovery_table())
>+		device = UNCORE_DISCOVERY_TABLE_DEVICE;
>+	else
>+		device = PCI_ANY_ID;
>+
>+	/*
>+	 * Start a new search and iterates through the list of
>+	 * the discovery table devices.
>+	 */
>+	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>+		while ((dvsec = pci_find_next_ext_capability(dev, dvsec, UNCORE_EXT_CAP_ID_DISCOVERY))) {
>+			pci_read_config_dword(dev, dvsec + UNCORE_DISCOVERY_DVSEC_OFFSET, &val);
>+			entry_id = val & UNCORE_DISCOVERY_DVSEC_ID_MASK;
>+			if (entry_id != UNCORE_DISCOVERY_DVSEC_ID_PMON)
>+				continue;
>+
>+			pci_read_config_dword(dev, dvsec + UNCORE_DISCOVERY_DVSEC2_OFFSET, &val);
>+
>+			if (val & ~UNCORE_DISCOVERY_DVSEC2_BIR_MASK) {
>+				ret = false;
>+				goto err;
>+			}
>+			bar_offset = UNCORE_DISCOVERY_BIR_BASE +
>+				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
>+
>+			die = get_device_die_id(dev);
>+			if (die < 0)
>+				continue;
>+
>+			parse_discovery_table(dev, die, bar_offset, &parsed);
>+		}
>+	}
>+
>+	/* None of the discovery tables are available */
>+	if (!parsed)
>+		ret = false;
>+err:
>+	pci_dev_put(dev);
>+
>+	return ret;
>+}
>+
>+void intel_uncore_clear_discovery_tables(void)
>+{
>+	struct intel_uncore_discovery_type *type, *next;
>+
>+	rbtree_postorder_for_each_entry_safe(type, next, &discovery_tables, node) {
>+		kfree(type->box_ctrl_die);
>+		kfree(type);
>+	}
>+}
>diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
>new file mode 100644
>index 0000000..95afa39
>--- /dev/null
>+++ b/arch/x86/events/intel/uncore_discovery.h
>@@ -0,0 +1,105 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+
>+/* Generic device ID of a discovery table device */
>+#define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
>+/* Capability ID for a discovery table device */
>+#define UNCORE_EXT_CAP_ID_DISCOVERY		0x23
>+/* First DVSEC offset */
>+#define UNCORE_DISCOVERY_DVSEC_OFFSET		0x8
>+/* Mask of the supported discovery entry type */
>+#define UNCORE_DISCOVERY_DVSEC_ID_MASK		0xffff
>+/* PMON discovery entry type ID */
>+#define UNCORE_DISCOVERY_DVSEC_ID_PMON		0x1
>+/* Second DVSEC offset */
>+#define UNCORE_DISCOVERY_DVSEC2_OFFSET		0xc
>+/* Mask of the discovery table BAR offset */
>+#define UNCORE_DISCOVERY_DVSEC2_BIR_MASK	0x7
>+/* Discovery table BAR base offset */
>+#define UNCORE_DISCOVERY_BIR_BASE		0x10
>+/* Discovery table BAR step */
>+#define UNCORE_DISCOVERY_BIR_STEP		0x4
>+/* Mask of the discovery table offset */
>+#define UNCORE_DISCOVERY_MASK			0xf
>+/* Global discovery table size */
>+#define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE	0x20
>+
>+#define uncore_discovery_invalid_unit(unit)			\
>+	(!unit.table1 || !unit.ctl || !unit.table3 ||	\
>+	 unit.table1 == -1ULL || unit.ctl == -1ULL ||	\
>+	 unit.table3 == -1ULL)
>+
>+enum uncore_access_type {
>+	UNCORE_ACCESS_MSR	= 0,
>+	UNCORE_ACCESS_MMIO,
>+	UNCORE_ACCESS_PCI,
>+
>+	UNCORE_ACCESS_MAX,
>+};
>+
>+struct uncore_global_discovery {
>+	union {
>+		u64	table1;
>+		struct {
>+			u64	type : 8,
>+				stride : 8,
>+				max_units : 10,
>+				__reserved_1 : 36,
>+				access_type : 2;
>+		};
>+	};
>+
>+	u64	ctl;		/* Global Control Address */
>+
>+	union {
>+		u64	table3;
>+		struct {
>+			u64	status_offset : 8,
>+				num_status : 16,
>+				__reserved_2 : 40;
>+		};
>+	};
>+};
>+
>+struct uncore_unit_discovery {
>+	union {
>+		u64	table1;
>+		struct {
>+			u64	num_regs : 8,
>+				ctl_offset : 8,
>+				bit_width : 8,
>+				ctr_offset : 8,
>+				status_offset : 8,
>+				__reserved_1 : 22,
>+				access_type : 2;
>+			};
>+		};
>+
>+	u64	ctl;		/* Unit Control Address */
>+
>+	union {
>+		u64	table3;
>+		struct {
>+			u64	box_type : 16,
>+				box_id : 16,
>+				__reserved_2 : 32;
>+		};
>+	};
>+};
>+
>+struct intel_uncore_discovery_type {
>+	struct rb_node	node;
>+	enum uncore_access_type	access_type;
>+	u64		box_ctrl;	/* Unit ctrl addr of the first box */
>+	u64		*box_ctrl_die;	/* Unit ctrl addr of the first box of each die */
>+	u16		type;		/* Type ID of the uncore block */
>+	u8		num_counters;
>+	u8		counter_width;
>+	u8		ctl_offset;	/* Counter Control 0 offset */
>+	u8		ctr_offset;	/* Counter 0 offset */
>+	u16		num_boxes;	/* number of boxes for the uncore block */
>+	unsigned int	*ids;		/* Box IDs */
>+	unsigned int	*box_offset;	/* Box offset */
>+};
>+
>+bool intel_uncore_has_discovery_tables(void);
>+void intel_uncore_clear_discovery_tables(void);
>-- 
>2.7.4
>
