Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384DE57D840
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiGVCK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiGVCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:10:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923061C129;
        Thu, 21 Jul 2022 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658455821; x=1689991821;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=USJ70BDhy9yXxLW2ouyyCnbOZMIiBcKqEzICy7KdfXE=;
  b=iWkSg/usV0irUra41rKOcjrzFpYFMFJRefk7leGVmWS73eXyarqfj3Sq
   g1rUutSA4XKXAkuv2muyAF0kYbiQla0l0M/FTeiURg1yhFP0kPjojgQ3J
   0do1NknaeFwelleL+Qrv9Ymg3y78GHnjOweBtWEjqZ5hCqIn1CiSwOUbt
   80T5JExD+EzUkhqRPVA02AIXdw/uIu3mQuTXBAHPKU6S45sYf5Nc8XfyP
   NJS/8fnIaRV9YY4FgZcNaHgDdNYAOm5DrTJOAPdeJqJAK9kcKtgnVMQTm
   WvS1e4oEm8KL1aKKWuQwOAAeMgdfbWmVAlZT47J668D6pzhdwFd2LzS/J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="274072079"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="274072079"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:10:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631407611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2022 19:10:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 19:10:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 19:10:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 19:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlQS2KBhxVtAAWKhutYtKQA+VHNGU8OEoiDQuVV8MtlY30EA6OTC6QKfkaXNjIPGIHETq/q2YvvgYmxqsjqluFMMe6stiUiipME6Y1YtvLyGlbWxv84C5U2y9VPx65UFjHPSlVz56gO37x59oz1gXXavHqG7yST+Kuj6iArPXz31WFGnBX3VPsJScNufJD94sLiJjCmjNnekcVnS2VHFpxW8tgzfyDUTy4cz/of2EoYVbNQ7LkaEZmdwWdV0cMEAAlW6uy+Umja8scQknlgz34KAHS+cslklP4YUpIudUUwITJToDTa6yLh4C56hqFYe8O30ovR0Gds34PJQxeYWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diuqqd8PHaBIvKf2ueO2YPxPwCT+5BGpvAeEl0wZy0Q=;
 b=avX3WIHeB/hN4ES+ZQ7CPaM5JGMocw2oHQtPGcKx5zvL8A3WZmkqqpapqLXAfHft8+iptBAtxN48F9FVdMWXY5kD1aKD4uEczNWIvmsj70wIi3rxICpnxbEU9Zu02vOPkxSynMBf3B7nQ8B/Nssh+de2hTY38QRFXuNACRHWp0/lp260SvRCDIYt8bGuGXN5ZA59czkMTujJfsZyZlS+HAa2vIL3xJi/rJxdAD3RoztRQIJt+gkMjF6XSYCIzQfgJa1rWIlHgR8C/GzlP/r4ncsg8mlzoUFZ90+kVtUsaPQZUI1VM0KOWyYPcg2h3CLCiS1MUo2RpEkZPCc0RoS4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by MWHPR11MB1776.namprd11.prod.outlook.com (2603:10b6:300:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 22 Jul
 2022 02:10:11 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c%6]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 02:10:11 +0000
Date:   Fri, 22 Jul 2022 10:10:02 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [xfs]  345a4666a7:  vm-scalability.throughput -91.7% regression
Message-ID: <YtoG+kcaC8yfMEZW@xsang-OptiPlex-9020>
References: <Ytlr9vZbF4SOfA2n@xsang-OptiPlex-9020>
 <20220721213337.GV3861211@dread.disaster.area>
 <YtnHa/IbHyD1QPh0@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YtnHa/IbHyD1QPh0@magnolia>
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6676fee5-d306-4c09-75d3-08da6b874ec3
X-MS-TrafficTypeDiagnostic: MWHPR11MB1776:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLU5liodPfk+qSXvwGIymowXrRMim1OG/mFcLjTG04iaiuvv5qZiw1rdRcFcKiGD+eDX2XzRWx3Z+5zuG0D+LQmv5i9y7n7uWkIQbKP0gvlhyswmjV9GibDHUtDl1QrsBXbWfe3Vzs3u3ELx55vPZUE8wA1KT7oL+JbQD5xg3J8f6M8SF+m5dT/dVWZAdY7nojrj0lfUIXJKXErKvbDX8WiAFqMeLr2+hCmQUmOMnfeN1QJiEpqOAswgZrHGDAEObHQjHtrfwhpyAtUx7qZOJCUzlVyKoX4YMMBqCQTCWkNy+CxSvqoMUhrn6xwygqVCfU6aC55TSFCGLIREXbQmIanPKzoodsC8QBamOCj1YdNfZOkvFAuVE3FT3WHDxIgy0lx79kzCJUeQSfUOcgKvB03Dvp24CS7Mfajp40UhXTR8/lxtss/k8Q1uJLqBj+z/qj6xY80ShN3UfJrX+ayA1QhkK7dKIHf5/4xoy4rDTlUooPOEj8uMWa75qtjXEeqtIcRlYc8bosBglDFxZntd42gNm1rW5F86y1D+uxceNqV84NfKxM/mYMpEn77gJuk85F3OzfOHFlpHw3G7W71PRP8fpctgz8dIJSjhtRC6lLJ/dlj4v7bdnQV1Q0V0ty6KkPs+FSBpai+mmRrY1pNgY5Xf8eTqjoDYQ9Z9xAO7eMTNoWtoLVARmjHaC2JY9V5k54/NnTkqJGlAZmBwtAIyFMOQkBQKNtczoarZmKpf2u7TySvZABDiAWMkUe27Qn1uCcHbLsJdaZpa8D9Zty+CSkC4YGQO7CE9Dpso8T8y2V2LuWWidV4J8uuiGx4u7d7P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(39860400002)(396003)(366004)(136003)(33716001)(82960400001)(54906003)(86362001)(38100700002)(8936002)(478600001)(44832011)(6666004)(41300700001)(5660300002)(316002)(6916009)(66556008)(66946007)(186003)(83380400001)(4326008)(8676002)(66476007)(6506007)(2906002)(9686003)(6486002)(26005)(6512007)(966005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BipvU6ctcRvFTD6g9bt4gBXckeK54vngMbO+W7/eeCypYxKKV2DlxbNlaZYT?=
 =?us-ascii?Q?pVLwPQEQKlIoD32oCmmlcms/QpH7UZsVu0HOXgPXaNboHLm+sTPFuxiCBaaD?=
 =?us-ascii?Q?Zw8b9GP9prrAeuSbUD0JLUGcavKMzd3IzO4n6TRqDiIOmFNsA0lc6UXF0YIS?=
 =?us-ascii?Q?GuRWYDCGTzbIZlT5t3XpjsFtKKuJKYS1Vp4yPTzAedegGdd9b056DrpcLuqR?=
 =?us-ascii?Q?7yvn2AEZlW4oRrpbn4wCStLFFx/abOpzehpjvabDlb01flBNdRuk/6PV1dP9?=
 =?us-ascii?Q?JDR+ZeAAMQfvabq0EG5qmQDPP7gwbmy+q7Za2CO+1Fgu0WZGedxEdBgYMOKt?=
 =?us-ascii?Q?/CbhzY+tEwCGMICK1P6SLxGS6T/A8DS4gbGGb1DavIgqOhJLOKgltgEKW7/b?=
 =?us-ascii?Q?FUke+y4cCJjPELFlkdnaJB3waBrQ1x1k0+3qfhA0QzsmCi3ifJ1m+H6zl/uS?=
 =?us-ascii?Q?Ho+A9eUc7tFyrqTIbQfj/TDJkaCPXrlnbqZrVD1ydXLvCQ3UMR6ZsTsWwvdC?=
 =?us-ascii?Q?//6v7FAoJy5CH4yTnHqdPy6ZagCxnLbVLz/axJ45Gg4esvfZRANRXAykWP+k?=
 =?us-ascii?Q?5HsKtDhvGDVzctM+ZzPYhIjSBCo+l0OFFkY0AhFckNzKVOjcpCk34q7auFDn?=
 =?us-ascii?Q?+hr7EvUDEc+4flanAui+CjbhZ8mBgMueOdfo7XWy4Bj/7a8PotmtloY0p3ro?=
 =?us-ascii?Q?VBEdJgFZyLCO/geETLoR5XzFc3K9e+ow+mAR/r0EyaSo11nhhq/Tty5lQS/a?=
 =?us-ascii?Q?1kvCkljkYwN7Vgeg44VaqVerKR5FlLDee417jbGo2J31eq0nN4/UwHHlNXHV?=
 =?us-ascii?Q?TC7Llsao1fg20ZsJ+iKVUNHCn1pW0fh+JtDnxBMr9I/eCiPR0sj6ILS7H2lG?=
 =?us-ascii?Q?My/6CZPDTkMfkrPg2VlKIM4oJHn3GEFXxT+VE7aBT14pOaaYiO6I2W8YTbKj?=
 =?us-ascii?Q?sUFGR4TE77I+PJrzdZyNAUp2z2SABJFQWS5xJZK5aSdHXAS4bUnZYRwqINaV?=
 =?us-ascii?Q?qNqmaIyng4k8AornDc6FrefjHWislMdG/ZDDyZWRjmAfdK2+QLj5gWDgppdL?=
 =?us-ascii?Q?+p0wMY1ZSTMOID6LP0PCTddz7bDXIQHkEIlmzmRCG3LhsKumWPnHxxTjFFAd?=
 =?us-ascii?Q?v3SN6OovGxxPMkYdKbyBkOYydqntuu2ejK0kohSnUSFhxKZ0ALXytZKZI+iF?=
 =?us-ascii?Q?TlCDHarzQgG2/p+UvsVz+HqR+08Ho6KVuRuX44LTelLaxPFdtztwfhl8Hmt0?=
 =?us-ascii?Q?AoojVLEnZ8MSk09M+8fiv8kN8wR5PYlGxglsvBO2GhZZcVK+j35Wr42AQNjB?=
 =?us-ascii?Q?/Kdl+sclTfoFVSWxk9NLeXevbP8FldQYjh3mtKHHm9eLgrnouwydjKTISMb8?=
 =?us-ascii?Q?rvcMGgUfe/0IE0CgfpGv4h6TeZUC7t4ieTkZD1dGhtlxKXqdTI+i2LyIFwPy?=
 =?us-ascii?Q?hVth4eu6pc5vhLs4zMRFC8cZ6KScJYBFkxlrJ6nSWfjyCSwYi0PI0ttGCXeL?=
 =?us-ascii?Q?BuXO+dyiabi9+DYUFKYppz4u2UoT9iNVlKgGLCt5of7DdPFdW72Cx5qH+Let?=
 =?us-ascii?Q?Gt/NmTAAVxvJ4PDJ4QFKy88hAKBdzIj3x2l33e5qjiMMuOXvqqhe2S/LSyqR?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6676fee5-d306-4c09-75d3-08da6b874ec3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 02:10:11.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSCqHG4Wo+VdyWNyyzEHPYHpY6OuNk9/YYNteHFBojP8wL+OX5qYZwCVwzwVVYk0y9Xf9wmIBjMyVl/BWJhRUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darrick, Hi Dave, and all,

sorry for this report is annoying according to Darrick and Dave's comments
below.
we will investigate this case and refine our report process.


On Thu, Jul 21, 2022 at 02:38:51PM -0700, Darrick J. Wong wrote:
> On Fri, Jul 22, 2022 at 07:33:37AM +1000, Dave Chinner wrote:
> > On Thu, Jul 21, 2022 at 11:08:38PM +0800, kernel test robot wrote:
> > > 
> > > (just FYI for the possible performance impact of disabling large folios,
> > > our config, as attached, set default N to XFS_LARGE_FOLIOS)
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -91.7% regression of vm-scalability.throughput due to commit:
> > > 
> > > 
> > > commit: 345a4666a721a81c343186768cdd95817767195f ("xfs: disable large folios except for developers")
> > 
> > Say what? I've never seen that change go past on a public list...
> > 
> > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.20-merge
> > 
> > Oh, it's in a developer's working tree, not something that has been
> > proposed for review let alone been merged.
> 
> Correct, djwong-dev has a patch so that I can disable multipage folios
> so that I could get other QA work done while willy and I try to sort out
> the generic/522 corruption problems.
> 
> > So why is this report being sent to lkml, linux-xfs, etc as if it
> > was a change merged into an upstream tree rather than just the
> > developer who owns the tree the commit is in?
> 
> I was wondering that myself.
> 
> --D
> 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
