Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8634D8F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiCNWZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiCNWZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:25:32 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D592DEC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:24:21 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso22105178oop.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VXkgLT4PeK4BJW91saFmU0oIFYB4QFVel8mcjNJiRmM=;
        b=fwsIaGF4QuCLG0iOgTTV5GoIGnY2aHjoWMpp+AaEV9HELRz9N7G1iK1hkOwie1Zkol
         Y28F3+urMv3v2rVixyeIAQ2o65BtxSzyrU3gx25E6JRVv6U6yHFRerWRgQJNb5zffoA4
         ket7miU2iqbcmKor9+1hyAsL/JBc3lqGDvKF33VjYbtrsKmNCvn8sjr7/oxLXM91YF60
         oXPnMZnaf1vQXjisuorXJmRxM278D8Is8nA+T3O+NWPy3qgGI2IdsAKZ+ahoM2mlFA/U
         aQ7eOCa5ivMORSiUoJ0DZz8HCBq0GACHimqJYq4iWgAvAHOO4o2jGKdK0NzPEtM1r7zx
         1PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VXkgLT4PeK4BJW91saFmU0oIFYB4QFVel8mcjNJiRmM=;
        b=ayyodXf22wxoc7O0MU5aJ/wr9vJQoJyvh4Lv5tjG3bsZSscgo+HpbNGjWxRZfhSfSG
         HHuOluuo47SMprQaqW8/Ox/wZr6elb3dvrvJpRrolP1mKF2Lf1iVYtKTKS2qJnRg6B66
         on49zf6EEg0eH4SWTwngaIJnflS4t4QbTyO/fm+lBGufGGR+kaa+AXqLcChxBwMjBhVI
         roOdHo1xvAKWQSCvn+/zdCO8wscsQlwqD3C9gmM9xkqcZTY7Q9Cim7Nhq4LiSpwPOA4b
         iuqg4ww4+fAUS08TxotYqDo1dNJ2Ruq0mXLVtEp/VcnoRyqZFZl6sNlN9cXVnrMkwaN8
         Hmtw==
X-Gm-Message-State: AOAM532jkHhAwZlMYSYBiylGnkkoSi3mg3bQ9NNVE3TbB5Wxr+hJUVYg
        AfPMLksLJ19fPbtB/rVchnbsFg==
X-Google-Smtp-Source: ABdhPJxsWboDvrA/SAMxOI6sRMS8CGcJCSsKU9LKX+lWQ7SnYyhFHebQojX6n+0d3k+fYy9xgMyUnw==
X-Received: by 2002:a05:6870:1d4:b0:db:a2b3:cff9 with SMTP id n20-20020a05687001d400b000dba2b3cff9mr37oad.231.1647296660779;
        Mon, 14 Mar 2022 15:24:20 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm7968434oov.3.2022.03.14.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 15:24:20 -0700 (PDT)
Date:   Mon, 14 Mar 2022 17:24:18 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org, robh+dt@kernel.or,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com
Subject: Re: [PATCH v4 4/7] remoteproc: mtk_apu: Add support of JTAG
Message-ID: <Yi/AkpIPO94E1qFg@builder.lan>
References: <20220304161514.994128-1-abailon@baylibre.com>
 <20220304161514.994128-5-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304161514.994128-5-abailon@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Mar 10:15 CST 2022, Alexandre Bailon wrote:

> The DSP could be debugged using JTAG.
> The support of JTAG could enabled at build time and it could be enabled
> using debugfs.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/remoteproc/Kconfig   |   9 +++
>  drivers/remoteproc/mtk_apu.c | 147 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 959d24e9492c..28140cf04d8a 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -74,6 +74,15 @@ config MTK_APU
>  
>  	  It's safe to say N here.
>  
> +config MTK_APU_JTAG
> +	bool "Enable support of JTAG"
> +	depends on MTK_APU
> +	help
> +	  Say y to enable support of JTAG.
> +	  By default, JTAG will remain disabled until it is enabled using
> +	  debugfs: remoteproc/remoteproc0/jtag. Write 1 to enable it and
> +	  0 to disable it.
> +
>  config OMAP_REMOTEPROC
>  	tristate "OMAP remoteproc support"
>  	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
> diff --git a/drivers/remoteproc/mtk_apu.c b/drivers/remoteproc/mtk_apu.c
> index 867b4682b507..3905eb5b7174 100644
> --- a/drivers/remoteproc/mtk_apu.c
> +++ b/drivers/remoteproc/mtk_apu.c
> @@ -5,12 +5,14 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of_reserved_mem.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  #include <linux/string.h>
> @@ -45,6 +47,11 @@
>  #define CORE_DEFAULT1				(0x00000140)
>  #define CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU	(0x10 << 0)
>  #define CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU	(0x10 << 5)
> +#define CORE_DEFAULT2				(0x00000144)
> +#define CORE_DEFAULT2_DBG_EN			BIT(3)
> +#define CORE_DEFAULT2_NIDEN			BIT(2)
> +#define CORE_DEFAULT2_SPNIDEN			BIT(1)
> +#define CORE_DEFAULT2_SPIDEN			BIT(0)
>  #define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
>  
>  #define VDEV_MEM_COUNT				(3)
> @@ -59,6 +66,13 @@ struct mtk_apu_rproc {
>  	struct clk_bulk_data *clks;
>  	struct iommu_domain *domain;
>  	struct list_head mappings;
> +
> +#ifdef CONFIG_MTK_APU_JTAG
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_jtag;
> +	bool jtag_enabled;
> +	struct mutex jtag_mutex;
> +#endif
>  };
>  
>  static const char * const mt8183_clk_names[] = {
> @@ -355,6 +369,133 @@ static irqreturn_t mtk_apu_rproc_callback(int irq, void *data)
>  	return IRQ_WAKE_THREAD;
>  }
>  
> +#ifdef CONFIG_MTK_APU_JTAG

Is there a strong reason to keep this compiled out? It's not that much
code and it means that I have to build test both variations...

> +
> +static int apu_enable_jtag(struct mtk_apu_rproc *apu_rproc)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&apu_rproc->jtag_mutex);

What happens if you perform the below writel() when jtag is already
enabled? I.e. do you need this mutex or could you simply have
enable/disable just write the register?

> +	if (apu_rproc->jtag_enabled)
> +		goto err_mutex_unlock;
> +
> +	writel(CORE_DEFAULT2_SPNIDEN | CORE_DEFAULT2_SPIDEN |
> +		CORE_DEFAULT2_NIDEN | CORE_DEFAULT2_DBG_EN,
> +		apu_rproc->base + CORE_DEFAULT2);
> +
> +	apu_rproc->jtag_enabled = 1;
> +
> +err_mutex_unlock:
> +	mutex_unlock(&apu_rproc->jtag_mutex);
> +
> +	return ret;
> +}
> +
> +static int apu_disable_jtag(struct mtk_apu_rproc *apu_rproc)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&apu_rproc->jtag_mutex);
> +	if (!apu_rproc->jtag_enabled)
> +		goto err_mutex_unlock;
> +
> +	writel(0, apu_rproc->base + CORE_DEFAULT2);
> +
> +	apu_rproc->jtag_enabled = 0;
> +
> +err_mutex_unlock:
> +	mutex_unlock(&apu_rproc->jtag_mutex);
> +
> +	return ret;
> +}
> +
> +static ssize_t rproc_jtag_read(struct file *filp, char __user *userbuf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	struct mtk_apu_rproc *apu_rproc = (struct mtk_apu_rproc *)rproc->priv;
> +	char *buf = apu_rproc->jtag_enabled ? "enabled\n" : "disabled\n";
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));

Per my ask about write below, please make this read 'Y' or 'N'.

> +}
> +
> +static ssize_t rproc_jtag_write(struct file *filp, const char __user *user_buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	struct mtk_apu_rproc *apu_rproc = (struct mtk_apu_rproc *)rproc->priv;
> +	char buf[10];
> +	int ret;
> +
> +	if (count < 1 || count > sizeof(buf))
> +		return -EINVAL;
> +
> +	ret = copy_from_user(buf, user_buf, count);
> +	if (ret)
> +		return -EFAULT;
> +
> +	/* remove end of line */
> +	if (buf[count - 1] == '\n')
> +		buf[count - 1] = '\0';
> +

Please use kstrtobool_from_user().

> +	if (!strncmp(buf, "enabled", count))
> +		ret = apu_enable_jtag(apu_rproc);
> +	else if (!strncmp(buf, "disabled", count))
> +		ret = apu_disable_jtag(apu_rproc);
> +	else
> +		return -EINVAL;
> +
> +	return ret ? ret : count;
> +}
> +
> +static const struct file_operations rproc_jtag_ops = {
> +	.read = rproc_jtag_read,
> +	.write = rproc_jtag_write,
> +	.open = simple_open,
> +};
> +
> +static int apu_jtag_probe(struct mtk_apu_rproc *apu_rproc)
> +{
> +	int ret;
> +
> +	if (!apu_rproc->rproc->dbg_dir)
> +		return -ENODEV;
> +
> +	apu_rproc->pinctrl = devm_pinctrl_get(apu_rproc->dev);
> +	if (IS_ERR(apu_rproc->pinctrl)) {
> +		dev_warn(apu_rproc->dev, "Failed to find JTAG pinctrl\n");

I believe you failed to find the pinctrl instance for the remoteproc
driver, not for the JTAG.

> +		return PTR_ERR(apu_rproc->pinctrl);
> +	}
> +
> +	apu_rproc->pinctrl_jtag = pinctrl_lookup_state(apu_rproc->pinctrl,
> +						       "jtag");
> +	if (IS_ERR(apu_rproc->pinctrl_jtag))
> +		return PTR_ERR(apu_rproc->pinctrl_jtag);
> +
> +	ret = pinctrl_select_state(apu_rproc->pinctrl,
> +				   apu_rproc->pinctrl_jtag);

So if the kernel is compiled with MTK_APU_JTAG "jtag" is the new
"default" for this device?

Regards,
Bjorn

> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&apu_rproc->jtag_mutex);
> +
> +	debugfs_create_file("jtag", 0600, apu_rproc->rproc->dbg_dir,
> +			    apu_rproc->rproc, &rproc_jtag_ops);
> +
> +	return 0;
> +}
> +#else
> +static int apu_jtag_probe(struct mtk_apu_rproc *apu_rproc)
> +{
> +	return 0;
> +}
> +
> +static int apu_disable_jtag(struct mtk_apu_rproc *apu_rproc)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_MTK_APU_JTAG */
> +
>  static int mtk_apu_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -442,6 +583,10 @@ static int mtk_apu_rproc_probe(struct platform_device *pdev)
>  		goto free_rproc;
>  	}
>  
> +	ret = apu_jtag_probe(apu_rproc);
> +	if (ret)
> +		dev_warn(dev, "Failed to configure jtag\n");

If devm_pinctrl_get() failed you'll get two warnings, and if the user
haven't added a "jtag" pinctrl state this warning isn't very
descriptive. Consider omitting it and add appropriate error messages in
apu_jtag_probe().

Regards,
Bjorn

> +
>  	return 0;
>  
>  free_rproc:
> @@ -457,7 +602,7 @@ static int mtk_apu_rproc_remove(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  
>  	disable_irq(apu_rproc->irq);
> -
> +	apu_disable_jtag(apu_rproc);
>  	rproc_del(rproc);
>  	of_reserved_mem_device_release(dev);
>  	rproc_free(rproc);
> -- 
> 2.34.1
> 
