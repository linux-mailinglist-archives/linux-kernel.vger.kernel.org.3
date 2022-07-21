Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDA57C615
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiGUITx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGUITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:19:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081F7D7A9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:19:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so2810479wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2iiwv/b22GKcZWA9ILgCtp/mDegR2D13JchN5YTAd08=;
        b=tsTvXWj44c1iQi7dvFDCqV9Qkm89YlRvfRvlP5U7T3n7TkGlkppzFWJZMsvAqigEkh
         g/pLsjZ5VBYJEXFRcyOfNCLYHe4FRB3pz1yGc53XFmdL9AvVPrh2I67NGRoU9u60qOv2
         8HfO4zgKhDFlt2SjnrIMozPoCYbLmKPjqnsJgslPlNH+E3aXiP89c43U0N61h5YzoxIh
         hm/SoKWLL+a5eqVro6Fzk8cz7tdbC6do5i5uXpNd5kl7blK0JRIiMziPcCyA65znILz2
         eMGYVipLziY4EvqqmxzhxDi+MSys/748Tiqlbay4T5vmOwLFqpDq7VPtsGKnCxRu1u1F
         wENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2iiwv/b22GKcZWA9ILgCtp/mDegR2D13JchN5YTAd08=;
        b=WgZtSSi7GqSVoJwJYzmxl7wNd4ADA/TliC2gf4GhOgfbN5M6F3SgCCyytrLlvTwzGH
         cqI0b5BLkqaSWOyZmOm3UCyV2b6gRRfyRmsqsflFQrG4q9DRn/u4eOQDQJ4VWcUXhrr3
         /BkhjXd0zwaOQ9NyCz1t/h18+OJKK/giPd1LCoEgTU4ZklrOzl4PpA0FF074A1cQw5oU
         uBkyENAB49BpTWS97EwDK24pUm1WNG6y3B1zq4m8PkhZ3Rtevc5Vqz12JMqQhOy2AKTN
         rAnZ+5rwABg8pCzfnMTpGg6y7pTPQerZ/JVoa/tyKV1LnquzuXIq/c+iDgX4OxmtYy5s
         SzwQ==
X-Gm-Message-State: AJIora+ecvEVaBSfPf3cXdUFVbID8A1AcpCfOVRpcEFkR+dWgeil9Ysh
        kUCtGZYOYiXt1t/HmLcHIHrNnw==
X-Google-Smtp-Source: AGRyM1ubszfaMcPim8J7vKXQANeWwpkUGpGQCuswd+pG2rr43eZe0VtT64SU1NzwtChzeDLwWLUhEg==
X-Received: by 2002:a05:600c:4f83:b0:3a1:9c7c:9ea3 with SMTP id n3-20020a05600c4f8300b003a19c7c9ea3mr7354494wmq.39.1658391587569;
        Thu, 21 Jul 2022 01:19:47 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm4640720wmh.33.2022.07.21.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:19:46 -0700 (PDT)
Date:   Thu, 21 Jul 2022 11:19:45 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 1/2] clk: Add generic sync_state callback for disabling
 unused clocks
Message-ID: <YtkMIYHmShBVfxh6@linaro.org>
References: <20220706150411.708213-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706150411.708213-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-06 18:04:10, Abel Vesa wrote:
> There are unused clocks that need to stay enabled on clk_disable_unused,
> but rather should be disabled later on on sync_state. Provide a generic
> sync_state callback for the clock providers that register such clocks.
> Then, use the same mechanism as clk_disable_unused from that generic
> callback, but pass the device to make sure only the clocks belonging to
> the current clock provider get disabled, if unused. Also, during the
> default clk_disable_unused, if the driver that registered the clock has
> the generic clk_sync_state_disable_unused callback set for sync_state,
> leave its clocks enabled.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Gentle ping.

> ---
>  drivers/clk/clk.c            | 67 +++++++++++++++++++++++++++---------
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 52 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 7fc191c15507..ea55806505c0 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1218,19 +1218,31 @@ static void clk_core_disable_unprepare(struct clk_core *core)
>  	clk_core_unprepare_lock(core);
>  }
>
> -static void __init clk_unprepare_unused_subtree(struct clk_core *core)
> +static void clk_unprepare_unused_subtree(struct clk_core *core,
> +						struct device *dev)
>  {
>  	struct clk_core *child;
>
>  	lockdep_assert_held(&prepare_lock);
>
>  	hlist_for_each_entry(child, &core->children, child_node)
> -		clk_unprepare_unused_subtree(child);
> +		clk_unprepare_unused_subtree(child, dev);
> +
> +	if (dev && core->dev != dev)
> +		return;
> +
> +	/*
> +	 * clock will be unprepared on sync_state,
> +	 * so leave as is on clk_disable_unused
> +	 */
> +	if (!dev && dev_has_sync_state(core->dev) &&
> +		core->dev->driver->sync_state == clk_sync_state_disable_unused)
> +		return;
>
>  	if (core->prepare_count)
>  		return;
>
> -	if (core->flags & CLK_IGNORE_UNUSED)
> +	if (!dev && core->flags & CLK_IGNORE_UNUSED)
>  		return;
>
>  	if (clk_pm_runtime_get(core))
> @@ -1248,7 +1260,8 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
>  	clk_pm_runtime_put(core);
>  }
>
> -static void __init clk_disable_unused_subtree(struct clk_core *core)
> +static void clk_disable_unused_subtree(struct clk_core *core,
> +					struct device *dev)
>  {
>  	struct clk_core *child;
>  	unsigned long flags;
> @@ -1256,7 +1269,18 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  	lockdep_assert_held(&prepare_lock);
>
>  	hlist_for_each_entry(child, &core->children, child_node)
> -		clk_disable_unused_subtree(child);
> +		clk_disable_unused_subtree(child, dev);
> +
> +	if (dev && core->dev != dev)
> +		return;
> +
> +	/*
> +	 * clock will be disabled on sync_state,
> +	 * so leave as is on clk_disable_unused
> +	 */
> +	if (!dev && dev_has_sync_state(core->dev) &&
> +		core->dev->driver->sync_state == clk_sync_state_disable_unused)
> +		return;
>
>  	if (core->flags & CLK_OPS_PARENT_ENABLE)
>  		clk_core_prepare_enable(core->parent);
> @@ -1269,7 +1293,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  	if (core->enable_count)
>  		goto unlock_out;
>
> -	if (core->flags & CLK_IGNORE_UNUSED)
> +	if (!dev && core->flags & CLK_IGNORE_UNUSED)
>  		goto unlock_out;
>
>  	/*
> @@ -1302,35 +1326,46 @@ static int __init clk_ignore_unused_setup(char *__unused)
>  }
>  __setup("clk_ignore_unused", clk_ignore_unused_setup);
>
> -static int __init clk_disable_unused(void)
> +static void __clk_disable_unused(struct device *dev)
>  {
>  	struct clk_core *core;
>
> -	if (clk_ignore_unused) {
> -		pr_warn("clk: Not disabling unused clocks\n");
> -		return 0;
> -	}
> -
>  	clk_prepare_lock();
>
>  	hlist_for_each_entry(core, &clk_root_list, child_node)
> -		clk_disable_unused_subtree(core);
> +		clk_disable_unused_subtree(core, dev);
>
>  	hlist_for_each_entry(core, &clk_orphan_list, child_node)
> -		clk_disable_unused_subtree(core);
> +		clk_disable_unused_subtree(core, dev);
>
>  	hlist_for_each_entry(core, &clk_root_list, child_node)
> -		clk_unprepare_unused_subtree(core);
> +		clk_unprepare_unused_subtree(core, dev);
>
>  	hlist_for_each_entry(core, &clk_orphan_list, child_node)
> -		clk_unprepare_unused_subtree(core);
> +		clk_unprepare_unused_subtree(core, dev);
>
>  	clk_prepare_unlock();
> +}
> +
> +static int __init clk_disable_unused(void)
> +{
> +	if (clk_ignore_unused) {
> +		pr_warn("clk: Not disabling unused clocks\n");
> +		return 0;
> +	}
> +
> +	__clk_disable_unused(NULL);
>
>  	return 0;
>  }
>  late_initcall_sync(clk_disable_unused);
>
> +void clk_sync_state_disable_unused(struct device *dev)
> +{
> +	__clk_disable_unused(dev);
> +}
> +EXPORT_SYMBOL_GPL(clk_sync_state_disable_unused);
> +
>  static int clk_core_determine_round_nolock(struct clk_core *core,
>  					   struct clk_rate_request *req)
>  {
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 72d937c03a3e..5d3ed2b14f2c 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -679,6 +679,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
>  		void __iomem *reg, u8 shift, u8 width,
>  		u8 clk_divider_flags, const struct clk_div_table *table,
>  		spinlock_t *lock);
> +void clk_sync_state_disable_unused(struct device *dev);
>  /**
>   * clk_register_divider - register a divider clock with the clock framework
>   * @dev: device registering this clock
> --
> 2.34.3
>
