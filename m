Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44586490903
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiAQMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:49:23 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42476
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229983AbiAQMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:49:22 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA3C63F1E1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642423760;
        bh=1Bqg5LT0Q9PIQpro86rbyCJ3sdGQT0IFQQvcsmRkkzo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DRXdNYBhrtJ3c/Q9ZdM8j4HVtFzDzf3QJMmrjsLogdXUDx1rHER1OwkwjVNx2s1QJ
         relIHpbr9gBR/qcsHRX8YxjVTaQLIhJfC3oZNcJHm0GPspK4TnBUl+U8155saZgbWy
         GCUOZLYVCf2e7g6K+qDwAzbye/MMsuQ2TEwdEW5nukD1TzEc3kIAFTw0ctVqaDiJoC
         /VCeoOrj+UyJ90QtbHILlxstGNLKM/CBSzlus7iE231I31E+dfBz62rst7XZhY5W3f
         jzZTo6eee45UsPwWhM/93Go1IUUwDPMkdNTWgyJDAfWFToXHMqGhO5hbi6ngFliRVI
         NhPzj/VUYaXiA==
Received: by mail-ed1-f71.google.com with SMTP id o10-20020a056402438a00b00403212b6b1aso1021137edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Bqg5LT0Q9PIQpro86rbyCJ3sdGQT0IFQQvcsmRkkzo=;
        b=xnDi1b3K9bGJGEXzY1eYlabPc37A8EZa7A/so5cCBgBr2gtNFrwbU7JcRZ41W1YGrN
         f6w37kh5Hvzo9hJpU5DIU2ZS4vSAz1je0n94Du34NzEA33Vf4lVkDYKQmVQzvRqpTiza
         5WU6+cs4YqWmn/+1y1JpNddjICPChuFJQigwYqQrbKt6mnLXcyo7twThXSRWNptdvjD0
         vB1Q5gcFK1+pgEh/uQIyqvTxi9lF9Z9BSqFmqHTuzrrpJiV9NEm9XnIVXlmkgJIF5MBX
         +rXo2uCD96bWvEbphieDJ2Gh1knjIHgeivikHdX2Afp/RuQDy4TS/ZNp0I+iYn+JU3O5
         EVfQ==
X-Gm-Message-State: AOAM531qB99bcjmPi6m+NySeJAzzSKNOux576TjJ7WW40NbXcCo7XnsJ
        rKJyr6lwAkZp4QTk3X43i/LG58jEDVc+8VB38NvLBQt8ENl9f/g5bRPHYfTNAtWdLUfa9tni1AP
        ryBS3Y42A4IX75DVVJxtVCRyFXvcMFoJmHPG7uvnL/Q==
X-Received: by 2002:a50:cd17:: with SMTP id z23mr20740235edi.287.1642423760448;
        Mon, 17 Jan 2022 04:49:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv0R1xW2vvLyW4bcyIeeKVHKqXb3hBGVa439g6FmRIEdA6+QXMF3VfQxQl0T9FEXxDspDOAQ==
X-Received: by 2002:a50:cd17:: with SMTP id z23mr20740217edi.287.1642423760231;
        Mon, 17 Jan 2022 04:49:20 -0800 (PST)
Received: from [192.168.0.37] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ee45sm1519601edb.83.2022.01.17.04.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 04:49:19 -0800 (PST)
Message-ID: <e441ee41-485f-b940-76f0-886d2f3ca942@canonical.com>
Date:   Mon, 17 Jan 2022 13:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 05/11] arm64: defconfig: rebuild default configuration
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-6-marcel@ziswiler.com>
 <060a9f66-fc00-2247-46f2-1c700d0e9bf3@canonical.com>
 <a5cfdd2ea149490abeb481c7a85d59019ea3c620.camel@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <a5cfdd2ea149490abeb481c7a85d59019ea3c620.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 13:05, Marcel Ziswiler wrote:
> On Sat, 2022-01-15 at 18:02 +0100, Krzysztof Kozlowski wrote:
>> On 14/01/2022 15:15, Marcel Ziswiler wrote:
>>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> Run "make defconfig; make savedefconfig" to rebuild defconfig.
>>>
>>> This re-ordered the following configuration options:
>>>
>>> CONFIG_BPF_JIT=y
>>> CONFIG_ARM_SCMI_PROTOCOL=y
>>> CONFIG_ARM_SCPI_PROTOCOL=y
>>> CONFIG_RASPBERRYPI_FIRMWARE=y
>>> CONFIG_INTEL_STRATIX10_SERVICE=y
>>> CONFIG_INTEL_STRATIX10_RSU=m
>>> CONFIG_EFI_CAPSULE_LOADER=y
>>> CONFIG_IMX_SCU=y
>>> CONFIG_IMX_SCU_PD=y
>>> CONFIG_CAN_FLEXCAN=m
>>> CONFIG_PCIE_LAYERSCAPE_GEN4=y
>>> CONFIG_MTK_DEVAPC=m
>>> CONFIG_SPI_CADENCE_QUADSPI=y
>>> CONFIG_MDIO_BUS_MUX_MMIOREG=y
>>> CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
>>> CONFIG_MESON_GXL_PHY=m
>>> CONFIG_QCOM_CPR=y
>>> CONFIG_ROCKCHIP_IODOMAIN=y
>>> CONFIG_SENSORS_ARM_SCMI=y
>>> CONFIG_QORIQ_THERMAL=m
>>> CONFIG_SUN8I_THERMAL=y
>>> CONFIG_TEGRA_BPMP_THERMAL=m
>>> CONFIG_ARM_SMC_WATCHDOG=y
>>> CONFIG_VIDEO_QCOM_CAMSS=m
>>> CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
>>> CONFIG_DRM_NWL_MIPI_DSI=m
>>> CONFIG_DRM_LONTIUM_LT9611UXC=m
>>> CONFIG_SND_SOC_IMX_AUDMIX=m
>>> CONFIG_TYPEC_HD3SS3220=m
>>> CONFIG_COMMON_CLK_SCMI=y
>>> CONFIG_IPQ_GCC_8074=y
>>> CONFIG_SM_DISPCC_8250=y
>>> CONFIG_QCOM_WCNSS_CTRL=m
>>> CONFIG_ARCH_R8A774A1=y
>>> CONFIG_ARCH_R8A774B1=y
>>> CONFIG_ARCH_R8A774C0=y
>>> CONFIG_ARCH_R8A774E1=y
>>> CONFIG_ARCH_R8A77995=y
>>> CONFIG_ARCH_R8A77990=y
>>> CONFIG_ARCH_R8A77965=y
>>> CONFIG_ARCH_R8A77970=y
>>> CONFIG_HISI_PMU=y
>>> CONFIG_QCOM_QFPROM=y
>>> CONFIG_MUX_MMIO=y
>>
>> Thanks for the changes.
>> The best would be to have a separate patch only for re-ordering.
> 
> Yes, from a review perspective that makes sense. Will do so in v3.
> 
>>> And dropped the following configuration options which are nowaday's
>>> already enabled (resp. disabled) by default:
>>>
>>> CONFIG_MEMCG_SWAP=y
>>> CONFIG_SECCOMP=y
>>
>> Is it? I tried now on next-20220114 and it is still user-selectable and
>> not chosen by anything.
> 
> Hm, strange. I guess, it is due to this whole patch series, given its i.MX main focus, being based on Shawn's
> for-next branch. Maybe for such defconfig changes it would be better to base them on something else? Not sure,
> who will ultimately pull such changes. Any suggestion?

I don't think there is a one nice solution, fit-for-all.

Consider a defconfig selecting FOO and BAR, plus Kconfig like:
config FOO
	depends on BAR

If you run savedefconfig on arm-soc next branch, there is a chance that
in parallel someone else will adjust the Kconfig in some other tree,
based on Linus' master. That person removes "depends on BAR" above and
notices that FOO is mentioned in defconfig, so no need to update defconfig.

However your savedefconfig commit will exactly remove the FOO from
defconfig, because there is no reason for it to be. After merging to
Linus - FOO is gone from defconfig.

Another approach - you base your savedefconfig on linux-next. This
should solve the problem above, except that such commit might not apply
on the maintainer's tree.

Therefore recommendation is to not run savedefconfig or run it very
carefully, for example explaining why each option is being removed. I
was doing it in the past, but it's quite time consuming:

https://lore.kernel.org/linux-arm-kernel/1500270596-22384-1-git-send-email-krzk@kernel.org/

and earlier set:
https://lore.kernel.org/linux-arm-kernel/20170608161049.12421-1-krzk@kernel.org/

> 
>>> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>>> CONFIG_QCOM_SCM=y
>>> # CONFIG_BT_HS is not set
>>> CONFIG_FSL_MC_BUS=y
>>> CONFIG_MEDIA_CONTROLLER=y
>>> CONFIG_VIDEO_V4L2_SUBDEV_API=y
>>> CONFIG_SND_SOC_FSL_SAI=m
>>> CONFIG_USB_CONN_GPIO=m
>>> CONFIG_USB_XHCI_PCI=m
>>> CONFIG_MFD_CROS_EC_DEV=y
>>> CONFIG_COMMON_CLK_ZYNQMP=y
>>> CONFIG_SDM_GCC_845=y
>>> CONFIG_SM_GCC_8150=y
>>> CONFIG_SM_GCC_8250=y
>>> CONFIG_SLIMBUS=m
>>> CONFIG_INTERCONNECT=y
>>> CONFIG_CONFIGFS_FS=y
>>
>> All three above are still user-selectable, so please leave them. It is
>> redundant, but there is no guarantee that something selecting a
>> user-visible symbol will stop selecting it. IOW, user-visible symbols
>> should be still chosen by defconfigs if they really want them.
> 
> Well, but even if they are already enabled anyway? What is the point of savedefconfig then resp. you are saying
> that the commited defconfigs should not be generated using savedefconfig? That sounds rather confusing to me.

Yes, it's confusing. savedefconfig is too aggressive - it strips
everything which is not strictly necessary now. However there is no
guarantee that current select of some option, thus stripped out that
option via savedefconfig, will stay there forever.

If CONFIG_XXX is not user-selectable, then when someone removes the
"select XXX", it *is expected* to modify the defconfigs to add back this
XXX.

However it turns out that some developers assume that there is no such
requirement of re-adding XXX to defconfig, if XXX was user-selectable in
the first place.


> 
>> See for example commit a2315d3aea59 ("ARM: exynos_defconfig: Restore
>> debugfs support") for rationale why we need to keep them.
> 
> Okay, I see what you mean as in relation to above mentioned commit but then any change to Kconfig dependencies
> can ultimately change the behaviour of previous configs unless they are complete ones (or were just lucky to
> include whatever stuff that changed). But how should one now know which of them zillions of user-selectable
> options should be added to such "more robust" defconfigs?

No clue... :) Except maybe do not remove existing ones.

> 
> I suggest a better approach might be to have some CI which validates defconfig changes. That way one could
> easily track stuff disappearing and could at that point explicitly enable it again.

Yes, that makes sense. One defines the expected symbols to have and CI
validates whether they are enabled. We have something like this (called
annotations) in our Ubuntu configs - we store a list of config options
were are interested in and detect when they change.

Another approach is to use specialized fragments.

The benefits of such solutions is that they also document why such
option was chosen in the first place (what I was also asking from your
patches here at beginning and thanks for fixing this).

Best regards,
Krzysztof
