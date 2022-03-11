Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BEC4D646A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348736AbiCKPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCKPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:21:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CBA1C65EE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAC89B82C11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110A3C340E9;
        Fri, 11 Mar 2022 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647011996;
        bh=LkMMUZ2X3xMm2AH+71fv9XoZT5c2j1CHmX9ihSVve6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBZOWtr/Y6IYGGrd6/XWmO3fXPORE4Wx26807HQgi0eyhOj+3QGl+hrKEWbD5oxcu
         moJP1lWJTCeqCfRzw82ZvGw+jxFz1O5CxEIZHXNOdgP9eUuC/f02z+Flw59YmIaqUo
         Ach6ubC8uZmYbgEpoZL7C6gTj869tWKVGaeAX07bT4oyGHtHi2YXF7j6PiMJECR3AT
         YbwYcD2PiXt4fZY2ktBdrtVBjVyy+OtpFTInH8WHzYI2cMFV6ZOLcRz2FimhnmG0lS
         nR+IQd4jxzMlXrtaaLgww340c8+dNJv1QVrTpOD0jMm6KmgXzBxv9WDUNN43GgtZiH
         vV0oaVhu9i4dA==
Date:   Fri, 11 Mar 2022 16:19:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 15/19] rcu/context-tracking: Remove unused and/or
 unecessary middle functions
Message-ID: <20220311151953.GA227945@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-16-frederic@kernel.org>
 <465c71e018de9800ba22a84b9c16f56f99aabefd.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465c71e018de9800ba22a84b9c16f56f99aabefd.camel@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:40:15PM +0100, nicolas saenz julienne wrote:
> On Wed, 2022-03-02 at 16:48 +0100, Frederic Weisbecker wrote:
> > Some eqs functions are now only used internally by context tracking, so
> > their public declarations can be removed.
> > 
> > Also middle functions such as rcu_user_*() and rcu_idle_*()
> > which now directly call to rcu_eqs_enter() and rcu_eqs_exit() can be
> > wiped out as well.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > Cc: Yu Liao<liaoyu15@huawei.com>
> > Cc: Phil Auld <pauld@redhat.com>
> > Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> > Cc: Alex Belits <abelits@marvell.com>
> > ---
> 
> You missed rcu_user_{enter,exit} declarations in rcupdate.h
> 
> There are also comments refering to them in kernel/context_tracking.c and
> Documentation/RCU/stallwarn.rst.

And I thought nobody would notice ;-)

Thanks!
