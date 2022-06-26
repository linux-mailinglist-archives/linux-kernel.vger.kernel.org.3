Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2D55B278
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiFZOh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFZOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:37:24 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845ABD98
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:37:23 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 65so846470qva.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZQN6rdXZBeRbBi6GH04arvPTXSrKXpzLHtzZj9DXNVE=;
        b=lA2BlcAaOVpZDxOT8XkzpGCat+hcNgXLVjJuuUUtLzNtVUT6SSpQTCagJtwzGwDMPS
         q9pqOUuUdwiPB8b0YL2nNy5IvmtfOeh1IXWGWr424UmaFGMd2KGQS3DG/LcNgvZk10ke
         S+AUUxeVmU2UsJVxuJKiEgCSr3c9O/r95YoZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZQN6rdXZBeRbBi6GH04arvPTXSrKXpzLHtzZj9DXNVE=;
        b=skAjfyAZhQbkQooWcorCe/jEqbN8YlBNoWgDRutkm1GPHcL4gcZT5y93c8srJ4r5vH
         fE0CWR1tQbuXt+FuN2BtQw3bqQP2b5QbP5oIR4tg6UecuOwr4iB0n02OWlzhjbQ5HJbn
         HJEpMD13p2AcOw8tUAwbhE/kUx9HNDza4ohMpeTgHwDDbyf/EUn+uyx9+rDeo3Uc2H03
         GFqOvqQFnml6NRg3ooy/CAcaS1JCJz6G76LddY5bEJsrtfVe14ulCnjOf6OAUGk/4cu+
         qsZqTSbs9QzSE5nSlpKXKClLn+2+fwQJFREVmiMnnmqtNXL66Cx4X5rsbWQHwVOY5y1f
         A8yQ==
X-Gm-Message-State: AJIora/lI4BtrBNKgzGZA84J8mMO2QvbzKE7zE9cKnKphiNO6l8qsAsH
        YJKjFmYUPaOQcqCJQ3g9oyyt4A==
X-Google-Smtp-Source: AGRyM1s+8y5vj/HBVvv+O0uvVJ3pftXmeAs5pWvNgkAERy88K99A+wR4w8mYn/L0mL3qTuVinkxXgA==
X-Received: by 2002:ac8:5f0f:0:b0:305:1fc0:482 with SMTP id x15-20020ac85f0f000000b003051fc00482mr6115094qta.121.1656254242692;
        Sun, 26 Jun 2022 07:37:22 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a13cd00b0030a9dfb2898sm5245765qtk.85.2022.06.26.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:37:22 -0700 (PDT)
Date:   Sun, 26 Jun 2022 14:37:22 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 5/8] rcu/nocb: Wake up gp thread when flushing
Message-ID: <YrhvIqnl/n3HaHUf@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-7-joel@joelfernandes.org>
 <20220626040622.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yrhi/Jwm0eLmDIGb@google.com>
 <20220626135240.GP1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626135240.GP1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 06:52:40AM -0700, Paul E. McKenney wrote:
> On Sun, Jun 26, 2022 at 01:45:32PM +0000, Joel Fernandes wrote:
> > On Sat, Jun 25, 2022 at 09:06:22PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 22, 2022 at 10:50:59PM +0000, Joel Fernandes (Google) wrote:
> > > > We notice that rcu_barrier() can take a really long time. It appears
> > > > that this can happen when all CBs are lazy and the timer does not fire
> > > > yet. So after flushing, nothing wakes up GP thread. This patch forces
> > > > GP thread to wake when bypass flushing happens, this fixes the
> > > > rcu_barrier() delays with lazy CBs.
> > > 
> > > I am wondering if there is a bug in non-rcu_barrier() lazy callback
> > > processing hiding here as well?
> > 
> > I don't think so because in both nocb_try_bypass and nocb_gp_wait, we are not
> > going to an indefinite sleep after the flush. However, with rcu_barrier() ,
> > there is nothing to keep the RCU GP thread awake. That's my theory at least.
> > In practice, I have not been able to reproduce this issue with
> > non-rcu_barrier().
> > 
> > With rcu_barrier() I happen to hit it thanks to the rcuscale changes I did.
> > That's an interesting story! As I apply call_rcu_lazy() to the file table
> > code, turns out that on boot, the initram unpacking code continously triggers
> > call_rcu_lazy(). This happens apparently in a different thread than the one
> > that rcuscale is running in. In rcuscale, I did rcu_barrier() at init time
> > and this stalled for a long time to my surprise, and this patch fixed it.
> 
> Cool!
> 
> Then should this wake_nocb_gp() instead go into the rcu_barrier()
> code path?  As shown below, wouldn't we be doing some spurious wakeups?

You are right. In my testing, I don't see any issue with the extra wake up
which is going to happen anyway and my thought was why not do it so that a
future bypass flush from some other path forgets to call wake up.

I'll refine it to be rcu-barrier-only then.

thanks!

 - Joel

