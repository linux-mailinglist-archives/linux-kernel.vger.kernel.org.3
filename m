Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30F570E53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiGKXdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGKXdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:33:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8EB7EF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:33:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so11381762ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tT3i3PdSWIbZI2/jQXTr2ht9FWXt0v5w3WnrwY7zOxE=;
        b=Ldn5e/XdivqNGq4Wo2DSw9vOq5ICFZFMjEsGK5qXKUBqT+RZBBTBUQUrgowVxl9abf
         IZvV6AFjiDL62G8G5+bfNOR9kg81XWRLWcfzrZg1n3q+TAcpqNtW0Qm6u4XsGNXO02KB
         w0cKuHUwdeLDMcYS59ah5rxS1gcxsji/tG4DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tT3i3PdSWIbZI2/jQXTr2ht9FWXt0v5w3WnrwY7zOxE=;
        b=DsVxutcVsoWa0WzogHtF4OSoyjhMW6qXScTAHVn8P7xV7K59ws2XXaf5MrzSu3QAg+
         /t8lAb72uBr1+yXK9zWztWZLh10cdxuPRO368AOb4O09HrSNwYKi9pIGhWY9CNLLwpkN
         I+ZszfXiwV09bLRu88u2+9E9gDplV2hf90D+O4qo2P5NnS5I4KfH8OOuWFv3En4RA3Ta
         2wZgonqeFSaU2LTJdKamXUsoKKoaNOYKf0lPdoeK1UlLyVm60gEcH6e/+Ty7rzbwCbjZ
         KKDDsgleK3F8uYVUt5S6FCq6UiCQvuZN+478QEnb0IKcleiwr3eTRy0oZLOpiIYS4LsP
         17Ww==
X-Gm-Message-State: AJIora8vSncGPAOxOWazINEF2omx9Qi/X1XgG5la3ZjKJp0E+R3Kf/3Y
        FFl/2tsWSOZ5ggwD6vTE0M5aJC75/bCbLf/K/Qc=
X-Google-Smtp-Source: AGRyM1t8N0uVDh5m+djfBmRKeDvBzZIzEhTDJaazKmLdx7k+qV4ChYGhrPznqL64RF1yDDdUvGXD/g==
X-Received: by 2002:a17:907:2d2b:b0:72b:546a:bd03 with SMTP id gs43-20020a1709072d2b00b0072b546abd03mr8226317ejc.149.1657582409751;
        Mon, 11 Jul 2022 16:33:29 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id t7-20020a170906064700b0072b131815e2sm3106183ejb.113.2022.07.11.16.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 16:33:29 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so5814607wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:33:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3d95:b0:3a2:e97b:f3ae with SMTP id
 bi21-20020a05600c3d9500b003a2e97bf3aemr728744wmb.188.1657582077548; Mon, 11
 Jul 2022 16:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com> <20220709112837.v2.5.I7291c830ace04fce07e6bd95a11de4ba91410f7b@changeid>
In-Reply-To: <20220709112837.v2.5.I7291c830ace04fce07e6bd95a11de4ba91410f7b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 16:27:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzvcjS51q78BZ=FPCEVUDMD+VKJ70ksCm5V4qwHN_wRg@mail.gmail.com>
Message-ID: <CAD=FV=XzvcjS51q78BZ=FPCEVUDMD+VKJ70ksCm5V4qwHN_wRg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sc7280: Update gpu register list
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 8, 2022 at 11:00 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> Update gpu register array with gpucc memory region.
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index e66fc67..defdb25 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2228,10 +2228,12 @@
>                         compatible = "qcom,adreno-635.0", "qcom,adreno";
>                         reg = <0 0x03d00000 0 0x40000>,
>                               <0 0x03d9e000 0 0x1000>,
> -                             <0 0x03d61000 0 0x800>;
> +                             <0 0x03d61000 0 0x800>,
> +                             <0 0x03d90000 0 0x2000>;
>                         reg-names = "kgsl_3d0_reg_memory",
>                                     "cx_mem",
> -                                   "cx_dbgc";
> +                                   "cx_dbgc",
> +                                   "gpucc";

This doesn't seem right. Shouldn't you be coordinating with the
existing gpucc instead of reaching into its registers?

-Doug
