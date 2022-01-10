Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E96489670
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbiAJKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243956AbiAJKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:33:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:33:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t28so19061218wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ux09BdvBfy5otBeH83si9wqeKjp8gHNJ9Zt3Er9zFxE=;
        b=uXYTgRqNTmPW/huo6KEYGPOM4ISUhPLQBff/OQu1mryKVB8bfEA9SMGpAzs8WENMSr
         fuyNQuevmAkNaM1DIBs9B5ePOxvg6kIQUNCfH4GFaXO0BAGjC6GgZqB5Fa+1alU087Z8
         P+Vm7f+/pCXvExKs6et7iTpYsEWdwEv98+Oj1Ut/3CLURBSYQn8BBRcI2i4huO0Nyhig
         jAh0PzBKkTaun4SPlD9rbsylUIDBnG5CqjHmWput0432gybnuR4m4QvkFs0RSDDvlb27
         XDCH8P8FAS/PXCOIbQZcLNaqtzSULbKkPi6r/pLPsz//6OCjXG/9tpB7zbwtR5B9wtSf
         7hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ux09BdvBfy5otBeH83si9wqeKjp8gHNJ9Zt3Er9zFxE=;
        b=WF/m1eD3rfWid3A0i1avCa3QwuhSfJA17I3Xj034YQRRl+Xxc+Riv9l+iIOiQv8cuA
         Hrs2egJ0KamW/CR+GEm02Bbh6ojfRB/IEQV2gv7CPXbejOypRcpMYRDWcHeK5s244Ndg
         DSeTkb5kUMTopFL+xuQ2gnfu3fY+Ob7fEQD3fImUVYT7psmTfjQjwn4ZntgllxolJeIC
         rFPZt+056d3dRpJCu60EUnjgeLIOUjxe5Qal/vJcYnhwT70+7ba8Lxy5XTmKsKuCLH8i
         0UN7w0GkqSLJOb5wRwbw3uyCYEu4c3vgxfixS5Xbx1hYNZpQxcU1WSZqsbW/WHt42do8
         IAtA==
X-Gm-Message-State: AOAM532p+9FmBJFUBCb1HarUbsBLXQLl/y3si4aXy1bzyNECjOOe4pyB
        1qJ03tR7jXS7dTOBM9W+n9t6aQ==
X-Google-Smtp-Source: ABdhPJzMfF4X4m8rqBSMupPmJ6wMSv1HcNXmy8LWfHPif6guaPAHOVr+QYANksWrPaZREcLyZVwvuQ==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr63672846wrq.273.1641810799760;
        Mon, 10 Jan 2022 02:33:19 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id ba18sm6324269wrb.40.2022.01.10.02.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 02:33:19 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:33:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suman Anna <s-anna@ti.com>, - <patches@opensource.cirrus.com>,
        John Crispin <john@phrozen.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Drop required 'interrupt-parent'
Message-ID: <YdwLc2ZTERBoXgxR@google.com>
References: <20220107031905.2406176-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107031905.2406176-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022, Rob Herring wrote:

> 'interrupt-parent' is never required as it can be in a parent node or a
> parent node itself can be an interrupt provider. Where exactly it lives is
> outside the scope of a binding schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/gpio/toshiba,gpio-visconti.yaml  | 1 -
>  .../devicetree/bindings/mailbox/ti,omap-mailbox.yaml     | 9 ---------
>  Documentation/devicetree/bindings/mfd/cirrus,madera.yaml | 1 -

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/net/lantiq,etop-xway.yaml        | 1 -
>  .../devicetree/bindings/net/lantiq,xrx200-net.yaml       | 1 -
>  .../devicetree/bindings/pci/sifive,fu740-pcie.yaml       | 1 -
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml       | 1 -
>  7 files changed, 15 deletions(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
