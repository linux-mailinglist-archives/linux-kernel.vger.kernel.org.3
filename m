Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAA5A9BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiIAPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiIAPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:30:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9011EC7F;
        Thu,  1 Sep 2022 08:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 158E3B827EE;
        Thu,  1 Sep 2022 15:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D26AC433C1;
        Thu,  1 Sep 2022 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662046236;
        bh=96TD368oCS8gVqV1eOy8FDbrPzJCXiI7p+QR+lCzqs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQVkANyC4saxgOcm+M4Q4L0F/a9UghpexylDouhtgjV4RT5B54i6l4HmWAqoXZaCQ
         Bj0xhL7H6rK+p9XyOSchv+lUOUTN4DWgnmjSazEGu8UFuVSPpYP+7OO2us8LVLGHtp
         781rI92CTo9tk7y9oQX2nGjeCH3LHD6p3TZlh1q+j9VzblHKWe687923bc4EyxRRPb
         yAT6PGzQbDQXFib2h++ZAFJcJaoy9Zw7fFBEjd/SPK18odBYxKNC8NVsFUfhKEnPiU
         D/RMFGrBS+pBkEMVOkHjUtTWArq/Il/cdmFngWHMvphHN7fkYorkL/3D6EBZ+ac5je
         v0Qsr+TIinR4Q==
Date:   Thu, 1 Sep 2022 17:30:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220901153034.GA106955@lothringen>
References: <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636>
 <20220901112947.GA105556@lothringen>
 <YxCejoKH8dGIeW22@pc636>
 <20220901144158.GV6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901144158.GV6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 07:41:58AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 01, 2022 at 01:59:10PM +0200, Uladzislau Rezki wrote:
> > On Thu, Sep 01, 2022 at 01:29:47PM +0200, Frederic Weisbecker wrote:
> > > On Tue, Aug 30, 2022 at 06:44:51PM +0200, Uladzislau Rezki wrote:
> > > > Hello, Frederic.
> > > > 
> > > > > 
> > > > > Although who knows, may be some periodic file operation while idle are specific
> > > > > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > > > > periods associated.
> > > > > 
> > > > > 
> > > > Everything related to lazy call-backs is about not waking "nocb"
> > > > kthreads in order to offload one or i should say few callbacks
> > > > because it is more or less useless. Currently if incoming callback
> > > > is the only one, it will kick a GP whereas a GP will kick nocb_kthread
> > > > to offload.
> > > 
> > > Not sure this is only about not waking "nocb" kthreads. The grace period
> > > kthread is also awaken in !NOCB and has quite some work to do. And there,
> > > having a server expands the issue because you may have a lot of CPUs's extended
> > > quiescent states to check.
> > > 
> > I mean here the following combination: NOCB + call_rcu_lazy() tandem.
> > The !NOCB is not about power save, IMHO. Because it implies callbacks
> > to be processed on CPUs they are landed.
> > 
> > In this scenario you can not let the EAS scheduler to find a more
> > efficient CPU for further handling.
> 
> Just to follow up, Uladzislau and others did some detailed performance
> analysis of NOCB on Android.  Of course, this analysis might or might
> not carry over to servers, but it was pretty detailed.

Sure I certainly don't deny the benefit on Android and similar workload.
What I'm worried about is that we are making this feature too specialized
when it may deserve to be made more generic.

I'm not convincing anyone though and I don't have the means to provide
numbers, I would need to produce an actual !NOCB implementation for that.

So I'm not entirely comfortable but I'm going to review the current patchset
anyway and once it lands -rcu I'll try to hack a quick !NOCB implementation
for measurements purpose.

Thanks.
