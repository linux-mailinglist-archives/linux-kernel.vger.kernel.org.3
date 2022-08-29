Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B005A55D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiH2Uz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiH2UzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:55:14 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA091DA75
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:55:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r141so7638707iod.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/WpZ2alG1CIoH2ULE/+JUbbWqOiZ8hhsZtBC3ijgmwo=;
        b=pJlkh9If2amT6Si6KqoPWg6CjHpZMdIU+/ut+dgDT08GDDA6YC4jAvg9OVCnK/Zjod
         hFYl37in2dJkI15GejgeVPzN98Tger0B0DPotX0rGuLgTeFBssRocoxgE0rBh+2XJCS6
         rUpnan58ARvUdHzPKDIHnmfa+Y6/gkPaviqYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/WpZ2alG1CIoH2ULE/+JUbbWqOiZ8hhsZtBC3ijgmwo=;
        b=ADsmD0mI90rJlEi1jE9px603UHRpefPBPNZRfbaXsQIMXoGVpQT0HTNREvhy0vFIU7
         LKPQQX3/RM2VvdyOtsrbzLhUVpP7+fxmRcPHngcrwBmBhctWYrBzyU0ETXCBZa0L0XWX
         dkNfb27cPH80QYk1DZwsigdFCoJljoEMZsi+rQXKl8fNaAT6+Ym3Sf9MRUEJU7wImN/W
         CAWseXloUkzF8cXmHsPgm9l6OEiLac9BQPyPdD853X/324itV6VZsB4ZyuFM2ajNjbiT
         cKEU1xVkd6PlAJqOCT68kQ+qVwN5WDq8ue/wK80ZB6jDPxkh9A47f17282udEN1UYMuB
         V6HA==
X-Gm-Message-State: ACgBeo3YPkHhGD0O6HZsX/gNnG//oAKMN/nTpxkWVePDa1wuIpTF7KjO
        1v41OfPfZ2U0wFncUX3epclEFNOvE30Rq86YtEFZCQ==
X-Google-Smtp-Source: AA6agR7+DLtTKGZtljenFFZGN/TsTDrf1+ohMTR/lFVEMYQ7Emfj8+dSuxEWx9ak8yEfo4uBY0Ryh7Pth1HL9+bn+ZE=
X-Received: by 2002:a05:6602:26d5:b0:68a:db5d:2923 with SMTP id
 g21-20020a05660226d500b0068adb5d2923mr9121176ioo.175.1661806512482; Mon, 29
 Aug 2022 13:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen> <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen> <20220829203131.GP6159@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220829203131.GP6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 29 Aug 2022 16:54:59 -0400
Message-ID: <CAEXW_YRay19Dw5W1QVjshoi5b7DWhFb=pzSdF9hs-asH3do2cA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 29, 2022 at 4:31 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > > 3) We are mixing up two very different things in a single list of callbacks:
> > > >    lazy callbacks and flooding callbacks, as a result we are adding lots of
> > > >    off-topic corner cases all around:
> > > >      * a seperate lazy len field to struct rcu_cblist whose purpose is much more
> > > >        general than just bypass/lazy
> > > >      * "lazy" specialized parameters to general purpose cblist management
> > > >        functions
> > >
> > > I think just 1 or 2 functions have a new lazy param. It didn't seem too
> > > intrusive to me.
> >
> > What bothers me is that struct cblist has a general purpose and we are adding a field
> > and a parameter that is relevant to only one specialized user.
>
> This does sound like a bad idea, now that you mention it.  Joel, if
> this is still in place, can it be moved near the rcu_data structure's
> bypass-related fields?

Yes, I can certainly do that! Consider it gone *poof* from the
rcu_cblist structure, and moved into the rcu_data.

>
> And by the way, thank you for reviewing this patch series!

And my thanks as well! I am deeply appreciative of y'alls work and
participation.

> > > > So here is a proposal: how about forgetting NOCB for now and instead add a new
> > > > RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
> > > > Then ignore that segment until some timer expiry has been met or the CPU is
> > > > known to be busy? Probably some tiny bits need to be tweaked in segcblist
> > > > management functions but probably not that much. And also make sure that entrain()
> > > > queues to RCU_LAZY_TAIL.
> > > >
> > > > Then the only difference in the case of NOCB is that we add a new timer to the
> > > > nocb group leader instead of a local timer in !NOCB.
> > >
> > > It sounds reasonable, but I'll go with Paul on the usecase argument - who would
> > > actually care about lazy CBs outside of power, and would those guys ever use
> > > !NO_CB if they cared about power / battery?
> >
> > _Everybody_ cares about power. Those who don't yet will very soon ;-)
>
> Apparently not enough to use CONFIG_RCU_FAST_NO_HZ.  Though to be fair,
> that option had its own performance issues.  And it would not reduce
> grace periods anywhere near as much as call_rcu_lazy().  But the problem
> was that last I checked on server workloads, the callbacks were mostly
> those that could not reasonably be lazy.

I see! FWIW, lazy-RCU does not have a lot of benefit on busy systems
in our testing (because other non-lazy RCU CBs keep churning grace
period cycles). So for servers that are mostly busy, the power benefit
may not be that much IMHO.

Thanks,

 - Joel
