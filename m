Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFE56CC35
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGJBiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGJBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:38:03 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D181BEB9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 18:38:02 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g1so1654362qkl.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 18:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zg8kU8L72tPIvWCiVTIJw7BwgVkbotl+8MU4rFDgnnU=;
        b=UAaQT1JtDJ1xuvBsX5S5V6w+9jyRdy2+ltqupEmsuQP/30BEtpMrY01IdKQDBoD0NL
         4HOlmKpek4e9rVX4nyhJb+4GNkneEJDRKld+yLRLEgw6SZGcVaAHQL25DgYFXZd+Asqe
         E/ns/MDptEsjBvCopunZNQ3YM+t3SGrp5gSYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zg8kU8L72tPIvWCiVTIJw7BwgVkbotl+8MU4rFDgnnU=;
        b=DOoYdTpfWYqTdgCRAbhzi7f94p+paUH6XC9rW6jlcfhDS64HmRbYFALYJmnmdAWNKK
         Hi656q7/G7HFhRKUbLTXUNs77ZHpxLaNmJqVk9JNusE9YhQGvegOVOy+ULNR1VkenNNl
         AuJtq9ufKjweDAfiek787RiDvOX5IijLjPbroNFtiL9tKw/5I98Q3oitwDTAC6xHnN+F
         UXCmd47ym8kFHnFUv5mB8uV29BKFUgtEczHg9huQi/lCdP/0EatiL+OfRuPu305NHovP
         IlLP7ceZYYPu6nPgXmWML0xaWYBXeTKaGbF4MD0QvPwbYYTu+PNTaK9mxM7CrUdMSHpH
         gSRA==
X-Gm-Message-State: AJIora/0iJ8BfjbI89vRhZqxF7C7NOtdCpHFJixxBsQJ/UhH2kz3pRDw
        oMGCoFweEwkpYYyUzwWsQyq9Vw==
X-Google-Smtp-Source: AGRyM1u1wLfeOuQd+BLT9o7UuMOH1Jb/yp3QUKowdVefD30sHot9hR3rTHgVPcL7Yol1J4fsYAAnyg==
X-Received: by 2002:a05:620a:27cc:b0:6b5:4dd4:d177 with SMTP id i12-20020a05620a27cc00b006b54dd4d177mr7508946qkp.70.1657417082083;
        Sat, 09 Jul 2022 18:38:02 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ci17-20020a05622a261100b00304f55e56e4sm2503726qtb.40.2022.07.09.18.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:38:01 -0700 (PDT)
Date:   Sun, 10 Jul 2022 01:38:01 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 0/8] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <YsoteYyJoOSzMGsr@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220626031206.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <Ysev2jbxFGNkLvjG@google.com>
 <20220708224514.GB1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708224514.GB1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 03:45:14PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 08, 2022 at 04:17:30AM +0000, Joel Fernandes wrote:
> > On Sat, Jun 25, 2022 at 08:12:06PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 22, 2022 at 10:50:53PM +0000, Joel Fernandes (Google) wrote:
> > > > 
> > > > Hello!
> > > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > > difference between the previous version is that it is now using bypass lists,
> > > > and thus handling rcu_barrier() and hotplug situations, with some small changes
> > > > to those parts.
> > > > 
> > > > I also don't see the TREE07 RCU stall from v1 anymore.
> > > > 
> > > > In the v1, we some numbers below (testing on v2 is in progress). Rushikesh,
> > > > feel free to pull these patches into your tree. Just to note, you will also
> > > > need to pull the call_rcu_lazy() user patches from v1. I have dropped in this
> > > > series, just to make the series focus on the feature code first.
> > > > 
> > > > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > > > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > > > system is very lightly loaded but constantly running few RCU callbacks very
> > > > often. This confuses the power management hardware that the system is active,
> > > > when it is in fact idle.
> > > > 
> > > > For example, when ChromeOS screen is off and user is not doing anything on the
> > > > system, we can see big power savings.
> > > > Before:
> > > > Pk%pc10 = 72.13
> > > > PkgWatt = 0.58
> > > > CorWatt = 0.04
> > > > 
> > > > After:
> > > > Pk%pc10 = 81.28
> > > > PkgWatt = 0.41
> > > > CorWatt = 0.03
> > > 
> > > So not quite 30% savings in power at the package level?  Not bad at all!
> > 
> > Yes this is the package residency amount, not the amount of power. This % is
> > not power.
> 
> So what exactly is PkgWatt, then?  If you can say.  That is where I was
> getting the 30% from.

Its the total package power (SoC power) - so like not just the CPU but also
the interconnect, other controllers and other blocks in there.

This output is from the turbostat program and the number is mentioned in the
manpage:
"PkgWatt Watts consumed by the whole package."
https://manpages.debian.org/testing/linux-cpupower/turbostat.8.en.html


> > > > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > > > can see that the display pipeline is constantly doing RCU callback queuing due
> > > > to open/close of file descriptors associated with graphics buffers. This is
> > > > attributed to the file_free_rcu() path which this patch series also touches.
> > > > 
> > > > This patch series adds a simple but effective, and lockless implementation of
> > > > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > > > initiate a flush of one or more per-CPU lists.
> > > 
> > > It is no longer lockless, correct?  Or am I missing something subtle?
> > > 
> > > Full disclosure: I don't see a whole lot of benefit to its being lockless.
> > > But truth in advertising!  ;-)
> > 
> > Yes, you are right. Maybe a better way I could put it is it is "lock
> > contention less" :D
> 
> Yes, "reduced lock contention" would be a good phrase.  As long as you
> carefully indicate exactly what scenario with greater lock contention
> you are comparing to.
> 
> But aren't you acquiring the bypass lock at about the same rate as it
> would be aquired without laziness?  What am I missing here?

You are right, why not I just drop the locking phrases from the summary.
Anyway the main win from this work is not related to locking.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> > > > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > > > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > > > of function graph tracer when increasing that.
> > > > 
> > > > One drawback of this series is, if another frequent RCU callback creeps up in
> > > > the future, that's not lazy, then that will again hurt the power. However, I
> > > > believe identifying and fixing those is a more reasonable approach than slowing
> > > > RCU down for the whole system.
> > > 
> > > Very good!  I have you down as the official call_rcu_lazy() whack-a-mole
> > > developer.  ;-)
> > 
> > :-D
> > 
> > thanks,
> > 
> >  - Joel
> > 
