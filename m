Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717D65B0AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIGQw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIGQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:52:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39109923F8;
        Wed,  7 Sep 2022 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569545; x=1694105545;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qmfg+MAbjCv7I+e3ib3dOiJ5AqFUj/UbOfH1ADVJ9Kw=;
  b=Sp2WZ6hBIjJeKLRZXZEzQQLwPQvV+0Ya2RhS5Lh/UiAqu1ht5BgJSEuk
   Zi0gNzan/uO4z4DR1C6OMUrnv0ss7IA1svOi3Ae+o8PKXbQB+wUNa5YGc
   f0l0b2vddyq76VUSs0XK66RFyFYf2kTDqUOMtL97R8ai8dMdYj04g90Xk
   +AjAajhWed5P9ISVyFYxmxdeHUKU5ap9btYDOiChPn1MA7NgudmKQAQ0d
   X2yNyGk3coXPBo4lQRoeveLlEV5qP2VAYE/qJ7cR7oJuw0YgLPD2/L8Th
   UuAxJYHLX/bZwtgixXIMmNM6PjiRyuHVLowr5H05M4SHCcuCs7DG/evjO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="277325717"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="277325717"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="682889637"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2022 09:52:24 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 09:52:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 09:52:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 09:52:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 09:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWL5GZW7DFfdSMDPJZozIVuhOXIJrmsxNb4mBwB0EJTH512nDZJSyCO7lGqh92ENY4axGOT9jTyzJritvtQRWqSW9v4ZswtB/4FGhs7gzlHYI64BLO9jr7uFwLL6Ds8JIXPTWls6hpZjuPsV/ic0d+tAeWghfpc46mgIOmbjI7n/r7Xj7Ocg7qlys0wKqZiCYXQ8nbs4kFaqXNxVXLYQ2WIQ6lpFCw71u8qixwQ9RLLCwzKeyXmzHGipvmOAdmycfpgIto3LLSx4DTLWZz12ZCvmsZd4LZvbyx51kJRY9p1iMW7JalmgjUwf2RvSqQpiKxQv/F4QuBRIRyNm6qUkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l5LNJUmZ5yGz6HfTw3sztBOM+dt8CJACjFzYJ3nWjc=;
 b=bmMm2r8ey3F/m7bfao+GpU/fvm+Z9cNPwWCLQCu2Omq3t/u1sERGdz+dOgzSCZlMpPz4zq7Azd7kzl0oURVakb+y0JBPb8M5mSOBHqB5FTHhdN5EJ5MAaACDyg+g2mShQnRoeIQHQH/wnQG45PWxGMOsrGs6OuMC1V8kN76YsLsMEGNo/Oogi9/U3gzBtDVpePmeJZWGh7m5ma7xoAmjPbs8t98amvIudHidz8UMW3rKz6llyUbxLzPOaH3SENJ7yOihVguBAda1qoLU/OQfaDdm3nqaOBHIKM9nuSM8SHz0jWuadWOB51qEE8FrnS4jYzxFm0+8HU5rfjxEaYqMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB7136.namprd11.prod.outlook.com
 (2603:10b6:930:60::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 16:52:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 16:52:19 +0000
Date:   Wed, 7 Sep 2022 09:52:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, Borislav Petkov <bp@alien8.de>
CC:     <dan.j.williams@intel.com>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <6318cc415161f_166f2941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <YxjBSxtoav7PQVei@nazgul.tnic>
 <20220907162245.5ddexpmibjbanrho@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220907162245.5ddexpmibjbanrho@offworld>
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8982f638-06ff-4df1-334b-08da90f153f8
X-MS-TrafficTypeDiagnostic: CY8PR11MB7136:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zL2AtWlEGQTkuX36cNFewB+gg0Z11L8xM71E3X3SkgP18irNK5obRU7G27e4myEScXdVFOB3lFV/zbJ1H3Kia97oMA2sjQdNJ1LuIvN3nSXdURBvJ3XxxGlciA5Vofky1Tls58lP7tcpj/Dz//8K7p8iy9eoEWqygyrPWyb33O73VOiHJuKCAdiKYOem7RvG9QIcEbzQwSvW4ySbBEo/1kBbFpw9IM7uOEeVU+wdKFxmyBoMNxVzAdvp1tAN620Qz4ruxWKjeMYaktoLu+fg3rDeZPNu5Gm8JKmbGD0xhGOW/8jYEihvt61NUDVlx1Le/AhTONIQgaHC9eIbeAJuInmlz95o8EtLEgmoH+9S16P4GcURppnvYZdXCLTkMjmx8zIUoMmjtmA0x7lK03PUco9uWd0GE5p8/DPF9MNNfd/2H1IDd5EAZoOYateD8xGs28xi3SyQ4KiPEQvA93ojhQmk8GFA+O5sTM3R2IczCiERZi5ttypkI9bowSoYjHuF/QixoBsMkZGryzjjHogEzO0jfO+r/vJGoJ8RsFxp5XqlVFXf+jzeE1NCgd1gp1yucKS3P3m0Oo7sNtMy9fQVTnBdNddIbXWP85/yK5cEXAHnek1nes8kylT18+bvkrFv3EhF9k+sLZAkNmjkhVT/PStUzUnLNQaGhyFVzWxbOs1fqi3vFGi4ZZhjf4qI2wM+XaOPYPZueD8Bx+yMR7bvSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(346002)(136003)(8676002)(66476007)(83380400001)(478600001)(66946007)(4326008)(6506007)(66556008)(186003)(26005)(2906002)(5660300002)(9686003)(6512007)(8936002)(86362001)(7416002)(6486002)(41300700001)(316002)(82960400001)(38100700002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwctkrgmf9mFUaUC5bsarsXazGM0/y0yrCURjne6314mlhP7FfrQjO2I3HsN?=
 =?us-ascii?Q?mreaIcZ9ceMHgh0tUNiyKEoMxmnPTCSiH+WzHKT1CNF67SfdNrkTCS+6I7kU?=
 =?us-ascii?Q?omNh3QSY8qLRXODANjV2CU6UWxLPBqdfWGSmqYBDIi67+QIvcYJDqUaQo3fB?=
 =?us-ascii?Q?1tTVYCQRZjxsbPy3UoJVtH5U2rOI44mjgUM+9mKC4SvuWJMHrTqj7REB4Mr3?=
 =?us-ascii?Q?RolaKrgYcQOZEeQNFekmcG2Ae/eOVhK7J0zWOR+++vzZdmEsmC2+gW0rla+d?=
 =?us-ascii?Q?HUs/Nt+K185mMUUA1Qg6c15R+QHjtLpb1lG+nvehebuFiezXxvzFbcLtpRbO?=
 =?us-ascii?Q?Gjce2lDtJsdgnGB6aGoxRblq4AWoxikkzQxhsM7gXJZwYLc/g7QQSw086xT5?=
 =?us-ascii?Q?OjW7kDf1SUJ3hTXQVhzjOXQnAzW1sniSvEgU8NTXQh1rOzj4xMBT0ABVUFWs?=
 =?us-ascii?Q?Tv6JKXxYhhSJ1eUQdOUFOed7NXtl3mFYTD6Rd5qYQxpMPfLaZEY2z1T8pQct?=
 =?us-ascii?Q?oVcCqQePDmBat1OafPBVdhjQIKyK57XKBRJDYAhP6+bA5c74spmby1EaAbug?=
 =?us-ascii?Q?3Jt+5IYYexepHMg0fzHrj/Dge/69ulx3x13LAufPjkrKm+Z0YjXKhKaoIs4z?=
 =?us-ascii?Q?kvfVjY54PppeJLXcyPyKyqzKUkUSmWGsk9IWueq5AygIvHqbiK1wyx5ofyBo?=
 =?us-ascii?Q?elYVduWhiOfbrllWY981IflfVjMtkO3y6Dk8E0Z8poVPojsqqapZIBSC5pC2?=
 =?us-ascii?Q?2CTNjwHIpE36hU/RzVECRIwW2xdIkUmPNq1mWazrhKtpCElOZxy8chCh+Uy+?=
 =?us-ascii?Q?Kvq1TynB7zhdTdCVd0daEJWwDSab9SLkyZ8yFjn+6ckf2dnqjuwI48X8ROdb?=
 =?us-ascii?Q?7gUMBW7JRT7kFahwqlHTMfuRLCFcH7MbQX524iqyFJR7vuu6WO8ybJdmwLyA?=
 =?us-ascii?Q?pGJjDKfQM8LspM/7p4yrfD9tjhzOvD/JtqfoLXEk4NiMBuMtonz7GRLar82Q?=
 =?us-ascii?Q?kRVLBVXhPGQnEupP0j5vI201hR1WrrCegyXbQXH6CbGw41+dfmclXPM9lFZX?=
 =?us-ascii?Q?tIAWMJLF9HEftbI6lSd5hXQ3ATyckTHN5HVTyMEHEh4rcIkEb/yveH3cvyWZ?=
 =?us-ascii?Q?Wjo0Ez8+DPWjnL1hIeg+ILfndPAjnh3DBjefo0lSa730UD3t4SgLKzj6+bUb?=
 =?us-ascii?Q?DSFPH2i3QnO9+Nd6jMmL5U6ogey414JkZoA1gzz406QaWqdsQZQguDIl+HDe?=
 =?us-ascii?Q?XBiSFGDhAvp2M8KsILPy1keFgrmasRTNpdCIGmD0mkBN6bbFd1KvbBinZ4Lc?=
 =?us-ascii?Q?t2K1mHG6wimdCAufnW/hYXw4wJsdhT3FSkzGlf0PrVc3evH0pRgjY13zTiNH?=
 =?us-ascii?Q?74bTGV92ybYxwC9lMZWiYmS4MD/GXoR7BBPd94ZkdngELBrPLy1KE5IlHRVh?=
 =?us-ascii?Q?/Olu5O1RNC1WluEGeO2xV41osoSdi97YNJJIEXmo++oLnpHkKWQhSRmPIRoz?=
 =?us-ascii?Q?l0g4oeLUaZS3wHlLtqZwszkIoFGmu2BNuO5M3wGO4SEz/DaY80tBPvUtFqSV?=
 =?us-ascii?Q?O/pIKIxBZBChC57DcWCuaU4pShmzIZ6GqsMbLnvgw6jQsW2zeKa24LQ0HazE?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8982f638-06ff-4df1-334b-08da90f153f8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 16:52:19.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+Zl5xVIr9qvP6QsAD/nCdcm6J4RDMlwIfoQVQlptw13qd0GrRC3wpwdX9F/WpirKTNPjyx7Hn+795EbQVsgEuKawCvsgW/cPmM7nhCaJnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 07 Sep 2022, Borislav Petkov wrote:
> 
> >On Mon, Aug 29, 2022 at 02:29:18PM -0700, Davidlohr Bueso wrote:
> >> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> >> index 1abd5438f126..18463cb704fb 100644
> >> --- a/arch/x86/mm/pat/set_memory.c
> >> +++ b/arch/x86/mm/pat/set_memory.c
> >> @@ -330,6 +330,20 @@ void arch_invalidate_pmem(void *addr, size_t size)
> >>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> >>  #endif
> >>
> >> +#ifdef CONFIG_ARCH_HAS_MEMREGION_INVALIDATE
> >> +bool arch_has_flush_memregion(void)
> >> +{
> >> +	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
> >
> >This looks really weird. Why does this need to care about HV at all?
> 
> So the context here is:
> 
> e2efb6359e62 ("ACPICA: Avoid cache flush inside virtual machines")
> 
> >
> >Does that nfit stuff even run in guests?
> 
> No, nor does cxl. This was mostly in general a precautionary check such
> that the api is unavailable in VMs.

To be clear nfit stuff and CXL does run in guests, but they do not
support secure-erase in a guest.

However, the QEMU CXL enabling is building the ability to do *guest
physical* address space management, but in that case the driver can be
paravirtualized to realize that it is not managing host-physical address
space and does not need to flush caches. That will need some indicator
to differentiate virtual CXL memory expanders from assigned devices. Is
there such a thing as a PCIe-virtio extended capability to differentiate
physical vs emulated devices?
