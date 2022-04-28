Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3551381F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349130AbiD1PV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349105AbiD1PVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:21:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C9AB1881;
        Thu, 28 Apr 2022 08:18:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 16so7103093lju.13;
        Thu, 28 Apr 2022 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xaL2NofZYB+9Bgq1eH5i9jftiXuMCAuBLBje3aZA54o=;
        b=RoW9YsObYUr3P/Zbhj3FURKbrhuIKe/mpnNNS9XOEbas4R2zBKebMvvFcv+7wGlL2B
         8ATqKTYMbRIAudb4wiyTBnuGdVTFmLXLJf7YPFNEHhFbYUL/mEY1Yaahlbm3j2yqWv//
         y26gE6cfpfhHOywZq6KaGFhkSRmLKwxeI9z0LSQcLtrVJAJurN+drS3cFk6W05F667fl
         PI7htvT2cwr+XBaIX//q0Vb9U2JYSM/IJEaY6uRh5A9GGeMrLfkAsmzj98GDZPIIZhnr
         sGSr4cyxV2CRsiEmBn5mQFur1M1pOdCjLBsPGw8WHk+XpMy/4oaw8ideAdjrEpN+g1Ej
         g1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaL2NofZYB+9Bgq1eH5i9jftiXuMCAuBLBje3aZA54o=;
        b=UOB1ZEUuT7pD71paTdu8pEaz9qseeYGDMz7Bn8C2b7duXv3qYmKaXkbKpIZvtTYbhV
         01OKrRuSFrNI/XU9PdK//Vt4pCQ1ZB9ifPoASv1ky3Nl+XHS2Q+zWLm4dT3t0BbBz/wX
         XsFhabSN5Zioj63rZm6Z25gNwcq9N77o2xaWGbVopaUcJztMPJqNK3iHJWOs8mwIY7GS
         hsCIkaf96o1hN4MfJZ3C+dS8f+/IqqCUpfzCEeptY9iYiX8QSJUEL5qmKNerknoALZe+
         rsWjRzl4tdKdMHt2BkCa2STlX8cfCICXmSBOJfp+zXSqEX0y1RVGJm1p9GLRkJYVPztU
         ifDA==
X-Gm-Message-State: AOAM5321JmRP62P3LLAkJb/b21tlWp7Js+TzFVMAxGJVmXTE8baeLLSn
        2rayCIe3hEYKQwaAO85eFkQ=
X-Google-Smtp-Source: ABdhPJyZzF0h6tC23/vwgnWj+1r/Yhq25iusz7FOjK81mdwRJVczfL3S+3Vl3+narigOyUwFvo61gA==
X-Received: by 2002:a05:651c:160b:b0:24d:a0fa:26cc with SMTP id f11-20020a05651c160b00b0024da0fa26ccmr21840592ljq.150.1651159096783;
        Thu, 28 Apr 2022 08:18:16 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l3-20020a194943000000b0046b928d2795sm26897lfj.67.2022.04.28.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:18:15 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:18:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/nvdla: Add driver support for NVDLA
Message-ID: <YmqwNVoTZZFaIM9S@orome>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <20220426060808.78225-3-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NeDJSlHi0WXVr0SR"
Content-Disposition: inline
In-Reply-To: <20220426060808.78225-3-cai.huoqing@linux.dev>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NeDJSlHi0WXVr0SR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 26, 2022 at 02:07:59PM +0800, Cai Huoqing wrote:
[...]
> diff --git a/drivers/gpu/drm/nvdla/nvdla_drv.c b/drivers/gpu/drm/nvdla/nvdla_drv.c

I'll look at this from an architectural level and leave it to other
experts to review the more technical things.

[...]
> +static struct nvdla_config nvdla_config_os_initial = {
> +	.atom_size = 32,
> +	.bdma_enable = true,
> +	.rubik_enable = true,
> +	.weight_compress_support = true,
> +};
> +
> +static struct nvdla_config nvdla_config_small = {
> +	//.atom_size = 8,
> +	.atom_size = 32,  // nv_large config
> +	.bdma_enable = false,
> +	.rubik_enable = false,
> +	.weight_compress_support = false,
> +};
> +
[...]
> +static union nvdla_operation_container operation_desc[NVDLA_OP_NUM][NVDLA_NUM_GROUPS];
> +static union nvdla_surface_container surface_desc[NVDLA_OP_NUM][NVDLA_NUM_GROUPS];
> +
> +static struct nvdla_task_desc global_task;
> +
> +static struct nvdla_engine engine = {
> +	.processors[NVDLA_OP_BDMA] = {
> +		.name = "BDMA",
> +		.op_type = NVDLA_OP_BDMA,
> +		.program = nvdla_bdma_program,
> +		.enable = nvdla_bdma_enable,
> +		.set_producer = nvdla_bdma_set_producer,
> +		.is_ready = nvdla_bdma_is_ready,
> +		.dump_config = nvdla_bdma_dump_config,
> +		.rdma_check = nvdla_bdma_rdma_check,
> +		.consumer_ptr = 0,
> +		.roi_index = 0,
> +		.group_status = 0,
> +		.rdma_status = 0,
> +		.last_group = 1,
> +		.groups[0] = {
> +			.id = 0,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_BDMA][0],
> +			.surface_desc = &surface_desc[NVDLA_OP_BDMA][0],
> +		},
> +		.groups[1] = {
> +			.id = 1,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_BDMA][1],
> +			.surface_desc = &surface_desc[NVDLA_OP_BDMA][1],
> +		},
> +	},
> +	.processors[NVDLA_OP_CONV] = {
> +		.name = "Convolution",
> +		.op_type = NVDLA_OP_CONV,
> +		.program = nvdla_conv_program,
> +		.enable = nvdla_conv_enable,
> +		.set_producer = nvdla_conv_set_producer,
> +		.is_ready = nvdla_conv_is_ready,
> +		.dump_config = nvdla_conv_dump_config,
> +		.rdma_check = nvdla_conv_rdma_check,
> +		.consumer_ptr = 0,
> +		.roi_index = 0,
> +		.group_status = 0,
> +		.rdma_status = 0,
> +		.last_group = 1,
> +		.groups[0] = {
> +			.id = 0,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_CONV][0],
> +			.surface_desc = &surface_desc[NVDLA_OP_CONV][0],
> +		},
> +		.groups[1] = {
> +			.id = 1,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_CONV][1],
> +			.surface_desc = &surface_desc[NVDLA_OP_CONV][1],
> +		},
> +	},
> +	.processors[NVDLA_OP_SDP] = {
> +		.name = "SDP",
> +		.op_type = NVDLA_OP_SDP,
> +		.program = nvdla_sdp_program,
> +		.enable = nvdla_sdp_enable,
> +		.set_producer = nvdla_sdp_set_producer,
> +		.is_ready = nvdla_sdp_is_ready,
> +		.dump_config = nvdla_sdp_dump_config,
> +		.rdma_check = nvdla_sdp_rdma_check,
> +		.consumer_ptr = 0,
> +		.roi_index = 0,
> +		.group_status = 0,
> +		.rdma_status = 0,
> +		.last_group = 1,
> +		.groups[0] = {
> +			.id = 0,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_SDP][0],
> +			.surface_desc = &surface_desc[NVDLA_OP_SDP][0],
> +		},
> +		.groups[1] = {
> +			.id = 1,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_SDP][1],
> +			.surface_desc = &surface_desc[NVDLA_OP_SDP][1],
> +		},
> +	},
> +	.processors[NVDLA_OP_PDP] = {
> +		.name = "PDP",
> +		.op_type = NVDLA_OP_PDP,
> +		.program = nvdla_pdp_program,
> +		.enable = nvdla_pdp_enable,
> +		.set_producer = nvdla_pdp_set_producer,
> +		.is_ready = nvdla_pdp_is_ready,
> +		.dump_config = nvdla_pdp_dump_config,
> +		.rdma_check = nvdla_pdp_rdma_check,
> +		.consumer_ptr = 0,
> +		.roi_index = 0,
> +		.group_status = 0,
> +		.rdma_status = 0,
> +		.last_group = 1,
> +		.groups[0] = {
> +			.id = 0,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_PDP][0],
> +			.surface_desc = &surface_desc[NVDLA_OP_PDP][0],
> +		},
> +		.groups[1] = {
> +			.id = 1,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_PDP][1],
> +			.surface_desc = &surface_desc[NVDLA_OP_PDP][1],
> +		},
> +	},
> +	.processors[NVDLA_OP_CDP] = {
> +		.name = "CDP",
> +		.op_type = NVDLA_OP_CDP,
> +		.program = nvdla_cdp_program,
> +		.enable = nvdla_cdp_enable,
> +		.set_producer = nvdla_cdp_set_producer,
> +		.is_ready = nvdla_cdp_is_ready,
> +		.dump_config = nvdla_cdp_dump_config,
> +		.rdma_check = nvdla_cdp_rdma_check,
> +		.consumer_ptr = 0,
> +		.roi_index = 0,
> +		.group_status = 0,
> +		.rdma_status = 0,
> +		.last_group = 1,
> +		.groups[0] = {
> +			.id = 0,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_CDP][0],
> +			.surface_desc = &surface_desc[NVDLA_OP_CDP][0],
> +		},
> +		.groups[1] = {
> +			.id = 1,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_CDP][1],
> +			.surface_desc = &surface_desc[NVDLA_OP_CDP][1],
> +		},
> +	},
> +
> +	.processors[NVDLA_OP_RUBIK] = {
> +		.name = "RUBIK",
> +		.op_type = NVDLA_OP_RUBIK,
> +		.program = nvdla_rubik_program,
> +		.enable = nvdla_rubik_enable,
> +		.set_producer = nvdla_rubik_set_producer,
> +		.is_ready = nvdla_rubik_is_ready,
> +		.dump_config = nvdla_rubik_dump_config,
> +		.rdma_check = nvdla_rubik_rdma_check,
> +		.consumer_ptr = 0,
> +		.roi_index = 0,
> +		.group_status = 0,
> +		.rdma_status = 0,
> +		.last_group = 1,
> +		.groups[0] = {
> +			.id = 0,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_RUBIK][0],
> +			.surface_desc = &surface_desc[NVDLA_OP_RUBIK][0],
> +		},
> +		.groups[1] = {
> +			.id = 1,
> +			.rdma_id = 0,
> +			.active = 0,
> +			.events = 0,
> +			.roi_index = 0,
> +			.is_rdma_needed = 0,
> +			.lut_index = -1,
> +			.operation_desc = &operation_desc[NVDLA_OP_RUBIK][1],
> +			.surface_desc = &surface_desc[NVDLA_OP_RUBIK][1],
> +		},
> +	},
> +
> +};

These global variables aren't going to work because Tegra234 (Tegra194's
successor) has two instances of NVDLA. So this data needs to be
allocated dynamically, per instance. It also seems to me like some of
this data could be separated into read-only (i.e. const) and variable
data. For instance none of the function pointers ever seem to change, so
those could be refactored into an "ops" structure and then passed by
pointer into the engines. That might also be useful if we need to make
some of these implementations different on subsequent generations of the
IP.

> +/* driver probe and init */
> +static const struct of_device_id nvdla_of_match[] = {
> +	{
> +		.compatible = "nvidia,nvdla_os_initial",
> +		.data = &nvdla_config_os_initial,
> +	},
> +	{
> +		.compatible = "nvidia,nvdla_2",
> +		.data = &nvdla_config_small,
> +	},
> +	{ },
> +};

Looking at the definition of these configuration structures these seem
to be software configuration variants rather than actually different
hardware blocks. In fact, none of the above seem to be specific to any
particular hardware version.

I would expect these compatible strings to reflect the exact chip that
they can be found in. I.e. for Tegra194 I would expect this to be just:

	"nvidia,tegra194-dla"

And then on Tegra234 it would become:

	"nvidia,tegra234-dla"

at which point the parameterization can happen based on that compatible
string, if we need to.

Also, and I think Peter Robinson already mentioned that, we'll need the
device tree bindings for this as well as device tree changes that create
this device on one of the platforms supported upstream so that we can
test this.

I think in your first version of these patches you had also made a
reference to the userspace driver component that you've used to test
this on. Can you include links to those in the cover letter of
subsequent versions so that people know where to look?

> +
> +static int32_t nvdla_probe(struct platform_device *pdev)

We generally don't use the sized types unless absolutely necessary. So
this (and potentially other occurrences) should just switch to simple
"int".

> +{
> +	int32_t err = 0;
> +	struct resource *res;
> +	struct nvdla_device *nvdla_dev;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +
> +	if (!pdev->dev.of_node)
> +		return -EINVAL;
> +
> +	match = of_match_device(nvdla_of_match, &pdev->dev);
> +	if (!match) {
> +		pr_err("Missing DT entry!\n");
> +		return -EINVAL;
> +	}

There's usually no need for this check. If there was no device tree
entry then the nvdla_probe() function wouldn't have been called.

> +
> +	nvdla_dev = devm_kzalloc(dev, sizeof(*nvdla_dev), GFP_KERNEL);
> +	if (!nvdla_dev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, nvdla_dev);
> +	nvdla_dev->pdev = pdev;

Do we really need the platform device later on? Typically access to the
struct device (i.e. &pdev->dev) is enough.

> +	nvdla_dev->config_data = (struct nvdla_config *)match->data;

You can get this in a single call to of_device_get_match_data(), so you
don't need the extra match local variable.

> +
> +	init_completion(&nvdla_dev->event_notifier);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	nvdla_dev->base = devm_ioremap_resource(&pdev->dev, res);

I think people prefer devm_platform_get_and_ioremap_resource() these
days...

> +	if (IS_ERR(nvdla_dev->base))
> +		return PTR_ERR(nvdla_dev->base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no irq resource\n");
> +		return -EINVAL;
> +	}
> +	nvdla_dev->irq = res->start;

You can use platform_get_irq() here, which makes this a bit simpler.

> +
> +	err = devm_request_irq(&pdev->dev, nvdla_dev->irq,
> +				nvdla_engine_isr, 0,
> +				dev_name(&pdev->dev), nvdla_dev);
> +	if (err)
> +		return err;
> +
> +	nvdla_dev->engine_context = &engine;
> +	engine.task = &global_task;
> +	engine.driver_context = (void *)nvdla_dev;

Why the generic void *? Can't we just store a struct nvdla_device * as
the driver context directly? Do we expect this type to vary?

What I'm missing in this ->probe() function is references to the various
clocks, resets and power gates that need to be controlled in order for
this IP to work. The power gates are typically implemented using generic
power domains, so you can safely ignore those, provided you at least
have them in the device tree, but I think you'd need to at the very
least grab the clocks and resets that this needs. This might work
without them for a while because Tegra194 and later do some hidden magic
with clocks and resets, but for any finer-grained control we'll need
them (for instance, we will want to switch into a low-power state when
no tasks are being processed).

Thierry

> +	engine.task->task_data = NULL;
> +
> +	nvdla_init_op_cache(&engine);
> +	nvdla_clear_task(nvdla_dev->engine_context);
> +
> +	err = nvdla_drm_probe(nvdla_dev);
> +	if (err)
> +		dev_err(&pdev->dev, "failed to register drm device\n");
> +
> +	return err;
> +}
> +
> +static int32_t __exit nvdla_remove(struct platform_device *pdev)
> +{
> +	struct nvdla_device *nvdla_dev = dev_get_drvdata(&pdev->dev);
> +
> +	nvdla_drm_remove(nvdla_dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver nvdla_driver = {
> +	.probe = nvdla_probe,
> +	.remove = __exit_p(nvdla_remove),
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "NVDLA",
> +		.of_match_table = of_match_ptr(nvdla_of_match),
> +	},
> +};
> +module_platform_driver(nvdla_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("Nvidia Deep Learning Accelerator driver");
> +MODULE_IMPORT_NS(DMA_BUF);

--NeDJSlHi0WXVr0SR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJqsDIACgkQ3SOs138+
s6HmWg/9EcAZlER/9uKoCOYwKDhSV9V88PE5ugVxHllVvnFIHalG0eUEV+lKQfeZ
jPwVKwPqJn+URInhbH6QV/8gy4njXcGRT+dS1dx28yXAKEmIINfhKQm0x4jzKp1M
YTMwzjLgU46ovizcia1Jn9LptiGkQvNUYHsxUrAP3tExTvO1+dunuzOmVn6S4h4i
d0I9SqbUadCfKrEmlgwsf+d3cZdKK16Sx7BVtUFjGuMzStV1Sg8YuTBRtsKUgNd1
O6lYTNQxSRGii9iP4TG7n46W2e3WDDKPgxNgKImcvTxarXFrLU7eCKxf6GCD6QuF
OJwmoodBUXnUZaYV6AwQ1D56gWjZsPQF5iSD8mlOThpVkKQ+OtK1f2abo3bv8mUs
UO0458/BJHLJjWmDDfdE9aaRHIBWghrxS0qCzC5wkqO7aPceCVeyLLh9bU/RgdxM
ydJhpAER9L5OI35EByV+ETgQpH0Bm1GICJFggogJGdOrJq35YoNEijLVFBvYu4IE
NWj8hqjLYqw+vn92nwpW6NwxZNvPS/I6SpZK6N7iSkBW5b2cebOPLwtz30FuaEll
QgorOTNXPQPMd9xo3GOfJHXiO4l6CNAkCJWB8TxHSA7dAlEjdc8PDwD5KSjEXZRH
Ra8MTRTEPRQxtKiLVsTy7Zib9Nke0C8qjksaz1iitCiLY+OIMho=
=rzUK
-----END PGP SIGNATURE-----

--NeDJSlHi0WXVr0SR--
