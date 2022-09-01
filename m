Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879485A9B57
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiIAPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8965885FEA;
        Thu,  1 Sep 2022 08:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 031A061E48;
        Thu,  1 Sep 2022 15:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1066BC433D6;
        Thu,  1 Sep 2022 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662045233;
        bh=0t8/KQ98NzBwSJ4fHc5D6nxTVXNraYwC1s9/iFWtwkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTIEH2lj86kQHwiT276ARAOQ1PjOkr49jT8a+knYDEzzoD8okdpydEc1JNKxDtuBb
         ITp0R8qShGI/4TkMP4BQBpYRGF/J7sJkn8E/oEvMx7+P3fq2agkFAkhBTpVRXZeYTD
         mquRxl+61NpIZqXJTBBSu2mMjnY5jcKEcKPjvjY85YPJtkyjcds5DklbPHjzkZ2qgi
         EiW0SRGve/h3IKyxEF31Ometku4gSOpycbneyp9WuQFIOta60xTO0gpi+RJlkB2lL/
         U+DLOdk/nZnDOeyV2EJGQnf9UkACmErvec8H7OHZ2x2W71BdNaQAr11J4nBUiNLvOm
         nv4acXRMO+M0w==
Date:   Thu, 1 Sep 2022 17:13:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20220901151350.GC105556@lothringen>
References: <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636>
 <20220901112947.GA105556@lothringen>
 <YxCejoKH8dGIeW22@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxCejoKH8dGIeW22@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:59:10PM +0200, Uladzislau Rezki wrote:
> On Thu, Sep 01, 2022 at 01:29:47PM +0200, Frederic Weisbecker wrote:
> > On Tue, Aug 30, 2022 at 06:44:51PM +0200, Uladzislau Rezki wrote:
> > > Hello, Frederic.
> > > 
> > > > 
> > > > Although who knows, may be some periodic file operation while idle are specific
> > > > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > > > periods associated.
> > > > 
> > > > 
> > > Everything related to lazy call-backs is about not waking "nocb"
> > > kthreads in order to offload one or i should say few callbacks
> > > because it is more or less useless. Currently if incoming callback
> > > is the only one, it will kick a GP whereas a GP will kick nocb_kthread
> > > to offload.
> > 
> > Not sure this is only about not waking "nocb" kthreads. The grace period
> > kthread is also awaken in !NOCB and has quite some work to do. And there,
> > having a server expands the issue because you may have a lot of CPUs's extended
> > quiescent states to check.
> > 
> I mean here the following combination: NOCB + call_rcu_lazy() tandem.
> The !NOCB is not about power save, IMHO. Because it implies callbacks
> to be processed on CPUs they are landed.

I'm sorry but I still feel confused reading that !NOCB is not about power
save. To me everything is about power save. NOCB just appears to help optimizing
it without significant tradeoff on some given workloads.

> In this scenario you can not let the EAS scheduler to find a more
> efficient CPU for further handling.

Sure but that doesn't mean there wouldn't be a power saving gain anyway.

Thanks.
