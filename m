Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25357891C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiGRSA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiGRSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:00:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DF52AC7D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658167226; x=1689703226;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=28lToqP9zeBnEVtgX1/i2GHIvZSP0ZER7fQwhmLKq/o=;
  b=I5HAaYD5ug+XHWkLMMM64509Js0PhWYoKhnIsFcIt+jX2wBwoEnAKqjg
   Tl3fZx8Yrgrj11b/sIeaiyiTQCRensINN1XUEEnUHBzU8o4WB23FRB/cS
   ToIqSogYJSkomoUwJx5K3ptcSGOZgevcNxoCrcV2A97l1YcuiqjXrJ6py
   Rv/Ea9SLy5fwFjAnoCKZgHxlo25ghPnBYlaALTwaJ7fPybPRPcld7mOty
   MBzLolpV8GRt2Z6mDP3FLOtsy/9I+pua+aZigxni1dI7PjhoEVl2T7dFV
   UvwI61W23+mobP1WC6y+nSR6/HgK004fEjGXmbDm4+ki2ww7JbJ+Fs8OO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="269307571"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="269307571"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="700121382"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2022 11:00:25 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 11:00:24 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 11:00:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Jul 2022 11:00:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Jul 2022 11:00:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3ydFMeB5w8GTFpyt4K8XbC6wBEFUS99fkTcLz2cdac1kyOBlZ0yMMV45xW1EK5zoE1aV2nma6FwSYmgLIOITwYykrsjdsNkaRPrfCEOF/BobmxWta0MzxL449N1QDqy4cXJ5phbz/Az+zAQlycJagOEH5aYHi5i18F4mxmudoYmW+gCRMt6GEQpk6O98XeyawaR5mIx6+BbJu+gZZBq1BENZSjMQmVaToiXTyOQo5uCG1kg9gFV/DJEQFN2WI6ugFO9obnouk7U50tlljLgXQAI88IBfD30gsENQQ+s6A20KTkSwTLexntc52lR8nQuS4WnH0mfC/rdIlV+Wezxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9msLYg+LfULqIUhMKNCz6/Tz8M4prPK9y37Gv7afiM=;
 b=gAV+0f2kXguRIMnSKWN/SaWvMF4rOUrY0cQiHO0BwPMslisr8qON96HAuTxjHigWYGOVF3L1d7AjPEzYhnU5TaFItQAYClaMygsExX+BGZ//bwFLkvSWj9CtPZWOa3d+18/yGqpVMnB6QsDGwyPcpPiYPsQ1fq5S0SU0lGGrdN+gKUSJsY+yhTgwA+Dvr6jywrhoEn6ocGrsQlJOYOM8dSjyqHWgortHZO5xYRzzsy/J96sCfFtFtLkgQcr+a81EFJIGm5zWTTlV5YFn+UGvcX325uk1+A4TMt1WbDeJK80eK4uO8J40YK9Xq64hefp9S2J6isGUYhVEAbIe8jSxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB5487.namprd11.prod.outlook.com
 (2603:10b6:5:39f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 18:00:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.023; Mon, 18 Jul
 2022 18:00:21 +0000
Date:   Mon, 18 Jul 2022 11:00:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
CC:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Miaohe Lin" <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] resource: re-factor page_is_ram()
Message-ID: <62d59fb3625f3_9291929441@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
 <488f510f-00ad-4ef0-1eb9-ac73c7bb527c@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <488f510f-00ad-4ef0-1eb9-ac73c7bb527c@redhat.com>
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a1de5fd-5a90-4aeb-562e-08da68e761d1
X-MS-TrafficTypeDiagnostic: DM4PR11MB5487:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlReWu5T7o7jiBKEuZTCB0v8Kzl0i6zotJHW4sQ4+5QB4Mu4eW9E+55vIasj6FeBYWVF12JvBeMl6fhrmk/wJSrhla9mqd3OP/2ZQW15zlbA1Ux1kD9AfZNol45vpMTn6xgB9pt7EVECR6SvZSMH3gjoBBima7t+l61dCW+kM13ZF/7MisjoqZGEHffWGrRsasYOIa+/dktORC0nkA6pR6VxMDNALPmmpqcu3FViVkAQMTEGJt389NoTngm/qjpPiy+yYPDQHfnxd5WmJEB1egpxwMK2IzoL5jnf489ZA5Qqx3iwLD26Us1U5t8TdQ+pohWau2kO7Ivsjg6jIJ7Cnz1u00pLtv3A0jpZR45bB6358NjNXD1r0CPt1B/nWKN84GXtPJjpkeqPitrFFUghlHhJJUJVAUU1XvIECykcLYkgkrjmoAJFZ5yjbrZhrgQBacnDo6hckhkDi/R/QjKJg20OqZsbop9B+T5zAdu50tU3sHb3lo1f1mcOzlJj+RW48tu7lfFexlTNZsQb5WD5tFRQkaSiVbXS/7+9Jg8RH18e8Vh3swZu728lPPt+y+1H8yYyANTZCj2T3JfQSxqROQmn5/NRjRN3kC0mRVSRZIVLL9s6jfjQM9cIKkk9Rq8e+rLefyBN1fuxZ6lZZAGPYaq6mD5XdHwdj8Hu5xSYzecMzIucQyUJwEG3ymo/PzNVAUreHx681x1rNCTssXmC2ntlkAcPA7ECAXaDNHgF+K0X4mkDRfA7+M2LglsYZvVy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(39860400002)(396003)(346002)(6486002)(82960400001)(41300700001)(478600001)(6506007)(86362001)(53546011)(9686003)(6512007)(54906003)(316002)(110136005)(26005)(83380400001)(186003)(8676002)(4326008)(5660300002)(8936002)(66946007)(66556008)(66476007)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aqru8yfKTrQ5Cy/0BrsHWbDovSziNQhk+EPDw6zzmIDNeUblJLpybQLKnLKN?=
 =?us-ascii?Q?KvOQ2u98ExfH0U3/HFCBHCJIS188HqJQovuaqH/TcxJumTaBUXam3Huw25BS?=
 =?us-ascii?Q?/JRR5Jtba17pjql0UDT+6vMYCnBWm0dqRGOD1L1redO44/QHucy5SJwpSKOI?=
 =?us-ascii?Q?mcHa14sOF7rh85eYZRxl/UYyLYwhwavasKFB53isv01kpSU1Divs7WC25w2U?=
 =?us-ascii?Q?YhFwGgv3Mj5OvkVBDU++/FD9ZKHMXiCsUJZxp0BSpnh2DgRU/v7kfvnyP8sq?=
 =?us-ascii?Q?P90QIMR/RcGFGsEd7T+A5xSvF+Tpw46aY/5ZGFRzHxioTrFkgWtigtNN476V?=
 =?us-ascii?Q?QK5GgN0p6DZc8A+4Qgpqxzo5pDcJatX0A2A9aE+d/a1/3Pinj09K+J29wX9s?=
 =?us-ascii?Q?N9wPVmETMTL9iPTabTcesx/yAGv5Z61KHpcKt64UMxKgo91pg8hDKaD893Q1?=
 =?us-ascii?Q?7/4r5U3b+Ubgq7D5HtPwu6u8YqNlufOidIqSTsUOzepEHcOXJiS50kaOlyqZ?=
 =?us-ascii?Q?i0vjSWuyzObE4fT33ZQBN2+EIdcasE0wKy64GBB44L7Me1anwdPVtI/z+ayb?=
 =?us-ascii?Q?/aEOR50rnhFno1RtQwvdUIgUlnJApjY3us0O+wPL7T3I/XPZZtBZkvG1Pl6h?=
 =?us-ascii?Q?uHRRWY9DcJJ2qnZCZaxGB6+v5ipVuu8qqSSJXKG6LxBF0uuOejsYQ9CUB2r7?=
 =?us-ascii?Q?ge29mFfmkAK0Pj+lLn4CUReq0pHmMBH+7BhMZ5yLSPo9EjY6f8rFgjqBBvdU?=
 =?us-ascii?Q?TvSpdl8MlwCCKTlHDMbxvW3QGhdwdvdM3f9tdm/ZZqMrIZO9F3cEMW/SHZ12?=
 =?us-ascii?Q?pChRoB85Vt9Q41ST9DkBXZftqspcSuCN7J3/7n5VqeO+R3qaiFPByQ01342i?=
 =?us-ascii?Q?/B1YVo1GA7N9NIA+hmg8U1p1X1QmAZ3KZQwsdq+Vse2T9nuO66RHJRbCXGX3?=
 =?us-ascii?Q?QxYQxbSQsfWjShTAAGyYLQWRGjsVOxRNKn0Y5kPWrVtAYAyyV30XpqMoX7bn?=
 =?us-ascii?Q?75t7253HCu5xxf8Dkf+pCzyWlDYLkY/X/HkySfyLWVthwJZ8khw0ua21uTbT?=
 =?us-ascii?Q?K/8V6r4QTRhE69JyoXTmqTNodzj9ATAgYmuFMwRd25FJiamTujQwuhhrsFeY?=
 =?us-ascii?Q?qsg7E6AD9EWtGX5khAU8D+6+G5YHtY2q35Ilz3l7whc7qOm5uqfRiuHKODF3?=
 =?us-ascii?Q?W4B1oDvzlAzlFQSUasyS1PRmM9ISquJKkPkXC8JZKqD6Z1krYoJQTL054ICm?=
 =?us-ascii?Q?bSKH/d+i8r6WxXmBWeb4jaexjKGg8pZ1r1fq0rNiKkRZC8Wc3O9OyhUAKBzQ?=
 =?us-ascii?Q?zbX5F54WnXLZZI+fL4sfL7ju8TzdixsU5PM2K0akQuog6jDaGyD9SOW6nHxN?=
 =?us-ascii?Q?afEgJxkcA2pVCxWrzAPK6weR9Sij5yUH6OeR0sREYvfw76iv0CaNPOYU5tv9?=
 =?us-ascii?Q?XM4OC8VNKPcGJNNzsO/ZAwbkR0nYuq/RgCW0sMj4EIbgQmf0OaCb4di4MZh8?=
 =?us-ascii?Q?LKYSpEEMne1WXEAZ+zVshprJfocNF5uj4yzVJhS9kwWzk/dqC5ZjFoHJjltV?=
 =?us-ascii?Q?EgVmUTRcCtRq1rNNpN3OcZB7kp0tGlB+86QyhwWx97BpjIUOkMwXqkjyqKs+?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1de5fd-5a90-4aeb-562e-08da68e761d1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 18:00:21.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwFk7BxE4i+JGwdUMCmBsWF1CA6O0etypgoSkwouqY+7fW14+Q5Rv4lHbS6moZ5wxSDjUHhO63515BGReuhSgArezypzpPevyu+hWZpWT+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand wrote:
> On 01.06.22 18:32, Vaibhav Jain wrote:
> > Presently page_is_ram() relies on walk_system_ram_range() that performs a walk
> > on kernel iomem resources hierarchy with a dummy callback __is_ram(). Before
> > calling find_next_iomem_res(), walk_system_ram_range() does some book-keeping
> > which can be avoided for page_is_ram() use-case.
> > 
> > Hence this patch proposes to update page_is_ram() to directly call
> > find_next_iomem_res() with minimal book-keeping needed.
> > 
> > To avoid allocating a 'struct resource' the patch also updates
> > find_next_iomem_res() to not return -EINVAL in case 'res == NULL'. Instead
> > out 'struct resource *res' is only populated when its not NULL.
> > 
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> >  kernel/resource.c | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 34eaee179689..ecf6b9a50adc 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -311,7 +311,7 @@ EXPORT_SYMBOL(release_resource);
> >   *
> >   * If a resource is found, returns 0 and @*res is overwritten with the part
> >   * of the resource that's within [@start..@end]; if none is found, returns
> > - * -ENODEV.  Returns -EINVAL for invalid parameters.
> > + * -ENODEV.
> >   *
> 
> There is still another -EINVAL in that function ...
> 
> >   * @start:	start address of the resource searched for
> >   * @end:	end address of same resource
> > @@ -328,9 +328,6 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> >  {
> >  	struct resource *p;
> >  
> > -	if (!res)
> > -		return -EINVAL;
> > -
> >  	if (start >= end)
> >  		return -EINVAL;
> 
> As all callers guarantee that, we might just remove it.
> 
> >  
> > @@ -356,7 +353,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> >  		break;
> >  	}
> >  
> > -	if (p) {
> > +	if (p && res) {
> >  		/* copy data */
> >  		*res = (struct resource) {
> >  			.start = max(start, p->start),
> > @@ -474,18 +471,18 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> >  	return ret;
> >  }
> >  
> > -static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> > -{
> > -	return 1;
> > -}
> > -
> >  /*
> >   * This generic page_is_ram() returns true if specified address is
> >   * registered as System RAM in iomem_resource list.
> >   */
> >  int __weak page_is_ram(unsigned long pfn)
> >  {
> > -	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
> > +	const resource_size_t pfn_res = PFN_PHYS(pfn);
> > +
> > +	return find_next_iomem_res(pfn_res,
> > +				   pfn_res + 1,
> > +				   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > +				   IORES_DESC_NONE, NULL) == 0;

I tend to agree with David that this change makes the page_is_ram()
harder to read. I think the problem is that the "next" nature of
find_next_iomem_res() is meant to be handled by the caller. So it really
should be called find_iomem_res().

> >  }
> >  EXPORT_SYMBOL_GPL(page_is_ram);
> >  
> 
> What about
> 
> a) A cleanup patch upfront that removes both -EINVAL cases from
> find_next_iomem_res() followed by

...a patch to rename find_next_iomem_res()

> 
> b) The actual change to page_is_ram()
> 
> ?
