Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1284FAACC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbiDIUi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiDIUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:38:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1053AA72
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:36:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p25so4580820pfn.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ToaemIh0N/ictNMTY6+8rwYpqhr7q8UZjVORvPQt/1Y=;
        b=VrFx9bSfQ+cfWs6cBGHXR9DrCWbguRAu9pGUcToAoFl0OMrWqmJrS4UZ8HJrm1XmlA
         ON6bJiMXpSqwUItF6z5n1hBhNbWDRowvH/6ptVky3daXm/LYeOUiLh9B/kmy52D/tDaQ
         mNlpDgQNKap2oxboEiwlJZW+uUqOQl13LxJclL2yUwQ/Q4dbHeUn7crvm8cNtb0pCJgN
         RLO7nskSGcQIbgp9QjWq7akVn3HeobMjuCoG9VJkZ7UBfmLj4VnQ1kCoZ6Ec4FI7NPxc
         JIYY8AF+i9HLJkdXfbfYR0bSwEEmW9Cz7Ca7opz7Q/mYdsMbL+/C6JNXYStCUjBzGZ9d
         A65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ToaemIh0N/ictNMTY6+8rwYpqhr7q8UZjVORvPQt/1Y=;
        b=tKIY5SrKUIUnHAzoJJp4w+G4DV2Nl9Dz4+wlx0jbrqjNDVmrddnmEouUvyl8STjFPf
         nsgCez4ptCmDAeEASbd8SuLeBTG0uKSTEoTbIjsBd1ZnRnvEphbs8W6Aw+OM6IougmTo
         qwRk0jzhogOVUjrNersC2WExhJOEH4KIrEhgDFNbYZVED71Ecdm2funZZtmgH2eo3Jsy
         6kcYt60G0qBd+omAdo7N8ok5m1z665rv5jkIb2O6TO9MWCQT0RfY0h7x+b/gvyi5c+Vv
         WD9OZd6vBLQDGOsD9KfzcMBB5mz3g3rBbagGqviNgD/QQhXmw0tbx/E6iqOH5qRROS/+
         ns4w==
X-Gm-Message-State: AOAM530RCO9DnHZKkB8OguOMf442Z0Q8VY2P8cuaGfod1U71czyzcnNd
        wY15Sph2pBHY7lA9xol1nEIvpw==
X-Google-Smtp-Source: ABdhPJw/rmDw7bqHCMDpzikztX0oH3Td8uC+JRWeVwaLpimkoupGZubMwy2iGBHTimSdAcvPSSyFzQ==
X-Received: by 2002:a62:6dc3:0:b0:505:895a:d38b with SMTP id i186-20020a626dc3000000b00505895ad38bmr9336064pfc.7.1649536575239;
        Sat, 09 Apr 2022 13:36:15 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:925c:1a60:e433:31b7])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090ab01100b001ca8458964esm15629780pjq.18.2022.04.09.13.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 13:36:14 -0700 (PDT)
Date:   Sat, 9 Apr 2022 13:37:01 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle bindings
Message-ID: <YlHubYmrx2w/s20N@x1>
References: <20220409045145.2434096-1-dfustini@baylibre.com>
 <20220409045145.2434096-2-dfustini@baylibre.com>
 <c4536b89-4843-c669-e499-f82fa3fec7f8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4536b89-4843-c669-e499-f82fa3fec7f8@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 06:25:24PM +0200, Krzysztof Kozlowski wrote:
> On 09/04/2022 06:51, Drew Fustini wrote:
> > Document the Wakeup M3 IPC properties that can be used to toggle the VTT
> > regulator during low power mode transitions.
> >
> 
> (...)
> 
> > @@ -51,6 +61,15 @@ properties:
> >        mbox_wkupm3 child node.
> >      maxItems: 1
> >  
> > +  ti,needs-vtt-toggle:
> > +    type: boolean
> > +    description: boards requires VTT toggling during suspend/resume
> > +
> > +  ti,vtt-gpio-pin:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: pin on the GPIO0 module used for VTT toggle
> > +    maxItems: 1
> 
> No need for maxItems, it's a single uint32. You could add "maximum" if
> you know the constraints for the value.

Thank you for letting me know.

> Do you actually need two properties (bool + pin)? A case of
> "ti,vtt-gpio-pin" without the "ti,needs-vtt-toggle" is valid?

You raise a good point. In fact, the driver does nothing useful in the
case of "ti,needs-vtt-toggle" without "ti,vtt-gpio-pin". Therefore, I
will remove the "ti,needs-vtt-toggle" property.

> 
> The other way looks wrong, so you need to add a dependency (see
> example-schema).
> 
> 
> Best regards,
> Krzysztof

Thank you,
Drew
