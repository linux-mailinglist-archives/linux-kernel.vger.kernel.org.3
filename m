Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C474982BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiAXOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:53:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36006 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiAXOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:53:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF49613CA;
        Mon, 24 Jan 2022 14:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2322C340F0;
        Mon, 24 Jan 2022 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643036017;
        bh=DgfnJXVYNoni5MGvYeMU/Er55W48ZA0qOqqHqmXQ1rI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HalJMxMRLUpfiogYDK0mnFCaGYakFt0khGZZpCxXdTS2OtImbiKX1Tb/I1299LP9o
         ZUZq9ajxoI4wVAoF8MEndgNHudY3DOJq0Oq/ArJFMb+ogKU2S3eIPqz7nN4KgtcOFr
         v+ryr+uyTo6mhbIphRLFx8kFmhy5tKILwHJWhL0no54/4ySqaEz/FEtPxWf3P0gUV0
         dILYIkphx69lWoNDwiuinVj+NcKC4U2Em5q1xhlmaV0k+UCutvBP80Kp5JLVaOsQtG
         nwLaNB3IwLHql7acY9hrLaZ9JQuyfGUNrYaFah+onlYuYJOjzV0b2xsXY8c+S5CkIt
         TjpxHqU74Te0A==
Received: by mail-ed1-f50.google.com with SMTP id c24so54835059edy.4;
        Mon, 24 Jan 2022 06:53:37 -0800 (PST)
X-Gm-Message-State: AOAM533/MBDuY4ypXqxL4PmTYmvWk9nqNnhqfPB1rzqFv1G6Xa+/l9ET
        cCMFp09aWvIQ79n34qtTt3f4bfIHMzfzfjZGHg==
X-Google-Smtp-Source: ABdhPJwZziTImIRfNFR6rqYJ587/gofl1dEoiSlc8t2aFJTjjw5R0cyuRIY1LoDUnwgwbbrvVENrXBJP8tRVC64pIfw=
X-Received: by 2002:aa7:dc44:: with SMTP id g4mr16285510edu.109.1643036016020;
 Mon, 24 Jan 2022 06:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20211217211136.3536443-1-robh@kernel.org>
In-Reply-To: <20211217211136.3536443-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Jan 2022 08:53:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLBwHK+M_Tk4YxAHxaSgUm7sFvov7-UC3TdDhhPWtaqew@mail.gmail.com>
Message-ID: <CAL_JsqLBwHK+M_Tk4YxAHxaSgUm7sFvov7-UC3TdDhhPWtaqew@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Fix msm8998 cache nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 3:11 PM Rob Herring <robh@kernel.org> wrote:
>
> The msm8998 cache nodes have some issues. First, L1 caches are described
> within cpu nodes, not as separate nodes. The 'next-level-cache' property
> is of course in the correct location, otherwise the cache hierarchy
> walking would not work. Remove all the L1 cache nodes.
>
> Second, 'arm,arch-cache' is not a documented compatible string. "cache"
> is a sufficient compatible string for the Arm architected caches.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 52 ++-------------------------
>  1 file changed, 2 insertions(+), 50 deletions(-)

Ping

>
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 408f265e277b..00adee461b52 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -138,15 +138,9 @@ CPU0: cpu@0 {
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_0>;
>                         L2_0: l2-cache {
> -                               compatible = "arm,arch-cache";
> +                               compatible = "cache";
>                                 cache-level = <2>;
>                         };
> -                       L1_I_0: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_0: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 CPU1: cpu@1 {
> @@ -157,12 +151,6 @@ CPU1: cpu@1 {
>                         capacity-dmips-mhz = <1024>;
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_0>;
> -                       L1_I_1: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_1: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 CPU2: cpu@2 {
> @@ -173,12 +161,6 @@ CPU2: cpu@2 {
>                         capacity-dmips-mhz = <1024>;
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_0>;
> -                       L1_I_2: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_2: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 CPU3: cpu@3 {
> @@ -189,12 +171,6 @@ CPU3: cpu@3 {
>                         capacity-dmips-mhz = <1024>;
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_0>;
> -                       L1_I_3: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_3: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 CPU4: cpu@100 {
> @@ -206,15 +182,9 @@ CPU4: cpu@100 {
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_1>;
>                         L2_1: l2-cache {
> -                               compatible = "arm,arch-cache";
> +                               compatible = "cache";
>                                 cache-level = <2>;
>                         };
> -                       L1_I_100: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_100: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 CPU5: cpu@101 {
> @@ -225,12 +195,6 @@ CPU5: cpu@101 {
>                         capacity-dmips-mhz = <1536>;
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_1>;
> -                       L1_I_101: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_101: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 CPU6: cpu@102 {
> @@ -241,12 +205,6 @@ CPU6: cpu@102 {
>                         capacity-dmips-mhz = <1536>;
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_1>;
> -                       L1_I_102: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_102: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 CPU7: cpu@103 {
> @@ -257,12 +215,6 @@ CPU7: cpu@103 {
>                         capacity-dmips-mhz = <1536>;
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>                         next-level-cache = <&L2_1>;
> -                       L1_I_103: l1-icache {
> -                               compatible = "arm,arch-cache";
> -                       };
> -                       L1_D_103: l1-dcache {
> -                               compatible = "arm,arch-cache";
> -                       };
>                 };
>
>                 cpu-map {
> --
> 2.32.0
>
