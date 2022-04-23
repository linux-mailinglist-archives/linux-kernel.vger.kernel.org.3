Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0D50C6EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiDWDoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiDWDoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:44:14 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75413B2442
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:41:18 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e5e433d66dso10626582fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKqHPdyYwATO8dlCGP1CENdzgdMNK7Lqp4jLDjIdG38=;
        b=zBj2quoyrYPsi/ivJ79t+l51E0g7NGKdD8xqRKuSeTwmBSD168WXqmEmoAWNO+Fv4o
         ewmbL+9KzW3yu9ge+gL7UrTQcliLwKp8fEK9o9J/AAixfG/4Hoi7ny1o/Pmf7pmlZkeM
         ymeIkD95M38hntoNgV4nAe2x/Eau5LdMWwCQjuCL5zlIo25q2E02zCPFDlkE+S3CVxsW
         dFJ4OI4m1lLIennX0FDgam7LMXApsVeiDKOrWX8qPyu/m3HsfdjjY1XmGZAXHcvgG1Xb
         J3DlOPIWPvgVuRt9JgqniHwlk7qS4HkuZJLFKEWd+yjZkM6FdiC1W0hqiA9ZCVmlO2fo
         8ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKqHPdyYwATO8dlCGP1CENdzgdMNK7Lqp4jLDjIdG38=;
        b=pMlg+eFSWDY/ozJ5ifZXW7UCg0uPnzs2m9BeD5h9bwufpOhumLmKuDRFjkAt7cyIq3
         mWoND5OJhSmSuDNxl4zG+oFC0V1fhWu7KUsph/l14PgxtSVL6Y1lg+y3u/yGhjv+Ze7j
         rAYFJtIEDqj42hUBF55BXXZ7nYOFVSRJGlnGFjrwBgGu3heDK1R6e6K3LTplngBOVLsx
         VeiGU5saIiH7xk/OIM9JMpfnRtsh9zfLrz12CYqT3Me6kAWw7cD1STnhS5db64BuK6QG
         G+3TRT0G1BlA/fXh9PCl5S1XSNhkZ+zWI/OiYPgLxze1a3A6Pz+T4yqZCMBcagxq1lP4
         KsWQ==
X-Gm-Message-State: AOAM532AzDUTs9tksDw3EBHQndsPtK0AGiZj/f+MEAE+CtxcbeIt8nHp
        95GV7oBY6Y1IWO3DmjHeMOoLog==
X-Google-Smtp-Source: ABdhPJzZCLhf7t3Ypz5v3KJ+nSV3UDL7oocvo4A+/+Cfx5GPnsc8JSYXgIXN+P7L1aauM/K4buLGdA==
X-Received: by 2002:a05:6870:d192:b0:de:691:81ad with SMTP id a18-20020a056870d19200b000de069181admr7566588oac.165.1650685277800;
        Fri, 22 Apr 2022 20:41:17 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id n21-20020a9d4d15000000b00603fb46ddcbsm1391698otf.65.2022.04.22.20.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 20:41:17 -0700 (PDT)
Date:   Fri, 22 Apr 2022 20:43:18 -0700
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
Message-ID: <YmN11qt/PqogYruQ@ripper>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org>
 <20220423014824.912ACC385A0@smtp.kernel.org>
 <YmNsYSxLtwLpw98t@ripper>
 <20220423031350.01299C385A0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423031350.01299C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Apr 20:13 PDT 2022, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2022-04-22 20:02:57)
> > On Fri 22 Apr 18:48 PDT 2022, Stephen Boyd wrote:
> > 
> > > Quoting Bjorn Andersson (2022-04-22 16:00:12)
> > > > Add binding for the Qualcomm SC8280XP Global Clock controller.
> > > > 
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > 
> > > Why no cover letter?
> > > 
> > 
> > I didn't have anything useful to write in it. Will provide you one in
> > the future...
> 
> Thanks!
> 
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: XO reference clock
> > > 
> > > "clock" is redundant in all these descriptions. Please remove.
> > > 
> > 
> > You don't think it's a little bit odd to have description such as
> > "Sleep", "PCIe 2a pipe" or First EMAC controller reference"?
> > 
> > I mean I agree that it's obviously clocks we're talking about, but to me
> > that makes it seems like the descriptions are cut short, just for the
> > sake of avoiding "clock".
> 
> Alright, keeping clock is OK as long as
> 
> > 
> > > > +      - description: Sleep clock
> > > > +      - description: UFS memory first RX symbol clock
> > > > +      - description: UFS memory second RX symbol clock
> > > > +      - description: UFS memory first TX symbol clock
> > > > +      - description: UFS card first RX symbol clock
> > > > +      - description: UFS card second RX symbol clock
> > > > +      - description: UFS card first TX symbol clock
> > > > +      - description: Primary USB SuperSpeed pipe clock
> > > > +      - description: gcc_usb4_phy_pipegmux_clk_src
> 
> there is a better name for this and the other non-word descriptions.
> 
> USB4 phy pipe gmux clock source?
> 

Sounds good, I'll make sure to fill these out.

> > > > +      - description: gcc_usb4_phy_dp_gmux_clk_src
> > > > +      - description: gcc_usb4_phy_sys_pipegmux_clk_src
> > > > +      - description: usb4_phy_gcc_usb4_pcie_pipe_clk
> > > > +      - description: usb4_phy_gcc_usb4rtr_max_pipe_clk
> > > > +      - description: Primary USB4 RX0 clock
> > > > +      - description: Primary USB4 RX1 clock
> > > > +      - description: Secondary USB SuperSpeed pipe clock
> > > > +      - description: gcc_usb4_1_phy_pipegmux_clk_src
> > > > +      - description: gcc_usb4_1_phy_dp_gmux_clk_src
> > > > +      - description: gcc_usb4_1_phy_sys_pipegmux_clk_src
> > > > +      - description: usb4_1_phy_gcc_usb4_pcie_pipe_clk
> > > > +      - description: usb4_1_phy_gcc_usb4rtr_max_pipe_clk
> > > > +      - description: Secondary USB4 RX0 clock
> > > > +      - description: Secondary USB4 RX0 clock
> > > > +      - description: Multiport USB first SupserSpeed pipe clock
> > > > +      - description: Multiport USB second SuperSpeed pipe clock
> > > > +      - description: PCIe 2a pipe clock
> > > > +      - description: PCIe 2b pipe clock
> > > > +      - description: PCIe 3a pipe clock
> > > > +      - description: PCIe 3b pipe clock
> > > > +      - description: PCIe 4 pipe clock
> > > > +      - description: First EMAC controller reference clock
> > > > +      - description: Second EMAC controller reference clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: bi_tcxo
> > > > +      - const: sleep_clk
> > > 
> > > And "_clk" postfix is redundant in all these strings. Remove?
> > > 
> > 
> > In this case I think they should include _clk, as they actually matches
> > the clock names in the documentation.
> > 
> 
> I'd really rather not have clock-names at all because we spend a bunch
> of time comparing strings with them when we could just as easily use
> a number.

I know that you would like to get rid of the clock-names for the clock
controllers. I've looked at it since and while it will be faster to
execute I still feel that it's going to be harder to write and maintain.

E.g. look at gcc_pcie_4_pipe_clk_src, its parents today are
pcie_4_pipe_clk and bi_tcxo. Something I can reason about being correct
or not.

If we ditch the clock-names I will have:

static const struct clk_parent_data gcc_parent_data_14[] = {
        { .index = 30 },
        { .index = 0 },
};

Generally we would perhaps use some compile time constant, but that
won't work here because we're talking about the index in the clocks
array in the yaml.


But perhaps I'm missing something that would make this manageable?

Regards,
Bjorn
