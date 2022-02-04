Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3F4A9DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376993AbiBDRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:41:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:47435 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238161AbiBDRlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643996482; x=1675532482;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HNAWq9SbvrJ7bhHuSuHGWfwTAaW9LozmAE/xxrXCg0c=;
  b=HY+vbmtiA14KR290hH82ko//xldvkySrZfxTRhmXVHtsPCnGIxNJckEn
   /Dse3vIzFeaPvYrcPK4DQP/900tOgNIHL/E/UYWgi8mPalvcFFoi2bKs2
   R7tRGo30hjUlMbRQvDXWiSTQAHejzGuwhs5UJev0HpXTq2Ajmjz2X8UCp
   EC6QCv2+rQjNuc3Qi8rwdapGWLncxVNKkBtZiHzeJnqYt0zReRdcC5yff
   9jNLMdtlsLW+RUoBa0PEUARgauq5TrCSbJroNuRkzNNlmy07jGyD1zchR
   IxUcibubHWfXcysttbI9aqXvQMkw1hZIiToN5kyFM/QKx3xNEruFIcj9S
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272912166"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="272912166"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 09:41:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="480903004"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.2.218])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 09:41:21 -0800
Message-ID: <88e9287ef7a86f24999af00f90d6f122de024979.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com, Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>, yu.c.chen@intel.com
Date:   Fri, 04 Feb 2022 09:41:21 -0800
In-Reply-To: <CAGsJ_4zVEjFYoff=x=Y3i9xPxoi891x-gkfA6Lsdc+yT2ykRmQ@mail.gmail.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
         <20220126080947.4529-3-yangyicong@hisilicon.com>
         <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
         <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
         <20220128071337.GC618915@linux.vnet.ibm.com>
         <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
         <20220201093859.GE618915@linux.vnet.ibm.com>
         <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
         <20220204073317.GG618915@linux.vnet.ibm.com>
         <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
         <CAGsJ_4zVEjFYoff=x=Y3i9xPxoi891x-gkfA6Lsdc+yT2ykRmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-04 at 23:49 +1300, Barry Song wrote:
> On Fri, Feb 4, 2022 at 11:28 PM Barry Song <21cnbao@gmail.com> wrote:
> > On Fri, Feb 4, 2022 at 8:33 PM Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > > * Barry Song <21cnbao@gmail.com> [2022-02-02 09:20:32]:
> > > 
> > > > On Tue, Feb 1, 2022 at 10:39 PM Srikar Dronamraju
> > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 07:40:15]:
> > > > > 
> > > > > > On Fri, Jan 28, 2022 at 8:13 PM Srikar Dronamraju
> > > > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:
> > > > > > > 
> > > > > > > > On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> > > > > > > > <gautham.shenoy@amd.com> wrote:
> > > > > > > > > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang
> > > > > > > > > wrote:
> > > > > > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > > > > > 
> > > > > > I am sorry I didn't get your question. Currently the code
> > > > > > works as below:
> > > > > > if task A wakes up task B, and task A is in LLC0 and task B
> > > > > > is in LLC1.
> > > > > > we will scan the cluster of A before scanning the whole
> > > > > > LLC0, in this case,
> > > > > > cluster of A is the closest sibling, so it is the better
> > > > > > choice than other CPUs
> > > > > > which are in LLC0 but not in the cluster of A.
> > > > > 
> > > > > Yes, this is right.
> > > > > 
> > > > > > But we do scan all cpus of LLC0
> > > > > > afterwards if we fail to find an idle CPU in the cluster.
> > > > > 
> > > > > However my reading of the patch, before we can scan other
> > > > > clusters within
> > > > > the LLC (aka LLC0), we have a check in scan cluster which
> > > > > says
> > > > > 
> > > > >         /* Don't ping-pong tasks in and out cluster
> > > > > frequently */
> > > > >         if (cpus_share_resources(target, prev_cpu))
> > > > >            return target;
> > > > > 
> > > > > My reading of this is, ignore other clusters (at this point,
> > > > > we know there
> > > > > are no idle CPUs in this cluster. We don't know if there are
> > > > > idle cpus in
> > > > > them or not) if the previous CPU and target CPU happen to be
> > > > > from the same
> > > > > cluster. This effectively means we are given preference to
> > > > > cache over idle
> > > > > CPU.
> > > > 
> > > > Note we only ignore other cluster while prev_cpu and target are
> > > > in same
> > > > cluster. if the condition is false, we are not ignoring other
> > > > cpus. typically,
> > > > if waker is the target, and wakee is the prev_cpu, that means
> > > > if they are
> > > > already in one cluster, we don't stupidly spread them in
> > > > select_idle_cpu() path
> > > > as benchmark shows we are losing. so, yes, we are giving
> > > > preference to
> > > > cache over CPU.
> > > 
> > > We already figured out that there are no idle CPUs in this
> > > cluster. So dont
> > > we gain performance by picking a idle CPU/core in the
> > > neighbouring cluster.
> > > If there are no idle CPU/core in the neighbouring cluster, then
> > > it does make
> > > sense to fallback on the current cluster.
> > 
> > 

We may need to take into consideration the utilization and
load average for the source and target cluster to make
better decision of whether it is worth placing the
task in the next cluster.  If the load of the target
cluster is too high, it is not worth pushing the task there.

Those stats can be gathered during load balancing without adding
overhead in the hot task wakeup path.

Chen Yu played around with cutting off the idle CPU search
in a LLC based on such stats and he saw some good
improvements over the default.

Tim

