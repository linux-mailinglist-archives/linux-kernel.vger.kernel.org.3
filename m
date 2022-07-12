Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512A572924
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiGLWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiGLWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:17:20 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91746C8EB9;
        Tue, 12 Jul 2022 15:17:19 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id a20so5698842ilk.9;
        Tue, 12 Jul 2022 15:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RObMc02t+WfPk9jeU/CAK3gKiv4t+C98B3+Wgqb9iOI=;
        b=JBFYIM3nVDhc21861uYhnJiwMOO41UOQDAldOz9rKEc6+CD/lob4XnfsxtV42VAu9J
         2ybH4MVN7J4ODKdbqEWJIbzWkGzG3gl5+JQnBijfYSRVrqBhoUNfZdnqmwGQyK1bHBGD
         xH9xsTAZHdD9P6B+Fjyj05OvA13xl50ZNkygJ61bgLvBWHywVM1IC3EOvNaV97r1t1ct
         sNCwy46qRA5pou45IlrD5+yyOKcFUr3Tp2wxF5LG5KrGqR9nBm1c7Xtb6WsoYrmfQO6O
         KfjcKzF3DlEQfElbnkCa4Ewe+k8stJj65jiMxMNkwO5YK23HRYWvxYiv1TvOR7g+D+GD
         9Beg==
X-Gm-Message-State: AJIora+n7NQ19ZFyVpVLPxldmSxlXvFrY33gOiXTKJAx56DLQFZhqshQ
        ZIml2bDvCQliXzFNatkyDgpwE4ptJg==
X-Google-Smtp-Source: AGRyM1veasA2cLvMV1USkfsnPSymf/oUdQBcz43HrDFq0MZeNLk1n2jeyeynmVGvNRE1CWwd0P5aaQ==
X-Received: by 2002:a92:ca0b:0:b0:2dc:1c04:67f6 with SMTP id j11-20020a92ca0b000000b002dc1c0467f6mr222356ils.124.1657664238656;
        Tue, 12 Jul 2022 15:17:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m21-20020a02a155000000b00339e2f0a9bfsm4613027jah.13.2022.07.12.15.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 15:17:18 -0700 (PDT)
Received: (nullmailer pid 2459492 invoked by uid 1000);
        Tue, 12 Jul 2022 22:17:15 -0000
Date:   Tue, 12 Jul 2022 16:17:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Message-ID: <20220712221715.GT1823936-robh@kernel.org>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712100113.569042-4-ben.dooks@sifive.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:01:09AM +0100, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++

Use compatible string for filename.

>  drivers/pwm/Kconfig                           |  5 +-
>  drivers/pwm/pwm-dwc.c                         | 53 +++++++++++++++++++
>  3 files changed, 96 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> new file mode 100644
> index 000000000000..38ac0da75272
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-synposys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys PWM controller
> +
> +maintainers:
> +   - Ben Dooks <ben.dooks@sifive.com>
> +
> +properties:
> +  "#pwm-cells":
> +    description: |
> +      See pwm.yaml in this directory for a description of the cells format.

pwm.yaml doesn't define how many cells. You need to. And you don't need 
generic descriptions.

> +
> +  clocks:
> +    items:
> +      - description: Interface bus clock
> +      - description: PWM reference clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: timer
> +
> +  compatible:

Convention is compatible comes first in the list.

> +    oneOf:
> +      - items:
> +        - const: snps,pwm

Don't need oneOf or items. Just 'const: snps,pwm'.

That's pretty generic for a compatible. There's only 1 version of the IP 
or is the version discoverable?

> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
