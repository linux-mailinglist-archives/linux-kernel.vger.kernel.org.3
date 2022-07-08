Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F256BB62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiGHN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiGHN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:58:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6302CDD0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657288696; x=1688824696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IzeSJjqaL8QrgCHR6P/Udd+D1v3LRw7Y6OyabCzvxbo=;
  b=VU+acLUhvN9uEaBe9FxjsaqwzyqL3r1qcvU/ufVsc9tmQ7Zf+Vjr7W0k
   DlxYlC/f4tjZEe+ZxwVRoTnYPSufXHP4U8PtG+JNtVPWmQWdfcyK5lm4l
   T7lhZiE4BdX7uFK9F7Jl7B9KL4E2H/T+GdsgOXfUZt4bA4rqB6Mv5q1p1
   NtbEXccWlQkPW/+j2/0AthvTlnBsPvdKM8y64PVldGDcEW7292Qw94+gZ
   M/CqNteVFr4o5q/UYfntEXIrROmSnR7YcpyV4K/Vao64/+A9l3Aj2OxOJ
   q7EvvT28ZMoziHZ/xVZZquiHDXvj0aj4MKq1PynG16Dk5GeIojHzK9Eym
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="285026164"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="285026164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 06:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="651573672"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2022 06:58:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 06:58:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 06:58:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 06:58:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 06:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IntnEwfUfxi4NAnHrejqV3eUjxyCv570hDD0klPZiGasH6aScss5ciqXavDfFCb8tfcshL7TfzDQ+/JuYqpNxozg+waZ/ljhYzgiByiscnR4C/09SccbKfiGSgvE/FnWzQt+gG+4J4Rf8bU1FR6Pbw/wqJSbwZ5NnFP1RU2evBPSNuNZu4Xy1uFrOpfZ9E9Xbbq+STetB2JUoBQ8Vpq6G6YOmMz2iRdBibD24ZV5WJA04Y2BhjSUJdbOYvXqFA7jgPiaqnDULqyMZFVV7KkOcYwMPmY1Oeol532seTfMe3KzEmBsVLisgNhkthfC5M6Mo9gVDrXNpavppiEQ6eSpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SgNHgF7BkEGP8yAhauVjoAqIPGY6FbgZE24iydnttI=;
 b=iqChvs/adVgdteNoLLo7dzZcizy2BYWQ40M136iYXFZmr+6Bzsmn1vrvw9CAlYCMW9bAiQM6Su0zhraxWecc3VF1nSI0daSRP0DqoQQ9AUET6z6/i1/c2sYjQxqQNMXgtvWFOPy5l7OkPEkRprK2RpMl43wG0uc7bL6SItUjOatIwXlfgEGVSHxcV6lz37xoEXJkqQSdk9jDxjuDQvs3KPyQKG+OBsI/6zyG6/x7TY60yTgYnVAFrAyxuzZTAdfj8vUKgU0afCFlJyldNVadbtQmXdVv7mSscdbfGrO456pHAJ+ylJJquAesRYA6/muj9jZON0DPFc+6M6y+YkT0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CY4PR1101MB2197.namprd11.prod.outlook.com (2603:10b6:910:18::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 8 Jul
 2022 13:58:05 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 13:58:05 +0000
Date:   Fri, 8 Jul 2022 09:57:59 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/14] GSC support for XeHP SDV and DG2 platforms
Message-ID: <Ysg350rph4UMgVdF@intel.com>
References: <20220706114345.1128018-1-alexander.usyskin@intel.com>
 <Ysgyc70ctolFl46S@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ysgyc70ctolFl46S@kroah.com>
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2efbfd4c-9549-4e4e-ec1e-08da60e9e0da
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2197:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMgLxmttXr6RwBQ06G8EeyxkC1VBDL10sW2Vla8Pg139fP4HHZjHYpXkDtmUJ8Fk/Tz6ZNfp9gabA7UdrepnQvFmI9bnptpMZr4WuUOzZUH9DUwwbcB5SpoyHv7aFghWKEWjb03xDsgwCWaHW5nfiFZr+nPlkDRCcTh2TJ2HeACZe470YRQqYmP78s5/apzL3NBo7Tv9HdDFeSYxAKRFXrH9PXuuD8LgTGcIOWCG1WLwAP669f2NB526EyxP2O2TPsdrWP2LSGn28A+FsGys6Q7il3bOvGKXEZyXF/AyZOiWyzmHvDZr40MVZlDOBQutnCYjQMoKme9zrL1vWhipsKMxDq8Z6sl8a6tWKEHB6Y33rHCwWXe1kXfZ5H9riVEEUgPsew+3qAVfU9ds+bSeOP5XKEh3TeFf+0ac5CaoScFJl9N1GSQ0JcIih2o6ihXO58+1+fFtFLxAU/Fq6yJ0tH2MnhaWTMWii6NK9s3u48VS4F7cKAp28nhDZkZH13GuNqSymtwdi4e4x9nIrOs5PUo2GwLOjItHtAMuD2Y0uILMxytA997+L40/+pinIK978UDOabcO9Ee7uqu+5a8bo9ZsgNfSNBM0D9SH3dfWgXi7s7cXdizGBEsdc2dN9UqC2T3v1j96XsHXoOkjQWQECFvTanX4QmHBQaE51EwdS/R4kkz1WGlWYlHsCXDcsfSm9si/Bk4DJevDR2IQp3hVATPlGkbAsl5jl16KNv+FuXOcx5ELNhrEV7s3RwCHs4bW/AAnjLYKX1labWRjANvD5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(366004)(136003)(396003)(82960400001)(54906003)(6916009)(86362001)(66946007)(4326008)(6486002)(5660300002)(8936002)(316002)(2906002)(8676002)(66476007)(38100700002)(66556008)(186003)(6506007)(2616005)(36756003)(44832011)(26005)(41300700001)(6666004)(83380400001)(478600001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FKYV1PXSiuDPVr9l0Q+FRAA+TdJDKRb2+y/2hDBg8qt/H1RFfijHNuuL0GcT?=
 =?us-ascii?Q?zaOgb6twOx5rGMWrGJHXxCbDksgzGnBTfTGtIDKJxjmW0k17Wnn9X/oVs0rG?=
 =?us-ascii?Q?nxj7MNAFRTcyCyuM8JXG+mHTzi75CWn/LII0wZiJGMKRfcUeIgbpaKmS67V7?=
 =?us-ascii?Q?297RAdFACB87IGRk0Ioc5Nnpvtlt+dqD5dVFKliV1N3ev7yOKITpNdMVu6Lc?=
 =?us-ascii?Q?jwcrK7EFCn4qC7yEiRwtfuKK/RU4F9JBXoI4RWlD7Y7Te/KsiRmNsb5PCX9a?=
 =?us-ascii?Q?VDQEteOmQmMOiZtg/5te8UiodWJcr92p4H6SMNqxRmTto03VFfCSdjA5PQLj?=
 =?us-ascii?Q?e5u5jwRrfrShSQqffyY4XVq3S///3TqhLEXdIpQzwej6sUyZNohC1XbT0Pn9?=
 =?us-ascii?Q?eZ8dUoYyXgGgDaabUpwff1fJb2QGIy+er5YXu1sZScw0YU/LBvGfhzOOB9MW?=
 =?us-ascii?Q?eKCVhR1aDxxhBgYWAW6qwjLjOsXNwInRFXbIhsv5xP2H9suUE/AepvocD2to?=
 =?us-ascii?Q?vtlxLa85XMki3+RSHlUfUwUFRFspPQTane+wRymP/g7qVbFs7naDvjwCaDMF?=
 =?us-ascii?Q?SzqEBt36gtO4AxBGTE3hhPODeZc2icSTZFkoX6PtZs4x+Iw6+Pg2SLUnUWuN?=
 =?us-ascii?Q?F3dpemgkaOVfZ26DyNwHosDrVu11P6/fW5i3Ne84DW3ZRLiu+1tnzlp1QC+8?=
 =?us-ascii?Q?oHKD9hyDAV+6pwTojEeCanxaGEH/kSkY7a28VY+hyId1zkL1IqlpKtPjO+1H?=
 =?us-ascii?Q?9U7QE5ev6lU3fnl5yXL6EKakgAoF9RxbckVmXHW2Yb5zBdzc3DKHDiMx1m07?=
 =?us-ascii?Q?RA1Eqh+UNnUKlirIud6W0bc70ftDXnqSybfCfs49udo78hCFtqUQUdNU/usb?=
 =?us-ascii?Q?8CEHYjuPEeHqR4tQb3HQW3Ep2Bx2oYIrfPyXRSWmpvhqgLvhj9qnJwlRSMSb?=
 =?us-ascii?Q?2MOkCzC8W/2ORV4ueLFh/c5W5sTKQlvEthhUQv5QoUIwevV1krhhWKG/Y1Wx?=
 =?us-ascii?Q?M6Xcz2EaUSkJI2fVZRgEVMZy4bkMp9yDME6xk9W8r+Lf+6pb+gXrc957FeS2?=
 =?us-ascii?Q?hFz7PYrQQwekOM3oEmkXGeOTnLWA/DSmeAEgbGXPxWDEAi8aHUMQdIGFWRsg?=
 =?us-ascii?Q?JcitUfVODKItoc7u6rUgIgkQ7u/C9TG+Fv+iZsxONhViNyOmC2crrjie2GeB?=
 =?us-ascii?Q?UAV+DDU2MZgUx5tze5CfNQieeNODUYv8B/BHRJRjEHsI9wm5Z0fHY00386in?=
 =?us-ascii?Q?30r+/mcXy/GHKOoDHdTqCa7uIT/4rIegpNY/9nEBs5vnUsIqn0yqzI+bC6J2?=
 =?us-ascii?Q?W0HCFuGgYl2c1/0nYGtJvmnlVVyroC+F7P0HNEw11Z6O3QAndi0AETPUqlb/?=
 =?us-ascii?Q?Q7w948RSbg5xrwp3c+OAVwVTslHK0B9APpGPABgzAhDtrIavydcIlF4cvi0B?=
 =?us-ascii?Q?bim4/6Rk1mBINfzZ1yVa9DEnqK2z1P1pBdJ1anepGI+LONLsqjW7VWV13uJt?=
 =?us-ascii?Q?0Z8JTW9XYBqZrw0EazsiqJKrXB7UPnJFB0vjUg2gpOwVT9mn/yv9iqS1FSNn?=
 =?us-ascii?Q?kIqqtMjj4Cgbr57R/yb40v6qTJwPwahepfU8ve/Q7xgdSjki0QkD327LnAK2?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efbfd4c-9549-4e4e-ec1e-08da60e9e0da
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 13:58:05.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYxaSx1VY/vfO8fMR+s6fwg0tEg2SYfSEP6tpcCVHpujU+5hNRKX1jkL6C6ChgDpHV1ghW28/h+rpAxDS+/RjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2197
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 03:34:43PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 06, 2022 at 02:43:31PM +0300, Alexander Usyskin wrote:
> > Add GSC support for XeHP SDV and DG2 platforms.
> > 
> > The series includes changes for the mei driver:
> > - add ability to use polling instead of interrupts
> > - add ability to use extended timeouts
> > - setup extended operational memory for GSC
> > 
> > The series includes changes for the i915 driver:
> > - allocate extended operational memory for GSC
> > - GSC on XeHP SDV offsets and definitions
> > 
> > Greg KH, please review and ACK the MEI patches.
> > We are pushing these patches through gfx tree as
> > the auxiliary device belongs there.
> > 
> > V2: rebase over merged DG1 series and DG2 enablement patch,
> >     fix commit messages
> > 
> > V3: rebase over latest tip
> > 
> > V4: add missed changelog in pxp dbugfs patch
> > 
> > V5: rebase over latest tip
> >     fix changelog in pxp dbugfs patch
> >     put HAX patch last to the ease of merging
> 
> You did more than just this from v4 to v5 :(
> 
> It's as if you want to make it hard to review these...

I just checked the code and it looks the same to me.

well, yeap, changing the order of other commits during the rebase
was not mentioned. So we don't know the reason...

But at least now the HAX is the last patch what makes more sense.

But I don't believe this should block the review and require a v6
just to add this comment in the cover letter, or it should?

Rodrigo.

> 
> greg k-h
