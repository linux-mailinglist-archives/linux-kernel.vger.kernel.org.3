Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB81520D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiEJEpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbiEJEo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:44:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A551CB1B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:40:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i24so13950709pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lbY1apz0pshrpCAaJ1RrYyZnbJ+UjeS0fVoXXo8j4x4=;
        b=g1O4yIW8IBZL4UjQArViSLk8BGWFwVVdDj4k3lboHQlTkJQ+rm3mIbeCIIKgBldnDL
         vemV1tqpX0uc13aujVWctoK7Xgz/Zw9Wdv34dhYv0rS2b96Ryzawc8Q7WTi9VBXsyM8/
         I5Pi+SicIj63pu9fYM3QYaBG5+AIDSGzQCMOf3QCc6fdmLUVblR7n6tedFbDYuwdUZhu
         zIuKHv2b8wLek6nQwSIbFcYwuO2pnT7dYWxxulUgiS5fNtP+EASQcqA5eMTg8QKMPEiX
         u1yAPilOKbWZR5pPKRYIkh4RjlpecE57z8J7ag6lrDvUnChqYht9pXoHxKkm7w1GC0Ey
         LmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbY1apz0pshrpCAaJ1RrYyZnbJ+UjeS0fVoXXo8j4x4=;
        b=XrNMYEjK+5TFyJok5t0IO1PQcIJsLoiQQ/wQKpJPIme2v3MeHfXrew1o1P2TTKZonP
         uywWWMIWo+V+qG9oUQpJR4PsD4pmIM450TuEIqNBfAaBHRVgfzEZlOY6TmBIY26eGrpt
         hwHKjzCOtsySVRw8kKn1RKteg0nB9WzJ7ghZiId8qxY+iOoPnZySdITmkHWijvpHGNUI
         qtZgysfkBBKw+RmQXXC19iztwn8ic3Peco0Kdn7n1CHMaibL8XwIpL7FJC1h846010pQ
         YRjE7wQ0Dh1HtqmCMpgdxK3G4hNwasWc6wg2vugbnRjDJ+t5jXJHyYrRpHMBy+hANpLY
         GR4w==
X-Gm-Message-State: AOAM531Eyz2+U0WkFAtLk/I49LsFjgG4uax0fkl7bEhMNz/b+6JTS9bW
        b53wEEIfJj7Ajo2hZRzM2r78Sw==
X-Google-Smtp-Source: ABdhPJymevaw8JA+ZHsBCjPJ4j0suFS7f77voPGuje3SGgohExKLxChq+oCh5WRtZK41XqI6SBv0+w==
X-Received: by 2002:aa7:9110:0:b0:4fa:e388:af57 with SMTP id 16-20020aa79110000000b004fae388af57mr18793150pfh.1.1652157656115;
        Mon, 09 May 2022 21:40:56 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902900200b0015e8d4eb289sm780370plp.211.2022.05.09.21.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 21:40:55 -0700 (PDT)
Date:   Tue, 10 May 2022 10:10:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Message-ID: <20220510044053.ykn6ygnbeokhzrsa@vireshk-i7>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
 <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
 <dea39b1f-0091-2690-7f07-108d07ef9f3c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea39b1f-0091-2690-7f07-108d07ef9f3c@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-05-22, 12:38, Krzysztof Kozlowski wrote:
> On 25/04/2022 09:27, Viresh Kumar wrote:
> > This is tricky as the OPP core can't really assume the order in which the clocks
> > needs to be programmed. We had the same problem with multiple regulators and the
> > same is left for drivers to do via the custom-api.
> > 
> > Either we can take the same route here, and let platforms add their own OPP
> > drivers which can handle this, Or hide this all behind a basic device clock's
> > driver, which you get with clk_get(dev, NULL).
> 
> For my use case, the order of scaling will be the same as in previous
> implementation, because UFS drivers just got bunch of clocks with
> freq-table-hz property and were scaling in DT order.
> 
> If drivers need something better, they can always provide custom-opp
> thus replacing my method. My implementation here does not restrict them.
> 
> For the drivers where the order does not matter, why forcing each driver
> to provide its own implementation of clock scaling? Isn't shared generic
> PM OPP code a way to remove code duplication?

Code duplication is a good argument and I am in favor of avoiding it,
but nevertheless this shouldn't be something which platforms can pick
by mistake, just because they didn't go through core code. In other
words, this shouldn't be the default behavior of the core.

If we want, core can provide a helper to get rid of the duplication
though, but the user explicitly needs to use it.

> >> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > 
> >> +static int _generic_set_opp_clks_only(struct device *dev,
> >> +				      struct opp_table *opp_table,
> >> +				      struct dev_pm_opp *opp)
> >> +{
> >> +	int i, ret;
> >> +
> >> +	if (!opp_table->clks)
> >> +		return 0;
> >> +
> >> +	for (i = 0; i < opp_table->clk_count; i++) {
> >> +		if (opp->rates[i]) {
> > 
> > This should mean that we can disable that clock and it isn't required.
> 
> No, it does not mean that. The DT might provide several clocks which
> only some are important for frequency scaling. All others just need to
> be enabled.
> 
> Maybe you prefer to skip getting such clocks in PM OPP?

They shouldn't reach the OPP core then. What will the OPP core do if a
clock has a value for one OPP and not the other ?

> >> @@ -969,8 +1008,8 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
> > 
> > I think this routine breaks as soon as we add support for multiple clocks.
> > clks[0]'s frequency can be same for multiple OPPs and this won't get you the
> > right OPP then.
> 
> I don't think so and this was raised also by Stephen - only the first
> clock is considered the one used for all PM OPP frequency operations,
> like get ceil/floor.

IMHO, this is broken by design. I can easily see that someone wants to
have few variants of all other frequencies for the same frequency of
the so called "main" clock, i.e. multiple OPPs with same "main" freq
value.  I don't think we can mark the clocks "main" or otherwise as
easily for every platform.

Stephen, any inputs on this ?

> The assumption (which might need better documentation) is that first
> clock frequency is the main one:
> 1. It is still in opp->rate field, so it is used everywhere when OPPs
> are compared/checked for rates.
> 1. Usually is used also in opp-table nodes names.
> 
> The logical explanation is that devices has some main operating
> frequency, e.g. the core clock, and this determines the performance. In
> the same time such device might not be able to scale this one core clock
> independently from others, therefore this set of patches.

I understand what you are saying, but I can feel that it will break or
will force bad bug-fixes into the core at a later point of time.

I think it would be better to take it slowly and see how it goes. Lets
first add support for the OPP core to parse and store this data and
then we can add support to use it, or at least do all this in separate
patches so they are easier to review/apply.

-- 
viresh
