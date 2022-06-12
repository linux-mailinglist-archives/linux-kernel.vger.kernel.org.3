Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86389547BF1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiFLUJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFLUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:09:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27F17051;
        Sun, 12 Jun 2022 13:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89F5EB80D13;
        Sun, 12 Jun 2022 20:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5A6C34115;
        Sun, 12 Jun 2022 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655064583;
        bh=Tm74GjsvV7hlPw/ZA/i75k7S7jIG8yLplgxCe7pUhnw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=luPu+9pIdW3SFm0NaVJW7gWty7VYeKxwwicFBZr8EcJnIEnt2wyHOZI+bhrmeZzsD
         MYZtkLb1ivNrU9sTd2p8sRyHm5Mu6BA+rdaNpgsPjcXxtyR1nf5CzC8jUwIZb9ccad
         xVoC8BLae5hgqG4TM7Yzc6t15Jafy413il6v8MQcd87O6dykJp80Uu1z0GPLelSFGW
         CMBNSt1HN90VJ5RkeFhpC03ZPJyv+n6bat+RquEpBW4o15mRf3ds4e1QVBiiOjZ2/b
         xoRKz4vWBW4kK0FhGcks9B38W9QdqNjo6qZL8V+lctF5gZUt/SN3Xgrp8zwHWjsdFL
         QRy6q3NmqPlpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B198E5C0266; Sun, 12 Jun 2022 13:09:42 -0700 (PDT)
Date:   Sun, 12 Jun 2022 13:09:42 -0700
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
Message-ID: <20220612200942.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
 <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
 <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
 <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <bfdc80bd-0be6-f591-e998-c3ad65283404@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdc80bd-0be6-f591-e998-c3ad65283404@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 09:23:14PM +0200, Paolo Bonzini wrote:
> On 6/12/22 20:49, Paul E. McKenney wrote:
> > > 
> > > 1) kvm->irq_srcu is hardly relying on the "sleepable" part; it has readers
> > > that are very very small, but it needs extremely fast detection of grace
> > > periods; see commit 719d93cd5f5c ("kvm/irqchip: Speed up
> > > KVM_SET_GSI_ROUTING", 2014-05-05) which split it off kvm->srcu.  Readers are
> > > not so frequent.
> > > 
> > > 2) kvm->srcu is nastier because there are readers all the time.  The
> > > read-side critical section are still short-ish, but they need the sleepable
> > > part because they access user memory.
> > 
> > Which one of these two is in play in this case?
> 
> The latter, kvm->srcu; though at boot time both are hammered on quite a bit
> (and then essentially not at all).
> 
> For the one involved it's still pretty rare for readers to sleep, but it
> cannot be excluded.  Most critical sections are short, I'd guess in the
> thousands of clock cycles but I can add some instrumentation tomorrow (or
> anyway before Tuesday).

And in any case, readers can be preempted.

> > The problem was not internal to SRCU, but rather due to the fact
> > that kernel live patching (KLP) had problems with the CPU-bound tasks
> > resulting from repeated synchronize_rcu_expedited() invocations.
> 
> I see.  Perhaps only add to the back-to-back counter if the
> synchronize_srcu_expedited() takes longer than a jiffy? This would
> indirectly check if syncronize_srcu_expedited() readers are actually
> blocking.  KVM uses syncronize_srcu_expedited() because it expects it to
> take very little (again I'll get hard numbers asap).

This is in effect what the patch in my previous email does.  In current
mainline, it waits for up to a jiffy before switching to sleep mode,
but with the patch it waits for between one and two jiffies before making
that switch.

Using call_srcu() with the occasional srcu_barrier() would of course be
faster still, but perhaps more complex.

							Thanx, Paul
