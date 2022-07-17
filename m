Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7757739D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiGQDIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiGQDIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:08:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E614030
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:31 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso15611228fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GPuNdH8N0hsQIuG366Lp4ROKzuBg5e0T0hN4VGOiBA=;
        b=XR+dh08D2rzNZVqfAj5euifs/8hKBPhSWtrJDf2/tubDYk+lRaePhmJ2qhYblYVyUH
         5KS6svy2EXL0QBitrcjEvzie18O9k80NUysW2O+BWNHXmCgZ7lAKoM/TloW3JvTDrUjl
         t4i++DYB7UzAh+BhNjE8Qfd8VIeHfqA8psFLi8wnHRtoZFPR4abOE7S2ERdLPp4VpR1H
         Zw93tyK0iCWFIy3Nt9x0slA46b5KIlh60avgEetSkWfn6GMKujlbPgBVCjHeAU0yeqL7
         2D9fsYm8b2on3XmKKcbxvKnfueVWn9PtZM4Pmv5GAFrm6evODV4uUvDxKh/tRfAjyyJe
         9ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GPuNdH8N0hsQIuG366Lp4ROKzuBg5e0T0hN4VGOiBA=;
        b=IiWtCYiXHJ1JEsMChYIbkHUhNDGfAwLgCBChLVgi1wT9NB+KHKj9hrkJ+bQPayis+q
         93oYulqtnB10eQoBUVYuJEQmMdfvc72iwXyhHJGR3qGE7d/o1xpPCFwEtTM9FDeSSwJg
         5bVww3m+GAzAejcONCgiWkti7S/U4cxxBX6r/sH5pjWWST3o+Sa/gE5Lk6VzU6XReRXE
         j25GKPKV4SSfpRBpC5zhYlDPQvbk24SqLp64MxppcCGjXgYut63c9ZxsGsC3gA/1LdPx
         m+jMs6fY9c7DCccfrC2KJOIhk3o9QPy3AmFBkWzqp9srRgVMJodljLSq5a49qlRipJ5H
         zltQ==
X-Gm-Message-State: AJIora/vxJF4ByIK9EInQZWZBSmvudQ6Vm/5JwocIKupvJ36yWlUhQVf
        wf7/0lGbxPvcjPyx0DwwtvkwBDzJuqSunA==
X-Google-Smtp-Source: AGRyM1trKyNF8OOHDOK0LQLxiqATR6xOCrfTpI40s3Hv/J8e0ER2M0Ctz4fsjU/a+CyaziAmqZIu0g==
X-Received: by 2002:a05:6808:f92:b0:33a:441e:979b with SMTP id o18-20020a0568080f9200b0033a441e979bmr6568901oiw.220.1658027311048;
        Sat, 16 Jul 2022 20:08:31 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z203-20020a4a49d4000000b0043577be222bsm3203928ooa.22.2022.07.16.20.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:08:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ARM: dts: qcom: msm8974-sony: Enable RGB LED
Date:   Sat, 16 Jul 2022 22:08:21 -0500
Message-Id: <165802729676.1737676.14748989855035222232.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220713212309.130230-1-bjorn.andersson@linaro.org>
References: <20220713212309.130230-1-bjorn.andersson@linaro.org>
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

On Wed, 13 Jul 2022 14:23:07 -0700, Bjorn Andersson wrote:
> Introduce the Light Pulse Generator block in the pm8941 and use this to
> describe the RGB LED driven by the triled in this block.
> 
> Bjorn Andersson (2):
>   ARM: dts: qcom: Add LPG node to pm8941
>   ARM: dts: qcom: msm8974-sony: Enable LPG
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: qcom: Add LPG node to pm8941
      commit: 5edd7d3e15a46c8549440a0b596c69be7e2c49fc
[2/2] ARM: dts: qcom: msm8974-sony: Enable LPG
      commit: 27f5947894c596fcfd6da20c061c582e7191e9e1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
