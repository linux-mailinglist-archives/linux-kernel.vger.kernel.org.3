Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72F49AB50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358527AbiAYEs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355985AbiAYDz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:55:58 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CB7C088589
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:33:20 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y17so3425955ilm.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjJmpu3e2t2f13z2Lk1fKSYhhOY3XW/vJD/ViRHi/3w=;
        b=ML4ZhwzpblICBpcfdpi1zxRWLHKRxGys7HU2dk4xn5uAUMmwdlmU3jDdG1V5dJaCfy
         6RrkYOndJqDoAeQG5v4B1FGQSLnDS4+WuOb8qckjKx+JK/sG9ox2LwcT2eVQaY8pvgK8
         dn4GQWBto1pDWHU4Cyno/TKRYUJXJxawwrkoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjJmpu3e2t2f13z2Lk1fKSYhhOY3XW/vJD/ViRHi/3w=;
        b=Gf2707SVFpn2t0pZ3ssbH4O+8v/d0HH/h8ES9sRDOhvFynfy4yMLvO0tmKtoL3txBw
         yi7SLJdUQCqYWhqZ2Why5Wr7SXgXxqG5R9pYfhHyOtZSHTiwY4Dx+b1KBJFQNnLHDCEY
         MQNvhRx98SZMCC2RrvYbZ6RgRwABDNg2TaeRdgFBjbtsOYQtPvZ643JU83IuV95ELVz2
         w/Je2lBLcEsp0/V4twmykugNgJB5Xy5IcqeNAjQeWqYuDurLut3frLRKGsXo5aH1UKhe
         LJqPgioYx1htKAV/NUjofLI076wxWnGqUeWncOl13Yi3yMQcCRZiib4ebcWMW++fyHzJ
         yCMQ==
X-Gm-Message-State: AOAM532kAaxC47wVG9bK8b69Hs7ySIuit2pyTG1bVRfpblp2mgs6QR0Z
        eECWfrRAkOhLFEah7kk+Y40yK+TiiOi/Rw==
X-Google-Smtp-Source: ABdhPJwanbYiOJAKUxtWLIr52afX9gOi41FRigrvN/ikWgBVzCz0JlTVrC/8AbGtDrXO2dMff9ncTw==
X-Received: by 2002:a05:6e02:20e6:: with SMTP id q6mr9840304ilv.180.1643056399841;
        Mon, 24 Jan 2022 12:33:19 -0800 (PST)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id y11sm7747133ilp.18.2022.01.24.12.33.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 12:33:18 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id 15so682782ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:33:18 -0800 (PST)
X-Received: by 2002:a92:6b10:: with SMTP id g16mr9053356ilc.165.1643056398198;
 Mon, 24 Jan 2022 12:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20220124165745.16277-1-tdas@codeaurora.org>
In-Reply-To: <20220124165745.16277-1-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jan 2022 12:33:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X3+MDOMEidLbdgvcHVSObO=_x3KSLe31hr-TP6B2jCEg@mail.gmail.com>
Message-ID: <CAD=FV=X3+MDOMEidLbdgvcHVSObO=_x3KSLe31hr-TP6B2jCEg@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 8:58 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> Add the low pass audio clock controller device nodes.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
> Dependent onLPASS clock controller change: https://lkml.org/lkml/2022/1/24/772
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 43 ++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 937c2e0e93eb..0aa834ce6b61 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -8,6 +8,8 @@
>  #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>

Presumably using these two include files means a dependency on things
landing in the clk tree [1]. Unless Stephen and Bjorn want to work
something out, I'd guess you'll need to re-post with just hardcoded
numbers for now?

[1] https://lore.kernel.org/r/20220124162442.29497-2-tdas@codeaurora.org/
