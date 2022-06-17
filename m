Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1710454FDB7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiFQTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiFQTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:32:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26EA185;
        Fri, 17 Jun 2022 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655494352; x=1687030352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3gzeJtqcX0o/BkQAq9o37TbkBECXFUGNTf+Benowf8I=;
  b=g0ms45Ha6pI/xqOilC0Tl6K9r9KMAtusPCX1Um/9tSw5UlMJiQZtdK7C
   Fsk2zWcUBTX7kL65OFJ9njB2pj85wgRPIZCuybq1ySCEhE6eLEcsxZAxf
   Uj+YZZVd0Dc7twwkc/6J46qa2dCWF0ihw0Pt5avwpyUFiMqn26KAL3GDo
   6LF7eEDAKBsXAYl5pKMNQqgI6fXTAH+1dIHgPcjfFwAcDN1nVSwj9f/G+
   XLO3lT4fimUPjhYGIMOSAqCC65X9l9XiMROAedUndVAIXvZYeBIyfxH5h
   724MIwhM2KCOU5b+Nim185B+keeiUauksBtQ7s0oROVt+1OCcu7QPXwwt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341255386"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341255386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 12:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="912731828"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2022 12:32:32 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 12:32:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 12:32:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 12:32:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMcr5QkDY239IIa6J/l5jUTARJYJmqJ9QS92ciGBDJ8NZ1+QP9woAsZO1TpMhwlRvvB7RGvz2D7Xy7UBEYWB159bAtzaGgWmL3u9th27VHlkI1Fu7OzR2GRInu0NBK9oLn2sRRQ0qlH2HVUDaBDo0FWwdViUcy10U6ol17PuLTyhAjo0LINbnrAs/+pqK9wrRbR+1cCOzW4/GF76GfWoEXAgEQEncRjtC4jz3mmYCMf/uqcEshZ75OtrZ6YpU0HSr/+sxqtrUF0hgr6XcmZ1jYD8Jg06wIKu3J9kUHp6CoKftrfa/2tF+VFfOWsragavUYcK9/IRDLBay8H2+I4M5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRMh9my0YNiucuTkpRvFn7oIV3z9+oVbQ1gDmDsoOeo=;
 b=DfXmdoWNScg3SG9hzgHXY24nUaQ3eOlj2UdQfqHBzmvH81gFpRXVdGUuu2oCBKLENrp388XtEcqW6+cB8FyCDX7tdoE0tfwTenPZYvxbjMnzT3R4C7sm3esrAbHUrnPuY+qrgYdEx2mSDUVMPBnRkZ9f9AriRfLJXNoHsh95LlGdfMXKwghUY02322eZkjCRwJhOQwm6W2EVbkL4AEmde7elfZMARuOJvEsJmjmbjAozdkjk2ysg4Z3v2nU6LgGfaLjYSZHKLNuIyTfmTcg3Hl4KyY/ki9+1vyMExk7vT/bxbKr17hGx/9Cs181aBC6n5VBF0uRkbXYtE56GQv4bhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5289.namprd11.prod.outlook.com
 (2603:10b6:408:136::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:32:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 19:32:30 +0000
Date:   Fri, 17 Jun 2022 12:32:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <62acd6cc72637_844b129463@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220617150508.0000266a@Huawei.com>
 <20220617162935.GA1532720@alison-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220617162935.GA1532720@alison-desk>
X-ClientProxiedBy: MWHPR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:301:1::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5f4d13-27dd-4f75-f572-08da50981e3d
X-MS-TrafficTypeDiagnostic: BN9PR11MB5289:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB5289C675843CB3C27DA30473C6AF9@BN9PR11MB5289.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IdKRGjbzsTqmFGSQiH8r1pc4g3WgOXkij5evpfQ+DcgihEFEnWwU1u8Ik7QWQk5zXkJ5RZSW3Oryy4R7LY+SnFbC/CSjrgvJBkolNb0AEUdPnIalJXWBoCxjJU+uWTUsSxn8LXrtjYeg1K9LAOs1GMAKL6s13WYPJWP0MNn9asfmk7+ZQjC7/zJdCbRw+skFy94QpbazNS4UdW6KkN2zhFMSqqcrfawH+X/iuRnypYff2aJWNi4cj33t8+Mh6sRxaJ7et+qhZcuFJU5EXSgCk7PS6l92vwgz8RnUv/aTcILf44q6CWC/WPAUGs4Ij49iY0xM6YM525/l0yUePtaWfAOsiDgJ5sYeMxdkOE88mWTwS9d5qCHr66ltdgIACmgOieuN+Mbbs5Ac9tWtdjrA6WZEw7wW0MVqkWf8rsr6ODsDRtxmkgb2D03K8AUnCghDWOR/0ti0l4M/UfvLInHDmvdTvOhbv9wvBLzWHZMb8hiYmVSqU1z04IiACR4A7y3HqCL5HRZ7qXJJ3W1s7Kwx1tsqiBtEXwP+13HfWlolw3KFPvr4KzWrTQrdqGEL3BX1fGPr8ZpaklygzQj+/mwlbqcxvPQBaSGMq2GgFlzsEfZkeVJGMCKdBWYKbYWENgzrfLWPdk8XrCiXgGpn+mc/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(498600001)(82960400001)(8676002)(66556008)(110136005)(5660300002)(9686003)(54906003)(6506007)(26005)(66946007)(83380400001)(4326008)(6512007)(38100700002)(2906002)(6486002)(86362001)(15650500001)(316002)(66476007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2Cdqrcwzner7Ld3JMvYY8XowxYiGhuW2j+g6P0CVO4rZadsCqVOotnkM/Be?=
 =?us-ascii?Q?TgPXAt9nUT9Qm/xKCwxG+Qh8C12IXVa+gexhFz194zf0CucQT5xZZTDrG4iW?=
 =?us-ascii?Q?/lTYiUF9Ow+AEJMhYY8i6z9SeozkyuG4IZOtK9bxrSqzSbg7yqXW+Ibbp1bV?=
 =?us-ascii?Q?I6yqJ6C8yYJjNpwy8xU0Sny0C2c0GmlJk0HB4iPObHRn3SE47A5ESrHLv7lq?=
 =?us-ascii?Q?HXAFqYqYrZJmeCYVw5dXtFimx0FP/jvom94PGlcii1DH3YNRGZbhOJSY8vA1?=
 =?us-ascii?Q?JsMzQVZggGgPLePnAAnRTMpfCwNLZheYXJqXJNkwgGUWdj75JowCH9qEAFgr?=
 =?us-ascii?Q?qLdpi5JMeENOlXHZxEa6q9bCKc+CTN0oxNJS4flMellsIMSShRmVKfCz3vt0?=
 =?us-ascii?Q?Ak7aV0xhDKc6AmzINFkm9z1zy2/D/5Yl9+lXO3cVzmlrUwq5ZwFU2jV4YFfS?=
 =?us-ascii?Q?VTgFxIlmW9qQixyJae1uP+EP8EUQ5o1q+sZpDpIfEpF37b29Edwcfc6V/6PZ?=
 =?us-ascii?Q?IpNxT8kWZ01cuF93iJoOzIR33y5Av9cLizGQpBhlrz0PotZ8NT1l2loyS1T9?=
 =?us-ascii?Q?J/9yo+2sGU4NxJyWtFCBkDn+H969LesUs56jWIA7cunsdq8dJcIKB0KK09LJ?=
 =?us-ascii?Q?gcWJ3sSnUpL7WUpyQEbjTTWD8afYe01MUNMP6b5fRWQN/icDK4Thgvgwxpto?=
 =?us-ascii?Q?a19NtIdfdSzJilipQ5zWul5FkmHnbV9MEvRkXwLkWQjSwDNVaR1gHBF6p//B?=
 =?us-ascii?Q?h41OWV9KUxWp9ETelLBdRgQct5nWONCJ3IoKDbnFUMAJ+cVgMwGxYIOXR+Fy?=
 =?us-ascii?Q?hVj5c+eC9zvn91fGGDjSCxgshgo3gjXtJ+vM4xtWmayn0Bp8lfgKfyRLz+rD?=
 =?us-ascii?Q?NJi3Q0IUE43qmxaPlneE+GCDsW9tUWLMuvO7QOdDPPaIjnhElDzwIRnjOUz4?=
 =?us-ascii?Q?aaUIrcCIELkTq2d+wipMKinPEuJTcFfEJQ7zEKZb8O4vnyNPmHOMvk91wx+/?=
 =?us-ascii?Q?BmMkfPA6QjhciDvRsYhzzdRopUUFIsFPECkzDkTcCOZXZgOqBj6ipffPxQdS?=
 =?us-ascii?Q?1jB3yl+nCcpRaCFjvF2cSC83V7i+w4mPCaYjAYg6WBR/9zHw6d4Qx6JaIhC2?=
 =?us-ascii?Q?138WQtAuHZNCz9NUUJuGxNUbYqLn3DND294/lxccTyUcE3FUJ6gedWcz+sSK?=
 =?us-ascii?Q?DdaNLuim4ZPIpt42DS9bj4C7a6Wf6HjOtyeu6AnjvcTseFTY9UB6hOkX2fmx?=
 =?us-ascii?Q?FyfAFekEuEdAB5iefQDovly0qX4JYY3XdMGWKND83Jc7m76HpcXO3GSP9xOj?=
 =?us-ascii?Q?73KDMNQVw9VBUqq1yfiqEjOFEir57VUiNfdrDq1CNJjSF5Haj1AocTFxp2xz?=
 =?us-ascii?Q?nts2A0G5NuH076mRg4tNpO/cCta+q73++paBKDtWQTrku0LXXN5UxE8ZTrlR?=
 =?us-ascii?Q?xEHlHxpn8KDtxiOUPaM/ApDZB6obQt4J/VCLFeHW93zPanz/+GNDW9DxrFAU?=
 =?us-ascii?Q?AnCKilJQd9qUAr6AU8TaSAcaIm9S1amnxk7w8S912UE+d9pXPj+uwGjGnlXh?=
 =?us-ascii?Q?c8dWm0k99SlujOx4vtrFDTrxKYe5mFVHDYr4efCCaH2KwYy/TyfFnyBCRO+9?=
 =?us-ascii?Q?16FhrH3xJGu+98eMRJgKUkvrzVnCmwQ6IEbC82zfS5dzTFIiz+9UvhQumeWM?=
 =?us-ascii?Q?9KojM1W6ArIu0nbtEaT6XlUlPawlxwMlait/bG/WMSuMTb4PuHxREr5kOLKM?=
 =?us-ascii?Q?62KBo7+KbnemVbPP0pPh0hNPCtF2t74=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5f4d13-27dd-4f75-f572-08da50981e3d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:32:30.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdclxWAlWAfSIANMn/qEo+H4VP/mcpbQCYp/gX84+/jta4grupSW9blo82W4+QMxznXlRekXJ+RtT2qsYlVJuKjbo+tBtMKCXyZSe2aWdEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
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

Alison Schofield wrote:
> On Fri, Jun 17, 2022 at 07:05:08AM -0700, Jonathan Cameron wrote:
> > On Tue, 14 Jun 2022 17:10:27 -0700
> > alison.schofield@intel.com wrote:
> > 
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > CXL devices that support persistent memory maintain a list of locations
> > > that are poisoned or result in poison if the addresses are accessed by
> > > the host.
> > > 
> > > Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> > > list as a set of  Media Error Records that include the source of the
> > > error, the starting device physical address and length. The length is
> > > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > > 
> > > Retrieve the list and log each Media Error Record as a trace event of
> > > type cxl_poison_list.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > A few more things inline.
> > 
> > Otherwise, can confirm it works with some hack QEMU code.
> > I'll tidy that up and post soon.
> > 
> > > +int cxl_mem_get_poison_list(struct device *dev)
> > > +{
> snip
> > > +
> > > +			trace_cxl_poison_list(dev, source, addr, len);
> > 
> > Need to mask off the lower 6 bits of addr as they contain the source
> > + a few reserved bits.
> > 
> > I was confused how you were geting better than 64 byte precision in your
> > example.
> >
> Ah...got it. Thanks!
> 
> > > +		}
> > > +
> > > +		/* Protect against an uncleared _FLAG_MORE */
> > > +		nr_records = nr_records + le16_to_cpu(po->count);
> > > +		if (nr_records >= cxlds->poison_max)
> > > +			goto out;
> > > +
> > > +	} while (po->flags & CXL_POISON_FLAG_MORE);
> > So.. A conundrum here.  What happens if:
> > 
> > 1. We get an error mid way through a set of multiple reads
> >    (something intermittent - maybe a software issue)
> > 2. We will drop out of here fine and report the error.
> > 3. We run this function again.
> > 
> > It will (I think) currently pick up where we left off, but we have
> > no way of knowing that as there isn't a 'total records' count or
> > any other form of index in the output payload.
> 
> Yes. That is sad. I'm assume it's by design and CXL devices never
> intended to keep any totals.
> 
> > 
> > So, software solutions I think should work (though may warrant a note
> > to be added to the spec).
> > 
> > 1. Read whole thing twice. First time is just to ensure we get
> >    to the end and flush out any prior half done reads.
> > 2. Issue a read for a different region (perhaps length 0) first
> >    and assume everything starts from scratch when we go back to
> >    this region.
> 
> Can you tell me more about 2 ?
> 
> Also, Since posting this I have added protection to this path to ensure
> only one reader of the poison list for this device. Like this:
> 
> if (!completion_done(&cxlds->read_poison_complete);
>               return -EBUSY;
> wait_for_completion_interruptible(&cxlds->read_poison_complete);
> 	...GET ALL THE POISON...
> complete(&cxlds->read_poison_complete);

Since this runs in the context of the requester a completion feels out
of place. What this probably wants is a mutex() protecting the state
machine of the Media Error Record retrieval and the "more" flag.

> 
> And will add the error message on that unexpected _FLAG_MORE too.
> 
> Alison
> > 
> > Jonathan
> > 
> 
> 
> 
> > > +
> > > +out:
> > > +	kvfree(po);
> > > +	return rc;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
> > > +
> > >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> > >  {
> > >  	struct cxl_dev_state *cxlds;
> > 


