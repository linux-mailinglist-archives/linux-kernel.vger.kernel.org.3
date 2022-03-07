Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C654CF66F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiCGJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbiCGJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:29:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E778566FB6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:27:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so8877771wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hp3SeZFWmub3b8Uot9WP9rF1cg01r3I7Zi8sapbnSWo=;
        b=kKfjp1eqSohCfYGRAjKLMCiz+l29EkuL/ImQ+pL+yY0Ljn4E06xEKARMidDFgj7r75
         +Q+yLAR047ZmMF6jxB3RmR3WQpebEcxR16+k/+PGz5UweOHMbtz95MfagivNjns5kyMw
         tO24rg14v9zSZDRe7Wwh2nlv/Kc75cmw/ppIwhXHO8Bk/pqd+xNP9Zh4jc2gDSG0PaEl
         pViQvnBYQsyisfNasnjMjS7Tvfty0t0tgj0vOX1sFLmm1eXCQjMAHVx/gXOje1L97mLq
         +cJLvwA1prPivUQWN1byXbjAxupa99mx2BRdgBA/55+pveoyfMDLiKyQa6jxam6gSnts
         6c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hp3SeZFWmub3b8Uot9WP9rF1cg01r3I7Zi8sapbnSWo=;
        b=09VslCMyxRQBRUwuy9k2N7EnQjuobScxyME9pIY5ppia7os94A6oLLWpEWfKWOhqFg
         1oVhxvz0e5+kKx0wOGl49Gto6/7geZKgmTMQ9Y5jnNPGYmEZy13FXN7G8hB7Vz4RMSCH
         K6clc/i1kHhVTSS7tCqQydxlGavn/1gvEqXzW/Hc5xAFXg7GkZOTOAMVl4ENjBRKT035
         70xn9T4MSSokGd72+kVhl5Esy12GJYym9vkwRczvEF9BGyEHwAq3LiFrMTOF5u85sIbR
         y2oO8/8C6VyJtDIsMLw+JGCTq6krz9SXsZ6ysvdz1fpSXVfMK9UP5c7/X6fm9FLOiO+3
         wjtQ==
X-Gm-Message-State: AOAM530093oP09GnpZQFH34O/qZ6S5V8aVjmgKlQ90k4tuERLdy62ze+
        WTZUHsbJBt5zPYtnUgJaOLq/cQ==
X-Google-Smtp-Source: ABdhPJzam5W5lL4BmYBl8ADicc18wPg5pnrpx0lmKPQWczLccxT9C1+hY1PtdegvJ6aWUm3152di7Q==
X-Received: by 2002:a05:600c:14a:b0:389:948e:eb2f with SMTP id w10-20020a05600c014a00b00389948eeb2fmr8068209wmm.141.1646645241970;
        Mon, 07 Mar 2022 01:27:21 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b00381890032dfsm18060727wmi.1.2022.03.07.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:27:21 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:27:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: power: supply: maxim,max14577:
 convert to dtschema
Message-ID: <YiXP91/gl3a36MsN@google.com>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
 <20220215074759.29402-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215074759.29402-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Krzysztof Kozlowski wrote:

> Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
> schema format.  The existing bindings were defined in
> ../bindings/mfd/max14577.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/maxim,max14577.yaml | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
