Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB354FCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383060AbiFQSEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiFQSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:04:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA2213F76;
        Fri, 17 Jun 2022 11:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655489089; x=1687025089;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x0vqz0kH9jT4NaYbM1nffXyyucHNjgNNfhx5AWrJ3eg=;
  b=TUWyLJ+5dnh+TR5925EdNZZjHG0fJX5g+8fu1eZ/wd9wdRuNyNo9yhBF
   RmY4LRq23R3q0ytB/FbpZuJB10RWCGSLimNAeNvxrf9qPaewopbyaG9pA
   SMtLNtwIUyjGcLLp6WWap2b7RjDzcTguP414RTUYSOh2rr3LXtpgg9IWV
   1tuIVIHSANK5eJi42111FMMf21Uvmyecym9uKVttGpRAKRy2gfGWk54+i
   2Jpjf4vjM3IkTaMJzyFhNxxej6eF5pegFl3YvNtU0TxhN/v0E2IQ5BiJ2
   c8RTBKtJcFqrRykvHco3esOp6zCdY42SZXEBV+lkAjl4H+FgG/nPquD8E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365879348"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365879348"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 11:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536908158"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2022 11:04:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 11:04:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 11:04:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 11:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv+IJQnPF3aI4+U/6DchHvm0RK92oCyq+SBRObp4UcJSra4Q/iWhJNe/iHaqeCBKVFqOH99NSrvzXaxBp39Ni/QNNrdJLxZGHuzQFRrQJvWP1fL4aKeqVvxKJ38opOQS/HlS0RDIhbmYKO+VZTIISo2fM0N4NuPT7R5OHxC8Cy2p/9YJWgRbdY3dWPN2heAylUMIB6rYju79tizb/PwQwy8tRPV8/xEigNuljDllm2semKLSvfL8pa8n1s9MqfAQSn9tkk5noWJbVmyiKkPBRhbAhrG7VQMonmEYROCxZReQUTEQQDYnrp6oz6IG8XroDovjufEvnw6Ph+adB9NmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svFPm1AmSz6zss4UBu4VSkFdr8aNaHsZR4WZ4mPCi60=;
 b=kHKMTA2BryFdH6MUHwnBzYCc3g00hxHAQr5oQVE8KQZL1LMCpcPJJ3tKKLOBGuzziZFPHWW0VvyWM+A7OsAIM/N4MAFSZqQggzSLZarPIpmo4AemcBDEqk/L0sgJF+YjGHmGggH3dUj/n6f6/Tp6MXCJjrcd/LVGjNk8R5CckrhIfmXjZhSnexuIlXrhgtOSXKg3B8Onidkes4BLlOLoPysa/jAWFImpRulODf3fB/KdMPgev6Zno3d+Yu9zcC3Ik9EFJ6Zc4qq1lv+YsMhMQmGF0MakK41aX3v55FgJJVPuOACsFRikuFz5AqctIcotBSiiqxlS8YwJd9Huc9rJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB2701.namprd11.prod.outlook.com
 (2603:10b6:805:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 17 Jun
 2022 18:04:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 18:04:43 +0000
Date:   Fri, 17 Jun 2022 11:04:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] trace, cxl: Introduce a TRACE_EVENT for CXL Poison
 Records
Message-ID: <62acc2396e6f9_81c5e294a@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ff5283-4133-41d6-2822-08da508bdaec
X-MS-TrafficTypeDiagnostic: SN6PR11MB2701:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB27015F63C438D3F8D32264DBC6AF9@SN6PR11MB2701.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7T/mHjKAETCw2st0tBB6tIuNHFyau3MZ1VyPp1lqlRfeTxLX01fH38nnpMAngSIKB0PdFHaajp9YkGXxiTw3rLQmaxRccbMqLy2npv7HAHNoxlGLFV4vnRUoKnl7rTOAWbv/3IR0qjwtAQgDVvW/iMZecVoTo7zC6e+zv9JeL1A2plb4Dz5ezXcaNNE9h5HK4EhQ8gdJnEz8loSFSQ/UI/CmYD2s/A2JSlqqZAjsP9z2jGReVOPtvgZAmIxmb1+PnQNcNJ0eZ/iiQaZ8LHrgDQfOy0KrX/vQsaLpoCIUJBbYGG5cJH5RgA9Xm36trTYiWvyF9KLPKlrGu0V+CWCwN8kU++/0dFH/0Dn0xUfW0e+fife9EakjFElKjYBJV4p0hivyT2ZIs8ZyJxqujAryZWuDU2W8ctfo+ETnfSIWJBdbmer10RU9o1E/XSChht+MzR2s7+29ORhBq2h6YttaRP+cAm/ZuOoo6omuqHy+XpEiDhkaHNuiVvQfvWUW0tL+gEyTnPJkumuUnoSzJLDySfAvtOtoljQ3Yy40uDaJtxEInXQSM6gv044vOb0WMjzrT4io+Blji3mzbLIcWP6BLsM3Ejj/g3FBNxr2/2zrdWUJEFGRUiULZqk3xtXqC7HwAx/rwXvkCY6ptMQS2W/UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(316002)(6506007)(110136005)(66476007)(4326008)(8676002)(83380400001)(5660300002)(6486002)(38100700002)(82960400001)(9686003)(186003)(66946007)(498600001)(2906002)(6512007)(8936002)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxxbgku/f3pDkvicbyGMceriA4ftV+vV1wgFFIzg+NVGmVDYB14T0FrTY9vp?=
 =?us-ascii?Q?lfYDrQUhtcdHjz7REOLWMmo3Nos/q3PYgVr+/4yLIyo2SRkEHMFma878ChC5?=
 =?us-ascii?Q?xe91Isf5SyzX3TkYV8fbEMgwz5RO/697Ti7S0wqkKz2HABH34CALwfAdoyDB?=
 =?us-ascii?Q?8VSukJLgle6nV+6gorfUK9FL0DfNnysPAOE02rk5jj5FeAIYag456uBfaN3I?=
 =?us-ascii?Q?11lFhxk1kd8xM+54SHJkZPgMRG5SI9XuLl10kWDaywNIyYFFKttZ2vzchqKM?=
 =?us-ascii?Q?6/ktNE1W85VwLNPtrHxsew58jwCD5uka9UJUWcdLLDNn9BMUR6gAAfiDbTiU?=
 =?us-ascii?Q?ndLDUfgiyJVvmr9AzuICVgpXEpomVJm6hKkQWQcZw4d3OFU4mHMbL5bebwrc?=
 =?us-ascii?Q?pPShnusTlSIkUyYov+/yabRuD1RZzS62bKdESbLGJzMHjxLERaGg8+WY1ORy?=
 =?us-ascii?Q?PfKEXgvWbBcZhoUSwwV1VvQhGz02tHz4v3ohSnBCLPdT1zi3OlS1X3a8iV+w?=
 =?us-ascii?Q?Kj+5iLsiQLvtUXyILXgKx0A1mdXuFLYSvuoncfKp7zDI28W79GFcFsECqZlH?=
 =?us-ascii?Q?rnx6qnC5VDijG3VaYKVhCmHqCJa+uwCBmA2fTIXlc731E+s8wMp7l+GCDjLo?=
 =?us-ascii?Q?aRmK9oT7qaiZrqZUsPGDTWmyz22d/83WDJRyfwlF0yZ1nWJQ2V53cN4Kf4eS?=
 =?us-ascii?Q?WJMJUDhbmEgbHxflXCq4OS0H1d5D+nk5T+Gbouh89hrQJnpwlwEUA36pfuK7?=
 =?us-ascii?Q?Is/HPu53cMfVKq+dD5Xke8u4hBn/09FDMTCqjdNf9F8DZ6Ak9uKhNLs4jIEW?=
 =?us-ascii?Q?bHcb8l53WGI/MY2gFfWcLHln2TrgWdnjRu44mAzfdNttHvfriAh5Gs9v9bAf?=
 =?us-ascii?Q?KUWZsg/zJ7YBhRElt9ZspZBdmwFPPQJcbFypw0F1odrQl0LuOJkOPyvG7zG6?=
 =?us-ascii?Q?TIDts76Vim3ZYveAgKtgCZMnOEu8P5TghalcazLIIhVWs/hM1XL2UOV/DPPj?=
 =?us-ascii?Q?j4kLas/uNpFQf1foI4kI2Ck03V+L+sph+oXMEkgZS0+5foO5ng3Y4qeeFter?=
 =?us-ascii?Q?o8kzZyjf0LdPY834w5wbLcr0X3czNzth1tCIt2kSQ41V7U13qs1sKBqH4nuw?=
 =?us-ascii?Q?0OqWEqI7VVm6Af+VHSWf0AR39s9a3tD5okZSjqdgTpt+EyjMoeBu0dQP4KRD?=
 =?us-ascii?Q?OHrBXYSHY97x3rDmKBmycIOBrxhn/Fq7U3WvdqcDBl8qNL+o2R3V4uRJqH21?=
 =?us-ascii?Q?jxn+nI+UiB3AYYridu0vSIuZIzg/4Brl9kUl1mb4F06uwf1HdPq6kPIlYM7g?=
 =?us-ascii?Q?fOkN6BqCdmLovRJhv+T6io4kIJiRjMpZ8+2joDmkB37X6hXrtNpuqhBlznKf?=
 =?us-ascii?Q?E1ZzzjixKhKEuz13KQlg6C5asZLZm6FyS/vbv6qVtx1L5I8yZzIais8k8cpP?=
 =?us-ascii?Q?Np3cyNf4XWsnEehP/nMOrhBoEFbV0q2B1uUsuapib6+7SgE/2mUfseJ0dRMy?=
 =?us-ascii?Q?iKYBRa7nZJYUQLpUBdL/qcAjeAZ1+6yci2agAWCCMGrt6ifAAtji4FlI8j5P?=
 =?us-ascii?Q?II36q3WF9g/roK2TM3nX+FloV1a5sUiUROOvYOZPeWaLd2MhmVNFiZcisenT?=
 =?us-ascii?Q?7eGvePnz8BQ9lOUiU+v+q9vEPuBnSyjB77qxElWtUscHpAm8xnbrl908905c?=
 =?us-ascii?Q?qqMjl4sG6G4TTaQy3ac963gWuc2S24KkLBmgRKbAr0ye+z29jZzovvYvzzP/?=
 =?us-ascii?Q?ymsfXL0jfwP6NF13Y/TjTzX3sbh1Fzc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ff5283-4133-41d6-2822-08da508bdaec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 18:04:43.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL+JmHTLQ84m7bZAdr0tYjesmRJhjcVRjD3UgM+rUqaOM3/gsZjdonaBRnciDXcK5xZc3w8lIgdbbsA2GOr2OVow46Flv3KTbtIsDX61lfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add a trace event for CXL Poison List Media Error Records that
> includes the starting DPA of the poison, the length, and the
> the source of the poison.
> 
> This trace event will be used by the CXL_MEM driver to log the
> Media Errors returned by the GET_POISON_LIST Mailbox command.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  include/trace/events/cxl.h | 60 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 include/trace/events/cxl.h
> 
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..17e707c3817e
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_UNKNOWN);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INTERNAL);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_EXTERNAL);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INJECTED);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_VENDOR);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INVALID);
> +
> +#define show_poison_source(source)					\
> +	__print_symbolic(source,					\
> +			{CXL_POISON_SOURCE_UNKNOWN,  "UNKNOWN"},	\
> +			{CXL_POISON_SOURCE_EXTERNAL, "EXTERNAL"},	\
> +			{CXL_POISON_SOURCE_INTERNAL, "INTERNAL"},	\
> +			{CXL_POISON_SOURCE_INJECTED, "INJECTED"},	\
> +			{CXL_POISON_SOURCE_VENDOR,   "VENDOR"},		\
> +			{CXL_POISON_SOURCE_INVALID,  "INVALID"})
> +
> +TRACE_EVENT(cxl_poison_list,
> +
> +	    TP_PROTO(struct device *dev,

The CXL memory device names need some decoding before other userspace
RAS tools might know what they are. So in addition to
dev_name(&cxlmd->dev) I think it would be useful to include
dev_name(cxlmd->dev.parent), i.e. the host PCI device name.

Other than that, looks good to me.

> +		     int source,
> +		     unsigned long start,
> +		     unsigned int length),
> +
> +	    TP_ARGS(dev, source, start, length),
> +
> +	    TP_STRUCT__entry(
> +		__string(name, dev_name(dev))
> +		__field(int, source)
> +		__field(u64, start)
> +		__field(u32, length)
> +	    ),
> +
> +	    TP_fast_assign(
> +		__assign_str(name, dev_name(dev));
> +		__entry->source = source;
> +		__entry->start = start;
> +		__entry->length = length;
> +	    ),
> +
> +	    TP_printk("dev %s source %s start %llu length %u",
> +		__get_str(name),
> +		show_poison_source(__entry->source),
> +		__entry->start,
> +		__entry->length)
> +);
> +#endif /* _CXL_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl
> +#include <trace/define_trace.h>
> -- 
> 2.31.1
> 


