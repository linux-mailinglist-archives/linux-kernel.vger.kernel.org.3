Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9553C03F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbiFBVHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbiFBVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:07:09 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC7C25E2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:07:07 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ws21nB6svvNzHws21nz3MA; Thu, 02 Jun 2022 23:07:04 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 02 Jun 2022 23:07:04 +0200
X-ME-IP: 90.11.190.129
Message-ID: <82e9f075-0526-ac34-fa92-14a7402825fd@wanadoo.fr>
Date:   Thu, 2 Jun 2022 23:07:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: fr
To:     tanmay.shah@xilinx.com
Cc:     ben.levinsky@xilinx.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, krzk+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        michal.simek@xilinx.com,
        openamp-system-reference@lists.openampproject.org,
        robh+dt@kernel.org
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-7-tanmay.shah@xilinx.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220602203834.3675160-7-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

should there be a v9, a nitpick below.

Le 02/06/2022 à 22:38, Tanmay Shah a écrit :
> This driver enables r5f dual core Real time Processing Unit subsystem
> available on Xilinx Zynq Ultrascale MPSoC Platform. RPU subsystem
> (cluster) can be configured in different modes e.g. split mode in which
> two r5f cores work independent of each other and lock-step mode in which
> both r5f cores execute same code clock-for-clock and notify if the
> result is different.
> 
> The Xilinx r5 Remoteproc Driver boots the RPU cores via calls to the Xilinx
> Platform Management Unit that handles the R5 configuration, memory access
> and R5 lifecycle management. The interface to this manager is done in this
> driver via zynqmp_pm_* function calls.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Tanmay Shah <tanmay.shah-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
> 

[...]

> +static void zynqmp_r5_cluster_exit(void *data)
> +{
> +	struct platform_device *pdev = (struct platform_device *)data;
> +	struct zynqmp_r5_cluster *cluster;
> +	int i;
> +
> +	cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
> +	if (!cluster)
> +		return;
> +
> +	for (i = 0; i < cluster->core_count; i++) {
> +		zynqmp_r5_core_exit(cluster->r5_cores[i]);
> +		cluster->r5_cores[i] = NULL;
> +	}
> +
> +	kfree(cluster->r5_cores);
> +	kfree(cluster);

why not remove this kfree(cluster) here...

> +	platform_set_drvdata(pdev, NULL);
> +}
> +
> +/*
> + * zynqmp_r5_remoteproc_probe()
> + *
> + * @pdev: domain platform device for R5 cluster
> + *
> + * called when driver is probed, for each R5 core specified in DT,
> + * setup as needed to do remoteproc-related operations
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct zynqmp_r5_cluster *cluster;
> +	struct device *dev = &pdev->dev;
> +
> +	cluster = kzalloc(sizeof(*cluster), GFP_KERNEL);

... devm_kzalloc() here...

> +	if (!cluster)
> +		return -ENOMEM;
> +
> +	cluster->dev = dev;
> +
> +	ret = devm_of_platform_populate(dev);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to populate platform dev\n");
> +		kfree(cluster);
> +		return ret;

and return dev_err_probe() here (without the kfree)?
Would'nt it be cleaner?

just my 2c

CJ

> +	}
> +
> +	/* wire in so each core can be cleaned up at driver remove */
> +	platform_set_drvdata(pdev, cluster);
> +
> +	ret = zynqmp_r5_cluster_init(cluster);
> +	if (ret) {
> +		zynqmp_r5_cluster_exit(pdev);
> +		dev_err_probe(dev, ret, "Invalid r5f subsystem device tree\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +

[...]
