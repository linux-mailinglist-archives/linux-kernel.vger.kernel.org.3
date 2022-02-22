Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2074C02CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiBVUG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiBVUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:06:52 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D76F210A;
        Tue, 22 Feb 2022 12:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GZ/WSWgJBiEHXHtoaYeS23vkf3k0hR1lrwLvk6dfqQY=; b=C3sRnNBZ9WphMIrOCeHKtbYK1Z
        4BUp8uWwLjKHugkczVmwkQFLYAx32RzaAOuAsJ6Gh6phWD7HlRwWlnBjafl60VWYMSRz13GuMmPDU
        ltYUt4ur4nth7jHVgdhIDTts6ppa7lV9BiwwJk6cpBlSlCtqLRhiCTkq9MqW3qkbAT8ptGwvr8ffy
        8JylfP3UpLceoAQoW/vFlVrCfa7eqwZ/i3+OMMxXe4FX1bS42h2aeek65DCEnX/kwZUv8RCZw/jbM
        iX6deNsMoWnKQhDtMPcd+mbCnDdiGkv2jR3Z+pgE81jKbbFhMiPc/c4T8RlP/WadtJmyEqcC+ZEyh
        fA1pedyA==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nMbQU-00CR3y-GA; Tue, 22 Feb 2022 20:06:22 +0000
Date:   Tue, 22 Feb 2022 20:06:22 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Multiple addition to ipq8064 dtsi
Message-ID: <YhVCPiBr+aEwQqkG@earth.li>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:29:38AM +0100, Ansuel Smith wrote:
> This try to complete the ipq8064 dtsi and introduce 2 new dtsi
> ipq8064-v2 and ipq8065. While some node are still missing (cpufreq node,
> l2 scale node, fab scale node) this would add most of the missing node
> to make ipq8064 actually usable.
> 
> Some of the changes are the fix for the pci IO that cause any secondary
> wifi card with ath10k to fail init.
> Adds regulators definition for RPM.
> Adds many missing gsbi nodes used by all the devices.
> Enable the usb phy by default as they are actually enabled internally by
> xlate only if the dwc3 driver is used.
> Add opp table and declare idle state for ipq8064.
> Fix some dtc warning.
> 
> This also add the ipq8064-v2.0 dtsi and the ipq8065 dtsi used by more
> recent devices based on this SoC.

A couple of comments directly on 2 patches, but otherwise for the set:

Tested-by: Jonathan McDowell <noodles@earth.li>

> v2:
> - Added missing patch
> - Added additional gsbi6 spi
> - Added extra description for L2 cache opp
> - Fxied smb208 enabled by default that is problematic for rb3011 devices
> 
> Ansuel Smith (18):
>   ARM: dts: qcom: add multiple missing pin definition for ipq8064
>   ARM: dts: qcom: add gsbi6 missing definition for ipq8064
>   ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
>   ARM: dts: qcom: disable smb208 regulators for ipq8064-rb3011
>   ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
>   ARM: dts: qcom: enable usb phy by default for ipq8064
>   ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
>   ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
>   ARM: dts: qcom: add smem node for ipq8064
>   ARM: dts: qcom: add saw for l2 cache and kraitcc for ipq8064
>   ARM: dts: qcom: add sic non secure node for ipq8064
>   ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
>   ARM: dts: qcom: add opp table for cpu and l2 for ipq8064
>   ARM: dts: qcom: add speedbin efuse nvmem binding
>   ARM: dts: qcom: add multiple missing binding for cpu and l2 for
>     ipq8064
>   ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
>   ARM: dts: qcom: add ipq8064-v2.0 dtsi
>   ARM: dts: qcom: add ipq8065 dtsi
> 
>  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  21 +-
>  arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi  |  70 ++++
>  arch/arm/boot/dts/qcom-ipq8064.dtsi       | 375 +++++++++++++++++++++-
>  arch/arm/boot/dts/qcom-ipq8065.dtsi       | 168 ++++++++++
>  4 files changed, 603 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8065.dtsi
> 
> -- 
> 2.34.1
> 

J.

-- 
"evilwm - we sold our souls to the window manager" --
http://www.6809.org.uk/evilwm/
