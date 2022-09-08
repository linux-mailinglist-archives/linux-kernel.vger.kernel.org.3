Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B365B1429
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIHFnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIHFne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:43:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0467C99;
        Wed,  7 Sep 2022 22:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662615813; x=1694151813;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UoCDuTZe3RMg6p+P77PtI3qXYPUkfdZrjty/liOY5wk=;
  b=nxrEn5PdQIXZywKV0s5VX4bIVFX80uVZ5USafidvkA+VOferZBxgVoBG
   LRuZ8J8JUt1YZPK68Kknpl0Ii3KaMuGCesJr9qLy42hRikyPOuLDiZsvj
   rTwPQg17++RAn/NrIOKNqawsIsZoBZunQsGodIYtWPVeynphl91DOVB0M
   +/5oTWfFOl4SvDUJhyY8ZlnCtgbRbqS+R76omj8tA6b4hbbnhyHbRyisp
   gHFuZo4/U/5gy8SuvMOA/JeLL9nO6J888+KlO31NUxk74K0fAshTf2sqw
   jMsuDeIazDEVCqnxUegMvwtiqH3RTTOE5TzACSoPfmTpxZsiPYk3l1Pan
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276809792"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="276809792"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 22:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="614762470"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2022 22:43:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:43:32 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:43:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 22:43:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 22:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZrc5nxDgVSHupxafOE6Dn6dIp27u69izv4soYBTAupYUSDs6vYiAznaLq5fVjsX08TXIdsRZg5pcQTw5aoJK96vD3Ez+Jaxg9XGU9GgL98d5SJhVRTn0fYqI1EE9KEuYUcdH/ZMIxkqHt6BdBukZkn6oCjMxbRAiah/r+v2MAX7+YCMsCy1uECEpkhvwRBSN/aHC90Qs2/hOkvzKN/K6XZYqRwP0fYsRsqusAFTbiAi46c1L9k3Z6Irdcq70czsPgOj9OIIVwVXu4GKUmwR543yS+aADyJXwNjrANG2EPPFWuSlXaEb3NYtVCvgvknVooenrZBXMsumr9flqiUD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVUh4SboKk7jFS3N+IZuQZYBghbDtBeduHK8OH0H+Tc=;
 b=QlZSQDgHK3i6qfFN4VwaFMjlqJUnXWT59kkJEQXX5Te1KSHqfjxSYJLLbab60E5frgqWU8H+5ZAc9+vWAvVDJi32DM5XTC92gCvWkt7O7OpE4mV1d/9MbKpDquPLHGlPq3vAbIEpd52gBUcTHpzGZnR/33njk6FT6PADNANMhz9D4aMBp/GydXllGcWgfnvfKdaS4dbX73ogUzZ9aNqs+TxoP00tkq4C0omuvYaTYcDPLZCWgegIMHsJAemQDEhf8P9i3kRavqRDyUStWHrCKuTNzXigEGu5s7XhSY9b9qPJzeTanNgtml6yaZFeMnublKM+neQQsDAAaaLxlExcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB7032.namprd11.prod.outlook.com
 (2603:10b6:303:227::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 8 Sep
 2022 05:43:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 05:43:30 +0000
Date:   Wed, 7 Sep 2022 22:43:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Message-ID: <631980ff90319_58016294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c39cce7-de3d-46e5-c4cb-08da915d0f42
X-MS-TrafficTypeDiagnostic: MW4PR11MB7032:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUzT5rA4oCmmYxtGS12X2g8a6jzCzPe+e/cSRpJXyb+ueFSW0tWKpQ4/4T0Ooudn/cHAa5U02/xv75nGcvihFwEBvykv7FWSLl5+ApxdGj5fWw9gS57nemaJ8MYQ4wLtxFFRULPpeQ/bwXBsU+xGe1G+pqZK1tCd9kloWntdfRnI6OO2PLHcZ9btQ/jSWLSi9KPcP37YHP/crl5iG0MHils4OAGbGsLCI2VV/5Ute4mMRyDrbMkcEG5dx4IMV42UcNoCExYTyyclBEBuBu97/NxwQFXo+OuOtO460w6Pi+lm6UcM9VvvXAocCCj8aQaknEkIxOi3I/f9xof6n39Suh7C0NjlUMZYgU6OjEyVAvNx+7qC1HdIzoqlcJORW1AfYCnioLPQeFIZNvjdEcRF29Yz67vOW8OFdK5O23cBGfaI1DTii9UYu50ixmzcwwkKRlR/HEPVCQEHPf5m1iLmBGvqyZ/yQVEtfEnGKlL5hXN4WMZW657pic4F+cnUxkhpFckFfwt2+l9opfoxg/CjNG7BtyFy09tbHXYhyGXuNkEdOo/liKj7Nb6PjYirZ/TduYDC5b989uERndaAHqWj73trCEmKKURv8advpx8HyxpuLjGXphtbfKFA2VN3pXkxIXAlt8ArmQVVqBMcjDZDBsvv13YXVQEWeakkRs/1o/ucFqBOFnl2dNBVpEXMQNKpZB/ZQdOwbmCGx/83tL6aZ6Z79AsfgzkopnAxbbw6JvwK+wR0KNBlmobNRrq6oWnA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(6486002)(6512007)(8936002)(66946007)(66556008)(66476007)(6506007)(41300700001)(6666004)(86362001)(5660300002)(9686003)(478600001)(8676002)(186003)(26005)(4326008)(2906002)(966005)(54906003)(110136005)(83380400001)(38100700002)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vO0vYoBKW70fPt74F5LmwPnOkGxlt7L4C/yGGnxZHqJLGlpqkHbs3Bwvfw9e?=
 =?us-ascii?Q?d/EQm9O3s0U+xsDPDSL6dGLsf4qxfJ+DenHhwh5yXQoJF13/+i7FyshIB3Cf?=
 =?us-ascii?Q?ZlPISwExrwI3W+DDMolbcB7hkXcJQgtSqhXS8QtT02fK3aQZWwVSGah9D8gj?=
 =?us-ascii?Q?H5KoRqt422B8y9Ptuj19TgDkoGuxOAhuCHKwWzSyCG2AsbNZ9OWhFxBKjGj3?=
 =?us-ascii?Q?fmXgihP3l2RBC6Bx7UX7B2jYwqnQzLqf2TagXlYcLVz8AJY4sxfg3/T46sFx?=
 =?us-ascii?Q?2cURbOJakgVXZEQ0zm5M11ma4PUsgB/fRE+QKbY8MyFXAesefHTVaBD+0p5a?=
 =?us-ascii?Q?iNVwK4eNigI5+7LGtVu5u6CkS8+6oWpMWPT4k3ThlR+ca1FPE9PLGHHdOStg?=
 =?us-ascii?Q?AzjmJwe+JUDDd32J0DfVJknL+kBrjK95s/2tf1VkMJKdXTjU++/ag2wPyb6t?=
 =?us-ascii?Q?Gu7wO/XjHsh9bfZSkW2R2hdSK1Mr+pABW+hqid9WNLEsSO+pQEWLHgrsgIm6?=
 =?us-ascii?Q?dXDjs+I34Gv/syzazqMyQ4OaqDbW5k9Io7f5rNjAmEAsksiAVuV7WMFf3MDY?=
 =?us-ascii?Q?XNn11OUHknwmZ5sn75bmHf5adPsrJ/G2EIQ7O4CX/q39j333C3BIX73Aowom?=
 =?us-ascii?Q?3BMVgC1fINLUKQUaBepcIZyybh6coyoqZ7NzJWy6r3kv0yqH6qSK1j0QCU3b?=
 =?us-ascii?Q?RnpC0GGoUynO3CUFaH1Q8JMSG4cm6Q+pK1Ga5LmSyywSvIdv44cg2/z0L0/s?=
 =?us-ascii?Q?WStVu6wHYqTmozKG/r7y48jlkIES2Ed5L/389NJEkqUgxI7VM3BH6Q+GF8Bv?=
 =?us-ascii?Q?uhj8j7xHogp67Tfe6VKRySl2Sckqu2qHG4vOFDVjQJDlIDW66mU1ldxsCLTs?=
 =?us-ascii?Q?DPc1NQBJllDh9wCGbR37jpXpo/MuUor52v56rtppAlUZLbMvefAiRxWL7IO/?=
 =?us-ascii?Q?+lDire8EdwpwIESoBwh1z1CdvMCcwtqPN7wgUpT4Ys3ws1hUfElL8LsUr2xl?=
 =?us-ascii?Q?OhXR8SbNVDrwCNl/ONfZsusH80P54VfO7eq1c8U8ul3bCyXYK7GjDxiEha3x?=
 =?us-ascii?Q?3idc+WKidSYxAU7F8cpPTYTerCBq4dWzfYTk4xa+7WjhE78ggJVmwStPXZRd?=
 =?us-ascii?Q?kCRmhPKQNG7jkVDobiCUmvq/43SjApgT/BARI4rfP6eN1qEs3C8ml3TWvEp0?=
 =?us-ascii?Q?5TD1142NkyyDdxhPTRRCfiUnxzbrCAzoylGFkCfk+vfKl++HvrfHpEO8FCIk?=
 =?us-ascii?Q?eUnkjo9fIzbQMQA4VuR6uKStiKMrp9Cx4OpSuPhZEI2Cb9tL+vAnz1xe//KK?=
 =?us-ascii?Q?2elvGf1YQWg39weSg58QFchNyAxb99yWmF7CuXUJJiBIaW3EHxr5Jv2GIn0u?=
 =?us-ascii?Q?ZwayvzPFKJifw6caQO9n1fMUkgEVx/Qn9Pt/wLK/Iu+0xBiXKgh2IsoznCzq?=
 =?us-ascii?Q?A/sDar2lm3dY2H+lCplvVBwuvltFSeoKuGEXoirTzj5VqCAHRvhuybi+JTpv?=
 =?us-ascii?Q?tFqiiOxI/dJ3CAEu7ZVXJpjTsP0mLMnE2SVPCP/edGeUl0OvuoQAUIIkPy5J?=
 =?us-ascii?Q?SoYHA6NRP4bsWus/baFHiDPX6MwAlvCs/m42puirVVLZ2Hup6V9eBDLwHEFm?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c39cce7-de3d-46e5-c4cb-08da915d0f42
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 05:43:30.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86lqlue8TzpteIHNmJFQLq4Aqc82FR7CYKmrFidJE509dHHOI9pobagpx2dJIl60xem1oxUmYdGjTOJBKnWtBteF2cDuPIjYKXsAmHe4xeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the delay in getting to this I had hoped to be able to
finish up some other DAX work to focus on this, but time is getting
short so I will need to do both in parallel.

Robert Richter wrote:
> In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
> the PCIe enumeration hierarchy is different from CXL VH Enumeration
> (formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
> and 9.12, [1]). This series adds support for RCD mode. It implements
> the detection of Restricted CXL Hosts (RCHs) and its corresponding
> Restricted CXL Devices (RCDs). It does the necessary enumeration of
> ports and connects the endpoints. With all the plumbing an RCH/RCD
> pair is registered at the Linux CXL bus and becomes visible in sysfs
> in the same way as CXL VH hosts and devices do already. RCDs are
> brought up as CXL endpoints and bound to subsequent drivers such as
> cxl_mem.
> 
> For CXL VH the host driver (cxl_acpi) starts host bridge discovery
> once the ACPI0017 CXL root device is detected and then searches for
> ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
> might not necessarily exist 

That's a broken BIOS as far as I can see. No ACPI0017 == no OS CXL
services and the CXL aspects of the device need to be 100% managed by
the BIOS. You can still run the cxl_pci driver in that case for mailbox
operation, but error handling must be firmware-first without ACPI0017.

> PCIe host bridge PNP0A08 ID, there aren't any CXL port or switches in
> the PCIe hierarchy visible. As such the RCD mode enumeration and host
> discovery is very different from CXL VH. See patch #5 for
> implementation details.
> 
> This implementation expects the host's downstream and upstream port
> RCRBs base address being reported by firmware using the optional CEDT
> CHBS entry of the host bridge (see CXL spec 3.0, 9.17.1.2).
> 
> RCD mode does not support hot-plug, so host discovery is at boot time
> only.
> 
> Patches #1 to #4 are prerequisites of the series with fixes needed and
> a rework of debug messages for port enumeration. Those are general
> patches and could be applied earlier and independently from the rest
> assuming there are no objections with them. Patches #5 to #15 contain
> the actual implementation of RCD mode support.
> 
> [1] https://www.computeexpresslink.org/spec-landing
> 
> Robert Richter (15):
>   cxl/core: Remove duplicate declaration of devm_cxl_iomap_block()
>   cxl/core: Check physical address before mapping it in
>     devm_cxl_iomap_block()
>   cxl: Unify debug messages when calling devm_cxl_add_port()
>   cxl: Unify debug messages when calling devm_cxl_add_dport()
>   cxl/acpi: Add probe function to detect restricted CXL hosts in RCD
>     mode
>   PCI/ACPI: Link host bridge to its ACPI fw node
>   cxl/acpi: Check RCH's PCIe Host Bridge ACPI ID
>   cxl/acpi: Check RCH's CXL DVSEC capabilities
>   cxl/acpi: Determine PCI host bridge's ACPI UID
>   cxl/acpi: Extract the RCH's RCRB base address from CEDT
>   cxl/acpi: Extract the host's component register base address from RCRB
>   cxl/acpi: Skip devm_cxl_port_enumerate_dports() when in RCD mode
>   cxl/acpi: Rework devm_cxl_enumerate_ports() to support RCD mode
>   cxl/acpi: Enumerate ports in RCD mode to enable RCHs and RCDs
>   cxl/acpi: Specify module load order dependency for the cxl_acpi module
> 
>  drivers/acpi/pci_root.c      |   1 +
>  drivers/cxl/acpi.c           | 311 ++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/pci.c       |  22 ++-
>  drivers/cxl/core/port.c      | 103 ++++++++----
>  drivers/cxl/core/regs.c      |   3 +
>  drivers/cxl/cxl.h            |   2 -
>  drivers/cxl/mem.c            |   1 +
>  tools/testing/cxl/test/cxl.c |   8 +-
>  8 files changed, 400 insertions(+), 51 deletions(-)
> 
> -- 
> 2.30.2
> 


