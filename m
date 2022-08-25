Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17355A191C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiHYSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbiHYSve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:51:34 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93ED1BEB4;
        Thu, 25 Aug 2022 11:51:24 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so14513343otd.12;
        Thu, 25 Aug 2022 11:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=Cg1AwP/ac5z/ltjeY4oKjrPpLfroVx5J9d1V+I/zl7Y=;
        b=PVnuEj/kcC7v+LYtHJvlqzPAXS+dp5MDkKsX2my7FKLC6Nw8yl+edMre1vfuB6CAif
         bxPhNHXqN2V8/Eo2ZTZh9a3+Dp0laeIfHWEqyBGSjhu0Ocq0ydO+aQmNIbEo3J5VUtEt
         uMBcA/eSjduTT8DFhaYVLqOZRny4M7YceTCrtPgAmCJVtJZ0hTFRzeeX4B8aLwFvrypV
         Mb+C3suPBBom+ElP5Am7mMmu5nqVrx7fHEzUIB3RRMijOe9aXhaSTxs0otLKU3ON+9Xx
         ZpwynoACg0pcCKh3WXxzrBR05U1yPkwikpL8k0ss8Vklrt+YCmQ2d80bYxUdvJscziFa
         VmJg==
X-Gm-Message-State: ACgBeo3hZK/RttPefvmXZbMqAdY/rT16GjX3eiBYtVko/7mIvtkzVxph
        6m2jBiLgs3K+CHjto/5idA==
X-Google-Smtp-Source: AA6agR6ZiLQ5mKRIj8fQ1S1XR92OpZji2uNcYFZ7mkpk99hTwFk8xqDeu5bgdcWPR4OY3N9LrYVW7w==
X-Received: by 2002:a05:6830:60c:b0:637:2636:eaf2 with SMTP id w12-20020a056830060c00b006372636eaf2mr179994oti.358.1661453482963;
        Thu, 25 Aug 2022 11:51:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r8-20020a4ab508000000b004358b15cfe8sm41000ooo.13.2022.08.25.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:51:22 -0700 (PDT)
Received: (nullmailer pid 1486940 invoked by uid 1000);
        Thu, 25 Aug 2022 18:51:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Andreas_B=C3=B6hler?= <dev@aboehler.at>
Cc:     devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Robert Marko <robert.marko@sartura.hr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org
In-Reply-To: <20220825141043.75354-1-dev@aboehler.at>
References: <20220825141043.75354-1-dev@aboehler.at>
Subject: Re: [PATCH v2] hwmon: tps23861: add support for initializing the chip
Date:   Thu, 25 Aug 2022 13:51:19 -0500
Message-Id: <1661453479.990270.1486939.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 16:10:42 +0200, Andreas Böhler wrote:
> The tps23861 driver does not initialize the chip and relies on it being
> in auto-mode by default. On some devices, these controllers default to
> OFF-Mode and hence cannot be used at all.
> 
> This brings minimal support for initializing the controller in a user-
> defined mode.
> 
> Tested on a TP-Link TL-SG2452P with 12x TI TPS23861 controllers.
> 
> Signed-off-by: Andreas Böhler <dev@aboehler.at>
> ---
>  .../bindings/hwmon/ti,tps23861.yaml           | 76 +++++++++++++++++
>  drivers/hwmon/tps23861.c                      | 81 +++++++++++++++++++
>  2 files changed, 157 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:28.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:36.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:44.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:52.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:27.26-33.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@0: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:27.26-33.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@0: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:35.26-41.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@1: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:35.26-41.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@1: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:43.26-49.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@2: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:43.26-49.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@2: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:51.26-57.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@3: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:51.26-57.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@3: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

