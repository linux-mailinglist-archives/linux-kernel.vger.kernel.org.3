Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADADE59660F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiHPXfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiHPXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:35:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555F7DF79;
        Tue, 16 Aug 2022 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660692922; x=1692228922;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S0XN3OYq2AKZe0h+1cYQ54H0TedXbZNTncgc3CyAOlw=;
  b=UUqQHOKasZqXRR1WzS+kXl8bv8WYyaP1qeT2h/XgN7ctnJDMnIUcgwZP
   V2Cgl6FJ02o8ybGsBB1Sh8Dwm7wgCv5NLzn9jyAOHQHntNtA5nzJLtzMn
   +zgIal/rMjVX8ThKYPh/wJshjg+bd5szpMmDFmQHiUBvkZfAU8Lq3k6Nd
   oEnTUvJRqiXkj1FFi6e5b+lCUCe7S1vbm+TuJwXz7Fd6VG7HAqyjASWmh
   +wZ6FTb8hofsGnV1dpf+yxRwh9l4OIbYJHbb4d6sIfU7lWwMsXULiqi3Q
   NvxXz1q+3DDS83l7MrGJMLAT3qWHQclKIpNPMG44vy1b81KJGFF02Ok32
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="356354609"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="356354609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 16:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667351646"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 16:35:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 16:35:21 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 16:35:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 16:35:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 16:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfSRIA65NDwnTxeGBa9QSNHREwv4hCYYrOOcmxBV+COjCBlGlsl6ibCxYfvpJO0ItwtamgFScgVd/vc2E2nCNj6ryXjbuCDjI2MW7vIwX9Zpzw2ULoI/BkvS3znfqovpPWbPyS8Ty1l2xuypFEIQ0F6xWLUKnVC8nsV2X7N3Ivhln6mECrE/LurdsLcwwDkdCaypiTR3OgFW6/0pVSGF9kf/+dprsUU/ZHgkZ9qA1a8z5WX8FEanz+873lu9tE1RoWk8MXU5T42v2mxgzs3Wd0QOnKMKtRaWl0bWBPNAnNAnt7URYwRvz04x0sp5od+nJEouEFDpAWmnqJoU+jmezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6KXckYwB0F+WlvosIjCs3VkhI28z1DOKURaoClrM2c=;
 b=AoASMqce+i6agfkzZ0cgG9Yg0fhnNAgvN3zLTqs7eyreMsvb1GIqbhepBL3UxGSESTIEZeAKn/4xLFJy5iu33E2I0bDpwW0xsvcXpoFVrMKGqUysdDU+WgvB7hhq0OO1WACMn49z13DCHIVWolxfAWfEa7wQQLoZ+pwSkrLDZOQ1rxLx4ASzItgHOi7KFPPiFYABn2QysYuHrA9dXJoMU1JHVBJbV8V7DnCS3PXS2TmbC0m3IgohBiLrhjTjBez0hlanuDvll5BHxtWgn9JCizXINUVq5+F2JY9Jc/+Axh5avv4L/cZeNZ2H0PWVeAV5iideZhJ0jTM5JVJFtfzXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 23:35:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 23:35:13 +0000
Date:   Tue, 16 Aug 2022 16:35:09 -0700
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
Message-ID: <YvwprR3eeD7hOwHx@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <20220816123958.2b49674a@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220816123958.2b49674a@gandalf.local.home>
X-ClientProxiedBy: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4dbbbee-75a6-4cc9-0ff0-08da7fdff767
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6228:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJYTlVFRU0P4ozoJYffYnr7+j/AiOEeNaFJ59+i1kz8HiVnG6/wFKIgBTCmK9mP7obG2stN6VgXOvSR6r5RaspYnlSekYvIIK1j9Diz3dcT3Ct27FwVZJw1xR80Xcy9rjGn10yweMXdWnZHvy5N3AcYwqGn8K68xkhgzZFkSGnCyVWGrQydG0wMCsloYQPl9YSbXjGSVqMag4uYxhgR+QOlnURPN9mBD9oTY4lW48ByNbmoVbJ+PpZiuTeTNV9gcqDoHn7RFH9SXStAcPt0s0M3//IwLR/eHNbGLqUBTWdjSDYL0kMWJ7e8HIn7Bh+ZhlbUw6Ceg6i980INVibzEP9XeflV60AkeI363yHWN9VtHLGeSGyu9R3ut8h/PkctFbs/M8cxhLu2dYOdNPr++Yd89igzJVIwSB3UCGW0+nHdePmItCVLFAYjDYggLZ5coH8n2Q9l3+Pne5mIirTHEyLax/np6o3LiAqaDSOXI3eIArRvrlc+vR9jdAGM7EOrwAxLzsKgcjQmyLCwQ9U/GD+e/huT8zJaSZGgBymbfaDNwrSa2fWeYNblkR0BCBNcAZ6mD5mNbH+aJNI84JC9N1QjkmCwxKh7TjktQOAb3MUWgVny7OA8/2CS+yf9eFC/4eriUVVBpUhvTLAY0mn+DGeSqjsYkAv5pTbE7BPS/ae6wBWGI6EpaEOGFmSGnGGGqNQM/24RceI1FcrWune2PfsUXKIv+4jw8EinMUea5JNTlfw3E5lAkzp6mxeimct5H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(346002)(376002)(39860400002)(136003)(44832011)(316002)(82960400001)(66476007)(5660300002)(9686003)(6916009)(86362001)(4326008)(54906003)(66556008)(66946007)(38100700002)(8936002)(6666004)(8676002)(26005)(41300700001)(6506007)(6512007)(186003)(478600001)(33716001)(6486002)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VT/QFLKSSF8IPKSvSjtvHHeo7M/xHcHTl6ZW7KLT8Otf05bZ+oNXMPWahHeB?=
 =?us-ascii?Q?kWUW1zAmOwwk0A45c7Kn9YczevARQzsWlpSQ+6jV4HZj0UxTUTP6yvu7IIbW?=
 =?us-ascii?Q?AOLEWliIwib501h8eltb67eJef7hiZBmwZ9kW/qLCh3guO0gFUYpcr0StDLw?=
 =?us-ascii?Q?diJHbPU5xyXg61b8JibuKTv8/UccDchB6dFDyNrbZbAoh6YBfXIPinrQPA0q?=
 =?us-ascii?Q?eo3ehtyJ73i4u2RmQ+10T9urDv7dmRIQ+QxKbLIu9B3hssyGW4LQtbtMH/fj?=
 =?us-ascii?Q?QzwiAdPpkkO2YvGhoPi0fQgy+h2G6DRow7PZgdmPX1Rynjh0ORyer2e/oYJW?=
 =?us-ascii?Q?Dpm72zk1pD+l582/tCMcnw6hMcGYmPiNcDS7pUIsxfsP++WAAylq/jT9Ggi6?=
 =?us-ascii?Q?Z4ldux/RaRFpdYv69xjL+GQJ8Mto3Pt/PNSuilAAfXR4IE06bRL7BY5S7cEB?=
 =?us-ascii?Q?NUwFVVAtLQxIoFqvwUZ8io9/zjrmDN2c5QHd5bomadMyOclp6YdUMiYkFMOM?=
 =?us-ascii?Q?EnCBJZkksVsrD7Fgrn32Oo9i3kqrJ7A2AyEElNSgRw50+HX2DqFZSjIAOl5a?=
 =?us-ascii?Q?nxy9EO8qc3PELw4ovkgQFQTTlCaTz6GJQEqf2zxzakd40Z/sY+4F+0RILrir?=
 =?us-ascii?Q?LaRIwYqboQz9Nch2r5cZZn01a1FSFI+k0CVTQWTYpovMYXbyfwysc5jBAB9m?=
 =?us-ascii?Q?+XudEkDykuakCz6ufqys0xbqn7pODR7v5Sr/wltWiIHEUuoRU8ni7c6RBrdO?=
 =?us-ascii?Q?VsHDDpAfHgC4LLZfv2n7jUc+iGQqi8NsYNJ0DixijXNNb6J3LDl+F8dpSJ6H?=
 =?us-ascii?Q?BwxXF3Qk0y4cLeLqBGpLvg+knoYuOyjP7WGLIJgKWkWBgmMLaCfG8fuTSNiR?=
 =?us-ascii?Q?FLTeAzhZfxzZjDvzsRqt789gStdlQT2BxHHqkSRWmhJtCF08L5NxgrWNTOpN?=
 =?us-ascii?Q?IKHc5jMRR3wKIElZGz4I7aw9BH7rtML3OhwZy4UcfstntyNE8R0NMnIi2uQU?=
 =?us-ascii?Q?+zXIu2J+iYSkGo6RCa9ssB34BadyP2fpdglw609HHrYg1D7jeiJjGmLVm1vs?=
 =?us-ascii?Q?Hvtr1jFhAG4UHxEHZtDiwvT5OccVwOl7NQU0ehsUr+Bgg5bk0OCXgSimKgTj?=
 =?us-ascii?Q?o/57b4m3ONgOL8T81Yv2SWZNvroxZWCAZqxcsmC4pTsbPgBp7fgeaKEmB/XS?=
 =?us-ascii?Q?2dAFmjgZX9//51fPgUXFHvSB4yYluOWv/KmQDqr4hrhIFsxC/gSspQ7HC4Dc?=
 =?us-ascii?Q?oJabWC16Y76tekO7RJn1ACACpPJxJNIaH7dCukMpqY/Hg+fj5YrcxEUyyloT?=
 =?us-ascii?Q?BojentbZWEg1u1PaNybKdK0BGqM28ljG56hwb6+wlS2FePdwloIZpXObp+58?=
 =?us-ascii?Q?MUnQ6XVsg2l0OjjZJ598XNzu7ZoYqgrMY79uU1XXS+dyMmSTHql+OjcQbJih?=
 =?us-ascii?Q?IE8Y9hJPSAu2A2KGsFZQ0rYY55gxs9aKIxVt3fbX8vnoItof7eI2f+/tYpnE?=
 =?us-ascii?Q?cT05vdAWrWSdeYza3bUUReek/eIQkb9szozzPHl537zGAq9lOaVxKlKZnHya?=
 =?us-ascii?Q?+XTkzhbcDWXAUURjuihcOgGRHmcH4ejXHX9S4++u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dbbbee-75a6-4cc9-0ff0-08da7fdff767
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 23:35:13.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Bgm5cOiI+X4QEvklcPu/xXt3iizjPEADCBP/P/VlQxc61Ck/F4yz1DDFNdl6r7eC3VV0Sgq/R3L4YPpZraIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
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

On Tue, Aug 16, 2022 at 12:39:58PM -0400, Steven Rostedt wrote:
> On Fri, 12 Aug 2022 22:32:35 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Event records are defined for CXL devices.  Each record is reported in
> > one event log.  Devices are required to support the storage of at least
> > one event record in each event log type.
> > 
> > Devices track event log overflow by incrementing a counter and tracking
> > the time of the first and last overflow event seen.
> > 
> > Software queries events via the Get Event Record mailbox command; CXL
> > v3.0 section 8.2.9.2.2.
> > 
> > Issue the Get Event Record mailbox command on driver load.  Trace each
> > record found, as well as any overflow conditions.  Only 1 event is
> > requested for each query.  Optimization of multiple record queries is
> > deferred.
> > 
> > This patch traces a raw event record only and leaves the specific event
> > record types to subsequent patches.
> > 
> > NOTE: checkpatch is not completely happy with the tracing part of this
> > patch but AFAICT it is correct.  I'm open to suggestions if I've done
> > something wrong.
> 
> The include/trace/events/*.h files are all broken according to
> checkpatch.pl ;-) Don't worry about the formatting there. I need to update
> that script to detect that it's looking at TRACE_EVENT() that has different
> rules than normal macros.

Thanks!

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
> > +
> > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > +		 struct cxl_get_event_payload *payload),
> > +
> > +	TP_ARGS(dev_name, log, payload),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name)
> > +		__field(int, log)
> > +		__field(u16, count)
> > +		__field(u64, first)
> > +		__field(u64, last)
> 
> Because you have a dynamic string, you will save some bytes in the ring
> buffer if you have:
> 
> 		__string(dev_name, dev_name)
> 		__field(int, log)
> 		__field(u64, first)
> 		__field(u64, last)
> 		__field(u16, count)

Thanks I missed this one.  I was trying to pack things better but I missed this
one.

> 
> 
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(dev_name, dev_name);
> > +		__entry->log = log;
> > +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> > +		__entry->first = le64_to_cpu(payload->first_overflow_timestamp);
> > +		__entry->last = le64_to_cpu(payload->last_overflow_timestamp);
> > +	),
> > +
> > +	TP_printk("%s: EVENT LOG %s OVERFLOW %u records from %llu to %llu",
> > +		__get_str(dev_name), show_log_type(__entry->log),
> > +		__entry->count, __entry->first, __entry->last)
> > +
> > +);
> > +
> > +/*
> > + * Common Event Record Format
> > + * CXL v2.0 section 8.2.9.1.1; Table 153
> > + */
> > +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> > +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> > +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> > +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> > +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> > +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"Permanent Condition"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"Maintanance Needed"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> > +)
> > +
> > +TRACE_EVENT(cxl_event,
> > +
> > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > +		 struct cxl_event_record_raw *rec),
> > +
> > +	TP_ARGS(dev_name, log, rec),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name)
> > +		__field(int, log)
> > +		__array(u8, id, UUID_SIZE)
> > +		__field(u32, flags)
> > +		__field(u16, handle)
> > +		__field(u16, related_handle)
> > +		__field(u64, timestamp)
> > +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
> > +		__field(u8, length)
> 
> The above looks good.
> 
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(dev_name, dev_name);
> > +		memcpy(__entry->id, &rec->hdr.id, UUID_SIZE);
> > +		__entry->log = log;
> > +		__entry->flags = le32_to_cpu(rec->hdr.flags_length) >> 8;
> > +		__entry->length = le32_to_cpu(rec->hdr.flags_length) & 0xFF;
> > +		__entry->handle = le16_to_cpu(rec->hdr.handle);
> > +		__entry->related_handle = le16_to_cpu(rec->hdr.related_handle);
> > +		__entry->timestamp = le64_to_cpu(rec->hdr.timestamp);
> 
> I wonder if I should add le64_to_cpu() and le32_to_cpu() to the functions
> that libtraceevent can parse, and then we could move that logic to the
> TP_printk(). That is, out of the fast path.

I would not do it for this series.  I don't see performance on these traces
being an issue.  The built in logging the trace mechanism provides (space
considerations) as well as user API to gain access to the data is what we are
leveraging more.

What I would really like (and was looking for the time to enhance) would be a
way to create 'sub-class' like events.

In this case each of the traces comes with a common header which is part of the
generic cxl_event trace point.

It would be nice if we could define something like:

DECLARE_EVENT_BASE_CLASS(event_header,

	TP_PROTO(const char *dev_name, enum cxl_event_log_type log_type,
		 struct cxl_event_record_hdr hdr),
	...

	TP_base_printk(<print header fields>),
);

Then somehow use that header in the 

TRACE_EVENT(cxl_event,

	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
		 struct cxl_event_record_raw *rec),

	TP_SUB_CLASS(dev_name, log, (struct cxl_event_record_hdr *)rec),

	TP_fast_assign(
		call_base_assign(rec),
		...
	),

	TP_printk(<automatically print header fields>
		  <print raw data>),
	...
);

TRACE_EVENT(cxl_gen_media_event,

	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
		 struct cxl_evt_gen_media *rec),

	TP_SUB_CLASS(dev_name, log, (struct cxl_event_record_hdr *)rec),

	TP_fast_assign(
		call_base_assign(rec),
		...
	),

	TP_printk(<automatically print header fields>
		  <print media event fields>),
	...
);

<etc>

Does that make sense?  I've no idea how this could be done.  But I think the
real work would be in the printk merging between the base class (header prints)
and the rest of the record.  I _think_ that the fast assign could just call the
assign defined in the base class somehow.

Am I way off base thinking this is possible?

Thanks for the review!
Ira
