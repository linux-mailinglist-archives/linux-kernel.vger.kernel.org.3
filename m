Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044C2479BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhLRSI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:08:29 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45588 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhLRSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:08:28 -0500
Received: by mail-oi1-f173.google.com with SMTP id 7so8825802oip.12;
        Sat, 18 Dec 2021 10:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TSfoz4aXjnjdb0jbAmqY/StV1Ml9RtqYdNL2erwhLOI=;
        b=SbSJRRmzpAmU59oBClH9aWnQWsOV762bAZZ9cqF88GABnh+bQRATVuU7XKUnpnLbr5
         9PaO3mEDKKJVMCGTjF01XdiPf4/roH89dINb5rbysjCGxRpL36LzXHwkpjey4xMtrs9c
         rQt3L4VWj6iFhOnE4EHAPGlYL0QR4H9vOqJQFxsxvNs82Si7GZWLvGqRPDr8hom1/iTh
         qJ7ZOJjpC8pt76ONiC4dbmf2aCxKu9Ban7ZNzBaxQ6Fizi/RjfxSyOlv4cxqPu6AL/ZX
         CMam8BtsXXQYVYFjPm/TEGVFLXtcoRBbmQvFMDqa01HYO9+JsNEx3iqx2W8YaqTI4eD8
         gs8Q==
X-Gm-Message-State: AOAM533Wy89GlP75aIVvHSmTpp5WHMWgRIRBVINkkGKEKmFXttmEo6bD
        zsJLwcj/5RKSZMFLhsKWHMdF7S2f6w==
X-Google-Smtp-Source: ABdhPJx9hhToxzGq7C+51vgR0l79b9qWSrZc9ukqQlRSkvk892TuWjxDQnarIz6MdIT/L4B0LdwJMQ==
X-Received: by 2002:a05:6808:1aa8:: with SMTP id bm40mr11678539oib.38.1639850908176;
        Sat, 18 Dec 2021 10:08:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x12sm2224275oom.44.2021.12.18.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 10:08:27 -0800 (PST)
Received: (nullmailer pid 72437 invoked by uid 1000);
        Sat, 18 Dec 2021 18:08:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
In-Reply-To: <20211217170507.2843568-1-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: regulator: palmas: Convert to json-schema
Date:   Sat, 18 Dec 2021 12:08:26 -0600
Message-Id: <1639850906.459198.72436.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:05:02 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Texas Instruments Palmas bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../clock/clk-palmas-clk32kg-clocks.txt       |  35 ----
>  .../bindings/clock/ti,palmas-clk32k.yaml      |  68 ++++++++
>  .../bindings/extcon/extcon-palmas.txt         |  22 ---
>  .../bindings/extcon/ti,palmas-usb-vid.yaml    |  65 ++++++++
>  .../devicetree/bindings/gpio/gpio-palmas.txt  |  27 ---
>  .../bindings/gpio/ti,palmas-gpio.yaml         |  53 ++++++
>  .../bindings/iio/adc/ti,palmas-gpadc.yaml     |  26 ++-
>  .../bindings/input/ti,palmas-pwrbutton.txt    |  35 ----
>  .../bindings/input/ti,palmas-pwrbutton.yaml   |  76 +++++++++
>  .../devicetree/bindings/mfd/palmas.txt        |  52 ------
>  .../devicetree/bindings/mfd/ti,palmas.yaml    | 117 +++++++++++++
>  .../bindings/pinctrl/pinctrl-palmas.txt       | 105 ------------
>  .../bindings/pinctrl/ti,palmas-pinctrl.yaml   | 154 ++++++++++++++++++
>  .../bindings/regulator/palmas-pmic.txt        |  89 ----------
>  .../bindings/regulator/ti,palmas-pmic.yaml    | 144 ++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-palmas.txt    |  32 ----
>  .../bindings/rtc/ti,palmas-rtc.yaml           |  62 +++++++
>  17 files changed, 756 insertions(+), 406 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/clk-palmas-clk32kg-clocks.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,palmas-clk32k.yaml
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/ti,palmas-usb-vid.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/ti,palmas-gpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,palmas.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,palmas-pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/palmas-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,palmas-pmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/ti,palmas-pmic.example.dt.yaml: pmic: 'interrupts-name', 'ti,system-power-controller' do not match any of the regexes: '^ldo([1-9]|ln|usb)-in-supply$', '^smps(([1-9]|10)-in-)|(smps10-out2-)supply$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/ti,palmas-pmic.yaml
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dts:27.13-26: Warning (reg_format): /example-0/i2c/pmic@48:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dts:21.13-39.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dts:25.19-38.13: Warning (avoid_default_addr_size): /example-0/i2c/pmic@48: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: pmic@48: compatible:0: 'ti,palmas' is not one of ['ti,twl6035', 'ti,twl6036', 'ti,twl6037', 'ti,tps65913', 'ti,tps65914', 'ti,tps80036', 'ti,tps659038', 'ti,tps65917']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,palmas.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: pmic@48: compatible: ['ti,palmas'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,palmas.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: pmic@48: 'interrupt-controller' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,palmas.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dt.yaml: pmic@48: '#interrupt-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,palmas.yaml

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/palmas.txt
Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml: Documentation/devicetree/bindings/mfd/palmas.txt

See https://patchwork.ozlabs.org/patch/1570213

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

