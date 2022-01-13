Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3C448D5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiAMKkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiAMKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:40:04 -0500
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:1::465:209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0EC06173F;
        Thu, 13 Jan 2022 02:40:04 -0800 (PST)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4JZLXw3KzbzQjvw;
        Thu, 13 Jan 2022 11:40:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642070398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKW9/ooiinOzFP5H2unHlNtCUzj8yfg0qW8Op7GfmCs=;
        b=jtDeXyxAVQN5Ospt4kys4zXqT/Z1Gd3W1tJGeikyAcvBf3HZVkBJD6PkOvar+Myp37HQSn
        M+RIbbyLmtyg9Mr0L5wKLm8h09k7cuaIUryhtfWRmpG/MKv337DHUKZf78FEAPTyAe1Sig
        ovynannmCvQkkIS26HhcjJZgSTzSZ/DN8MRv1TsusblQWqYr/GbyJG3cQtTi+rzx3R6GwO
        oRwloPh2vSFFK1Z7I/d+YC/9lPFaccTEbHw4MflPlMVmD3rFFOysPpCdX311crUGAVLPZk
        TO4qCf28fO1VO3BitRi1hnckozvt6cxZ0J5d0Ezi5u5KYST6Mm77AB/8sd5aaA==
Message-ID: <7d51dc977be01c71b1bc5774bbdeb13240b868ee.camel@sylv.io>
Subject: Re: [PATCH v1 3/4] dt-bindings: hwmon: Add binding for max6639
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roland Stigge <stigge@antcom.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Jan 2022 11:39:53 +0100
In-Reply-To: <20220110012203.GA976519@roeck-us.net>
References: <cover.1641224715.git.sylv@sylv.io>
         <df3d2ec4f711d310da8a4b23e2a2fa4c019d3500.1641224715.git.sylv@sylv.io>
         <20220110012203.GA976519@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for your review.

On Sun, 2022-01-09 at 17:22 -0800, Guenter Roeck wrote:
> On Mon, Jan 03, 2022 at 05:33:48PM +0100, Marcello Sylvester Bauer wrote:
> > Add Devicetree binding documentation for Maxim MAX6639 temperature
> > monitor with PWM fan-speed controller.
> > 
> > The devicetree documentation for the SD3078 device tree.
> > 
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > ---
> >  .../bindings/hwmon/maxim,max6639.yaml         | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> > new file mode 100644
> > index 000000000000..136ed37b6aac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim max6639
> > +
> > +maintainers:
> > +  - Roland Stigge <stigge@antcom.de>
> > +
> > +description: |
> > +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
> > +  fan-speed controller.  It monitors its own temperature and one external
> > +  diode-connected transistor or the temperatures of two external diode-connected
> > +  transistors, typically available in CPUs, FPGAs, or GPUs.
> > +
> > +  Datasheets:
> > +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max6639
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  polarity:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +    description:
> > +      PWM output is low at 100% duty cycle when this bit is set to zero. PWM
> > +      output is high at 100% duty cycle when this bit is set to 1.
> > +      Fans PWM polarity is set to high (1) by default.
> 
> Should probably be pwm-polarity.
> 

indeed.

> > +
> > +  pulses-per-revolution:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 3, 4]
> > +    description:
> > +      Value specifying the number of pulses per revolution of the controlled
> > +      FAN.
> 
> Is there a fan in the world with pulses-per-revolution == 3 ?
> Valid values should probably be 1, 2, 4.
> 

No sure but regarding the data sheet, it is a valid value for ppr:
https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
Page 16, Table 10

In my view we should keep it, since the IC does allow this values to be
set accordingly.

> > +
> > +  rpm-range:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [2000, 4000, 8000, 16000]
> > +    description:
> > +      Scales the tachometer counter by setting the maximum (full-scale) value
> > +      of the RPM range.
> 
> The above need to be per channel in devicetree data.
> 
> On higher level, max6639_platform_data should be removed entirely.
> It isn't used by any in-kernel driver, and all its parameters are
> per device and not per channel as they should be.

Sounds great. In this way we could get rid of get_pdata_from_dt_node
and make it easier to add additional proprieties in future.

I'll adapt v2 to implement this change.

Marcello

> 
> Guenter
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      max6639@10 {
> > +        compatible = "maxim,max6639";
> > +        reg = <0x10>;
> > +        polarity = <1>;
> > +        pulses-per-revolution = <2>;
> > +        rpm-range = <4000>;
> > +      };
> > +    };

