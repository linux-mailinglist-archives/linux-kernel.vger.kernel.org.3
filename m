Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D039646456F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346448AbhLADcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245220AbhLADcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:32:00 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:28:39 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so7373471oof.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MO98g5+euDpCVh/jM+G9QFzSNcP/DvDPu2ZrHFjPZiI=;
        b=q6TBdnlLfvm7R0HoW22oepN5kftiW3DpHBwcdL5EVMVlQpGgSqkDtufnZK0r4iNdIh
         D6RdI8R8ln6MLdW4KiWC2Rx6rbXBLAJuvtf3lRKF2ZTk+btOyK5q4eAVTg1NuhnMH60N
         ir2AG6gVWCd+7tsmMUpib0VI1SFZTXsWTALpSenGMRJuKxA4me3+VxiJ68sGGyW7rsSy
         hQWPJpQPuFRXS2IVI+hunuBpke78ZuO1pj7rH17exKzYX6ifp2647hw5KHKf7u5df+K2
         rVlmY2XsKYDHsuZjjuOnSt1HZnLUx3m0A8nhApcOn+uH3etDRRTKh7HB6aSfpkjg820p
         fNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MO98g5+euDpCVh/jM+G9QFzSNcP/DvDPu2ZrHFjPZiI=;
        b=4a55bPL3w23lZ/GkeDJSmGZUcLFOmnNThlxQmbsdvz+wDiO5Z25hQCjftz6YfDR7C4
         8eIBEIfvjYHqZYL9VefyjvQW19lMQYmuOWZDmkTycMZ6egC3m5j1NNzSo4hXpdtL7o1G
         BZC54J292tPbOROq6sdKjCnEV59rkneWU0K8CmOx0I7noPUzjPn3h+MGJFvRoHd+gEhH
         jy4eHrc92BSEcUayU0opncWRjapQX0f7FxQ0WEerm9f4Xq9jGuXth82FXRlWLZMXf4A2
         MTuXEcN7hf42RoLINkRGIdf8B2ehl1rYn3l38vkKVbVdJ3U3xUIKmuKZZGUgl/+AWzUL
         +X0g==
X-Gm-Message-State: AOAM533PZOphwlIsLfW8RsRO1LAFyMIEeRQ4yRX71nOaCT5D+QZ4mSBM
        NI2bHH5mjjCwtJg+bJ5O6TFz6Q==
X-Google-Smtp-Source: ABdhPJxRV0wt7Uha2/z9XZkBUc9mYcppiJ72YLqp1ThPKmdn8S+ZpdjExghjKIx6cLzq0lU87Q2lnA==
X-Received: by 2002:a4a:d854:: with SMTP id g20mr2695766oov.6.1638329319096;
        Tue, 30 Nov 2021 19:28:39 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w24sm3394628ots.10.2021.11.30.19.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 19:28:38 -0800 (PST)
Date:   Tue, 30 Nov 2021 21:28:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH 2/2] arm64: qcom: sc7280: Add USB2 controller and phy
 nodes for SKU1 board
Message-ID: <Yabr4azUasmQDy7U@builder.lan>
References: <1637837815-8532-1-git-send-email-quic_c_sanm@quicinc.com>
 <1637837815-8532-3-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637837815-8532-3-git-send-email-quic_c_sanm@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Nov 04:56 CST 2021, Sandeep Maheswaram wrote:

> Adding USB2 controller and phy nodes for SC7280 SKU1 board.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 9b991ba..ffd483d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -80,3 +80,19 @@
>  		qcom,pre-scaling = <1 1>;
>  	};
>  };
> +
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";

The commit messages doesn't capture why the mode changes from peripheral
to host.

> +};
> +
> +&usb_2_hsphy {

Is this specific to this SKU? Is there a reason not to keep this in the
dtsi?


Please squash the two patches and please write a proper commit message.

Thanks,
Bjorn

> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l10c_0p8>;
> +	vdda33-supply = <&vreg_l2b_3p0>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +};
> -- 
> 2.7.4
> 
