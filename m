Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569AE5B142D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIHFtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHFtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:49:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F994EE8;
        Wed,  7 Sep 2022 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662616147; x=1694152147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PlruszmZkiKggFul+Xw0XzbaWBx8Xsm59T6oRQw7ROA=;
  b=LydntmHMpW4EVlJ98zHeanC1UszIxW8geadMDefqIWo3mcce0sr4ZyHU
   qXiKL/crPd2qgL7Fb6r5E1s81ZXsQkHiptpVQ8i7Kr9TRR3nmWXhRvXPQ
   XONqqlOHwXrNO3/D69CZZQXW/3ak4B/pOXy06YINDJdr4OBAdouhHfRTU
   Kz7yAt+OHzt/eH/MHtYEpCJG7ggFNZWkx72sLDGgpI6puFNXJdpOb3ny0
   06ppQ8gcQyiU0TYKXKvEvq+wggA3lTg+gpNHb/Kz+oQ+5W74QuA2g+rRv
   xm5rIPkKf/JyPRFMBd2lO0M7HRfX2MWL8ppWNxM0Q33cXP3huFTYzP78e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297880276"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="297880276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 22:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="565807521"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 22:49:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:49:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 22:49:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 22:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihRaLgrDV0losRDOsegPn6d/1R4LDVI7xkL0ochV0vIgUJQ+GDrkUM2YgO+CMJZ43TwetjKwoJFtCYNKOoYQR/ITBRfxzIf9mcnFhk33MIq3zykOFDAO3WsBivtRH4KXmBybx1QPxWEzk89Zxlo3wf55/FBTWpBGbdC/Rhc5sndOtgEWq08ue1UNe0mwZCq2M0kMVorCwWtn1uMpbzMZWxCl3TLEr918x492IT/dgtHS7zygCdks3oJE6ng0+hL+DnWk+3ldD6QjzSUdeTkuUnL6SlMpsaUl8GiNPU23pENIJ8xtdfXfB4Gt2dEAe+nMamGIKVqE4Na6KGyiwVeJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NheIfK1dEmbgjxcXh7xGNJ8TfJYSqcUrJjlJIWEcNg=;
 b=SVtzLhEBs0ztfxgfeRnkVQRNPkR29kbF1IVph10K2izMwZdCncrFPPqqdCrAr1Qho8+THCg/zAnaHeRepDS1bc81Nb2ahnMF5FiMNDtmFORDQe5fYONeQTQMUzhixBJ1hGkk/4xsQ193N+o0Aw3pK1SCrTWMeggmbzvLknlcHUvRR4HwWt0QLdmQNmuIEZKVS1eUMxEV2ENnzscV89oHuzm2P7h9oWFoxha8yZcTF90kuAgOVx3UsXqxSmBs9gxN8on6LpUKlfFfWSHiKWzQiWB3pta8YkMWAE6V1HY5+F3FR5Clcj6JUE+JBw3jF4dGXBbaCP8F7WjYHn944UgYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB7032.namprd11.prod.outlook.com
 (2603:10b6:303:227::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 8 Sep
 2022 05:49:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 05:49:00 +0000
Date:   Wed, 7 Sep 2022 22:48:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 02/15] cxl/core: Check physical address before mapping it
 in devm_cxl_iomap_block()
Message-ID: <6319824968fa7_580162946f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-3-rrichter@amd.com>
X-ClientProxiedBy: BYAPR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:a03:54::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e9be781-4fd9-40aa-e673-08da915dd3dc
X-MS-TrafficTypeDiagnostic: MW4PR11MB7032:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFE/BQ6/DWz1i66oe6rFImXLUOyFbbyIPhlTYD3iLTeAQ7ghP7Habh80P0nhfgQRue3JH6cFbfHGMgAKEhkXdcyx5BMER1UnoaL9k7bBFpOXB/zqYpQXxD3qTZepvAYU2IOoR86az4yv/8264VxZLbsJOVqnJAKK2Q0fmdm2+nJyv9EHteEkrDUENgLq+grtjL3iB89xmOo0xYUR46rm8TXvCme+7xZwRr0PKiX3CYI8RWEO8RT1S1paRAXgzzkceZbU/7vBZ4Obwgl/ncpzeTGz4gpbx9tzmxfHaR+28bi4gvyGvGqI1rsE7DFGXxn1slAXyDnw/SqpvwJVfDFHoIbUeXX7nKdVSph5SlYuraM21KlVqdDnvMIeSS1dm0IWfKtneyHBsjXFejJpOu7ORQOd8Z1yrNqzmN5HkhvO5ERljs0+CC3rr9p6o5v323W9uDb//wc0zBRlEANs2FfxTG84VmEimvhlkeN9o6kh/li8y6OiElPNPRcmEEJz5SrvtxssanwPf+zKDLnNq/0WoE1RMyRN6WcVLfkqHwXBY7bzATI87ns8qW3UPEBqDPEQRhbXKdDwAIaWOSs5UA7ulJopC/3M/ZJ5tBTmWlerHH6b2SCCOTmy1Ik2SmvqUuW6gEwNwUxUNZydTYoG5tk73Rfpb8X+bwb+9hx6YQJ5MtGg7QnUsuocbfCa3uuBI3ae3Lp/hAbZspR5oQDTQFqFtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(6486002)(6512007)(8936002)(66946007)(66556008)(66476007)(6506007)(41300700001)(6666004)(86362001)(5660300002)(9686003)(478600001)(8676002)(186003)(26005)(4744005)(4326008)(2906002)(54906003)(110136005)(83380400001)(38100700002)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rp9G8EhOZLXV9pT6sQEWkoCNtSV/AIuOapr6/3TvBpdlPqu1+OZuM4IOJFqf?=
 =?us-ascii?Q?1SP9/I0ZNTJJiZ+Z57p0FPfbRx1DRBs3tGoMJ7CZ146ZO+2JM9jGXMDpFrYF?=
 =?us-ascii?Q?808rEStyk2RqNPcyXTrW8zEU3+vuI7T1dsfJNDMSoBzFoLYUipUxVSHqX/Sq?=
 =?us-ascii?Q?N0ErgxdYNtLQ9RRdCc9aZQxaQ83xDn1tcACD8mGZo9iu2cHlwTR/4wguZ4Aa?=
 =?us-ascii?Q?zOK+RtsZNZwBwVo5cq4HStZwnVlgJ3j+cZHZ1qhYZ5yKZ8F3KBSeCKux2KUK?=
 =?us-ascii?Q?i+u3N8h40VgQlSShSg8mnsiJZljsoveHVIzWBv7NorSUo+AonzrPAJ45WSt6?=
 =?us-ascii?Q?MJMU/45T4dQSvf3ZqYlWJS+o3iQJUwUDmQX0IMyweqIBD1gU/4jG8vzl2rvH?=
 =?us-ascii?Q?zNdLwEPYA/KWd4ZGBZOtQQru3M627JArK4u1RxihfBkXVDLy1LMYMHnDXqH7?=
 =?us-ascii?Q?vlh43L7ks2X5j0BbGc0mSuVlHYqJfFMha+B4fc/CxZoEa22gffmniHWnobr9?=
 =?us-ascii?Q?DPVC0/+ztydZJsU3l4YrRTfgof+GvbtbGnO5PKSxmHryqg8dhvM25mkE++fK?=
 =?us-ascii?Q?9ugIZm1T5Pf1+9pXwNCP+iD3o5g+ZZmDqnmZ9WgjyAXCVsA6P8gzefaf7HSN?=
 =?us-ascii?Q?x8+Hup01fjH4XTJz/iLqdnKLx5Gg/KTtGif6rM79kdA/3c7hMtnCV5CjplsR?=
 =?us-ascii?Q?PWNKpyc5rEpD0DrazzOrj5tCD3Ct4sROcrg42RhKFhOEgwj/ZLVuyQNIRQ18?=
 =?us-ascii?Q?qx4PTZYdSLNcDr7+KEOAjasjgN12pU9/ljchqg1+IAW2nTSDxdsTjlva0BrV?=
 =?us-ascii?Q?Bx6c4XJPqwcXNVM/LsKzcuG9tz57WPDKR8Z0GR+6QzrY8ARkUg9im09Bcpyu?=
 =?us-ascii?Q?wazsu3tOgUpGqHv2VK4DUUwuNYZ9rfFZRfaZTdZA82AeiHHVCnISSMrqljHQ?=
 =?us-ascii?Q?IbMqtmPiFcQyNSMPozADdpPrY/2SE1B6p38X0yjc0/MniBdqLqcxeUXbYTsl?=
 =?us-ascii?Q?qbg+tSEaYS3jqo9Y0hb+T2lyWmjiW8f1AyG5priJ6fOJVrd251AdtNorocBL?=
 =?us-ascii?Q?TO7werCa0Xh5usJov/ucoQR2mkghXSevKu8tIOLQvipcJqcd4w2vDh2iLZ1h?=
 =?us-ascii?Q?JYfWSmh/IInwVBmIQEFizm+UsBXrzBZol0RtCU1scPHVTgnAuNdjToc12toU?=
 =?us-ascii?Q?hDumR0l8guLzyDSmzgxATRW5nDRT4c5VceXC0pn9cbXUUT3z1D4NPE/G6u+e?=
 =?us-ascii?Q?TA/oLu2pPqYHlBNQq57zGaMVFop1aY1zhI3lRHlewwl81mkP4zUVi3stvgo9?=
 =?us-ascii?Q?8kNxj4w+GvsukskT/yHjH7t9TUuJuvNja0+m5B1Sn/LZ7MqJTMK+jpmy1s1R?=
 =?us-ascii?Q?vQp7SEzlQBBbdc+8WU0wd4wToCcnJnGQIUjZ/OUM8vM43pl2KbI19WtcEkf9?=
 =?us-ascii?Q?bpUciZmVCUenz3cWWhUq3AwpjWahuXcZv8jO1RPXdhds8xkO4tCNLP5VcCb1?=
 =?us-ascii?Q?bexz58MyuNzEQqTGA9ABAaYpIALm782FjZ+vAUP9JJ6DBL/irJGvzEyIAIdg?=
 =?us-ascii?Q?LiZPb9L5KVZ4CIQWpe7zBNz5w2OaS0qS6WOX661x5H3GR0ZPSjgzMAZMuF2x?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9be781-4fd9-40aa-e673-08da915dd3dc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 05:48:59.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y361tmUAk6fO0uztD36f9o6ycjRJHb8Rzjch+qaT3+N34bpVPGeOrizhhyoTy2Ek2F2NALVyWGXvNNgLalEys340seq2j5P/seGPklou8oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The physical base address of a CXL range can be invalid and is then
> set to CXL_RESOURCE_NONE. Early check this case before mapping a
> memory block in devm_cxl_iomap_block().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/regs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 39a129c57d40..f216c017a474 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -165,6 +165,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  	void __iomem *ret_val;
>  	struct resource *res;
>  
> +	if (addr == CXL_RESOURCE_NONE)
> +		return NULL;
> +
>  	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
>  	if (!res) {
>  		resource_size_t end = addr + length - 1;
> -- 
> 2.30.2
> 

devm_request_mem_region() succeeds for you when this happens? More
details about the failure scenario please.
