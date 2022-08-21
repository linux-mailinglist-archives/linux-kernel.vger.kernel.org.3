Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4666F59B5CC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiHUSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHUSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:06:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715AC1D329;
        Sun, 21 Aug 2022 11:06:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w29so2845662pfj.3;
        Sun, 21 Aug 2022 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=WZPcPJT9zvWPvsEM4NAAw/0jxPWsF3FxCjtklAsTneU=;
        b=d+ULP6ImPM4qyQrpoTcaxqS4t1rNIDKoG7OxOCf0dGUgm5Xme3cn1hIdNHSCG0xZlF
         5nmCYf2ya7e7bYzma6ZvFeJEUl2HEJeZ9FNJVyQBGRbZvsz4Pzj8cTWFGe/xoP02yQdd
         X7YIlSX/3ZocjQouKIyOXu3TkXsIeM5SYrgTvqw0bDuymnkWeYuFwFnuCkHdTcXdD1Lp
         E3T+p1pGQms5b89qhUX8OwwBpHd49rhVGdKQAJSGhnc/Y9b01iqRrPK1baV7QKLERUg6
         TIxwdBGZIILGF+fEumPKLix/FH3ra5b93ySOBTX67dtpkZLH45WQ7urFmA+RIYPSaQ/w
         jkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WZPcPJT9zvWPvsEM4NAAw/0jxPWsF3FxCjtklAsTneU=;
        b=DKxEPcRgtAISCc0jgq4HCksTQyXHHEuUQ456pH73CURTvIcko+tX5jKMJH/2mrLJhi
         0OEci3CNQD7ezy9R/L4LsPN/0FUEGvx6Fj8+M824079NjCbNblhNcfl345zaImL0g4/x
         XHtWAFLOqujJG4+ZMH2J8tKqAoDfkJKKgcUhGIESEHe21hOYBt/GJa8d1c6ffbXVDZCE
         hwqHatvN6dfB+1NZRGzD2gAtd/2gOqtOBvVNtQU1QNuyAC4uL+mxibqdBOXMv4VVlNeW
         y0NZoo39AhLH8Jz0Q1wdkv8Sug79TRTLfQWsWHu+1UkoInebDGFFnt2Jk1ufI/75rt/6
         75bQ==
X-Gm-Message-State: ACgBeo1gf0gd/u29gFplEBvW/lXJEEDKaYwhr/A0B8XVSkTvh4EZGcoY
        K2T3Ul8oax7v4btVxfyNg0iThoa7SvlnqA==
X-Google-Smtp-Source: AA6agR7/vOXpsOzVSFiar3eeaTq2ScO0QeQ6uUTKJ/rNxtuujGomojIJYEGv4V4ZtwhlE8m7Y5CKuw==
X-Received: by 2002:a63:4d4a:0:b0:423:1b0:e5c1 with SMTP id n10-20020a634d4a000000b0042301b0e5c1mr13719679pgl.585.1661105205846;
        Sun, 21 Aug 2022 11:06:45 -0700 (PDT)
Received: from Mahakal ([2401:4900:36a0:636e:62bf:3813:d194:e46f])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7989a000000b005367c6db0a4sm1424311pfl.183.2022.08.21.11.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Aug 2022 11:06:45 -0700 (PDT)
Date:   Sun, 21 Aug 2022 23:36:39 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        vimal.kumar32@gmail.com, Mintu Patel <mintupatel89@gmail.com>
Subject: Re: [PATCH v3] Common clock: To list active consumers of clocks
Message-ID: <20220821180637.GB6946@Mahakal>
References: <20220624010550.582BBC341C7@smtp.kernel.org>
 <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_NO_BRKTS_FROM_MSSP,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:39:47PM +0530, Vishal Badole wrote:
> This feature lists the clock consumer's name and per-user enable count
> in clock summary. Using this feature user can easily check which device
> has acquired a perticular clock and it is enabled by respective device
> or not.
> for example:
> $ cat /sys/kernel/debug/clk/clk_summary
>                       enable  prepare  protect                           duty  hardware                            per-user
>    clock               count    count    count    rate   accuracy phase cycle    enable   consumer                    count
> ----------------------------------------------------------------------------------------------------------------------------
>  clk_mcasp0_fixed         0        0        0    24576000      0     0  50000     Y      deviceless                      0
>                                                                                          deviceless                      0
>     clk_mcasp0            0        0        0    24576000      0     0  50000     N          simple-audio-card,cpu           0
>                                                                                              deviceless                      0
> 
> Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Co-developed-by: Vimal Kumar <vimal.kumar32@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> ---
>  drivers/clk/clk.c | 46 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f00d4c1..c96079f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -102,6 +102,7 @@ struct clk {
>  	unsigned long min_rate;
>  	unsigned long max_rate;
>  	unsigned int exclusive_count;
> +	unsigned int enable_count;
>  	struct hlist_node clks_node;
>  };
>  
> @@ -1008,6 +1009,10 @@ void clk_disable(struct clk *clk)
>  		return;
>  
>  	clk_core_disable_lock(clk->core);
> +
> +	if (clk->enable_count > 0)
> +		clk->enable_count--;
> +
>  }
>  EXPORT_SYMBOL_GPL(clk_disable);
>  
> @@ -1169,10 +1174,16 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
>   */
>  int clk_enable(struct clk *clk)
>  {
> +	int ret;
> +
>  	if (!clk)
>  		return 0;
>  
> -	return clk_core_enable_lock(clk->core);
> +	ret = clk_core_enable_lock(clk->core);
> +	if (!ret)
> +		clk->enable_count++;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);
>  
> @@ -2953,28 +2964,41 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
>  				 int level)
>  {
>  	int phase;
> +	struct clk *clk_user;
> +	int multi_node = 0;
>  
> -	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
> +	seq_printf(s, "%*s%-*s %-7d %-8d %-8d %-11lu %-10lu ",
>  		   level * 3 + 1, "",
> -		   30 - level * 3, c->name,
> +		   35 - level * 3, c->name,
>  		   c->enable_count, c->prepare_count, c->protect_count,
>  		   clk_core_get_rate_recalc(c),
>  		   clk_core_get_accuracy_recalc(c));
>  
>  	phase = clk_core_get_phase(c);
>  	if (phase >= 0)
> -		seq_printf(s, "%5d", phase);
> +		seq_printf(s, "%-5d", phase);
>  	else
>  		seq_puts(s, "-----");
>  
> -	seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
> +	seq_printf(s, " %-6d", clk_core_get_scaled_duty_cycle(c, 100000));
>  
>  	if (c->ops->is_enabled)
> -		seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N');
> +		seq_printf(s, " %5c ", clk_core_is_enabled(c) ? 'Y' : 'N');
>  	else if (!c->ops->enable)
> -		seq_printf(s, " %9c\n", 'Y');
> +		seq_printf(s, " %5c ", 'Y');
>  	else
> -		seq_printf(s, " %9c\n", '?');
> +		seq_printf(s, " %5c ", '?');
> +
> +	hlist_for_each_entry(clk_user, &c->clks, clks_node) {
> +		seq_printf(s, "%*s%-*s  %-4d\n",
> +			   level * 3 + 2 + 105 * multi_node, "",
> +			   30,
> +			   clk_user->dev_id ? clk_user->dev_id : "deviceless",
> +			   clk_user->enable_count);
> +
> +		multi_node = 1;
> +	}
> +
>  }
>  
>  static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
> @@ -2995,9 +3019,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
>  	struct clk_core *c;
>  	struct hlist_head **lists = (struct hlist_head **)s->private;
>  
> -	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
> -	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
> -	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
> +	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            per-user\n");
> +	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                    count\n");
> +	seq_puts(s, "-------------------------------------------------------------------------------------------------------------------------------------------\n");
>  
>  	clk_prepare_lock();
>  
> -- 
> 2.7.4
>

Hi Stephen,
Please review the above patch. Here we have made the changes as per your
review points. 
Note: The example format in commit meassage is getting changed during
copy paste but we are getting proper formatted and parsable output on
actual target.


Regards,
Vishal
