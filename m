Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDDD4AA29D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbiBDVvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244478AbiBDVvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:51:49 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B0C061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:51:49 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso6065503otv.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O2+sVRpdHPYQoxVHI59ztnDEc6w2w5/2mmrQawOpXNE=;
        b=iqFWBf7gzQtaq+GgoHczFWRaBXshUkQK0uHiLVzfb6y9h0/ms/gkgl492dbJGkmDe7
         Y1InhFuQIM/5aabeRUuiOW/G/WSU9B4p3afeyAkRIsM3HFFbeOrSWMV47jZpPv02lEbx
         tIuFhWxLmuo3SKiz9zcZnlpp6xTo6GSGv1sn32JepTQU+zWeQFKN/AGuZwnBIPPtlNYr
         29O9Mpo3VBNNtaenT+Ogb0M0PDi1m2y0cIqlYLXHupc5LYQm4aYhGc79vHRqtNDDqKdA
         GQlPWbQ2BpFfjWxnbftDcvEevW5aUxdPtvJnlhXceO8VSeRQL7cPTrFZvUc8JQ2IRIOf
         n+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O2+sVRpdHPYQoxVHI59ztnDEc6w2w5/2mmrQawOpXNE=;
        b=jjhCDum0i91Pl4UI99U9fLEXPonpbsB8t9Xwc39B7o2liR4M/gXG8omW7jkxUj2Co6
         xuaCCDzI7U+kYMMdqmoMQMocT1AC5qUuKpe3Z5Rva1BlQ50HqekFpMy9ulmMAlqpTOSL
         KSI6vJp7JthI640VLokem1L3HL5MEe7JZkfNWOiEmOjHz/01/B29gIvps1Kzj5mNWNlS
         IyL4ReuflB1JTCjliJUOMxMD8glPnigD6kbpBxTeiBxWptAhjetaKadiGUx1w0KIrcIh
         sr/eiLaqHL5jjOGFV/tc1uOi0QMwMTz0fBEvk4oTrH6aRWxFYdAvoOHNfTLh40hsSwXK
         GLlw==
X-Gm-Message-State: AOAM531144fcTO/kOQQEtakyj71xD/MRorDfaMa/Z7HzHCB6coWiF0ur
        NTNI7HrbinjCD9VxttXoGa1yoQ==
X-Google-Smtp-Source: ABdhPJwgDaID5lNoBN2g/qxi4lyV59pbUBQVCse82d4EAmJt7DbANA3S7fVKR6KuNzdyNBnklI8RrQ==
X-Received: by 2002:a9d:104:: with SMTP id 4mr381180otu.191.1644011507408;
        Fri, 04 Feb 2022 13:51:47 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id bj8sm1429873oib.20.2022.02.04.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:51:46 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:51:44 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/14] arm64: dts: qcom: sc7280: Add the CPU
 compatible to the soc@0 node
Message-ID: <Yf2f8Az5v1TtlAjd@builder.lan>
References: <20220202212348.1391534-1-dianders@chromium.org>
 <20220202132301.v3.13.I7924ce4592e3e75b2293804d8a3f8a4dae44646e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202132301.v3.13.I7924ce4592e3e75b2293804d8a3f8a4dae44646e@changeid>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 Feb 15:23 CST 2022, Douglas Anderson wrote:

> We'd like to start including the CPU name as the compatible under the
> "soc" node so that we can get rid of it from the top-level compatible
> string.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Probably needs a .yaml file somewhere?
> 
> Changes in v3:
> - ("sc7280: Add the CPU compatible to the soc@0 node") new for v3.
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 618ae0407cd6..2bfc919d4018 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -573,7 +573,7 @@ soc: soc@0 {
>  		#size-cells = <2>;
>  		ranges = <0 0 0 0 0x10 0>;
>  		dma-ranges = <0 0 0 0 0x10 0>;
> -		compatible = "simple-bus";
> +		compatible = "qcom,sc7280", "simple-bus";

To me this implies that /soc represents the sc7280, but as noted earlier
I don't think that's accurate. E.g. if this node represents the sc7280,
why are the cpus described outside this node?

Further more, if we look at the reg nodes on this bus it's clear that
this is some mmio bus, which per the ranges has 36 bit address width.
But not all buses in the sc7280 has 36 bit address width, so it's not
inconceivable that one would actually have to split /soc into more than
one entity with different dma-ranges. Perhaps not today, but I don't
like the precedence it sets.

Regards,
Bjorn

>  
>  		gcc: clock-controller@100000 {
>  			compatible = "qcom,gcc-sc7280";
> -- 
> 2.35.0.rc2.247.g8bbb082509-goog
> 
