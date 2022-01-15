Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5048F81E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiAORCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:02:23 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51710
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbiAORCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:02:23 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E79EA402A8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642266141;
        bh=9dVm/8o0muM3PlhFgyKWOrYMTMJFIcsJEfbMuoyWqC0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tTZR/Q848j9GJPdA387PM9nhX/RzqmeTuegdIsxcpX21YrG5YQunmcS4bwpZl4mVE
         T8BTVJsrs7d5Hjg++utMx7MrjY77JWwsKG4pHbbaDf2FB3+0t4OHfaO/kR9JlVMX97
         5QPOpxxjS/FPwqCnxj5YlTQ00iOEBAU4NQyeKfHxmItPDojC34KyK9+odI/wguILEK
         dRx6se288ugDawTd2pkbHHOGdzRLEfiWVEtcnXtbakFQkaCVbHg3VFjQHz1DwvITqg
         /RIFfV8i7vjgrnJHaqGLFW2V1com3dzuH/rtmwtnT+Jf5+1b3EzKcuA0ssGX0UN2Mb
         CfvAfiHYiZmZQ==
Received: by mail-wm1-f70.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso7634510wmb.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 09:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9dVm/8o0muM3PlhFgyKWOrYMTMJFIcsJEfbMuoyWqC0=;
        b=Ud4pf0vQQdfhOtqIgvRkMGRGzJuSlXIaKZCsgNWqHUyndwSB8PbJKh7qp31ReQdb4x
         YcsspbPf6e8OgN59IvGlRuxOVTDEmKaRxXCKGsh8OMvEyRkRp/Drwfs+/jsNbZ6ZxB9q
         RFCz0Z3PHJkILPFMFtno5y8lOwtekyB5OIE23jEVuUMNsaXYe+BvcM6N9k68jphjVMXa
         i+Y8Dr0B0mjMaHTZJZv+JlVfRMGgUN5IbqnrWeCZbXRFSBObopY2W99AphDGTz6a1ECN
         DtzDDMfbQzt+LTsGWEus9zGYXPjdVn6wrM6OSBwYnNt69Av7nT9zzqBgzJ+NEfuF9Aab
         d6dA==
X-Gm-Message-State: AOAM532wmN3ghYlkw2FfRZIcV/sWmIpRdbWvMRGtCZjxyu7QOBLwZPFr
        u1CeeoQqRkkO9kbEtNEGf6rqoOpwqtmiwj1efYiVGxne8dOgqpkZZmad7Mt9Lg3ahhNMCpZFN07
        5wZdE8dJWLGxXCXVEsk8bFXfDNnTEW6r1HiDLk7bE5g==
X-Received: by 2002:adf:c74e:: with SMTP id b14mr12904046wrh.97.1642266140381;
        Sat, 15 Jan 2022 09:02:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWvA8ccWFDFUx+F94uUg6e/GEZRpHKh+A0j/XSiKLQ/f4YHoAW3x8lfNMEqweZDdp3OlxzfA==
X-Received: by 2002:adf:c74e:: with SMTP id b14mr12904022wrh.97.1642266140208;
        Sat, 15 Jan 2022 09:02:20 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a18sm8711256wrf.42.2022.01.15.09.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 09:02:19 -0800 (PST)
Message-ID: <060a9f66-fc00-2247-46f2-1c700d0e9bf3@canonical.com>
Date:   Sat, 15 Jan 2022 18:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 05/11] arm64: defconfig: rebuild default configuration
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-6-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220114141507.395271-6-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 15:15, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Run "make defconfig; make savedefconfig" to rebuild defconfig.
> 
> This re-ordered the following configuration options:
> 
> CONFIG_BPF_JIT=y
> CONFIG_ARM_SCMI_PROTOCOL=y
> CONFIG_ARM_SCPI_PROTOCOL=y
> CONFIG_RASPBERRYPI_FIRMWARE=y
> CONFIG_INTEL_STRATIX10_SERVICE=y
> CONFIG_INTEL_STRATIX10_RSU=m
> CONFIG_EFI_CAPSULE_LOADER=y
> CONFIG_IMX_SCU=y
> CONFIG_IMX_SCU_PD=y
> CONFIG_CAN_FLEXCAN=m
> CONFIG_PCIE_LAYERSCAPE_GEN4=y
> CONFIG_MTK_DEVAPC=m
> CONFIG_SPI_CADENCE_QUADSPI=y
> CONFIG_MDIO_BUS_MUX_MMIOREG=y
> CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
> CONFIG_MESON_GXL_PHY=m
> CONFIG_QCOM_CPR=y
> CONFIG_ROCKCHIP_IODOMAIN=y
> CONFIG_SENSORS_ARM_SCMI=y
> CONFIG_QORIQ_THERMAL=m
> CONFIG_SUN8I_THERMAL=y
> CONFIG_TEGRA_BPMP_THERMAL=m
> CONFIG_ARM_SMC_WATCHDOG=y
> CONFIG_VIDEO_QCOM_CAMSS=m
> CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
> CONFIG_DRM_NWL_MIPI_DSI=m
> CONFIG_DRM_LONTIUM_LT9611UXC=m
> CONFIG_SND_SOC_IMX_AUDMIX=m
> CONFIG_TYPEC_HD3SS3220=m
> CONFIG_COMMON_CLK_SCMI=y
> CONFIG_IPQ_GCC_8074=y
> CONFIG_SM_DISPCC_8250=y
> CONFIG_QCOM_WCNSS_CTRL=m
> CONFIG_ARCH_R8A774A1=y
> CONFIG_ARCH_R8A774B1=y
> CONFIG_ARCH_R8A774C0=y
> CONFIG_ARCH_R8A774E1=y
> CONFIG_ARCH_R8A77995=y
> CONFIG_ARCH_R8A77990=y
> CONFIG_ARCH_R8A77965=y
> CONFIG_ARCH_R8A77970=y
> CONFIG_HISI_PMU=y
> CONFIG_QCOM_QFPROM=y
> CONFIG_MUX_MMIO=y

Thanks for the changes.
The best would be to have a separate patch only for re-ordering.

> 
> And dropped the following configuration options which are nowaday's
> already enabled (resp. disabled) by default:
> 
> CONFIG_MEMCG_SWAP=y
> CONFIG_SECCOMP=y

Is it? I tried now on next-20220114 and it is still user-selectable and
not chosen by anything.

> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> CONFIG_QCOM_SCM=y
> # CONFIG_BT_HS is not set
> CONFIG_FSL_MC_BUS=y
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> CONFIG_SND_SOC_FSL_SAI=m
> CONFIG_USB_CONN_GPIO=m
> CONFIG_USB_XHCI_PCI=m
> CONFIG_MFD_CROS_EC_DEV=y
> CONFIG_COMMON_CLK_ZYNQMP=y
> CONFIG_SDM_GCC_845=y
> CONFIG_SM_GCC_8150=y
> CONFIG_SM_GCC_8250=y
> CONFIG_SLIMBUS=m
> CONFIG_INTERCONNECT=y
> CONFIG_CONFIGFS_FS=y

All three above are still user-selectable, so please leave them. It is
redundant, but there is no guarantee that something selecting a
user-visible symbol will stop selecting it. IOW, user-visible symbols
should be still chosen by defconfigs if they really want them.

See for example commit a2315d3aea59 ("ARM: exynos_defconfig: Restore
debugfs support") for rationale why we need to keep them.


Best regards,
Krzysztof
