Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F94C88AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiCAKBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiCAKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:01:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220B58C7EC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:00:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so19554051wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/NQBr1sZ8oQQXIIdf1B2NQjdSNXQ4QPfHCPPwQs11cE=;
        b=yfoyhboq/By8VvqSyPz4Pc4WTVhTUz6EPgHo2Rw65TOBCdz3fH4JBoDCxNRdsPnXq/
         HZCFpjKlIZkZGmuqeLj+06YTEiGlC58beIl8NrHj004w1fTCu6pbkZ9ysEwbe5lHYozO
         wuFNkSL8QisrQGLPo3aWl8pYzCWbkgPE3oUT2JFT/3r+n5i46xHmF+J3k9m5vPH50E4L
         EvF5SsKMVm0wCprD1Y7BkhFqQgYghk6IU2xr9dGvXOblrsz3Q/q9rSiz9B7e3Cnh3N7w
         Y5t6LwoJdMtQGeh/HlVIX8UnTYKckMi6YrxcSAtEYoF658cz4ng69CJ0Zir9VMCelJVm
         hjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/NQBr1sZ8oQQXIIdf1B2NQjdSNXQ4QPfHCPPwQs11cE=;
        b=Bt+mMLUJVsYI3jBwDLWT6eABqT062shtvMoY7wRM17/NiMBNQBY6KVxIms9SH/aE4c
         LSihsfbwYDRlhWOrO7U816YS550pvh4Q3YB8438ZqPUy7G9b7uuEmuqK7F5kIpehJM9e
         QX7XWF5Q7kd4trzekX5cBgpfzcq1MDAIvppllyyqSNY6bA6m4J41ndl9mJ3sqcha1iPA
         sXeGE0H2wqGcBB6us8CPfQTe7PQ9OLqm5jwrdNbmuU7G9H8E8OVfbPeOmXC6v8Z1BSK4
         u0XtfxlHFJBWjupDsZpnuD+EYk+ig5ATS7VG65P92wBHaaxkw+IuhcS4YEf4dtE1KNGf
         6dpQ==
X-Gm-Message-State: AOAM5339jKQkVi9X9j5DzJM9MeEzk0pK1fEy0vSfpMkXqKPGcJukVKD/
        CYgOCb+KNiw7QAgf06IWsDwPww==
X-Google-Smtp-Source: ABdhPJxkoqxn1nwWXTwvIK4kRs12pJH4RpRn/7JBDpSDv2croOxCvb0jYahryR9C5EUY2k2J/9Fr7g==
X-Received: by 2002:a5d:4ccd:0:b0:1ed:a139:708f with SMTP id c13-20020a5d4ccd000000b001eda139708fmr18430472wrt.672.1646128827711;
        Tue, 01 Mar 2022 02:00:27 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id x18-20020a1c7c12000000b0037c94766961sm1954654wmc.20.2022.03.01.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:00:27 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:00:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Add compatibles for undocumented trivial
 syscons
Message-ID: <Yh3uuVflhwnN89nh@google.com>
References: <20220228221537.1700071-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228221537.1700071-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Rob Herring wrote:

> 'intel,lgm-syscon', 'marvell,armada-3700-usb2-host-misc',
> 'mediatek,mt8135-pctl-a-syscfg', and 'mediatek,mt8135-pctl-b-syscfg' are
> all used in DT binding examples and/or dts files, but are not
> documented. Add them to syscon.yaml as they are all trivial cases.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
