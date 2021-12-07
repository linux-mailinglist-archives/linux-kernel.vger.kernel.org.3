Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6799C46B701
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhLGJaH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 04:30:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4220 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbhLGJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:30:05 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7ZdF49HKz67PcP;
        Tue,  7 Dec 2021 17:24:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:26:32 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 09:26:32 +0000
Date:   Tue, 7 Dec 2021 09:26:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
CC:     <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: accel: add ADXL367
Message-ID: <20211207092630.000067c1@Huawei.com>
In-Reply-To: <982d5463-0cbf-3275-8f9a-6c3680337738@gmail.com>
References: <20211206105403.53049-1-cosmin.tanislav@analog.com>
        <20211206143934.000017b8@Huawei.com>
        <1f23cc46-47b7-e00d-40d3-ec2083928759@gmail.com>
        <982d5463-0cbf-3275-8f9a-6c3680337738@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 09:58:16 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 12/6/21 21:31, Cosmin Tanislav wrote:
> > 
> > 
> > On 12/6/21 16:39, Jonathan Cameron wrote:  
> >> On Mon,  6 Dec 2021 12:54:02 +0200
> >> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >>  
> >>> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> >>>
> >>> The ADXL367 does not alias input signals to achieve ultralow power
> >>> consumption, it samples the full bandwidth of the sensor at all
> >>> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> >>> with a resolution of 0.25mg/LSB on the +-2 g range.
> >>>
> >>> In addition to its ultralow power consumption, the ADXL367
> >>> has many features to enable true system level power reduction.
> >>> It includes a deep multimode output FIFO, a built-in micropower
> >>> temperature sensor, and an internal ADC for synchronous conversion
> >>> of an additional analog input.
> >>>
> >>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>  
> >>
> >> Hi Cosmin,
> >>
> >> Given how often we get patches later to add regulators for devices like
> >> these I'd like them supported from the start.
> >>
> >> I'm guessing it needs power, but how many supplies? I'm not sure as 
> >> doesn't
> >> seem to be a public datasheet yet.  
> > 
> > I'll add them. For the note, it has two supplies, one being the main one 
> > and another one for the io.
> >   
> 
> One question I have is whether I should disable the regulators on system
> suspend. If I do, I should also use a regmap cache so I can re-apply all
> registers on resume...

Ideally yes, but often first implementation just turns them off on probe / remove.
Can add fancy stuff later :)

Jonathan

> 
> >>  
> >>> ---
> >>>   .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
> >>>   1 file changed, 79 insertions(+)
> >>>   create mode 100644 
> >>> Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> >>>
> >>> diff --git 
> >>> a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml 
> >>> b/Docu`mentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> >>> new file mode 100644
> >>> index 000000000000..1bf9e1602480
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> >>> @@ -0,0 +1,79 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl367.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Analog Devices ADXL367 3-Axis Digital Accelerometer
> >>> +
> >>> +maintainers:
> >>> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> >>> +
> >>> +description: |
> >>> +  The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> >>> +
> >>> +  The ADXL367 does not alias input signals by to achieve ultralow power
> >>> +  consumption, it samples the full bandwidth of the sensor at all
> >>> +  data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> >>> +  with a resolution of 0.25mg/LSB on the +-2 g range.
> >>> +
> >>> +  In addition to its ultralow power consumption, the ADXL367
> >>> +  has many features to enable true system level power reduction.
> >>> +  It includes a deep multimode output FIFO, a built-in micropower
> >>> +  temperature sensor, and an internal ADC for synchronous conversion
> >>> +  of an additional analog input.
> >>> +    https://www.analog.com/en/products/adxl367.html  
> >>
> >> "We can't find that page". I guess this driver is running slightly ahead
> >> of the datasheet being made public.  
> > 
> > Yeah, the datasheet and product page isn't out yet.
> >   
> >>  
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - adi,adxl367
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1  
> >>
> >> spi-max-frequency: true
> >>
> >> to fix the issue Rob's bot reported.
> >>  
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - interrupts
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/gpio/gpio.h>
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +
> >>> +    i2c {
> >>> +      #address-cells = <1>;
> >>> +      #size-cells = <0>;
> >>> +
> >>> +      adxl367@53 {
> >>> +        compatible = "adi,adxl367";
> >>> +        reg = <0x53>;
> >>> +        interrupt-parent = <&gpio>;
> >>> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> >>> +      };
> >>> +    };
> >>> +  - |
> >>> +    #include <dt-bindings/gpio/gpio.h>
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +
> >>> +    spi {
> >>> +      #address-cells = <1>;
> >>> +      #size-cells = <0>;
> >>> +
> >>> +      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
> >>> +      status = "okay";  
> >>
> >> We don't normally list status in example bindings.
> >> Also, the cs-gpio is part of the spi master binding
> >> so no need to have it here as we are showing how the
> >> actual device binding works.
> >>
> >> That should let you drop the gpio.h header.
> >>  
> > Interestingly, you forgot to say this for my AD74413R driver.
> >   
> >>  
> >>> +
> >>> +      adxl367@0 {
> >>> +        compatible = "adi,adxl367";
> >>> +        reg = <0>;
> >>> +        spi-max-frequency = <1000000>;
> >>> +        interrupt-parent = <&gpio>;
> >>> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> >>> +      };
> >>> +    };  
> >>  

