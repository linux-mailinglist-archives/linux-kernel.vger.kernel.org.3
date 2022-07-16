Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B92576FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiGPPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiGPPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:19:20 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D081EC72
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:19:18 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bf634bc50so12851913fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kt2nNYoHBTO6MrqYYkc0RFLwMu+31VPI3+k3qn2NFQ0=;
        b=IAPrxMWktnCjr8J6dJjF5fQN4wtpDEO4mpzTf8vI2LtvZQpOF3in54+oXmeV7Qk7Z4
         7XSACQ/izh7o/JZW8e24BSYACRJe15YXnyP1gv/DQV4Q8AcPCL6yaXWbRIU0kUnMBoOo
         XnfivUa3wHhv2RaAnGkvdxWBskI/EDKepx0riyx3NhR6hi6+Gy7NkGfjcyz4chZksEqk
         pL07OepS2vnUPinq9WN7UvOhV8viMwc2Px1ecWifQIiaG9MDBMOUSUIUNYKxQj9DBzi9
         A5q0qzE5Ue61fVphf+fhil2kjU5u9R2eIWSratrqKwJxUpaS1/coiqfTM3K2kx9OVWF4
         NXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kt2nNYoHBTO6MrqYYkc0RFLwMu+31VPI3+k3qn2NFQ0=;
        b=SLL+AzEd1qB15qDt6UBm2ZfRiHiri3WRETamD0IIGRJ/TR9gmwzc7c0UieJzkBDeyy
         xurDQCidNTgIQ8ql4+VfPGM4JWNW6isvVGP0Kc1WL7PSoiSq22RYlsxNzA+axkwvVcyA
         HpDtrIJdl1yYxK7uLFM1TvkdqBqdpWuUA9OwB3KuPLdWKy9TvMavG/Xi7G50muQN+Eyt
         Pfex70YQ6VsfivvelqJSAEu1H8HF0mzaoplO74oSkHsqkXhEH0t3nMYoOpgZpMFQE20/
         uwHLf9G4l9ShLj4U2C1B8r9SIz3DBIytU3brE7eUyBufCMDdOojQY3nHqJF7RxnLGujZ
         LkMg==
X-Gm-Message-State: AJIora+TfyLTP7NVgH12vuTl8HsGEpjiC+kbOsjBJRUsljtWE3+rZ8W9
        N6gNrposSQvBZ0z2S4w06lb7vQ==
X-Google-Smtp-Source: AGRyM1vTHpjtf0+AposTsJTgrdLrf1SpogOk1rRO5jQWDQlxIMQtwHL2TfIhXCADpCUdJf+dBoPnfw==
X-Received: by 2002:a05:6870:9620:b0:10c:32ba:8358 with SMTP id d32-20020a056870962000b0010c32ba8358mr10639502oaq.11.1657984757601;
        Sat, 16 Jul 2022 08:19:17 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m21-20020a4ad515000000b00425beedad70sm3035254oos.32.2022.07.16.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 08:19:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH] arm64: dts: qcom: msm8998: Make regulator voltages multiple of step-size
Date:   Sat, 16 Jul 2022 10:19:00 -0500
Message-Id: <165798474063.1679948.13705113619162226902.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220507153627.1478268-1-marijn.suijten@somainline.org>
References: <20220507153627.1478268-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2022 17:36:27 +0200, Marijn Suijten wrote:
> These voltages are not a multiple of the given step-size 8000 (with base
> voltage 1664000) in pm8998_pldo, resulting in PLDO regulators l18 and
> l22 failing to validate and in turn not probing the rpm-pm8998-regulator
> driver:
> 
>     l18: unsupportable voltage constraints 2856000-2848000uV
>     qcom_rpm_smd_regulator rpm-glink:rpm-requests:pm8998-regulators: l18: devm_regulator_register() failed, ret=-22
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998: Make regulator voltages multiple of step-size
      commit: 2aa54fa87cca1fa43870a9caf4fcce00eb087fa5

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
