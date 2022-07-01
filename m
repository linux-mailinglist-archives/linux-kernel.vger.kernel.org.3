Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF59F5631A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiGAKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbiGAKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D57C1B2;
        Fri,  1 Jul 2022 03:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD1762489;
        Fri,  1 Jul 2022 10:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D87C3411E;
        Fri,  1 Jul 2022 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656672086;
        bh=fYXFGVsJmGdknY5ZLNu6gkfrzL41cNJOTXJpZUyIaBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLwA8SbyY403rkRplkbUNJpqHD+H1aebvZj5xPPEVrO4giwR9UghM42sdmyJKsVlE
         KyGbQroDiYgXUHr7+iB4RUWSp0pBw6kXwrp/rZfW3INKKd0FQfGS1MASqyzggYT2PP
         4ZgW8EJpMloro1neY3ghLIkZgIDrXjyBSaOCgaEk=
Date:   Fri, 1 Jul 2022 12:41:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 24/30] serial: qcom: Migrate to dev_pm_opp_set_config()
Message-ID: <Yr7PUxdOKYp91mG0@kroah.com>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
 <Yr6z5ixRTsIbZvsq@kroah.com>
 <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
 <Yr7AwAZeSPeQKDPU@kroah.com>
 <20220701100100.bxv4t4t7iqphalpv@vireshk-i7>
 <Yr7J6f6+EQfXFjYN@kroah.com>
 <20220701102926.uwvn7rurbxdybzeu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701102926.uwvn7rurbxdybzeu@vireshk-i7>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:59:26PM +0530, Viresh Kumar wrote:
> On 01-07-22, 12:18, Greg Kroah-Hartman wrote:
> > On Fri, Jul 01, 2022 at 03:31:00PM +0530, Viresh Kumar wrote:
> > Still crazy, but a bit better.
> 
> :)
> 
> > Why do you need the clk_count?  A null terminated list is better,
> 
> Because I am not a big fan of the null terminated lists :)
> 
> I had to chase a bug once where someone removed that NULL at the end
> and it was a nightmare to understand what's going on.

But that's the "normal" way the kernel does things.  Trying to keep a
count in sync with a list is a pain, and just gets harder and harder
over time.  Make it a null-terminated list so that the cpu makes this
always work and prevents errors.

> > as the
> > compiler can do it for you and you do not have to keep things in sync
> > like you are expecting people to be forced to do now.
> 
> I am not sure I understand what the compiler can do for us here.
> 
> The users will be required to do this here, isn't it ?
> 
>         const char *clks[] = { "core", NULL };
>         struct dev_pm_opp_config opp_config = {
>                .clk_names = clks,
>         };
> 

The "in sync" is the count issue.  Don't force humans to count up the
number of items in a list please.

> > The above is much more complex than a simple function call to make.
> > Remember to make it very simple for driver authors, and more
> > importantly, reviewers.
> 
> Hmm.
> 
> > Thanks, and drop the count field please.
> 
> There is one case at least [1] where we actually have to pass NULL in
> the clk name. This is basically to allow the same code to run on
> different devices, one where an OPP table is present and one where it
> isn't. We don't want to do clk_set_rate() for the second case but just
> use dev_pm_opp_set_rate() (which does a lot of stuff apart from just
> clk).

That feels completely wrong, don't have NULL for a name, make a fake name
or something.  Don't make all users in the kernel have a horrible
interface just for one piece of broken hardware out there.

Worst case, name it "".

thanks,

greg k-h
