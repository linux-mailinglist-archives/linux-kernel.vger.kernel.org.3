Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E92585E10
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGaIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:17:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427F11828
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659255431; x=1690791431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DZgUsB/B2P010VUIaQCWsZTzlBOeTuy5G/+QV39B/48=;
  b=jSuB+qAVH+p+GVkw8GhV+HWmJ+83iYx7WseaElbEBvlA9YHuH4yZ+xv3
   oufo0++4opYEbxgs2qOLf7zILuf2kn42dzaRSLiMTZEbSP1FZAXEc0x1j
   tUOFBqDi8MZU/a45BAjwjTgTyHky0V8emU7OH5V65MPOptTzyahSIwlwv
   2DPtfyC/cHxhLTBI9gXxQ74xykdOG6UL7opbWKuIiDMq5W5hEoN4+u9VU
   xjpolb2JqXa3cpNzctlgf8eiGRgwo7KgCm1x8t3H9lct6kPmPYV8MDivz
   6dFOvihNaDomYjut9DwfNQwElCYX1PVf94+6rMvvXaPQo3T+G5d5CXlX3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="268744197"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="268744197"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 01:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="691157077"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2022 01:17:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 01:17:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 01:17:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 01:17:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 01:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adzer+eZ6CvSaDNUMlaN5M+lc9IFhdWDXxdQdmJ6c/GuZll/ArF13keY5Jnoh4Y+7aa4UiTwgQ/CwRxlwbRaqD6VbyEgTPghIZum6St3WoBr8FzLnPC7hgu/BduJl3QY3d3qu5SoPSLRIKUDLNHVa1Zw6M3GTfGP8Pi0umlZkjr/WZdDZVT5/TcTB1khh/RhU9bYXIwV0Lb6cExVSN8fw4yKg4asonlXoiP5CA7R/E7C8mlBzjehGs3IJ1kT387OCdg3W0hi4Tvzs4gQS9XqIPP8mYqtfsRr3pGhIM1UYsTGIL0jEXd5FmE+GPKcuq1c/fiOgKoX4j+gO0X4Fz64pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy8LwAgwKQuOPArMCy7pko88Rrkea6Ft9NPp2jtwR4o=;
 b=i0Z0shvmqrZaexiSij7L/sGGxaqzD2QEAYe7YtAxVtsyCcgchVFP9OV40hXRTC22djUxqSvmml/BJBFerGuB2fdkw1FvI5XC3tbcUDeOWgZNQ0wH7HyfReBI4YDGvvQWiZP9ohHZfB+MP6vQqzbnbHZoGZAtk8SOr8sQACiIBI+Z4OKfTcUOoT7NooG+h9NfYqSdJMVFOhMNJsytn8J1GcEkgwl5QB8Zeg57IiKnE5iik1uD8lo+tQTTGITEz68H57tSiCZrZ9t/wfiS9BWnpi7os70PbsEmhszCneXsOa43VwQmc69Pb133JlP9XOaOte4khoubvpgGUKaha5SPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM6PR11MB3083.namprd11.prod.outlook.com (2603:10b6:5:65::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Sun, 31 Jul
 2022 08:16:54 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Sun, 31 Jul 2022
 08:16:54 +0000
Date:   Sun, 31 Jul 2022 16:16:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
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
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [mm/slub]  3616799128:
 BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
Message-ID: <YuY6Wc39DbL3YmGi@feng-skl>
References: <20220727071042.8796-4-feng.tang@intel.com>
 <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95b43ee-f771-4cf3-bf72-08da72cd06fe
X-MS-TrafficTypeDiagnostic: DM6PR11MB3083:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lC+VCJ7J+/Cs0ZMEhu51nOkZHBg3n5B7ABdnL5Es4U3HmFuZDfzyIFKhFQliloPPhVyrGJNdahIvH5kyvy+PgR0xyuaGMYwbaje0bUyfmKJLPTWvVGjxSbt9Oj6pKVLjn/B3VzCDOSjvdZpe/tNndzt1p7DbtJGf53M1MNlkhxIfZITY76VBOZRQsFOTxo4P0JFx/J/yXEx2v4yP0puuNaWR4yYz9i6CvN0B5eaFptmKP27R1pzzbXDCseX+ObN4Ezi5VNTN7MT2cybkyI9rJH4RB5Znw4STV60mJqRrEdqna47hVVQUxS3rdqBeSa6bbyFwgwKxKmpFdi2kAEfCxGpfhrOBd6YluCtIXOldy/WPC3tPi0j/+x8LG3okMm/8GI6MF7b0mD8IXtCsDf7fBwA2vd5WoCEgdMfO06sf4z/xe2UHu5buHUA2gCeFRL0VeIOGh2KBUCPcFHEh67opxvMNOpZ9dduxTNCZa/mz+ktN25IDVGp5codmdXyg5dHHWI0UKicTn56kLLi2oyV6SAf1e0UhmXTM4DJmsgP/Q86+sRiHLk2M8dX0mte8kH/ta5iub7RAT5CacHpT9jn/G+QKsAQiYRKN+WdGIbJa795vP2R1OUuqRnNF89F0qjRDysfYpJKb8cGr51MeRhJv8VHjRmBu7ZLs4/k1mKn8ySatZhoPvOpMxD3bUU2cYBkNAHrRekz1whmar2OFDwXDRLNXE4gmBmpCOmY4+hNVPE1G4a9VMyjFTjByCyZ7b02Jg9YFOftQV4W88F/apKNIP7Q2R9xYjltza4wqqkFq3pCNnYuZMbT+ETobS0rqpTcz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(6862004)(8936002)(6506007)(5660300002)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(6666004)(2906002)(44832011)(966005)(6486002)(478600001)(86362001)(6512007)(26005)(186003)(9686003)(38100700002)(316002)(54906003)(82960400001)(6636002)(83380400001)(7416002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJXB0pPfR2+OEkmUZR8a5RZqjAq2V9ThUr7Gv6PIqAtasfy1piAH8i4ZfZw+?=
 =?us-ascii?Q?SWeed1LivdpeHJMljITiGq0mUKrwDhAxJjAnLK3kTRfwVFOLPed7q+zIvawf?=
 =?us-ascii?Q?CHk+aydXlS/nN11SBd/ElHu70C8Mi1pk5uu5HzMpuchWSFOJQHsiT6SqEXJa?=
 =?us-ascii?Q?JEv7f0TWd082L83y74YuxP+oPfj/8XNKv2NHzjXi9Lnt+0yihYZmT1dZla5v?=
 =?us-ascii?Q?OLMzwvvBVileHcZi+8+6KOTqKU/jKUvvgdxI8w5BW7isTQRSZMk7ZO55K1Ko?=
 =?us-ascii?Q?prgoObPXPw8abvBQFETgoABIxuytjrw4SO3vpH4CFnjAnqBlOMVUw9XN2clu?=
 =?us-ascii?Q?JoUCBdeRzxe+CMjIUtuoPSfLikdvRzue+ZV7u7fiV7HqXZCmfDaKZHHiof3r?=
 =?us-ascii?Q?KQWYm7ySRx3FAGggMhgPtZ5hNEeoBlw8h7oeM3cCsVmYyx0FzK5YJiy2dvsl?=
 =?us-ascii?Q?pBEivaRK03bZL3AiD+Ic8em7lzDBH6271m8wGuWkRAwQ8hGla4nxKHsShNxF?=
 =?us-ascii?Q?SGgpH+csf80KlD7BVOfccObpq5iHOFACM2rthPxHqjM69nboOGGw9ctes88l?=
 =?us-ascii?Q?3XhGBI7G1+KsVmlB4nunrzktjCVTAL1SzXSN6+05GJkNnhzli/msIwqLgwwL?=
 =?us-ascii?Q?//OUYTIj30INpCBkW/JWACAKYjeH/y8ildqPqkWRMHKm/mDL70eo1etcGRJ2?=
 =?us-ascii?Q?VjKyPX7biErgxhwAOzNteznn+AiRiACcgBD7kuWjB0JWg3CnNgsxyZjqfi8i?=
 =?us-ascii?Q?4kXBQ1zVCGLcrUpi8V9cGDU0eGOITHli7RT3fIBp6/Oo4llTlD1PEDoSusBi?=
 =?us-ascii?Q?s1Mmu1T/81T+P7S4LA6poGKGK9e0w4rvRGSuJi9nWBi7oQIG515UBmSQWRaQ?=
 =?us-ascii?Q?WYXExcvtQSCdI2M4n5luQtbsPXz4HApHRu+2C8ozLxOsv+oEKFu8KwTbnU6K?=
 =?us-ascii?Q?0BdvX4ps9V98Bwja8Qy5Ld6B4XnFFzqivxd7yvi82o0yunPyh1rqwHi0VtEq?=
 =?us-ascii?Q?rAXJf/sgUveSqx1b7LYtXCPZtG+wrsO3ShKdzO4zvr3IXGVtlLecIDowkYJi?=
 =?us-ascii?Q?yP28W9qTYb1RZ7EmlyScot4SiLUVreVA+izwzP5XBWWKUxnHScy7Wc+lE8QP?=
 =?us-ascii?Q?ITvTV3KpzKyqopqnnCdMEMG8xmIv4VEU6h64i6uuQhGfyKB+iwW6Cn6hbDmX?=
 =?us-ascii?Q?n5D79dJQrqrxGKx876o57FyJ3Gox/JAoEg0+Yg8iRhc8SGdgnn3CQFB9jVVc?=
 =?us-ascii?Q?D4CbACWfDKhn41GKEZ5fB8nPo+2+Jqu3UW1g0u+/c/ovMJSSbvyTjOH/vtmt?=
 =?us-ascii?Q?g7f67Wqq2ZO1ILBmrLxizvFQes0co7BQiCleDv56aWBDVZ2Ip1LZ+vr1u7pg?=
 =?us-ascii?Q?PLqeXHvT8JQhCT18QeKX9ZASAG8nPD0MHxaNrmz214Q4YV0FTEDl0HTlp/Mr?=
 =?us-ascii?Q?+sKX14B3Zsv8p2PdO0wshwQ2xbMRjpQXErTI1/za/DEArsMYuhpiFN+5ykNi?=
 =?us-ascii?Q?aZkaVAYEHboS6lfzkE4VdqqHWeFGF9w65kWdLuGta3Kqvon6puArZtLi9hju?=
 =?us-ascii?Q?EJMNEliilTrK8XhNOVXfU7nMP20cFaB/MXAWkGsJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e95b43ee-f771-4cf3-bf72-08da72cd06fe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 08:16:53.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tUdkUW6dMlH5ZSe/Z8AUAcxlHz+kLWKh7vpEJ2teMuVPLf6omCNLXdnJN2xArsJ4eE+ry/cuN/FXcd9W+g6hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Sun, Jul 31, 2022 at 02:53:17PM +0800, Sang, Oliver wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 3616799128612e04ed919579e2c7b0dccf6bcb00 ("[PATCH v3 3/3] mm/slub: extend redzone check to cover extra allocated kmalloc space than requested")
> url: https://github.com/intel-lab-lkp/linux/commits/Feng-Tang/mm-slub-some-debug-enhancements/20220727-151318
> base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
> patch link: https://lore.kernel.org/linux-mm/20220727071042.8796-4-feng.tang@intel.com
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   50.637839][  T154] =============================================================================
> [   50.639937][  T154] BUG kmalloc-16 (Not tainted): kmalloc Redzone overwritten
> [   50.641291][  T154] -----------------------------------------------------------------------------
> [   50.641291][  T154]
> [   50.643617][  T154] 0xffff88810018464c-0xffff88810018464f @offset=1612. First byte 0x7 instead of 0xcc
> [   50.645311][  T154] Allocated in __sdt_alloc+0x258/0x457 age=14287 cpu=0 pid=1
> [   50.646584][  T154]  ___slab_alloc+0x52b/0x5b6
> [   50.647411][  T154]  __slab_alloc+0x1a/0x22
> [   50.648374][  T154]  __kmalloc_node+0x10c/0x1e1
> [   50.649237][  T154]  __sdt_alloc+0x258/0x457
> [   50.650060][  T154]  build_sched_domains+0xae/0x10e8
> [   50.650981][  T154]  sched_init_smp+0x30/0xa5
> [   50.651805][  T154]  kernel_init_freeable+0x1c6/0x23b
> [   50.652767][  T154]  kernel_init+0x14/0x127
> [   50.653594][  T154]  ret_from_fork+0x1f/0x30
> [   50.654414][  T154] Slab 0xffffea0004006100 objects=28 used=28 fp=0x0000000000000000 flags=0x1fffc0000000201(locked|slab|node=0|zone=1|lastcpupid=0x3fff)
> [   50.656866][  T154] Object 0xffff888100184640 @offset=1600 fp=0xffff888100184520
> [   50.656866][  T154]
> [   50.658410][  T154] Redzone  ffff888100184630: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> [   50.660047][  T154] Object   ffff888100184640: 00 32 80 00 81 88 ff ff 01 00 00 00 07 00 80 8a  .2..............
> [   50.661837][  T154] Redzone  ffff888100184650: cc cc cc cc cc cc cc cc                          ........
> [   50.663454][  T154] Padding  ffff8881001846b4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
> [   50.665225][  T154] CPU: 0 PID: 154 Comm: systemd-udevd Not tainted 5.19.0-rc5-00010-g361679912861 #1
> [   50.666861][  T154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [   50.668694][  T154] Call Trace:
> [   50.669331][  T154]  <TASK>
> [   50.669832][  T154]  dump_stack_lvl+0x57/0x7d
> [   50.670601][  T154]  check_bytes_and_report+0xca/0xfe
> [   50.671436][  T154]  check_object+0xdc/0x24d
> [   50.672163][  T154]  free_debug_processing+0x98/0x210
> [   50.673904][  T154]  __slab_free+0x46/0x198
> [   50.675746][  T154]  qlist_free_all+0xae/0xde
> [   50.676552][  T154]  kasan_quarantine_reduce+0x10d/0x145
> [   50.677507][  T154]  __kasan_slab_alloc+0x1c/0x5a
> [   50.678327][  T154]  slab_post_alloc_hook+0x5a/0xa2
> [   50.680069][  T154]  kmem_cache_alloc+0x102/0x135
> [   50.680938][  T154]  getname_flags+0x4b/0x314
> [   50.681781][  T154]  do_sys_openat2+0x7a/0x15c
> [   50.706848][  T154] Disabling lock debugging due to kernel taint
> [   50.707913][  T154] FIX kmalloc-16: Restoring kmalloc Redzone 0xffff88810018464c-0xffff88810018464f=0xcc

Thanks for the report!

From the log it happened when kasan is enabled, and my first guess is
the data processing from kmalloc redzone handling had some conflict
with kasan's in allocation path (though I tested some kernel config
with KASAN enabled)

Will study more about kasan and reproduce/debug this. thanks

- Feng
 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.19.0-rc5-00010-g361679912861 .config
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
