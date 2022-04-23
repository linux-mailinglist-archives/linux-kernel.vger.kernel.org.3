Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449A150C6E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiDWDZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiDWDZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:25:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91913019E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650684153; x=1682220153;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y8V0rXoIScsp2xCfAYnkhQM0xlkF+eNm2qAlE7SoCvg=;
  b=nKrgcOD3T1E6iTD1Tx5Cs0aaZqvU8FyeB/5igfNAK+XLcP5QqmTjLkX4
   3EQFV/vVFaDthy7Mxe0H97hsRDkR01d18J+34yzVaC0kNKTH772V4r0d3
   tLkCVeLo0xC1jfycztM/MkFN8ExXUaD6kssfJLHzs5HjpabFOfA7raC6l
   C+DGauraNJusI4uSW3mxnql8+6vqiMZt/nC477U/aorG10bcp/AD27cAj
   7ZYYofVfgSooAkAqPAQb6sN2ke7zB9bTZjytwGLI/Jx5wJ0ruDOByj23v
   3vrl4992h+bs9IH+SYyONgJ2CM2yF6U/Cd4mXemELspJdIy5b/WqEJS0X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="252172471"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="252172471"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 20:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="728799928"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2022 20:22:32 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 20:22:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 20:22:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 22 Apr 2022 20:22:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 22 Apr 2022 20:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKJQRiSp3LhF4R/r95GtXZE3JeM4ee/DBtOA3RC669zDKtpfo06FeFUkKBvxpMhRqE/ZKBcteeoATaEfxyGpJgDbCcVnv0uMtUYeAFfL3NjnNFczNHO081STNUtgEmSERaC7hBl7pPRNlDCiqV1+IezdZ+OOwnyNTbzUtDP5+Rn3aZvwIUgvX9neOg2X1vDptqqyBzTSeKda9X07QKmo64D+6FS2SGcDg9v7W2aNQGd7MqWtzn8sGOw3AN7skKXrallnhP+bXYoMuHlAQOIJ3q53Nvuc0PIAQo1/CM1AVgHyNHD7Pswe9OtXWZCDNAVFqmxezSRUqBqPZZvft1ck5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95fF3UMrZM07deYENbKwVQFae5x375737G53CMqnRe4=;
 b=J8FjOzADTGydvjK3OByclooRLulOUgJWZxKnSxLxjXEE2ASeGWIqNwffaoVWW3ej9P/wekw4QPx4UViH08F4xJneg940RLZq+CZyYvp7HusPbGRAxrQofteaasaqor+r3w3PQDsc4ERRV1GPo/uIvlZCmL8JhIUPHJzy2JMd96HF3t09toTlgLBRHyaLP4qkRBBkMW6s1qtOG+VR+bpypCHv8IXTIJsDB1m7MahYyJ0zSKbl839+GuE+jCw+OX4X4vA15rlO3ZeLZvuyOKUT5NneNy2QzebUSstd2BfW7zSz+4ABmbR547kfUeqxsRaW/rlmr8CMnMpzr4d1n6NoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BN7PR11MB2564.namprd11.prod.outlook.com (2603:10b6:406:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sat, 23 Apr
 2022 03:22:29 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5186.016; Sat, 23 Apr 2022
 03:22:29 +0000
Date:   Sat, 23 Apr 2022 11:22:21 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <YmNw7Q/9/xNuQsPK@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
 <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
 <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
 <YmETEHnK/FiNbLO7@ziqianlu-desk1>
 <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
 <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
 <CAHbLzkriO6xWzyMNpcVFmyxSn=cqbz2qx+2mJ5d0m-beqPRCUg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzkriO6xWzyMNpcVFmyxSn=cqbz2qx+2mJ5d0m-beqPRCUg@mail.gmail.com>
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e9844f-d8b1-4e3b-2113-08da24d87efd
X-MS-TrafficTypeDiagnostic: BN7PR11MB2564:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB256403EC2A525F86EAB555CC8BF69@BN7PR11MB2564.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvI0FFpAvy6CXimoEUynxj0Hh9KUEBbzDwHkf7G32ugTe4Krgh8fHhbNa7VLBANCXSAGgApbL+igj5wsgj+NlM+m6RlPV6sXFlEi8eu5XrzUmu613MprGg6suxiIEF1X8ccbd40oI/wigJ/PHCe6Q+ocPlCtuE3+6TCb4pqTIOCt38rpZVCyhZ3/qhEaOP23RCGDyKqgSjcj5OXqlwjZrX1uS/NIbWJqrkF0E/FYXWNKkyZGz9cL/t+zT4L+A9TIcICqhHtFMG4T2JQdSqM+xphIsZT/BtHo319HtYQ7FL74Xueq/DMlmY+fPSI5zuVUBBArJxO5msM4+iPoJYGQGC7L22oYn5yNlXzIJiokpJ31VBVxuQNd+cVS8p7GOuliWTM5fclK3ZRDsXe7j+XKnvmwvBmV0mZAWzomOub7MsVuVCli4NfB1Msx64tW4+qzZwJYuaJUB8s/Nl+lRNiFEIuE+jMOwxZf+jIJB5Gw4K/sfm3/nM9pWPwSpRAGwOCwpyMK64C6gpLtYu6lzn4PuNbxdoDUAzcpIbSvWUWCgrFBaeNQ7AMrQD4b2U5Z7gniOSYLi0WlVtn+L6kX4Y8AOhDJbtygQdtjPDUy9WOREDfUb/BP06F76dJeNseyWUBdO3IKLRA3z8XF7r5G7pKfsaAkqP9A+Q5AG45gx+VIUHy8VpLm0YWuNGR2MFzsZSVIuoakEEKalIOmofcZbhcvjaqGa+bdLK1FKAl6JP1TnMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(53546011)(6506007)(9686003)(6512007)(26005)(54906003)(6916009)(33716001)(6666004)(6486002)(966005)(508600001)(82960400001)(38100700002)(83380400001)(186003)(86362001)(2906002)(44832011)(8936002)(5660300002)(66476007)(8676002)(4326008)(66556008)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoHlSstnVKYOLYLqVODy5vHkYp/wNtjALOs7HmV840YZn4C3JfBC63+0V7ye?=
 =?us-ascii?Q?eLOrJkDgcC8VRMCvLFXEEVnhZD60WX9DB4AVG9lyzbX91oXsWP2iLSi1eJsE?=
 =?us-ascii?Q?mP9pSI3Vgg47L1WHJpaR2jvx4qBfCUWmL/xI0mhd3qysA6J/dYf+v26G9KOP?=
 =?us-ascii?Q?o2oLz8HEn1bLb5L+OmickpDku35mbGn3XhdYq0j4jZL4kObwkqHWvDP/SNIQ?=
 =?us-ascii?Q?h3QbaqEIJBiXRBRcdCqrAwmUqIVzsw6wrGKSmPXnZqueTrbIoj6bfS6EPslC?=
 =?us-ascii?Q?C9wp/5B8gtqJglbkbM/H3BZ5hgCksUPQSoeYvwvky4M5zpYxghDpjVUkY79S?=
 =?us-ascii?Q?o1xBu5jcENWhAuGhg1uWMZBp80176WriJGmI66P+ZAiwaPAJyM9moE7GrBu5?=
 =?us-ascii?Q?rPUmO12VftIUCbyjdbc2WCz8+1ZBiet8TDhOh+zD9hurpwQUJshhHkozjpOC?=
 =?us-ascii?Q?sRnk6Hlrsoo9+ev20Eh9kmCG+mgqgud84y+EegvJ9r2S9aOvpTxw9OTwocje?=
 =?us-ascii?Q?Qh4P2cE4qpBqz1A0K9Pmi/LNcsJRZzn9N7Z+j5eKRXoNeX8ax/9gSFrqaCox?=
 =?us-ascii?Q?rhXI9sYi5ZXO6TGyEwvsTtXB8oO8baT4HIIajY8vFsbbmqLxpj351oyDqlSI?=
 =?us-ascii?Q?ehdUFZ8jZ/LUxWAAncSUPFtqbKR6jQ82FlEKp6wyEbZTmFYwiaV3NULMY+By?=
 =?us-ascii?Q?yZKCy2ihcVLcpzZrjvH08Izbm11GHAUsMTkfR9EEDnBgGngvSF54OqkbVAWP?=
 =?us-ascii?Q?V5/NLFbT07EQgl/R58zQfAcxWIjFuNg/uNXrfFHlbSOMRWwR5ysKuGJqWadd?=
 =?us-ascii?Q?YqSSZf6/CbKhWYABvXlKaPvda4kjs0UWvzIADdsgnkaeefcQuPb6WcmKh+lx?=
 =?us-ascii?Q?IUp9feZYx5fKbcZHaEt4jzqfhmwVvBWvPbir73bujPjPys27nmTzIN+fxHDt?=
 =?us-ascii?Q?AeNAzUNrNmij/1uPRUzhNwNoRVHlqxsl6sRRL3JItgW2E1FKVelukQ9pnaBD?=
 =?us-ascii?Q?3j68Ml6DFTHVykaFK77SHvgjDVzuP0vXlY4qWEemQRcnwpCM6AHW+ummsvlr?=
 =?us-ascii?Q?an3APoeFBkYcEDxS7WX4fB7bpz2/XutkqGkqSEiKIRTgAM49JfBO3qGbFm6J?=
 =?us-ascii?Q?i7xHFZEZtPj65IKpbq+sHJsA+slJAZHERx84M2cAr7xoJSi5BFgxkPOiF00x?=
 =?us-ascii?Q?qaqNpSA4/2BfyQIJ8uf8jRb9Kln3pxOOvPRYCU/YtJx1CKNS9+NWESiELuqy?=
 =?us-ascii?Q?PzeCQ3h79zgRCCT83Vz7knQ9qBD4FNYJ5Tg/4/AYmV06oGLgZ0msJEceLUTQ?=
 =?us-ascii?Q?YKkjE+d77t3tXzRC8GtKxTCL8Bv0z87FWFau2R4Mk4qu9T4QEiWL9VNOvSUm?=
 =?us-ascii?Q?FhiEFh63/moDqEXkNyYFkZdZyIbZy+sUbXr5hK7/0mR2aBJ7w+TKnkJHeieh?=
 =?us-ascii?Q?ZOGJBQNmZ/FydNog0hGoDb0Fi5RTHrfJKzsElCsBzfMgQKJNx2xE+5v2bf/r?=
 =?us-ascii?Q?6gEaMxZDk3xs9gV4brojC3H00hlGndD/GYnHGwVr4CTxKYDlPro7mFtahjMk?=
 =?us-ascii?Q?WAZlV9jTiHOET6wsKxa3qoXNuAv6c0Qce2xdjMq3OrvqRz+zwQR3V36i/CZL?=
 =?us-ascii?Q?duxeYmtb2XhcjM+grtbNzBL/1wCid4f9gfH2eVJhC6styvfDKAVxUXdR8rjd?=
 =?us-ascii?Q?62HbD5OTDQGvhAfK1QaTREDS0/aPhqnGVfpU7erywrA4vuxBOyuWKk5GPHfp?=
 =?us-ascii?Q?kKOOdNOuPA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e9844f-d8b1-4e3b-2113-08da24d87efd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 03:22:29.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D66tD3Y5Da9BNya6tC3ICsobexoGAAz2ae5hClHOl2odEM4iKKWYjXxyzZAZX5HPFnmGdZbZAIfP5pro8LK/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:00:59AM -0700, Yang Shi wrote:
> On Thu, Apr 21, 2022 at 11:24 PM Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 04:34:09PM +0800, ying.huang@intel.com wrote:
> > > On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> > > > On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> >
> > ... ...
> >
> > > > > For swap-in latency, we can use pmbench, which can output latency
> > > > > information.
> > > > >
> > > >
> > > > OK, I'll give pmbench a run, thanks for the suggestion.
> > >
> > > Better to construct a senario with more swapin than swapout.  For
> > > example, start a memory eater, then kill it later.
> >
> > What about vm-scalability/case-swapin?
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swapin
> >
> > I think you are pretty familiar with it but still:
> > 1) it starts $nr_task processes and each mmaps $size/$nr_task area and
> >    then consumes the memory, after this, it waits for a signal;
> > 2) start another process to consume $size memory to push the memory in
> >    step 1) to swap device;
> > 3) kick processes in step 1) to start accessing their memory, thus
> >    trigger swapins. The metric of this testcase is the swapin throughput.
> >
> > I plan to restrict the cgroup's limit to $size.
> >
> > Considering there is only one NVMe drive attached to node 0, I will run
> > the test as described before:
> > 1) bind processes to run on node 0, allocate on node 1 to test the
> >    performance when reclaimer's node id is the same as swap device's.
> > 2) bind processes to run on node 1, allocate on node 0 to test the
> >    performance when page's node id is the same as swap device's.
> >
> > Ying and Yang,
> >
> > Let me know what you think about the case used and the way the test is
> > conducted.
> 
> Looks fine to me. To measure the latency, you could also try the below
> bpftrace script:

Yeah, bpftrace can nicely show us the histogram of the latency.
The hard part is to integrate bpftrace into LKP framework though.

> 
> #! /usr/bin/bpftrace
> 
> kprobe:swap_readpage
> {
>         @start[tid] = nsecs;
> }
> 
> kretprobe:swap_readpage
> /@start[tid]/
> {
>         @us[comm] = hist((nsecs - @start[tid]) / 1000);
>         delete(@start[tid]);
> }
