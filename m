Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C56B4BFF38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiBVQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiBVQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:50:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E216A5BD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:49:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g1so12651912pfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Ljxg0fnUTAqNuMf+CJgicX0/L6Xlb1XybLuSqJDmXk=;
        b=uE6SBmObEnrdiczQzKgPlGMv8vibgsSwlxw/OWFFl5tJSF9LjJF/rjG8oPclIfaq1L
         UrUHsspinjXruRROM/iCiRWSxVGr3+ZWbUfPXuqR5xPy9dpJrysOCoqnjFVzn3CbXW0K
         FCKyXKEg8rhNgXlRkNrIQsE6/NN+LgqGbt5mGlHsuiZsT3NofE0iGEeeZfq9/54ENmnb
         OxKoGs2xB0FOOyjbM74jnMvao5bsUuTeDX+pWsT+q+FqCCi/z1haGKUhSozFloM/kgDo
         3pRMq1envIYSHJ2wyzatIlSQnPBm9eAoqpLDc05axNwkjc6xKIXSWut2kjBzGHYi/YFR
         VfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Ljxg0fnUTAqNuMf+CJgicX0/L6Xlb1XybLuSqJDmXk=;
        b=Z348OhcswKCViz7VYk8mgcLomhdv05aDA8n+BAdpvoxON9L2HmX0p8bb5sOdP3hKjZ
         fxOr0dcv7dqQfqptmn8yeVF9r46mLrljN0FtTg4wrS/pFEEsmFFIzdzmXaqNCrfQ7EUH
         MP1Xe0EjIfwJCGGlPlCiFBFRDaPjMVVg9Eh5Ryds4a8kxmS2x8oZJA/OAspZofvSnxjY
         jE5zb0U0l/dWmd6h95EFxoJsCt/boXHylo70a68VrOT4SrQR9TsTJMcXmmRp3CcA2z+7
         49VyBwYnhL1fh3zGNbpNumj5vWC7XZT74f/mrayR7RwjCioAThwus8lefoTffv3ADuw3
         ptRA==
X-Gm-Message-State: AOAM5304wggltmvTG71ZmrwV45hM+Dt7Tq+9TOM9g8WQYPwf4BYapnea
        gt/ppmkGaBauchf4VCm0bWpzRA==
X-Google-Smtp-Source: ABdhPJzq9169xLlO34W8P9IgbAuUtBoSjkMowSoJhPUCS8RWnTU5gOJmAR7QpjMOeL9mOr3qha8IXw==
X-Received: by 2002:a62:ee12:0:b0:4e1:2ec1:cba2 with SMTP id e18-20020a62ee12000000b004e12ec1cba2mr25805336pfi.71.1645548595246;
        Tue, 22 Feb 2022 08:49:55 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090a1fcb00b001bc58804974sm76007pjz.27.2022.02.22.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:49:54 -0800 (PST)
Date:   Tue, 22 Feb 2022 09:49:51 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, laurent.pinchart@ideasonboard.com,
        ben.levinsky@xilinx.com, bill.mills@linaro.org,
        sergei.korneichuk@xilinx.com, arun.balaji.kannan@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Message-ID: <20220222164951.GB923552@p14s>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
 <20220210112824.2084724-7-tanmay.shah@xilinx.com>
 <20220216182631.GA347485@p14s>
 <9d20b1ae-e158-a0a7-7415-cd589ec44900@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d20b1ae-e158-a0a7-7415-cd589ec44900@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > + * zynqmp_r5_cluster_init()
> > > + * Create and initialize zynqmp_r5_cluster type object
> > > + *
> > > + * @cluster: pointer to zynqmp_r5_cluster type object
> > > + *
> > > + * Return: 0 for success and error code for failure.
> > > + */
> > > +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	struct device *dev = cluster->dev;
> > > +	struct device_node *dev_node = dev_of_node(dev);
> > > +	struct device_node *child;
> > > +	struct platform_device *child_pdev;
> > > +	int core_count = 0, ret, i;
> > > +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> > > +	struct zynqmp_r5_core **r5_cores;
> > > +
> > > +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
> > > +
> > > +	/*
> > > +	 * on success returns 0, if not defined then returns -EINVAL,
> > > +	 * In that case, default is LOCKSTEP mode
> > > +	 */
> > > +	if (ret != -EINVAL && ret != 0) {
> > > +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/*
> > > +	 * For now driver only supports split mode and lockstep mode.
> > > +	 * fail driver probe if either of that is not set in dts
> > > +	 */
> > > +	if (cluster_mode == SINGLE_CPU_MODE) {
> > > +		dev_err(dev, "driver does not support single cpu mode\n");
> > > +		return -EINVAL;
> > > +	} else if ((cluster_mode != SPLIT_MODE &&
> > > +		   cluster_mode != LOCKSTEP_MODE)) {
> > > +		dev_err(dev, "Invalid cluster mode\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Number of cores is decided by number of child nodes of
> > > +	 * r5f subsystem node in dts. If Split mode is used in dts
> > > +	 * 2 child nodes are expected.
> > > +	 * In lockstep mode if two child nodes are available,
> > > +	 * only use first child node and consider it as core0
> > > +	 * and ignore core1 dt node.
> > > +	 */
> > > +	core_count = of_get_available_child_count(dev_node);
> > > +	if (core_count <= 0) {
> > > +		dev_err(dev, "Invalid number of r5 cores %d", core_count);
> > > +		return -EINVAL;
> > > +	} else if (cluster_mode == SPLIT_MODE && core_count != 2) {
> > > +		dev_err(dev, "Invalid number of r5 cores for split mode\n");
> > > +		return -EINVAL;
> > > +	} else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
> > > +		dev_warn(dev, "Only r5 core0 will be used\n");
> > > +		core_count = 1;
> > > +	}
> > > +
> > > +	r5_cores = devm_kcalloc(dev, core_count,
> > > +				sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
> > > +	if (!r5_cores)
> > > +		return -ENOMEM;
> > > +
> > > +	i = 0;
> > > +	for_each_available_child_of_node(dev_node, child) {
> > > +		child_pdev = of_find_device_by_node(child);
> > > +		if (!child_pdev) {
> > > +			of_node_put(child);
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		/* create and add remoteproc instance of type struct rproc */
> > > +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
> > Function zynqmp_r5_add_rproc_core() returns an error code on error that is never
> > checked.
> > 
> > > +		r5_cores[i]->dev = &child_pdev->dev;
> > This will result in a kernel stack trace if zynqmp_r5_add_rproc_core() fails.
> Sure I will fix it.
> > > +		if (!r5_cores[i]->dev) {
> > > +			dev_err(dev, "can't get device for r5 core %d\n", i);
> > > +			of_node_put(child);
> > > +			return -ENODEV;
> > > +		}
> > And here the validity of child_pdev->dev is checked _after_ it has been passed
> > to zynqmp_r5_add_rproc_core().  This check should not be needed if proper
> > error handling is done above.
> I agree.
> > > +
> > > +		r5_cores[i]->np = dev_of_node(r5_cores[i]->dev);
> > > +		if (!r5_cores[i]->np) {
> > > +			dev_err(dev, "can't get device node for r5 core %d\n", i);
> > > +			of_node_put(child);
> > As mention in the documentation for of_find_device_by_node(), the function takes
> > a reference to child_pdev->dev that needs to be released with put_device().  In
> > fact I don't see the reference dropped anywhere, even when the driver is
> > released.
> 
> I agree. I want to use r5_cores[i]->dev throughout driver so,
> 
> Is it fine if I use put_device() during driver release i.e. function
> zynqmp_r5_cluster_exit( ) ?
> 

Yes, that would be the right place to do it.

> > Moreover, if we end up here for r5_cores[1], resources acquired for r5_core[0]
> > are not released.
> 
> Most of the resources (such as zynqmp_r5_rproc_ops and r5_rproc objects) for
> r5_core[0] are allocated using devm_* API,
> 
> so I believe it will be de-allocated when driver probe fails and driver
> exits.
> 
> If r5_cores[1] fails, then r5_cores[0]->np needs to be released here. I will
> find out mechanism to take care of this.
> 
> Please let me know if I am missing anything here.
> 

I'll take another look in your next revision.

> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		i++;
> > > +
> > > +		/*
> > > +		 * If two child nodes are available in dts in lockstep mode,
> > > +		 * then ignore second child node.
> > > +		 */
> > > +		if (i == core_count) {
> > > +			of_node_put(child);
> > > +			break;
> > > +		}
> > > +		of_node_put(child);
> > This one is not needed as it is already done by the
> > for_each_available_child_of_node() loop.
> 
> Ok I will remove it.
> 
> > More comments tomorrow.
> > 
> > Thanks,
> > Mathieu
> > 
> > > +	}
> > > +
> > > +	cluster->mode = cluster_mode;
> > > +	cluster->core_count = core_count;
> > > +	cluster->r5_cores = r5_cores;
> > > +
> > > +	ret = zynqmp_r5_core_init(cluster);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to init r5 core err %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void zynqmp_r5_cluster_exit(void *data)
> > > +{
> > > +	struct platform_device *pdev = (struct platform_device *)data;
> > > +
> > > +	platform_set_drvdata(pdev, NULL);
> > > +
> > > +	pr_info("Exit r5f subsystem driver\n");
> > > +}
> > > +
> > > +/*
> > > + * zynqmp_r5_remoteproc_probe()
> > > + *
> > > + * @pdev: domain platform device for R5 cluster
> > > + *
> > > + * called when driver is probed, for each R5 core specified in DT,
> > > + * setup as needed to do remoteproc-related operations
> > > + *
> > > + * Return: 0 for success, negative value for failure.
> > > + */
> > > +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> > > +{
> > > +	int ret;
> > > +	struct zynqmp_r5_cluster *cluster;
> > > +	struct device *dev = &pdev->dev;
> > > +
> > > +	cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
> > > +	if (!cluster)
> > > +		return -ENOMEM;
> > > +
> > > +	cluster->dev = dev;
> > > +
> > > +	ret = devm_of_platform_populate(dev);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to populate platform dev %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* wire in so each core can be cleaned up at driver remove */
> > > +	platform_set_drvdata(pdev, cluster);
> > > +
> > > +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = zynqmp_r5_cluster_init(cluster);
> > > +	if (ret) {
> > > +		dev_err(dev, "Invalid r5f subsystem device tree\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/* Match table for OF platform binding */
> > > +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> > > +	{ .compatible = "xlnx,zynqmp-r5fss", },
> > > +	{ /* end of list */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> > > +
> > > +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> > > +	.probe = zynqmp_r5_remoteproc_probe,
> > > +	.driver = {
> > > +		.name = "zynqmp_r5_remoteproc",
> > > +		.of_match_table = zynqmp_r5_remoteproc_match,
> > > +	},
> > > +};
> > > +module_platform_driver(zynqmp_r5_remoteproc_driver);
> > > +
> > > +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
> > > +MODULE_AUTHOR("Xilinx Inc.");
> > > +MODULE_LICENSE("GPL v2");
> > > -- 
> > > 2.25.1
> > > 
