Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1952922B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiEPVAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348744AbiEPU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 16:59:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320F5A099
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 974FCB81647
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F11C385AA;
        Mon, 16 May 2022 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652733258;
        bh=6vhcWvhM3vv86PhvKft0mCwU+EdvxVsRYUbhBJHRYZo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hD8sYudGORAncGsT/S9Dlj3uGoy0TBEqd3Vpz1w88/a05X562MMxZbG/xiZ3gl5eo
         ihRJCkcuIR/cr8gCdvqRV27zz3AJKA+pFuIyJOBZ0tXYURtLZdm4OC0iwcQii7/VXU
         byH4P+tzz/9WLSfs8ZV2wpFxVx6bz5u2TbUVHUXVAG9vRvKHk914nqGHSLwnbt29IB
         PQSAvvEIl6RLGbM2xeqNwToAHvO52S+JZc4lhmRaDc2NUG9blcJGep8MUCcusPjvZM
         M+V/01HRfjMf8B46m9caO7NEf4ZBarxaQMp7yOKKEmfSxNG/DYM5HSo35ANo4xLA4Q
         iDYL36m78mFcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C55C95C0528; Mon, 16 May 2022 13:34:17 -0700 (PDT)
Date:   Mon, 16 May 2022 13:34:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        brauner@kernel.org, hannes@cmpxchg.org
Subject: Re: Use after free in cgroup_migrate_execute
Message-ID: <20220516203417.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <549de740-1356-7ad2-3ee5-c52bc355fd99@quicinc.com>
 <Yh+RGIJ0f3nrqIiN@slm.duckdns.org>
 <8d21e655-4ce9-c7b3-2010-e484161bdbe9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d21e655-4ce9-c7b3-2010-e484161bdbe9@quicinc.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:24:44PM +0530, Mukesh Ojha wrote:
> +@paulmc
> 
> It would be difficult to reproduce this with clean kernel.
> 
> However, i have put trace_printk on the cset object and found that task
> reference is dropped from rcu_do_batch() as below and later trying to get
> same cset reference resulted in the warning and later BUG_ON().
> 
> rcuop/0-16    [002]   255.430731: bprint:
> put_css_set_locked:cset:refzero:put_css_set_locked:cset:0xffffff80274eb800:
> 
> Callers (cgroup_free<-delayed_put_task_struct<-rcu_do_batch<-nocb_cb_wait<-rcu_nocb_cb_kthread<-kthread<-ret_from_fork)
> 
> PERFD-SERVER-1387  [002]   255.432631: bprint: get_css_set: get_css_set:
> 0xffffff80274eb800: Callers:(cgroup_migrate_execute<-cgroup_attach_task<-__cgroup1_procs_write<-cgroup1_procs_write<-cgroup_file_write<-kernfs_fop_write_iter<-vfs_write)
> 
> PERFD-SERVER-1387  [002]   255.456360: bprint: get_css_set: get_css_set:
> 0xffffff80274eb800: Callers:(cgroup_migrate_execute<-cgroup_attach_task<-__cgroup1_procs_write<-cgroup1_procs_write<-cgroup_file_write<-kernfs_fop_write_iter<-vfs_write)

If you can make this happen on small systems, you might try building with
CONFIG_RCU_STRICT_GRACE_PERIOD=y, which will make RCU grace periods finish
more quickly, possibly increasing the probability of hitting this problem.

							Thanx, Paul

> Thanks,
> -Mukesh
> 
> On 3/2/2022 9:15 PM, Tejun Heo wrote:
> > On Wed, Mar 02, 2022 at 08:42:32PM +0530, Mukesh Ojha wrote:
> > > Hi ,
> > > 
> > > We are facing one issue like below in cgroup .
> > > Not able to find which race could lead to this.
> > > Any idea, would be helpful.
> > > 
> > > [136233.086904][ T1457] ------------[ cut here ]------------
> > > *[136233.086912][ T1457] refcount_t: addition on 0; use-after-free.*
> > > [136233.086943][ T1457] WARNING: CPU: 4 PID: 1457 at lib/refcount.c:25
> > > cgroup_migrate_execute+0x188/0x528
> > > [136233.087527][ T1457] CPU: 4 PID: 1457 Comm: PERFD-SERVER Tainted: G
> > > S      WC O      5.10.66 #1
> > > [136233.087532][ T1457] pstate: 62400085 (nZCv daIf +PAN -UAO +TCO BTYPE=--)
> > > [136233.087536][ T1457] pc : cgroup_migrate_execute+0x188/0x528
> > > [136233.087539][ T1457] lr : cgroup_migrate_execute+0x188/0x528
> > > [136233.087541][ T1457] sp : ffffffc01ff23a60
> > > [136233.087543][ T1457] x29: ffffffc01ff23a60 x28: 00000000c0000000
> > > [136233.087547][ T1457] x27: ffffffffffffeaa8 x26: ffffff88cbc55668
> > > [136233.087551][ T1457] x25: ffffff878424d458 x24: ffffff891fdd5e00
> > > [136233.087557][ T1457] x23: ffffff88cbc55600 x22: ffffff8784d673d8
> > > [136233.087565][ T1457] x21: ffffff88cbc55758 x20: ffffffc01ff23b20
> > > [136233.087572][ T1457] x19: ffffffc01ff23b00 x18: ffffffc019475068
> > > [136233.087580][ T1457] x17: 0000000000000000 x16: 0000000000162ba8
> > > [136233.087587][ T1457] x15: 0000000000000004 x14: 000000000000407f
> > > [136233.087594][ T1457] x13: ffffff8ae5d48be8 x12: 00000000ffffffff
> > > [136233.087602][ T1457] x11: ffffff8785a79f98 x10: 0000000000000002
> > > [136233.087609][ T1457] x9 : 759287265d79e000 x8 : 759287265d79e000
> > > [136233.087616][ T1457] x7 : 206e6f206e6f6974 x6 : ffffffd7616121b4
> > > [136233.087623][ T1457] x5 : ffffffffffffffff x4 : 0000000000000000
> > > [136233.087629][ T1457] x3 : ffffffd7635ce996 x2 : 0000000000000000
> > > [136233.087633][ T1457] x1 : ffffffd7635ce996 x0 : 000000000000002a
> > > [136233.087636][ T1457] Call trace:
> > > [136233.087640][ T1457]  cgroup_migrate_execute+0x188/0x528
> > > [136233.087643][ T1457]  cgroup_migrate+0xb4/0xe4
> > > [136233.087646][ T1457]  cgroup_attach_task+0x128/0x20c
> > > [136233.087650][ T1457]  __cgroup1_procs_write+0x1d8/0x290
> > > [136233.087653][ T1457]  cgroup1_procs_write+0x18/0x28
> > > [136233.087656][ T1457]  cgroup_file_write+0xa4/0x544
> > > [136233.087661][ T1457]  kernfs_fop_write_iter+0x1b0/0x2f8
> > > [136233.087665][ T1457]  vfs_write+0x300/0x37c
> > > [136233.087668][ T1457]  ksys_write+0x84/0x12c
> > > [136233.087672][ T1457]  __arm64_sys_write+0x20/0x30
> > > [136233.087676][ T1457]  el0_svc_common+0xdc/0x294
> > > [136233.087681][ T1457]  el0_svc+0x38/0x9c
> > > [136233.087684][ T1457]  el0_sync_handler+0x8c/0xf0
> > > [136233.087688][ T1457]  el0_sync+0x1b4/0x1c0
> > > [136233.087690][ T1457] ---[ end trace 9e592742965258ba ]---
> > > [136233.087693][ T1457] ------------[ cut here ]------------
> > > *[136233.087695][ T1457] refcount_t: saturated; leaking memory.*
> > 
> > Looks like the target css_set ref underglowed but you have five taint flags
> > set and this isn't even the first warning message. Any chance you can
> > reproduce this in a cleaner environment?
> > 
> > Thanks.
> > 
