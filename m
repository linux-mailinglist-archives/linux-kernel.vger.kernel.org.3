Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6191D4A4EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357946AbiAaSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351424AbiAaStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:49:22 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F360CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:49:21 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id s18so18119569ioa.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9f04l0Uq57l+kUQAdBvsrPuxoRAh5llaJT8q8qRZBo=;
        b=iVTA+B5TWMfrTBBOUUb6402jvtJ9RYNCsrj6QDNRVJ85GGrB7pjY1VhYkK9KqilDFR
         0v6Qze0rSk1BgXIxBGhhylFo70+du8LzuHvXDvb+8/hH9jA/LEJzCdFgRXl2vwSi6gze
         vJvYMu6clL8nRO123zAMAMxEh37RD4PHCJBBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9f04l0Uq57l+kUQAdBvsrPuxoRAh5llaJT8q8qRZBo=;
        b=UGxaVNb35l8T5nluOsanD0cV7nPcNTy7Klg9ea2BWq+6qanhQbFlX76AkI2QM7jxiA
         T1GgsDr2ZohAxK/dewVb/Aw9JrpERqrtm5DAl5/zwuQEexor+9wDQsSNDApCBqBk4NtD
         WtahtheDlOYGQM2lBq4A1VMrL5FzyOzDRX5l6BujAWrG24uLmzDWm7k31PePBVhAusPo
         S0zZRWRusw5npguKLpas3SgEU+U6NXN2coQ/SjrAVPMrAsyh3yOJoJB3rnuaqe0JH4gU
         1YK+arrdrgoG3u7OO6wgovhgCn1mWRBP1Oeaq3c4wJbu1SxddHgo6iYs8pmbQbyVZh/1
         AccA==
X-Gm-Message-State: AOAM533J0J7no4a5wppTsFz25Ph2u9fiXevenuE3bWw2PmipSGlTT77T
        vNbDpNpvhQGmljDTR0Vnj+q0kMQpy/Lqag==
X-Google-Smtp-Source: ABdhPJxAOD5DfKb2RGGl6TwDWU7IdzYExMdQL/fFiSnjn2Z8O4dEiPFyewzPzlMpOVnQ05aQ+lo3Qw==
X-Received: by 2002:a02:6203:: with SMTP id d3mr11335603jac.109.1643654961093;
        Mon, 31 Jan 2022 10:49:21 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id z5sm19548328ioq.47.2022.01.31.10.49.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 10:49:19 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id h7so18181862iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:49:18 -0800 (PST)
X-Received: by 2002:a05:6602:3411:: with SMTP id n17mr11811765ioz.128.1643654958506;
 Mon, 31 Jan 2022 10:49:18 -0800 (PST)
MIME-Version: 1.0
References: <1640274189-14120-1-git-send-email-quic_srivasam@quicinc.com> <1640274189-14120-2-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1640274189-14120-2-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 31 Jan 2022 10:49:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XC3h8H8mSSUDiku8N68aKvR0226tjKobKcKTo=h=5BmQ@mail.gmail.com>
Message-ID: <CAD=FV=XC3h8H8mSSUDiku8N68aKvR0226tjKobKcKTo=h=5BmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker
 and Headset
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Maurice Alou <malou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 23, 2021 at 7:43 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> Add AMP enable node and pinmux for primary and secondary I2S
> for SC7280 based platforms.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 11 +++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 55 ++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index d623d71..86f182c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -491,6 +491,17 @@
>  };
>
>  &tlmm {
> +       amp_en: amp-en {
> +               pinmux {
> +                       pins = "gpio63";
> +                       function = "gpio";
> +               };
> +               pinconf {
> +                       pins = "gpio63";
> +                       bias-pull-down;
> +               };

Please don't split up "pinmux" and "pinconf" into two nodes anymore.
This was done in old SoCs but it's not the new style. Also:
* Having a pull-down for outputs doesn't make sense, does it?
* Should be specifying a drive strength, right?

So it should be:

amp_en: amp-en {
  pins = "gpio63";
  function = "gpio";
  bias-disable;
  drive-strength = <2>;
};


> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 937c2e0..b5ebc9ec 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3461,6 +3461,61 @@
>                                 };
>                         };
>
> +                       pri_mi2s_active: primary_mi2s_active {
> +                               sclk {
> +                                       pins = "gpio97";
> +                                       function = "mi2s0_sck";
> +                                       drive-strength = <16>;

A few problems:

1. drive-strength shouldn't be in the sc7280.dtsi file. That's a board
property and should be specified in the board.

2. drive-strength=16 is likely way too strong. On one sc7280 board,
our EE measured the signal and said "The AP is driving I2S lines to
[...] codec way too hard (the overshoot will damage the codec long
term).". Are you sure you need 16?

3. Node names should have dashes, not underscores.

4. I guess it's up to Bjorn, but I don't see the huge benefit of
grouping in an overarching node like this.

5. I don't know that we need the "active" there.

6. Not sure why "mclk" is down by its lonesome.

7. In general, pins should be sorted alphabetically.

So overall, I'd prefer this in the SoC dtsi file:

  pri_mi2s_data0: pri-mi2s-data0 {
    pins = "gpio98";
    function = "mi2s0_data0";
  }

  pri_mi2s_data1: pri-mi2s-data1 {
    pins = "gpio99";
    function = "mi2s0_data1";
  }

  pri_mi2s_mclk: pri-mi2s-mclk {
    pins = "gpio96";
    function = "pri_mi2s";
  };

  pri_mi2s_sclk: pri-mi2s-sclk {
    pins = "gpio97";
    function = "mi2s0_sck";
  }

  pri_mi2s_ws: pri-mi2s-ws {
    pins = "gpio100";
    function = "mi2s0_ws";
  }

Then the board file would have:

&pri_mi2s_data0 {
  drive-strength = <some_number_probably_not_16>;
  bias-something;
};

&pri_mi2s_data1 {
  drive-strength = <some_number_probably_not_16>;
  bias-something;
};

&pri_mi2s_mclk {
  drive-strength = <some_number_probably_not_16>;
  bias-something;
};

&pri_mi2s_sclk {
  drive-strength = <some_number_probably_not_16>;
  bias-something;
};

&pri_mi2s_ws {
  drive-strength = <some_number_probably_not_16>;
  bias-something;
};


> +                       sec_mi2s_active: sec-mi2s-active {
> +                               sclk {
> +                                       pins = "gpio106";
> +                                       function = "mi2s1_sck";
> +                                       drive-strength = <16>;
> +                                       bias-disable;
> +                                       output-high;
> +                               };

Similar issues for the "sec" i2s bus, but you've also got this
"output-high". Are you sure you need that?
