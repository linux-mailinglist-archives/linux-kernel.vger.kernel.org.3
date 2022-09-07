Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98585AFB53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIGE2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIGE2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:28:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1338FD52;
        Tue,  6 Sep 2022 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662524914; x=1694060914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3V29Do9zX0h+N/Bz5bpDlp2hMv1apROnuYa3ysqxl1Q=;
  b=mh/ud7jmRImAuKAU9VWcLx0xRXErgmKjAvUwF4pPnMpBVR1Z2R8wvF2Q
   uXz/1vQLGIkUEUvFKr+eVQtP/y8qJyF0Z4nFV1iR0YJN9AimKRoEglI9k
   BqTmy4/Bq2ir9cc29vbkeEUEwtQvsOR3G7IuAzuUzlWzEo/TubdXGtepj
   ZzBfUCn0c1fVunUUi6tC8QWOSeU9XFMmvyJziBZdGNlbk4kZDS8n90m0J
   G6ILCHt3z3L5+mabCZMh+cGOnnFLse7C40xVoql2pB4hXII4agG3UhLpl
   UrOxjZ88eLpWerANhxdwQmlVLU1lEg5KgiUZviJgicJ6tlQOcBIJcoL0L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="295510448"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="295510448"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 21:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="644446721"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2022 21:28:33 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 21:28:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 21:28:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 21:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVe7liKoztvYmvDcqFybtxeFQpqd+2tZNChC2e9y7mA5MTO5mLHRXx8omgA60HvUknK7rRMp4l6z4C6BNFAMTVIqWcvCAbJDUoNV4wJWcyTofz8s66WCRVCclZWvJVEiZkH5LtWj7N/DoAz3txwXlp1dsH6liKV6giaPV64OVBwueBw5kQIMqxFxe1+FuUwogaJaTbMsdYfGy+ogPbGg/WAH2Px8FghPIkapWHitEnLcCahwhr4RiCjKEnqcH9N8TnP6vxUKooD93V4xsyUqWU/xas/vCyppN2363H55GoWoNaFddmoRaXf9e6BQu/jfdKLsF/eNAXtXKxtZ+HEP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s3vZBMsbnCdkz6E9j46zJxFj+4xBzIXsolU/tJEOOU=;
 b=GgB0jQTQEllTNT1i+iZqr9dwEE4dMuW5EE4xwdWdsfkJ1rlPyXsNzsF5kNtKZGRtKgUf5u7qMnPam7nuQVXJYh6IeAv2q1EeD/irNK3R+Er0bwy+ZqGidhcrZv/JimczC4OJKWRJAhf8g9duMKuGmRIxqShXdIDgHhnx2EpnBgQVFMdPlN9cBwB/seznJDvsFpt1K+z+ZC9UFct2Fd8Cu7vUaMTK8OC6hBnNa8e24kv1MfqgUFBa/TOePLR/v7/W/mndGt0GqBI8TI4rdmJ07zCCUub3633D407jKhLbvNu72rv2YE7gaHJcBQSw7E8mIHNgj1DE4NAYmegbWyO7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM5PR11MB0074.namprd11.prod.outlook.com (2603:10b6:4:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 04:28:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0%6]) with mapi id 15.20.5588.012; Wed, 7 Sep 2022
 04:28:29 +0000
Date:   Tue, 6 Sep 2022 21:28:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <Yxgd51zdrk9pEXE6@iweiny-mobl>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <20220824165058.00007d4f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220824165058.00007d4f@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6d29e40-b13d-4dd5-76a2-08da908969d3
X-MS-TrafficTypeDiagnostic: DM5PR11MB0074:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISc6K/6jeMWxnoW4WGuJo7ULA2qe003avL4dpQsgd8ijCH4ZAHrvS5qFq8FSTiDUoTduWgQmTMf513ZZ5h012L4pZVCChazgp6vYGbYr+AHtqC4/iNmWQDEb9k323DpM6OdlcuZDTaWer1sCyNRv1iIJifaHnIOW0cUi1GBNnQE2EHJY2kI5CZ3lXvif3Qb2Kt8ez4nUvp+Yl/oOMUrCDQPD1vt5+baCDIygffCBINET00j8ng5loKufZ2gBB4MM/zDxWLO57OU/3Qkk07qCLgtVkjWUM2T2GX7929ghfTWsSor54xjy5BYPJUjhSzVpVr4ihIKs8UHy9OSum/C0DnR2z0NAz2BCw4YsZQ9YTRFcPcDeKibqqfkCY4Gpw85Vo7RCs8uqGcTgy0LdMNCT5zNguoAPLQ5XxNYC40UVhKCaH81WwFm4/jQH/2P01/edi5h0B8C2XYRuTgY48rHvh/B4ds46ZphDe2ETPslXZw7m+w3hbBw+gFikk/4cFmcWa6ox/u/uiN489TpHCGIZNv3NTLSHvaZ06UuuXM+hazvEAhml/G8f+LAU4JIHGWFqjziIKgSGjnwqcV/FJo1PjIqkBVmM/8vEmyCMLLG8htqlq7oFaLGjDWbAwqeDxxn5p8f9koCEXVFcg56tZUpatNv27n0TB/bu1nrWxBk0LMIfhUfoIcYiNxOzAPN/YDow0GGRaBlU0EXhEm9Yke2xqbNGKrCIi+96PMF8/5rm+PCKImH/fWsksIlehszkJ1I7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(66946007)(66556008)(54906003)(33716001)(316002)(8676002)(6916009)(478600001)(4326008)(41300700001)(5660300002)(9686003)(6506007)(6666004)(6512007)(26005)(6486002)(82960400001)(8936002)(86362001)(186003)(2906002)(30864003)(44832011)(38100700002)(83380400001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ze4T2JQe/nZFE+DhZ3VgY49Niow7f1r/2aQkJ6RtlNLSE+N8dtOzRofjHcfi?=
 =?us-ascii?Q?IUhNXsbMlw4kGKnwc7OHxZPtmUSmqjGeyyRBdymHuyvvQJ76hWEz4U2JyU3c?=
 =?us-ascii?Q?eY7B2MFo1gcnAgjubHogl1DenMrusEqMYRZB0I7mz9HLhRKgCIqbCUohVjgo?=
 =?us-ascii?Q?RyM9t6uV7UxCzht6eZFDtxLxO6rR68JlKh/6fRp895P2H2fReOm2x2F1YCmJ?=
 =?us-ascii?Q?mRTQT1dWoX7TXX703orcfyvIy1SB8ta1IiUskJFdVFzkAkBJa9iusWzP1BpR?=
 =?us-ascii?Q?A4Re3DqtN0r5NJPTGwE31DVvongcrj53pRnnxz1iIER1U0TfgOHt+ft0zF/t?=
 =?us-ascii?Q?gaOXlpnxJQ1+Rn9gphFTAmA4ypFII7GFw3qL+/Sab4Eo6HpT8W1C95iwcCrF?=
 =?us-ascii?Q?WSQPotAV7KoA2rJtq2Uvm4xaaG8YZGJUVY4C0jwpq/y1qZm3dVQ83eSycajM?=
 =?us-ascii?Q?c20I6WhKLo53FY54Ar6plcLLtdCYx3BZ3u/NWYfjVw3YjsVzCuEyEJvAADmn?=
 =?us-ascii?Q?Y7+EDnejD7pu//s49AJpfeptRmNo0CB1JZb8xLZ0OfvSPL6EzsKzpEMb+bfu?=
 =?us-ascii?Q?k6X2cs7qoSK8D9/jwvTmh7oUftSh/ude5C/QMyhHWNWXyPwaGeTmZJ8rzgxS?=
 =?us-ascii?Q?3f9n/qoL3ijqNeRw0hq0uXgf8ol8Y2lsdWCRQOZ9RVdOtP1la9CFbV8lRj2O?=
 =?us-ascii?Q?q+5QRbflS1xGtkq3uJAoABJfp24jRvMf2Rf057fkWq1FNt4XhJhX5da4zvgw?=
 =?us-ascii?Q?OjlG1SqkIxrH9/YXOK1d0sdUmDQRALQS/9r3QLKg1eThui2doKMgjEMe/176?=
 =?us-ascii?Q?mNH1OSzZcvQycwZpb8Rqd74q/PF7psw057e0kSMBcFiz/xG2OZ232yuIJEav?=
 =?us-ascii?Q?BlcGqKh3WT+AuUXD526ZuDVqcBSUrbtcTr7/1UFkjhFh01buOevvYdsuqJy5?=
 =?us-ascii?Q?YHkVyxXd3VQjf1wdQbm0mBkD3ig4wiSFIu6YLZPDfChUZDU44cnToi4WtnVz?=
 =?us-ascii?Q?kijnpHi+5ZM9Bio8DweKKaB7BNZG7g9tA8n3Q2lvB2Wt8Wh5j5reFOfq/YLg?=
 =?us-ascii?Q?3i+rffqTwdkmYlguag286IB7Jw2MRR09VQJSvv+Yz/5ottP0qJihUEFXERYI?=
 =?us-ascii?Q?Nj2ul3e8mmAi9Uigl6Sj1QlGUVPQLAFf7CHpNemWKOMiHKd4qXgLwqSd2cuu?=
 =?us-ascii?Q?BxhBLy1ddGbjChzAJnrxEP32AMRv36j9gldFZ54Rg7nchAFrGHps3bjOPNpF?=
 =?us-ascii?Q?CFPgqfzbAVgoO86lCFjqknXR5VYdtieaByQUoCxo5sO649NrHbthSxuI7Odq?=
 =?us-ascii?Q?5TsFFPsYEs4vHl1ZjUhqLwgUEAt3Xi4USbaQNF5yqlTvfKbBbsJ/81JeUPIp?=
 =?us-ascii?Q?cZLAC13cJV3Gef1ceoo/GwB17DjN0KzsQIraHZ4H3+2zOk/zmBiFBm+C4TaH?=
 =?us-ascii?Q?pQyiTaN7nkx8mH+Lyy9NwxyOhDjxhRE2rFJDygpmScDn+Xb++HIpByo2qq4Y?=
 =?us-ascii?Q?hHRz2M/5l7wyzGF6LwEao8V6NGrWgNYMuxIEnZxKVvmckThX6cKIuYoTfghP?=
 =?us-ascii?Q?FLIgXiN6ftBFN5yTZzx/+vYxoM32DLHVr6EV/SDj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d29e40-b13d-4dd5-76a2-08da908969d3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 04:28:28.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUqqPl/5rKLzgBQGL8cdxs2kMWB8xvN9THAJkqQLtcPzV9paRM3Rg1LWt5Ga1uzs4bJZDOqPbSgUckVtvfpiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0074
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

On Wed, Aug 24, 2022 at 04:50:58PM +0100, Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 22:32:35 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Event records are defined for CXL devices.  Each record is reported in
> > one event log.  Devices are required to support the storage of at least
> > one event record in each event log type.
> Hi Ira,
> 
> Someone went and slipped in a new field in CXL r3.0.  Might be easier
> just to add it now?

Yea I did not notice the difference below.  I thought 3.0 only added records in
this area which I was going to leave to additional patches.  Thanks for
catching this.

> 
> A few other comments inline.
> 
> > 
> > Devices track event log overflow by incrementing a counter and tracking
> > the time of the first and last overflow event seen.
> > 
> > Software queries events via the Get Event Record mailbox command; CXL
> > v3.0 section 8.2.9.2.2.
> rev3.0
> 
> You reference 3.0 but use 2.0 definitions below (I'm guessing this crossed
> with spec release).

It did.  :-/

> 
> > 
> > Issue the Get Event Record mailbox command on driver load.  Trace each
> > record found, as well as any overflow conditions.  Only 1 event is
> > requested for each query.  Optimization of multiple record queries is
> > deferred.
> I'd be tempted to make it easier by using a variable sized fail element and
> an allocation, but fair enough that can come later.

Yea I don't see this as a performant path.  So I'm struggling to justify the
additional complexity of reading more than 1 event at a time.  It is not super
difficult of course but I think my time is better spent elsewhere.

> 
> > 
> > This patch traces a raw event record only and leaves the specific event
> > record types to subsequent patches.
> > 
> > NOTE: checkpatch is not completely happy with the tracing part of this
> > patch but AFAICT it is correct.  I'm open to suggestions if I've done
> > something wrong.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> 
> > ---
> >  MAINTAINERS                       |   1 +
> >  drivers/cxl/core/mbox.c           |  60 ++++++++++++++
> >  drivers/cxl/cxlmem.h              |  66 ++++++++++++++++
> >  include/trace/events/cxl-events.h | 127 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/cxl_mem.h      |   1 +
> >  5 files changed, 255 insertions(+)
> >  create mode 100644 include/trace/events/cxl-events.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 54fa6e2059de..1cb9cec31009 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5014,6 +5014,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
> >  L:	linux-cxl@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/cxl/
> > +F:	include/trace/events/cxl*.h
> >  F:	include/uapi/linux/cxl_mem.h
> >  
> >  CONEXANT ACCESSRUNNER USB DRIVER
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 16176b9278b4..2cceed8608dc 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -7,6 +7,9 @@
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/cxl-events.h>
> > +
> >  #include "core.h"
> >  
> >  static bool cxl_raw_allow_all;
> > @@ -48,6 +51,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
> >  #endif
> >  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> > +	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> >  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
> >  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
> >  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> > @@ -704,6 +708,62 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +static int cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > +				   enum cxl_event_log_type type)
> > +{
> > +	struct cxl_get_event_payload payload;
> > +
> > +	do {
> > +		u8 log_type = type;
> > +		u16 record_count;
> > +		int rc;
> > +
> > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> > +				       &log_type, sizeof(log_type),
> > +				       &payload, sizeof(payload));
> > +		if (rc)
> > +			return rc;
> > +
> > +		record_count = le16_to_cpu(payload.record_count);
> > +		if (record_count > 0)
> 
> If it is anything other than 1 you have a problem..  So fornow
> I would check for that.

I assume you mean if there are any records at all?  For the next version I've
checked for 1 here but 0 is also valid if there are no records to return.  So
!= 1 is not an error.

(Currently all logs are checked when the event records are queried and some may
be empty.  I don't plan on trying to distinguish the various interrupts.)

> 
> > +			trace_cxl_event(dev_name(cxlds->dev), type,
> > +					&payload.record);
> > +
> > +		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > +			trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> > +						 &payload);
> > +
> > +	} while (payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * cxl_mem_get_event_records - Get Event Records from the device
> > + * @cxlds: The device data for the operation
> > + *
> > + * Retrieve all event records available on the device and report them as trace
> > + * events.
> > + *
> > + * See CXL v3.0 @8.2.9.2.2 Get Event Records
> > + */
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	enum cxl_event_log_type log_type;
> > +
> > +	for (log_type = CXL_EVENT_TYPE_INFO;
> > +	     log_type < CXL_EVENT_TYPE_MAX; log_type++) {
> > +		int rc;
> > +
> > +		rc = cxl_mem_get_records_log(cxlds, log_type);
> > +		if (rc)
> > +			dev_err(dev, "Failed to query %s Event Logs : %d",
> > +				cxl_event_log_type_str(log_type), rc);
> > +	}
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> > +
> >  /**
> >   * cxl_mem_get_partition_info - Get partition info
> >   * @cxlds: The device data for the operation
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 88e3a8e54b6a..f83634f3bc8d 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -4,6 +4,7 @@
> >  #define __CXL_MEM_H__
> >  #include <uapi/linux/cxl_mem.h>
> >  #include <linux/cdev.h>
> > +#include <linux/uuid.h>
> >  #include "cxl.h"
> >  
> >  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> > @@ -253,6 +254,7 @@ struct cxl_dev_state {
> >  enum cxl_opcode {
> >  	CXL_MBOX_OP_INVALID		= 0x0000,
> >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > @@ -322,6 +324,69 @@ struct cxl_mbox_identify {
> >  	u8 qos_telemetry_caps;
> >  } __packed;
> >  
> > +/*
> > + * Common Event Record Format
> > + * CXL v3.0 section 8.2.9.2.1; Table 8-42
> > + */
> > +struct cxl_event_record_hdr {
> > +	uuid_t id;
> > +	__le32 flags_length;
> 
> Can you split this into a u8 and
> u8[3] then use the get_unaligned_le24 accessor
> where appropriate? Oh for 24bit types ;)

Sure!  Another function I did not know about.

So the following should be correct ordering?

...
	uuid_t id;
	u8 length;
	u8 flags[3];
	__le16 handle;
...

There are other records which may work better this way too.

> 
> > +	__le16 handle;
> > +	__le16 related_handle;
> > +	__le64 timestamp;
> > +	__le64 reserved1;
> 
> As below. Maintenance op from CXL 3.0?  Seems easy
> to add now rather than needing a change later.

Yes I see it now.  Added.

> 
> > +	__le64 reserved2;
> > +} __packed;
> > +
> > +#define EVENT_RECORD_DATA_LENGTH 0x50
> > +struct cxl_event_record_raw {
> > +	struct cxl_event_record_hdr hdr;
> > +	u8 data[EVENT_RECORD_DATA_LENGTH];
> > +} __packed;
> > +
> > +/*
> > + * Get Event Records output payload
> > + * CXL v3.0 section 8.2.9.2.2; Table 8-50
> 
> r3.0 :) (just drop the v and go with 3.0 would be my preference).

Can do.

> 
> > + *
> > + * Space given for 1 record
> > + */
> > +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> > +#define CXL_GET_EVENT_FLAG_MORE_RECORDS	BIT(1)
> > +struct cxl_get_event_payload {
> > +	u8 flags;
> > +	u8 reserved1;
> > +	__le16 overflow_err_count;
> > +	__le64 first_overflow_timestamp;
> > +	__le64 last_overflow_timestamp;
> > +	__le16 record_count;
> > +	u8 reserved2[0xa];
> > +	struct cxl_event_record_raw record;
> > +} __packed;
> > +
> > +enum cxl_event_log_type {
> > +	CXL_EVENT_TYPE_INFO = 0x00,
> > +	CXL_EVENT_TYPE_WARN,
> > +	CXL_EVENT_TYPE_FAIL,
> > +	CXL_EVENT_TYPE_FATAL,
> 
> Worth putting Dynamic capacity in now? Up to you.

Might as well.

> 
> > +	CXL_EVENT_TYPE_MAX
> > +};
> 
> Blank line for readability.

Done.

> 
> > +static inline char *cxl_event_log_type_str(enum cxl_event_log_type type)
> > +{
> > +	switch (type) {
> > +	case CXL_EVENT_TYPE_INFO:
> > +		return "Informational";
> > +	case CXL_EVENT_TYPE_WARN:
> > +		return "Warning";
> > +	case CXL_EVENT_TYPE_FAIL:
> > +		return "Failure";
> > +	case CXL_EVENT_TYPE_FATAL:
> > +		return "Fatal";
> > +	default:
> > +		break;
> > +	}
> > +	return "<unknown>";
> > +}
> > +
> >  struct cxl_mbox_get_partition_info {
> >  	__le64 active_volatile_cap;
> >  	__le64 active_persistent_cap;
> > @@ -381,6 +446,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> >  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> >  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
> >  #ifdef CONFIG_CXL_SUSPEND
> >  void cxl_mem_active_inc(void);
> >  void cxl_mem_active_dec(void);
> > diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
> > new file mode 100644
> > index 000000000000..f4baeae66cf3
> > --- /dev/null
> > +++ b/include/trace/events/cxl-events.h
> > @@ -0,0 +1,127 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM cxl_events
> > +
> > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > +#define _CXL_TRACE_EVENTS_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +#define EVENT_LOGS					\
> > +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
> > +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
> > +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
> > +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
> > +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")
> 
> Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
> dynamic capacity events so I guess it doesn't matter.

I'm not sure why you would say that.  I anticipate some user space daemon
requiring these events to set things up.

> 
> > +
> > +/*
> > + * First define the enums in the above macros to be exported to userspace via
> > + * TRACE_DEFINE_ENUM().
> > + */
> > +#undef EM
> > +#undef EMe
> > +#define EM(a, b)	TRACE_DEFINE_ENUM(a);
> > +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
> > +
> > +EVENT_LOGS
> > +#define show_log_type(type) __print_symbolic(type, EVENT_LOGS)
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
> 
> Maintenance

Thanks done.

> 
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
> Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
> (only noticed because I happen to have that spec revision open rather than 2.0).

Yes done.

There is some discussion with Dan regarding not decoding anything and letting
user space take care of it all.  I think this shows a valid reason Dan
suggested this.

But for now I have added the field.

Thanks for the review,
Ira

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
> > +		memcpy(__entry->data, &rec->data, EVENT_RECORD_DATA_LENGTH);
> > +	),
> > +
> > +	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s' " \
> > +		  ": %s",
> > +		__get_str(dev_name), show_log_type(__entry->log),
> > +		__entry->timestamp, __entry->id, __entry->handle,
> > +		__entry->related_handle, show_hdr_flags(__entry->flags),
> > +		__print_hex(__entry->data, EVENT_RECORD_DATA_LENGTH)
> > +		)
> > +);
> > +
> > +#endif /* _CXL_TRACE_EVENTS_H */
> > +
> > +/* This part must be outside protection */
> > +#undef TRACE_INCLUDE_FILE
> > +#define TRACE_INCLUDE_FILE cxl-events
> > +#include <trace/define_trace.h>
