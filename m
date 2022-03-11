Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D314D60BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348061AbiCKLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiCKLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:39:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD863507
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:38:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 954D1B82AD2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A09EC340E9;
        Fri, 11 Mar 2022 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646998681;
        bh=e4y3Z0M6OHH8hOOsfv+op+DHBVtoqM4faCpqS9Xl8uU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g1jxaks/+lJoF0nO1IAAjxawKI0ko+aKkwulHRxCgZnr1xWbUVBLR7c1jdMN+w+U2
         6cm+tTiVqaowR5Ncg4U1esB4Ey5SXwONGFW4fAyQSvddk4B6dQavU1v/gyitXcUMtN
         FylD1vi4UaqJbo4yeGSTinuYHvS5j2ZNSYtUOBMDqDI5+hVyF84mx5PHq1jObzbLnl
         O+jWJhUavz3LM9nWyTvQQcu0LzzJL5FBguiegnqP8+Omnc6wusNY7v9dY8sJOUzCI4
         EMePzLFBq+97ctuNIUOvMpIs2kr1KkhiehRXV+TE2ewdpmNK6q+4zhB2UDXSlRu0uz
         ORzwPjb75UpNg==
Message-ID: <c6333d9ebf5fcf03c1cf62071336c110a013a762.camel@kernel.org>
Subject: Re: [PATCH 00/19] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Date:   Fri, 11 Mar 2022 12:37:55 +0100
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-02 at 16:47 +0100, Frederic Weisbecker wrote:
> This mixes up the RCU dynticks counter and the context tracking state
> updates into a single atomic instruction. This may serve several
> purposes:
> 
> 1) Improve CPU isolation with deferring some disturbances until sensitive
>    userspace workload completes and goes to the kernel. This can take
>    several forms, for example smp_call_function_housekeeping() or
>    on_each_housekeeping_cpu() to enqueue and execute work on all
>    housekeeping CPUs. Then an atomic operation on ct->state can defer
>    the work on nohz_full CPUs until they run in kernel (or IPI them
>    if they are in kernel mode), see this proposal by Peter:
>    https://lore.kernel.org/all/20210929151723.162004989@infradead.org/#r
> 
> 2) Unearth sysidle (https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=sysidle.2017.05.11a&id=fe5ac724d81a3c7803e60c2232718f212f3f38d4)
>    This feature allowed to shutdown the tick on the last housekeeping
>    CPU once the rest of the system is fully idle. We needed some proper
>    fully ordered context tracking for that.
> 
> Inspired by Peterz: https://lore.kernel.org/all/20210929151723.162004989@infradead.org
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/context-tracking
> 
> HEAD: e4eaff86ec91c1cbde9a113cf5232dac9f897337
> 
> Thanks,
> 	Frederic
> ---

I've been testing patches 1 to 18 on my nohz_full setup. Everything is looking
good so far.

Regards,
Nicolas
