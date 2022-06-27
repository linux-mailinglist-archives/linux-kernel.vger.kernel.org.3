Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3586C55CA00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiF0MBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbiF0Lw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:52:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53CDF46
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:47:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k22so12667729wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DNfZf1ALusxNZItYPzLBSfgjkhIQRGT+paZKIzAlEKg=;
        b=sV0flEb6e8vzBIQcGxl/RLcS74O4Nx86dAcc93mn8FPtVTw4L5J2j0DXwIo4b1jLiO
         TXHVeiIcfQZLyRgCwf+yZPOodVlfqP7U2xrt+TCXRZ+nxCfubcoofsr285ENaoFYiLrN
         yo6kSYEVQvXzaisFGfYxVAMk6fdCXNeTqKrUclCUe1cKod1balAyTsQTFW1Sruvgjn3U
         IFQxkz9S5+LvuuIYFxHS7wfyALzJolDZGfzDPYieb8saBvE7lAZGOy/5K1saLTZBAzr5
         E/GzyemEfHqv9Eq0lkfWGAuM5iwXChMCfoShbooumaD06p/179duedibRQra51wMX1bb
         SvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DNfZf1ALusxNZItYPzLBSfgjkhIQRGT+paZKIzAlEKg=;
        b=5gnxPDx0Mp5VAvcS/32VSM30Jp7o0y40/w1pOtbUpMScwcf0Nt3BSOPnxnNBjgl/pf
         SwwlrfYyKuAZa8Iz2tvg1wc+v5VOkB+BqeoXYDomZ9OvQRkCTKE6zlBdgg81JLAV/LXD
         jNulAnrHkcbDslKcPJeVGRhsmHuFfpVMvJ2VPUCpUdaypuWk5wnpvyjmnMAxcPmb3Ooz
         wzqF9a4EFEWSd5/oPucHIVkC8iIN41KsqTccOwnCYqkC7hXfjKgfIh7pEoEx1yeZrXWU
         MMfSMaurb8k2NFCLFsGZCBPZHfvV7U1K1g/cV2SwEuMpurYkgpluHNMP09EEFo+2+DbO
         EaQQ==
X-Gm-Message-State: AJIora9cvNOiGFpasWP//r4Urz2A5FPyh4U34D+ptKOjRie7ydEJE8yB
        AU2ZXzdqRmUncnkxCTp9R5pd1g==
X-Google-Smtp-Source: AGRyM1v/Irv5206u/VfQLtfpPzA9fr8PJqMfZhF2phPpC4wOEt4/o9BLlBG0Ze4sOEA0d8pg3/fEhg==
X-Received: by 2002:a5d:64a3:0:b0:21b:b86f:e9cc with SMTP id m3-20020a5d64a3000000b0021bb86fe9ccmr11701408wrp.156.1656330428099;
        Mon, 27 Jun 2022 04:47:08 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t10-20020adfe10a000000b00210320d9fbfsm12218547wrz.18.2022.06.27.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:47:07 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:47:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: mt6397: Add basic support for MT6331+MT6332
 PMIC
Message-ID: <YrmYuRy2ZgIw21JX@google.com>
References: <20220617110728.90132-1-angelogioacchino.delregno@collabora.com>
 <20220617110728.90132-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617110728.90132-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022, AngeloGioacchino Del Regno wrote:

> Add support for the MT6331 PMIC with MT6332 Companion PMIC, found
> in MT6795 Helio X10 smartphone platforms.
> 
> This combo has support for multiple devices but, for a start,
> only the following have been implemented:
> - Regulators (two instances, one in MT6331, one in MT6332)
> - RTC (MT6331)
> - Keys (MT6331)
> - Interrupts (MT6331 also dispatches MT6332's interrupts)
> 
> There's more to be implemented, especially for MT6332, which
> will come at a later stage.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/mt6397-core.c            |  47 ++
>  drivers/mfd/mt6397-irq.c             |   9 +-
>  include/linux/mfd/mt6331/core.h      |  40 ++
>  include/linux/mfd/mt6331/registers.h | 584 ++++++++++++++++++++++++
>  include/linux/mfd/mt6332/core.h      |  65 +++
>  include/linux/mfd/mt6332/registers.h | 642 +++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   2 +
>  7 files changed, 1388 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/mfd/mt6331/core.h
>  create mode 100644 include/linux/mfd/mt6331/registers.h
>  create mode 100644 include/linux/mfd/mt6332/core.h
>  create mode 100644 include/linux/mfd/mt6332/registers.h

Does not apply.  Please rebase.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
