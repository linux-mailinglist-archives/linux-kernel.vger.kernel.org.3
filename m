Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D720E513C04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351364AbiD1TOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347415AbiD1TOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:14:15 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76CA8A32A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:10:57 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id l9-20020a4abe09000000b0035eb3d4a2aeso174801oop.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2aXsqerjLXA91XKgmdLKkKAKVBORFuGPtPebXTdU8DQ=;
        b=R0JEfLOaP4DoFmErPMfFEbjdIK/j5w9Qwzk61+EjAjK9AjUFPngr64Y9NwSK6B9o5z
         +w0R15px/1QmEpmkiCODYb3/BtPhdR0yxF1jgyCK+ACBHR2LddwOiKo2h8n0uvyhIA3j
         7Z3bzdXIE3Go0L9hSvwt750vWlyNZPRNGlj8ZHDAKDEqGxevy8wWanRsmTU2FKngaRaU
         eiTqyY5FgX/sye7F0A84crd7lsi5LwzCqCivl5Z6UD+wHNWrzylum+G2DlBiqwtADZXz
         nRr8mj18Mw5R/Pu66rTPU+nmus1nyJjbyAzF0HKDrpZ+qVoTLXODhsvDu/Shpiq0JcCU
         brfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aXsqerjLXA91XKgmdLKkKAKVBORFuGPtPebXTdU8DQ=;
        b=PGXNAtcZqQj61fLNRKiRxQqpsDH6o7SIP4vPEE9JOYNQuUF0rdLe28VTmrwfeK6Lp7
         jtSlStTF3bXW+y9OGbyyv/XsMsHvLG9f0a6hPUpNh3nwKtmO+gq17vFVBy1Ujt//hcWM
         Vb9s9YKAy9ndO1p1LjmuSMNvCEJbOxbPMR5fPz6RONXEpUKqeE8DrNV8QO59+vqZQEGX
         54lN2Hc0tyJzdL9kiNoHxbI+DZzzYFgdSM4tddAVLzAQRYPtSShX9mPyTwn5gIdxkCD3
         rGZsNRxnS+IFRVShDAdZiXXkHe2XmsDA7o3ttTw7p6JgudFVj9zg2SoItHQKOxltBYXX
         3ptQ==
X-Gm-Message-State: AOAM533nJrvzg+YcM47uZIGhUCW6s0lwMKBoZdd9PM/RyYSVDbhrfJUi
        jNJBto5hQvl/ybgOUXBN6WvHFA==
X-Google-Smtp-Source: ABdhPJzKBeopn16KqsmMbcXih08Js7rj7ornldsvddmz5pJjeqIV8lREl+AUtyHtmoRWFGSKZ4Ux3w==
X-Received: by 2002:a4a:942b:0:b0:33a:39e0:b908 with SMTP id h40-20020a4a942b000000b0033a39e0b908mr12379358ooi.62.1651173056919;
        Thu, 28 Apr 2022 12:10:56 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id ds10-20020a0568705b0a00b000e686d1387bsm2142927oab.21.2022.04.28.12.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 12:10:56 -0700 (PDT)
Date:   Thu, 28 Apr 2022 12:12:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC
 bindings
Message-ID: <YmrnMQwIR9wOeoKE@ripper>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org>
 <20220423014824.912ACC385A0@smtp.kernel.org>
 <YmNsYSxLtwLpw98t@ripper>
 <20220423031350.01299C385A0@smtp.kernel.org>
 <YmN11qt/PqogYruQ@ripper>
 <20220425223426.BE973C385A4@smtp.kernel.org>
 <3fb043e6-2748-24f8-0115-b5372c747a12@linaro.org>
 <Ymq6UOjrYgFlzl/W@ripper>
 <CAA8EJpqBMzTNjTSWN1UMXM61-DmW22RKQJyWoMw3Rds=xEVQaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqBMzTNjTSWN1UMXM61-DmW22RKQJyWoMw3Rds=xEVQaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 Apr 09:24 PDT 2022, Dmitry Baryshkov wrote:

> On Thu, 28 Apr 2022 at 18:59, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Thu 28 Apr 08:44 PDT 2022, Dmitry Baryshkov wrote:
> >
> > > On 26/04/2022 01:34, Stephen Boyd wrote:
> > > > Quoting Bjorn Andersson (2022-04-22 20:43:18)
> > > > > On Fri 22 Apr 20:13 PDT 2022, Stephen Boyd wrote:
> > > > > >
> > > > > > I'd really rather not have clock-names at all because we spend a bunch
> > > > > > of time comparing strings with them when we could just as easily use
> > > > > > a number.
> > > > >
> > > > > I know that you would like to get rid of the clock-names for the clock
> > > > > controllers. I've looked at it since and while it will be faster to
> > > > > execute I still feel that it's going to be harder to write and maintain.
> > > > >
> > > > > E.g. look at gcc_pcie_4_pipe_clk_src, its parents today are
> > > > > pcie_4_pipe_clk and bi_tcxo. Something I can reason about being correct
> > > > > or not.
> > > > >
> > > > > If we ditch the clock-names I will have:
> > > > >
> > > > > static const struct clk_parent_data gcc_parent_data_14[] = {
> > > > >          { .index = 30 },
> > > > >          { .index = 0 },
> > > >
> > > > Those numbers could have some #define.
> > > >
> > > >     { .index = PCIE_4_PIPE_CLK_DT }
> > > >     { .index = BI_TCXO_DT }
> > > >
> > > > > };
> > > > >
> > > > > Generally we would perhaps use some compile time constant, but that
> > > > > won't work here because we're talking about the index in the clocks
> > > > > array in the yaml.
> > > > >
> > > > >
> > > > > But perhaps I'm missing something that would make this manageable?
> > > >
> > > > I dunno. Maybe a macro in the dt-binding header could be used to specify
> > > > the 'clocks' property of the DT node that is providing the other side?
> > > > The idea is to make a bunch of macros that insert the arguments of the
> > > > macro in the right place for the clocks property and then define the
> > > > order of arguments otherwise. It would be similar to how
> > > > CREATE_TRACE_POINTS is used in include/trace/define_trace.h
> > > >
> > > > In the dt-bindings/qcom,gcc-soc.h file:
> > > >
> > > >     #ifdef IN_DTSI
> > > >
> > > >     #undef GCC_DT_NODE_CLOCKS
> > > >     #define GCC_DT_NODE_CLOCKS
> > > >             clocks = <BI_TCXO_DT>,
> > > >                      <SLEEP_CLK_DT>;
> > > >
> > > >     #endif /* IN_DTSI */
> > > >
> > > >     #define BI_TCXO_DT 0
> > > >     #define SLEEP_CLK_DT 1
> >
> > BI_TCXO_DT is not the value, its the index of the entry in the clocks
> > array. And the actual values of the clock controller's clocks
> > property is not a property of the clock controller, but the system
> > definition.
> >
> > I.e. that should be clear and explicitly expressed in the dts.
> >
> > >
> > > Isn't this being an overkill, to define exact properties in the bindings
> > > header? Also this would mean that we'd have to add dt-binding headers for
> > > all _consumers_ of clocks. And to make things more complex, e.g. for PCIe
> > > devices different instances of the device would use different amount of
> > > clocks. This would mean that we'd have to define SM8250_PCI0_CLOCKS,
> > > SM8250_PCIE1_CLOCKS and SM8250_PCIE2_CLOCKS.
> > >
> > >
> > > If we were to switch to this fragile path of using indices (yes I consider
> > > it to be very fragile), I'd consider something like the following to work in
> > > the platform dtsi file:
> > >
> > > clocks =
> > > BEGIN_CLOCK
> > > CLOCK(BI_TCXO_DT, &bi_tcxo)
> > > CLOCK(SLEEP_CLK_DT, &sleep_clk)
> > > END_CLOCK;
> > >
> > > While the following should give an error:
> > > clocks =
> > > BEGIN_CLOCK
> > > CLOCK(SLEEP_CLK_DT, &sleep_clk)
> > > CLOCK(BI_TCXO_DT, &bi_tcxo)
> > > END_CLOCK;
> > >
> > > I think we can make this error out by using some additional tool (or
> > > additional preprocessor pass over the sources)
> > >
> >
> > Let's not invent some magical syntax for describing the clocks in the
> > DT.
> >
> > These macros can't expand to sparse arrays anyways, so iiuc this would
> > give a sense that the ordering might not be significant, when it really
> > is.
> >
> > > > And then in the SoC.dtsi file have
> > > >
> > > >     #define IN_DTSI
> > > >     #include <dt-bindings/qcom,gcc-soc.h>
> > > >
> > > >     #define BI_TCXO_DT      &xo_board
> > > >     #define SLEEP_CLK_DT    &sleep_clk
> > > >
> > > >     ...
> > > >
> > > >     clock-controller@a000000 {
> > > >             compatible = "qcom,gcc-soc";
> > > >             reg = <0xa000000 0x10000>;
> > > >             GCC_DT_NODE_CLOCKS
> > > >     };
> > > >
> > > >
> > > > and then in drivers/clk/qcom/gcc-soc.c file:
> > > >
> > > >     #include <dt-bindings/qcom,gcc-soc.h>
> > > >
> > > >     static const struct clk_parent_data gcc_parent_data_14[] = {
> > > >             { .index = PCIE_4_PIPE_CLK_DT },
> > > >             { .index = BI_TCXO_DT },
> > > >     };
> > > >
> > > > The benefit I see to this is that the index for each clock is in the
> > > > header file (BI_TCXO_DT is 0) and it's next to the clocks property.
> > > > Someone could still mess up the index based on where the macro is used
> > > > in the clocks property though.
> > >
> > > And actually might I suggest an alternative approach to manually using
> > > indices everywhere? What about spending the time once during the boot to
> > > convert .fw_name and clock_names to parent indices during clock registration
> > > and then using them for all the further operations?
> > >
> >
> > I'm pretty sure that's what clk_core_fill_parent_index() already does.
> 
> In this case I think we should go for clock-name in the DT and
> auto-flled indices inside. Stephen, WDYT? Would that fix your concern
> for comparing strings each and every time?
> 

You mean, just continue doing what we've been doing lately with fw_name
etc?

That lookup is the one that Stephen wants to avoid.

Regards,
Bjorn
