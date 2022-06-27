Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8495455C42C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiF0UzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiF0Uy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:54:58 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E52AD8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:54:56 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w83so14550532oiw.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wu8FbJfJ+Q9MxmPPrAR91FAjnYekUfFagsceeKXjh0=;
        b=loSSV131mIFKt3HpYTok7q4CoL9EKNUepLdX1KxCRXfu8a57sYL2uzn14dMUx/gSSk
         VFxRQ53JaaPjOhxKg5QR/5lW7P6NuePeUVL8A45QCT0xNOi9ZcH2Kag49Pz3PQOddYhD
         832ct3sFqIPJsHlWcoVfdoi5ySm8yAflN71laKCOlM331XmwE5gKW29jvnTW8ZJ/bk+F
         Kmo+p5JbqhBZM1+smuwJ7F6i3aM5zbHfZieorgBQGA4UCHs99cTdVgIKqBI1s1EwBena
         Q9rzvAN5ccj9luYtSSME8+YZ/NhcLOf60XnbyjjhH/mkAhE2aJe7mQR5szplNQzUh3rP
         vzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wu8FbJfJ+Q9MxmPPrAR91FAjnYekUfFagsceeKXjh0=;
        b=3vqnds5rp+MOjg02kxVjcWLepQB0d+3884rjH+BQTz4VT96fCpgQh6srtVSnSHUicK
         Z0YA4vy6iLvfr4Jcc3aYT65i0vKWZpN3aKtyF3DqyUHXLm2CacJS70AqPeDo5c8SCxOQ
         ydUqiM7pWUS/T3G8AI18z/WGxJ39huaSgRlPcfz1uvaBYlU6DOZVMxj1GC8Zb7LrsRNN
         zL4fNmTw7ZvW0tGEho9wG+k4DTbyi5sEcfkbLYPVLmaXY5X9CtBT2tf9WvCh7ZZyDcoS
         U6r8riPxWT69zp1dRoP38vWyUBiplAj8+vpJIUBC4IYwQPahL8B2AUn41NIp0rPLEPEk
         0CSw==
X-Gm-Message-State: AJIora9R7vqlRR9euZpQcgondP3pcxaXeC7xc1BTlK0hOXaEFxPHlaQ1
        FsFrdkJYIrof0CYPuU+kc6e/HA==
X-Google-Smtp-Source: AGRyM1tgbmKXwzWoirqUL53jUbbUZ64FHe+zsXVc527cYaSy3639GImZYXL6jCmaQhREfAnBhkhhDg==
X-Received: by 2002:a05:6808:1202:b0:2f9:c7b4:fd56 with SMTP id a2-20020a056808120200b002f9c7b4fd56mr8925688oil.55.1656363296088;
        Mon, 27 Jun 2022 13:54:56 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w12-20020a056870a2cc00b000f33624baa4sm7751272oak.18.2022.06.27.13.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:54:55 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:54:53 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Message-ID: <YroZHWEbVK5BHEFM@builder.lan>
References: <20220430060125.9124-1-ansuelsmth@gmail.com>
 <20220430060125.9124-4-ansuelsmth@gmail.com>
 <fec305d1-d4b3-3f9d-bc31-bc33490d1ad7@linaro.org>
 <626d4cbf.1c69fb81.e6965.76b4@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626d4cbf.1c69fb81.e6965.76b4@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30 Apr 02:42 CDT 2022, Ansuel Smith wrote:

> On Sat, Apr 30, 2022 at 04:40:54PM +0200, Krzysztof Kozlowski wrote:
> > On 30/04/2022 08:01, Ansuel Smith wrote:
> > > Convert kpss-gcc driver Documentation to yaml.
> > > Add #clock-cells additional binding to required bindings and example
> > > as it's a required binding for clock-output-names.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > 
> > 
> > (...)
> > 
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - qcom,kpss-gcc-ipq8064
> > > +          - qcom,kpss-gcc-apq8064
> > > +          - qcom,kpss-gcc-msm8974
> > > +          - qcom,kpss-gcc-msm8960
> > > +      - const: qcom,kpss-gcc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: phandle to pll8_vote
> > > +      - description: phandle to pxo_board
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: pll8_vote
> > > +      - const: pxo
> > > +
> > > +  clock-output-names:
> > > +    const: acpu_l2_aux
> > 
> > It does not make sense having a constant output name. What is the
> > meaning this property in such case? The original binding did not enforce it.
> > 
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> Mh. Should I just drop the const and put a description referring to an
> advised name? The driver with the kpss-gcc hardcode the name to
> acpu_l2_aux that's why I thought it was a correct conversion using a
> const but I assume this is another problem of not making a correct 1:1
> conversion and adding fixes on pure conversion.
> Think I should drop it and put a description to it. (and then later fix
> it when I will push the other series with all the tweaks)
> 
> What do you think?
> 

The typical reason for using clock-output-names is that we have some
consumer that finds the clock based on global name lookup. Over time
we've been moving these to use .fw_name or .index based lookup, which
removes this problem.

But I don't see that being the case here. So my suggestion is that you
just drop clock-output-names from the binding, which will solve
Krzysztof's objection.


From there we can review what needs to be done in the Linux driver to
work with the improved binding.

Regards,
Bjorn
