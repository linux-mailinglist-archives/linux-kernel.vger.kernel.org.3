Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823FB57DBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiGVIDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVICy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:02:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F2D9B54D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:02:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so5440074wrc.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bvEexGq32Q2q4yLSZgYal6lzMRVPSRDwzzKaxMf771o=;
        b=evku2628x8f7AayzAAE1I5iATAY92Nv0ST8sh2IwQ63jYO3pXS+81O5kKMh8cHWdg0
         fEOkQP44gh9YLaDgU6h5fw/TpHvTGXIzsMK0BxkOSokAGiT68uJq0o96IoR2t5yzmWBC
         VONUbj8m7D9BYNUlm3vlO2DdcFlELpkCnzGMPiEONQNVbHIXhqcwWp1+3duanEX8gJ6h
         8jvXFXifWx+fyevCpsJfdidOmZW23cDFW7y1rYjc9Q2kscaK51y6ThurHiBUfZNLTU3E
         6EjzRr7ORduLoY/7B56rQC69Sqo+R8xspanSeOHAS5/6QEKNk7EmzzFvPaYKI6JpEX0Z
         11Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bvEexGq32Q2q4yLSZgYal6lzMRVPSRDwzzKaxMf771o=;
        b=M9KLpDFuIuqZ2WG95Q5jeQmZA5yn/3iIUoBADIj+OkKq7PAPfHE6vzHWes5KFFKDIr
         lLDaExEADe7dEx1jycMlBK+SlSHHQsk/qxqJRsdvzW0LyvUmwk9qYR6Q1UHd2sprPBCs
         92Ww05GoW6uUzqv+LhXyEfGJZSlG8/sst/B+TBeV2/tKudyjIwV6aAV2KHlb5mTu/D/Z
         DHeWTiSpD0Q7mkCT9o2HQpCpnKC+FtMF+Yun1phGXpvV1geP9TImDu2ZCgRvSGunKZlA
         gz4CWv/ZHtRHtZrfoZtvMGbD52qhbGXdOK0yvo/Y1bLaMe5j2191K6KgtmxqLxQXqavi
         ZMsQ==
X-Gm-Message-State: AJIora+rcl1g50yokr08eLDizxvsY15mdyAQbBys3lQDEQ3dswAn+LjX
        I0Pu//xCsYWCq1M2yo7k+GBpcA==
X-Google-Smtp-Source: AGRyM1v1LK4VrBLGMhVxuBKsl0VRF2RpAftCZFCp1jKEXOMgOZ9vuAekYBfklMuNr345fGlUFFQQHg==
X-Received: by 2002:adf:fb10:0:b0:207:af88:1eb9 with SMTP id c16-20020adffb10000000b00207af881eb9mr1575350wrr.238.1658476970912;
        Fri, 22 Jul 2022 01:02:50 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0021d746d4820sm3868746wrz.37.2022.07.22.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:02:50 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:02:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: stm32-timers: Move fixed string node
 names under 'properties'
Message-ID: <YtpZqNm7Cgzz9+ZC@google.com>
References: <20220706211934.567432-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706211934.567432-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2022, Rob Herring wrote:

> Fixed string node names should be under 'properties' rather than
> 'patternProperties'. Additionally, without beginning and end of line
> anchors, any prefix or suffix is allowed on the specified node name.
> 
> Move the stm32 timers 'counter' and 'timer' nodes to the 'properties'
> section.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/st,stm32-lptimer.yaml        | 28 +++++++++----------
>  .../bindings/mfd/st,stm32-timers.yaml         | 20 ++++++-------
>  2 files changed, 24 insertions(+), 24 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
