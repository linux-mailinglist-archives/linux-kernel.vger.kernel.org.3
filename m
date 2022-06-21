Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C5553EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 01:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355164AbiFUXEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiFUXEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 19:04:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B832EFF;
        Tue, 21 Jun 2022 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655852689; x=1687388689;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mg9BdPPQzNKzChySg43/oBIYFn5YHXYnjV2YakN709Q=;
  b=aB6eSAaq5rs7oNcgepsXrPxxWhh6KPgpl4NjJt+oDZMMdqRu20dBcXK0
   xbjx0e9FSbkGSkatCwm7TbleN8uVyjOeQ9X1yeaneOSHfzdoufPTOTLms
   Q8sRP+u/xB2EHOdzkP7xCB9SDnHfH687R+F96o2s/ZDYR3UNslben208B
   L4yATn5kDo5WSmBsmqt3cuDtklPLfCMu1CN4RM3Oeq//mjVCkqD4gYaql
   w37RkJru+vNcQ02yvveI0tvFoT3g/LxdcyIaLH+SVHayHg3gGQ3bgTP5E
   y31PzIOLxz6xbvC6cu5Jj9GhTaY/uPCEKNv15OhOG88tGFRoJcwvLGnLm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344252373"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344252373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 16:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="730048176"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2022 16:04:48 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 16:04:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 16:04:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 16:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTQm2JkQ+SqCreaS3CYDWLdyeI3oAL36LUqcLQnAJCSxZ0Keqe4Ozwi0rKdzpVX655Sj0LOM9CTybfbLlmz/8lqCn3bTeYv0Mga6lZPetGPS+++XLCkA6xyT1XTkWD9cUSHZOglW7AdM+T2yhgN5DEZeeAmvXfwGsTGxfr2wlUuWNRbUgqpOM+Z0XNw+LQMM4VgDDZCwbPzpBq4uyV/1Jj8H1Iizs9YIGPYuoxhMGAM9A/RsBVlfZT0dB0rII+3ohw/1EkoZECXeYhjoEBCVO1rQNe8cs4UBxNRccLYwq+QtT8rexA2+ojoat4aPm979rwBdSfZu5lOPL0JM+5HO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpb33zSqazAumG55ila8GvNx9rIcihtMgG6r53wtb/0=;
 b=HdhGYyVIxVGoxvlb67hjyZARurCaa4WSEh97GEdOnkFTtO4uDaD/2/ulwvcTKDha9WT1Bd7D0vPwPVYq60UniKX+KcLWHy9CLMNqyjyCEotsZGrmShD/e8wsHtwaUBItNGJHL4mBeDrOVJXW9j/SwdJr33FhlFup1k7hdBrlJomlg8C870QitcjIcex8yhx1K9cIH/BGG6xwTgXaSOBUyvfQ0Hsq4Ig49pyWwhnmwTZe/EoAjxqbJhyAshr9WMr16/uixe5QPvinvLXc5M3xko/3Fxx3K3KHTHLHZM+RjLehNSNwiezLPhyYtuCCLpEzjw7K1QbhSPgPO+i9IerGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB3085.namprd11.prod.outlook.com
 (2603:10b6:805:da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 23:04:45 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 23:04:45 +0000
Date:   Tue, 21 Jun 2022 16:04:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS consistency
Message-ID: <62b24e8b61cec_89207294e@dwillia2-xfh.notmuch>
References: <20220621201259.1547474-1-dave@stgolabs.net>
 <62b230881a77_8920729456@dwillia2-xfh.notmuch>
 <20220621223829.zdyqoej76kyfut4o@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220621223829.zdyqoej76kyfut4o@offworld>
X-ClientProxiedBy: MW4PR04CA0371.namprd04.prod.outlook.com
 (2603:10b6:303:81::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fc308df-f491-404c-9ec6-08da53da6eb8
X-MS-TrafficTypeDiagnostic: SN6PR11MB3085:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB3085659271554826330D40FCC6B39@SN6PR11MB3085.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKHbE2Jv0fZplxOduoy6Am4vqsiqu/5KHokTpaC06hsjZ3GDMzza8MpgyZZswvdRjo6b3Gqdht0v75/ntkhB8q6W8q+wY3YC45AEc9jFpIx6oqy+Qm8PMxGLlSUY4iNurh0q8nWSGC3CP0rpTSRV9fLMVXfkwY7NXA7kJLx4adNOGhjqjyWJv1G82nkN8euyY3Ub1BZ+8rVVOzs5nlxf9skRHsYPmq4GWFz5uIn4RdIeoxhZrq4x+LDzWpHYOS+DEeRYvBEkt9li7b5cCLZiQ0Wmfu3CkmJeovis/1Rkg9A5C0CW5VCUrmw82PO06hcKG6EY2V7injeV8lckHUZsAl9CHY4UfUYmK+3lJzciimCpopHvUHS0cauYeJKB/8h0Sdjdl4hNVAA8xg8+lnghMUF8N0XE+PcB6yA4VP2x58DoIhzi9H6A/ALs9uxb4DVfdg0WKJAUnwYa50ob07xNrZc0ziYCa6f3GiLHkF1JUx+nD1tmArYePQzLnnehyLWwNxebsj9yn1bq0/0tkrNMSZqz6ZuxgnZHdA/cwsCsErFzntyuCN+1IDuY9LpiNi/mHYUORHewvHFgWuesg3XaAL35a8XOZYPYU5jx2CbjuY1ji/gg6AQJ7din6vOkAGH8sde5ZaPrq6jAG5Xzg/e45A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(396003)(376002)(366004)(4326008)(5660300002)(316002)(86362001)(8936002)(15650500001)(110136005)(6486002)(66476007)(66946007)(6512007)(2906002)(66556008)(478600001)(8676002)(186003)(6506007)(41300700001)(82960400001)(9686003)(26005)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T/zysDlNHGwtOQ5d97Zp9hP2N0sBVNvlRTerOyDGavtdsncV/9LoxNXzTHJ3?=
 =?us-ascii?Q?2AsRsBErdHB25oZZUoD4GakgKq+SJPMOeVcIh/tvTS+mqI5mTpRz/m00RV5U?=
 =?us-ascii?Q?KmsKeC4w7IiXIVgdUWO6UL6hoQeTpZ/7UXrg8iM3BkkSwUpBsgsuNlYcgy33?=
 =?us-ascii?Q?wlZuvnZlHLh3qwPSwZW5PN9mJLnPi11Emnqym6ABIYpnZxuf1EarWRzSZI5m?=
 =?us-ascii?Q?YiM89BG4bpTu+ptZ+PBHlYp8tjGtDaepT/7iYYTRgWGsu1m6yl7xXn7QIwfz?=
 =?us-ascii?Q?mwdVXMB8MDuQRp9AjurPX/QJab8tBnphQIIRgdWBN0WGBvh0kzUYGpX/KZi2?=
 =?us-ascii?Q?JJksmhXmEZc+9PHTv5G3YC1KsL4UkANIbptPne61QrgKK5uf8D2BGQBF78DC?=
 =?us-ascii?Q?H8B6eG9xAAZGmdB96nVCR4IOoJE8tQ+r4aktFd2xZb93MaRer2BQKcjHJUZn?=
 =?us-ascii?Q?8N3bz3XrqBEMgcMW+RgXLvkgffAChrvbprkKWYQZi8cc+ATBLUStPGOZtIt+?=
 =?us-ascii?Q?Fad+Y7dHuFVvJ/8Ux9K3noe9oMjuFHnuvLZd+ZTzplqQb7+tIzHoUlN3Qo7Y?=
 =?us-ascii?Q?3WCw5xojMHIidMjr/NO3rzyBhIgHlm2IIadtaIzM8cgzPqBOB6c90vsXahmr?=
 =?us-ascii?Q?Mjfbq3EmbsraFoWjnV7QG7S5EaQdvlL6qm8J6lUL7iQk1bFXLRgTFUSzvZvt?=
 =?us-ascii?Q?VHdNSfG7IXmp/lFzLnIse28M7mcV2J9nBKBX7k+ddOuVeMcyuvjzSnmYjyNX?=
 =?us-ascii?Q?4HKgxGT4lGwYFpCsGtEdPAUbolYHce84pfRBulrsFCf9tmVB1LSiFakDMDGp?=
 =?us-ascii?Q?TksV8WAIskauJbojmUQFxW8UnhzBDMB3HoACATxhIKDxTYpUbEyJm7dYi1xv?=
 =?us-ascii?Q?Cs0jMkHN0axZ6GQZGuiLfK21+wg02dpw+EXyd0vQvw0rf957LIG8SO1WDFOS?=
 =?us-ascii?Q?8NUFoEki/VIjpmF3XKF7A2eVg6oubbxWuvvQ2RUvYolVGkcukFRUBGPaVlru?=
 =?us-ascii?Q?10DGdjwSMWe+SA79bIYA2UdhSr0hNKZ0g/bDTR5+XKirS74NbTy3LLc5bv61?=
 =?us-ascii?Q?1l6vb/K3d+SI7CZmiwcEE6ytoVocqg8NKBuaxsZ1rnVcfZXHRmwhlRiGvx6G?=
 =?us-ascii?Q?AdzKtX9Erm0BCpeSue1O1Om+E20iGbRfxa3Djei78f3e3eNg1qE07wXIzGRI?=
 =?us-ascii?Q?BzthO8+hCS9RZqhJjwaCDS0p8Nh7M8XPtKkS4Q8/i4p6OkAX5RL6Z/Ft2/0b?=
 =?us-ascii?Q?zSSRX6dccHmrnC9iYWBECLK03fGSa1nzVAg9I6ITesZB+D+f0JnF21JyRU80?=
 =?us-ascii?Q?KEMqmynCyoqLunf2iRAxLCdMNc+oB2rmlgrNJttvNrPRShpb8BIFr2z73+dx?=
 =?us-ascii?Q?wsblw9Q3EUqBbgPJ4A8KtaqFmDrYyRF21PHRBcHEUMw0hPTmQlTkAJ7hL9mT?=
 =?us-ascii?Q?JC1U2d+om81HiHHIL9laBHNXooVK61wvCn84u5LVYkwAUIHQGkXYyP1IU7uS?=
 =?us-ascii?Q?+bvMWaOfzV1EF1o32Zsp7IVHEVu+cjmk0SRjM/fPGxrN+tNjjqXwrE1t1YRY?=
 =?us-ascii?Q?ELHIq7GbI5ZFtFbwCch1K8/qzXUllUcYXDSkvttuyuBxjUvEFE2ptlXoqYQG?=
 =?us-ascii?Q?dofINA2CEGYKS4qGVx0ILTqjcYuI5nLgeIlJUu5811kgcjXRFupy46XgZquI?=
 =?us-ascii?Q?S/owecoqVOcWFeteSWoTV/jNOozlD56uS4WsYShC7GY/0QvvAhzRth/LQVdH?=
 =?us-ascii?Q?WHDSS2HbeWpA+JclopuBl8lvf9FN/z8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc308df-f491-404c-9ec6-08da53da6eb8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 23:04:45.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZH//0Ow+eyYUyFROvVbKfVHWWDNegmPduJ/EHHhx861bQ52JTKcr+/EBWktRUgZ1Go8Sy/m+W5PDs9SP8NhJJ7nXOadkvYYWhGcVk++ruA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3085
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

Davidlohr Bueso wrote:
> On Tue, 21 Jun 2022, Dan Williams wrote:
> 
> >For cxl_port objects this happens "for free" as a side effect of the:
> >
> >        crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
> >                                   CXL_COMPONENT_REG_BLOCK_SIZE);
> >
> >...call in devm_cxl_setup_hdm(), where it tries to exclusively claim the
> >component register block for that cxl_port driver instance.
> 
> Fair enough, I had noticed this.
> 
> >
> >I.e. if the CHBS provides overlapping / duplicated ranges the failure is
> >localized to the cxl_port_probe() event for that port, and can be
> >debugged further by disabling one of the conflicts.
> 
> Ok. Although imo it does make sense for failing directly in the cxl_acpi
> driver at an early stage instead of bogusly passing it down the hierarchy.

You could make that argument for almost any resource range advertised to
the kernel. The expected place where they finally collide is at
request_region() time.

> So is a v2 still worth it without this check?

I do notice that you also added a CXL 1.1 version check. That seems
useful to break out, but probably needs a rationale for what that means
for CXL 2.0 device on CXL 1.1 host compatibility. So a patch per new
CHBS consistency check is my preference, but I think only the CXL 1.1
check is still open.
