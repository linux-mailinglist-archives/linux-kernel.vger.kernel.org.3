Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2197598ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbiHRSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiHRSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:04:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE2A7AA3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:04:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so1365393wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GlpTqivy0tIzGkwP7ejOAS9UIgP5mpapG/8trM9+O8s=;
        b=flz/+Chioex0V5uN0j7jxB1BCIqc7jyvF8jHUeSIQ2x884HLiWijSc2da85H8hVGdo
         Q4lp6mTxxV8ZogvfT1Aezb8jJhmEbAwkH0STSBS1D+TxnocOZtqLe8ySx0mMrYQSpa47
         /GyYmOMw/8eINm3Df319PEHMsn1l0VmeS1NOgoHUmcyyhx2Hj9zRjKMBxtq2ejs0pKkU
         OGmKZh3pAzgWteDqXJtm1adhlXJJH03Rh04pbciP2nu5ldDwFSq8+L9iGgGPrdPaUkDp
         IO2BJPTn4SHIHC8+676XiZQg/WABYpgb7U1Ug66lTHHE21ZcYSYAnKv13kSFeTcYGlKM
         ABxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GlpTqivy0tIzGkwP7ejOAS9UIgP5mpapG/8trM9+O8s=;
        b=V6NLitLZsKlwnkTuVmCnXgVgQoZT6UPqTQPYalwrX1aTSnHcmpFBHPC/WhfLvgpKu8
         tEFSWHn3bBbQzJKHOGvlS9F7GCvxaAGA56ffZiQYiSsBQ8NPHFkv9hgSgVJcJV8KP2vV
         GlHNU8vorJFWJw9cXieJBNCrlrM2ywQ44QOMaOUrDu1rK20r1KHP0oWu0NzSCfAcQyBe
         hK6d1GENZ41u7f1cnETma8U7byp1ZE+aXKzewFX3cJTo+KxmBSb3bGolu/jl/IHw/O5O
         OzTvlbJvQkywUbHqiyQmZB8GiowYPrT9fryaL/zJZbBd0freYsVfi3xPzldKcmYmFS5J
         iouw==
X-Gm-Message-State: ACgBeo0oNkj5uJaWzjshBDF1dS2/htFv2TEIZIK881uOo+zuhodukvd/
        RAyrZtWgGnrXgdNC95PWcBdGBw==
X-Google-Smtp-Source: AA6agR5nwxqBrsO5buNoFzw4KTHCE5WRDDDX00NomWvkOTF3NeHI3vRmJEi25qV1Uyv9RjgIL4mKEA==
X-Received: by 2002:a05:600c:35d4:b0:3a6:18ba:1585 with SMTP id r20-20020a05600c35d400b003a618ba1585mr5017823wmq.48.1660845875137;
        Thu, 18 Aug 2022 11:04:35 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a5537bb2besm2876217wmj.25.2022.08.18.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 11:04:34 -0700 (PDT)
Date:   Thu, 18 Aug 2022 21:04:32 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/2] soc: qcom_stats: Add dynamic debugfs entries for
 subsystems
Message-ID: <Yv5/MCC6c3lgud+v@linaro.org>
References: <20220818142215.2282365-1-abel.vesa@linaro.org>
 <20220818142215.2282365-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818142215.2282365-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-18 17:22:15, Abel Vesa wrote:
> Register per-subsystem notifier using qcom_register_ssr_notifier().
> This will allow the order of between the remoteprocs actually starting and
> qcom_stats driver probing to become more relaxed.
> 
> When the notifier callback gets called, depending on whether the remoteproc is
> starting up or shutting down, either create or remove the related debugfs
> entry. Also, in order to make sure we're not missing an already started
> remoteproc, after the notifier has been set up, we go though the subsystems
> list and try to create the entry for it, as it was doing before, but this time
> we store the dentry to use it later on for removal, if necessary.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/soc/qcom/qcom_stats.c | 77 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> index fa30540b6583..baaa820c9a77 100644
> --- a/drivers/soc/qcom/qcom_stats.c
> +++ b/drivers/soc/qcom/qcom_stats.c
> @@ -7,8 +7,10 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/remoteproc/qcom_rproc.h>
>  #include <linux/seq_file.h>
>  
>  #include <linux/soc/qcom/smem.h>
> @@ -68,11 +70,20 @@ struct appended_stats {
>  	u32 reserved[3];
>  };
>  
> +struct subsystem_priv {
> +	const struct subsystem_data *subsystem;
> +	struct dentry *root;
> +	struct dentry *dentry;
> +	struct notifier_block nb;
> +	void *notifier;
> +};
> +
>  struct qcom_stats_priv {
>  	struct device dev;
>  	struct stats_data *data;
>  	struct dentry *root;
>  	const struct stats_config *config;
> +	struct subsystem_priv ss_priv[ARRAY_SIZE(subsystems)];
>  };
>  
>  static void qcom_print_stats(struct seq_file *s, const struct sleep_stats *stat)
> @@ -177,6 +188,57 @@ static void qcom_create_soc_sleep_stat_files(struct qcom_stats_priv *stats,
>  	}
>  }
>  
> +static int qcom_stats_subsys_ssr_notify(struct notifier_block *nb,
> +				    unsigned long action,
> +				    void *data)
> +{
> +	struct subsystem_priv *ss_priv = container_of(nb, struct subsystem_priv, nb);
> +
> +	switch (action) {
> +	case QCOM_SSR_AFTER_POWERUP:
> +		ss_priv->dentry = debugfs_create_file(ss_priv->subsystem->name, 0400, ss_priv->root,
> +							(void *)ss_priv->subsystem,
> +							&qcom_subsystem_sleep_stats_fops);
> +		break;
> +	case QCOM_SSR_BEFORE_SHUTDOWN:
> +		debugfs_remove(ss_priv->dentry);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void qcom_register_subsystem_notifiers(struct qcom_stats_priv *stats)
> +{
> +	struct device *dev = &stats->dev;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
> +		const struct subsystem_data *subsystem = &subsystems[i];
> +		struct subsystem_priv *ss_priv = &stats->ss_priv[i];
> +
> +		ss_priv->subsystem = subsystem;
> +		ss_priv->root = stats->root;
> +		ss_priv->nb.notifier_call = qcom_stats_subsys_ssr_notify;
> +		ss_priv->notifier = qcom_register_ssr_notifier(subsystem->name, &ss_priv->nb);
> +		if (IS_ERR(ss_priv->notifier))
> +			dev_err(dev, "failed to register ssr notifier for %s (%ld)",
> +				subsystem->name, PTR_ERR(ss_priv->notifier));
> +	}
> +}
> +
> +static void qcom_unregister_subsystem_notifiers(struct qcom_stats_priv *stats)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(subsystems); i++)
> +		if (stats->ss_priv[i].notifier)
> +			qcom_unregister_ssr_notifier(stats->ss_priv[i].notifier,
> +							&stats->ss_priv[i].nb);
> +}
> +
>  static void qcom_create_subsystem_stat_files(struct qcom_stats_priv *stats)
>  {
>  	const struct sleep_stats *stat;
> @@ -188,12 +250,20 @@ static void qcom_create_subsystem_stat_files(struct qcom_stats_priv *stats)
>  		return;
>  
>  	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
> +		struct subsystem_priv *ss_priv = &stats->ss_priv[i];
> +
>  		stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
>  		if (IS_ERR(stat))
>  			continue;
>  
> -		debugfs_create_file(subsystems[i].name, 0400, root, (void *)&subsystems[i],
> -				    &qcom_subsystem_sleep_stats_fops);
> +		/*
> +		 * At this point some subsystems have already started
> +		 * and so we already missed the startup notification,
> +		 * so let's create the entry post-startup.
> +		 */
> +		ss_priv->dentry = debugfs_create_file(&subsystems[i]->name, 0400, root,

Please do not apply. There is a build issue here. Should be: subsystems[i].name

> +							(void *)&subsystems[i],
> +							&qcom_subsystem_sleep_stats_fops);
>  	}
>  }
>  
> @@ -232,6 +302,7 @@ static int qcom_stats_probe(struct platform_device *pdev)
>  	stats->data = d;
>  	stats->root = root;
>  
> +	qcom_register_subsystem_notifiers(stats);
>  	qcom_create_subsystem_stat_files(stats);
>  	qcom_create_soc_sleep_stat_files(stats, reg);
>  
> @@ -245,6 +316,8 @@ static int qcom_stats_remove(struct platform_device *pdev)
>  	struct qcom_stats_priv *stats = platform_get_drvdata(pdev);
>  	struct dentry *root = stats->root;
>  
> +	qcom_unregister_subsystem_notifiers(stats);
> +
>  	debugfs_remove_recursive(root);
>  
>  	return 0;
> -- 
> 2.34.1
> 
