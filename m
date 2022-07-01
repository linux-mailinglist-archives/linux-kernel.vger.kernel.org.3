Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973C0562EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiGAIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiGAIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694AD73587;
        Fri,  1 Jul 2022 01:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2560FB82EEE;
        Fri,  1 Jul 2022 08:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B41C3411E;
        Fri,  1 Jul 2022 08:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656665064;
        bh=ff3IXJSH71dvCV/eOmVSMR0aG0V0qwXJOmu8LZRehP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6/deRXh3ZURDgIspy7x5W7LJxPnBaVcos3JEs+Vaq9z02ZyeNZuvyZ6UKwCNrWbb
         WHWUAUFfTi5C0vMmLMxAKTQDvslvKCNoDOLfD2gVfldFm4HJKHbMPJ8uurRvQXxtt7
         ZgD4GQ+b011ziEw/U5L6jOcazQq2v93z6JwI1Tak=
Date:   Fri, 1 Jul 2022 10:44:22 +0200
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
Message-ID: <Yr6z5ixRTsIbZvsq@kroah.com>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 01:50:19PM +0530, Viresh Kumar wrote:
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
> 
> Lets start using it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 4733a233bd0c..ab667838d082 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1347,6 +1347,10 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	int irq;
>  	bool console = false;
>  	struct uart_driver *drv;
> +	struct dev_pm_opp_config config = {
> +		.clk_names = (const char *[]){ "se" },
> +		.clk_count = 1,
> +	};
>  
>  	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
>  		console = true;
> @@ -1430,7 +1434,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
>  		port->cts_rts_swap = true;
>  
> -	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
> +	ret = devm_pm_opp_set_config(&pdev->dev, &config);

This feels like a step back.  This is much harder now, what's wrong with
devm_pm_opp_set_clkname() as is?

thanks,

greg k-h
