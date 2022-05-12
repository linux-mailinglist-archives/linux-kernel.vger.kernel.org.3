Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3B524D59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353940AbiELMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353882AbiELMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:48:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63301E0584
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:48:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e194so5132945iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNd3Gm8nUZ7PICSGljzFyVVDd1hZA/GzEUARiHu8reA=;
        b=P+s6nn3BAqL09cTQZHN1ewg0v6vl8jrsEONJYK8CKGpgYe3lx+uzP9HwD3eQJqN577
         3pqtxxiCI6YXx6P3O6QUpst4SV+8tyUqwfZWxep4F/+Ifhbf+6pdODLAAHQDQaz4Z3TF
         x5+2iqnQ9zyy8BDIvOatJegOBDMBt0yT0Y5TRrtUcWrqCnlNmM8flPTXWexwbfuf/dmK
         b6jyhgL61F6EeHqpnxc3rVnOKTkZzjMACalpFZ1OxT88LKcBij/OTYDUZRf95ZRMqFJs
         PabNAO8NU0/APnsHy6LFbcCvDl5IDaUR2wsB5mTWC3dOVNMIlrAVj9oZpbRQD3Gki5P7
         igPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNd3Gm8nUZ7PICSGljzFyVVDd1hZA/GzEUARiHu8reA=;
        b=l27hKly4CndXY9lQMwCzjBQMqTOegxmG2bXnlOAWDVZf/Cm2r/nyolJtKw2QNq07Dy
         yT3guv6Coebofj0Fd0Z/Vna+8A1c4lngAdHn2CizjOqJRKVq78y5h6bykO96IimgCJ10
         dG2Rx0+ZAEI4zNMn4/f+XZoDqSd5bkqAu7RNJBaXkN2jCzlCLfArbzO/TupqRpxT6+jK
         vsWp7Pppjp5ayBQ/VoRzpy4mvrngmSx9BHc0BbELdpmsCuQsyDMyz9VGYAkP8YGjd5an
         zFygIYyhFjL7H+AzQ8pSSaBhVEuD3A9Ym3E2jRPgsn0s3B2PlpOvcrWRzW73v4BnRl+W
         TFPQ==
X-Gm-Message-State: AOAM532xshMSR2C2lwiZMRWjJA9xOEk178tOuu3BiNK7p1hHjjzaFshq
        kqk008mvwdWBVzH0BiXpkTWvydHrru/IPiULHfyGsw==
X-Google-Smtp-Source: ABdhPJxmHajQAtmeAOa2hqK9jIE6Fvj7k4Q2daHftWuREJvjw97wdOFcHX4vJ74gWyi2jlegcsdeaAeZ+9EvNgHAy2U=
X-Received: by 2002:a5d:9e17:0:b0:657:b212:c97e with SMTP id
 h23-20020a5d9e17000000b00657b212c97emr13187580ioh.176.1652359688147; Thu, 12
 May 2022 05:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220510124929.91000-1-robert.marko@sartura.hr>
 <20220510124929.91000-2-robert.marko@sartura.hr> <0815f581-ca5b-6fb6-a59e-f5d0a3686caa@linaro.org>
 <CA+HBbNFnXoEghSdhTYoC-VvCMkiEuuee9p8SuNGubYCeLWoYfA@mail.gmail.com> <41cc4506-57be-a831-57d5-e539e8a95610@linaro.org>
In-Reply-To: <41cc4506-57be-a831-57d5-e539e8a95610@linaro.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 12 May 2022 14:47:57 +0200
Message-ID: <CA+HBbNGvXtGhuxRgz-7VSPh1HJwdeTOD1fU7rWV2xBEvhf2WYA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] dt-bindings: marvell: convert Armada 37xx
 compatibles to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 2:36 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/05/2022 14:26, Robert Marko wrote:
> > On Wed, May 11, 2022 at 6:52 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 10/05/2022 14:49, Robert Marko wrote:
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> >>
> >>> -
> >>> - - compatible: must contain "cznic,turris-mox"
> >>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> >>> new file mode 100644
> >>> index 000000000000..3f41ef2c6f3e
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> >>> @@ -0,0 +1,50 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Marvell Armada 37xx Platforms Device Tree Bindings
> >>> +
> >>> +maintainers:
> >>> +  - Robert Marko <robert.marko@sartura.hr>
> >>> +
> >>> +properties:
> >>> +  $nodename:
> >>> +    const: '/'
> >>> +  compatible:
> >>> +    oneOf:
> >>> +      - description: Armada 3710 SoC
> >>> +        items:
> >>> +          - const: marvell,armada3710
> >>
> >> This does not look correct. The SoC usually cannot be used by itself,
> >> it's always a part of some product, SoM, board.
> >
> > Hi Krzysztof,
> > Currently, there are no Armada 3710 boards present in Linux, so I just
> > put the SoC compatible.
> > If that is not appropriate, I can drop it.
>
> Yes, please drop it.
>
> It seems several Marvel boards and bindings use wrong convention for
> compatibles. We discussed it here:
> https://lore.kernel.org/all/1ed03960-77f6-1a9e-2378-07a6c51f42f7@linaro.org/
> AC5 and CN9130 have the same wrong patterns.
>
> >
> >>
> >>> +
> >>> +      - description: Armada 3720 SoC
> >>> +        items:
> >>> +          - enum:
> >>> +              - marvell,armada-3720-db
> >>> +              - globalscale,espressobin
> >>> +              - cznic,turris-mox
> >>> +              - methode,udpu
> >>
> >> Order by name.
> > Will fixup in v3.
> >
> >>
> >>> +          - const: marvell,armada3720
> >>> +          - const: marvell,armada3710
> >>> +
> >>> +      - description: Globalscale Espressobin boards
> >>> +        items:
> >>> +          - enum:
> >>> +              - globalscale,espressobin-emmc
> >>> +              - globalscale,espressobin-ultra
> >>> +              - globalscale,espressobin-v7
> >>> +          - const: globalscale,espressobin
> >>> +          - const: marvell,armada3720
> >>> +          - const: marvell,armada3710
> > Do these const compatibles also need to be in alphabetical ordering,
> > cause I ported them as they are meant to be used with the board and
> > then 3720 compatibles being in front of 3710 one as required by the current
> > text bindings.
>
> Entries in enum should be ordered alphabetically. Then the entire set "-
> description: Globalscale Espressobin boards" should have some logical
> order, not necessarily by name.
>
> Anyway this is not a requirement but rather suggestion because having
> things ordered reduces amount of conflicts when two people add new
> boards (because they add it not at the end, but somewhere in the middle
> following some order).

Hi,
understood, will send a v3 soon.

Regards,
Robert
>
>
> Best regards,
> Krzysztof



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
