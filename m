Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8255A6B86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH3R7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiH3R7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:59:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE92676
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:58:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p18so8870891ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zOi9kFOde5m40Z0kzt7eejwPpj0TyHiFN0Epj0E8EcY=;
        b=kOSsVdTVsCPhkycrz9pFHCagY9vhvZ/ZsHKsO5/WpC2KatVlstdZC08p4rRCGwGnlI
         vvMTass1nOfPlNAGL9Trvt+FHMNNL7Qh2MzuJ8CqKER9ItW1mo6hIDF7t4D+lvlbJRJM
         rwZGQV18MmjoPqeP1qNb3zT8C9aHqzsQ9F3uXBaEMUDEJYzA6Mn8HSdI2Cm4L5LR6TOE
         QC0prfswFQK60mYEimHhLstNDjvG79CMdJd13Xbb9Hbaa+857gKoePXq3i1OXGPD16FH
         eaLK/BIKs1UvuaajzvE6hn8fEg7e8WMWUbGpiGOI0e8kml4OBsZQO3TYsDM7Qezz3RFa
         lqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zOi9kFOde5m40Z0kzt7eejwPpj0TyHiFN0Epj0E8EcY=;
        b=X38lYHmw2W5vSyuPtHOQmNFJdntDX1OH3kZv20Au/lKjPFsc+YS1ONhdySi3TqYEN7
         qBV5vQ+fhw9PN60MpjQmPTPeEHV7ZZucg/PjbKkD0F73kJIhDfGylbj6DOROUNshAx1I
         nrIeTiNNL3De3T9FpCTpnmPXn7aJqpe3mYiaalteVtJ6QiCDGv6P8xNIh5ulmqeYFKYl
         BCIsZfnlzZkwHw++VPU1tb2vMNuv9qAlutf6suKJP/CEa6Bd1x88Y8G+skkBWEmgCbct
         aH42+DEr1dFpaUfvPMizhqWubZOAaeC/5x3ACcDTE4TjOLpbGXE9pdSFkpYD9HDDKT1q
         jXXg==
X-Gm-Message-State: ACgBeo2/V8TvNiU3RDkM9HxwyFOwdcEqSZZTEgHcvUXIMp1DKM52MlBU
        ilzNeeGpfeQmwkt01ELnWMdg6w==
X-Google-Smtp-Source: AA6agR5fB8tcI6nebScGu9KgPYQP+YMJ6wrIkqasj8/WnuIm+BOxrAGCTs+OgaoBOeK4z79Jb3aqmw==
X-Received: by 2002:a2e:be9b:0:b0:25f:e027:4999 with SMTP id a27-20020a2ebe9b000000b0025fe0274999mr7477279ljr.395.1661882332908;
        Tue, 30 Aug 2022 10:58:52 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id h5-20020a2ea485000000b0025e6a3556ffsm1851394lji.22.2022.08.30.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:58:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, yong.wu@mediatek.com,
        chengci.xu@mediatek.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, yi.kuo@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        anthony.huang@mediatek.com, wendy-st.lin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 0/4] MT8188 SMI SUPPORT
Date:   Tue, 30 Aug 2022 20:58:49 +0300
Message-Id: <166188232676.14577.13660349538278549218.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817124608.10062-1-chengci.xu@mediatek.com>
References: <20220817124608.10062-1-chengci.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 20:46:04 +0800, Chengci.Xu wrote:
> This patchset adds MT8188 SMI support.
> 
> MT8188, similar to mt8195, there are two SMI-common HW, one is for
> VDO(video output), the other is for VPP(video processing pipe). They
> connect with different SMI-larbs, then some setting(bus_sel) is
> different.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: memory: mediatek: Add mt8188 smi binding
      https://git.kernel.org/krzk/linux-mem-ctrl/c/9d9fde47430298455544b283cffa390c40d58bfc
[2/4] memory: mtk-smi: Add return value for configure port function
      https://git.kernel.org/krzk/linux-mem-ctrl/c/8c1561edc0692fa8e321daf2777c3c32454b5748
[3/4] memory: mtk-smi: Add enable IOMMU SMC command for MM master
      https://git.kernel.org/krzk/linux-mem-ctrl/c/4e508b259ed02f5fa608cdd83b817a7f49c22271
[4/4] memory: mtk-smi: mt8188: Add SMI Support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/673e71df5ccfaefeb32bb5b3130a5d397b742194

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
