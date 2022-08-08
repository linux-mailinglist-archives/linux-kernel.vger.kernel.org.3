Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23658CC53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiHHQq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHHQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:46:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7B11821;
        Mon,  8 Aug 2022 09:46:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q19so8571120pfg.8;
        Mon, 08 Aug 2022 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FBFzu78PXQ4VkKxZwnG7kf/6swmTQSKdX2ioFA0j04A=;
        b=qtCKz9+U6OvrOCj/Z/uIgVSWfZbJ/cubcPUV8ynY41755o7M7TnpfE7bMz73zr/DoU
         H65KikCgCXlRGwD+NW+W/SFiuxw9o4xYNYlBQixPwYhgsZHgvzYlBRhR+uYqzcKImER3
         UQu238n2NAUoJRrkmb4mmnHAmC/MIeOA4HP4J7RlxiCdoMPuKWfo6h5kF6hJ3R+atCYu
         1aOj0o0KItt1vEaqLI5f/Hj+LC9FF2EdDLGvhtUJjCKQ9rj2/8qnmqDGr2s5fWnDaST/
         LZ4t+rsnFVJOm9X0RY+WGKJZNxo7z67gNjjKIRu/8NlXlv+sErbRiCcp01hCZP0CorPO
         0daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FBFzu78PXQ4VkKxZwnG7kf/6swmTQSKdX2ioFA0j04A=;
        b=La71gNIP3NRRLAEQ51WO/SkZAeJtZM09G0lQfsZJCKEjn1UsZjduYqBdQOu5l8zJNr
         dzSyZrOwhk7/Y7FR6bApkUHQsCZEtj53jYSFwMLZoe16lNUF8zprnor8FS6G00GDaoVX
         qPCL+qnBTS+8TvOmt7WbND7lEFKhDzMMcAOdQhHyvN54LRTZ0+ZMBzsy+Rhc8maGdVU6
         M3jejM3fRDfvfbA36XSQXF5KkcuFqx4psplw2PrVLLtHz9qCpiaDtZUV70/GNLLX02cH
         SvneH8d7xXIHFfP0pGdGwiwSz1uVJzPIfxChzyUmpPwYH/WYpjykT4k8Lu1xKBDyg6GV
         osWw==
X-Gm-Message-State: ACgBeo1XVp0CjXTAAn47MG+4pkifZu83ATSK3MQuHhrFrezd/fr1PZ3X
        DIv9PcHkpASF3ENdR2ozp6M=
X-Google-Smtp-Source: AA6agR5KQPdp6ySa5gZVS9LerIqlvA9ymZMjzhnxDguXQjKNToBUW0QoZOkXX6gzNmnUk4ZoEGMpVw==
X-Received: by 2002:a63:8949:0:b0:41d:1f89:a37c with SMTP id v70-20020a638949000000b0041d1f89a37cmr10903686pgd.243.1659977213810;
        Mon, 08 Aug 2022 09:46:53 -0700 (PDT)
Received: from Mahakal ([2401:4900:36ab:9d3a:cf26:15dd:368e:8685])
        by smtp.gmail.com with ESMTPSA id j18-20020a170903029200b0016db43e5212sm8963610plr.175.2022.08.08.09.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2022 09:46:53 -0700 (PDT)
Date:   Mon, 8 Aug 2022 22:16:46 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        vimal.kumar32@gmail.com, Mintu Patel <mintupatel89@gmail.com>
Subject: Re: [PATCH v3] Common clock: To list active consumers of clocks
Message-ID: <20220808164644.GA5239@Mahakal>
References: <20220624010550.582BBC341C7@smtp.kernel.org>
 <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_NO_BRKTS_FROM_MSSP,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
Have you got a chance to review the above patch? 
We have made the changes as per the reviews, please have a look on the
patch.

Regards,
Vishal
