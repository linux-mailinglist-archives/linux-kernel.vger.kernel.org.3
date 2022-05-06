Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3919C51CFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388939AbiEFDof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388838AbiEFDoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:44:11 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0CF12AD0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:40:28 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e2fa360f6dso6109950fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNNx5SqqknTge4y9/eUvRrcsh9m9RTE+BK27SVwwwhs=;
        b=Y3oK9ZklCqUyV2UCcurb2SZie0KVUZBoED2gV1ZMI54pHlaObR+Yu0zT/4B4URslXU
         L6G/3lv1KbX/2evOvCIeoR+ixzyEP7ORlBdMS+PejkXygXxDWjojZ4QdbvqK5khV4Rg+
         aXl6hBUofLH6/lhsMPnD+Gt3DCuNIGLHpSNROar9lyMsILkTt10qVoPg0fRQ0Hf0/KrI
         Lj322x0AfrbEWjvlMqlNrdgw7jX0QnytRFVMrU9EEqlKnocZzr8VhMqvFztq1OGJQhvk
         wfcTyWXHicx0+w5PgU+0YCbmio7sD6DwE8qEznkr0GpxszA/CS1dyVzU3Q/FoAIlePWV
         74/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNNx5SqqknTge4y9/eUvRrcsh9m9RTE+BK27SVwwwhs=;
        b=Fh8nlKDZpSZmYqj7dGxZz8fPJ9W2HaupuyX7EsBTvuCyFRmQN8fZpfXNVf+lSMROGp
         i7RgbwBW4hVtLI6e23dg/TIDDZNhMUBrugWXOZ85t47pCLGHD2vBs0qnrGb0n0Z+vZ44
         uSvI0GFbt5AE69HMp44DRDHYo9SA3SRqVP19qLlnDN3vwZQNUBQZ5LrmFzQfPtd3l1Md
         SKsFE38jvvmSWa0yx08wbA+0KoERCqgGvg2+q4Bfhw/rParqOxaYKBTOm1boh2xPJOT0
         ldEYMvKqGMK68Ew+DcVct3h/MrF08dp+7P1HgBgmNPWiC5URJN+Lxg2738PAm5LYUpmn
         mQsw==
X-Gm-Message-State: AOAM531jYt4qAvhB4Z4aYZMaSPd0ZNGiRIPFFFEAe4JgCSghQGIxkJyA
        qmi2ZwbRzBuRDcjdH7mjdxu05Q==
X-Google-Smtp-Source: ABdhPJydCEUimIJyazQBa8BRPeEcgTzNUlC4nBe5TecKYIwIBr2ZbEo9p+gDmXN3dQu5R6BUoL3UXg==
X-Received: by 2002:a05:6870:f5a3:b0:e1:944b:6450 with SMTP id eh35-20020a056870f5a300b000e1944b6450mr526370oab.254.1651808428175;
        Thu, 05 May 2022 20:40:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000eb0e40b4b8sm1260245oae.48.2022.05.05.20.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:40:27 -0700 (PDT)
Date:   Thu, 5 May 2022 22:40:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Remove cros-ec
 keyboard from detachables
Message-ID: <YnSYppSYwaoZRXb4@builder.lan>
References: <20220426225748.324759-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426225748.324759-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Apr 17:57 CDT 2022, Stephen Boyd wrote:

> Trogdor devices that have a detachable keyboard still have a
> non-detachable keyboard input device present because we include the
> cros-ec-keyboard.dtsi snippet in the top-level sc7180-trogdor.dtsi file
> that every variant board includes. We do this because the
> keyboard-controller node also provides some buttons like the power
> button and volume buttons. Unfortunately, this means we register a
> keyboard input device that doesn't do anything on boards with a
> detachable keyboard. Let's delete the rows/columns properties of the
> device node to indicate that there isn't a matrix keyboard on these
> boards.
> 

As this seems to directly relate to the final design of each device,
would it make sense to push out the &keyboard_controller from
trogdor.dtsi? Or do you think it would be too much duplication for it to
be worth it?

Regards,
Bjorn

> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 5 +++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> index c81805ef2250..4173623cc241 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -119,6 +119,11 @@ &i2c9 {
>  	status = "disabled";
>  };
>  
> +&keyboard_controller {
> +	/delete-property/keypad,num-rows;
> +	/delete-property/keypad,num-columns;
> +};
> +
>  &panel {
>  	compatible = "boe,nv110wtm-n61";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index bff2b556cc75..7205062e88b4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -121,6 +121,11 @@ &camcc {
>  	status = "okay";
>  };
>  
> +&keyboard_controller {
> +	/delete-property/keypad,num-rows;
> +	/delete-property/keypad,num-columns;
> +};
> +
>  &panel {
>  	compatible = "samsung,atna33xc20";
>  	enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
> -- 
> https://chromeos.dev
> 
