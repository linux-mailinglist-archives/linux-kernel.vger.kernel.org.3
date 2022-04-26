Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E465108F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354117AbiDZTac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352273AbiDZTa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:30:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF676E4F7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:27:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a15so18849486pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YrNAxfDrxxD766OcfeCfCclqIZpQa0twyturIx4zcDA=;
        b=lFpfuszm5sYEet8AFcmzLa4ajQqoQ28Y0ReAuZHGIDsHkytcZgVXGcB2HZzslryqop
         KuAHYH0lOOzehRzsz/JNBPOdO0QuUNhTGm2JIAXfwTsO7RK1dG6NtZdU2wcGETwnHgT7
         ERJZiZc94CGVpzdmoJXxJ6y/5gtpV9ksDeveb6drlh6e0+jqXTBo8hcp5Nw9TzKxleFI
         LDHft1G55yQmOC7+qC0MNvo/CLNnvOeWQrUfQq6tkotBoY0TfSqWyXdMY+2OlEECxnse
         vJ9KiPmxDEJDHRaqrzgw+O23TQleBL8JpBtCPJVrPaFM6wZ05Z6a2yKizbldHKlBgCmp
         NcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YrNAxfDrxxD766OcfeCfCclqIZpQa0twyturIx4zcDA=;
        b=5F7Rr4NLt3qkjQKTdhO7PRPx2LcpdoY7Gp3hh64iffSFV1uzyVFJ//QDW4MF2DGEHN
         dlytxSTXwcyFPaWy+o0VrXGJykEiQ9T0wDpNtXvpLJTatBSJASnfuHJq07l8sq5mnzJ3
         A6hrRDosBStw1IMPGXQztqpEgK8xHMyXd0dB9M27hYWmnpgMl/ex3a9vLugZdPsoqLcn
         hMjt7qLEu23OY+p9SeSEmtoKzLQDKoXvkxdradXCp6kK939WiQ80npiqiEhT/YqF2vJd
         qiLRw+tskGRjoDIt7MiqjEEEAG/mgYa1EAorfaWqyLqnRSnMFVV8vHSaZ9YroR+lw7wj
         wKmw==
X-Gm-Message-State: AOAM533B1V84BMPvacqUUoQr5eLTvEAS6gGQZULO//WbRr1vEemojTKR
        OqSvW+sDcNgmt3YVznAPoXr0/A==
X-Google-Smtp-Source: ABdhPJwsYXdbHr7lCZriH0/82+iIj0K6xR6VWQSP6+pPkBdDyb7ogFEs1NlZGQpGAY7kGVDfBzcLyQ==
X-Received: by 2002:a63:df0f:0:b0:3aa:436f:8784 with SMTP id u15-20020a63df0f000000b003aa436f8784mr20938313pgg.514.1651001239114;
        Tue, 26 Apr 2022 12:27:19 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:9bcd:e060:b370:70d8])
        by smtp.gmail.com with ESMTPSA id o2-20020a62f902000000b0050cfb6994e2sm13327322pfh.130.2022.04.26.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:27:18 -0700 (PDT)
Date:   Tue, 26 Apr 2022 12:28:18 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add ti,scale-data-fw
 property
Message-ID: <YmhH0gFFSfJmZkDX@x1>
References: <20220425052806.484590-1-dfustini@baylibre.com>
 <20220425052806.484590-2-dfustini@baylibre.com>
 <YmbKvN00F6vGawpE@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmbKvN00F6vGawpE@robh.at.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:22:20AM -0500, Rob Herring wrote:
> On Sun, Apr 24, 2022 at 10:28:05PM -0700, Drew Fustini wrote:
> > From: Dave Gerlach <d-gerlach@ti.com>
> > 
> > Add documentation for ti,scale-data-fw property to enable I2C PMIC
> > voltage scaling during deep sleep. The property contains the name of a
> > binary file for the CM3 firmware to load.
> > 
> > Based on previous work by Russ Dill.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > [dfustini: split from driver patch and convert to json-schema]
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml       | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> > index 88d690de050c..d2c248d82384 100644
> > --- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> > +++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> > @@ -40,6 +40,12 @@ description: |+
> >    override the pin's existing bias (pull-up/pull-down) and value (high/low) when
> >    IO isolation is active.
> >  
> > +  Support for I2C PMIC Voltage Scaling
> > +  ====================================
> > +  It is possible to pass the name of a binary file to load into the CM3 memory.
> > +  The binary data is the I2C sequences for the CM3 to send out to the PMIC
> > +  during low power mode entry.
> > +
> >  properties:
> >    compatible:
> >      enum:
> > @@ -67,6 +73,11 @@ properties:
> >        mbox_wkupm3 child node.
> >      maxItems: 1
> >  
> > +  ti,scale-data-fw:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Name of the firmware binary in /lib/firmware to copy to CM3 aux data
> 
> The location of firmware files is up to the OS.
> 
> Is there other firmware? If not, 'firmware-name' is the somewhat 
> standard property for this.
> 
> What's the default name?

Thank you for the suggestion.  I will change it to firmware-name as
this is the only type of firmware that this driver will need to load.

There is no default name for the firmware. The name depends on the board
being used. The current [1] possibilites are:

am43x-evm-scale-data.bin
am335x-bone-scale-data.bin
am335x-evm-scale-data.bin

Thank you,
Drew

[1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/tree/bin?h=08.02.00.006
