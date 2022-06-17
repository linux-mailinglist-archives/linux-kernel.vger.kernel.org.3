Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334DC54FD19
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiFQTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFQTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:02:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8EC10FC8;
        Fri, 17 Jun 2022 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655492570; x=1687028570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kLUEXbSo2TlFD2RVrQqzxAndxRREBalITeH4xZQMWWU=;
  b=RKpX9/UzhYikAspXcM59DbZ6aHE0+PO8s11T5jIEtylONOzT1zlHQG0X
   2LYcdSetWTgssNDdsajzX0rjU5SqDOn+SqaaUjjMXsegVkYqu/DSRQKho
   NlgJyLaP75dqLqP+WTWHBcIuLwGIYzH2EtdftgUweNylrTykvlnklIDMS
   BAcrzglGMoOOcgDN6DzbEm8mEod3tKSq71jNqOf6qXuz0UYQUPlupzOJj
   Xnwh+rE3q7exEWP1BHrY0zagqZZ48H2PFQahiA6ZuNG3V+oXHKPSV+TRG
   JT7EfB4dQ4jZb6QKyrIsNQ+km8wpiCCrWXXCAk7hYfaao20fMY4FoEekR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279599536"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279599536"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 12:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590234961"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2022 12:02:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 12:02:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 12:02:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 12:02:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 12:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLWwIrEer3WW1YpzxU5c1EUgQIFbvW5vhUTEp6AuHiZR2nYtys+ibyWN4RhXxcU1E0KnAQmU7F36z2XCd07FiUmW6a05FoIy0RIh1M8H0picEtJlDCLc9h/qVFTyNIB7zNcy0NOc9yONjaQZd5xKwA4ftJ/vNeOrthyoCS3yt+TIBQ0N5v4+XUoSdlMDlQzQM7mmB+XTuCLzvnpvJUMiei4aFwS/dSxtHmvQO8hdxGuQL43C3S60EKCdSizq4sr8fogioqHxPq8LokJ7b+IteTz2uJ7ANXT/IPl+kyHLN4hKVTwXqeiFO/mr3QeMQFkgp3EuUEVWBtnTuKdkIVEapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYkvbPY5B0l1huWiRTg4FcGZPjd6in6vVUCa9OZMOrI=;
 b=bgu4jOoXHrxrBY1ZTBGQ22THgvASlzLX7QN8NlFNb9ysdgf51cslN3A0LoduFWFlR7Lk5AFfXUFnSKzjG6UfpdYTPPx5WNgPQjKRuzHy+5OeoNEaGgneEMgpqpMbFP93KU3fNrOYlSysPQr848HNVPbPof9ISiMZvhIVWSP2hYoVtMRYglMPJmHYdnnKrf0ygXd0qh/wipA4hGDFb4G1jCgScduTp/CMY3/VDbzoIsOLdAtoIM+vq6CHCFaSx7acvoCgA+NI8mX/sZuhKIVp8AA6Q8IhWTKU7HiuPB1HQwUsRSHquUbXzY16bzTIltQTnA7WRmm5P2CmZygAcySUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ1PR11MB6251.namprd11.prod.outlook.com
 (2603:10b6:a03:458::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Fri, 17 Jun
 2022 19:02:35 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 19:02:35 +0000
Date:   Fri, 17 Jun 2022 12:02:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <62accfc892f74_81c5e29456@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
 <20220616203400.GA1529208@alison-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220616203400.GA1529208@alison-desk>
X-ClientProxiedBy: MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae4a2535-1c9d-486c-ae1d-08da5093f051
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6251:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ1PR11MB62517C5039A4C13B140DB56DC6AF9@SJ1PR11MB6251.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaXBX16TQnCifNuUUxJ5oBGxvIvzzMpIlkm1D+WfCVHBBNry9FFus9LJnb3oWl3Cugog44g+NwgVIQolRZ+dVPTAL5/fqHBNmiPfg6F/X6sIHEPSIGkQAyGI4MveXtGUALCa2Gwd3Wg503mH9WP83L11nd6jDz1wr3mQxvBvjZORaCZ92D//TPaIyXuXtHaPsQt/Tb2me3YHVcep7U7NFa+o9gGNgscB5I0yoAv1tYDOpfnb9AJxwCqwPPcNWl5loViGg5Gf4Nu7HMhtqUUyaCfBoQ4tz2ePTTnWtiIt4B/Gk85TBH5rl0SS4vUOgorqz48CZQHmAaxFGgRMv9wW9Ot/pu0RdmcXEva7uh5DKdo7siAR69T5aEYN9efNgWK73LNPxzlvU/c65T350EoZXCRq0b1Ouz8CjajT9bkNuZQFJATt096w/cARxBe9dckQ5vqMEu2RNiob8N522eq6Bi/uvMNtfbMaMbYjepEnZQDbB5GQTITFGuitqq0SCOCvDhmFWYMYA9iwzHrhLv0G6U3/+pvksi9bYQ9dEqXg6wbSupzx7S41cgSrga2GWmDrcATQbkAAT2n6WA0kPeNQ/1+IJN/+jAvsZi45HmPLqG4DEhGi+lJ0osJfWeXW2a8os4fhryexGx1AUeuB6h8/65orDrZUgSAcW64FdEzsa3WDI/bZXszCFnd9sybEOaEJW1Q801kbqulMc5UcWKW0Fh2Sm/Il/oJkRj4OHNusejw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(86362001)(38100700002)(5660300002)(316002)(498600001)(82960400001)(966005)(2906002)(15650500001)(186003)(110136005)(8676002)(8936002)(4326008)(66476007)(66946007)(66556008)(6666004)(83380400001)(54906003)(26005)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CBooW/hEzu3wxCNa5NfQiIKa2P3mctdHJ+yXDyFeF1JgQYzVcOXJydelc/U?=
 =?us-ascii?Q?5GGRjAE2oiKDpRIkYyfLsLrymf9KvlTlN9LC9x+DtLae0m8SzZaEG383OEFI?=
 =?us-ascii?Q?UA6F4cgpim6KsQpl8/r3J0TIIAM9tl4TPR0/Y4akYU4NMHKs/PK2qalcfIc1?=
 =?us-ascii?Q?t/GCKBszOOk+a4PaqQDRoXxKtD4OsMJyjpmrWs5HKJeF4LvNQ+rAAgyAUy+B?=
 =?us-ascii?Q?AW2j5dzA9a8Wp5Lzq3CTtAVYv2wD66DOnnyTrBHr3sUw0zzGa2PJVZ8mS/NC?=
 =?us-ascii?Q?HLBC5JulTPgOYMF1k4XftQp05S13fuvF9cMNVpds5IxKIVBHQMZRwGdbZ6YN?=
 =?us-ascii?Q?3xMQiBj0MP3auARKP5H0fiYYwZgpjel6DBiVND2DmtxtmOqRJ1Z9bmaoLtPm?=
 =?us-ascii?Q?zvIDPWuCMG/x9KsgYnAFIfWpuhesGFBYnaHyTRpKEmH0qXYFjKMhcyHRHPxC?=
 =?us-ascii?Q?m+JcQ67s8EXiZ/SgWaFvdTUZZq3vgmHryzBlqKeb+SiTh4b+dqMye6VMwpOK?=
 =?us-ascii?Q?8OvDJVFH/Lz4OatjM/NQi5LUxpXOegWHalK7xLAkAqpyBSb3XpiueIMiM2jM?=
 =?us-ascii?Q?RBTEtfbhsynMBV3kdJtDH7aP5QUAdG9lAD+KEsfxzpx4RslzfYxEUkpCuKn9?=
 =?us-ascii?Q?izHJX4DaLACWE+jTJ9c473CUZA9J3JVAgD69LQzKXasqzA/SiLoNsGLsRGXK?=
 =?us-ascii?Q?Y7chEKWAy/CbL2f63R6l1nVU7ux+6CX2ecqRzLPm+YxbUfhXXK1ihW6Rm8HR?=
 =?us-ascii?Q?RiPDeRqYD0BHG9AUZaSyUQOGVFHNrz4rxp0olq1f9O87nLxlIdEtdCdicETr?=
 =?us-ascii?Q?N7VOkruw8D8OJvz9a5ZNvwytuTxOO6icVfe/cqYStC2Jsip8KzFC8nLk3K6w?=
 =?us-ascii?Q?r5FugxQbw5MyP5s4VFBIwVjZeVKXeeFj3HDFBSNqnsE/V77L6skHzXNQYY31?=
 =?us-ascii?Q?lTgwGg2/guL3ig91bKpYrjOU6QcpMK6ayiZP+nRuGLJcmie98276bPuOhCv/?=
 =?us-ascii?Q?q1uztqoIcOIULEPKWQhyQbl65MJt3944CcvhRCACMD8fCeUnyiz7S/ilzEUP?=
 =?us-ascii?Q?fHwG4Vqsbb0Zmf8C3GCi4hhIYU2Mp//GDpR1+pm01kLh/pbELia9LNILH9oM?=
 =?us-ascii?Q?cn0r36GPdA1tq3g7whVo+IHU+AroVTsKVxMTVN61zGgXddLGeP86Njjgzxf0?=
 =?us-ascii?Q?fh35PMMHWKUaQh+r9qQi4XLZWAotNlJ4Mzqe3q0hDWf+pep+0Yyuoqk+xsFj?=
 =?us-ascii?Q?fw66CQviMLj4sd7pf4R4/r2nz1If4KtqGiCVfMMcyi9+JJqLUIlX3EeBl8v2?=
 =?us-ascii?Q?tzEz4zz+CkXQ1mH8lRI6d6NuEJ/Pzz3PcnMtetOV9FOnHNnfd1MIpeCxgb4E?=
 =?us-ascii?Q?grYAWUacRWxZDEnmUMhCMy51yhB7wIduef9o1NPlcvfVetyMPEYbyKzQJeke?=
 =?us-ascii?Q?eB4AiLcZXRNSc3YypSRo/ANdieWJJEan2efMN4MtjrBbAaH6f9lXLmXTAxJi?=
 =?us-ascii?Q?yNZV+wRrZwaV5Nhfhjq+Kynm8BQOwfU1e67e4O+WEEy9qxM36FnEKRranuB7?=
 =?us-ascii?Q?3JUjZ4v4TcpaZ0ULk62Q0R4irs3KJ0PQJWrO474lU+3+lERil1GhW9y6hR64?=
 =?us-ascii?Q?1NC0HW4rEFdpVRTsUSIJdjDnndrWxING8EDG36vOeMq4OsU0m5ihp26SpD7U?=
 =?us-ascii?Q?Z2HhjqA+JPkLvogetFlhVXRE4wWReoNBXRJ5Tr1qniCfcHfYzt+HNXrL6pBs?=
 =?us-ascii?Q?9BLwvdgFnO1OOZvrXmLxz95WqWdJk/c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4a2535-1c9d-486c-ae1d-08da5093f051
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:02:34.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9+38qP3CqtWFoRdQADU2hnUI9b2vmu0ZkxPuBFo1IENzoAtcnLrR5NynIi0o9Djo0+X2A+PLQHFLilfBHYShNnva/trEU9Fb77bO9TTZ4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Thu, Jun 16, 2022 at 12:43:34PM -0700, Davidlohr Bueso wrote:
> > On Tue, 14 Jun 2022, alison.schofield@intel.com wrote:
> > 
> > >From: Alison Schofield <alison.schofield@intel.com>
> > >
> > >CXL devices that support persistent memory maintain a list of locations
> > >that are poisoned or result in poison if the addresses are accessed by
> > >the host.
> > >
> > >Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> > >list as a set of  Media Error Records that include the source of the
> > >error, the starting device physical address and length. The length is
> > >the number of adjacent DPAs in the record and is in units of 64 bytes.
> > >
> > >Retrieve the list and log each Media Error Record as a trace event of
> > >type cxl_poison_list.
> > >
> > >Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > >---
> > > drivers/cxl/cxlmem.h    | 43 +++++++++++++++++++++++
> > > drivers/cxl/core/mbox.c | 75 +++++++++++++++++++++++++++++++++++++++++
> > > 2 files changed, 118 insertions(+)
> > >
> snip
> 
> > >+int cxl_mem_get_poison_list(struct device *dev)
> > >+{
> > >+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > >+	struct cxl_mbox_poison_payload_out *po;
> > >+	struct cxl_mbox_poison_payload_in pi;
> > >+	int nr_records = 0;
> > >+	int rc, i;
> > >+
> > >+	if (range_len(&cxlds->pmem_range)) {
> > >+		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
> > >+		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));
> 
> First off - you stopped at a bug here - that pi.length needs to be
> in units of 64 bytes.
> > 
> > Do you ever see this changing to not always use the full pmem DPA range
> > but allow arbitrary ones? I also assume this is the reason why you don't
> > check the range vs cxlds->ram_range to prevent any overlaps, no?
> > 
> > Thanks,
> > Davidlohr
> 
> David - Great question!
> 
> I'm headed in this direction -
> 
> cxl list --media-errors -m mem1
> 	lists media errors for requested memdev
> 
> cxl list --media-errors -r region#
> 	lists region errors with HPA addresses
> 	(So here cxl tool will collect the poison for all the regions
> 	 memdevs and do the DPA to HPA translation)
> 
> To answer your question, I wasn't thinking of limiting
> the range within the memdev, but certainly could. And if we were
> taking in ranges, those ranges would need to be checked.
> 
> $cxl list --media-errors -m mem1 --range-start=  --range-end|len=
> 
> Now, if I left the sysfs inteface as is, the driver will read the 
> entire poison list for the memdev and then cxl tool will filter it
> for the range requested. 
> 
> Or, maybe we should implement in libcxl (not sysfs), with memdev and
> range options and only collect from the device the range requested.
> 
> Either one looks the same to the cxl tool user, but limiting the
> range we send to the device would certainly cut down on unwanted
> records being logged, retrieved, and examined.
> 
> I'd like to hear more from you and other community members.

There is some history here that is relevant to this design. CXL Get
Poison List builds on lessons learned from the ACPI "Address Range
Scrub" mechanism that was deployed for ACPI described persistent memory
platform (See ACPI 6.4 9.20.7.2 "Address Range Scrubbing (ARS)
Overview"). In that case there was no expectation that the device
maintained a cached and coherent (with incoming poison writes) copy of
the media error list. CXL Get Poison List in comparison is meant to
obviate the need to perform Scan Media in most scenarios, and it is
lightweight enough that userspace need not have a mechanism to request
errors by range, in my opinion.

One of the design warts of drivers/acpi/nfit/ that I want to get away
from in the case of drivers/cxl/ is snooping the equivalent of ARS
command results to populate a kernel list of poison addresses and
instead put the onus on userspace to collect DPA events and optionally
inform the kernel of the HPA impacts. For example, DAX filesystems will
soon have the ability to do something useful with poison notifications
[1], but that support is limited to synchronously consumed poison
flagged by memory_failure(). When the cxl tool translates the poison
list to HPA it needs an ABI to turn around and notify the filesystem
about which blocks got clobbered.

[1]: https://lore.kernel.org/all/20220616193157.2c2e963f3e7e38dfac554a28@linux-foundation.org/
