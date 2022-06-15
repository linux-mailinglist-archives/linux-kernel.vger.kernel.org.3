Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671454D426
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350289AbiFOWCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350313AbiFOWCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:02:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3477562E3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:02:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z14so8459403pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kcScYJXACf2T9Sa4dGBrpIUizywJV+NB+pNeD+jGRj0=;
        b=vZg0V5XGviYMk89uA9Wp1MtlDzkq1rdkPCbOnn1cHvci3xZ0es4PnSo0dWmB+M1xFz
         AJ1mlX9EhMwHmEvQkbmTRdhdPofzKyV4kCsB8Vp9xmz0tp6EKzMze8LKFwNXVWS98J9R
         88hOcBSRLHEQY4JNTD9ugK9VeZfTCiLLBIzx2jnOn4aNioJOhEqLs405WbeKDN44TsJ0
         8tsh6G61OeovlN3mYKiOpiCEOTCHwSADGEyWuPTRZ3wIY+OI6Pj/4A7B+ZLX0pSwO4D+
         e4fY6e0DzRVikaE0hjnTbh7jgt7cjUBxZtnrOvXH4EkTrIKfKOW9IkvroRX6YuG367eI
         Xdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kcScYJXACf2T9Sa4dGBrpIUizywJV+NB+pNeD+jGRj0=;
        b=tqDOHEL0YXmWA74lQpXiFLTj+dm9m+6dExdVnq/CVKvCFmcmT0CyHMQ8fuNulmrMSD
         CVlhZyXIxsEGY8wBS4L/VUfa0FCGAulrT27pNGNe2+525rNc0qxacN/KC1I+LaHaqpQh
         ogbviCPTrheECr0lvY3CtK4XncpOilQXZ6RatsNKqCdSGlo6VBfcHZ97mbb1opBWZhYX
         1aSl2cj44aCJEgGM9hTjdNd3DQzLUDApSw69GtlN3waX5e/sRoxQwCwzFrlBLcmicMts
         Y2feC8G37qIsFuYAwCOQLHfnoM27BY8Naq6O7wuQgNGX3iN6LLNr4u+iixLkC9QnZQX/
         dbjQ==
X-Gm-Message-State: AJIora9ty4lJSNEKG+mwc6T05Wrpn2BqkRQ0B71tFu8JlfDWb25BRwBc
        s/Z9tYZ6kg/dkPdG0TMcx9N3ng==
X-Google-Smtp-Source: AGRyM1vAu+j0mmpvKehwZsnqXWna7Wp2yP3aY01hL+X0jvE+4s7/feJd4/rbNQjAAV4okSJFwzqbpw==
X-Received: by 2002:a65:6a05:0:b0:3db:27cb:9123 with SMTP id m5-20020a656a05000000b003db27cb9123mr1603825pgu.497.1655330538113;
        Wed, 15 Jun 2022 15:02:18 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p11-20020a170903248b00b00161ac982b52sm121873plw.95.2022.06.15.15.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:02:17 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:02:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        henryc.chen@mediatek.com, johnson.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: mfd: Add compatible for MT6331 PMIC
Message-ID: <YqpW56+bntMonulO@google.com>
References: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
 <20220520124039.228314-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520124039.228314-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022, AngeloGioacchino Del Regno wrote:

> Add a compatible for the MT6331 PMIC MFD device.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
