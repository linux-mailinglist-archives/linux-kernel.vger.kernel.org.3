Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5624C1148
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbiBWLbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiBWLbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:31:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA7E90266
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645615861; x=1677151861;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YFbagUMAvEslu1lRm2fg1I30EtE3+zka7RP8Py1XDFQ=;
  b=krgely3SpN1GRSJJX4QjSQz3akSEdn/O/w7Ule1hMOI+as3YAQAj2QdV
   c4e1i2yLwZ+G/H1akLvEtQN9xgH6IxeDx77awhjbJE7SF0arr9BUCZ7on
   pYBSM3Lrin0kzjuGWof01UaLgOi7YLqLwER7eI7fIRgMZfu9acFNjhU9V
   jKnLLhhOOQO/kNfq40rZDVqJDp0KZFwdw+5jSYVAsoppYZ5fu4aGaf47M
   S3JHu4G7ymIJvH2PDtMX4lC8QpPNrrBTKyru0+dQR2kmAPSVKmUX+z7cU
   cJrGXjw2ovdLMK5u9UKp+SxjY0jQ51v7if4jbsqQ4YSv/xcHa39nCYAzn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252135059"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="252135059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:31:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="532645289"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 03:31:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 03:31:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 03:30:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 23 Feb 2022 03:30:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 03:30:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bxh8/OI43oXqhDYsnJ7/lNp8+g1tNvRvOPKtiKKvzPk5MBxJvHEzIQHbJk7ykgnOzAUKWnmqJVaqe8XROuFS0BPG5OwhWV+W7tL53/bjATTpmvkrbSdKONu8sWv54t1anFO0x3tvO10iWvo+gP9mQqkEXPK+8ENvh/HuAW64Ttimt9jIn9/nGEZfY4TNpvkokBT9b0UqSsLuZyQb1O4FifSnukQ9/cSV4sxZTq7lQZXxX7/I5txo8cbq+3sWSHrrs62ZDgsSnuKHTsKiLu0uFQf02drMxcML2l306oumefHMhgSlJRKTqh3Ip2+ctwFJYiO6zjGKtPJ+ezkajyKoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89UYffvwcslMzwsPHWKmDHcw6fogR0Qiyt4MtewiDFE=;
 b=Et9K6pQwfxcOAlRqDUngP7otXs3PuZrtd+jcPokmDlAdN2xLkTv4ELQIIwHvwbrrFIXrUH90Nf74l1ZC50LbgmQbfV5Sr4CJuFUGrAYlzzYgm6IqFtAseb6CyAeOQSCRfNk0AJ8LY8hS/3HlaBmewt/WdMuvbLE+4vMFGazisMOvVBL+EzBz+HnlIzUh3OcZtJv069KxMU4O+l9jT/nyosbmRBNf3/fHF3h4DzxZVA1GD/0jRcmuWyZ+Qu5jWnhkI8/QAFbW7RYMtPRDlv1Kb3HIAzY0Yewpd16hlMYtA+8vWCGOLfwmE/WjuMQN4TS6Uk0rovShIMxjoKAyXiSx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 11:30:57 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b%6]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:30:56 +0000
Date:   Wed, 23 Feb 2022 19:30:52 +0800
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
Message-ID: <YhYa7PzhzEqRYXHp@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
 <20220217093113.GU3366@techsingularity.net>
 <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn>
 <YhOVzktqtWIJFjiJ@ziqianlu-nuc9qn>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhOVzktqtWIJFjiJ@ziqianlu-nuc9qn>
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f032b2d-0a4f-46b7-eb23-08d9f6bff574
X-MS-TrafficTypeDiagnostic: MW4PR11MB5872:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW4PR11MB5872FD05B230E495EC085FBA8B3C9@MW4PR11MB5872.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzTC3qVDM2AXhWRGIVVs4fWgTWPX1K0k+E0ZbAGmffS9nDpD2Pap+1/0ja3cKBCDxD7hogiU4oeKVvNI6+Um+DeUzk10rV2+nJWR3paL3le7mTg2sLOpH92/ixJr6UTADZucWoPE8ejJ/mgZJZ8RTTTvAPI5VyP666HVbWrZvZiCK1qamX5hS83Ekxwc+LE05OyyU9qtxFi5/qmJrVD93Flx/N7a+g3nzV4eCaAlwOlwqqSQbWFOZVXXTGZVFCeqCxTiroAB5n9K2WDqDJdUiaTJWuB8XF08okYVeag6VyRQ4yPXGvXcXD32G19fhOUvYBXP8LvIv9D0mmQuRh8WgMejGe9L1pOTKME837olyD5hPoSkWWqZhDj96kq77CdFXGCSQuLT+RMq1Hg+9o9KA7bJK3+fgjirgqrMZjd8C2XD1JO6qlm1uq4y6wjiDB8ggrK9Xj4/LZICJ38oXBjLlxD8D/3pHLeA8ETHmZTEiUPv/+kAsdKH+I8V0VgsT87/jVhk5blVNsgkFywiKW8qJHu9ghozJRIugnt0lMQAJfChdcyc57AGwBRDHEhhcT0ieAaPDJ95JCe0wY8aq0pZ1duoxskv5USba+QQfE215iy8P4IBFq8bNkzAvR9CiIqJTIRmdBg5VvUmDhdrWqWQ7KjWzGeImzqCCyy4ERZ6YL6SvqFvCKBS9jYGbMA6NVooxjqJdWGpvPL/qY8v3ihTwHycKGXLg2qUbJwF5yA2oq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(8676002)(66556008)(4326008)(316002)(6916009)(66946007)(66476007)(508600001)(54906003)(6486002)(86362001)(82960400001)(186003)(26005)(6666004)(9686003)(83380400001)(6506007)(6512007)(44832011)(5660300002)(33716001)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HOeZ/LwIAJ19z9VM/KjhfvHYdxJ7cfF5x4psLCyvXBUEgWzkzutLaBzCsB?=
 =?iso-8859-1?Q?eGzVAUufKuu00FvFyWRrhWJzi/hXevHFVknfG0/UzbeQ/5vU5PA83yl+Kz?=
 =?iso-8859-1?Q?2KKtdL1dQwR+O225/py/Wa7+aQJAl1XU/6JiBTmA+KgBwW30U5mUiFshGl?=
 =?iso-8859-1?Q?FIFQywB2ZyF4KfaqTwEvC7aao0RC+cgtati6GxUcvpNkjyIWFrMSEfXLLv?=
 =?iso-8859-1?Q?/I8Rf47TY7xAEMFGW60mjKvItA3QL6GidsXvxBrnx5Q69tc5IEgnQmITEp?=
 =?iso-8859-1?Q?uWsBXoPTZoQWvcVUwGafNZOGimvvhvw9QGWL3e1LRNNF95QRu745fJqOmA?=
 =?iso-8859-1?Q?ph5+oVoFSLesdSbLxndD1oicfC8J83Aq4RZkI6NCE/G9TMErMhsIFDmTTQ?=
 =?iso-8859-1?Q?qa7kf7/dskhkVrSTrEcfIJjIU4oquzvfywbfj9SFkKIo72szgFi0+LzNbm?=
 =?iso-8859-1?Q?e6h57XkUwzma5lqg7qanAtteiCx8kuFNeGvGbE3UJFWL5CEjPU1x9443tA?=
 =?iso-8859-1?Q?MGcMvCAD3a1d8ufzduDDLjU20kNnuI0J+PjZJJRjpXpB35WSnGE2vNTHyP?=
 =?iso-8859-1?Q?Z1JvyPkf+LpdXOQlHz5KDMiMLtwZ7jkpsWWrLNBDs1Avtts2hDHYuTxxC0?=
 =?iso-8859-1?Q?iqMug9ycZ8DKPD4NyyrNT2jrJoOiect/kjGfBeVSFJpfsrwav0il+hEYpr?=
 =?iso-8859-1?Q?lTusmYiPS8D/UKHYnJkC6XutuxVTk8O9LaJgYqOJsSIOM/u1yCF2JaUFGj?=
 =?iso-8859-1?Q?c4/kFp1HS+Q0Z/4nfpG6/dc7TCapfacr1D7S3MU3+C0svRFbxkgQbYJXjw?=
 =?iso-8859-1?Q?M0ysdxIwftoGhL9V8qXuZqv/s7UN0VGsGAcqLHzYuKMIZ0gv0Ud2CooDHw?=
 =?iso-8859-1?Q?lIAgVXvl0OcD+EAbPcARb2t2imua3bD3B7VDFgMwmo0y3PoVLb/N9JS5Fk?=
 =?iso-8859-1?Q?qg5/B8klwbK438wkhAhz6EczDgGL0ko+Zq6R10NbClnv2YEJS7RDpMgUgJ?=
 =?iso-8859-1?Q?Mx09OM6tJQNf567hFNl4om6G5+kTOBo+BfnnPddGUONuI1VCJabpYmWOBC?=
 =?iso-8859-1?Q?BoAWAP6WHJTWTMHo2GHI2o828RLnVUZIvMl/2GEMsbw1nGKV5UTHyIdUz/?=
 =?iso-8859-1?Q?mCDpGP4aKYRYEvgmrfWIlGO47+PH7B0mq7++CQpCsM8FwhaHFl1wJ/yKO5?=
 =?iso-8859-1?Q?zBUBlc0pbw4iGpqc0wj4ZLfENeMdRTHk+jqlmoXHjtdqFsS7ayFNPi004m?=
 =?iso-8859-1?Q?LY+jLND7Z0BmsnB/BoJf7fcc9zxEu5GfFNn3+HHJuS19Np5+MyU3FfiMqI?=
 =?iso-8859-1?Q?EvV2x+eyQxgx1RzoBLd7ygMnRrpEwVhunq2RfbDtYJxVqTSE7kpunQZkDw?=
 =?iso-8859-1?Q?S7Vl7oTNuV3/nIyA/hRJ+BtMC+6dnZNUryAPTmipzmnuFDSafQB73XWfEE?=
 =?iso-8859-1?Q?Dd0vgkJnCU3AKuB2Ypz7vmMbgGMWctzlj7HQmUX1pbwtHW4yLouXgGY0aM?=
 =?iso-8859-1?Q?3uTaRLXf2korTs9URf624d/Lw44O82j4ZZ+MrykfvAs2eFiTf9x3oYQm6X?=
 =?iso-8859-1?Q?RpRfGwng+RcQL5/rDUZ2tEPTAsQY6enoldNW9TuHW+ADheyzfoJNr6N0k6?=
 =?iso-8859-1?Q?3I+KAoYL1OA4svBNpKj7GeExN8Ft/w6o1Dnrdi2N2Zn51F1KywWEvel23a?=
 =?iso-8859-1?Q?OY93VN6FLhKWnU9920M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f032b2d-0a4f-46b7-eb23-08d9f6bff574
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:30:56.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoHTCbqYJ7olhZHEkJSVpqzMxKnCWT4ncH12hc9TWbPh8sMrc7Fj51iU6k14EDyJEAoHHg/RcVia+zoE0dCb1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:38:22PM +0800, Aaron Lu wrote:
> On Fri, Feb 18, 2022 at 12:20:03PM +0800, Aaron Lu wrote:
> > On Thu, Feb 17, 2022 at 09:31:13AM +0000, Mel Gorman wrote:
> > > On Thu, Feb 17, 2022 at 09:53:08AM +0800, Aaron Lu wrote:
> > > > > 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
> > > > >                                                     5.17.0-rc3                 5.17.0-rc3
> > > > >                                                        vanilla           mm-highpcpopt-v2
> > > > > Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
> > > > > Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
> > > > > Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
> > > > > Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
> > > > > Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
> > > > > Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
> > > > > Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
> > > > > Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
> > > > > Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
> > > > > Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
> > > > > Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
> > > > > Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
> > > > > Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
> > > > > Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
> > > > > Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
> > > > > Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)
> > > > > 
> > > > > The differences are mostly within the noise and the difference close to
> > > > > $nr_cpus is negligible.
> > > > 
> > > > I have queued will-it-scale/page_fault1/processes/$nr_cpu on 2 4-sockets
> > > > servers: CascadeLake and CooperLaker and will let you know the result
> > > > once it's out.
> > > > 
> > > 
> > > Thanks, 4 sockets and a later generation would be nice to cover.
> > > 
> > > > I'm using 'https://github.com/hnaz/linux-mm master' and doing the
> > > > comparison with commit c000d687ce22("mm/page_alloc: simplify how many
> > > > pages are selected per pcp list during bulk free") and commit 8391e0a7e172
> > > > ("mm/page_alloc: free pages in a single pass during bulk free") there.
> > > > 
> > > 
> > > The baseline looks fine. It's different to what I used but the page_alloc
> > > shouldn't have much impact.
> > > 
> > > When looking at will-it-scale, please pay attention to lower CPU counts
> > > as well and take account changes in standard deviation. Looking at the
> > 
> > I'll also test nr_task=4/16/64 on the 4sockets CooperLake(nr_cpu=144) then.
> > 
> 
> For the record, these tests don't show any visible performance changes
> on CooperLake.

One thing I just noticed is that, zone lock contention increased to some
extent. I'm not sure if this is worrisome so I suppose I should at least
mention it here.

The nr_task=100% test on the 4 sockets Cooper Lake showed that zone lock
contention increased from 13.56% to 20.16% and for nr_task=16, it
increased from 4.75% to 6.18%.

The reason is probably due to more code are now inside the lock and when
there is contention, it will make things worse. I'm aware of that
nr_task=100% is a rare case and this patchset is meant to improve things
when there is very little contention, which should be the common case.
So I guess that's just the tradeoff we have to make...

Here are the results on performance metric and zone lock metrics:

nr_task=100%
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/thp_enabled/cpufreq_governor:
  lkp-cpl-4sp1/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/100%/process/page_fault1/never/performance

commit/ucode:
  8391e0a7e1728d74faecebf096b446ac5d0a5709/0x7002302 (mm/page_alloc: free pages in a single pass during bulk free)
  c000d687ce22252c8ea96e47b4a2add592fbad6c/0x7002302 (mm/page_alloc: simplify how many pages are selected per pcp list during bulk free)
  7decb609034044e56cffd1c9971738878467ee96/0x7002402 (mm/page_alloc: Do not prefetch buddies during bulk free)

8391e0a7e1728d74 c000d687ce22252c8ea96e47b4a 7decb609034044e56cffd1c9971
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
  11807831            -0.5%   11750578            -0.3%   11778047        will-it-scale.144.processes
     15.44 ± 10%      -4.9       10.58 ±  8%      +0.6       16.01 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.get_page_from_freelist.__alloc_pages
      4.72 ±  8%      -1.7        2.98            -0.1        4.63 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages


nr_task=16
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/thp_enabled/cpufreq_governor/ucode:
  lkp-cpl-4sp1/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/16/process/page_fault1/never/performance/0x7002402

commit:
  8391e0a7e1728d74faecebf096b446ac5d0a5709 (mm/page_alloc: free pages in a single pass during bulk free)
  c000d687ce22252c8ea96e47b4a2add592fbad6c (mm/page_alloc: simplify how many pages are selected per pcp list during bulk free)
  7decb609034044e56cffd1c9971738878467ee96 (mm/page_alloc: Do not prefetch buddies during bulk free)

8391e0a7e1728d74 c000d687ce22252c8ea96e47b4a 7decb609034044e56cffd1c9971
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   3410615            +0.2%    3416565            +0.2%    3415846        will-it-scale.16.processes
      4.83 ±  3%      -1.1        3.76 ±  9%      -0.4        4.40 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.get_page_from_freelist.__alloc_pages
      1.35 ±  9%      -0.4        0.99 ± 14%      -0.2        1.17 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages

Regards,
Aaron
