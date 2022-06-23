Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB355723B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiFWEte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiFWDaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:30:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8810135AA7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655955044; x=1687491044;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wLUwn9zrBG9/UjJtdAdfIJoBy1QmIyDvHdxzpnUQmw0=;
  b=AvtdvMToAdd3R5PsgEYZ/KxpxEogXuTJ5vagYeRX9ZOD5ORxghuqW/th
   gmMWHAI8hm81pujoPcYaq7M6QmOQovE6SMBk/0weykkng4gkCLfoRjfYd
   7DVUuxd2UIGdYeanMvolvyA10pgJDsJvWplul1orkByvwXdWocObcN4GI
   vXJsfrmrkws2PovoBPl99dc8yyLy7sLHzrua01tnmhSlhpkaHiCwYqHw1
   +Y7iIqlfytstt6KbhyoKt2dtzV/vO1HFNrN1YwjkB9a9BXtVoGxhsXqMF
   f8ePozQQuvZ1f2uCb198l8AmUQTxSivZq3zrLnzTIvRplDwHt0YxCVM5A
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281340810"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281340810"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 20:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644522149"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2022 20:30:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 20:30:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 20:30:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 20:30:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imegO/IUPjmZGzEAWdf0bzbioV4GE0e588NDjH0idQxHbypcX37yDgJo/7zLtAuhLjqjL7Et89+0JBvYaI+fwADXoGQCI7bEABn+xS9qnjmexKHLmu/Coh7yAklV8pBRW9NAbHWTvn5drPKummURNe2GMdIL8r9woB9pMX0DR/MJM6/mHz6cSFOz6KQlWeGPUY3iQv0QobHcPunIN23+jv+rqJ8kLMWdWGC1mUxkhPIbhkDHjgykkfHZpQKbQqYIbmM+NZU+nqmdgx06fuFgIbqLb+uslDJHCRynyaYtOZTjFDDkOyjVI39Hgz86Qc/h/XRiiyFV7hGRpkEw6M33bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaCcxNhTit7/OHdfvNnEzT1spbPu02YtfkJcMXRYxVA=;
 b=lxIgXSadDCdVHzPqLhBKqO207nhWaBG70DKzT5a1nEVK5KbAMTWU1kIlQtN4l6wzWGP3N2jyFGPtyJEi875Yl13CEgK7wIb1SE8mVICTsuo2+WaHMsUug83ehrQxkzSRCI2n0GvQJlGJho4UUJubP2Hm79T/vOj8uE8WTBLv8MlD+nrRZ4XSnm7CoNz9F1xUO14nsWzf+PVzoBUIHYkb0SZBik1Jz8is/T44omIRRSa5eZOTGcbUQ8ONAv7TalKcmH7aPa4ij00HlnaFHlGMo6qu2nM3zh2mNuxpYEpFXkiIlBXiOEVI668u1f3qhsgqzSXut72Gqhzxias9k6pWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 03:30:41 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Thu, 23 Jun 2022
 03:30:41 +0000
Date:   Wed, 22 Jun 2022 20:30:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
CC:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YrPeXOgEQq7G4Ctq@iweiny-desk3>
References: <cover.1655889641.git.remckee0@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1655889641.git.remckee0@gmail.com>
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c2ff857-4b90-46aa-a045-08da54c8bfd1
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_
X-Microsoft-Antispam-PRVS: <MW4PR11MB582470D8D769B2F95A5F48ABF7B59@MW4PR11MB5824.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yol6kkv/3WzBO6k8/Otbu20+/qHhy6z9gZUpBb6Qs0xQIE1H9t5ZmBwIIYQMW1c797MUuaXL9kg0m2vfxDG1WIYgflf2vsukOZriYKhWVJHSvmTmV71J1gcd0CTKRYVk6nc0AG6gxMOSbMUAlZXojbaj24dD0gRaXQNssZUU0v3/8+Te4OMepFN5WANacn9TcX918PaRNO12z30kMVGX0NzBgtXau3EkwEHtP1apcKpigiBRHhACPa8OVgETpeRz7KqvGiAEwv2ywARECBposOZvN0nE1n0QFnnh+zsgevTDh4P0s4v3aRwjrfm2xp9iVrp2sK4Xo8Cw5fC0lppYVcBjWXAlvo9w1OQbmbz2Lw5hYCOi2T4wKXqbxpCJIddP93t52mPInvkhofrCaBFGroa4TmexWN4sFIJxIA6HeucGHPLrNKItxoqvwnACYaph86KBErgCpYMI7N6IV9rIwjoOqYO9MgPrdy4knQrCg7Fv74HUYJUlcH3hEGjuFmXTDDWbqfebwWAVRtu/Z+Z7BwwaWO6ymrETLnn7S/jQK6b3YI6J/UoyrTcEUHz/UlcEBOYKBN3SitEhy5nORibJDrJZtVq7v+cb2MThGNkIICxmp+6st6/3LaO1f6G12zX3ovpFnabRfODiRcbd/mozhibcmkcHXkcczzqPQfYMc5Sr1oQq/8sMPSvwN2DFqrQQu/vvPrnt5JpxSPgx4JbkBQe7gpOZW5T2/7IJTUt/wcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(316002)(6512007)(9686003)(186003)(86362001)(83380400001)(38100700002)(82960400001)(6666004)(26005)(33716001)(478600001)(8936002)(966005)(2906002)(44832011)(41300700001)(66946007)(66556008)(8676002)(54906003)(5660300002)(6916009)(4326008)(66476007)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o48OFbf5FbI0lyYAsKcK0M4fAnBvRIxrGZ6wiG4veE0+pQk6Cwaqle3/qosX?=
 =?us-ascii?Q?p57nmCDs6jyJtjt73IbZUmLpPQ4zB1FAYBjv/oiEkVXb6brYT+EHko5WT7uB?=
 =?us-ascii?Q?xIbdankVMRwiHqct6LCmX7FlBS0ujsfsUqKAAQ4u5nU5y6u+4fzC0hJdbcS+?=
 =?us-ascii?Q?xBrvf2QsQlnH7S10mBWnpR0mKbM2BE+2R5VjUaehoZfFTTV7eSKGdZqUfYD+?=
 =?us-ascii?Q?63PBXFLt2pFkzjsezrIWg5OwNqHR80NATaZg9c3U5esiM/bBrloHOtsrbknt?=
 =?us-ascii?Q?VRqAM4lk3B4UxzZEXEOc4kGmPU1+al7p16RCbM78wqg65TaLoNvORZUjAJCy?=
 =?us-ascii?Q?gt3w9HZmT+ZJG67zyJV1iI7OBEW8KiMF91SCHhpp+iSYefqBO5949wWLKRWv?=
 =?us-ascii?Q?wXpXhgImFMpR/ItAY0XYa4HGFW9dRGmf/+TGZkNx/5O6VxVr1gpPKsrncG3+?=
 =?us-ascii?Q?0dc8tLaVbRWbf1Zb9kcN+0ltUxmFrQv4lsCg7LzgLV33W+QbQVtJw190Wzeu?=
 =?us-ascii?Q?JkHgNtreGfLm8/WEgO6l6o/p9Rm4uf7jNjLTZnziW7mg4duPvs+5c+1KtZAp?=
 =?us-ascii?Q?x14WjHpeac0mShn+dJ0WsL/wQtooddYUgk9B9mjkmNIUNuSHvUfVkuQ16HM2?=
 =?us-ascii?Q?rZwHjESYsN/cNkQLYHIjuzUcsaJh+UNCp644WStUqUzSjOJdd6uRPW3jh9ER?=
 =?us-ascii?Q?oX/Mhqid6NO4ZZbmfgfL3GNBGQCc+98nEa2GKDxdxpkvfmX7SKzf7vC0sXM0?=
 =?us-ascii?Q?OzxWPDfzbBlTGYgqGBP4orR6kFYEWSVPPSaJqfhvtqF8HdS/BB2qItFAqFvf?=
 =?us-ascii?Q?Q/P/DXK+DiJ9i+5YsXb7ZQBSPLONbcdH/TGIYTuscJlUk0QVkRCn7nh1cYDj?=
 =?us-ascii?Q?+5cJXJ2aV+3tmH1AdiSGTJDm6PCYRHWS3gr/BacEzeIyfaSVK4w5ubgcyh6i?=
 =?us-ascii?Q?d485cICBDsPtpcijFavu8TMluzrMxWpRfw9ZkNMrgNGpzozM7SaIbBMgVYGR?=
 =?us-ascii?Q?LLIcILp5++Pg2BnLOVFRBwurfYArEAzY1vQ6GMlKzQKQpoN9Ywh/c+R1Wn1M?=
 =?us-ascii?Q?wikAbrA3iwdEOe7QevDS6/SzhmSabwE8ScA3d03u3bn/uztbTfSIsMtLluTe?=
 =?us-ascii?Q?NY7XzTo2ur/ncdSaoti9zOoXDTSaniLWshmbTviwynjPRw3Gd9J3hGwWz+8w?=
 =?us-ascii?Q?sy9eXp/PnFkL1ECKJlynxFILhV7S/93qaIJaRUGb20bDaAJImWTd8bm6jLcI?=
 =?us-ascii?Q?7WmmI9yegkVI535gwT5zSEg40HAkf9LXd8qamzSzXPvVVCTFot5vn5k5ex7L?=
 =?us-ascii?Q?4AHDc4Fz1Lfl2//Ahkvpui5/2fmSgsM8ODLV66eWl9uLnx4KBKYQT2ekPrqk?=
 =?us-ascii?Q?lhyWpWWql/mVjTkp3T8pC3+NnYBw5sTLG8bmFIIFVpeURwXeBFC4loQtzteK?=
 =?us-ascii?Q?TwqxTE0KxZC//uly7v2/M6rz9A8h/4ebkkYq9SxQm1wRuF+pV+8fYGv7uTS8?=
 =?us-ascii?Q?E9dLokTIU/5tL/1Msrj09mvPIh/BwVNyRhRuJLjL7Xvt48o1FNDE50u/u9o9?=
 =?us-ascii?Q?F4u99jrdHNKwCjKNXpt6a7vAMVUDY48ny571fM4Av0kqBHpR6bZqoNN6pfJt?=
 =?us-ascii?Q?zQ9P/3sPYKLW/B3VKaLGXj8Hm6CmPk8inD5R1i9HFXhe54ojHqTeW5XtjVu5?=
 =?us-ascii?Q?SBYrVzuwrjOTAZxv3jctac8YDjUD1Nr0Imzd498FCNCubYeuB0RjSUJhfYtB?=
 =?us-ascii?Q?qzOQfOtzOzPjlcV7NyKxLsw9knrl1Ns=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2ff857-4b90-46aa-a045-08da54c8bfd1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 03:30:41.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x74Rq/6nWroFq4iVk8pe0BcjCxJI/8LurmWQwOOPYF2KvrpDx06me7vBC+SXvd+sZ2/4ywiFZCJy98RkgEC1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5824
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

On Wed, Jun 22, 2022 at 04:29:05AM -0500, Rebecca Mckeever wrote:
> These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> simulator, which can be specified when running make. These patches also
> implement the functionality for these options.

I seem to be missing patch 3/4 and I don't see it on lore?

https://lore.kernel.org/linux-mm/004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com/

Did it get sent?  Did it define the ASSERT_*() macros?

Ira

> 
> VERBOSE
> Usage:
> 
> $ make VERBOSE=1
> 
> Passing VERBOSE=1 will enable verbose output from Memblock simulator. For
> each test, the verbose output includes the name of the memblock function
> being tested, the name of the test, and whether the test passed or failed.
> Since all the tests in Memblock simulator run as one monolithic test, this
> output is a quick way to get a summary of test results.
> 
> MEMBLOCK_DEBUG
> Usage:
> 
> $ make MEMBLOCK_DEBUG=1
> 
> Passing MEMBLOCK_DEBUG=1 will enable memblock_dbg() messages. These
> are debug messages built into several functions in memblock that include
> information such as the name of the function and the size and start and
> end addresses of the memblock region.
> 
> Rebecca Mckeever (4):
>   memblock tests: add user-provided arguments to Makefile
>   memblock tests: add verbose output to memblock tests
>   memblock tests: set memblock_debug to enable memblock_dbg() messages
>   memblock tests: remove completed TODO items
> 
>  tools/testing/memblock/Makefile               |   4 +
>  tools/testing/memblock/README                 |  10 +-
>  tools/testing/memblock/TODO                   |  14 +-
>  tools/testing/memblock/internal.h             |   7 +
>  .../testing/memblock/scripts/Makefile.include |  10 +
>  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
>  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
>  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
>  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
>  tools/testing/memblock/tests/common.c         |  58 +++
>  tools/testing/memblock/tests/common.h         |  54 +++
>  11 files changed, 913 insertions(+), 356 deletions(-)
> 
> ---
> Changes
> 
> v1 -> v2
> PATCH 2, in common.c:
>   Remove #ifdef VERBOSE around prefixes and related constants
>   Add __maybe_unused to prefixes
>   Move PREFIXES_LEN_MAX, DELIM, and DELIM_LEN so that they are
>     immediately after the other constants
>   Add #ifdef VERBOSE around definitions for test_*() and prefix_*()
> 
> v2 -> v3
> PATCH 1:
>   Add Reviewed-by tag
> ---
> 
> -- 
> 2.34.1
> 
> 
