Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4C5758ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiGOA6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGOA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:58:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB41AD97
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657846719; x=1689382719;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=92mtqkj8ilvAK4rNb/NSrD6vV0lcCipPf/sTUd5Ds9Y=;
  b=VUKfHy3HXZ1RNYKJ4hte2R3jr7+/n96I7sAqwLRUEjNbL2I8k8x2c0Wa
   CeFngiXVXzvWShKYmGsaUWLgXa+6XelhW1AVB4Fl54PyKwp33BXIlqbdM
   108qcThRix8HI7Fg/sjdWQGJPDxzEWQX1LflBjLA+Gd4ekZNgRSE6cL4G
   KnixODED2kuU26021mApBfxEIT474cbtvfGYAtTcDesYj1/SX/wsGdK9p
   swGb6wB5cy1yzvcMreNdkbGRUmDWU5i1UEQEGW9oExtoOBCgr/oTVMn16
   KaV5Vj9YSosRkyv+bHNfwOcGguA4qnxJBFbPnk695RynXLIiR3716GFYW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265460085"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265460085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663999882"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 17:58:39 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 17:58:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 17:58:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 17:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnyuXY5GJGyXtvrQiJnagWORBbF/jYMhpF11+SciBBxXuAhNVD226fIvzLeBwNVImz8Jbixatdhryuddorjz7GgT9YeZx5/44eF5IGe4gGnB4BVuuWyND3HB5ZT82qPXAijGaznbtCaJd4WsKszXhIfSjkOM7uAq8TiesfAOInGLj2sPWzWTIvXzN/KGG32nIi4Y/VsA1LqY15z5pW7GuKSk8zJt2zkGJ+PE7hrddoGdx3CQFRbUUe+hJCT3y1bVvsVD/5CtO4kD4BC1SZ3uL51UoGdqXADQGj7jwZqYIUZsPAkx3GeFFQY8WeU5e7PmQVpn/MjUOlx/KR0u8tQXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97hKqWq+t8klp1gztVqZ1XFRXmvUxq2yXLMOHvqYbrQ=;
 b=SkjeoqmsoIMDb2ex5PuSMJD7QxPtqQNmtJahzjq10NuoI0XJZPmfREOROKa9lYTUzTmTMGBW6UMyAIBGgZ86s8dpp1WQ3IFryeH8krL+kCwTom2Ly2Cs0jFCBy02OBLLvaUru+7KKaF0y2mFvKaPY8PK6H1bW25Qx4zWYGSaNuM98V3NgmpE4PuEB1Fglcw0vuaiQH/qNsDMEjTCYD6AhC9AhP9MeI/DaG/ZpZh41flQuBU7D6hWpgBaqA+09YrsanPxZ6kzuQUuX6V84X5bmmbNYd8U8eE/3vBYQcOcjqn2P/+OwnpGecn8bpS8ZJI2zvFML03iAZIb8UQJyyaGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2753.namprd11.prod.outlook.com
 (2603:10b6:406:b0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 00:58:28 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Fri, 15 Jul
 2022 00:58:28 +0000
Date:   Thu, 14 Jul 2022 17:58:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: badrange report spill over to clean range
Message-ID: <62d0bbb19ed1f_1643dc294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
 <62cf622a32e1_16b52e294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae6e33a0-20f5-4504-2f89-08da65fd20c0
X-MS-TrafficTypeDiagnostic: BN7PR11MB2753:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKnzCUvgurK0sQX5liwfcM6Ad+0E8kuyKzYFeAuXiziVXT7dFRIUJkvw34oVYmkBbjMtRwAivjPfTI+/r+V+4pItTk6Ea3jt67Ry0w4czsvcGKE04rEeKoncftHDWlz/e5CHadDNUx1/pjCaNcKvf38dP3XOhzMYYOJ5a59c68KU6WVzrgk5P5GItPj0nFjl7pV5cixcVMBICje2nSp1iBmKfs/nfluIbr5bdJ0ViE49eafwttCIkXxqufB32ezTgQIbxtVfua1IqUJXKqAvJRZsJTT8st9tn9i4wrv7619+xLQ6Roob7TXLYYRdvJqnDjmpeEBYjndb8IknQ91iws528djwjxs4cEb2n8fl2sidsFxPnzrbTnAhkFn8VMjtkwXD0qBOtPSUvbMjqrIQvzEY2sMOU+/IVqzl/cqR/t59XUVZ7FwiCVQiXcwB34pBJaCLHJazRrvlOmwXEOnDNzEOyLzD7yD49XR5cDQV588GBnw8XS/3w7kxThRtwrgeqsNCO6S2oBGLVG0CHTw48Y2LWvw+v27q/fEJLwtof/mxB1RULWrp++pLwsD2Dh4G++Wxyp58MoCR7fs96icDSvgVOzDxpyU9vJLGk5QRYVLfhQizNjC7GfLboDh2LY+14gt9HkOzWLlwJORdJJfxEoitf2gCDHB2JU4kcBPVKXMK8XCtjU7/sNQZCyc2L1lRHzwD8HogOnMJbAVm56QyYmdFy9HxBnUxPlLcsuObKEcG8fWsRwuFzUE/sWrO7aJEJE7KmJvmyjkxZCA/NxfUr/F6daSPENQ6bRb+kt2WcKNyq02RyArO3ctI+km5I3O9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(366004)(136003)(39860400002)(8676002)(316002)(38100700002)(8936002)(478600001)(83380400001)(5660300002)(110136005)(41300700001)(6512007)(2906002)(82960400001)(66476007)(9686003)(66556008)(53546011)(6506007)(186003)(86362001)(6666004)(66946007)(26005)(6486002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikgk3qkrhB2ieK2occVSLAt/C6wMbP3C2DTa/73hmbfbklSdTJxA+CchoLOh?=
 =?us-ascii?Q?c22hvZwHvlAdX9B1/muR9kqV1uxwyUFFE4QVvt+38hblFQwKImaO/qvDfXxs?=
 =?us-ascii?Q?fn07p3qD+1cekcATrvtAM9IerpLQzZexA65CHfYmVtmbd48Our8mKcDnykSj?=
 =?us-ascii?Q?wS33FXrU/9e8k9m02Y20Aw4MqFmCnTj9fXbgsXRx8HZw0PE9R30W5DiphULF?=
 =?us-ascii?Q?KxH3QQkHX9vVyuOhaXphOl54Rlzh2JpvRbz0qsobuTNdcOmLJXVnXCFvnjAx?=
 =?us-ascii?Q?ng4KQwW1nV4AzeHeGXlt7MZmqnsGzst6TbMmATpFumiCso5Wk1T35M0XsCEZ?=
 =?us-ascii?Q?9Dq6FaoQKykPxwB1alvEbLELkNdEptRWBcgkcg4j3bRe99kgdBwjvGHyQltn?=
 =?us-ascii?Q?d7WSq2v16hWpWvGZSRS9IChP2xazeOtHR41Jqjb14DoJzy/rFKfn+ba6RQ2I?=
 =?us-ascii?Q?+7mNgn+g1u4UGGQgFHNd0sC+oQNqMCHl8oruUvlcKmMoYi0NuqGg6bJDTqLm?=
 =?us-ascii?Q?t024V1AVnGo1S601HB018ZP+WqskSLpPTLVb3UL55RNJaNhQ+8Fw3s3Msx2L?=
 =?us-ascii?Q?RIIVdc+qA2YY9dn4f2nMiLagCkF5I/KWlqN0uSc5ZzNWhcdqUFwF/4PpH3TC?=
 =?us-ascii?Q?dYCOtGrIlhwugQcuz1ou48PHLccPNn2QZk2KdasAO01sqM9dxJw+vIWrEnRp?=
 =?us-ascii?Q?Rew34lObUtuYzEE8xygmpLyZGdzxi7SPOhBqZh581smqWUb02Po6DA9jj+yO?=
 =?us-ascii?Q?NjuOtB3Cd4fgovpZieKfNmuZYmmVfBEKD5S7Idkx32wzMNoDJniIFjqM66j1?=
 =?us-ascii?Q?BMGjv+6/sLvMBm6vw7rvB/0gBs01JKYKabzWItuHENmt5YU2wAt20TY4vI9h?=
 =?us-ascii?Q?zx1zXjXgc+AfL7ldt1c2QrIF1WxNvgcLoubwrADbP/McD7E3+T+nBAI3o7wU?=
 =?us-ascii?Q?c6TuWclPKFdatv/X0RHkKMjwpMd0LYChYvIPL7GZXv2ztIDg/bfbi17vsH0I?=
 =?us-ascii?Q?XeAe51I8V6rGk1O0Fp3v1TOuNzB5udzIgP9CgH/bTf/9A1C7dSzB1t3JDAGp?=
 =?us-ascii?Q?qhxP5cFsnr0z6q7WtNsf90mFV3fUNkOljI+oNsUsk8ev8IZDzQ+9adJJPN7m?=
 =?us-ascii?Q?YhNF1NdWsDnwOJRiRdtlHbpqGd/dhcHfVMShuKHIqcjtIh3uTpixf1hf7bm7?=
 =?us-ascii?Q?/cQrgvXhw/BJ5ShKLZ9QhVoZTgIeVIMS0UH4hTcDMoCnKL/1Pu8C+rT+/GtA?=
 =?us-ascii?Q?nLzTcnaGgasQaZVYLRlUzwnEgle7A7XWXWlKnDO/l+GoL+oH+qSsimCU165s?=
 =?us-ascii?Q?gHb3ys2HPE1r9tF9ZFY93eFq6b9Nd6glnSL8CHI5EnKVJpjeMcdd8o1WtAce?=
 =?us-ascii?Q?H43B355oaBm49gVzcVBpriKeeMB7monZywqoXDPAdSPatpFIC0zW9epGImGC?=
 =?us-ascii?Q?5aW5rFqXjVjWyl8AOxXfNeQrYd3ZgGvQfVHg/D9Uy8X/tV9WVr0ThyzsAT4Q?=
 =?us-ascii?Q?a18pttYXkPy5lbhpligXP4vfpxTzyzD6c3cTJeuPLbnGbe08jT9Xo9vhkipX?=
 =?us-ascii?Q?jsyHek7nQzjdHbQhwiEpu+Po++JlgW/ewq8HJCVG9fr+MO+MEBVpSkFgGvL1?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6e33a0-20f5-4504-2f89-08da65fd20c0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 00:58:27.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1FzEAWbOGXKYLxZYdps6G35XTprbGciFQBQKzyDlkjvrTjd5QK9xQqbz6WHbr5cSfLuGHZCCtn2GErk3ZUSSl+ITerFbXJ41QT9iLyEQuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jane Chu wrote:
> On 7/13/2022 5:24 PM, Dan Williams wrote:
> > Jane Chu wrote:
> >> On 7/12/2022 5:48 PM, Dan Williams wrote:
> >>> Jane Chu wrote:
> >>>> Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine poison
> >>>> granularity") changed nfit_handle_mce() callback to report badrange for
> >>>> each poison at an alignment indicated by 1ULL << MCI_MISC_ADDR_LSB(mce->misc)
> >>>> instead of the hardcoded L1_CACHE_BYTES. However recently on a server
> >>>> populated with Intel DCPMEM v2 dimms, it appears that
> >>>> 1UL << MCI_MISC_ADDR_LSB(mce->misc) turns out is 4KiB, or 8 512-byte blocks.
> >>>> Consequently, injecting 2 back-to-back poisons via ndctl, and it reports
> >>>> 8 poisons.
> >>>>
> >>>> [29076.590281] {3}[Hardware Error]:   physical_address: 0x00000040a0602400
> >>>> [..]
> >>>> [29076.619447] Memory failure: 0x40a0602: recovery action for dax page: Recovered
> >>>> [29076.627519] mce: [Hardware Error]: Machine check events logged
> >>>> [29076.634033] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
> >>>> [29076.648805] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
> >>>> [..]
> >>>> [29078.634817] {4}[Hardware Error]:   physical_address: 0x00000040a0602600
> >>>> [..]
> >>>> [29079.595327] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
> >>>> [29079.610106] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
> >>>> [..]
> >>>> {
> >>>>     "dev":"namespace0.0",
> >>>>     "mode":"fsdax",
> >>>>     "map":"dev",
> >>>>     "size":33820770304,
> >>>>     "uuid":"a1b0f07f-747f-40a8-bcd4-de1560a1ef75",
> >>>>     "sector_size":512,
> >>>>     "align":2097152,
> >>>>     "blockdev":"pmem0",
> >>>>     "badblock_count":8,
> >>>>     "badblocks":[
> >>>>       {
> >>>>         "offset":8208,
> >>>>         "length":8,
> >>>>         "dimms":[
> >>>>           "nmem0"
> >>>>         ]
> >>>>       }
> >>>>     ]
> >>>> }
> >>>>
> >>>> So, 1UL << MCI_MISC_ADDR_LSB(mce->misc) is an unreliable indicator for poison
> >>>> radius and shouldn't be used.  More over, as each injected poison is being
> >>>> reported independently, any alignment under 512-byte appear works:
> >>>> L1_CACHE_BYTES (though inaccurate), or 256-bytes (as ars->length reports),
> >>>> or 512-byte.
> >>>>
> >>>> To get around this issue, 512-bytes is chosen as the alignment because
> >>>>     a. it happens to be the badblock granularity,
> >>>>     b. ndctl inject-error cannot inject more than one poison to a 512-byte block,
> >>>>     c. architecture agnostic
> >>>
> >>> I am failing to see the kernel bug? Yes, you injected less than 8
> >>> "badblocks" of poison and the hardware reported 8 blocks of poison, but
> >>> that's not the kernel's fault, that's the hardware. What happens when
> >>> hardware really does detect 8 blocks of consective poison and this
> >>> implementation decides to only record 1 at a time?
> >>
> >> In that case, there will be 8 reports of the poisons by APEI GHES,
> > 
> > Why would there be 8 reports for just one poison consumption event?
> 
> I meant to say there would be 8 calls to the nfit_handle_mce() callback,
> one call for each poison with accurate address.
> 
> Also, short ARS would find 2 poisons.
> 
> I attached the console output, my annotation is prefixed with "<==".
> 
> It is from these information I concluded that no poison will be missed
> in terms of reporting.
> 
> > 
> >> ARC scan will also report 8 poisons, each will get to be added to the
> >> bad range via nvdimm_bus_add_badrange(), so none of them will be missed.
> > 
> > Right, that's what I'm saying about the proposed change, trim the
> > reported poison by what is return from a "short" ARS. Recall that
> > short-ARS just reads from a staging buffer that the BIOS knows about, it
> > need not go all the way to hardware.
> 
> Okay, that confirms my understanding of your proposal. More below.
> 
> > 
> >> In the above 2 poison example, the poison in 0x00000040a0602400 and in
> >> 0x00000040a0602600 were separately reported.
> > 
> > Separately reported, each with a 4K alignment?
> 
> Yes,  and so twice nfit_handle_mce() call
> nvdimm_bus_add_badrange() with addr: 0x40a0602000, length: 0x1000
> complete overlap.
> 
> > 
> >>> It seems the fix you want is for the hardware to report the precise
> >>> error bounds and that 1UL << MCI_MISC_ADDR_LSB(mce->misc) does not have
> >>> that precision in this case.
> >>
> >> That field describes a 4K range even for a single poison, it confuses
> >> people unnecessarily.
> > 
> > I agree with you on the problem statement, it's the fix where I have
> > questions.
> > 
> >>> However, the ARS engine likely can return the precise error ranges so I
> >>> think the fix is to just use the address range indicated by 1UL <<
> >>> MCI_MISC_ADDR_LSB(mce->misc) to filter the results from a short ARS
> >>> scrub request to ask the device for the precise error list.
> >>
> >> You mean for nfit_handle_mce() callback to issue a short ARS per each
> >> poison report over a 4K range
> > 
> > Over a L1_CACHE_BYTES range...
> > 
> >> in order to decide the precise range as a workaround of the hardware
> >> issue?  if there are 8 poisoned detected, there will be 8 short ARS,
> >> sure we want to do that?
> > 
> > Seems ok to me, short ARS is meant to be cheap. I would hope there are
> > no latency concerns in this path.
> 
> Yeah, accumulated latency is the concern here.

An actual concern in practice? I.e. you see the round trip call to the
BIOS violating application latency concerns?

> I know the upstream user call stack has timeout for getting a response
> for certain database transaction.

I would expect that's on the order of seconds, no?

> And the test folks might inject dozens of back-to-back poisons to
> adjacent pages...

I am not sure the extreme scenarios of test folks should be guiding
kernel design, the interfaces need to make sense first, and then the
performance can be fixed up if kernel architecture causes practical
problems.

> > 
> >> also, for now, is it possible to log more than 1 poison per 512byte
> >> block?
> > 
> > For the badrange tracking, no. So this would just be a check to say
> > "Yes, CPU I see you think the whole 4K is gone, but lets double check
> > with more precise information for what gets placed in the badrange
> > tracking".
> 
> Okay, process-wise, this is what I am seeing -
> 
> - for each poison, nfit_handle_mce() issues a short ARS given (addr, 
> 64bytes)

Why would the short-ARS be performed over a 64-byte span when the MCE
reported a 4K aligned event?

> - and short ARS returns to say that's actually (addr, 256bytes),
> - and then nvdimm_bus_add_badrange() logs the poison in (addr, 512bytes) 
> anyway.

Right, I am reacting to the fact that the patch is picking 512 as an
arbtitrary blast radius. It's ok to expand the blast radius from
hardware when, for example, recording a 64-byte MCE in badrange which
only understands 512 byte records, but it's not ok to take a 4K MCE and
trim it to 512 bytes without asking hardware for a more precise report.

Recall that the NFIT driver supports platforms that may not offer ARS.
In that case the 4K MCE from the CPU is all that the driver gets and
there is no data source for a more precise answer.

So the ask is to avoid trimming the blast radius of MCE reports unless
and until a short-ARS says otherwise.

> The precise badrange from short ARS is lost in the process, given the
> time spent visiting the BIOS, what's the gain?

Generic support for not under-recording poison on platforms that do not
support ARS.

> Could we defer the precise badrange until there is consumer of the
> information?

Ideally the consumer is immediate and this precise information can make
it to the filesystem which might be able to make a better decision about
what data got clobbered.

See dax_notify_failure() infrastructure currently in linux-next that can
convey poison events to filesystems. That might be a path to start
tracking and reporting precise failure information to address the
constraints of the badrange implementation.
