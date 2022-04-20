Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAD507F61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359203AbiDTDIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359202AbiDTDH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:07:56 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2623B3CA7D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:04:25 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso258262otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bOmRDQWsh4LJc0ss61NPg8qXWsb+khLjGhqRuXFnjwU=;
        b=bAEDSRKGCAmjsYmi9/pGay3D0pg8XPKtai9P6r0xgeBxSvo/ORnSkYRuFaosMAmpIm
         nX0hcjiP+JLYhFwZV9lLNoDJJLxWmpnJ1bwoIl/X+JqOwSWxtgxYbmbtrjnbhCWawuiI
         CDW+0mkGLvbIgFonVOAi23HNXaoruJtORwESlKapCUBFiCpNMjC4melyj20KJERAOozu
         /hfgJ+4d6KBH8nfbeUEEq0OHBbGj9MAxmzSgmCV95g7a9tRJBI72nUSCX+pvbplvu7jo
         uNJL1NrL0/ianvgdM2Pr3oVaoWnw/ozCqhzjYGz5QT6L6WZPBtJm+N75mg0Ui4cEX9/a
         d03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bOmRDQWsh4LJc0ss61NPg8qXWsb+khLjGhqRuXFnjwU=;
        b=VXEWy1Tuf8vJuvD7RX5Y9GCbYqtN2NPDeR0QWSbV/mNL7Zu6p3OBNQYBYe0GhVWi48
         zM0mE44PXbtcKv5bMWUENC0uypIGP8psblYNokhf+wWhhc6mPDcAlLCd1niEW4Rcmvww
         DCvpDENUyRt46cWruEytdJE4eOtKvv8BEwuXZre6IPV7ZK0YHqguCeBI/xAAkgw3O6OL
         P7+/WofCub4KZpVcNvRtlJ4SwcMjkVTid8fsSYWoY6VyGlJss4HTn/1gFDSRfT8le8k6
         9bI24sQsR1ZS6l6eLtxN7VFKjCZ/vzyI4vJdHYq+GWvC/ciieK+SEZlA8THKB1ZwjjqD
         B9OA==
X-Gm-Message-State: AOAM532aGpUGLXRTx0mrqC9wee1nJHdXzdjeT5lLqZR9WpLudoCX06yp
        JGw0MQLrjXvDp5xf34pMHJcVoA==
X-Google-Smtp-Source: ABdhPJz78HNHOCUdlI0fxzBVktGevGVhmjxibFmoHtIZNr8U2JMJL+kspGLrc1H8lG7ze5d0XHe6Gg==
X-Received: by 2002:a9d:7685:0:b0:5e6:b452:4e9 with SMTP id j5-20020a9d7685000000b005e6b45204e9mr7073498otl.254.1650423864144;
        Tue, 19 Apr 2022 20:04:24 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id x24-20020a056870a79800b000e2e53716fbsm6121695oao.31.2022.04.19.20.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:04:23 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:06:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
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
Message-ID: <Yl94tB+FrZu/am0/@ripper>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
 <YlWztZknl4OBmekp@ripper>
 <02fc797a-190f-3558-5ee1-c9c3320f3d57@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02fc797a-190f-3558-5ee1-c9c3320f3d57@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Apr 02:07 PDT 2022, Krzysztof Kozlowski wrote:

> On 12/04/2022 19:15, Bjorn Andersson wrote:
> >>  
> >> +	opp_table->clks = kmalloc_array(1, sizeof(*opp_table->clks),
> >> +					GFP_KERNEL);
> > 
> > This seems to be 81 chars long, perhaps worth not line breaking?
> 
> I doubt that it will increase the readability:
> 
> 	opp_table->clks = kmalloc_array(1,
> 					sizeof(*opp_table->clks),
> 					GFP_KERNEL);
> 
> 80-character is not anymore that strict hard limit and in such case
> using 1-2 characters longer improves the code.
> 

I was suggesting that you remove the line break

	opp_table->clks = kmalloc_array(1, sizeof(*opp_table->clks), GFP_KERNEL);

Seems to be 81 chars long, which is fine in my book with or without the
80-char guideline.

> > 
> >> +	if (!opp_table->clks)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >>  	/* Find clk for the device */
> >> -	opp_table->clk = clk_get(dev, NULL);
> >> +	opp_table->clks[0] = clk_get(dev, NULL);
> >>  
> >> -	ret = PTR_ERR_OR_ZERO(opp_table->clk);
> >> -	if (!ret)
> >> +	ret = PTR_ERR_OR_ZERO(opp_table->clks[0]);
> >> +	if (!ret) {
> >> +		opp_table->clk_count = 1;
> >>  		return opp_table;
> >> +	}
> > [..]
> >> +struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
> >> +					  const char * const names[],
> >> +					  unsigned int count)
> >>  {
> >>  	struct opp_table *opp_table;
> >> -	int ret;
> >> +	struct clk *clk;
> >> +	int ret, i;
> >>  
> >>  	opp_table = _add_opp_table(dev, false);
> >>  	if (IS_ERR(opp_table))
> >> @@ -2159,70 +2259,92 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
> >>  	}
> >>  
> >>  	/* clk shouldn't be initialized at this point */
> >> -	if (WARN_ON(opp_table->clk)) {
> >> +	if (WARN_ON(opp_table->clks)) {
> >>  		ret = -EBUSY;
> >>  		goto err;
> >>  	}
> >>  
> >> -	/* Find clk for the device */
> >> -	opp_table->clk = clk_get(dev, name);
> >> -	if (IS_ERR(opp_table->clk)) {
> >> -		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
> >> -				    "%s: Couldn't find clock\n", __func__);
> >> +	opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
> >> +					GFP_KERNEL);
> >> +	if (!opp_table->clks) {
> >> +		ret = -ENOMEM;
> >>  		goto err;
> >>  	}
> >>  
> >> +	for (i = 0; i < count; i++) {
> >> +		clk = clk_get(dev, names[i]);
> >> +		if (IS_ERR(clk)) {
> >> +			ret =  dev_err_probe(dev, PTR_ERR(clk),
> >> +					     "%s: Couldn't find clock %s\n",
> >> +					     __func__, names[i]);
> >> +			goto free_clks;
> >> +		}
> >> +
> >> +		opp_table->clks[i] = clk;
> >> +	}
> > 
> > Wouldn't it be convenient to make clks a struct clk_bulk_data array
> > and use clk_bulk_get()/clk_bulk_put() instead?
> 
> I was thinking about this but clk_bulk_get() requires struct
> clk_bulk_data, so the code in "get" is not actually smaller if function
> receives array of clock names.
> 
> OTOH, usage of clk_bulk_get() would reduce code in: _put_clocks(). Rest
> of the code would be more-or-less the same, including all corner cases
> when clocks are missing.
> 

Fair enough, I think you're right that it's not going to be much
difference.

Regards,
Bjorn


> > 
> >> +
> >> +	opp_table->clk_count = count;
> >> +
> >>  	return opp_table;
> >>  
> >> +free_clks:
> >> +	while (i != 0)
> >> +		clk_put(opp_table->clks[--i]);
> >> +
> >> +	kfree(opp_table->clks);
> >> +	opp_table->clks = NULL;
> >> +	opp_table->clk_count = -1;
> >>  err:
> >>  	dev_pm_opp_put_opp_table(opp_table);
> >>  
> >>  	return ERR_PTR(ret);
> >>  }
> >> -EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
> >> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_clknames);
> > [..]
> >> +static int _read_clocks(struct dev_pm_opp *opp, struct opp_table *opp_table,
> >> +			struct device_node *np)
> >> +{
> >> +	int count, ret;
> >> +	u64 *freq;
> >> +
> >> +	count = of_property_count_u64_elems(np, "opp-hz");
> >> +	if (count < 0) {
> >> +		pr_err("%s: Invalid %s property (%d)\n",
> >> +			__func__, of_node_full_name(np), count);
> > 
> > Wouldn't %pOF be convenient to use here, seems like it becomes short
> > enough that you don't have to wrap this line then.
> 
> Yes, I forgot about %pOF.
> 
> > 
> >> +		return count;
> >> +	}
> >> +
> >> +	if (count != opp_table->clk_count) {
> >> +		pr_err("%s: number of rates %d does not match number of clocks %d in %s\n",
> >> +		       __func__, count, opp_table->clk_count,
> >> +		       of_node_full_name(np));
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	freq = kmalloc_array(count, sizeof(*freq), GFP_KERNEL);
> >> +	if (!freq)
> >> +		return -ENOMEM;
> >> +
> >> +	ret = of_property_read_u64_array(np, "opp-hz", freq, count);
> >> +	if (ret) {
> >> +		pr_err("%s: error parsing %s: %d\n", __func__,
> >> +		       of_node_full_name(np), ret);
> >> +		ret = -EINVAL;
> >> +		goto free_freq;
> >> +	}
> > 
> > Regards,
> > Bjorn
> 
> 
> Best regards,
> Krzysztof
