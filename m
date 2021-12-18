Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A258479BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhLRSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:08:32 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41589 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhLRSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:08:30 -0500
Received: by mail-oi1-f178.google.com with SMTP id u74so8863524oie.8;
        Sat, 18 Dec 2021 10:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=V4ySLdwE8O/Hwz8NqPZirHPlYVuGnuH6GNQyDfCl0hc=;
        b=u50+142GXntiQlUWMSVYetuQCR+LH2yIvh9Ownza64xd4ZHhvEg8FYElkyPnIr1auh
         eORQlfPM0sVPWVBgOW16aCVKi2qBWRA7Lw1KgJZ20wrOxnkuMJbpMA60l8q/z5G0Ey90
         gSDXKIYq/LNxPsdK1FM942i1s7XbzvxX8oRnczc0rqN4+baGuRAtluFPHicxKh799KHf
         IRijlPCc/mGxNXE9hN1CAFfBx4E5mlqd5YhjA4EPMliI+x/N/vssJ2h5y6NDNXVbnrwn
         NhxH3vDnetyg6YnxEouagq27CoRg80QUFfJaoqTm/yoyr8CHB+W3Qaq2qZ4y1WVJ6bTI
         68QA==
X-Gm-Message-State: AOAM533I/FCfs6iM59r5ep77M0fHaXXPMW9nu6mNLrCpLdxlT4oyOe6h
        oglHrNAMoQXL9XEtN7ePMQ==
X-Google-Smtp-Source: ABdhPJwniP2UG6a+Eoz7FH2ete+wJEmNci8/eGNZ3ZUkrQjrgs3wa5paLV2VYknsSemIDilTHjPASQ==
X-Received: by 2002:a05:6808:ed0:: with SMTP id q16mr6458949oiv.165.1639850909732;
        Sat, 18 Dec 2021 10:08:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w18sm2236945otm.1.2021.12.18.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 10:08:28 -0800 (PST)
Received: (nullmailer pid 72448 invoked by uid 1000);
        Sat, 18 Dec 2021 18:08:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
In-Reply-To: <20211217170507.2843568-5-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com> <20211217170507.2843568-5-thierry.reding@gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: regulator: tps6586x: Convert to json-schema
Date:   Sat, 18 Dec 2021 12:08:26 -0600
Message-Id: <1639850906.505369.72447.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:05:06 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Texas Instruments TPS6586x bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/regulator/ti,tps6586x.yaml       | 184 ++++++++++++++++++
>  .../bindings/regulator/tps6586x.txt           | 135 -------------
>  2 files changed, 184 insertions(+), 135 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/tps6586x.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1570217


pmic@34: regulators:ldo2:regulator-coupled-max-spread:0: [170000, 550000] is too long
	arch/arm/boot/dts/tegra20-acer-a500-picasso.dt.yaml

pmic@34: regulators:sm0:regulator-coupled-max-spread:0: [170000, 550000] is too long
	arch/arm/boot/dts/tegra20-acer-a500-picasso.dt.yaml

pmic@34: regulators:sm1:regulator-coupled-max-spread:0: [550000, 550000] is too long
	arch/arm/boot/dts/tegra20-acer-a500-picasso.dt.yaml

tps6586x@34: regulators:ldo2:regulator-coupled-max-spread:0: [170000, 550000] is too long
	arch/arm/boot/dts/tegra20-paz00.dt.yaml
	arch/arm/boot/dts/tegra20-ventana.dt.yaml

tps6586x@34: regulators:sm0:regulator-coupled-max-spread:0: [170000, 550000] is too long
	arch/arm/boot/dts/tegra20-paz00.dt.yaml
	arch/arm/boot/dts/tegra20-ventana.dt.yaml

tps6586x@34: regulators:sm1:regulator-coupled-max-spread:0: [550000, 550000] is too long
	arch/arm/boot/dts/tegra20-paz00.dt.yaml
	arch/arm/boot/dts/tegra20-ventana.dt.yaml

