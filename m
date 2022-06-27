Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9496455D4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiF0LxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiF0Ls1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:48:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84B101C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:41:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r20so12682290wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XGLjigKahLIbEiIjs4vb9AiZqSJH2kvHBxMmjbNszGQ=;
        b=aPvmFznj7yqy4vj7LQLlbbcOIzC9aADXBp0AZlgIo456NCt8eVi6q37s5G+UG6Iigm
         9iY7kl9/Mq2qyMAK3FgNVLrJ6oiNEeBtvY431Q0iuqZIUYR0lSTG+VhgSDRM9bc7ZOwI
         nazBwO094kgX/wWej7vNXtwHePuuulFp46SC7Xif4L7pR+BmyneLm+h656KBMtrqAXHN
         eZMaLz3fYaWmtX/DFKq13ZM9PQtYu/F5iMSJJgNgcG9tgD10XAl6Po+wAZIr01kQkSev
         osJenA2uOk/VHO2aYlLGGMs7IwgYseZB3BeP32J5XhOlIdOItPsOT8/nQ5eZufUuRDC4
         pD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XGLjigKahLIbEiIjs4vb9AiZqSJH2kvHBxMmjbNszGQ=;
        b=yFuQwVVihF8MCdc9oC8OsFKBSd7sjw6aAvvFkpehoya3S8hLgRIm0srfgq8FSvZFJw
         qc7GPpyAHyB1w2XPDICAIbDeNUm6UJ5sJvZKtlMZ+2aBO0rZZKoG3FIM80yylOZ7QYQE
         xbVJ+2q7kkoDK5eRujcwKuhUr6HlXk1Eq+eGGmCt5Nv13QUjY9QobmmVGQaoBNN4JYNS
         gBYNHo5TQZ/NzHOydLlNZ/WEb5F8HWFLhRB28VmuoVYWz2sPFYHrrGCgioO9P1iu1O/o
         XGOPU4cRbJZWm+ZlMUMx/djz+Du8RS93YLI9tw6vfXGHroo7JLWU7e+W5fk8XVo8/m+/
         U3rA==
X-Gm-Message-State: AJIora9v2mLFfj0uFC6bqSaUCmoJaTW6GDTWtgOX8dSGUqet+qpiSNin
        9qs/utgnBSRmKF1Zw1BczNXy5g==
X-Google-Smtp-Source: AGRyM1tano6gA3YQd1oWYRrXYlajjDR3D5/RPCRCXOlsa7JV+jUhPYwOBPQeaAZ+HX6xShSm0p7Hxg==
X-Received: by 2002:adf:dbc1:0:b0:219:e994:6ba7 with SMTP id e1-20020adfdbc1000000b00219e9946ba7mr11742596wrj.229.1656330090193;
        Mon, 27 Jun 2022 04:41:30 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m12-20020adffe4c000000b0020d106c0386sm10066389wrs.89.2022.06.27.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:41:29 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:41:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: mt6397: Add compatibles for
 MT6331 RTC and keys
Message-ID: <YrmXZyNHNrHtzOUC@google.com>
References: <20220617110728.90132-1-angelogioacchino.delregno@collabora.com>
 <20220617110728.90132-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617110728.90132-2-angelogioacchino.delregno@collabora.com>
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

> The MT6331 PMIC provides many sub modules: regulators, audio
> codec, LED controller, keys, RTC and some GPIOs.
> It is always paired with a MT6332 Companion PMIC, which provides
> thermistors, WLEDs (display LED backlight), secondary AP cluster
> regulators, modem clocks, battery charger and fuel gauge.
> 
> Add the necessary compatibles to start implementing the basics.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
