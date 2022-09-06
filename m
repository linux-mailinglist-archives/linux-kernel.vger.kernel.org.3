Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949F25AF3DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIFSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIFSou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:44:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015101D0D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662489888; x=1694025888;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/lcPs3orVnls9Hb6iT8Kn+P8uLpV38epnOs8myLRow=;
  b=Nbtz/Qp9OIfkyxnyHsy6Q3yg+kaXWLeXbW6Kgo3fvrD36lNiUTdTG6oY
   gHsNm9BStHi3gYdjsdvr6SzMc2qngVRNHo9NsvG+jbyORmQ9XT5FLboTV
   S11P/2K1gJvMHk0vFS3rxopmBO4/1uecspNme4lK51i3Xviw4h2CtK8pU
   LGQDqAU/gsEn5aNNpyalfdRN2/zCc89+jyIc7lSLIeI6MwGvPZyz06IFQ
   ExzNZxwuQJNX9KL4fwlDZWQowPsoZDg63E9Fzlgnt2bBxnxyW1NUhUJOb
   kHgfpSK7eLf9EOVQD2vhoQ0yl8IxvKO4uJkL7h+y3dP+PTHmyfSvjXW6p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297990554"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297990554"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 11:44:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="739998118"
Received: from schen9-mobl.amr.corp.intel.com ([10.252.133.221])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 11:44:47 -0700
Message-ID: <048517e7f95aa8460cd47a169f3dfbd8e9b70d5c.camel@linux.intel.com>
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shakeel Butt <shakeelb@google.com>,
        Jiebin Sun <jiebin.sun@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vasily.averin@linux.dev,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        alexander.mikhalitsyn@virtuozzo.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>, tianyou.li@intel.com,
        wangyang.guo@intel.com
Date:   Tue, 06 Sep 2022 11:44:46 -0700
In-Reply-To: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
         <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-02 at 09:27 -0700, Shakeel Butt wrote:
> On Fri, Sep 2, 2022 at 12:04 AM Jiebin Sun <jiebin.sun@intel.com> wrote:
> > The msg_bytes and msg_hdrs atomic counters are frequently
> > updated when IPC msg queue is in heavy use, causing heavy
> > cache bounce and overhead. Change them to percpu_counters
> > greatly improve the performance. Since there is one unique
> > ipc namespace, additional memory cost is minimal. Reading
> > of the count done in msgctl call, which is infrequent. So
> > the need to sum up the counts in each CPU is infrequent.
> > 
> > Apply the patch and test the pts/stress-ng-1.4.0
> > -- system v message passing (160 threads).
> > 
> > Score gain: 3.38x
> > 
> > CPU: ICX 8380 x 2 sockets
> > Core number: 40 x 2 physical cores
> > Benchmark: pts/stress-ng-1.4.0
> > -- system v message passing (160 threads)
> > 
> > Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> [...]
> > +void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
> > +{
> > +       this_cpu_add(*fbc->counters, amount);
> > +}
> > +EXPORT_SYMBOL(percpu_counter_add_local);
> 
> Why not percpu_counter_add()? This may drift the fbc->count more than
> batch*nr_cpus. I am assuming that is not the issue for you as you
> always do an expensive sum in the slow path. As Andrew asked, this
> should be a separate patch.

In the IPC case, the read is always done with the accurate read using
percpu_counter_sum() gathering all the counts and
never with percpu_counter_read() that only read global count.
So Jiebin was not worry about accuracy.

However, the counter is s64 and the local per cpu counter is S32.
So the counter size has shrunk if we only keep the count in local per
cpu counter, which can overflow a lot sooner and is not okay.

Jiebin, can you try to use percpu_counter_add_batch, but using a large
batch size.  That should achieve what you want without needing
to create a percpu_counter_add_local() function, and also the overflow
problem.

Tim


