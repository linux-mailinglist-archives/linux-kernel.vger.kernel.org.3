Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15D47F37A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhLYOsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:48:54 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:42579 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhLYOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:48:50 -0500
Received: by mail-qt1-f172.google.com with SMTP id z9so9790454qtj.9;
        Sat, 25 Dec 2021 06:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=45oXLxsLRy64jxplOJXcctPy/c24XaAFnKJEqdFlaBo=;
        b=A5atjnQi+jmGb6NrwY5gnpAmmqncwD6EEpLWskjiUeU1+LgdMipOOcQr/YMXXiuDa/
         txiWdFuIWiQkGPoFhuRmv3Qr9vYfcwDFdNblr2sdzWbsR4nQaJwiB11vK6TD2iwuhwnU
         KpQGWy6hSMyzUMSJyZYTweQ2flUCVByLUAKY1l0QIg99NwkwJ96HACXusWqtZNpPIPgS
         TIkbb080uQ+JLeChxXiFZ1WiBjrgVqFJxaima+fbhDrR+XBRdEZqZwYeQ7Cfyh3u9L6I
         jkOQhxIldC0B5Oxu5dFDo+VoNG8f0O9tMuBrTEDz43woAPuRz9sLzatbZ1evXEPWMVWQ
         oLQA==
X-Gm-Message-State: AOAM530fO9YyRisA4YqT/2n+1A9s5tnOGBnFwXUuq7gHJmFgTdFWt6B6
        ztK+veX4yJJ5Xgv1CvWKAzA6yjCvswL6
X-Google-Smtp-Source: ABdhPJyLljuvCylzaLdPswZfnibLkqYbGg4ADMyoKFtilZv7iZLTuSnjBlW+wVjn5V0ECHAMd139vQ==
X-Received: by 2002:ac8:7e83:: with SMTP id w3mr9055830qtj.160.1640443729276;
        Sat, 25 Dec 2021 06:48:49 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id s6sm9112508qki.23.2021.12.25.06.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 06:48:48 -0800 (PST)
Received: (nullmailer pid 363351 invoked by uid 1000);
        Sat, 25 Dec 2021 14:48:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20211224163344.54177-1-david@ixit.cz>
References: <20211224163344.54177-1-david@ixit.cz>
Subject: Re: [PATCH 1/2] dt-bindings: spmi: spmi can have at least up to 5 registers
Date:   Sat, 25 Dec 2021 10:48:42 -0400
Message-Id: <1640443722.949011.363350.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 17:33:43 +0100, David Heidelberg wrote:
> Since Qualcomm SPMI Controller (PMIC Arbiter) can have 5,
> bump reg up to maxItems 5.
> 
> Fixes warning as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: spmi@c440000: reg: [[0, 205783040, 0, 4352], [0, 207618048, 0, 33554432], [0, 241172480, 0, 1048576], [0, 242221056, 0, 655360], [0, 205561856, 0, 155648]] is too long
>         From schema: Documentation/devicetree/bindings/spmi/spmi.yaml
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/spmi/spmi.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1573074


spmi@c440000: #address-cells:0:0: 2 was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@c440000: #size-cells:0:0: 0 was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

