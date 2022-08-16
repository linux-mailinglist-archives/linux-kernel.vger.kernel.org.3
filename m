Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9E5965E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiHPXLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHPXLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:11:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C2923CF;
        Tue, 16 Aug 2022 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660691481; x=1692227481;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w3+S54qAnBI0bcgZuUePwvNNu/Y+ohxfdEW/WoxebdA=;
  b=CwaUxt3Iv4rKn00FojIK3xs/uVFFLQ/gKyBbxoeXa4hoclNhWKBQrXCS
   G7IQF/Dte8HZma9ZktnFtYQAZl/4Y6NR6MNM3zHZUahdNq5CMlA9NpPR4
   9tVFaZbGXxMLeBKBiaapBcD9JOT4rNLIlE9yg5ZmIPYx29R4Rh2wFt4I0
   1VauN08kkYP/wYMRMVw+j8ycG7rl4fZJ6T7pc/+RRkW23NZWWezVFaeHy
   aoqx4dqup8dx8/uf302C7UhafSZ1XoLWxsDTirT6gJoz3bsA+w0HleCjF
   aPv8hpuOkaMIq1fxeG3sYRR5Nc1r2kvIU6n/J8hLJmQSpQrwjB7LMyunj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354095600"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="354095600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 16:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583517510"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2022 16:11:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 16:11:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 16:11:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 16:11:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 16:11:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfzg2mGE2nHPY4+XngbnOlhaHv/bDPsthSyQODV80MybI32daYEyjoDB8mCDsH76zHMj9KQMFRnLEYrOgZWfJI4epX8BCFIWB1Vly3OYxAuG/4nToS+2nAHMW8fkxklAeskpFWsD6hRm81/trSz0AsbvsONpU4OqTX8GfRh1kSI2bq9OQ4wMG70AQey7N7+7jAsmVxyfA4KOvo1OE2cb3Ytp+GDxtqfKTUoZOmKvXN/10mf5qCqSNltPwKNwSUsCGQX5I/X5Yn0/D2vu9+IItHs+RAIX+2725mQb/Tv0nWsUgN7Qutyv9OzPQxhnl1xAuY+xu96aMHYA4PA7Kuwzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obWeQ900j+CjqhX41Bi4AQS8WlCjnb7k7IDkEQndhEo=;
 b=kSmjv87JLm9o/0M/yagEi+bX7tBSsGnapYa96Dqx2vYKx0qK1bcZ5QHiKed7rgoweS+p2jMORDoZ2WQJX/obuhHpd5k9z30pqun8ULAkt4glDEz0C82rc7fzxWpp7VthNGmWhsocQI+S1ZhzQmeH+ejtPg7hz7GEaaIVNkcBSca6rQJMo+sko+97gwCsSbIXBv5i/v5+wv+UIqjZKfb2B8tbOBGp5wdN5LESlSgk3MJRN8/1Lg/q/oX7HWjC5l2JkAtMO+HtnIzfUw/aDpqVG/Jkd7xyic9m29NTcZSZav1tUDwJeepaK6aaLIeejsb6Bk2VnN+kVgXNAhcQMPus3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4384.namprd11.prod.outlook.com (2603:10b6:208:18b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 23:11:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 23:11:16 +0000
Date:   Tue, 16 Aug 2022 16:11:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <YvwkEIywUvVohagd@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <20220816123958.2b49674a@gandalf.local.home>
 <20220816124128.618948e9@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220816124128.618948e9@gandalf.local.home>
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9697eafe-de6e-4bbf-1c97-08da7fdc9f1a
X-MS-TrafficTypeDiagnostic: MN2PR11MB4384:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XyYRc/+qV4xxvwu84XpPG7euPZVYehKtBpS91ixw/+n1XX2fGuScZTV7RH4NsuU5ZezCwUDY9BIzCzCU3FAdnilFjubDx8oN0gwYRGiuVZeXq44iLnONmvnH8agyyXnw8+jNJG51uLTuPAtG1xg5Tpx3xrwHoGs7DYXinK0Wq/AlV+AsrBGSBnedX21CjnK8QG0jYbtWSNNVpk9Rn/o2008Pdh/blmts6dHLTdrogoo40549QJHaZpKfjCpuFNrv/AKgYc4YqJa3ERhBf8ucxCocXVJdthi5sHu39+HkTfvbwocGDL8SEZzbIpGUxOR/rEVe11/THv6P3X92N65nt+vRnAucwGtI/XgowCy9/VzpeUHJgcR/fWRX4+852An+RRNGizEzJm8dJQR/1tx6O4rP8t4jRFuIo68t8hrZn/rEDS+57fDS7R+lG47yCS6RFKq+mo1OQgzaDk5GDDdBnzAUzOtwfucnDnTK9GpCzLJ209qG7i2smMokQzfAFqcm0mWHwdgHUSUmcMGEmbvFgQQVYLEXFV0vplcfIT0Xoyvgp0HxBN35S92kXd9ZE4uAoe4nyvYlmloug1BiXZUGwcAYe6cWx1cFTThrIg+0l05HIPXRoDrmS10dWx3gMBh4rXjEtP/kfHTrYZx46Huzinc2x2ArVpgIRHdF5y+p5L+6bjWgI2hIdddt558hqkD8AArhSM8XJJQz3ukw4xJM/kR4m0AyUomggWOT8Dl924=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(9686003)(26005)(6512007)(44832011)(8936002)(41300700001)(82960400001)(2906002)(6506007)(54906003)(316002)(86362001)(6666004)(478600001)(4326008)(6486002)(66556008)(8676002)(33716001)(66946007)(186003)(66476007)(6916009)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J65eY3UE/7Y4oubCXPoT+p1wsc9dm8CRlGHkAO7OL/NCEsiGmHu3O1JvICBD?=
 =?us-ascii?Q?a6pSBjRBsuGsvw1Z6GHFnElRHp3vFQBtDP1+xfJ7f0UCkFNVDmuu+kPNFVfg?=
 =?us-ascii?Q?6glzQjvt8IGbc123UIotwp5QmUnPDF7EaRHIlHyrQ8zmlQa5XPy5u9Z6ohPb?=
 =?us-ascii?Q?tGRPC7Z3kE9ai/5sPKyy1PNzR4ST3Lr//ZU7EC3KGDRJOFV2P1ZWG/AV7Mfd?=
 =?us-ascii?Q?cppNn91HneU+CUzJmZGnUkuWzTM5G2dk8hj4M+L8ywpaLtMomI0fW3Fd9rpp?=
 =?us-ascii?Q?vH9SWPrl6wJeqfnXRDEHoVYr8vOT2RC2EYK+p2reLWOvnOgdCi7r40f8XXOg?=
 =?us-ascii?Q?CmBo5T5Sh+eHIizU/uyVG+FqAnI9PoIs2gfrmAC2GAVo13Bgn0YTNKFXI6Dp?=
 =?us-ascii?Q?usYFaTeoGwReOs6XilUpJqKWMKpqyXD55x57So+kVNDqxHx2WmeIBaNhTN+x?=
 =?us-ascii?Q?3Q3+xqXhhZCuL/H4Ti3+No5OKWbMPknZlYcLNKHnR0CsDi6fB7jqv3UI7+Tp?=
 =?us-ascii?Q?nohBUwLstBj5Fx/fIoW/SySQl6o/08WNUsVaVUeYyJ9SVdmyBmFz58NG+g5C?=
 =?us-ascii?Q?SERjMVrtQlFqdxGV5PcUt4VhLYJ6bkSJXNr4G3LVgX3VsEttz19P3cAIYZVf?=
 =?us-ascii?Q?dNt5nZWUFlkRhHjptx5K5H7yQWRViIF02lONlTFYVWPLXXrX6S8NaszTVGdn?=
 =?us-ascii?Q?jNf6IqOcp7vTbZh3AjStQypmiU0aQdWxDr2kLfaHr5ca455kOM1SRZ57HN1y?=
 =?us-ascii?Q?0Q/dnZmiGmqxSHp4iBjaS11w/RvoUZo36sVl0DICg97U2+cl9EQI4CXcMUKJ?=
 =?us-ascii?Q?DMA3vFD+84wymowO8dSxhXS6pgRXaX1P+DtREBZyyDiDZ1QYvUuXFXQ2v7er?=
 =?us-ascii?Q?5FvKCj4uzoMTq3BreasTe/SRQfx8jNfcvRuS/fxcpp8GSeMhL19l7iuGXObi?=
 =?us-ascii?Q?1/xZyWNKnXkluefAmu4qU2qzCl49HI2uUJkGQ/JC/2H4t7bSt5dAAOcwUPJX?=
 =?us-ascii?Q?O0VQL1BVUl7Za8TBlygsJW1PdtLT+9iopsEpPaXRi5HFJ1Wmzc7qpckrbDCL?=
 =?us-ascii?Q?KGErHcX+7z5QnFTUL2ttbd4XfCPWP2/YszEEZJA1tKHuhNzdjsfEBPKBxA/U?=
 =?us-ascii?Q?G2O1Uk052lvf+R1R53OiB9nI0GmNS3wLuAQFIf/4xrA1FO6idhnbiEqW5/gM?=
 =?us-ascii?Q?+6y9i59tx9iG6P7alYW8SOdk88qYg5AM9/qA+uYUqiQraS6qPUFNc4Cuvljf?=
 =?us-ascii?Q?9ttGOBW/NOvLsGe1PeMFuZbs8zkxx3EdvG0gHFhND+fgKfizRx/7TOaSuMhQ?=
 =?us-ascii?Q?tcCpB1+8697OgDbIncDNp9dmZkHMR0jegB8t2p4oEeTkO8lrjyVpCWlF0PcT?=
 =?us-ascii?Q?KMmlXy5MoyGOKAr+jtRhaFYJrxZoFNiN7sJ2cyKP7Dedy5tLfZCeuxJgZtb1?=
 =?us-ascii?Q?zw62YVhsqgHiQFw8/uGeu9DxV6WqcZK8quk7jGTKQSwuFV3vczS75MZH77aP?=
 =?us-ascii?Q?9seC2JPYVN2121EBfT1QGt8ri6iLnlWO01OE06cMXDYJwQdnCXWOerJWq9mi?=
 =?us-ascii?Q?p0M/ZmQeIZ7BxERyOylyqamPprwgy4KVPvWiNXgm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9697eafe-de6e-4bbf-1c97-08da7fdc9f1a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 23:11:16.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcj3zkoiUDwV8wT2Iqxeace86xhsSCNur2D2T8r5sB1Xu7nLHiPpXXiyfUKv3EuVaVhopbuC6exnmkFjm6QzpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4384
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

On Tue, Aug 16, 2022 at 12:41:28PM -0400, Steven Rostedt wrote:
> On Tue, 16 Aug 2022 12:39:58 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > +		record_count = le16_to_cpu(payload.record_count);
> > > +		if (record_count > 0)
> > > +			trace_cxl_event(dev_name(cxlds->dev), type,
> > > +					&payload.record);
> > > +
> > > +		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > > +			trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> > > +						 &payload);  
> > 
> > If you want to avoid the compare operations when the tracepoints are not
> > enabled, you can add:
> > 
> > 		if (trace_cxl_event_enabled()) {
> > 			if (record_count > 0)
> > 				trace_cxl_event(dev_name(cxlds->dev), type,
> > 						&payload.record);
> > 		}
> > 
> > 		if (trace_cxl_event_overflow_enabled()) {
> > 			if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > 				trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> > 							 &payload);
> > 		}
> > 
> > Those "<tracepoint>_enabled()" functions are static branches. Which means
> > when not enabled it's a nop that skips this code, and when either is
> > enabled, it turns into a jump to the contents of the if block.
> 
> Ignore this suggestion. I see in the second patch you add more logic to the
> if condition.

Correct.

> Only use this suggestion if the logic is only for when the
> tracepoint is enabled.

This could apply to the overflow trace.  I think it is more likely that either
all of these traces will be enabled or none.

So other than doing:

	if (trace_cxl_event_enabled() ||
	    trace_cxl_event_overflow_enabled() ||
	    trace_cxl_gen_media_event() ||
	    <every event defined>
	    ...) {

Is there a way to know if 

	/sys/kernel/tracing/events/cxl_events/enable

is != 0?

I feel like the real optimization will be to shut this entire functionality
down if no one is listening.

Ira
