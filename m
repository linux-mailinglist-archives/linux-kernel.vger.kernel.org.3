Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D268479BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhLRSIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:08:38 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40663 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhLRSIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:08:34 -0500
Received: by mail-ot1-f50.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so7084535otj.7;
        Sat, 18 Dec 2021 10:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5q1HAw6dG274NClq6su5gzPo1f7Z+q6cH6boRReKYV4=;
        b=pquFFCOmF6zJ8AR28c9PNpE+C+cdLLUHYaiDo/HD5UUr4adp5R0gIYFbmF7dOYcUfq
         wNYEdkbuE93taGgTK7pkfCji9qgfyFjVLg5wGgWTHEcDI+hVxVs5bPpVc3ZSoqwy4iV3
         SK6QtJD/6ipkYqrte7Ie19U13WXJOUOO2bwHubj6isooG0j8DLDZrLM0R7sj0MOiMkRN
         Ptk2oX235OXyX3ZH5VsPlsR1kku1HGG/G29KUN+k6uSf/y7mUdlVXtkqw2AuPYPevlN/
         XrIzD4gXNDiE5lZ6Caw6t6RkZiEnJ9yxZoB/jEcF5WQy/179VuLd/mIefuOBk+4E49LY
         WKNg==
X-Gm-Message-State: AOAM532Yl5BEAJXni4WdrtPLSBCYLwTQafwfOomzsV/+DY2gc4N9M7ON
        y3n1dR4UzYS0jam5jNyHoA==
X-Google-Smtp-Source: ABdhPJztvn4MEN+pGjmwfyWAFwd9O7bEdEzMmt4Fj0vvLYcFMgDJaVwRbsyLotLGUiO06+ulmSiRxg==
X-Received: by 2002:a05:6830:3195:: with SMTP id p21mr5908381ots.56.1639850914203;
        Sat, 18 Dec 2021 10:08:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb7sm2404659oob.14.2021.12.18.10.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 10:08:33 -0800 (PST)
Received: (nullmailer pid 72446 invoked by uid 1000);
        Sat, 18 Dec 2021 18:08:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211217170507.2843568-2-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com> <20211217170507.2843568-2-thierry.reding@gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: regulator: pwm: Convert to json-schema
Date:   Sat, 18 Dec 2021 12:08:26 -0600
Message-Id: <1639850906.492042.72445.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:05:03 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the generic PWM regulator bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/regulator/pwm-regulator.txt      |  92 -------------
>  .../bindings/regulator/pwm-regulator.yaml     | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 92 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1570214


ppvar-bigcpu-pwm: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dt.yaml

ppvar-centerlogic-pwm: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dt.yaml

ppvar-gpu-pwm: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dt.yaml

ppvar-litcpu-pwm: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dt.yaml

pwm-regulator: 'max-duty-cycle', 'regulator-always-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/stih407-b2120.dt.yaml
	arch/arm/boot/dts/stih410-b2120.dt.yaml
	arch/arm/boot/dts/stih410-b2260.dt.yaml
	arch/arm/boot/dts/stih418-b2199.dt.yaml
	arch/arm/boot/dts/stih418-b2264.dt.yaml

regulator-vcck: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml

regulator-vddcpu-a: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dt.yaml

regulator-vddcpu-b: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dt.yaml

regulator-vddcpu: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12a-u200.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dt.yaml
	arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dt.yaml

regulator-vddcpu: 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dt.yaml

regulator-vddee: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/meson8b-ec100.dt.yaml
	arch/arm/boot/dts/meson8b-mxq.dt.yaml
	arch/arm/boot/dts/meson8b-odroidc1.dt.yaml

vdd-arm: 'regulator-always-on', 'regulator-boot-on', 'regulator-settling-time-up-us' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dt.yaml

vdd-arm-regulator: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rk3229-evb.dt.yaml
	arch/arm/boot/dts/rk3229-xms6.dt.yaml

vdd-center: 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml

vdd-core: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on', 'regulator-init-microvolt', 'regulator-settling-time-up-us' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dt.yaml

vdd-core: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on', 'regulator-settling-time-up-us' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml

vdd-logic: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml

vdd-log: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dt.yaml

vdd-log: 'regulator-always-on' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rk3066a-bqcurie2.dt.yaml
	arch/arm/boot/dts/rk3066a-marsboard.dt.yaml
	arch/arm/boot/dts/rk3066a-rayeager.dt.yaml

vdd-log: 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-firefly.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-orangepi.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-sapphire.dt.yaml
	arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dt.yaml

vdd-log: 'regulator-always-on', 'regulator-boot-on', 'regulator-settling-time-up-us' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dt.yaml

vdd-log: 'regulator-always-on', 'regulator-boot-on', 'regulator-state-mem' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dt.yaml

vdd-log-regulator: 'pwm-supply', 'regulator-always-on', 'regulator-boot-on' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rk3229-evb.dt.yaml
	arch/arm/boot/dts/rk3229-xms6.dt.yaml

