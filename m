Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B038346A068
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444958AbhLFQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442267AbhLFPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:52:19 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E23C036FA0;
        Mon,  6 Dec 2021 07:36:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id a11so11443945qkh.13;
        Mon, 06 Dec 2021 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ueUGZY4zQTkUeijQ/NC4vlBAXF1KTkDDMmUCfB1Bq2E=;
        b=GD2PCzdAtWW+9Rxl1fm57BsgXMBO/Bvc4axX5YKw6+REkxj/vsiIy8dt5MBDGKUUuF
         xyKknB94C4PA+6b5qzG4Hy51Y5H0hyQCIWoyngs46AeI904/vM/ffYy1v1rCDUjc77VI
         wDcR2CLAQk5SLXPE1jf/T1grB5o3IOiElv+okiwEaRZGvys2zjUqJKhUE25SpvT1qAwL
         OtreLXINzn9NrCNnqDtKBeBlg0vt1bB93XzfWd9CEi2Np1Vg7NyF+8ipfnHcG4CtQ8wH
         1fFZ5A82XfTvIArcmbApXWwnNSf8UQkNMQxvsNJ7oMByaZRihU6zMu/RzxOpCALsOApp
         j5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ueUGZY4zQTkUeijQ/NC4vlBAXF1KTkDDMmUCfB1Bq2E=;
        b=AFCwuFabUtuhnGt/65TCgecZAqh8ulRojod9IBix8hdb68CYuhZ3Y5+49KLWx/MZ3R
         RsiImmJ55aSpUKrq01xiXEDKQeljSEmm8c1BRLNG8NcPpZqucmTO0Z9WemuaLgeLkQj5
         J+oIm1589NRLDuHWZSYIrIarvKwjk25dwrFb9wtKCvYKku9ChFEwof61ihd1MU11jnIC
         6+HE/0EHzc5lyCL2Zquu6yWYg19DxbsFnQ7oqwc7YzoL8NC/X6x0LdlvhAvPTUu4szE6
         PKU73TW8VYvb/PJKr5+sQrTe8Kj1HwLat8J6zbvNYRHzb2+QzL/RZjACew2QSCJjYSrJ
         asjw==
X-Gm-Message-State: AOAM5308BnaHRXnUi+j8l7mrMbWeejaIl1hf4YZL5V6p6h7pguHEEC1S
        1prQEUUD3K6QjLVXKlghAFw=
X-Google-Smtp-Source: ABdhPJx9R6dJ8dive3vst13k48x2FiWzvufEUAAQK6cOWeipW37fuwe9MuGPqXHzfYXNgJN2RJQXgA==
X-Received: by 2002:a05:620a:85e:: with SMTP id u30mr33486128qku.765.1638805012306;
        Mon, 06 Dec 2021 07:36:52 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id 143sm6515612qkg.87.2021.12.06.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:36:51 -0800 (PST)
Date:   Mon, 6 Dec 2021 10:36:49 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Message-ID: <Ya4uETXlJc7PMY81@errol.ini.cmu.edu>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-3-gsomlo@gmail.com>
 <CAMuHMdVJZp+YuaDnXabOgeTajNo0JA9nwCmkiTg2=69L9-6-ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVJZp+YuaDnXabOgeTajNo0JA9nwCmkiTg2=69L9-6-ew@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Dec 06, 2021 at 11:18:18AM +0100, Geert Uytterhoeven wrote:
> On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > LiteSDCard is a small footprint, configurable SDCard core for FPGA
> > based system on chips.
> >
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> And after reviewing the driver...
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/litex,mmc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LiteX LiteSDCard device
> > +
> > +maintainers:
> > +  - Gabriel Somlo <gsomlo@gmail.com>
> > +
> > +description: |
> > +  LiteSDCard is a small footprint, configurable SDCard core for FPGA based
> > +  system on chips.
> > +
> > +  The hardware source is Open Source and can be found on at
> > +  https://github.com/enjoy-digital/litesdcard/.
> > +
> > +allOf:
> > +  - $ref: mmc-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: litex,mmc
> > +
> > +  reg:
> > +    items:
> > +      - description: PHY registers
> > +      - description: CORE registers
> > +      - description: DMA Reader buffer
> > +      - description: DMA Writer buffer
> > +      - description: IRQ registers
> 
> The last one is optional...
> 
> > +
> > +  reg-names:
> > +    items:
> > +      - const: phy
> > +      - const: core
> > +      - const: reader
> > +      - const: writer
> > +      - const: irq
> 
> Likewise.
> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> reg-names, as the driver needs it (and it's good practice anyway).
> 
> > +  - interrupts
> 
> Interrupts is optional.
> 
> I tried to link it to reg{,-names}:
> 
>     if:
>       not:
>         required:
>           - interrupts
>     then:
>       properties:
>         reg:
>           maxItems: 4
>         reg-names:
>           maxItems: 4
> 
> but that doesn't seem to work. Anyone with a clue?

For now I'm queueing this up for v3, unless we get more ideas:

@@ -29,7 +29,9 @@ properties:
       - description: CORE registers
       - description: DMA Reader buffer
       - description: DMA Writer buffer
-      - description: IRQ registers
+      - description: IRQ registers (optional)
+    minItems: 4
+    maxItems: 5
 
   reg-names:
     items:
@@ -37,7 +39,9 @@ properties:
       - const: core
       - const: reader
       - const: writer
-      - const: irq
+      - const: irq (optional)
+    minItems: 4
+    maxItems: 5
 
   interrupts:
     maxItems: 1
@@ -45,7 +49,7 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
+  - reg-names

Some of the *.txt formatted files in Documentation/devicetree/bindings/mmc
had an explicit "Optional" section, but all the .yaml formatted ones
just seem to assume that if it's not under `required:`, it's
implicitly optional. So I'm removing `interrupts` from `required`, and
adding `reg-names`, as you pointed out.

Thanks,
--Gabriel

 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    mmc: mmc@12005000 {
> > +        compatible = "litex,mmc";
> > +        reg = <0x12005000 0x100>,
> > +              <0x12003800 0x100>,
> > +              <0x12003000 0x100>,
> > +              <0x12004800 0x100>,
> > +              <0x12004000 0x100>;
> > +        reg-names = "phy", "core", "reader", "writer", "irq";
> > +        interrupts = <4>;
> > +    };
> > --
> > 2.31.1
> >
> 
> 
> -- 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
