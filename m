Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2E53D4FA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 05:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbiFDDDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 23:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFDDDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 23:03:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24E1F639
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 20:03:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id az35so190533qkb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 20:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LsfZ82PdOPICg3ihOidrmbQM4Kx+GZgOc28RlAEoupY=;
        b=kUbvaz0O2SDRUAO2RX5cvc3zRaR+X0Vijo2W9/iKMlewn7tnAKXhPRLddAVXqktGmX
         r6tmhXr8Eny7pmO8gzcTXj/3hHqfob7UYrrm0wakgGb8Oa14LfVtCtna3Z5oFtZuAw+r
         cDreEQOOTxdd/VPfuXnxZ3IHN62qAKq0ItkvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LsfZ82PdOPICg3ihOidrmbQM4Kx+GZgOc28RlAEoupY=;
        b=kKswfq1gFKyUKMIYifGl9CqTF4A0atAnHFcctzQ6RLT2hqed4+WekgjC0fCpUPpNew
         h51Tp4hptbnCJtqAlBKaISUKI60IRHwPZHjLsMB7vpfUzmGjmQa2WjVWH7F4EUxkRJvE
         zP8nzUGgYoekgtpqiOlnPCySK9XcPmEvPPt3+DV6wUfcN6Lo0Vwdfj2x4Qg+0JBOkzjT
         SNEF/VQydcfAoGm3aEUZD2/Fisz4iZPgHMxyT6wgiItvz7Xeqe3M1ElTlJe/DVozdkAH
         tTvVt4K3UdMYNn4vbMnBQahB5JaGrP1kqpTjKrTG68mSQ93ve29LH9uLvCsANXGF2ERA
         PkzQ==
X-Gm-Message-State: AOAM532AdRy8fCeOG7oI1Z5n65FcupdBOANkvLyX3DayuPRb/SCjxJAZ
        WqXbijTbcOQzwkmxw6LgFJIDmg==
X-Google-Smtp-Source: ABdhPJy/0mDJfNuLLNZUcHBjp83BmcsFrBFT5Df5tL7JehfM1AIMdGKvXeLHfOiqe0gRDOxTmdHgNg==
X-Received: by 2002:a05:620a:4453:b0:6a0:3fa3:eb41 with SMTP id w19-20020a05620a445300b006a03fa3eb41mr8780132qkp.309.1654311791232;
        Fri, 03 Jun 2022 20:03:11 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006a6a6f148e6sm1605779qkl.17.2022.06.03.20.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 20:03:10 -0700 (PDT)
Date:   Sat, 4 Jun 2022 03:03:10 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <YprLbpCyLUCVAwg5@google.com>
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
 <YplIh8BoYXc8X77q@google.com>
 <Ypnafl/65x4jHnfv@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypnafl/65x4jHnfv@pc638.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:55:10AM +0200, Uladzislau Rezki wrote:
> On Thu, Jun 02, 2022 at 11:32:23PM +0000, Joel Fernandes wrote:
> > On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> > > Currently the monitor work is scheduled with a fixed interval that
> > > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > > a low utilization of page slot in some scenarios. The page can store
> > > up to 512 records. For example on Android system it can look like:
> > > 
> > > <snip>
> > >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> > >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> > >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> > >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> > >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> > >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> > >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> > >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> > >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> > >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> > >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > > <snip>
> > > 
> > > where a page only carries few records to reclaim a memory. In order to
> > > improve batching and make utilization more efficient the patch introduces
> > > a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> > > KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> > > case a memory reclaim occurs more often whereas in mostly idle cases the
> > > interval is set to its maximum timeout that improves the utilization of
> > > page slots.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> Thanks!
> 
> This patch makes the interval hard-coded in some sense so you can not change
> it in runtime, only recompilation. If there is a need or request we can make
> both as module_param().

Yes, this seems a good first step.

> If we are to do that we can just add one extra patch on top of it.

Yes.

thanks,

 - Joel

