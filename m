Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12145494AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358903AbiATJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:25:17 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47852
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242012AbiATJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:25:04 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A6C8B40023
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642670702;
        bh=EJnsqS+Yl91TEoL6UGlpWnR4T5zcb/hsyJCaq1j9yiE=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=gnzZp9sFb4Id3GlxWDU39mWGg74rfCalSHe/ju9XIzT61Zj5TeJ7nc7kl3Kf+tCJA
         WpH/a6ZfdDYbj3LuoLbjCi9Q1LkUOcRXj2N5WO4gbK1Ul7YR/H/vlWiZwkgIGDhrzQ
         H8EtGDiSVrH/pBESnr8ojxTLCl6VYVm+/oNuHWLHMX3tQlotJVIF6jL585AqdwZM//
         xD9PZRlUQ/6hBxCyL5X2bd00cjjx2bs+GTy5dHzU4tMT97zzfi0tUjgGpYewN8z/J9
         cctQNZ8Mg6p5EMeAPDz21QNI5cE/ktexREpzZljxCfVeFW67587biAqgOC48cesR5R
         8OvvGQYg7f5CQ==
Received: by mail-ed1-f70.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso5369126edi.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EJnsqS+Yl91TEoL6UGlpWnR4T5zcb/hsyJCaq1j9yiE=;
        b=h+SPg4oTCCJm+DECYBNk/nToO/6CAXx5COoV6kbcKI7A6emT7WDv9O6fDcn1jd/6EA
         pvaSOxcLLf7+NXl+z6IqAqvdQSIihQArPT873YuAY3rH2xcgd2Cpeiy/Pklm3KL74QZ9
         QzFiDozKDBByW6uq1zK9GIMzJ8xZMGd45UPQxMFinExePwRxJRao9sjMfLXCaw/qrGC1
         qEA6brjtgY+I0JtC7ZeWqAZi4b7ClZrKVQpGVg3bnzojX/HIZwx6OQjvNf+ka/85IXXi
         syMd+za374Mh9yRLOSPBBnCU3sz+H/CMy7R3Ejd/iUKGtjeJZBAnM54JL9jAAFVj2gyn
         bHVQ==
X-Gm-Message-State: AOAM531x3ZXeH681+z0WRU13BFKTOZt9B5W4bhYNdeF78kiA4/wL9Hao
        HNv3fvVfd9FzOcy+i3Lf1Xzk9nSHv0Mp1elUEks8wVoGzYYYFmrwyMe9BweMCrRYVjPwiIkSzrl
        iCvEH7vCKYoOIBtmsvozlm0TSzRXM/oyLcKGLLaB1Yw==
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr17141455ejc.676.1642670701796;
        Thu, 20 Jan 2022 01:25:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKtVARCwsexGDUUf9MujOL36JGyNyCggPfIbaa5PrKFu5DBQFsqZtbJArlkq2kkmWtRBPDvQ==
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr17141437ejc.676.1642670701583;
        Thu, 20 Jan 2022 01:25:01 -0800 (PST)
Received: from krzk-bin (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id by22sm753903ejb.5.2022.01.20.01.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 01:25:00 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:24:59 +0100
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v3 2/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <20220120092459.gbaoief77p2tynaf@krzk-bin>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
 <20220112100046.68068-3-krzysztof.kozlowski@canonical.com>
 <20220119192758.z3lvlkaeyeiqi73a@ti.com>
 <5f912896-0635-fbe7-4fda-f4cb569190d9@canonical.com>
 <20220120070620.wyeosdstbfcsaplt@ti.com>
 <0c0a22ed-2c4b-374c-4f4c-06afd4e8681d@canonical.com>
 <20220120090002.hg4jmb7q2s25k64y@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120090002.hg4jmb7q2s25k64y@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 02:30:02PM +0530, Pratyush Yadav wrote:
> On 20/01/22 08:36AM, Krzysztof Kozlowski wrote:
> > On 20/01/2022 08:06, Pratyush Yadav wrote:
> > > On 19/01/22 08:49PM, Krzysztof Kozlowski wrote:
> > >> On 19/01/2022 20:31, Pratyush Yadav wrote:
> > >>> On 12/01/22 11:00AM, Krzysztof Kozlowski wrote:
> > >>>> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> > >>>> controller bindings to DT schema format
> > >>>>
> > >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > >>>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> > >>>> ---
> > >>>>  .../spi/samsung,spi-peripheral-props.yaml     |  35 ++++
> > >>>>  .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
> > >>>>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
> > >>>>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
> > >>>>  MAINTAINERS                                   |   2 +-
> > >>>>  5 files changed, 224 insertions(+), 123 deletions(-)
> > >>>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> > >>>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
> > >>>>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> > >>>> new file mode 100644
> > >>>> index 000000000000..aa5a1f48494b
> > >>>> --- /dev/null
> > >>>> +++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> > >>>> @@ -0,0 +1,35 @@
> > >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >>>> +%YAML 1.2
> > >>>> +---
> > >>>> +$id: http://devicetree.org/schemas/spi/samsung,spi-peripheral-props.yaml#
> > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>> +
> > >>>> +title: Peripheral-specific properties for Samsung S3C/S5P/Exynos SoC SPI controller
> > >>>> +
> > >>>> +maintainers:
> > >>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > >>>> +
> > >>>> +description:
> > >>>> +  See spi-peripheral-props.yaml for more info.
> > >>>> +
> > >>>> +properties:
> > >>>> +  controller-data:
> > >>>> +    type: object
> > >>>> +    additionalProperties: false
> > >>>> +
> > >>>> +    properties:
> > >>>> +      samsung,spi-feedback-delay:
> > >>>> +        description: |
> > >>>> +          The sampling phase shift to be applied on the miso line (to account
> > >>>> +          for any lag in the miso line). Valid values:
> > >>>> +           - 0: No phase shift.
> > >>>> +           - 1: 90 degree phase shift sampling.
> > >>>> +           - 2: 180 degree phase shift sampling.
> > >>>> +           - 3: 270 degree phase shift sampling.
> > >>>> +        $ref: /schemas/types.yaml#/definitions/uint32
> > >>>> +        enum: [0, 1, 2, 3]
> > >>>> +
> > >>>> +    required:
> > >>>> +      - samsung,spi-feedback-delay
> > >>>
> > >>> I am not quite sure if this required would work here. Let's say another 
> > >>> controller also uses a controller-data node, but it contains a different 
> > >>> set of properties. Won't this cause an error to be raised for that 
> > >>> controller since this property is not there?
> > >>
> > >> The controller-data is Samsung SPI specific (does not exist in any other
> > >> binding), so why would controller-data get added to a different controller?
> > > 
> > > It does not as of now, but the name is fairly generic and some 
> > > controller in the future might use it. I do not think it is a good idea 
> > > to list required properties in X-peripheral-props.yaml in general since 
> > > all those will be collected by spi-peripheral-props.yaml and so will 
> > > apply to _all_ controllers that reference it.
> > 
> > Right, but have in mind this is merely a bindings conversion. These were
> > made like this long time ago.
> 
> Yes, but the bindings infrastructure is not capable of handling these 
> required properties as of now. So even if your next patch was _not_ 
> making it optional, I would still say you should drop the "required:". 
> Even though the property is actually a required one, we currently do not 
> have the means to express that.
> 
> > 
> > I think we can drop the "required:" entirely with the commit 3/4 which
> > makes it optional.
> 
> I would prefer you never add it in the first place.

If I understand correctly, you propose to squash next patch making it
optional to this conversion? I believe there is a value in splitting
conversion of existing bindings from making changes to the bindings, but
I don't mind squashing them if that is desired.

Best regards,
Krzysztof

