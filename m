Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8374D4D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiCJPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiCJPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:38:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7D16E7D1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:37:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b15so3384128edn.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6JXg6OR646jM76JRpapUazLqGWvsRdggkpJq90pah8=;
        b=YChSVyKLVMOalQZRDRKtxKHcwbUDmNwko7I32xXa0f1GBzTRU81/OGwiosnZoLJrKj
         o45+zcIOCF6NnoDjrNzZwgzIVkYXf6+RqAQeM73lk09+ugRpcoVzs97rOvPzSk8qYPKd
         rl6/imHMf7EV0pDCkFJaqeJPc+Kx96t5oiaVXIiDIiMHrx0zm+nns9zPK3KtPkoTJxV+
         S9jqcVT1Bh+yznf3h1l3d740YPoO3QkurAHHDmJmFafBpkNlyrDk5NzIopbJUxEJPTeW
         v+FSZSz9Cq8m0ofXOobYPke3xeZJB75ARTbnmTHVb6xbPdP5Ci9+zbIw9XOpmu1XWBUp
         4jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6JXg6OR646jM76JRpapUazLqGWvsRdggkpJq90pah8=;
        b=y2YT5UxZn9R0kniPg49/Jrw62MV2dz/Y6vFLakihW3uIy5y9hfb8gyvVIVn/Yb0noo
         J5gz46VaIQ16gUKIB9mp0R4mw43yTI0j5PrNyXCn8uKqTf3LjG8BpCTPSf0Q1pOiQS9W
         HI8YrYdKClsj9AvHw3QvyVdljpmVR7nX1LieRqzn0hM/krS6CU6SU4LJ5IfFCrPpUr5j
         mBuTROAV9VmseQeSQxLNz6oFGJxhFdxvHZxafCHYnmHCFz+etqb5BcC6WZA815qg6jCm
         RjUwByPJKJBN+cIvF+IjVSuaBlZbGCFbiG9kcXdkF5V4CqCMxuFxWQX9oQRO43i79DFY
         lJDg==
X-Gm-Message-State: AOAM530LMXDDSPCaUK9CMZoik8Ne1H/efvlt3aZanmCNd8aqus/cgNBb
        FDHO2mXNpG6S23ET4b6feJCI+UdKw+GbbkFioomKag==
X-Google-Smtp-Source: ABdhPJyFXNA9JyzqhAJWg11ooceV0nza7abfMjzctaIlNzVhFu4+t+Mmh61Vcxe1fwGHSBUpet7k2ZYKgQys2Q8a3Cs=
X-Received: by 2002:a05:6402:34cb:b0:415:b974:ec5c with SMTP id
 w11-20020a05640234cb00b00415b974ec5cmr4977669edc.329.1646926626280; Thu, 10
 Mar 2022 07:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
 <20220210112824.2084724-7-tanmay.shah@xilinx.com> <20220218191150.GB574087@p14s>
 <6a9dcca9-3c86-f603-d13a-acc74161f1a1@xilinx.com> <1be9d9bd-4c74-d38f-6a9b-3a17d86fe380@xilinx.com>
In-Reply-To: <1be9d9bd-4c74-d38f-6a9b-3a17d86fe380@xilinx.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 10 Mar 2022 08:36:53 -0700
Message-ID: <CANLsYkwthHZr42Bi87Tvj4fWE_nGJU47tsXBdhvKxvVz0GeLtA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc driver
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, laurent.pinchart@ideasonboard.com,
        ben.levinsky@xilinx.com, bill.mills@linaro.org,
        sergei.korneichuk@xilinx.com, arun.balaji.kannan@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 00:18, Tanmay Shah <tanmay.shah@xilinx.com> wrote:
>
>
> On 2/21/22 6:13 PM, Tanmay Shah wrote:
> >
> > On 2/18/22 11:11 AM, Mathieu Poirier wrote:
> >> On Thu, Feb 10, 2022 at 03:28:24AM -0800, Tanmay Shah wrote:
> >>> This driver enables r5f dual core Real time Processing Unit subsystem
> >>> available on Xilinx Zynq Ultrascale MPSoC Platform. RPU subsystem
> >>> (cluster) can be configured in different modes e.g. split mode in which
> >>> two r5f cores work independent of each other and lock-step mode in
> >>> which
> >>> both r5f cores execute same code clock-for-clock and notify if the
> >>> result is different.
> >>>
> >>> The Xilinx r5 Remoteproc Driver boots the RPU cores via calls to the
> >>> Xilinx
> >>> Platform Management Unit that handles the R5 configuration, memory
> >>> access
> >>> and R5 lifecycle management. The interface to this manager is done
> >>> in this
> >>> driver via zynqmp_pm_* function calls.
> >>>
> >>> Signed-off-by: Ben Levinsky<ben.levinsky@xilinx.com>
> >>> Signed-off-by: Tanmay Shah<tanmay.shah@xilinx.com>
> >>> ---
>
> [ .... ]
>
>
> >>> +
> >>> +/*
> >>> + * zynqmp_r5_rproc_mem_map
> >>> + * @rproc: single R5 core's corresponding rproc instance
> >>> + * @mem: mem entry to map
> >>> + *
> >>> + * Callback to map va for memory-region's carveout.
> >>> + *
> >>> + * return 0 on success, otherwise non-zero value on failure
> >>> + */
> >>> +static int zynqmp_r5_rproc_mem_map(struct rproc *rproc,
> >>> +                   struct rproc_mem_entry *mem)
> >>> +{
> >>> +    void __iomem *va;
> >>> +
> >>> +    va = ioremap_wc(mem->dma, mem->len);
> >>> +    if (IS_ERR_OR_NULL(va))
> >>> +        return -ENOMEM;
> >>> +
> >>> +    mem->va = (void *)va;
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +/*
> >>> + * zynqmp_r5_rproc_mem_unmap
> >>> + * @rproc: single R5 core's corresponding rproc instance
> >>> + * @mem: mem entry to unmap
> >>> + *
> >>> + * Unmap memory-region carveout
> >>> + *
> >>> + * return 0 on success, otherwise non-zero value on failure
> >>> + */
> >>> +static int zynqmp_r5_rproc_mem_unmap(struct rproc *rproc,
> >>> +                     struct rproc_mem_entry *mem)
> >>> +{
> >>> +    iounmap((void __iomem *)mem->va);
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +/*
> >>> + * add_mem_regions
> >>> + * @r5_core: single R5 core's corresponding zynqmp_r5_core type
> >>> instance
> >>> + * @rmem: reserved mem region parsed from dt node
> >>> + *
> >>> + * Construct rproc mem carveouts from carveout provided in
> >>> + * memory-region property
> >>> + *
> >>> + * return 0 on success, otherwise non-zero value on failure
> >>> + */
> >>> +static int add_mem_regions_carveout(struct zynqmp_r5_core *r5_core,
> >>> +                    struct reserved_mem *rmem)
> >>> +{
> >>> +    struct device *dev;
> >>> +    struct rproc_mem_entry *mem;
> >>> +    struct rproc *rproc;
> >>> +
> >>> +    rproc = r5_core->rproc;
> >>> +    dev = r5_core->dev;
> >>> +
> >>> +    /* Register associated reserved memory regions */
> >>> +    mem = rproc_mem_entry_init(dev, NULL,
> >>> +                   (dma_addr_t)rmem->base,
> >>> +                   rmem->size, rmem->base,
> >>> +                   zynqmp_r5_rproc_mem_map,
> >>> +                   zynqmp_r5_rproc_mem_unmap,
> >>> +                   rmem->name);
> >>> +    if (!mem)
> >>> +        return -ENOMEM;
> >>> +
> >>> +    rproc_add_carveout(rproc, mem);
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>>
> [ ... ]
>
> >>> +
> >>> +/*
> >>> + * zynqmp_r5_parse_fw()
> >>> + * @rproc: single R5 core's corresponding rproc instance
> >>> + * @fw: ptr to firmware to be loaded onto r5 core
> >>> + *
> >>> + * When loading firmware, ensure the necessary carveouts are in
> >>> remoteproc
> >>> + *
> >>> + * return 0 on success, otherwise non-zero value on failure
> >>> + */
> >>> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct
> >>> firmware *fw)
> >>> +{
> >>> +    int ret;
> >>> +    struct zynqmp_r5_core *r5_core;
> >>> +    struct device *dev;
> >>> +
> >>> +    r5_core = rproc->priv;
> >>> +
> >>> +    dev = r5_core->dev;
> >>> +
> >>> +    ret = add_tcm_banks(rproc);
> >>> +    if (ret) {
> >>> +        dev_err(dev, "failed to get TCM banks, err %d\n", ret);
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    ret = rproc_elf_load_rsc_table(rproc, fw);
> >>> +    if (ret == -EINVAL) {
> >>> +        /*
> >>> +         * resource table only required for IPC.
> >>> +         * if not present, this is not necessarily an error;
> >>> +         * for example, loading r5 hello world application
> >>> +         * so simply inform user and keep going.
> >>> +         */
> >>> +        dev_info(&rproc->dev, "no resource table found.\n");
> >>> +        ret = 0;
> >>> +    }
> >>> +    return ret;
> >>> +}
> >>> +
> >>> +static struct rproc_ops zynqmp_r5_rproc_ops = {
> >>> +    .start        = zynqmp_r5_rproc_start,
> >>> +    .stop        = zynqmp_r5_rproc_stop,
> >>> +    .load        = rproc_elf_load_segments,
> >>> +    .parse_fw    = zynqmp_r5_parse_fw,
> >>> +    .find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> >>> +    .sanity_check    = rproc_elf_sanity_check,
> >>> +    .get_boot_addr    = rproc_elf_get_boot_addr,
> >>> +};
> >>> +
> >>>
> [ ... ]
>
>
> >>> +
> >>> +/**
> >>> + * zynqmp_r5_get_mem_region_node()
> >>> + * parse memory-region property from dt node and add
> >>> + * memory region carveouts
> >>> + *
> >>> + * @r5_core: pointer to zynqmp_r5_core type object
> >>> + *
> >>> + * Return: 0 for success and error code for failure.
> >>> + */
> >>> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core
> >>> *r5_core)
> >>> +{
> >>> +    int res_mem_count, i, ret;
> >>> +    struct device *dev;
> >>> +    struct device_node *np, *rmem_np;
> >>> +    struct reserved_mem *rmem;
> >>> +
> >>> +    dev = r5_core->dev;
> >>> +
> >>> +    np = r5_core->np;
> >>> +
> >>> +    res_mem_count = of_property_count_elems_of_size(np,
> >>> "memory-region",
> >>> +                            sizeof(phandle));
> >>> +    if (res_mem_count <= 0) {
> >>> +        dev_warn(dev, "failed to get memory-region property %d\n",
> >>> +             res_mem_count);
> >>> +        return -EINVAL;
> >>> +    }
> >>> +
> >>> +    for (i = 0; i < res_mem_count; i++) {
> >>> +        rmem_np = of_parse_phandle(np, "memory-region", i);
> >>> +        if (!rmem_np)
> >>> +            return -EINVAL;
> >>> +
> >>> +        rmem = of_reserved_mem_lookup(rmem_np);
> >>> +        if (!rmem) {
> >>> +            of_node_put(rmem_np);
> >>> +            return -EINVAL;
> >> What happens to previously allocated regions when there is a failure?
> >
> > Right, I need to unmap memory and use kfree(rmem) to de-allocate memory.
> >
> >>> +        }
> >>> +
> >>> +        ret = add_mem_regions_carveout(r5_core, rmem);
> >>> +        if (ret)
> >>> +            dev_warn(dev, "failed to get reserve mem regions %d\n",
> >>> +                 ret);
> >> Same here.
> >
> > Here as well. I will release reserved mem dev with
> > of_reserved_mem_device_release API.
> >
> > One more thing. I moved add_mem_regions_carveout from parse_fw to
> > zynqmp_r5_get_mem_region_node.
> >
> > However, I believe I should move it back to parse_fw.
> >
> > Following test case is failing in when add_mem_regions_carveout is not
> > available in parse_fw:
> >
> > load_rpu_fw -> start rpu -> stop rpu -> start rpu again
> >
> > In above case, during mem regions are not added again.
> >
> > Is it fine, if I move this add_mem_regions_carveout back to
> > zynqmp_r5_parse_fw ?
>
>
> Hi Mathieu,
>
> I have addressed most of the comments from this revision.
>
> However, I wanted your opinion on this.
>
> I think mapping memory-regions during parse_fw just like tcm mapping is
> easily
>
> maintainable rather than mapping during probe. Also in my case, I am not
> able to start RPU again because memory regions are unmapped
>
> during RPU stop and can't be mapped again. So, is it ok if I move back
> add_mem_regions_carveout from driver probe to parse_fw?

If you intend to support attaching to the remote processor at some
point in the future then I suggest adding the carveouts in
ops::prepare(), otherwise ops::parse_fw() is fine.

>
> Thanks,
>
> Tanmay
>
>
> >> I am out of time for this set.  Please address comments provided up
> >> to here and
> >> we will see about the rest in a future revision.
> >>
> >> Thanks,
> >> Mathieu
> >>
> >>> +
> >>> +        of_node_put(rmem_np);
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +/*
> >>> + * zynqmp_r5_core_init()
> >>> + * Create and initialize zynqmp_r5_core type object
> >>> + *
> >>> + * @cluster: pointer to zynqmp_r5_cluster type object
> >>> + *
> >>> + * Return: 0 for success and error code for failure.
> >>> + */
> >>> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster)
> >>> +{
> >>> +    int ret, i;
> >>> +    struct zynqmp_r5_core *r5_core;
> >>> +    struct device *dev = cluster->dev;
> >>> +
> >>> +    ret = zynqmp_r5_get_tcm_node(cluster);
> >>> +    if (ret < 0) {
> >>> +        dev_err(dev, "can't get tcm node, err %d\n", ret);
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    for (i = 0; i < cluster->core_count; i++) {
> >>> +        r5_core = cluster->r5_cores[i];
> >>> +
> >>> +        ret = zynqmp_r5_get_mem_region_node(r5_core);
> >>> +        if (ret)
> >>> +            dev_warn(dev, "memory-region prop failed %d\n", ret);
> >>> +
> >>> +        /* Initialize r5 cores with power-domains parsed from dts */
> >>> +        ret = of_property_read_u32_index(r5_core->np, "power-domains",
> >>> +                         1, &r5_core->pm_domain_id);
> >>> +        if (ret) {
> >>> +            dev_err(dev, "failed to get power-domains property\n");
> >>> +            return ret;
> >>> +        }
> >>> +
> >>> +        ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
> >>> +        if (ret) {
> >>> +            dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
> >>> +                cluster->mode, ret);
> >>> +            return ret;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +/*
> >>> + * zynqmp_r5_cluster_init()
> >>> + * Create and initialize zynqmp_r5_cluster type object
> >>> + *
> >>> + * @cluster: pointer to zynqmp_r5_cluster type object
> >>> + *
> >>> + * Return: 0 for success and error code for failure.
> >>> + */
> >>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> >>> +{
> >>> +    struct device *dev = cluster->dev;
> >>> +    struct device_node *dev_node = dev_of_node(dev);
> >>> +    struct device_node *child;
> >>> +    struct platform_device *child_pdev;
> >>> +    int core_count = 0, ret, i;
> >>> +    enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> >>> +    struct zynqmp_r5_core **r5_cores;
> >>> +
> >>> +    ret = of_property_read_u32(dev_node, "xlnx,cluster-mode",
> >>> &cluster_mode);
> >>> +
> >>> +    /*
> >>> +     * on success returns 0, if not defined then returns -EINVAL,
> >>> +     * In that case, default is LOCKSTEP mode
> >>> +     */
> >>> +    if (ret != -EINVAL && ret != 0) {
> >>> +        dev_err(dev, "Invalid xlnx,cluster-mode property\n");
> >>> +        return -EINVAL;
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * For now driver only supports split mode and lockstep mode.
> >>> +     * fail driver probe if either of that is not set in dts
> >>> +     */
> >>> +    if (cluster_mode == SINGLE_CPU_MODE) {
> >>> +        dev_err(dev, "driver does not support single cpu mode\n");
> >>> +        return -EINVAL;
> >>> +    } else if ((cluster_mode != SPLIT_MODE &&
> >>> +           cluster_mode != LOCKSTEP_MODE)) {
> >>> +        dev_err(dev, "Invalid cluster mode\n");
> >>> +        return -EINVAL;
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * Number of cores is decided by number of child nodes of
> >>> +     * r5f subsystem node in dts. If Split mode is used in dts
> >>> +     * 2 child nodes are expected.
> >>> +     * In lockstep mode if two child nodes are available,
> >>> +     * only use first child node and consider it as core0
> >>> +     * and ignore core1 dt node.
> >>> +     */
> >>> +    core_count = of_get_available_child_count(dev_node);
> >>> +    if (core_count <= 0) {
> >>> +        dev_err(dev, "Invalid number of r5 cores %d", core_count);
> >>> +        return -EINVAL;
> >>> +    } else if (cluster_mode == SPLIT_MODE && core_count != 2) {
> >>> +        dev_err(dev, "Invalid number of r5 cores for split mode\n");
> >>> +        return -EINVAL;
> >>> +    } else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
> >>> +        dev_warn(dev, "Only r5 core0 will be used\n");
> >>> +        core_count = 1;
> >>> +    }
> >>> +
> >>> +    r5_cores = devm_kcalloc(dev, core_count,
> >>> +                sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
> >>> +    if (!r5_cores)
> >>> +        return -ENOMEM;
> >>> +
> >>> +    i = 0;
> >>> +    for_each_available_child_of_node(dev_node, child) {
> >>> +        child_pdev = of_find_device_by_node(child);
> >>> +        if (!child_pdev) {
> >>> +            of_node_put(child);
> >>> +            return -ENODEV;
> >>> +        }
> >>> +
> >>> +        /* create and add remoteproc instance of type struct rproc */
> >>> +        r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
> >>> +        r5_cores[i]->dev = &child_pdev->dev;
> >>> +        if (!r5_cores[i]->dev) {
> >>> +            dev_err(dev, "can't get device for r5 core %d\n", i);
> >>> +            of_node_put(child);
> >>> +            return -ENODEV;
> >>> +        }
> >>> +
> >>> +        r5_cores[i]->np = dev_of_node(r5_cores[i]->dev);
> >>> +        if (!r5_cores[i]->np) {
> >>> +            dev_err(dev, "can't get device node for r5 core %d\n", i);
> >>> +            of_node_put(child);
> >>> +            return -ENODEV;
> >>> +        }
> >>> +
> >>> +        i++;
> >>> +
> >>> +        /*
> >>> +         * If two child nodes are available in dts in lockstep mode,
> >>> +         * then ignore second child node.
> >>> +         */
> >>> +        if (i == core_count) {
> >>> +            of_node_put(child);
> >>> +            break;
> >>> +        }
> >>> +        of_node_put(child);
> >>> +    }
> >>> +
> >>> +    cluster->mode = cluster_mode;
> >>> +    cluster->core_count = core_count;
> >>> +    cluster->r5_cores = r5_cores;
> >>> +
> >>> +    ret = zynqmp_r5_core_init(cluster);
> >>> +    if (ret < 0) {
> >>> +        dev_err(dev, "failed to init r5 core err %d\n", ret);
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static void zynqmp_r5_cluster_exit(void *data)
> >>> +{
> >>> +    struct platform_device *pdev = (struct platform_device *)data;
> >>> +
> >>> +    platform_set_drvdata(pdev, NULL);
> >>> +
> >>> +    pr_info("Exit r5f subsystem driver\n");
> >>> +}
> >>> +
> >>> +/*
> >>> + * zynqmp_r5_remoteproc_probe()
> >>> + *
> >>> + * @pdev: domain platform device for R5 cluster
> >>> + *
> >>> + * called when driver is probed, for each R5 core specified in DT,
> >>> + * setup as needed to do remoteproc-related operations
> >>> + *
> >>> + * Return: 0 for success, negative value for failure.
> >>> + */
> >>> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> >>> +{
> >>> +    int ret;
> >>> +    struct zynqmp_r5_cluster *cluster;
> >>> +    struct device *dev = &pdev->dev;
> >>> +
> >>> +    cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
> >>> +    if (!cluster)
> >>> +        return -ENOMEM;
> >>> +
> >>> +    cluster->dev = dev;
> >>> +
> >>> +    ret = devm_of_platform_populate(dev);
> >>> +    if (ret) {
> >>> +        dev_err(dev, "failed to populate platform dev %d\n", ret);
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    /* wire in so each core can be cleaned up at driver remove */
> >>> +    platform_set_drvdata(pdev, cluster);
> >>> +
> >>> +    ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> >>> +    if (ret)
> >>> +        return ret;
> >>> +
> >>> +    ret = zynqmp_r5_cluster_init(cluster);
> >>> +    if (ret) {
> >>> +        dev_err(dev, "Invalid r5f subsystem device tree\n");
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +/* Match table for OF platform binding */
> >>> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> >>> +    { .compatible = "xlnx,zynqmp-r5fss", },
> >>> +    { /* end of list */ },
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> >>> +
> >>> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> >>> +    .probe = zynqmp_r5_remoteproc_probe,
> >>> +    .driver = {
> >>> +        .name = "zynqmp_r5_remoteproc",
> >>> +        .of_match_table = zynqmp_r5_remoteproc_match,
> >>> +    },
> >>> +};
> >>> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> >>> +
> >>> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
> >>> +MODULE_AUTHOR("Xilinx Inc.");
> >>> +MODULE_LICENSE("GPL v2");
> >>> --
> >>> 2.25.1
> >>>
