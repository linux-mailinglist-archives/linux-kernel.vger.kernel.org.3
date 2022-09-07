Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313295AFB72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIGEyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGEyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:54:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30161112;
        Tue,  6 Sep 2022 21:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662526472; x=1694062472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hpaGe3fNTMj/JNNu32oGCkhWE2eYQ28GGf4Y7EkKruc=;
  b=GWruoCxgda5JRYBVKyNH8VDKz+LkrtpOukyXOR4fZt1Bm39K0Ut3ikjv
   tSMTvC1OYNyKpWHf/lV5UIGeahUG5651ztW09xRdGdk9darPAzd0qp675
   WOHaGFbQQbzCis1/nXWrrRrexZQsNRE/eZC8f+HiXsvArv1zKKhXEePpL
   Zdl9poO42/mWglBWVTSJcxxbe2j1xhlpymcEFGFxgbxL6UBrrj/9I4Rsm
   yv9e9ZjA/SKpyLsPILO3bI51EvcMvS/dElfs+8msFonl1BCwtjZCcrLVJ
   NRDkR5syvY6xGf2HERWhdCRK1TFbn8nQ5CMvNAEQqKCf79oeJLCmZUgBT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358495618"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="358495618"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 21:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="610192929"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2022 21:54:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 21:54:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 21:54:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 21:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIqjszjj/p2Qbv2Ma/rgGWguPo8NS4pWiRtNw5CdlS1b2yTwKHGn5oLhUnqAEq1wnOgUMYdiYjdvlENw/5iQ3brrs/CnmHOE304mNTGxnN9dJAyl3R83u75h+jGlto3xEHq26kFHtyvtX92l6k8eIceeyeB/MOBIzPcmElZO5SVR8fMRJ6uqgxPrZT3Vws5wsrW11rsc0dIhiILp6TmvkiVYi75Pe7xMMxhX3MRnWdntSf2Y1OeVAv7Qj7nmQs8gt90s17SZ8RUgMZvSa/uR6uE/KqmCJshydEQbaMhpkp8wTfbkQdEKQfglU5+QKTXAa060oeuSLyG06A/uxBUYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NZ3fL3mVBfLu6wnynlcSq0/uh/FSIvHifX7wMTAT4I=;
 b=Ox2J0zcHy47XOR2lD/avse3qOgpvHBSud0iDkRGDxJs5P6k/MYY837AGUryjUWAP42LQaJ8DSxWsPfiqwlNbBG2L8aWwmBXspFQVgNDTrCVWK+HPSoEhQ7fzPVqBldzBnPWaRi1IayR3DWpIYb49v+Bec3aAcnE8uUuCZXm5ocXdxyyeb0+zsTj7r9LOsD9jJk/7Qrnqp4+vuJd0kcykff5D5QLzJgG3BCepgf7TsTLjRM74eSVa2Hn6nJvB3lMghzPDlz1lcNmcGIGMlGph3b9UOOiCsrJgPqYcv+lKbQjmWYTajubbXiX+y45O0OK2dlkJiPd6P5+xyrFERe/xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY4PR1101MB2070.namprd11.prod.outlook.com (2603:10b6:910:1c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 04:53:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0%6]) with mapi id 15.20.5588.012; Wed, 7 Sep 2022
 04:53:49 +0000
Date:   Tue, 6 Sep 2022 21:53:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <Yxgj2dwqweF/aZZc@iweiny-mobl>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <67c4e0da-87e3-44a1-1902-220dbc312700@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67c4e0da-87e3-44a1-1902-220dbc312700@intel.com>
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65db39de-0a89-4b5d-de60-08da908cf42d
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2070:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MB2I0fbRQRqftT9/WnkFPgauxLtVt3rAlrSnMiSUzhSSB0u3YpOkLgLulKaZ/SlcaPFBFNN/asfYJETnq75dOCstSSWXYSPqT4V97jG7pJQjugHpoObfns+PCh3TiXH+EKzZp1xUxT/dgiT9t2i953mUiqxW66oAC0FXgMzzkHTaltfYLZSMfjIPkwu7smz1rjiZM+UZ/xNvgdUfXVBRa2SeTXMDVEEex8o3zXKsTvgGXuLtn3xhgnRBL3Q3XZSD5lP8otaAyfbVhzbkHeWAvg8xh4pu69zlCPwi5R0iN0zfpbSNnx6QlesP17yqKDeVjVgvl/ffHI89RdC1jG0DON94oMqS/OiJN1SWvWYbo721TkPMUr4xqolCuFcIyD6fBIq8HlF6QWBbXiVfZYNt1vniVMbRr9skqNlNZGi/OvtIKEgdBsx+XZehDR2WS73XoV4l0KGpXRsQRFL42paRXMYj4VxSz42LiKOo2ljkZhny7WJMPM7zNPRhFYNEMbfHK/U0nHIpxNwyt5eFK+u5ARh3YjtUZkJ9f4ZVyXQK5zGRSNx3ERz23VIRUooDioDefya1t4oDzPU9DLE/cOPOwuBJrfU2zDwoVPEK+Csp+wubyF1wXw/s5UEV8LO07efBJZav0auTUZfEYd5ZKtu3BlQGf7dWXWmqXX9fLFBBodpAvSp0FJ59TIHgrW8AmDhoU5ftPSnKrOIifBU1yGHg4jKym39cv08PhVKyhqAq4IUfhAeK1NY+kLKXdwEt8gZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(66476007)(316002)(4744005)(44832011)(5660300002)(66556008)(4326008)(8936002)(66946007)(54906003)(8676002)(6862004)(6636002)(2906002)(6486002)(41300700001)(6506007)(6666004)(9686003)(33716001)(478600001)(6512007)(26005)(186003)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6van7SvVc8tZXAUtJmkLe+9XHx2OxlqbUPlLnLQWSKDzhYKMXKZ+Yr0DXFxt?=
 =?us-ascii?Q?3wmn8Vp1ZHCj8ggvTnwoFGIT5avFxlTQB1mXHTr5E2pneR9mL61ZcJgfUIlR?=
 =?us-ascii?Q?mnuQ3C9IG/ugmP+FUE29wndp6vtBpGRdkZLpIBVZCGRgrsyPubIVx2/lYNWT?=
 =?us-ascii?Q?4jk9no/d9w3geKanAcX+S20uyf/XI/aLfbk1RFJPPGZ7UTiGXrpr7JhHu+A1?=
 =?us-ascii?Q?lZbTKGOq5Wg+fCyi5PdZy/rELIwvEYlydhjqCicpsRTlQDZoWrd/Vs2u0ZLf?=
 =?us-ascii?Q?R1kkh6ennJZekdnXClO6bcuobhGlbIs4EP9dEslQSCXjhO38Tx/qoJmKcq6m?=
 =?us-ascii?Q?ZCT/l0GzxjRDw0oUY1IMdzejwNYUsSgwLWHVs6lV9x6iq1cS7evQVuu4JEWs?=
 =?us-ascii?Q?8Isn2iPz7U+mSsKto8wn52OcnMF/RarRPha3ogcOCNV21e1tCiBAOrkCp0wQ?=
 =?us-ascii?Q?e0aWqJN5Fj74B/3Aexta9TKWLt5N6PqAD08Kqu9WJM5+IOxQP4ptr1WL0NrZ?=
 =?us-ascii?Q?efwpDomrw+5C6yJAS/dZ4TYuRQ0irSVfwFiPUHwFmiNYGWggPpnm2HQT3W3N?=
 =?us-ascii?Q?U9I1/oy3VqyqCvpJNPRsM6DmFyxAxumA/MCyYZho39wlK0GekCTkx2wObxtc?=
 =?us-ascii?Q?T3AenDNLc0pNzZ05mIgpCksX12XY5bzDLyRkLPD5X6cem+q8ODNJcgoHnLot?=
 =?us-ascii?Q?ZXifUV1+PWf8l5X1q6+iit6exR3syIm2bLLJ04qSkalUHId9uq39u39bKJiF?=
 =?us-ascii?Q?vpsdXmyX5xZh5ubWTEdtvms0Mvjgi7dMqHrT97fWtHJU+12bKmPdceVgVA9x?=
 =?us-ascii?Q?lZOJvQkoAdUzG2qavLatcE6aD2Ttl6Ws6J67eFGy8T6awGDFHvUF6EMrw4I9?=
 =?us-ascii?Q?adBjYMcm/6WMQNLVI06x9BKDX5K3/Q+quHqEX5g0+PaqjJ0N1LVoo1fVcHq5?=
 =?us-ascii?Q?L1IqzDjoMLFHv/n096ZiLPtrwAHC5JkFN9tnk0+9vYTUOTwP0eJxS7nnacy4?=
 =?us-ascii?Q?hfLC8h7U2IiYsbwhk1Sg1xY6yvmgYqGibGCttBBUK2eI1bWdS5dOF9ZZoL6g?=
 =?us-ascii?Q?6iTzn+/bh8c5EsxjMi8/Adsp/2FOG2iV/aSo49CSaI7IcWtyiLzNexItJwa2?=
 =?us-ascii?Q?K8xhGnv8F530WP8eb0peclEQ/NaoKfPKEKA8Q7VjeWa1/l917OBt/Yy5LZzp?=
 =?us-ascii?Q?GeY2rpQzoOcWZarAPY+qo28unqT0+XW0LQj+ETcFWcY9DZplOHWbjTtxulOI?=
 =?us-ascii?Q?fSJn+KPSJKoN+5ihg4hwgAzTS6MZ70bYjr1AhKqctmR2Biv428/P2UrKNFQl?=
 =?us-ascii?Q?N8VLg5+6cNpmDOQrZAIo8PPQ0JRahVaSUXbcWop57nFvIU+lqxHcb+ygKhJi?=
 =?us-ascii?Q?GODOYtDudhmdo2L1WJfwEtmkN6kwRn9+nPWAnIpvCA6DXRAvdAkVpiwDhzLj?=
 =?us-ascii?Q?8PgFowSB7Vi9e1aGwwosryseaIrXsAUYI3NmUri0SprJKFgpHs8qYhyDfb7b?=
 =?us-ascii?Q?RDDZyX3orrXDZ01PepLXbUQXK6vENX+ASLYm4EPkBS+mGTbly7N02us56Q0z?=
 =?us-ascii?Q?KDTEGhvYmRTHfDikE6FuTbazD/dK7fPwOFwY/74o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65db39de-0a89-4b5d-de60-08da908cf42d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 04:53:49.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v79U25YQ736GvW+qjcSJOdF8laGdwZ0sUpL/AdjUGTldJ6oaHalQwYPracA7TFbfdPdSPeqb1wCFRkGqHuWVPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2070
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

On Wed, Aug 17, 2022 at 03:54:15PM -0700, Jiang, Dave wrote:
> 

[snip]

> > +
> > +/*
> > + * Now redefine the EM and EMe macros to map the enums to the strings that will
> > + * be printed in the output
> > + */
> > +#undef EM
> > +#undef EMe
> > +#define EM(a, b)        {a, b},
> > +#define EMe(a, b)       {a, b}
> > +
> > +TRACE_EVENT(cxl_event_overflow,
> 
> Kind of a general comment for the event names. Maybe just "overflow" instead
> of "cxl_event_overflow" since it shows up in sysfs under the cxl_events
> directory and becomes redundant?

It is redundant for sure...  The problem is that trace_overflow() is pretty
generic but I think it will work.

Ira

> 
> - Dave
> 
