Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F9A544C75
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiFIMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiFIMrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:47:46 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D45359FD3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:47:43 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id p8so16993684qtx.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8cWqvPg9zbI1Q43jZ22k5KFlen0dxXXQmLtqMTzZJM=;
        b=W3iSqn+U6DYPLx0Gt6muJSyYUB8gxNK8sU1bPvLeuDq+RHwCPr02xyazKxVG5njrL+
         TEHtdxgOlEiy8lGZeAdkKfkVGnIbRVz3/NJIM0RiZgRRVFD0hipcqJPQyE4MOCSiKkTG
         CwMrD5Bumyr+5pxKhAK/uAMPADY1s1UyiD4wiXxn/kGf4/XdAmdLG4dVpQQIUJd6cMB8
         f3N0AcjzAaO1vMMs0BoTpvhaqFN9zHX9LLYboRY18/BkgPNskeisffwebtUATlmNBFgT
         WW/qXdf0o8SAXjb6NPZNoRB/X7aK+YNgvI7QYmq3GhO+k1RMvr1YJRBs6DKtv0yvq4ud
         9hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8cWqvPg9zbI1Q43jZ22k5KFlen0dxXXQmLtqMTzZJM=;
        b=hnJ5bcQLUP9iDbCscKtnTexhdGgL9Bp+f6rGVWe9IczaZRZ2lTlRXfJCbPqIn02GEs
         4V7zju9olVFYDEMvdLBhmEJ6fAcdtmJyqXvh6mlbMc5NhrsLeQ142Veymj/PFRFd4CrX
         uRsOMO2oF5VPnoXUODwE2fJ7lNmiNufDypVJ7mseRFYjL0nvuA7KWNNk2Xns6dzX37sp
         K8NfhTLDB5jGovD7ZJqpQ7BIa4tD2el/O863Wkiw5WugMZ0PzvpxMCuM9CXVdztrQrY4
         Bx5IoQqZXulYJmI9jQlv3Xo7GaorC9iCpk/027ozJlUL3uHg5peuul4eD/5Dfs6qS3Up
         FbWQ==
X-Gm-Message-State: AOAM530DV9IJciIhVQ1SEof3mwDp5XdSGSBx4EnGOIouD7Tqb9Ibzdwa
        /wLwY0UdDxHGx6EjM4AfJwvoCEBubgzn2lHIzqyBJg==
X-Google-Smtp-Source: ABdhPJwIC+f21r6zvATp/buJdHq/JKIw15pStNVdzdxyxyK2vJJ81iSA3iUJwPYvzI/sWZ2iYPbRMyCFUYI7hs9I2yQ=
X-Received: by 2002:ac8:598f:0:b0:305:8f8:2069 with SMTP id
 e15-20020ac8598f000000b0030508f82069mr4867390qte.370.1654778863045; Thu, 09
 Jun 2022 05:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220609095412.211060-1-amartinz@shiftphones.com>
In-Reply-To: <20220609095412.211060-1-amartinz@shiftphones.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Jun 2022 15:47:31 +0300
Message-ID: <CAA8EJpqz32_LxmBVbcLt0sV=e1JzGtWEmMsKsQNoZzuGgLWbBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch: arm64: qcom: sdm845-shift-axolotl: fix
 Bluetooth firmware loading
To:     Alexander Martinz <amartinz@shiftphones.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 12:54, Alexander Martinz <amartinz@shiftphones.com> wrote:
>
> From: Dylan Van Assche <me@dylanvanassche.be>
>
> Add hsuart0 alias, firmware name and prevent garbage data on Bluetooth UART lines

hsuart aliases are not standard. Please use serialN alias instead.

> on the SHIFT 6mq based on the Qualcomm SDM845 chip.
> I discovered that these were missing by comparing the DTS with similar
> devices such as the Oneplus 6/6T and Dragonboard 845c.
>
> Signed-of-by: Dylan Van Assche <me@dylanvanassche.be>
> Tested-by: Alexander Martinz <amartinz@shiftphones.com>
> ---
>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 103cc40816fd..fa72f23ef0c2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -20,6 +20,7 @@ / {
>
>         aliases {
>                 display0 = &framebuffer0;
> +               hsuart0 = &uart6;
>                 serial0 = &uart9;
>         };
>
> @@ -529,6 +530,32 @@ volume_down_resin: resin {
>         };
>  };
>
> +/*
> + * Prevent garbage data on bluetooth UART lines
> + */
> +&qup_uart6_default {
> +        pinmux {
> +                pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +                function = "qup6";
> +        };

This chunk should probably go into sdm845.dtsi. I'd suggest either
adding a separate qup_uart6_4pin or just making qup_uart6_default the
4-pin UART.

> +
> +        cts {
> +                pins = "gpio45";

Then the label and 'pins' can go into the dtsi, while keeping just the
bias and drive-strength in the platform dtsi.

> +                bias-pull-down;
> +        };
> +
> +        rts-tx {
> +                pins = "gpio46", "gpio47";
> +                drive-strength = <2>;
> +                bias-disable;
> +        };
> +
> +        rx {
> +                pins = "gpio48";
> +                bias-pull-up;
> +        };
> +};
> +
>  &qup_uart9_default {
>         pinconf-rx {
>                 pins = "gpio5";
> @@ -667,6 +694,12 @@ &uart6 {
>         bluetooth {
>                 compatible = "qcom,wcn3990-bt";
>
> +               /*
> +                * This path is relative to the qca/
> +                * subdir under lib/firmware.
> +                */
> +               firmware-name = "axolotl/crnv21.bin";

Do you know what is the difference between axolotl's bin and the regular one?

> +
>                 vddio-supply = <&vreg_s4a_1p8>;
>                 vddxo-supply = <&vreg_l7a_1p8>;
>                 vddrf-supply = <&vreg_l17a_1p3>;

-- 
With best wishes
Dmitry
