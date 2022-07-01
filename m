Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33002563060
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiGAJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiGAJjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:39:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712891EAF1;
        Fri,  1 Jul 2022 02:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DBB1B82D7B;
        Fri,  1 Jul 2022 09:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565B3C3411E;
        Fri,  1 Jul 2022 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656668354;
        bh=0sEyJePAIlTdmtPkGFkh47O0MW8T3+MGC/jTPw4JD+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=endj+OEKxHSxBFJ9luqmgllI6SiW0HlqjtVRXtTqyJBYQ0HTj0r6DE59cD3hCeNLO
         ztdoiozpfyXB4KlrAqUPKxOGafOBKEeOCv90/utxJMETDqnuKSApByaEgV3xcKOEvW
         7FWV29QtHjEISCM8gjYbmVPA+qoDe7XCsleGhzTg=
Date:   Fri, 1 Jul 2022 11:39:12 +0200
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
Message-ID: <Yr7AwAZeSPeQKDPU@kroah.com>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
 <Yr6z5ixRTsIbZvsq@kroah.com>
 <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 02:54:58PM +0530, Viresh Kumar wrote:
> On 01-07-22, 10:44, Greg Kroah-Hartman wrote:
> > On Fri, Jul 01, 2022 at 01:50:19PM +0530, Viresh Kumar wrote:
> > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > > +	struct dev_pm_opp_config config = {
> > > +		.clk_names = (const char *[]){ "se" },
> > > +		.clk_count = 1,
> > > +	};
> > >  
> > > -	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
> > > +	ret = devm_pm_opp_set_config(&pdev->dev, &config);
> > 
> > This feels like a step back.  This is much harder now, what's wrong with
> > devm_pm_opp_set_clkname() as is?
> 
> Hi Greg,
> 
> There are a number of configurations one can do for a device's OPP
> table currently:
> 
> - clk, single or multiple (new)
> - helper to configure multiple clocks (for multiple clocks)
> - supplies or regulators
> - helper to configure supplies (for multiple supplies)
> - OPP supported-hw property
> - OPP Property-name
> - Genpd specific one
> - etc
> 
> One problem was that it was a mess within the OPP core with a separate
> interface for each of these interfaces, almost duplicate code, etc.
> 
> But then it was a bigger mess for the user drivers that need to manage
> a few of these. They were required to call multiple APIs, with all the
> interfaces returning tokens, which the callers need to save and supply
> back to free the resources later. More code, hard to manage, easy to
> abuse and add bugs to.
> 
> The new interface makes it easier and clean for everyone and allows
> easy upgrades of interfaces in future. Adding a new interface, like
> support for multiple clocks for a device that I just did, is much
> easier now.
> 
> I really believe this is a step in the right direction :)

It's now more complex for simple drivers like this, right?  Why not
provide translations of the devm_pm_opp_set_clkname() to use internally
devm_pm_opp_set_config() if you want to do complex things, allowing you
to continue to do simple things without the overhead of a driver having
to create a structure on the stack and remember how the "const char *[]"
syntax looks like (seriously, that's crazy).

Make it simple for simple things, and provide the ability to do complex
things only if that is required.

thanks,

greg k-h
