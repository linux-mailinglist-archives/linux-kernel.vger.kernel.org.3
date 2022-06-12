Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BE547B96
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiFLSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiFLSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F50159977;
        Sun, 12 Jun 2022 11:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 090FB6101C;
        Sun, 12 Jun 2022 18:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661E1C34115;
        Sun, 12 Jun 2022 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655059915;
        bh=pP3VrvMaUKkFQXik/UtVwsPaBrvvOwDzdTec0ohn/4Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sNvI0+Ja/RRCyxVZ3zZg74NLmMbheAPWYp9iGLhyyIAlLW/u55ATafQFevXsAvQZ/
         pid7WLgDiHS8dan1I/4O8qKczcDIi+2vAr/TwhNRpCPAvT2wTEeNJVoAz6/mNCrIW1
         GuNxickeg7WCjRTU9TvMNEHqD9zWdjaJ9G4/bMNm8xt8vPXTAq5A1Y6eI7e3swCgMT
         Z103pcAnzObocZpnoY+aLcgUDmRADfdphW31+gSJzziT2dPUsozw2hxuiTlTYtEsKX
         TyRgnS0BL8QEOrc3/qCYGH6ka1cm/mdSK+vvPR7sOX58pSFeL7XmA5KpAykrGLoHGv
         Du0NZ9L8Vy2Hw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EB3F75C0266; Sun, 12 Jun 2022 11:51:54 -0700 (PDT)
Date:   Sun, 12 Jun 2022 11:51:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, mtosatti@redhat.com,
        sheng.yang@intel.com
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Message-ID: <20220612185154.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
 <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
 <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
 <a3de4cf5-d760-1666-6b9c-f620c238453b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3de4cf5-d760-1666-6b9c-f620c238453b@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 07:47:10PM +0200, Paolo Bonzini wrote:
> On 6/12/22 19:29, Paolo Bonzini wrote:
> > On 6/12/22 18:40, Paul E. McKenney wrote:
> > > > Do these reserved memory regions really need to be allocated separately?
> > > > (For example, are they really all non-contiguous?  If not, that is, if
> > > > there are a lot of contiguous memory regions, could you sort the IORT
> > > > by address and do one ioctl() for each set of contiguous memory
> > > > regions?)
> > > > 
> > > > Are all of these reserved memory regions set up before init is spawned?
> > > > 
> > > > Are all of these reserved memory regions set up while there is only a
> > > > single vCPU up and running?
> > > > 
> > > > Is the SRCU grace period really needed in this case?  (I freely confess
> > > > to not being all that familiar with KVM.)
> > > 
> > > Oh, and there was a similar many-requests problem with networking many
> > > years ago.  This was solved by adding a new syscall/ioctl()/whatever
> > > that permitted many requests to be presented to the kernel with a single
> > > system call.
> > > 
> > > Could a new ioctl() be introduced that requested a large number
> > > of these memory regions in one go so as to make each call to
> > > synchronize_rcu_expedited() cover a useful fraction of your 9000+
> > > requests?  Adding a few of the KVM guys on CC for their thoughts.
> 
> Another question: how much can call_srcu() callbacks pile up these days?
> I've always been a bit wary of letting userspace do an arbitrary number of
> allocations that can only be freed after a grace period, but perhaps there's
> a way to query SRCU and apply some backpressure?

They can pile up as much as ever, especially if you have long-duration
sleeping readers.

But you could do the occasional srcu_barrier() to wait for all the
preceding ones to get done.  Maybe every 1000th call_srcu() or similar?

							Thanx, Paul
