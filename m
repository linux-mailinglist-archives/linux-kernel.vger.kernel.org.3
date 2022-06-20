Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065AF5522A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiFTRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFTRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:16:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A411E3E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 702E0B8128D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225ECC3411B;
        Mon, 20 Jun 2022 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655745363;
        bh=OHhYxsEhpopk7S29OFbpneumoHGAyyICVDMbqjyLXcY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lXdksj/BM39DWG+PAmXwcUbcblIXvpp0Mcctjkzpziyf/RkVPRdaV+5Vp6/pjuWew
         iLMjlXuH3ooblp2c572jJwjl9eSbwjiPFuPO07PWmv1URuvEhiCR44/pp6/05RINKB
         R/jG+hr1hY/MhUr+NFwGtAXhzUh45uZta+Z1BtaYBH5gE5tOsDfpjvejxQLcOvsk2b
         VAUahDh7O4k9vFEK1tZ74DsLGUsZGzwfitJrc2KzV/hew/DKIEAus7ee3Dv2JVGnsL
         keW85OnxHJJBrL/hfgTrEkcyyQprBC44I/mAM6aqP60NkWJTrMpsMfHzajSA6+f3Xo
         JeGHWUgWC5+PQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A91A15C05DA; Mon, 20 Jun 2022 10:16:02 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:16:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 00/20] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking v4
Message-ID: <20220620171602.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220608144037.1765000-1-frederic@kernel.org>
 <07c07c2d0714b20bbfffe91b37e8ed810d017c35.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c07c2d0714b20bbfffe91b37e8ed810d017c35.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 12:14:32PM +0200, nicolas saenz julienne wrote:
> On Wed, 2022-06-08 at 16:40 +0200, Frederic Weisbecker wrote:
> > Hi,
> > 
> > No big issue reported or reviewed in the last take.
> > Changes in this version:
> > 
> > * Dropped noinstr related "fixes" as it's worth a whole patchset of its
> >   own. Just comment on why some context tracking functions are not going
> >   to be fixed (because they are obsolete).
> > 
> > * Fixed several build splats reported by the kernel test robot
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	rcu/context-tracking-v4
> > 
> > HEAD: 82e4a1998ec3a58b865249c6015d3ee9b94e3004
> > 
> > Thanks,
> > 	Frederic
> > ---
> 
> For the whole series:
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Applied, and thank you for testing!

							Thanx, Paul
