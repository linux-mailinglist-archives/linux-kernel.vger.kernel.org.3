Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9D50C6D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiDWDD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiDWDDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:03:54 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55081FE6D3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:00:57 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t15so11126422oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z01ZX/eSD7gWHPOLzm6BsqAyU5hOlUHJpTNJkHkEOQk=;
        b=OQy5pbi2V8P7+8nbw7viv9EC72ztvMlIp4uoHQvN373CnFpxUXkLDcJiMbkwKSd1TX
         /xi8gjeHVmuqnUV1Nhr5n3MYF6tej6+mG4Nx6gOSWLEn/ftlyavgPCjR66kNssmEVtW1
         ARFGPOYoAHU7haQdipuTcAt1c3G4pfIpIRK0bn6qSnUDoYDU1Pz0euQJYi4criK9cuSh
         m1kIWx+93qHWQYcLG+6ArbyWnOmtbXkpGz7hYDfsgIhCLfqy2e0tYkQSzPzsaIu1epVS
         ad01IS6j8ABAIDLL/o03uYgzB5HTW9R+XMFXmtVenh77JzoAyYLQyDCylGJM47fmQRUW
         lWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z01ZX/eSD7gWHPOLzm6BsqAyU5hOlUHJpTNJkHkEOQk=;
        b=kfXyMidJVyj5iqrWhGjZLwxAOwoxPkJb/J7nXYMg++39Cla0typfCB/Uh6PkyS3ln0
         cB54tc0vUQYgXzfQf8G0tUcZZ/yoROyiWAZ5gflTQdJvmmIGVoB/XCEezLMZmkB5o9yC
         g5geNxZL4Ie5aIS4xwJKROmoXbsEsQok3nuhEwOJuc4iPTGH13kJT5sqOhexWq5tGXBd
         63Y7luHA+RvKQ1G5WrPQdmiQG8QO9wSBuFt1alaiBroQlFv3ZjQtjSs7a7LcAFEQqdyj
         1NR8jE4wYrLD71gATbRH730NstKtwx52PzlPBXJb7kz8EptFImU9Wiy0ag/D2xr6o2sH
         gsqA==
X-Gm-Message-State: AOAM531KC8et/Jbz3NVWYGfuRuXokv9X+LTz0JRtnj+ug1+G/eHOBm7H
        69EiaF6mSGc1xydyas5EC8j94o0DJIHYqzZf
X-Google-Smtp-Source: ABdhPJxaDzvRJf2bpiAF38YoDo5+oP+LcNWYr+r/d8JYzz3aKhSEJuv2rYkuoct5XvlvfFivi7Nskw==
X-Received: by 2002:a05:6808:1881:b0:322:9e57:9e56 with SMTP id bi1-20020a056808188100b003229e579e56mr7863341oib.97.1650682856893;
        Fri, 22 Apr 2022 20:00:56 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e67f5bd9b9sm1363747oae.45.2022.04.22.20.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 20:00:56 -0700 (PDT)
Date:   Fri, 22 Apr 2022 20:02:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC
 bindings
Message-ID: <YmNsYSxLtwLpw98t@ripper>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org>
 <20220423014824.912ACC385A0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423014824.912ACC385A0@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Apr 18:48 PDT 2022, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2022-04-22 16:00:12)
> > Add binding for the Qualcomm SC8280XP Global Clock controller.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Why no cover letter?
> 

I didn't have anything useful to write in it. Will provide you one in
the future...

> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> > new file mode 100644
> > index 000000000000..44e5f0d0a795
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> > @@ -0,0 +1,199 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gcc-sc8280xp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Global Clock & Reset Controller Binding for SC8280xp
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description: |
> > +  Qualcomm global clock control module which supports the clocks, resets and
> > +  power domains on SC8280xp.
> > +
> > +  See also:
> > +  - dt-bindings/clock/qcom,gcc-sc8280xp.h
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,gcc-sc8280xp
> > +
> > +  clocks:
> > +    items:
> > +      - description: XO reference clock
> 
> "clock" is redundant in all these descriptions. Please remove.
> 

You don't think it's a little bit odd to have description such as
"Sleep", "PCIe 2a pipe" or First EMAC controller reference"?

I mean I agree that it's obviously clocks we're talking about, but to me
that makes it seems like the descriptions are cut short, just for the
sake of avoiding "clock".

> > +      - description: Sleep clock
> > +      - description: UFS memory first RX symbol clock
> > +      - description: UFS memory second RX symbol clock
> > +      - description: UFS memory first TX symbol clock
> > +      - description: UFS card first RX symbol clock
> > +      - description: UFS card second RX symbol clock
> > +      - description: UFS card first TX symbol clock
> > +      - description: Primary USB SuperSpeed pipe clock
> > +      - description: gcc_usb4_phy_pipegmux_clk_src
> > +      - description: gcc_usb4_phy_dp_gmux_clk_src
> > +      - description: gcc_usb4_phy_sys_pipegmux_clk_src
> > +      - description: usb4_phy_gcc_usb4_pcie_pipe_clk
> > +      - description: usb4_phy_gcc_usb4rtr_max_pipe_clk
> > +      - description: Primary USB4 RX0 clock
> > +      - description: Primary USB4 RX1 clock
> > +      - description: Secondary USB SuperSpeed pipe clock
> > +      - description: gcc_usb4_1_phy_pipegmux_clk_src
> > +      - description: gcc_usb4_1_phy_dp_gmux_clk_src
> > +      - description: gcc_usb4_1_phy_sys_pipegmux_clk_src
> > +      - description: usb4_1_phy_gcc_usb4_pcie_pipe_clk
> > +      - description: usb4_1_phy_gcc_usb4rtr_max_pipe_clk
> > +      - description: Secondary USB4 RX0 clock
> > +      - description: Secondary USB4 RX0 clock
> > +      - description: Multiport USB first SupserSpeed pipe clock
> > +      - description: Multiport USB second SuperSpeed pipe clock
> > +      - description: PCIe 2a pipe clock
> > +      - description: PCIe 2b pipe clock
> > +      - description: PCIe 3a pipe clock
> > +      - description: PCIe 3b pipe clock
> > +      - description: PCIe 4 pipe clock
> > +      - description: First EMAC controller reference clock
> > +      - description: Second EMAC controller reference clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bi_tcxo
> > +      - const: sleep_clk
> 
> And "_clk" postfix is redundant in all these strings. Remove?
> 

In this case I think they should include _clk, as they actually matches
the clock names in the documentation.

Regards,
Bjorn

> > +      - const: ufs_phy_rx_symbol_0_clk
> > +      - const: ufs_phy_rx_symbol_1_clk
> > +      - const: ufs_phy_tx_symbol_0_clk
> > +      - const: ufs_card_rx_symbol_0_clk
> > +      - const: ufs_card_rx_symbol_1_clk
> > +      - const: ufs_card_tx_symbol_0_clk
> > +      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk
> > +      - const: gcc_usb4_phy_pipegmux_clk_src
> > +      - const: gcc_usb4_phy_dp_gmux_clk_src
> > +      - const: gcc_usb4_phy_sys_pipegmux_clk_src
> > +      - const: usb4_phy_gcc_usb4_pcie_pipe_clk
> > +      - const: usb4_phy_gcc_usb4rtr_max_pipe_clk
> > +      - const: qusb4phy_gcc_usb4_rx0_clk
> > +      - const: qusb4phy_gcc_usb4_rx1_clk
> > +      - const: usb3_uni_phy_sec_gcc_usb30_pipe_clk
