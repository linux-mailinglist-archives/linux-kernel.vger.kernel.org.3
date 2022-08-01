Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B7586405
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiHAGWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiHAGWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:22:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378C14015
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659334922; x=1690870922;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jRvsYrNwlbPt2ZsaF0ogctwAiQpOfMgZC9HEro65p+0=;
  b=b3uY8ybU9K6CBgh/THx7QyryujrMmuYR4HiTshBdFf/MYBoPBVrRdP4j
   UWB7zkLEM2wMp0YyRuSj3x+iJcpr1jEPQSjIYgdTpumApNdsLKa48UmFd
   pFGgAjYaZUwSKLdi55xQoVZfvYMMoR4ii4dpDz62tSsusayQO47qK37BH
   NHK2qJC0KJ7BZnUh2YYhA2DxEzKK0bw9BA57fqHL8lo/VLCrT8WpiJHIe
   MCozQUw8VO2LwHgECxgQx0DHwOQZjl1CbtkXvgVEGG6V/HfctUPxE6Akp
   U8KJCS1yJ7uuArCiBqWk6SjLbSkrHivAgKsHTfRvO91yYqZqLxgUG+mea
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="269454012"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="269454012"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 23:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577667785"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 23:22:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 23:22:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 23:22:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 23:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCGH9l+q68bmsf/glGsSHoU3hb5q87eM+1Kx6Ve5AucdYXRFVkKnyEI7cjCP6JRSe0mwhtICWUJdBVffr3pTa9ifmulhhnfunKqd+CbE5+4KeFMyEmTEwgpT06aSiC83Rkk6i14Wzh+iFLjGxwehW7SQLLJd2bXpDe9wWQA+9rr/76yfDL/vzCeN0/l8mPu9KvAH9+6NzWAXiRYy2r5bJi+guXzW3s+H18nTov69qovn6Z60arR+Y/55NoM+Cid2mVVofbw5mAIaDSIfcBCPOxmebulsp4lB+zMk/PCps/FEx20Bh5W3sqmKsRaaIRfZetzu7tflyTui4S6GfKd90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ORrpUQfxP3i4qb9oRb97nmERA7C5jGkzjaRjcsHSJY=;
 b=KvbCUXOvtqShrZ5mab+I5SVP1pRUC9CWHdDCPfNNhqkIG986i6YnabNsxAq/wXwI7QO2UV0JbQi20hKbWWbG09cJ1D0yPHdi10URrNuWRqkXZlgaxDj5yY0zeWE1WFEe8j9CzvI4GkvcbKEB5AQfkMPuH344OpURJtAj2L/agkq93mYBvF4g5I6ZSjp0cK2ntC+VgkpsX4pYt6+W+3oQMAbwTajiRLQu0xFIY9K5/QXg3QyKCUBhyujelT3WkUUVkfl3Li7o6/xufzshrG53SUpfaK0D+fUilfjWwSOUDF+Lw84wLmZkGwu2VRlK3gV5Lzy57qhIwLMKA6tFD3JQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MWHPR1101MB2301.namprd11.prod.outlook.com (2603:10b6:301:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 06:21:58 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Mon, 1 Aug 2022
 06:21:58 +0000
Date:   Mon, 1 Aug 2022 14:21:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     lkp <lkp@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <kasan-dev@googlegroups.com>
Subject: Re: [mm/slub]  3616799128:
 BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
Message-ID: <Yudw5ge/lJ26Hksk@feng-skl>
References: <20220727071042.8796-4-feng.tang@intel.com>
 <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YuY6Wc39DbL3YmGi@feng-skl>
X-ClientProxiedBy: KU1PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:802:18::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69363f81-e60b-4e02-e2d0-08da7386238d
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2301:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iia5pXKg4WJJzGUpYnGDQYT+g6HKvAbHS5HfKgNXOyomqNZG3KW8ZzPqDKGPEpt/eYuN6891DF9fiHl3q+cWcwV5AghFLrLunAzAdArp8TpxiAxqk9USzUUocRddJsl9SOO6HwE8v2nbXtYlFroei330KoMT9olZk+neJ7IouIUtYMhD3RWRgK7y1IlaYj+TjgBtBpHeCAO9C6bjhb0OCPIbJAzTimb1/Ey4jM6hU1slUonftqleMfnucY354xOWXujH0xcpU5XS/juLueuKlCYqVgg34T/f2PeBSEqv6eTyTPnL9xxjkUmIvZ11p/+8neEfpIQHwm/g9F6OI/OZ0f2JgppexOYPptm2hWIbAqRhWoinwi24CARJxMGNeddWCg1M/adEdGfIY1OhmCAjTGYy2xOdo0FF6OLN1V+EX/H1CesEPDBL72cjPGmzf6h7GjEDKP0kh2AF1HK49UFyQELtiE1tj2c4SaCDxcm6CXoQfMPM2THtFrZAzq+MhtbMtZz+4n17kaY4A+YitNlPe2hEkx//xNr7/amz+4bAZ5IKjpwcyjSHlC2/GwUmw27SCVjcFK61ljii+WNDR8/cMypl/RcTVLon9mJeTlS16MFbZ14Az4sXsybfySoZE0f8jPggVG6RDWpj3k8nPCHnDpTUnGZdgRHg+G/W2hgPHHNpe5rkJlwOyGlQavqW/jQ8V5ahP3JW07OoIEGYaozeJmjo+xBTWnULs4wUPnuDrUOHoDolgscPZ27Brju7bIVMyBqRLl10PGL2XFxaomp0u/mewZLZCepRkCYEwa9i4NDZ49OOouowP0zTPiVS9Kro
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(136003)(396003)(376002)(39860400002)(44832011)(966005)(6486002)(7416002)(478600001)(316002)(83380400001)(2906002)(66556008)(66946007)(110136005)(54906003)(41300700001)(5660300002)(8936002)(66476007)(8676002)(4326008)(6512007)(9686003)(33716001)(86362001)(6666004)(26005)(6506007)(82960400001)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m768fNXLHGvXQYum8S0gIFKoY94EOUd0lD2mVR+8WOF70i+ejlR2lopHweZR?=
 =?us-ascii?Q?FkCZ/HpRzuaUe4mw77hDjFSWm9nZ8h2XcjDBUawyAvfLDVstOcz4rKPOVYm2?=
 =?us-ascii?Q?Ge7aBt7QmQw8PcVjJ3d8cY7c23Lo/uf+VeNr/uUWw8SAGePqv/DEtbJhe1U9?=
 =?us-ascii?Q?Onf8hQUwX7qvuKpcrEMPxSDtkmgsFI+SlKFTdprK6OTEuugieCWNc49aoIj7?=
 =?us-ascii?Q?2MbaER+R/OB4mvfe7FZT6jWXvtO0PiZlHEvivFTCMa+t9zMWIn98Aj6+Lmt7?=
 =?us-ascii?Q?jtGSG5y3rrctr59Lx5pBBw6xwm/HmIWhbUPgG/QkIGo/XZM0tPNsEW5VC6Gf?=
 =?us-ascii?Q?iKQDhT1QXZvh/lQ4GgNILmXZf9/x5NgNHoDGYeU2CYhfsXbY7U2GFZrHtV9h?=
 =?us-ascii?Q?rHfgbZ1H+yf8lCVqTek4T0VMEZhCphBU1oQqQhqmac4/k006qRmtBRFn7y+2?=
 =?us-ascii?Q?8AamPnG37llnBrkSv2R6zKWGwUu2wOCsbL3yMr94LfPnHCVnsZW1RmS90H5O?=
 =?us-ascii?Q?tobvKH74y2T3nCs+wgsD6g1rUbXw4/z5H9i3pNCsyMOd47Ab9eqwXcLDIMtM?=
 =?us-ascii?Q?eqRqLzaqrFpqVJkoLO3oa21uzw0Sj7ZBqc/OmTy6NXMhH2hIHSu81LWc2/aj?=
 =?us-ascii?Q?21l9QqDrd6Qf0c1VzoNn1bT6JjoSvu+qenFoVJHvAeR63t1OxFsuUepGKIdp?=
 =?us-ascii?Q?8H1eRKVFaFnMMNPfNr+OxIGpaefZCtQ4ZTkGmTI+fBYufViExg23axPyox9X?=
 =?us-ascii?Q?uoB4ql23quMPPKFdijech3YiTkYVzogq2Y182mzAAhVDqhdri1f/btlrHZrU?=
 =?us-ascii?Q?qktUJDUAPEqy0T63DE69a4VumxClINye9M7d4289W1Ek7OpJgU67Wrvp7/I0?=
 =?us-ascii?Q?jzxwUWKfLcl7Gg9ceEx4/KcBYFkOlbQBZ9NFZlPSf1665QxqCDPyZ9xiX2wb?=
 =?us-ascii?Q?jpBpwstt4VuMtc0Y5+/WRyNF8ldlunEz8i/HL/O8dWgkHRN7AowkwjzBqrek?=
 =?us-ascii?Q?CIiA3Mea2x1Y2KYPhP2wr1TzvfwmpxFdAXARGybul4Qz4bW3C64UbXmJXz7H?=
 =?us-ascii?Q?daIHWA3BC0CgmwVLyy46gsTk1v5G5mjmInE2A8/r/1YCFbqPV7NW8pRA3HL3?=
 =?us-ascii?Q?z3rY7//Pumf+4qiKei0FdxCibiFwm0l5PBBvjDYxvldxBb3r0nq0wWNH5qmd?=
 =?us-ascii?Q?coDKcOr8Z4FI4F5ePW286u9+W7tqckhoWFJbZ12eFRiC+v3ixWD9Z3KZskdm?=
 =?us-ascii?Q?/PhymkQjdjknXHmc9EzOQOShiPfPrm5Thsr5Cucc/nGuiFJtigOnGM91X/62?=
 =?us-ascii?Q?gWsz/fKD9DuQJp7gYXytxROIBX1N/r8mGKNr27AhGUPUCBb20iWO2Oc/RPmV?=
 =?us-ascii?Q?H99zPGNXwD2kNYs5G9Dk8B7a5v1RH1z8a67VA3BM1t5R8BvaK7XQgsXKFXQB?=
 =?us-ascii?Q?AAnAzdg2rp+AKvCaM8GmD6i1klMC1HoASPldU3t3wHi1mifrS9yHNxQLhXEt?=
 =?us-ascii?Q?SL8v3gb8RjW9Ikhq8LghL0A33M127vC7nOo9N49lzsuk0MqbxF1jPgfDSe9P?=
 =?us-ascii?Q?u5EiKc6fNyQdDYJjz+YRmZg1j86/6jKrv93DNyV2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69363f81-e60b-4e02-e2d0-08da7386238d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 06:21:58.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOp3uuvxlj/yitGcG3eD0yvUwQ/MxKAz/jSKggk+Iuah61Nlx4sNLb5sTqWlaBwC0yW1N9fO+QA65fvT1bCWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 04:16:53PM +0800, Tang, Feng wrote:
> Hi Oliver,
> 
> On Sun, Jul 31, 2022 at 02:53:17PM +0800, Sang, Oliver wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-11):
> > 
> > commit: 3616799128612e04ed919579e2c7b0dccf6bcb00 ("[PATCH v3 3/3] mm/slub: extend redzone check to cover extra allocated kmalloc space than requested")
> > url: https://github.com/intel-lab-lkp/linux/commits/Feng-Tang/mm-slub-some-debug-enhancements/20220727-151318
> > base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
> > patch link: https://lore.kernel.org/linux-mm/20220727071042.8796-4-feng.tang@intel.com
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > [   50.637839][  T154] =============================================================================
> > [   50.639937][  T154] BUG kmalloc-16 (Not tainted): kmalloc Redzone overwritten
> > [   50.641291][  T154] -----------------------------------------------------------------------------
> > [   50.641291][  T154]
> > [   50.643617][  T154] 0xffff88810018464c-0xffff88810018464f @offset=1612. First byte 0x7 instead of 0xcc
> > [   50.645311][  T154] Allocated in __sdt_alloc+0x258/0x457 age=14287 cpu=0 pid=1
> > [   50.646584][  T154]  ___slab_alloc+0x52b/0x5b6
> > [   50.647411][  T154]  __slab_alloc+0x1a/0x22
> > [   50.648374][  T154]  __kmalloc_node+0x10c/0x1e1
> > [   50.649237][  T154]  __sdt_alloc+0x258/0x457
> > [   50.650060][  T154]  build_sched_domains+0xae/0x10e8
> > [   50.650981][  T154]  sched_init_smp+0x30/0xa5
> > [   50.651805][  T154]  kernel_init_freeable+0x1c6/0x23b
> > [   50.652767][  T154]  kernel_init+0x14/0x127
> > [   50.653594][  T154]  ret_from_fork+0x1f/0x30
> > [   50.654414][  T154] Slab 0xffffea0004006100 objects=28 used=28 fp=0x0000000000000000 flags=0x1fffc0000000201(locked|slab|node=0|zone=1|lastcpupid=0x3fff)
> > [   50.656866][  T154] Object 0xffff888100184640 @offset=1600 fp=0xffff888100184520
> > [   50.656866][  T154]
> > [   50.658410][  T154] Redzone  ffff888100184630: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > [   50.660047][  T154] Object   ffff888100184640: 00 32 80 00 81 88 ff ff 01 00 00 00 07 00 80 8a  .2..............
> > [   50.661837][  T154] Redzone  ffff888100184650: cc cc cc cc cc cc cc cc                          ........
> > [   50.663454][  T154] Padding  ffff8881001846b4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
> > [   50.665225][  T154] CPU: 0 PID: 154 Comm: systemd-udevd Not tainted 5.19.0-rc5-00010-g361679912861 #1
> > [   50.666861][  T154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > [   50.668694][  T154] Call Trace:
> > [   50.669331][  T154]  <TASK>
> > [   50.669832][  T154]  dump_stack_lvl+0x57/0x7d
> > [   50.670601][  T154]  check_bytes_and_report+0xca/0xfe
> > [   50.671436][  T154]  check_object+0xdc/0x24d
> > [   50.672163][  T154]  free_debug_processing+0x98/0x210
> > [   50.673904][  T154]  __slab_free+0x46/0x198
> > [   50.675746][  T154]  qlist_free_all+0xae/0xde
> > [   50.676552][  T154]  kasan_quarantine_reduce+0x10d/0x145
> > [   50.677507][  T154]  __kasan_slab_alloc+0x1c/0x5a
> > [   50.678327][  T154]  slab_post_alloc_hook+0x5a/0xa2
> > [   50.680069][  T154]  kmem_cache_alloc+0x102/0x135
> > [   50.680938][  T154]  getname_flags+0x4b/0x314
> > [   50.681781][  T154]  do_sys_openat2+0x7a/0x15c
> > [   50.706848][  T154] Disabling lock debugging due to kernel taint
> > [   50.707913][  T154] FIX kmalloc-16: Restoring kmalloc Redzone 0xffff88810018464c-0xffff88810018464f=0xcc
> 
> Thanks for the report!
> 
> From the log it happened when kasan is enabled, and my first guess is
> the data processing from kmalloc redzone handling had some conflict
> with kasan's in allocation path (though I tested some kernel config
> with KASAN enabled)
> 
> Will study more about kasan and reproduce/debug this. thanks

Cc kansan  mail list.

This is really related with KASAN debug, that in free path, some
kmalloc redzone ([orig_size+1, object_size]) area is written by
kasan to save free meta info.

The callstack is:

  kfree
    slab_free
      slab_free_freelist_hook
          slab_free_hook
            __kasan_slab_free
              ____kasan_slab_free
                kasan_set_free_info
                  kasan_set_track    

And this issue only happens with "kmalloc-16" slab. Kasan has 2
tracks: alloc_track and free_track, for x86_64 test platform, most
of the slabs will reserve space for alloc_track, and reuse the
'object' area for free_track.  The kasan free_track is 16 bytes
large, that it will occupy the whole 'kmalloc-16's object area,
so when kmalloc-redzone is enabled by this patch, the 'overwritten'
error is triggered.

But it won't hurt other kmalloc slabs, as kasan's free meta won't
conflict with kmalloc-redzone which stay in the latter part of
kmalloc area.

So the solution I can think of is:
* skip the kmalloc-redzone for kmalloc-16 only, or
* skip kmalloc-redzone if kasan is enabled, or
* let kasan reserve the free meta (16 bytes) outside of object
  just like for alloc meta

I don't have way to test kasan's SW/HW tag configuration, which
is only enabled on arm64 now. And I don't know if there will
also be some conflict.

Thanks,
Feng

