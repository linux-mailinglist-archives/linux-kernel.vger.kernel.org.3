Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A59472ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhLMLIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:08:39 -0500
Received: from www381.your-server.de ([78.46.137.84]:46432 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLMLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Y4dtkF/fMMRIvoWTochjJh1M/yoOLIPvlhPe/ZJAB28=; b=bjFQDgK5Yh1g30FOoZQwC+sp7l
        rH6to49nqPPpFkBQFGSDt4CeWPAiDRmaVy8K+ISajzCu1zk85vM5aQXM4MkUJ8ik/DtzX6ezn2dUK
        ILDKZOVuGM+Qpr4PpBLV8NT4vObqrXXX5f59iYqZIBV3E6C2uF3PZI/nCD1/fy8c+fLj6wwnP2Khi
        1COXitSPV6zePf/yeQ/CFdfa1smv1id7Rkq3EQBfkHZxDqW5fCvOi/DyLON7yKrRHTzQYS/4D3MtY
        JYAYHR+LcJt7tE1mkdH6cUs8j8ffhNY/YwlCfp7KHtusBScnRUc4znFPCtagCTMrxMmkJUfbdobjJ
        mEbbC7RQ==;
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mwjC6-000FYH-K0; Mon, 13 Dec 2021 12:08:34 +0100
Received: from [2001:a61:2aa6:c001:9e5c:8eff:fe01:8578]
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mwjC6-000ObZ-97; Mon, 13 Dec 2021 12:08:34 +0100
Subject: Re: [PATCH v2 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
To:     Tanmay Shah <tanmay.shah@xilinx.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        Sergei Korneichuk <sergei.korneichuk@xilinx.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ab9e009a-5e35-ae49-2c8e-65be6ba36d7f@metafoo.de>
Date:   Mon, 13 Dec 2021 12:08:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123062050.1442712-7-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26385/Mon Dec 13 10:38:12 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 7:20 AM, Tanmay Shah wrote:
> [...]
> +/*
> + * zynqmp_r5_rproc_mem_map
> + * @rproc: single R5 core's corresponding rproc instance
> + * @mem: mem entry to map
> + *
> + * Callback to map va for memory-region's carveout.
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int zynqmp_r5_rproc_mem_map(struct rproc *rproc,
> +				   struct rproc_mem_entry *mem)
> +{
> +	void __iomem *va;
> +
> +	va = ioremap_wc(mem->dma, mem->len);

Since you want normal memory and not IO memory a better choice might be 
memremap() with MEMREMAP_WC. Internally memremap() will call 
ioremap_wc(), but this will make the intention clear and you do not have 
to deal with the __iomem type cast.

> +	if (IS_ERR_OR_NULL(va))
> +		return -ENOMEM;
> +
> +	mem->va = (void *)va;
> +
> +	return 0;
> +}
> [...]
>
> +static int add_tcm_banks(struct rproc *rproc)
> +{
> +	struct device *dev;
> +	struct platform_device *parent_pdev;
> +	struct zynqmp_r5_cluster *cluster;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	if (!r5_core)
> +		return -EINVAL;
> +
> +	dev = r5_core->dev;
> +	if (!dev) {
> +		pr_err("r5 core device unavailable\n");
> +		return -ENODEV;
> +	}
> +
> +	parent_pdev = to_platform_device(dev->parent);
> +	if (!parent_pdev) {
> +		dev_err(dev, "parent platform dev unavailable\n");
> +		return -ENODEV;
> +	}
> +
> +	cluster = platform_get_drvdata(parent_pdev);

You could just use dev_get_drvdata() without having to cast back to the 
platform_device first.


> +	if (!cluster) {
> +		dev_err(&parent_pdev->dev, "Invalid driver data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (cluster->mode == SPLIT_MODE)
> +		return add_tcm_carveout_split_mode(rproc);
> +	else if (cluster->mode == LOCKSTEP_MODE)
> +		return add_tcm_carveout_lockstep_mode(rproc);
> +
> +	dev_err(cluster->dev, "invalid cluster mode\n");
> +	return -EINVAL;
> +}
> +
> [...]
> +
> +static struct rproc_ops zynqmp_r5_rproc_ops = {
const
> +	.start		= zynqmp_r5_rproc_start,
> +	.stop		= zynqmp_r5_rproc_stop,
> +	.load		= rproc_elf_load_segments,
> +	.parse_fw	= zynqmp_r5_parse_fw,
> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	= rproc_elf_sanity_check,
> +	.get_boot_addr	= rproc_elf_get_boot_addr,
> +};
> [....]
> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> +{
> [...]
> +
> +	for (i = 0; i < res_mem_count; i++) {
> +		rmem_np = of_parse_phandle(np, "memory-region", i);
> +		if (!rmem_np)
> +			return -EINVAL;
> +
> +		rmem = of_reserved_mem_lookup(rmem_np);
> +		if (!rmem) {
> +			of_node_put(rmem_np);
> +			return -EINVAL;
> +		}
> +
> +		memcpy(&r5_core->res_mem[i], rmem,
> +		       sizeof(struct reserved_mem));

r5_core->res_mem[i] = *mem;

This will give you proper type checking and is also a bit shorter.

> +		of_node_put(rmem_np);
> +	}
> +
> +	r5_core->res_mem_count = res_mem_count;
> +
> +	return 0;
> +}
> [...]
> +
> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> +{
> [...]
> +
>
> +	i = 0;
> +	for_each_available_child_of_node(dev_node, child) {
> +		child_pdev = of_find_device_by_node(child);
> +		if (!child_pdev)
A return or a break in a for_each_available_child_of_node() will leak 
the reference to the child node.
> [...]
> +	}
> +
> [...]
> +
> +	return 0;
> +}
> +
> +static void zynqmp_r5_cluster_exit(void *data)
> +{
> +	struct platform_device *pdev = (struct platform_device *)data;
> +
> +	platform_set_drvdata(pdev, NULL);
This is not needed. The device driver core will set drvdata to NULL when 
the device is removed.
> +
> +	pr_info("Exit r5f subsystem driver\n");
This is probably also not needed.
> +}


