Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D54B1A20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiBKAIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:08:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbiBKAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:08:44 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09ED93
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:08:42 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso4910882ott.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fcC0SEpVltFRTxoXkp53F9HT6U0x1VaT4hIpMkDokFA=;
        b=ugzulgstXhccLImdFMnJdEshlBhA4kJzeZIOEEsVkSKwCmvbAEVmq9bssZqIMdw/7t
         bTWC6ml41kJn1oCAn6eBY97CZ0QuM5fnjIPwluI94Hx65W+4UaM6WIigKUTtyuNkxqQK
         g5nmVhkg0RZTXJXFPstX5Z4veqfI3PCJYQDOeLaac3BmdHdimTQbZNkGDx0+X+WtkTjo
         Ez5wHKFG+FgMekmSFNCcYi9uFr6rfJCiD+RY86Fh/qrPO3rFLBVU8M1TLPpJmH765buY
         UdBIZeLbWu4RdJo4dxTbFyRTQmlPIOiIIFZ71VobbhcBb8MJQ3JRsww/J/IDZLppRQ71
         c6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcC0SEpVltFRTxoXkp53F9HT6U0x1VaT4hIpMkDokFA=;
        b=KTGoLfsOvkzbtkRTOaBVX7TCnBgQKRfWOyeohNyPgFfyvDIAZPsiRBWs4dUna0XpW3
         gDd0muhVOYJPWw5ZWG7vlgAd9yFBYbM/9egjn6YLME+fxo4lnWTHNioGF3e6Cz7Zz7ST
         VcLnhSCLfiIQnbmKEWb0ENt7KpXss4ejp/XTaopEl26dx8hu+PzrK8wySlaa7BN6lFTF
         JS254CTTSq1VaKVh3kQHHewtvGYgxy8vFbffrzMzbTyD0BZFjcbrS+nayIjI+/mxpn3V
         sAyyUSVQdyK4Hv8+tLELIulwWlU9br9jCxCizDJukwC88VjERlExnlTXjrDw66kfxny9
         M0cg==
X-Gm-Message-State: AOAM533GC8BTX33Umdmup+pVt9iiWHBebuMrWwQBlfU7fA59ZmpiQdab
        F701pGz+mX8K4x9SkwFNVqWRog==
X-Google-Smtp-Source: ABdhPJzHWAm1wwa3ofVjl2ssMnyXrqm4FEc3LXrZHVFMkRd2t4i2qVF3LIT3WQAJ/lod7ClR9v4NOQ==
X-Received: by 2002:a05:6830:19f7:: with SMTP id t23mr2021359ott.256.1644538122230;
        Thu, 10 Feb 2022 16:08:42 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id bg34sm9133324oob.14.2022.02.10.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:08:41 -0800 (PST)
Date:   Thu, 10 Feb 2022 18:08:39 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org, robh+dt@kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        dianders@chromium.org, krzysztof.kozlowski@canonical.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com, quic_vproddut@quicinc.com
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: sc7280: rename edp_out label to
 mdss_edp_out
Message-ID: <YgWpB6dwDP0XeLaj@builder.lan>
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com>
 <1644494255-6632-4-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644494255-6632-4-git-send-email-quic_sbillaka@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Feb 05:57 CST 2022, Sankeerth Billakanti wrote:

> Rename the edp_out label in the sc7280 platform to mdss_edp_out.

Next week, or in the next product, it might not be obvious why we did
this change. So please continue this sentence with something like "so
that the nodes are grouped together when sorted in the dts".

> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 10 +++++-----
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index 6dba5ac..af40e14 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -69,7 +69,7 @@
>  			port@0 {
>  				reg = <0>;
>  				edp_panel_in: endpoint {
> -					remote-endpoint = <&edp_out>;
> +					remote-endpoint = <&mdss_edp_out>;
>  				};
>  			};
>  		};
> @@ -129,10 +129,6 @@ ap_ts_pen_1v8: &i2c13 {
>  	};
>  };
>  
> -&edp_out {

You just added this node in patch 2 and now you change it immediately.
If you reorder the two patches the history will be cleaner.

Thanks,
Bjorn

> -	remote-endpoint = <&edp_panel_in>;
> -};
> -
>  &mdss {
>  	status = "okay";
>  };
> @@ -156,6 +152,10 @@ ap_ts_pen_1v8: &i2c13 {
>  	/delete-property/ pinctrl-0;
>  };
>  
> +&mdss_edp_out {
> +	remote-endpoint = <&edp_panel_in>;
> +};
> +
>  &mdss_edp_phy {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 3572399..eca403a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3066,7 +3066,7 @@
>  
>  					port@1 {
>  						reg = <1>;
> -						edp_out: endpoint { };
> +						mdss_edp_out: endpoint { };
>  					};
>  				};
>  
> -- 
> 2.7.4
> 
