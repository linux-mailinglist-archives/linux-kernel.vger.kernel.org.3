Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9D4FEA24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiDLWc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 18:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiDLWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 18:32:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD22F61F1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:17:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h5so17437234pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LzVK1IQoHy6inUcYifHpyKq1c6gHZpZ4adL9ShMc3pA=;
        b=MboutHxzQOdqFgBiScTBM+v/RlZEwIWrI+SZ3TVlCwgU+E9p0LkJo87yLyopNsrq5k
         dZZ10V3nV4vGnJc1QW7qQRCY3XJMbBDPF/yfhsJ0/SYi9EHz2tPlogkv5U/fbAHrO3D7
         Up9M4Wb5HbUddlf9lmOjzcQPNX9FBjvUAcRzkSoCKAIfLSp8CXnhjxB5J7oEUSpdrqfn
         vi6eU8Fhy18Nm87Tjfcmq/7CMnx8ZKU0a+YF9jRvw3aP/OYbBkMvRPOC4spqXEZQQ2wS
         XKuexO0eLcuSUV4SdH2sX1NOBa2FUqE6RcK0yqhCgwRA2JCr8VtRLgC/JdWnY9xTYfPn
         lnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LzVK1IQoHy6inUcYifHpyKq1c6gHZpZ4adL9ShMc3pA=;
        b=w7UcXEgvSOsau/6dAukrSRyhRw2i7SkW3Izfny7QNCS3wgKNIW7KJmRDQIfQ+x2lsv
         XhqKzgOp0uv3gvPH6GwurvItg874sqBQiTAA/RKQh2JqXxKsGHYFPUVC+/hHD0wT99Yw
         FQVMmfMSWIAUHt3dcyDNGZnwqdFByYn1F6Msx2lLcW0coyUPfmOEqNhKp2kgrXMxDjAv
         8rYfoQAtfw/XJ0jlhYc7VqfN/Lw+x+d5pPsyx9Up/yeZ/wYU5E6HVQozq6bQc4pRxcvy
         PQXvDZTERD898LtwG4b0ml5ZbPUIr6bgFLzJofQLYA6tlRO97TiDfmNjeuen71ml1GqP
         Nr1w==
X-Gm-Message-State: AOAM530Z8io6+jGZcyGxD9l7kXJjce2pkM/KmPhD1/eQpcIJoBFR2+RY
        JQMaZs1bCzi/afG4Ah3VSrcjjA==
X-Google-Smtp-Source: ABdhPJy9vH/5dk5SdPO+gnx9Vvk/LPSJEnQ7v+hjjt1g34/aCd4gYXgqkvlvOAi0xia+ZZQe6U2P9Q==
X-Received: by 2002:a05:6a00:150d:b0:505:c6f0:686e with SMTP id q13-20020a056a00150d00b00505c6f0686emr6502605pfu.37.1649798079559;
        Tue, 12 Apr 2022 14:14:39 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:669f:cec7:c0c2:1cc])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm38195522pfw.144.2022.04.12.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:14:39 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:15:24 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle gpio pin
 property
Message-ID: <YlXr7M/HXvlXWftR@x1>
References: <20220409211215.2529387-1-dfustini@baylibre.com>
 <20220409211215.2529387-2-dfustini@baylibre.com>
 <YlXY88aJIrcHc5Bc@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXY88aJIrcHc5Bc@robh.at.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 02:54:27PM -0500, Rob Herring wrote:
> On Sat, Apr 09, 2022 at 02:12:14PM -0700, Drew Fustini wrote:
> > Document Wakeup M3 IPC property that indicates a GPIO pin is connected
> > to the enable pin on DDR VTT regulator and can be toggled during low
> > power mode transitions.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > [dfustini: converted to YAML, removed unnecessary "ti,needs-vtt-toggle"]
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml     | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> > index d855c01ce61c..7f4a75c5fcaa 100644
> > --- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> > +++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> > @@ -24,6 +24,14 @@ description: |+
> >    A wkup_m3_ipc device node is used to represent the IPC registers within an
> >    SoC.
> >  
> > +  Support for VTT Toggle
> > +  ==================================
> > +  On some boards like the AM335x EVM-SK and the AM437x GP EVM, a GPIO pin is
> > +  connected to the enable pin on the DDR VTT regulator. This allows the
> > +  regulator to be disabled upon suspend and enabled upon resume. Please note
> > +  that the GPIO pin must be part of the GPIO0 module as only this GPIO module
> > +  is in the wakeup power domain.
> > +
> >  properties:
> >    compatible:
> >      enum:
> > @@ -51,6 +59,10 @@ properties:
> >        mbox_wkupm3 child node.
> >      maxItems: 1
> >  
> > +  ti,vtt-gpio-pin:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: GPIO pin connected to enable pin on VTT regulator
> 
> Looking at the driver, can't you add 'maximum: 31' here? If so, I can 
> add it when applying.

Yes, good idea. I would appreciate it if that was added when applying.

Thank you,
Drew
