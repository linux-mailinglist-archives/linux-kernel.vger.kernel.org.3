Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2FA518D83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiECT6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiECT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:58:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A2E3F8BB;
        Tue,  3 May 2022 12:55:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id be20so21045071edb.12;
        Tue, 03 May 2022 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+DEWzHhrxACEjCwf7T0XjTn5ZBDS8HwV0VUoztADHg=;
        b=dWLQHeoIxj+f1p4NCW93iqTklgcPL8WN0VuU+snkXlk2e1hf/c1RslsVyzMpo2rubA
         aZXIFZUrQG8a+AyRVzwzNx4AWUU+bUr21V+BiFmJ56ovyWrWbxyDAn3BvwRUjlNZzaA+
         2pbWWBgON/CUoe/eI+HkhFGZ74Xt/QC0HWHDGK13u6ECrm+y1OX8PqX6f6pN7NmsV8CN
         lvFk9hEsITGgScX/jyvHbEIg4J7rsMYP3IAq4FFqLh4CYMnmw3NgJ1m+5IALM1N/M0tB
         93TM1R0pam1GOV+dM0YG942rezIGdI63lEAjEb+x5tCWD1/MyXGdvekj8hgNttSjmCPc
         wLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+DEWzHhrxACEjCwf7T0XjTn5ZBDS8HwV0VUoztADHg=;
        b=5LkBR0rAN4rLFzAlg6Q5GgaDZpMRIJ0k/pwnTRkC+PJCtjo7k3jjGEwrVXh/50+SfS
         sRWx2QElzhsChAuuDBciFLdY2pydE14l91UMMW3FFs258rwMr2xlibOoGk2GeIcd5CUd
         0vDPjNUYH+wSUae1jXeMXOVbb4TSlN8yPHcfIElFFssnRSQxOYwx/3VJEuHiy0Vg4EaX
         U35vo4DjL0YFYZJPvGNwr8+AD9+wwrDPQubUGMjjjAwXF5quuumtNT2v7Mil+PYkH28h
         vbFx+uW1k73EyjcwrwonHbhtdG2zAlmdBhWLpfraSMy0btC8x/aXXkqU/4azE+GMBVdt
         Lchg==
X-Gm-Message-State: AOAM531691K6zQe2KgqIWNtEt02tVm2/7OhP3ewVONEr1yNIhsjzdfgZ
        w+syhSVvHpyWjC4mtAL9xsA=
X-Google-Smtp-Source: ABdhPJxVyHdtQ9I2qKWzhlqsVlMnvcDSlegTZwE6qyb2HVxhTsJ1dRUbc42Lcopb65c/ra5IlrQMqQ==
X-Received: by 2002:a05:6402:2142:b0:413:6531:bd9e with SMTP id bq2-20020a056402214200b004136531bd9emr19319635edb.5.1651607709862;
        Tue, 03 May 2022 12:55:09 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id g3-20020a50ee03000000b0042617ba63acsm8337929eds.54.2022.05.03.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:55:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     icenowy@outlook.com, Rob Herring <robh@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: Re: [PATCH 05/12] dt-bindings: clock: sunxi-ng: add bindings for R329 CCUs
Date:   Tue, 03 May 2022 21:55:08 +0200
Message-ID: <1910544.usQuhbGJ8B@kista>
In-Reply-To: <YnBOY2EjW5ZWCAkx@robh.at.kernel.org>
References: <20220422140902.1058101-1-icenowy@aosc.io> <BYAPR20MB2472A5F7269F56C2C6BB3104BCF79@BYAPR20MB2472.namprd20.prod.outlook.com> <YnBOY2EjW5ZWCAkx@robh.at.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 02. maj 2022 ob 23:34:27 CEST je Rob Herring napisal(a):
> On Fri, Apr 22, 2022 at 11:41:08PM +0800, icenowy@outlook.com wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > R329 has a CPUX CCU and a R-CCU, with all PLLs in R-CCU.
> > 
> > Add bindings for them, with R-CCU only taking 3 oscillators as input and
> > main CCU taking oscillators + PLLs as input.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  .../clock/allwinner,sun4i-a10-ccu.yaml        | 62 ++++++++++++++--
> >  include/dt-bindings/clock/sun50i-r329-ccu.h   | 73 +++++++++++++++++++
> >  include/dt-bindings/clock/sun50i-r329-r-ccu.h | 45 ++++++++++++
> >  include/dt-bindings/reset/sun50i-r329-ccu.h   | 45 ++++++++++++
> >  include/dt-bindings/reset/sun50i-r329-r-ccu.h | 24 ++++++
> >  5 files changed, 241 insertions(+), 8 deletions(-)
> >  create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
> >  create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
> >  create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
> >  create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-
ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-
ccu.yaml
> > index 15ed64d35261..c7a429e55483 100644
> > --- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> > +++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> > @@ -45,6 +45,8 @@ properties:
> >        - allwinner,sun50i-h6-r-ccu
> >        - allwinner,sun50i-h616-ccu
> >        - allwinner,sun50i-h616-r-ccu
> > +      - allwinner,sun50i-r329-ccu
> > +      - allwinner,sun50i-r329-r-ccu
> >        - allwinner,suniv-f1c100s-ccu
> >        - nextthing,gr8-ccu
> >  
> > @@ -106,6 +108,7 @@ else:
> >            - allwinner,sun50i-a100-ccu
> >            - allwinner,sun50i-h6-ccu
> >            - allwinner,sun50i-h616-ccu
> > +          - allwinner,sun50i-r329-r-ccu
> >  
> >    then:
> >      properties:
> > @@ -118,14 +121,57 @@ else:
> >          maxItems: 3
> >  
> >    else:
> > -    properties:
> > -      clocks:
> > -        minItems: 2
> > -        maxItems: 2
> > -
> > -      clock-names:
> > -        minItems: 2
> > -        maxItems: 2
> > +    if:
> > +      properties:
> > +        compatible:
> > +          const: allwinner,sun50i-r329-ccu
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 13
> > +          maxItems: 13
> 
> This is (or should be) implied by the size of 'items'. Did you find that 
> to not be the case?
> 
> > +          items:
> > +            - description: High Frequency Oscillator (usually at 24MHz)
> > +            - description: Low Frequency Oscillator (usually at 32kHz)
> > +            - description: Internal Oscillator
> > +            - description: CPUX PLL
> > +            - description: Peripherals PLL
> > +            - description: Peripherals PLL (2x)
> > +            - description: Peripherals PLL derivated 800MHz clock
> > +            - description: Audio PLL 0
> > +            - description: Audio PLL 0 (/2)
> > +            - description: Audio PLL 0 (/5)
> > +            - description: Audio PLL 1
> > +            - description: Audio PLL 1 (2x)
> > +            - description: Audio PLL 1 (4x)
> 
> > diff --git a/include/dt-bindings/clock/sun50i-r329-ccu.h b/include/dt-
bindings/clock/sun50i-r329-ccu.h
> > new file mode 100644
> > index 000000000000..116f8d13a9b3
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/sun50i-r329-ccu.h
> > @@ -0,0 +1,73 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2021 Sipeed
> 
> It's 2022.
> 
> > diff --git a/include/dt-bindings/clock/sun50i-r329-r-ccu.h b/include/dt-
bindings/clock/sun50i-r329-r-ccu.h
> > new file mode 100644
> > index 000000000000..c327d1a1b602
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> > diff --git a/include/dt-bindings/reset/sun50i-r329-ccu.h b/include/dt-
bindings/reset/sun50i-r329-ccu.h
> > new file mode 100644
> > index 000000000000..bb704a82443f
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/sun50i-r329-ccu.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> 
> > diff --git a/include/dt-bindings/reset/sun50i-r329-r-ccu.h b/include/dt-
bindings/reset/sun50i-r329-r-ccu.h
> > new file mode 100644
> > index 000000000000..40644f2f21c6
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> 
> Why the different licenses? GPL-2.0 OR BSD-2-Clause is preferred. MIT is 
> fine if that's what matches the dts files.

Yes, most, if not all, DT files for Allwinner are dual licensed under GPL2+ and 
MIT. There are still some files under include/dt-bindings which are dual 
licensed under GPL2+ and X11, but I believe those files are for older SoCs.

Best regards,
Jernej


