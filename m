Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99AE577333
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiGQCq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:27 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8022F19C03
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:26 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10c0d96953fso15597594fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aqrPTFbCcN45C5/PgnZvI7IME29SUOPi1BHAqGX4TKQ=;
        b=AU5rxjwnElbCZX/g86eYKB5ww11EkFqk8fQSA1v+tls3CR0IAy8AYB5dXqWrAQAQbQ
         peXcia3fStSSo2tC4XrALVRhPkP02FfEPWWYWsREX2ejOq4PbTt4yT9gxrcuMJdmWzXc
         /6CcLUp2Qq9FYqWs55gribCQjchHNEMzCGuR03yozebCodyiGIIRMqC1pLQsxhjUhv26
         AKT2GXkA5jFJWmCZEz91BnW8zNrVL5ZMbY7M5Rfkacj53mn+V3nIp8xgah5mdaSAeEls
         lP9YCAMdWd6VMHX+5RnkqIZYcex4gDmHZ3fImUKoCnanZqmtsFqkaQZpwKQ86CAdKrkU
         q/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqrPTFbCcN45C5/PgnZvI7IME29SUOPi1BHAqGX4TKQ=;
        b=A5s8Hl8bMQEeVEdqaWmxR0JZd5BgOEJkqY/CdrMjm6rDNnQ0gR8vD5DYJgwWSI7bIE
         HUW83mdhMGJm4p23gxbvs3mG9/zDWGlyUOghRth/UcCwELr6NZ4tgc8GHZG+LWkStaL9
         CQIv5WjzkoYOVKv1yYb8kMGxGftw+fa0IBNkABjvueYf6Ph6/bKfz+J0bHbo5K8T/Yjv
         fGii5imRsnVVc7zJWTP7jciTbeJUzsqz3JS74gfji0SQkIACq+aZ39FiqUI04t4i6+SX
         +gWBCcRk5LFYtCZl9eZ/wkBgEZoPBnL553ijIleUyUnWmzogvv+mYgS5v1EMYo/vwuv3
         MXcA==
X-Gm-Message-State: AJIora+gahqLVoxp2xQy5ELhZP80kUC2p8kuW/t198LTFvNdVZ0Gjoca
        ZTblvtCGDTtBT4nYVHfXjsiGjQ==
X-Google-Smtp-Source: AGRyM1v+3j7Kq4ZxN9qQMXbnYfewiuvgVE4amerM/sq3toi4pzN7Td2bY2LWptLeUU+GOs0Jr+UmzA==
X-Received: by 2002:a05:6871:299:b0:e1:e1a2:5c65 with SMTP id i25-20020a056871029900b000e1e1a25c65mr10838009oae.190.1658025985813;
        Sat, 16 Jul 2022 19:46:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k10-20020a4ab08a000000b004328ca9498dsm3661540oon.24.2022.07.16.19.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 19:46:25 -0700 (PDT)
Date:   Sat, 16 Jul 2022 21:46:23 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add ipq806x missing bindings
Message-ID: <YtN3/wYKFeAZEsX8@builder.lan>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Jul 20:09 CDT 2022, Christian Marangi wrote:

> This is a respin of "Multiple addition to ipq8064 dtsi" series
> with major changes and some commit removed.
> 
> This series try to add some of the missing bindings for ipq806x.
> 
> This still lacks of the cpu bindings and all the bindings required
> to scale cpu clk or L2. These will come later as the driver and
> documentation require some changes.
> 
> So for now we try to add bindings that can directly applied without
> making changes to any drivers.
> 
> Changes:
> v2:
> - Dropped "add sic non secure node for ipq8064" (no user found)
> - Dropped "add smem node for ipq8064" (require changes to the driver
>   to remove syscon node and use regs directly, will be added in a
>   different series)
> - Dropped "fix dtc warning for missing #address-cells for ipq8064" (
>   doesn't actually fix any warning)
> - Changed "enable usb phy by default for ipq8064" to disable usb phy
>   by default
> - Reworked rpm smb208 declaration to a saparate dtsi
> - Fixed order with compatible-reg-status
> - Squashed "remove redundant binding from ipq8064 rb3011 dts" with
>   "add multiple missing pin definition for ipq8064" to prevent dtc
>   error.
> - Add review tag for snps patch
> 
> Changes from "Multiple addition to ipq8064 dtsi":
> v3:
> - Fix error in rb3011 dts
> - Add tested-by tag on the entire series
> v2:
> - Added missing patch
> - Added additional gsbi6 spi
> - Added extra description for L2 cache opp
> - Fxied smb208 enabled by default that is problematic for rb3011 devices
> 
> Christian Marangi (8):
>   ARM: dts: qcom: add multiple missing pin definition for ipq8064
>   ARM: dts: qcom: add gsbi6 missing definition for ipq8064
>   ARM: dts: qcom: add specific ipq8064 dtsi with smb208 rpm regulators
>   ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
>   ARM: dts: qcom: disable usb phy by default for ipq8064
>   ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
>   ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
>   ARM: dts: qcom: add speedbin efuse nvmem node

Please prefix your ipa8064-specific patches with
  "ARM: dts: qcom: ipq8064: ..."

It makes the git history easier to read, so I fixed it up while applying
these.

Thanks,
Bjorn

> 
>  arch/arm/boot/dts/qcom-ipq8064-ap148.dts   |   6 -
>  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts  |   9 --
>  arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi |  37 +++++
>  arch/arm/boot/dts/qcom-ipq8064.dtsi        | 150 +++++++++++++++++++--
>  4 files changed, 179 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi
> 
> -- 
> 2.36.1
> 
