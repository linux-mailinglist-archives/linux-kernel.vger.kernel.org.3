Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9A56B150
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiGHERe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiGHERd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:17:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64927CDE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:17:32 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y3so4724122qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGoy5SHC3OQwhZlm2IT5uM+W5kXJSSMgEQTx8s2qElc=;
        b=v7C/SD2n/xR97dosIcWJVUeECNHIjuG1oHxTMiH3BiPHtH5O2vCHfnxT4nJ7BaCfjC
         1GzcHFMTNlW4KnRttTVVskdHvFl+iyo2rkGjCy7VbEegG0Il9go17UqqaevcvjZULSfD
         Cw24NvgzegAnGIM/s67DnOdFzTXO+wF5XPD/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGoy5SHC3OQwhZlm2IT5uM+W5kXJSSMgEQTx8s2qElc=;
        b=lbnUHRB7XjT40ym0ZOdTb85/yJL0+wFi8yuf0RmtGUQ+UL1m4xTTLTxt1+OBbLtooj
         ij5xNY2yh7ninv7loqIJ9QpdrddpaC9exu1aXBrUJvuTgRbU09i3PVBVZ5/+/ZrSDdQv
         /eiPfN6wcu6vJfGAkE7kcriHrBesYP8n2IecHc0grnYAd50aGhVniU08v4Spk5KXMw3b
         tfZ1zN1KB3NVDXsTlrhkx6CnQhPxv1SxYhPgBuTm5Y56TnoKLqDuaH9tAbEINpq+5jwr
         7YhGL2wnl1oEWcvmh5HAHsEgSiJvfEPgcl4bgAHpLjyL/Eh6aZurA9IY0hlHHzi16Bcb
         gksg==
X-Gm-Message-State: AJIora8ZPklQ+1WYYJsmikZVtbxbkS1DCrVtvIZuT49wkdio+NXezdMb
        2P/2deOI10sS77ICqjY2iAkHIxhTl2rIGA==
X-Google-Smtp-Source: AGRyM1ujMKRohqwU3MDLZwVDRoNOfBtY4Z79IawBLrj08rRTfhFWnS9F4aRCa/Of+pGM1gE3GR1Cpg==
X-Received: by 2002:ac8:5713:0:b0:31a:c706:50ef with SMTP id 19-20020ac85713000000b0031ac70650efmr1299549qtw.267.1657253851629;
        Thu, 07 Jul 2022 21:17:31 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a222800b006ab935c1563sm31103220qkh.8.2022.07.07.21.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 21:17:31 -0700 (PDT)
Date:   Fri, 8 Jul 2022 04:17:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 0/8] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <Ysev2jbxFGNkLvjG@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220626031206.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626031206.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 08:12:06PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 22, 2022 at 10:50:53PM +0000, Joel Fernandes (Google) wrote:
> > 
> > Hello!
> > Please find the next improved version of call_rcu_lazy() attached.  The main
> > difference between the previous version is that it is now using bypass lists,
> > and thus handling rcu_barrier() and hotplug situations, with some small changes
> > to those parts.
> > 
> > I also don't see the TREE07 RCU stall from v1 anymore.
> > 
> > In the v1, we some numbers below (testing on v2 is in progress). Rushikesh,
> > feel free to pull these patches into your tree. Just to note, you will also
> > need to pull the call_rcu_lazy() user patches from v1. I have dropped in this
> > series, just to make the series focus on the feature code first.
> > 
> > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > system is very lightly loaded but constantly running few RCU callbacks very
> > often. This confuses the power management hardware that the system is active,
> > when it is in fact idle.
> > 
> > For example, when ChromeOS screen is off and user is not doing anything on the
> > system, we can see big power savings.
> > Before:
> > Pk%pc10 = 72.13
> > PkgWatt = 0.58
> > CorWatt = 0.04
> > 
> > After:
> > Pk%pc10 = 81.28
> > PkgWatt = 0.41
> > CorWatt = 0.03
> 
> So not quite 30% savings in power at the package level?  Not bad at all!

Yes this is the package residency amount, not the amount of power. This % is
not power.

> > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > can see that the display pipeline is constantly doing RCU callback queuing due
> > to open/close of file descriptors associated with graphics buffers. This is
> > attributed to the file_free_rcu() path which this patch series also touches.
> > 
> > This patch series adds a simple but effective, and lockless implementation of
> > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > initiate a flush of one or more per-CPU lists.
> 
> It is no longer lockless, correct?  Or am I missing something subtle?
> 
> Full disclosure: I don't see a whole lot of benefit to its being lockless.
> But truth in advertising!  ;-)

Yes, you are right. Maybe a better way I could put it is it is "lock
contention less" :D

> > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > of function graph tracer when increasing that.
> > 
> > One drawback of this series is, if another frequent RCU callback creeps up in
> > the future, that's not lazy, then that will again hurt the power. However, I
> > believe identifying and fixing those is a more reasonable approach than slowing
> > RCU down for the whole system.
> 
> Very good!  I have you down as the official call_rcu_lazy() whack-a-mole
> developer.  ;-)

:-D

thanks,

 - Joel

