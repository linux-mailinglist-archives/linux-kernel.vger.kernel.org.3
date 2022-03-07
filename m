Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6984D00A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiCGOD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiCGOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:03:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD7522DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:03:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q14so7894912wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3vpCUXjcTswDRStl3MzweD4Aro2/agAY5dQepL0dC1U=;
        b=x22eO+NgQwSt2pJFQ47yB6UStu1dgm9un5bOnmT6bZT8XT2GQfgdf7n/cAUN21kTtE
         zuI/lQWVM4o93eHQI3j7OhUb81LPWdBQjr7eUPlnEP7joGkCL5gHHr6RaauiKH6OjcK3
         uNh6Q1JpYKKGNcbYFZppkobG57Pz4G9KYjtpO+9AFcAn8EahLZwD12Kkc9ytxErS1x3W
         vC+MrdocY32J/Uh7ZJOcP+6WMPx88ALbewSY5DaYUCSToOoouUedydt1P9OHsCo+6PvO
         mxSE32FQI4pNZFGTAsrR/3AVG46R8gbWeOoAytBnzckd+8ALrO+b6xuMCh9K9FwCb15I
         WOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3vpCUXjcTswDRStl3MzweD4Aro2/agAY5dQepL0dC1U=;
        b=bXLrx/4rBVAmWGaWYxtkNZCkMnAR/zDAQt+Whj3kR3k1rj9fcjn707oEKJ/7EkB8bg
         xC2vBWvjXKiqQNpX1k97OdNwFEfCqTuh72tNdm3h2c7w1N4DXc1/DF4Arp/SBamGRLvG
         Rh3cXRQXj3hHqqAWPX0/1dgvH9qxh4C9qm7ctlHaBFUmifwdDie9iwIbQOqZOKmVJGIJ
         6O7GzOkzgSlXAH6alkIze7a2NhlYw+xvNjsDeqqgdoSZ8g3xuPDTeDztZqqvls3QEgFl
         zKJHeopwgMrUb5LHKhGDoM8eno+0UN6lv3+Rr9R+rwBGW1M9arN2INwM5ESews/DSy2n
         veJA==
X-Gm-Message-State: AOAM531nLw6UBN5OZ39A2VwK9EdcUrpvoKVXB/aNq07dF/lF2SEqSyNo
        Fwnln6xgpru1gg2O5r3AQqi6xQ==
X-Google-Smtp-Source: ABdhPJxmOu4d6SmZt+3tWywr84hP+oV0Bdo1xJ0jXq5SXyxRVfDaE4pjwOF+c2dXu+y0o/So/xiPLA==
X-Received: by 2002:adf:9123:0:b0:1ef:9b6d:60c1 with SMTP id j32-20020adf9123000000b001ef9b6d60c1mr8402184wrj.169.1646661779812;
        Mon, 07 Mar 2022 06:02:59 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm13008346wmh.31.2022.03.07.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:02:59 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:02:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: mfd: brcm,cru: rename pinctrl node
Message-ID: <YiYQkSsHrdbWzfMq@google.com>
References: <20220216112928.5330-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216112928.5330-1-zajec5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022, Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This matches pinctrl.yaml requirement and fixes:
> 
> Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>         From schema: Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/mfd/brcm,cru.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
