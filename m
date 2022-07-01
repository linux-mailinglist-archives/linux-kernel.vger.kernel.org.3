Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7FD56313D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiGAKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiGAKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D0E19C21;
        Fri,  1 Jul 2022 03:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F5762385;
        Fri,  1 Jul 2022 10:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E0AC341C7;
        Fri,  1 Jul 2022 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656670700;
        bh=LueGHu0phaZAdqh5IchuD6JHc8SA/6eT66RBdcfIcjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKRSrnxqIg87rzd0TWCG0J4CggaW94AeKqKU/ikGgzRLVHXqdTw28u4WsUzvqez0V
         XaD4sCNQFW5tNxohu2Yz5oKjD+ooSbWxplf0y4c7YSyaE+njivPxH2ttjjnmIKiUOa
         yMb3IyuKRsLIAf/CLP70K7BmuId7fbwnBMi2XzNI=
Date:   Fri, 1 Jul 2022 12:18:17 +0200
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
Message-ID: <Yr7J6f6+EQfXFjYN@kroah.com>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
 <Yr6z5ixRTsIbZvsq@kroah.com>
 <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
 <Yr7AwAZeSPeQKDPU@kroah.com>
 <20220701100100.bxv4t4t7iqphalpv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701100100.bxv4t4t7iqphalpv@vireshk-i7>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:31:00PM +0530, Viresh Kumar wrote:
> On 01-07-22, 11:39, Greg Kroah-Hartman wrote:
> > It's now more complex for simple drivers like this, right?
> 
> They need to add a structure, yes.
> 
> > Why not
> > provide translations of the devm_pm_opp_set_clkname() to use internally
> > devm_pm_opp_set_config() if you want to do complex things,
> 
> That can be done, yes.
> 
> > allowing you
> > to continue to do simple things without the overhead of a driver having
> > to create a structure on the stack
> 
> I didn't think of it as complexity, and I still feel it is okay-ish.
> 
> > and remember how the "const char *[]"
> > syntax looks like (seriously, that's crazy).
> 
> The syntax can be fixed, if we want, by avoiding the cast with
> something like this:
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index a018b45c5a9a..1a5480214a43 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2559,8 +2559,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         const struct sdhci_msm_offset *msm_offset;
>         const struct sdhci_msm_variant_info *var_info;
>         struct device_node *node = pdev->dev.of_node;
> +       const char *clks[] = { "core" };
>         struct dev_pm_opp_config opp_config = {
> -               .clk_names = (const char *[]){ "core" },
> +               .clk_names = clks,
>                 .clk_count = 1,
>         };

Still crazy, but a bit better.

Why do you need the clk_count?  A null terminated list is better, as the
compiler can do it for you and you do not have to keep things in sync
like you are expecting people to be forced to do now.

> > Make it simple for simple things, and provide the ability to do complex
> > things only if that is required.
> 
> I still feel it isn't too bad for simple cases right now too, it is
> just a structure to fill out but I don't have hard feelings for
> keeping the old API around. I just feel it isn't too helpful to keep
> the old interfaces around, it will just confuse people at the best.

The above is much more complex than a simple function call to make.
Remember to make it very simple for driver authors, and more
importantly, reviewers.

> Anyway, I will keep them around.

Thanks, and drop the count field please.

thanks,

greg k-h
