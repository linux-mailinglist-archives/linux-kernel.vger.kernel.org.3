Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E35A54A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH2Tm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Tmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:42:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272FE73336
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:42:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o4so9030976pjp.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DRojyyEkQJaI3ruqXF8PA7dAvzuh8TA99+WmvS2ccKU=;
        b=brVaxPBLPju5jff8Pa4EVeXfGeOA9i5nUT87DXILuVueaT0W9QC8g08MaV43qdMLt0
         xdzv7YPwS6Ej+TFQAZmh8l/6gX8+G2XJ2GzP0H/vZaquWkB6ymcIBxY/Afg1FsytrXzX
         o5gbJ9ODI6Q3IGOXRCjKFqa0TvtZzEMKSXieCKU6tOeXe+8W20B+CHkaQpCfqHKeWBHj
         hHqF7WQhterfKsvpanzDK/PvEUMzp7lxtSeZY8Ps9ZPztTCNtx9XxeZmXL7MACAkuMfe
         wtive/YlA7RDrhk6/jJJ039P2HFEVIXJqhgRx2eF5apskE3YbhKuqGR63DdXcKQvL0E5
         jH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DRojyyEkQJaI3ruqXF8PA7dAvzuh8TA99+WmvS2ccKU=;
        b=JL6Kj9Jr2up5WHExcry+hWOXksOLMHse6n33S9/Uva6sjs5U+YXyWfT+4L8D5mQSHd
         NjcCUx4P1bnwEL5w1S3/1bDdYRfw9OTZiQZnl28rbr5Szj4MhBmzkttry7kjkDZ7J5+g
         TUnMH/O7ukk327fQY3DD1JPxZWWNlmvxMMz/qlbvGPEIfMLtUJL+4sLC5zu78EPd5A9O
         kw18Ru9QZzf771VzOO2jLM9n/VnmYKpPzg8eUccPO0GiTBVeLjqbxMXOpI/S7piymzzO
         0PxYYhLtiF7nFPHauoKKddfk+ZzqBieYjSZoLSyr3lelIrAmFICZee7bHezyPn28Q0Ix
         Os0Q==
X-Gm-Message-State: ACgBeo1+uXu2zEK2fOr77zb28alGhx3lYj0jHQq2PGf0wxGKg5x5vGl5
        koRweZCuyVmYiQNPgDx8lDg4kQ==
X-Google-Smtp-Source: AA6agR73dJ6zqJdEqwSre7rs9UMvyIM4SDNkPl6iDWE7C8VSfpk2HWHFiKxa7FMIROFlJaab1ETldg==
X-Received: by 2002:a17:902:f64f:b0:172:a790:320a with SMTP id m15-20020a170902f64f00b00172a790320amr17692944plg.149.1661802171623;
        Mon, 29 Aug 2022 12:42:51 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b00172f4835f60sm7840088pls.189.2022.08.29.12.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:42:50 -0700 (PDT)
Date:   Mon, 29 Aug 2022 13:42:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        weishunc@google.com
Subject: Re: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the 2nd
 core of dual-core SCP
Message-ID: <20220829194247.GC2264818@p14s>
References: <20220608083553.8697-1-tinghan.shen@mediatek.com>
 <20220608083553.8697-5-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608083553.8697-5-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:35:48PM +0800, Tinghan Shen wrote:
> The mtk_scp.c driver only supports the single core SCP and the
> 1st core of a dual-core SCP. This patch extends it for the 2nd core.
> 
> MT8195 SCP is a dual-core MCU. Both cores are housed in the same subsys.

s/subsys/subsystem

> They have the same viewpoint of registers and memory.
> 
> Core 1 of the SCP features its own set of core configuration registers,
> interrupt controller, timers, and DMAs. The rest of the peripherals
> in this subsystem are shared by core 0 and core 1.
> 
> As for memory, core 1 has its own cache memory. the SCP SRAM is shared

/the/The

> by core 0 and core 1.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 3510c6d0bbc8..91b4aefde4ac 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -23,6 +23,10 @@
>  #define MAX_CODE_SIZE 0x500000
>  #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
>  
> +#define SCP_CORE_0 0
> +#define SCP_CORE_1 1
> +#define SCP_CORE_SINGLE 0xF
> +
>  /**
>   * scp_get() - get a reference to SCP.
>   *
> @@ -836,6 +840,7 @@ static int scp_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	const char *fw_name = "scp.img";
>  	int ret, i;
> +	u32 core_id = SCP_CORE_SINGLE;
>  
>  	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
>  	if (ret < 0 && ret != -EINVAL)
> @@ -851,8 +856,16 @@ static int scp_probe(struct platform_device *pdev)
>  	scp->data = of_device_get_match_data(dev);
>  	platform_set_drvdata(pdev, scp);
>  
> +	ret = of_property_read_u32_index(dev->of_node, "mediatek,scp-core", 1, &core_id);
> +	if (ret == 0)
> +		dev_info(dev, "Boot SCP dual core %u\n", core_id);

Why is the DT property "mediatek,scp-core" needed at all?  Since the compatible
"mediatek,mt8195-scp-dual" has already been defined previously in this patchset,
initialising the second core, if present, is a matter of looking at the
compatile string. 

> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> -	scp->sram_base = devm_ioremap_resource(dev, res);
> +	if (core_id == SCP_CORE_1)
> +		scp->sram_base = devm_ioremap(dev, res->start, resource_size(res));
> +	else
> +		scp->sram_base = devm_ioremap_resource(dev, res);
> +

This looks very broken...  For this to work you would need to have two DT
entries with the "mediatek,mt8195-scp-dual" compatible properly, one with
"mediatek,scp-core = <&scp_dual1 0>;" and another one with "mediatek,scp-core = <&scp_dual0 1>;".

Which is also very broken...  Here you have a binding whose first argument is a
reference to the core sibling while the second argument is a characteristic of
the current core, which is highly confusing.

I suggest what when you see the compatible binding "mediatek,mt8195-scp", a
single core is initialized.  If you see "mediatek,mt8195-scp-dual", both cores
are initialized as part of the _same_ probe.

If the above analysis is not correct it means I misinterpreted your
work and if so, a serious amount of comments is needed _and_ a very detailed
example in "mtk,scp.yaml" that leaves no room for interpretation.

I will stop reviewing this patchset until you have clarified how this works.

Thanks,
Mathieu

>  	if (IS_ERR(scp->sram_base))
>  		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
>  				     "Failed to parse and map sram memory\n");
> @@ -873,7 +886,12 @@ static int scp_probe(struct platform_device *pdev)
>  		scp->l1tcm_phys = res->start;
>  	}
>  
> -	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (core_id == SCP_CORE_1)
> +		scp->reg_base = devm_ioremap(dev, res->start, resource_size(res));
> +	else
> +		scp->reg_base = devm_ioremap_resource(dev, res);
> +
>  	if (IS_ERR(scp->reg_base))
>  		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
>  				     "Failed to parse and map cfg memory\n");
> -- 
> 2.18.0
> 
