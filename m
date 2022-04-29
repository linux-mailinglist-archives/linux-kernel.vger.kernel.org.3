Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6175146C4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357454AbiD2KaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiD2KaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:30:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E2FA2075
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651228023; x=1682764023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1tQTauQD/MLKLgiL3ppD3Xgdal2z8SDQOZmYuVwCzk0=;
  b=NBM1iMJgWdtBBQGcm5LvmNzBKlGMdr105p7k9PndohvZ6g7JxvZiuC7a
   0Ma1Hw5mxzt3DOfVc10UkklArKu0ABx2rJFQfwirTANSBdm3/ZVQ6eS8Z
   npuGPFqSFRetRkP2YhvwNidaZkqjdIW0E476g0apjLy5JmpQlDRDtvNwC
   aTLH1CIGLZOILkC+EF9pPs2OLFq+cfV6xkhMNGb0qMbmnagcws817Qd00
   RfzxO0AzeNzQKxTJnlnIqRCeV/o+jdXZZokmKmMa7IyjLw16xXTp+iz2L
   itn47e/v1dMxrZMgKknMHv2/osAlU13QKeS8jUvu3C3biKGLz1VT17B2O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266761416"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="266761416"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 03:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="582048289"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2022 03:27:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 03:27:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 29 Apr 2022 03:27:02 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 29 Apr 2022 03:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JghovPwLUi88JY4l9L9UjPm8jsQD3lfHco2mYd9oYb6InKWtuElrDLxUhoRHj+9ZRrQoBWAH73aoonWsKuNFx8KR4O/HlKkcprgWle1spXPcBk+Anxy9hjx/c5xWocYOSYGrCtY3NPSj000JtNijmZewMKEUqDg4Iutxda5FB4LlyIxsQaTKBi7yR/dgDORl7RhqrkZLzaPCjmBEuekZKidQ3B9c5S/loyO2bytkiceGOU6snKOZuwttyGN2r+h+FEt0kCeqPbLC3uY6oKQsWd4CvCwDUweQoynV/CTQUbfv9TuCsyTKB56T8h03/ws63/SI5EeYuQVufmRIGKZ+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIOxT/lNhSwJUkjryy8JBl6/m91659XK9BLAh1YQvJY=;
 b=Qxm1KhJiUg37T9HFObnqwD9smEZ+4/x183zcWOTDtte9+CuLoxdrBq1NLloHH7/I5PS6LCo8uMcs4rYdf+HZ29h3lF9ZDpuLnMB5Ex0NLYHN0RVCe1AvdvwC/TwC0aYLnbMnkKqNQQFMrnjzHD2HucOqy3X674GmHiWJ8bFkbp2ZeqaI7SfRTgj97jXI+lHo86vg9NdJuK/lowq+HzAFQPZWYgfQduJckPr2yGsgvMyerbt6S2KiC7MwjkwqMghZZ6B37hTH2Ji2o/4Ow63IHX2DrIHTyUPixbvW1nNj25h0ToghSJbGBBdSZBdjwUorHxFzEcyWDVmxGt7XZkgsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB5485.namprd11.prod.outlook.com (2603:10b6:5:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 10:26:59 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5186.023; Fri, 29 Apr 2022
 10:26:59 +0000
Date:   Fri, 29 Apr 2022 18:26:49 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <Ymu9acl18pTA5GU6@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
 <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
 <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
 <YmETEHnK/FiNbLO7@ziqianlu-desk1>
 <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
 <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
 <CAHbLzkriO6xWzyMNpcVFmyxSn=cqbz2qx+2mJ5d0m-beqPRCUg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzkriO6xWzyMNpcVFmyxSn=cqbz2qx+2mJ5d0m-beqPRCUg@mail.gmail.com>
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c8f75bc-5172-49a5-fcd7-08da29cacb00
X-MS-TrafficTypeDiagnostic: DM4PR11MB5485:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB5485B4478084E705B84621778BFC9@DM4PR11MB5485.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VBDEfsgTbycTJAjeuqZN1nwhK4DNnPe6JKCCLaOp20UffGSjDmIa/PFy74Hng6gYA8RRbTgQnHjwlGduqT66OXhurbapvJV2CMTCtsTRffkLpVv67EyxFt867PrVSNLylvn9PHRE9zVfnZhy0s1il8eEACfcEmRwphAObGxl1HhFEMKtp8/k38EecRcLJPD9374WaCy+S5ZCVjezGwMvb4jxWn9C4fB88isLS6GBGoC2YkxWT/XIzInRn1hjsOO2ybaHSBPu6Sikb2VeNzDBU47DaTVbzoKlsKJRaJ52thyuIK9Z1iAVwfo59w0ThaLvv0uMEAhjVjm/mPEVguV030wQWnQRj54AGccwbguojiFJCerd610hF7QBXKWV1AJeNLDy37ICiZe8VE/XoOSgrKkYrelvKMx8Xn50aGd+0WHkQVyCx1QpkC55t2z3r9BHYcxdU3HeKPp8HzV+dsU99pEQVerJ5U4pxVWXu4EPXYUSEbXLp4sr6PWToxRj5rhubwhoizsynZDTdwEEcCBbQ3kQRKWm688YOiv+A2zQftw9jG3x3cbe/7H3qHiqbM/BnshwuddqGvzdxg9mg/zmiDvBnh3Lr+ZNFKhGlYhGgfsSA1Lh+albbQj7V4W0AI9r8hZqNHNU8ZUeJh0CfMynQVqOTqnpIgyIhvALRqM9uU/gmULuRH8Ch6jZ2GgK40svmb17j3BpRe5E95WYmKnrm43iWXs3rRpynLZiwhv2wQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(33716001)(82960400001)(6916009)(6486002)(9686003)(5660300002)(44832011)(83380400001)(66476007)(38100700002)(86362001)(8936002)(53546011)(66556008)(8676002)(508600001)(54906003)(4326008)(66946007)(186003)(6506007)(966005)(316002)(26005)(6666004)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zCgZS77Z7ljIdsC/ZT8jVgkqnbq2/onqbGZ57mnQkImoDIwpujAhdu8EwiG?=
 =?us-ascii?Q?s9cZkJP2EX5o9PD+FZ3pNkkSdlfHA7aM1Je5B2pZwXYb+92lKju3c2Nb6+YZ?=
 =?us-ascii?Q?l/qE5Eyqh7aXGSn7mOFQ+A7mVl7sKXh/1qR6oobyidZzfjnhKeS8EPgp2vVU?=
 =?us-ascii?Q?6QgJczeOPwDxqffsECfKJldCZVUxVcpaQbKTakVSfULH9xPIr8FBOXH9qt3Y?=
 =?us-ascii?Q?I48MiXInRVDrFJJDG5xOkY5tvMn3udAye5CPInJCwkVf8m4EnRmd1SySfmoX?=
 =?us-ascii?Q?Rspt2uifM7+rgydkz7AmoUpy9+GEruMoyL/YmFos1mGkhiAWdy/Qb5uHSy2j?=
 =?us-ascii?Q?nJY3oPxZTlHfTFKUSHbo5V6JpSQOksonfnDpLd1vFpk8T0lmvcPHoa25/maT?=
 =?us-ascii?Q?ZrR88G+PGKFXVWw6/AVi/I/Ow3Z2XFUy8VCbBKR4ONwqgvIxLfrREZmCb6ku?=
 =?us-ascii?Q?EnCD5luxcEEk2P4U9g9WAk+A8q89WuAd+Wap186Jvids1IQ+623sGc+UKDMK?=
 =?us-ascii?Q?62+cAt7nsk0aMKdFK8bz/ikVu3Efz8aeZ96ArlUSbZ3pb9ii4swNoX9HMOcn?=
 =?us-ascii?Q?ShpaHOzhlpw/EG8qhMffd82BpAXe3D1aANwzzfrzb5nx/8F8xFnJwq9wzPvD?=
 =?us-ascii?Q?86GNPCK/j3ZjyWYD7cq0HEvd+7tzmBlOe1wdGXIBS9fJpodTeyOpW31Yr3h8?=
 =?us-ascii?Q?pXKoUksinYGtle2YR2hckTWIxkW4O9mMivhwFxC4myGpD93BavF8WF3SVrJp?=
 =?us-ascii?Q?9Ff/iDbH0HA9sjs0vyBpaF/gFa17kY5TXTUHcKs/ovMzSknos7EiszhxkQvH?=
 =?us-ascii?Q?xbDNpMGWRcGKHl+VmrKkJltHjJQ0jiQy2O+uJVIc0aGOXQ33U3f9ojz6hgZi?=
 =?us-ascii?Q?LQPzA+u0hd7eelzm9mCVBHHFkvUo06N4IyUkTaOnIeS8mAyZTYYowUzBKFxd?=
 =?us-ascii?Q?0Rw8rkIc+HJ1TVsz62L9+wlLXdfisVb8z0VWFoBZ1FGPtPYDRy+Xi4yDWG+V?=
 =?us-ascii?Q?rUrlkteqUHUmaUbAXJKGiOmCx13/NcZDfcVJm0tKat2yT/52kCBAnBIIjOPe?=
 =?us-ascii?Q?Y5IeWuSWsgYhY3ho1v1N448tBu6kFAzyxz0LzlOkJxDoSfw9nT4yuN6AdAmY?=
 =?us-ascii?Q?uHwH1l///TePI+JyoVNHd4nlGqDUMmsx+E59pivQnv1t2fiUzU8bGPcJouTT?=
 =?us-ascii?Q?ZFhDuDI0LOf/7d7Q+FlZ+uEFe+4XwnHjAnKT72r+pcCeD90WFqMvFf8rPpfX?=
 =?us-ascii?Q?onxviyilbDBbSIa8eaEORna9lgJEbEV4Nril5B2IsDXnk6o3+l9pfUWdeeRZ?=
 =?us-ascii?Q?LklTeyUeQ5Gspa9d6GpJpdOce5w7Qnb5vrqP9Hv4ZMFiiy/HOibETkiBrbZl?=
 =?us-ascii?Q?QNhAa6+JjTdB7ABFkRiuddWfW1qt/nOTdtdRfFHKPJ5UYq+4q3phL8pwTfNB?=
 =?us-ascii?Q?Nx5ZBwpB9SCtPkXUVIbhprsbO3HjpayYS8tSst+PJD+f10UxSfqrj1xJ1wND?=
 =?us-ascii?Q?dF+S5tOYEDbozNm1tTHmhAB/7VeKHn+8IpRCWdSIjsv15iDYFfAU+cURT7UG?=
 =?us-ascii?Q?P51ZPtCsEOOOLmTQ1FPK65shlX85PpwYKvQQ6kLisa/O5esGdv5f6Zktg3BP?=
 =?us-ascii?Q?3Ag0Mv3TE6XnWE2q1pl2tOBo+BmrMv9zBBa2ao3BSL+546Z9ImEMIatC+7bb?=
 =?us-ascii?Q?eQR0xXAFk61mZ1vZKLQdJ683F8a6kQnvc/CkXanQz3tN2rEnwvvvCjvuEQfx?=
 =?us-ascii?Q?rR1OmpMNaA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8f75bc-5172-49a5-fcd7-08da29cacb00
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 10:26:59.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRcIfQgbi+QhAVf3zkNrZQj9ygXE6XMMlMoDMp0zc+B6YI4GY4BX5cQxCd8UMG6yTaknkiu6t9Qa5zCIcJK8KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5485
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:00:59AM -0700, Yang Shi wrote:
> On Thu, Apr 21, 2022 at 11:24 PM Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 04:34:09PM +0800, ying.huang@intel.com wrote:
> > > On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> > > > On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> >
> > ... ...
> >
> > > > > For swap-in latency, we can use pmbench, which can output latency
> > > > > information.
> > > > >
> > > >
> > > > OK, I'll give pmbench a run, thanks for the suggestion.
> > >
> > > Better to construct a senario with more swapin than swapout.  For
> > > example, start a memory eater, then kill it later.
> >
> > What about vm-scalability/case-swapin?
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swapin
> >
> > I think you are pretty familiar with it but still:
> > 1) it starts $nr_task processes and each mmaps $size/$nr_task area and
> >    then consumes the memory, after this, it waits for a signal;
> > 2) start another process to consume $size memory to push the memory in
> >    step 1) to swap device;
> > 3) kick processes in step 1) to start accessing their memory, thus
> >    trigger swapins. The metric of this testcase is the swapin throughput.
> >
> > I plan to restrict the cgroup's limit to $size.
> >
> > Considering there is only one NVMe drive attached to node 0, I will run
> > the test as described before:
> > 1) bind processes to run on node 0, allocate on node 1 to test the
> >    performance when reclaimer's node id is the same as swap device's.
> > 2) bind processes to run on node 1, allocate on node 0 to test the
> >    performance when page's node id is the same as swap device's.
> >

Thanks to Tim, he has found me a server that has a single Optane disk
attached to node 0.

Let's use task0_mem0 to denote tasks bound to node 0 and memory bound
to node 0 through cgroup cpuset. And for the above swapin case:
when nr_task=1:
task0_mem0 throughput: [571652, 587158, 594316], avg=584375 -> baseline
task0_mem1 throughput: [582944, 583752, 589026], avg=585240    +0.15%
task1_mem0 throughput: [569349, 577459, 581107], avg=575971    -1.4%
task1_mem1 throughput: [564482, 570664, 571466], avg=568870    -2.6%

task0_mem1 is slightly better than task1_mem0.

For nr_task=8 or nr_task=16, I also gave it a run and the result is
almost the same for all 4 cases.

> > Ying and Yang,
> >
> > Let me know what you think about the case used and the way the test is
> > conducted.
> 
> Looks fine to me. To measure the latency, you could also try the below
> bpftrace script:
>

Trying to install bpftrace on an old distro(Ubuntu 16.04) is a real
pain, I gave up... But I managed to get an old bcc installed. Using
the provided funclatency script to profile 30 seconds swap_readpage(),
there is no obvious difference from the histrogram.

So for now, from the existing results, it did't show big difference.
Theoretically, for IO device, when swapping a remote page, using the
remote swap device that is at the same node as the page can reduce the
traffic of the interlink and improve performance. I think this is the
main motivation for this code change?
On swapin time, it's hard to say which node the task will run on anyway
so it's hard to say where to swap is beneficial.
