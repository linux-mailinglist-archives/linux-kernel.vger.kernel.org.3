Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D925157D62E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiGUVjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiGUVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:39:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CAA9363B;
        Thu, 21 Jul 2022 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658439555; x=1689975555;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u/V+VZQo9Z6dyb7cm+h5IApbjTf27KOnmUB2HqFKWtQ=;
  b=nN/ANktzxvBQbfGgohVeif7jID8IKD5DfsVQhSsknu5y4QVSNm736Q8b
   nc806wd4/WgDtimrIb0mg2T6ApHTmMRSQVo5nozF6MPCgMpSJC+r9XK4g
   qFuxEYSDyZRFMPYgrpM+K0QF39PK6dHVY8N0Fzq2tawfUPUYcS1xEmGhI
   1oDmevgoJekQuQPzNfHYPMOYzNkF8eVqPxj1jnqDsVfLYxBgohPgb3ySc
   i2cW9uJonEmNNXAyj6QD831jXRZdrhudsyjzXJh4BmpwdmlCJcZBQhEF2
   T3gmrp4Id/8MTc4SyhTDSgy4aL/B13C2Fra5cn7Jn7bPu72xvlU0yiuRC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="288345998"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="288345998"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 14:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="775028966"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2022 14:39:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 14:39:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 14:39:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 14:39:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQY30auu3rTpWr0toWv5FIjavGR5ftr2ZndA/FHb6mvEErOjD17JFCiZGFoy3HTIRduyISlGy5c1K9zitxhQha6tR1Q2LhYkcbpRlyWF3vExF8LeFz3433KkaAITQ00fwFyElCi5USuHR7sn8Uf7cMuv0I4awwbjH95TyQ8EPO2Dvoo4I7/yMZHEtr5WR04TVZfrn+UU3SEV62SOPfEdkn+PoIjRFYkBVAhE/PhVLtS1Mblr7oJuvDU/5NBzLX9VlbFlWLlGKfjXKmLC7yHtOM57u9xxDifsOLaUjk6FFi60XZilZAXq1QDPHwXpeqycLMkwjRCuM0R6TzBpW+vaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL/3BuIX0gZ395RVgYQkrlZdwS99bpdgbZzy5RyPt8A=;
 b=QLh5PEtzISd2qieTiiO5XvQdua1jUZGpuT8cH2qJ9d47xEMGQAlJAAA8i65vEOcQhg2EjULvB7xkh0NppyWE49qGCrOxpOab6q5hHt6bjFkIG1wkXAK20KrWH+BgF5vLYe7r/9ehUsnUi3c5GzBYZfnsvpxFueycsii45geT5fC+C12gX6tlv2i7ZtvxwycReEffkwQmFAOgOhdBKw309bN3m3i5fCqo/RySEIlofjczrLlpqSNKVm2fmIgS4umrbSmT1TjWE02hVMHdJxBKqcvlZyAgEQJfUUj+LCMYjUzQMGvV7lmlexBs01h7lRqsR0RnPMmAxPx2Q7tH8JDaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 21:39:12 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::2dc7:4b83:9107:132c]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::2dc7:4b83:9107:132c%7]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 21:39:11 +0000
Date:   Thu, 21 Jul 2022 22:38:58 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Srinivas Kerekare <srinivas.kerekare@intel.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qat-linux@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: Re: [PATCH] crypto: qat - add check to validate firmware images
Message-ID: <YtnHcmwfBHzHCziz@gcabiddu-mobl1.ger.corp.intel.com>
References: <20220622210155.69684-1-srinivas.kerekare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220622210155.69684-1-srinivas.kerekare@intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: LO2P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::15) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9abb45-0aa5-4fc9-7add-08da6b617319
X-MS-TrafficTypeDiagnostic: PH0PR11MB5626:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EU8PtvphiDrWHLRNUP1bRSNF2Ofm5t3//r9wp1pX690akS0KZvnQgh3ms1i2ig+SjBA0J58/XVAz6tBfth9jlln+yJWCIxT8CA3InXZ4eFwH51VcPatfvhkcZlEvI3gB1SsBIt92lqk6cCoUkkruileYBgIKGT+q+V7A8+OLPZcTmiqmKUxpZdbaCfuur6RNMD+WTiH040VKMz6TvdXyrzgT3PLvKMPTWnoMpoxAEidBJjxgWmETqsDYI6eGGzIBF0+jAnaWTjYOOEY04sdXN8DJglqoEZc1z6YNKfW7h0z97HmnxOUcom7ammXJ/vhga56JtiambI2y7uE6D9N0pbczhg3lJVR5LJlX0xUUL4WQdTYVNRX5jlmVZSZI3h8Q93ZMcEqt0AQzVuQ1mXnG06S8U512XTGXo76jPBeQy1yIJxRp6rhSpUIH5x57tckfhRPx5fWrD/uGwbzryfwSFGuNpvEnW4lmrXolbQWtjjTLZ1BTLzlPk7U0hviPKxdBbyK6uR3DL/X7cWPb+HbGO2aGmz98AxyjFJPIT2xgbePtAsJ/cmRRwbVtEIAUoazu0uj3bULKe4bGt+WC1iXDWKLJh4V7JPlT107Xk93T4MI3V1g8jrEbYxDr9VxNCYYoibz5gul6WTOlsZFkEOJOsQn1OxCE9nlQuCQlzai15Zfjr48qc2mx4nDPzY+qk6zdAh/K81sBFY3O/MAHuhV8LoAudHdbX3rgMndOdEcjYbHCd+m4WWMjBJ53a3Xqp4cRIywVXa76h4RmVIyqj7oszg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(376002)(136003)(39860400002)(41300700001)(6506007)(6666004)(316002)(36916002)(478600001)(186003)(6486002)(6636002)(4744005)(2906002)(15650500001)(66946007)(66556008)(66476007)(966005)(4326008)(8676002)(44832011)(5660300002)(6512007)(8936002)(6862004)(83380400001)(38100700002)(107886003)(26005)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3PcEGFQZppn7gT/AOeoEtWUn41n9QM17pjQOyRliPiWzMti+NhzJxpEKXLU?=
 =?us-ascii?Q?6P+PGf8VQRmQU1lzX4eordv43qoA//dnCTvlbzJMzY236+DowIihi/ikIn74?=
 =?us-ascii?Q?KbcdsSDWQ0N8Y7Q7prkBA14Vtnfm+oToFcrW5oeI+EfkIqeoqZ7OL4omHlOP?=
 =?us-ascii?Q?plsn5Hvw2SMazrsI/Ahujm3ruuFAEZrGhd0J0KoFZsaWM1um+lZqjHPNWg4F?=
 =?us-ascii?Q?WH+GtKC/CPnxvQc5qJ74IQy4ycw3NwyCYaj5p7DTNJ8/Ns3vqqf/0TkHjXru?=
 =?us-ascii?Q?gUG7tYCNa4XA/6iyHad8a3FMvNh69qgAfkBAR1T+WS1rB5RybNcoiCNBiAOp?=
 =?us-ascii?Q?fzNhXP/448FeQI34JoChX0uykTrFSMh6Rrz/dxYpOEN7JeGROovQTIinwibh?=
 =?us-ascii?Q?y+vzPsLJ6I9k7D+eYinUSjXgmw1wxl9b4YMVZ0rhnt5I1yXiDsfwXC3di2h2?=
 =?us-ascii?Q?x/aLnj7kuAYFwPuClsl83Xfzust9NFLjlQ6LfYUIEdD75EEzNLg43UWG916T?=
 =?us-ascii?Q?Luk/gk7BB4ue2D8WcoZYQLZ6bP6NUbKlBL2AEKjL929Nih2DG45DbnpcGU5E?=
 =?us-ascii?Q?3Wip1XBpwKMTMVm4ZEI1ru+iG/LuaYyAMf9GRP9E3KiEmKYnwHKUc0thwbD4?=
 =?us-ascii?Q?MML+c4oAeYvYveXEN64MeiIR889FJbdTgXYD0B8yrnfoK+V/EI6rFgixvcoL?=
 =?us-ascii?Q?vQjXrDJ0RjiUmKf+nMg/o/42FK4dcAr4eudR6/T0isdQGj2CA0qYhbgAH/D3?=
 =?us-ascii?Q?t686eeuHZFstZm9hSfCwYXpsh/IZUB1qrfk7LxUdgy0/AD1qTEe8fO3jlZ9e?=
 =?us-ascii?Q?EABdH2r9/huUe5F8I7uzDsu2nIR3et0YQ8pw4qUI0ZMbYmP3R5xBRE9+jJU/?=
 =?us-ascii?Q?bcJ4bQHqlqYpy/4TbJMSwVrn51tuIeRJboIeLMCu9WMWxh+DIiZYl5KjV64w?=
 =?us-ascii?Q?Kgrev60ugYYe8P2v78rvWv/0CrhI5U1//ith+MBxgVtoglznsUTWf3HmpTsO?=
 =?us-ascii?Q?8nga5uDpobR+IpBYpPif6FxUne3bhlOlKxK5W+sf6+5wBqlpXp1eSzPcleM/?=
 =?us-ascii?Q?A7GuHxcjLdgVgNqXJKBhaOXBYyz4A/YqWRNaUkkc8R4VIKXjYnQrhosv3utg?=
 =?us-ascii?Q?n8kGgsNRLd3fLazO4djIs2pqKJ+rbbaLGr0Wt5tOjJljyaTfqsassE+uGRr8?=
 =?us-ascii?Q?gYNOqiaKn1BTHuVPDd2WhTqE4qdY1uRpwmU+lL/9R1jsKEPbRICjWNompoX7?=
 =?us-ascii?Q?wJ7o99QSlH6KHomwvnpP8+nreo4sKuuG7JMPPMU9E5B26u2A7ye4KTpbAJ6q?=
 =?us-ascii?Q?wcZcPQUj6gOzBwwN/crNRYczoTXlM7sTKo1Xtu8dNLLWIVV8hc4ODsan5GqP?=
 =?us-ascii?Q?MqVjD0B620XzGaQNuzyJgvajmko5k3kgy6MO9EuMDRVTR7aIKWKlukugOW4g?=
 =?us-ascii?Q?cTrF6FNlExYm33eDgyDuEsVSy9XLoSzMFNXNAqSW5HNh8wiSTb2AN3BG+Ecd?=
 =?us-ascii?Q?XfsDimIcsDZ2HT+2kFrbjte52xviAUUTFFEh+xA9SVcGj48yxkrE/g5F6fLg?=
 =?us-ascii?Q?EduVSIPlzq3aPFMSvJNdr9UzEEWOaI0WuJegleoI0Cvac/Y6LMhutbRME3LR?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9abb45-0aa5-4fc9-7add-08da6b617319
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 21:39:11.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqdYSCcXFWO5Pygezhk9RDUUH8Zuuq+GZHlwur9u1utbUcP98+kpzeXwLSWN98v+D+ZMx9An4WJlnWR6cmsHPoQcfTc09nbTNMKwsL9wwUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:01:55PM -0700, Srinivas Kerekare wrote:
> The function qat_uclo_check_image() validates the MMP and AE firmware
...
The date on this email doesn't look right.
It was sent today, Jun 21, but it reports Jun 22.
It is also confusing patchwork which is showing this patch
before all the other patches:
https://patchwork.kernel.org/project/linux-crypto/list/

Can you please fix it and resend?

Thanks,

-- 
Giovanni
