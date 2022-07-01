Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91489562FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiGAJZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiGAJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8855BBC3A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n10so1888502plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJeZ+WjGaa4+hEW3peCfL4WVLqu3B1Bi1AgPkXR9HIk=;
        b=R/rFsTuMPBZeGoQMe5rYyJANDvRFdef9oY6LPondRkVUztcd28xeNsSzmhnUo4eBww
         +x60eYfl4AdmEM6sTvyy8sa9vHqv9NZ1r7QbmD0u7SmABya69yR7Urd50af3M1V/kfle
         qSh0Gwu06AB9leH2/pcwVsNCfdlU8+mKSnZzJp7ZVX3dZSZN2GsYdgI3NAR9Lv6VT33h
         f2Tn4HDTq/BbY96l3xXbMHf+3430IejO8/tU5NFkq6Vazi87xLtVgpVx5wutiH3NBbzo
         sv6a+GE4nNE/s0C5OhPZ9rlNIeRMi/P/ay+/RtbICcmImSxD90OM7EH8RpNuEncoa+61
         JWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJeZ+WjGaa4+hEW3peCfL4WVLqu3B1Bi1AgPkXR9HIk=;
        b=IKQtHW+8Gqq7p0gj0LN4ajSLz5UOn/k/bOxMjQWWVVqo9dEJt1HVy+RmtVlMraKJpl
         /PWMbXDCCc4HpEq95r88p5QOKOzjEoMCx8XoLdUpn+vztITGSxZxGlZbr7TGc9qVz6nX
         D4qy0H+0Dagd1T5GdzKvj8bmQ5/f/J5Q8nbcCPXyynNID09AsEcvNajSxCSeZRKziWRC
         bhy1bEtPZgCLm8wpVs+41ifziNnzM4EcTELazke182mh1Hr9zD48RKqJVOJ6T5DgRQ/X
         w73ED69gkDdsL59XisBnLBYalS5kBCkIMSHqWWoje+Ci5eA8p+4dTOAsw9u7pQXBORZx
         qnbA==
X-Gm-Message-State: AJIora8x++f8E3yRDOKwA80JRgthEruEyz5QE1ts8AT5JxSU8z2A/Llx
        C24NQ61H9As4uZ6Lx2U9+1XP6w==
X-Google-Smtp-Source: AGRyM1tn/3ZuTQnenTLiteUpSdYtxwuzIw1xhxbu5YIzTLOAH+lxcAfgGpHVt5veQYdR5OCjkdBwfA==
X-Received: by 2002:a17:903:2c6:b0:16a:276a:ad81 with SMTP id s6-20020a17090302c600b0016a276aad81mr19827350plk.65.1656667501039;
        Fri, 01 Jul 2022 02:25:01 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b00163f2f9f07csm15020084plc.48.2022.07.01.02.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 02:25:00 -0700 (PDT)
Date:   Fri, 1 Jul 2022 14:54:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 24/30] serial: qcom: Migrate to dev_pm_opp_set_config()
Message-ID: <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
 <Yr6z5ixRTsIbZvsq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr6z5ixRTsIbZvsq@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-22, 10:44, Greg Kroah-Hartman wrote:
> On Fri, Jul 01, 2022 at 01:50:19PM +0530, Viresh Kumar wrote:
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > +	struct dev_pm_opp_config config = {
> > +		.clk_names = (const char *[]){ "se" },
> > +		.clk_count = 1,
> > +	};
> >  
> > -	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
> > +	ret = devm_pm_opp_set_config(&pdev->dev, &config);
> 
> This feels like a step back.  This is much harder now, what's wrong with
> devm_pm_opp_set_clkname() as is?

Hi Greg,

There are a number of configurations one can do for a device's OPP
table currently:

- clk, single or multiple (new)
- helper to configure multiple clocks (for multiple clocks)
- supplies or regulators
- helper to configure supplies (for multiple supplies)
- OPP supported-hw property
- OPP Property-name
- Genpd specific one
- etc

One problem was that it was a mess within the OPP core with a separate
interface for each of these interfaces, almost duplicate code, etc.

But then it was a bigger mess for the user drivers that need to manage
a few of these. They were required to call multiple APIs, with all the
interfaces returning tokens, which the callers need to save and supply
back to free the resources later. More code, hard to manage, easy to
abuse and add bugs to.

The new interface makes it easier and clean for everyone and allows
easy upgrades of interfaces in future. Adding a new interface, like
support for multiple clocks for a device that I just did, is much
easier now.

I really believe this is a step in the right direction :)

-- 
viresh
