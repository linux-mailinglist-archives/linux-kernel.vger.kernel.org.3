Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E7D4B95B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiBQBxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:53:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBQBxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:53:44 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A26F231913
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645062811; x=1676598811;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PGLVqMCVc/UDVeFWpO08r/2ub13ztKT0XrGAwwVqGQw=;
  b=HCcTwesvApAt2NcvG9r9qN4GEjUWd0EQxe9zEeP4v11m2htv0TBQH8AK
   mkTi98ssea1q6JDlmQf8cgas2Q4BQBI5cwxWinwgCclGIC02zaOQBF5gv
   kyiqsf1fmBKfyC03MRVe6gUnD66VEHjgHAqiiL4e8ngerst34nwALPOKb
   Cy8IN1lmG7VA+5RfZb/0fIZgTmpjnm7QcvkyS/G5Y60TS7nASj1yAEHM/
   dC8hFwlyD/YuznlGoSva0BfezTSaQZ1s9NRKDWDVXU8+Qy/oKCp8DOly9
   +x20MMQp9te9Qp/nhkL3kN+iJ4w0w9smxQ3WK4jfWS2JpdY8LoIooNKwd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311509771"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="311509771"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 17:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="776782115"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2022 17:53:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 17:53:29 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 17:53:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 16 Feb 2022 17:53:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 16 Feb 2022 17:53:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQex7JMDCorOSUqsaf3XuhJ5LiFSIiDVlE3Gg8bvg7FapwwPhew6CI8thPFBPE2p0rXRPaMPwjBvby4w981nR01IKBD4u6hTbp1ykpEl5o6Vz76CJ8oWatslKzyq77SmtvVVnzR6g9+/QaWLC3XxG+bjbtl2LJU+wLdj5kr5XVJc7G0gfW402abh9wlkTChEY7SnNbTHg02aex9L/Grhv6a2VvIW4fkuk66F7oDHtTe6s2P8TSNdVHs7LKB8QcCBpjHJaTCdveacGHEDP5gOY74u6le0BkvhHRxLSATODDz00j8lqDLT4hm8p7GLO8vPo5yM0U2xfWFWX14rkSkS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JVzLUe38TFR7ieq/lvkNrRtrUg16mNCThkD1EQcrCk=;
 b=BL00EcJ3qm8npM7uKDHWbfXdXpNHEfbyzt03CqasQkDoIYvBytnV2DIWnVL0rnJ+SzP3UPD47CJpM2iG/E4ezkGXx6x6DVeLy4KJFKuImiCGpNn1ZFc3LncOHRMBtzK/+i/3y8+oMgh00jiZWxVytzFj76kRNridVgqH/RFdsCTweM9D9sWfRNFf5j1rBMVJytQY2PUTCssfhD3Oxe0GAAzyB0xRzcfbZY1tpoWhPqHgd3BI/fc959LHbxNuLoYb50TW1K8jIHnD1+CSjs53BS/OeVk77gPUDzDBL620rXhmMcKEKBSEsJS1TZMsSvNsN2439mDrE7YM6RqL6yS1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by BYAPR11MB3351.namprd11.prod.outlook.com (2603:10b6:a03:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 01:53:16 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::2477:ce52:e1c4:387]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::2477:ce52:e1c4:387%5]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 01:53:16 +0000
Date:   Thu, 17 Feb 2022 09:53:08 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Message-ID: <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220217002227.5739-6-mgorman@techsingularity.net>
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0651dbb-6a74-4271-238c-08d9f1b8439a
X-MS-TrafficTypeDiagnostic: BYAPR11MB3351:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB3351B2E05E5B54E5D50CAB438B369@BYAPR11MB3351.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGnkd4Pksms6mkpHKKmIIEnggH30joejGiWnPrzdX9ZvJVpiQWjCHXVpqTpkOCLBKgTF1XuQoai6LqXcoPVVsUyiVGwgH/aPRXLXS+qC3SaZjxgR6emQdUf3iU4ZNvrepzevcvtgvz4rG4TJf7V47XIrMTnnPxr0RxAF5X5u/ldUt7NX6FV5iZoIb+h611mr3AxX/aU+vlymxFGOZgX1H/G0s1bEJ4nyT2yysP6QcbvRnneCVQ/CVuE19vQ1VRv/yv4vnyfEngCD/Mxv86UM3myoeaGrEjdbZ5xNO7R6D45ynXqlSAQomnqlRBc6aHn+UaqXj/EUKKJZOkZlfLf37IAsvQ5WKNlc/+lzVXKnY4fReNqzKnEwYXa/lCRBwOGM6nLlLopZIpH7YXBVPL03wcwtbNo3rxkbrZNfaV+8lVXy47RRCdNRhzqDVeGlZFXN19wrwg3QBnBeYX0816O3NSGkn+PUsdI4Khu0sYdP6yddIzxkC0h+yiZj7TXGtKXHcPb8feBXE8aqhotTkklc+6nPQew7ke8MEnRVNwRCNBcPY8IFoEmJR5BdrW+BNdiBeEWnjQn3YFvjJWwvr/IInn4KLi3fxoxwhbNOozlPpLHBdTfhtCTJoKO5R9uvP/TLVJBfBadtTVySt0b8mPiESevtJZhNCvr3Mbns4eRmhJw34c/XTve5XcBg5daouy9C/Fc3JFUWgwjRsIpLjdfp5iJUJ+hWA2GmJjbBFb5BXuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(86362001)(4326008)(66476007)(6486002)(8936002)(54906003)(82960400001)(38100700002)(5660300002)(316002)(66556008)(66946007)(6666004)(6916009)(83380400001)(6506007)(44832011)(9686003)(6512007)(26005)(508600001)(186003)(33716001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KgQ7l2HAjfyItcQ6gmNG+svQr6Ylx4mLacQW5z+28Ik7ZP8A32d9sLJwbBs+?=
 =?us-ascii?Q?qGy0d9H87sWYZyUxltY+Wi75ohvERYzautptGaXR3PUdui3Boq75M4414rL5?=
 =?us-ascii?Q?lgfCQvzbRn3EOZ41KhIqb87x8xRfdhpIdtznI/4YOctNZnFnnldcBev0zmIG?=
 =?us-ascii?Q?0GtOu6y+7No4p+Hqt0ff9z5uGuLJq04pb30Qa/VcIWDi+elh3EtVWU8MM7gT?=
 =?us-ascii?Q?kKroI7NN/QSjoAPyyhUL3KE1tPSgFpvnD8N0nT5yLmFxiYQ3bNsbX6/rtNp7?=
 =?us-ascii?Q?7FT/Vo+Jxeb/PUrZomi9F+rZ5ay2HRE/S4mMiF4+jyshJevzlMHEdpUL3aVf?=
 =?us-ascii?Q?2Krs0brTDdY9XOp0BN51HrmvusgSxFh8JLdpulKgVsVeMJx0d7CoQeJdxSiD?=
 =?us-ascii?Q?CpJpCLjvddEg7pjRXTYWgbLw4fUT8bur0+acefs8TqcUL2NT0Vi6HYQAgbRI?=
 =?us-ascii?Q?b8nlJhgImu6qngmAkdOX6tDjWfBw2vlpljujYSXbPbnExMFDI7P30OcRDVYT?=
 =?us-ascii?Q?exaDBl20Vq2wkcdTkm2O8ewLRP9EMF17ieMh5Mtre5Z3YQarJitaW9mHhYCt?=
 =?us-ascii?Q?u1b4SFGN708/DXs2RdhyMjV83szLlGRUtWnmkfcPEIqm34bgqM9lEbyx66Bs?=
 =?us-ascii?Q?aj2Gwq2Un/qJaXjE7YvaodcNXSNbjk0RYHh6dZg0ALH15EEwCtbnL2UYtqJW?=
 =?us-ascii?Q?aUhLSdHqQ0DjKRQtPuwEufOdwCoYE5PPLjwLfMYRbjJyHVwrQ9fx0dro2poJ?=
 =?us-ascii?Q?nrES6QIjf4rDWgewXbTLoll6KMq1C2sy6WiK7CoUZBtc7fjamPL4cfeXijoG?=
 =?us-ascii?Q?wXocDfBk34IbRZEO3CntnUZVV7fGeuu6aIEpHhKpQ8bPfvxin5YnpCjLRrG4?=
 =?us-ascii?Q?67d5oE6utkCyvwnJFjh0ATX086s0+sn9asGA+7SQOjSnzfyOXtQaN6BZ7mWN?=
 =?us-ascii?Q?tXWzAhbmJVbUHWehOvZfHnALk4Ke3A4hZn7ucwjr9sogHKSoMShE+Th7HJzv?=
 =?us-ascii?Q?UDCSMAmjPkVcsLMTrZujOcuvbsGqvVRCaCFhTdzrHTcYGvOhRccx+x9ldy7c?=
 =?us-ascii?Q?If1m7r9HDZ5/1b0z+hGlKzwkqP09iNxkvlS0OvhQCj00vgrpsthxmKAqwEUr?=
 =?us-ascii?Q?ibG6VhhUJFflbVoTND+zXaBDjE17FpcWW7m6rx/2615/bNdiNBVRZnwC+Gi/?=
 =?us-ascii?Q?lVIamWPgNNvrLQ+TEmghNLN2l4oF/pPc5giHcfKIsRDScTJ7r1aedZVHxe/A?=
 =?us-ascii?Q?NkWmvfVVx0M6q0HAG18mjxVaArcpHzcJM7Zc6LvH9n3fyJwrUqKudkMhblZE?=
 =?us-ascii?Q?VZI8J4NOO7g4lEVSZh5/KtXf3Eiwjsw13+1UstPAYL93qXCLBd9W4GtKc9x6?=
 =?us-ascii?Q?wyOiVRY4bxD9vQnSwLnND/iTVMEjVKAnD6sp36jlPYbgKuL0Hxm1QR2Xiw15?=
 =?us-ascii?Q?XHIslr7P62koUz7XvbMvSdLNENfmaepf6U1TemoeTefM0hVYadm6QEV0/5KK?=
 =?us-ascii?Q?41LVBeQXFGwRflxe1ObEMBvtprOCoHvT3JPWiKMzKP56nAXYPomIxMQ21qwu?=
 =?us-ascii?Q?/02p4flw6DPTv+uz+0U6sbGKuEF0lejmCaldmPA3X0Nwdwsn2Nk9mEpWNeSc?=
 =?us-ascii?Q?Vvix4+8sBaizX5J3KpH7gqs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0651dbb-6a74-4271-238c-08d9f1b8439a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 01:53:16.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU6kK/j8p0Ylz6takQgV6Hd1Dk43eqRtU0DUJlmjgfis2QumH6AJE6r12UlRKo7CKRH4RGeAm7Dr4KtPm8FkIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:22:26AM +0000, Mel Gorman wrote:
> free_pcppages_bulk() has taken two passes through the pcp lists since
> commit 0a5f4e5b4562 ("mm/free_pcppages_bulk: do not hold lock when picking
> pages to free") due to deferring the cost of selecting PCP lists until
> the zone lock is held. Now that list selection is simplier, the main
> cost during selection is bulkfree_pcp_prepare() which in the normal case
> is a simple check and prefetching. As the list manipulations have cost
> in itself, go back to freeing pages in a single pass.
> 
> The series up to this point was evaulated using a trunc microbenchmark
> that is truncating sparse files stored in page cache (mmtests config
> config-io-trunc). Sparse files were used to limit filesystem interaction.
> The results versus a revert of storing high-order pages in the PCP lists is
> 
> 1-socket Skylake
>                               5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
>                                  vanilla      mm-reverthighpcp-v1     mm-highpcpopt-v2
> Min       elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
> Amean     elapsed      543.00 (   0.00%)      530.00 *   2.39%*      530.00 *   2.39%*
> Stddev    elapsed        4.83 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
> CoeffVar  elapsed        0.89 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
> Max       elapsed      550.00 (   0.00%)      530.00 (   3.64%)      530.00 (   3.64%)
> BAmean-50 elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
> BAmean-95 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)
> BAmean-99 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)
> 
> 2-socket CascadeLake
>                               5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
>                                  vanilla    mm-reverthighpcp-v1       mm-highpcpopt-v2
> Min       elapsed      510.00 (   0.00%)      500.00 (   1.96%)      500.00 (   1.96%)
> Amean     elapsed      529.00 (   0.00%)      521.00 (   1.51%)      510.00 *   3.59%*
> Stddev    elapsed       16.63 (   0.00%)       12.87 (  22.64%)       11.55 (  30.58%)
> CoeffVar  elapsed        3.14 (   0.00%)        2.47 (  21.46%)        2.26 (  27.99%)
> Max       elapsed      550.00 (   0.00%)      540.00 (   1.82%)      530.00 (   3.64%)
> BAmean-50 elapsed      516.00 (   0.00%)      512.00 (   0.78%)      500.00 (   3.10%)
> BAmean-95 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      507.78 (   3.59%)
> BAmean-99 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      507.78 (   3.59%)
> 
> The original motivation for multi-passes was will-it-scale page_fault1
> using $nr_cpu processes.
> 
> 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
>                                                     5.17.0-rc3                 5.17.0-rc3
>                                                        vanilla           mm-highpcpopt-v2
> Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
> Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
> Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
> Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
> Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
> Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
> Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
> Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
> Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
> Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
> Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
> Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
> Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
> Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
> Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
> Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)
> 
> The differences are mostly within the noise and the difference close to
> $nr_cpus is negligible.

I have queued will-it-scale/page_fault1/processes/$nr_cpu on 2 4-sockets
servers: CascadeLake and CooperLaker and will let you know the result
once it's out.

I'm using 'https://github.com/hnaz/linux-mm master' and doing the
comparison with commit c000d687ce22("mm/page_alloc: simplify how many
pages are selected per pcp list during bulk free") and commit 8391e0a7e172
("mm/page_alloc: free pages in a single pass during bulk free") there.

The kernel for each commit will have to be fetched and built and then
the job will be run for 3 times for each commit. These servers are also
busy with other jobs so it may take a while.

Regards,
Aaron
