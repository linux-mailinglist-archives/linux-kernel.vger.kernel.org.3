Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92C4831A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiACN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:59:02 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43548 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACN7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:59:02 -0500
Received: by mail-oi1-f176.google.com with SMTP id u21so41835554oie.10;
        Mon, 03 Jan 2022 05:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wzDM9gjQL9KJfKSfYGCQK2zI/KnBbFjyptgpSxeAvX8=;
        b=IvXOqKGmtW8dxCz6STk2ke86Vtub+b7+3MZVUDwTsrMpZXT4USXOyUTFVS5KOWpXOg
         zDGXaG17Xu/u6trxfWhNQ3AUQ46HC/zeH1MJp1xn/F5tKqHMdcDFPJXfoTr0ZjGkGEpi
         hg0jbzn7lkhrCuYtT57YqkRiECWjoxu70tqbxdppObOEl+zgxJRrdGW1LCu1x9ZDccQc
         forqF9eHRgpd6876ifpoSpAfAeouMFJ07jpFyJwx0BPUDqdepPeithGEICnnPVBycaQq
         HZiJIsDjUnpFDhuBAZ/HwL0tyq1xHujurIYYS96bc/cCS3OFznKHi721N4QVEgBrKwPr
         yvXQ==
X-Gm-Message-State: AOAM531MFVbgrK+pPHI7PKAzXtFIBs/vXdxVaRDZQGfHFu5QRn4gko4Z
        v1JkxsOr1Uhmrf2kNAeE0w==
X-Google-Smtp-Source: ABdhPJw7S2QyvbSVgsDRCOh58ieaDF4BWKOnY006IkcKhBMkOI0VpUV+B5SwjktePQEdZqXq20LIlQ==
X-Received: by 2002:a05:6808:2309:: with SMTP id bn9mr34944786oib.42.1641218341421;
        Mon, 03 Jan 2022 05:59:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t66sm8264920oie.39.2022.01.03.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 05:59:00 -0800 (PST)
Received: (nullmailer pid 2378537 invoked by uid 1000);
        Mon, 03 Jan 2022 13:58:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, peter.ujfalusi@gmail.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220103074427.4233-1-j-choudhary@ti.com>
References: <20220103074427.4233-1-j-choudhary@ti.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Date:   Mon, 03 Jan 2022 07:58:59 -0600
Message-Id: <1641218339.997415.2378536.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 13:14:27 +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs from txt
> to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains',
> '#sound-dai-cells' and 'port' which were missing from the txt file.
> Removes properties 'sram-size-playback' and 'sram-size-capture'
> since they are not used.
> Adds 'dmas' and 'dma-names' in the example which were missing from
> the txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> Changes 'op-modes', 'serial-dir' to optional properties as they are
> not needed if the McASP is used only as GPIO.
> Changes 'tdm-slots' to required property only for I2S operation mode.
> 
> Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
> INSTRUMENTS ASoC DRIVERS'
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> Changelog:
> v5:
> - changes the commit message
> - changes description for 'reg', 'op-mode', 'tx-num-evt',
>   'rx-num-evt' and 'interrupts'
> - adds minimum and maximum for 'tdm-slots'
> - removes default from 'serial-dir'
> - removes maxItems from 'tdm-slots', 'tx-num-evt', 'rx-num-evt' and
>   'auxclk-fs-ratio' as they are of type uint32
> - adds 'tdm-slots' as conditionally required property for I2S mode
>   of operation
> 
> v4:
> - changes the commit message
> - adds type and description to relevant properties
> - changes maxItems for 'serial-dir'
> - removes properties 'sram-size-playback' and 'sram-size-capture'
>   as they are not used
> - removes 'function-gpios'
> - removes 'num-serializer'
> - marks 'tdm-slots', 'op-mode' and 'serial-dir' as optional properties
> - adds the yaml file in MAINTAINERS
> 
> v3:
> - remove maxItems from 'clock-names'
> 
> v2:
> - changes the commit message
> - modifies the properties 'clocks', 'clock-names', 'dma-names',
>   'dmas', 'interrupts' and 'interrupt-names' according to the
>   arm SOCs
> - adds 'ports' and 'num-serializer' as node properties
> 
>  .../bindings/sound/davinci-mcasp-audio.txt    |  86 --------
>  .../bindings/sound/davinci-mcasp-audio.yaml   | 201 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 202 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1574696


mcasp@0: 'num-serializer' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-cm-t335.dt.yaml
	arch/arm/boot/dts/am335x-sbc-t335.dt.yaml

mcasp@0: 'rt-num-evt' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-wega-rdk.dt.yaml

mcasp@2b00000: 'tdm-slots' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b10000: 'tdm-slots' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b20000: 'tdm-slots' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

