Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9673151A9DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357688AbiEDRTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356235AbiEDRE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:04:59 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A334FC6D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:53:58 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ed8a3962f8so1765870fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2klMetXGa1eUlKZSFzvlKnCFZIMh5g+h156STL277cU=;
        b=xwSoPZhK4O9KfF0E9rB8njkdJRtTwkZ4NR9LCTG0wMvOKwKndxeRPvixpmBIcXqHdY
         qnYVcoFOds+xnLyeSRi6JCoJvovK5Ont8ITuL89eG48BDLXzDfbI7+wpAhSS4VqLEciS
         /ExulmzKoBHM1in91h9JtnFioxJJ+rQ4dOTGBUTyPiyzOCm25ErpRvSq4X/7e5xg6frM
         hsHarDuHST1RgfinipAKy/JnsW5bKxiotUgLWcM9FS5fR3VZ2LAqpOXfbkI13sUKo+bm
         O6AUeLw1hRpkjAOw9PYtndBN0mDjRpFPXAzA4IvNiK6aP9CHCbcgb7OCexn1diIWIYGI
         x2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2klMetXGa1eUlKZSFzvlKnCFZIMh5g+h156STL277cU=;
        b=IvfzQ6zb2BambxzHwq4JB9ZT2v9Os3/93sPX+bYqOoGtDDmo12X/GMbPMX6eQU/E1a
         f2MoR37oaW5qFce7thNcunbxoZY6SABzIXK9DK7B79fxRpLh/rCdAlIJMsuw6K8nxail
         CGQJGD1Guqu6U8KlZ5SZqZ12IAr9Iavospfy8a2bt1rA3x1Fffg2YGr8gjU4vE5iSXIZ
         KHxam5R4UdsN3/SyJMOy7qDo+S/VvT4txi4X/1eamvE8w3nWw96FsGeEUSevJydwGwLx
         OSEh2MhgdU6bOg2mUD4ljtwVPgS3+VyCNIqXx7Bt4FM5StEvPGzg/+H++/R4J1328iTO
         lWlQ==
X-Gm-Message-State: AOAM53376bEd97q+8I4RcdTac5aB6ZraeGMp8LaVLCSXXkBEcl2tXaIi
        lAjF00A0q6YLHuALTu2ggYoZnw==
X-Google-Smtp-Source: ABdhPJyocyOzuasLctGeqNeBJMplgmBUpdNyW29oi9jqBr4TwlqaFgI/BnBfrAb7QdBgNToE3dbmIQ==
X-Received: by 2002:a05:6870:b6aa:b0:ed:a7de:cc26 with SMTP id cy42-20020a056870b6aa00b000eda7decc26mr169045oab.259.1651683237792;
        Wed, 04 May 2022 09:53:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r42-20020a056808212a00b00325cda1ff85sm4484697oiw.4.2022.05.04.09.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:53:57 -0700 (PDT)
Date:   Wed, 4 May 2022 11:53:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        patches@lists.linux.dev, Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH] clk: qcom: rpmh: Set wake/sleep state for BCM clks
Message-ID: <YnKvoh+h07at8b65@builder.lan>
References: <20220412194505.614002-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412194505.614002-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Apr 14:45 CDT 2022, Stephen Boyd wrote:

> Set the wake and sleep state for BCM clks here, not just the active
> state, as the active only state is dropped when CPUs go to deep idle.
> This ensures the clk is always on when the driver thinks it is on.
> 
> This was found by inspection, and could very well be incorrect if the
> RPMh hardware copies over the active only state to the sleep and wake
> states.
> 

Taking another look at this patch and now it makes perfect sense to me.
Sorry for not grasping the problem earlier.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Will you take this in fixes, or do you want me to pick it for 5.19?

> Cc: Alex Elder <elder@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Fixes: 04053f4d23a4 ("clk: qcom: clk-rpmh: Add IPA clock support")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index aed907982344..29da1ffd10cf 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -260,6 +260,7 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
>  	struct tcs_cmd cmd = { 0 };
>  	u32 cmd_state;
>  	int ret = 0;
> +	enum rpmh_state state;
>  
>  	mutex_lock(&rpmh_clk_lock);
>  	if (enable) {
> @@ -274,15 +275,19 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
>  		cmd.addr = c->res_addr;
>  		cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
>  
> -		ret = clk_rpmh_send(c, RPMH_ACTIVE_ONLY_STATE, &cmd, enable);
> -		if (ret) {
> -			dev_err(c->dev, "set active state of %s failed: (%d)\n",
> -				c->res_name, ret);
> -		} else {
> -			c->last_sent_aggr_state = cmd_state;
> +		for (state = RPMH_SLEEP_STATE; state <= RPMH_ACTIVE_ONLY_STATE; state++) {
> +			ret = clk_rpmh_send(c, state, &cmd, enable);

Nit. We only need to pass the positive enable on the last iteration here...

Regards,
Bjorn

> +			if (ret) {
> +				dev_err(c->dev, "set %s state of %s failed: (%d)\n",
> +					!state ? "sleep" :
> +					state == RPMH_WAKE_ONLY_STATE	?
> +					"wake" : "active", c->res_name, ret);
> +				goto out;
> +			}
>  		}
> +		c->last_sent_aggr_state = cmd_state;
>  	}
> -
> +out:
>  	mutex_unlock(&rpmh_clk_lock);
>  
>  	return ret;
> 
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> -- 
> https://chromeos.dev
> 
