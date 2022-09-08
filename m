Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB95B2715
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIHTri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiIHTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:47:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD3DF2948;
        Thu,  8 Sep 2022 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662666444; x=1694202444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MUsBSYdZrGDDLmY/vas/7Tp0sb2czLOG1XqHZ+CD514=;
  b=NGB1UWUUBW2Mi2xrPGhiM67r9vpUM3bNax7LUR72XXBzabtW93bBK9zm
   gY2/PSCUoA5OqBSqA/n8gCN0Fu3+IN/sP7dfTc/TEEjHn6IvaikwisGj5
   +22QbLRWDYfapNtoaeRcqAoX5CnRzjYIr1f23un9x3uPhfia5u9NkHudC
   r4eZ0+0S8BTfsCwGo35+p8i+AOk6kpfkXMH9S1UWA7J6cPMfUu7E//cGl
   +pL3IX2IAC3uzICG4j3OpdhThV3PVUyl4lpOBB//KDgiu87oQIXQ3uzLI
   wsmxU271JbEw50ca09AHYQJAB4p+V3TsECRp83x07DXY69MboFvnYkrPw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="383601755"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="383601755"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 12:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683362420"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2022 12:47:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 12:47:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 12:47:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 12:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNWNAzUoF0SmRcYJon9VmuLcZarZzqYg70GsN2jvQX2IYnYQ/RVkDof+k0vgnGU7WTNzFgMVcJFXU2jNisBnYc7u4N49Lp9qWmCKndkItxqztk2d7sYlANwXMkHErVDTdrPsRsm819vGuaSRyMRa1D9PtQQTWBI+H71/pU5Ot25h0Cy6DxSibVrA81dG2Q2UPR5JeZRTtUy/fk/Doo2ZjGjS//KFK9VaNLyzfu/6kgY864DzRhucponoiSI+42qZDJ4jJzOrRVHvTP2Eq+OOLkr8fgSyupPJbEU4tF61P2ozb2dBaZDokN6/Zun2Nf8NXwVZUPEYG8JTFLvmBa9T9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkUsAzk+ugR8cGSdW19TwfTA4hhBwS/+GjI3er/tg0A=;
 b=RXEH0L4km/YafY2kKPbhH4gojxsRz87xs3DqGl1vvdcP8ee5aNUbW+K8rJXvpfntrGwYmEvw9SQzlE2xTi62QRqoawK56mpLh5VHK/weCfCPvFwOrwiWkuIIp7KvdjKL+DtzoxtIKbhNpWYracFt8IOZRNU2ut/WD86aQNYz1793ePJPJMHuT/TlMyeKOIJeiJ/gbOGw7SM33fZQ7YKNHIy5CiZWe2gmwAuIwj+m/zqFhDwhQeHjgrhAiBBcpdqA5qWfEwhWDgPOsGZVY2Ed+0KtnbGLLoeis9ix8XLYUVH5W9AXBh2wdLAwjEokEsZ2mGK2ubYlvXwf24PjzYXlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW5PR11MB5858.namprd11.prod.outlook.com
 (2603:10b6:303:193::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 19:47:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 19:47:07 +0000
Date:   Thu, 8 Sep 2022 12:47:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/15] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <631a46b8a9e4f_166f294c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-2-rrichter@amd.com>
 <63198120f143a_58016294a0@dwillia2-xfh.jf.intel.com.notmuch>
 <YxoBeJ4p/5oTSqrG@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxoBeJ4p/5oTSqrG@rric.localdomain>
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f7b03fd-8cc9-4201-0888-08da91d2e9ba
X-MS-TrafficTypeDiagnostic: MW5PR11MB5858:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/ovxFC05dhkflu6uC6j70O5XPXCq4TS+texck/xlSERfXPELQDktn4uHX2zZ4pp9SqciI7U4XE80jx38oV6CAA8PZpNoF2eVYM5East5CXyusWmdi1Vx82U2u+YOOgHkjmsvFU9ce2TGWNkxRTv6lJC4GkM0BnpAGp4OqWWD5fiYD8ML+aOP+22brGyAPNOErgskQTzc2j+hjKpv8pwiEp2zXhQ7z/3bvFQUnjiVJ0GPOcqmrR0YcmKd02k31K3T2GBLddKQp+jKhoyZGO8gMqmARJgdlngqA8Wx2gE9l0zqj6KLnNBMDEVeZg26MtOvHO0OgNlGX5r8TcnQF/3oH4LguJMCdzZSfHWhUY5ToCAf/iNvhY5B7N7SyHdzJbarNqnURS9/UrSQJQ48FEwrFA1PnrfN1QNHI50KEku7+UvgU7H581C+uRmrxm3eWhKqNQyi7A976bQC0LCml/y1+SFSog+mWhqG0t9DQUVMpytgM9qbGqHWDiQWwqoyVcf8/7JFUTxoTJoIh1QLzHlHRRnLgNV7rOAm6LVI1arUjWnGfi01WnixaJCKZCaEf/C0Tmh6p5SNJXZXZ7LTQdtOlFqT3SkK7/IjHUAEQwnTZKpyXmhmOP5+BrmjytyhI/p7T+pPmOdNLPwDk2iQxkLwsVJF0WkPX5FY88GKDNlVJEhjo0hB7s2IwAndtbd/GpQF0tcJeehJy9yvdyb1oOPMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(86362001)(6666004)(53546011)(8676002)(83380400001)(9686003)(2906002)(6506007)(4326008)(6512007)(26005)(4744005)(38100700002)(41300700001)(66556008)(8936002)(186003)(478600001)(5660300002)(110136005)(54906003)(66946007)(6486002)(82960400001)(316002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nZcy8Gq3mq3x7zoflV3asK+X8WhxlRWKTvfm/uQlPZ4VKz57wK86znXBDz6m?=
 =?us-ascii?Q?0K4RA0Hbix1t++wSty5JvUg9Ym6QiI74wxUurXDDKENtIYdB0/EWWl0ITF6c?=
 =?us-ascii?Q?tE+IIsSRg+LmMG3Wf/YdPMaDKNJA6YpTpIrNHgYttgWag7YJsyhDwxH/uaGa?=
 =?us-ascii?Q?KKFeVi2VvlhgzkXGzHdcis0QR1bMilEhEz+CdRwVedANflml6EmuRyMTA4uK?=
 =?us-ascii?Q?NTHXp1Jsp29oFuiwLu+qc0nAD+C2WhdwqlL0PEMcKM9qLKoJs+DEwEixQ6ni?=
 =?us-ascii?Q?PLoRJinyKm7SKlB+nfCK+QxSrFMR82qD7PatlhQ7DFrSc63n5udxsMS3w4VM?=
 =?us-ascii?Q?Bl2jEZ++OSh9jyo7BPsEySHdtb6a5m8zGci53XWn72emSc6NjXomk58GtR+n?=
 =?us-ascii?Q?ZqPv5VgTtvDkLc+WSegq0OwrEkAGNrYqxMkjW1ubYXZezWFSYjbd0jwFQLM7?=
 =?us-ascii?Q?jjkVY+5kVS/Njv+9wRcKyOpO09gN19iSkymzTzp4Q4XcgojWQeFJBV7+4XrL?=
 =?us-ascii?Q?26nViHy14dSVBDSi7LePPS3/ZxyNzCGZjD6q9is+FTgjWg7W6FUnc+bX7XYi?=
 =?us-ascii?Q?w/ewtijYR5hBAGJFHu0pZoFQyuh6dngbY76GlUNO3MGuEuWhOc+o2s2AwMmo?=
 =?us-ascii?Q?361S4UMsNh/9KQQIfinqeQ1wfwT1PClE/5Vhqh3Wty2h69xGKgoYp0g9LriC?=
 =?us-ascii?Q?5oUiPlhn2WoN7PW501IeZp87YYyGYbpGVaomwvbN37QWlyFSvWGsdMIni/nn?=
 =?us-ascii?Q?2HVqZe4TyRgsxvePlXnz4SX6FBfbotftgwBAS6QZap5UBEfzja4ZZsKoSV19?=
 =?us-ascii?Q?34gT8T4BYxLyMXQjWqgLNAzBUpUXXYmSp8i70ZehIhxflT0S0GtOxCuPup4r?=
 =?us-ascii?Q?G0gvmv33/s+plxxKzrsuGo5/Dhsm7R/Rd/uiASe1Goa7dw1qYJyWqUwMP3n/?=
 =?us-ascii?Q?baPCLAuNfbJJeWdOycfxIhA/BpWud7L+E2wDPrsm6xnVhLnfEn9GRyBD08AN?=
 =?us-ascii?Q?UMwgSEAjOBkYMq/RY2mmQOzarfzlUZOnDcQjoQPV+CYADO8hzaxcthqITurW?=
 =?us-ascii?Q?naRxufzMjU3UvlHLcMGYL8xF8j7bmWIqEVof0IUsONF4VlYKUxGpnt5yr9W8?=
 =?us-ascii?Q?g4GX9wpIpsRn46zfbtVW6i5iIvI/AwXGzYUW3alJrmHUtLo9QC6ESEthk5Nq?=
 =?us-ascii?Q?QzeXIs2DiZg08X+pSP2e0AYucS5vLNNaHZVwbaECF28Mejx3S27R5RjiN5w0?=
 =?us-ascii?Q?ysylPKIaDEU4/g240TYdttBGXp6JEt+c3Y/F6/VP1CLTfIP7XrwRhkatdCBv?=
 =?us-ascii?Q?Iw7lXXfh0Lyk9z6i0VfH2m3JFsUFY/budf1CYZxBq6a4tbtbJsRoeRO1Vc0L?=
 =?us-ascii?Q?rWHI/K0SguuQAc0GI98UwcSkTIqwz6Rv5m9BiNXRNh8jAq/9L1E+G9NmsMCo?=
 =?us-ascii?Q?he0AlNG+aS1JHARWKX2Q1Z2EcMcqeRCgpRfjTvgCPscJOy2lk3JafKYgmmK8?=
 =?us-ascii?Q?PF/Ngk+oQxUdkG4ELsP5c8DRpJ5oIFhHx3ZRG4cDWtj9ZbdNzpJJMJ4TCRxY?=
 =?us-ascii?Q?KNa9EZqifcordIFb1wdixXTl4fL/MxaaNEL6lbzl+ptee3ak2pqcPFnuM1cy?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7b03fd-8cc9-4201-0888-08da91d2e9ba
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:47:07.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4oPRsfbYKquF1qQz9Q2jeXzep1WPMiF98ApBPfaDxYxna8nuijrwZ9K0owe0bEDlxakY6vY5u3gjaROFdsu2O9AMJ2MoIdjlqCrJMuhz5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
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

Robert Richter wrote:
> On 07.09.22 22:44:01, Dan Williams wrote:
> > Robert Richter wrote:
> > > The function devm_cxl_iomap_block() is only used in the core
> > > code. There are two declarations in header files of it, in
> > > drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
> > > declaration in drivers/cxl/cxl.h.
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > 
> > Looks good,
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Note there was a 0day build error. So I will add the inclusion of
> "core.h" to core/regs.c to this patch. I hope that is ok.

Yes, for my Reviewed-by: small fixups that don't touch the core theme of
the patch are ok.
