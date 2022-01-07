Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63429486F19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbiAGAwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343978AbiAGAwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:52:31 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD6C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:52:31 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h5-20020a9d6a45000000b005908066fa64so4098901otn.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3aPUnzYtbQdyger4FFqFgLjI63Heqt9JjnVsTDvx1g=;
        b=YQRWy5nSJPHQ4hRAob2yOMp9D4kCgJVQ5yHcHhKjyTW/DJECb5qacmqSX79+xOSbs4
         OcGPjU5cD2lngXPtzWSEHYB9nSmbZzIO+0jL4IFiZmMx/ZX68ZU7w7Za9vevCPEYUaXc
         rRa0/MOnudrWVMZ+MCWKVmhwbWT5V/5zkB6EMpTxlPGIvSjNo0CWp09/MaSEAjjKXI4m
         E5oxEz37pnP/Naar8HLJE9Kl4vWvyg1jo1IeZ70iX8TOXBbSVasphZ/HGduyZoaBJWwP
         jvGRHaPE4XIZcQjcxF2OaNPEU+Cb/D2BAwKybhbLHlV67dlv4GRUHlCugGGw8IHpwN/y
         9rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3aPUnzYtbQdyger4FFqFgLjI63Heqt9JjnVsTDvx1g=;
        b=czjrLcTvG8uDYQn1b4w/OEPTT1fuArn5GwRM5TWpr9VHF/Pejv5p+9hAXD4afWTQ/y
         5f/2dr9PujxszEehWLY0A1+AbfZNYBwdMmuw3e+b1+L/D3l6ijCFO6ihVMtmgRxxPbpB
         lIBMU/E1bg6Q015uNltucebq17mu6jJpi5D28c5GMsofm6o6Bhg8FarlaH+00tLuRQx+
         lrSNybMwkuASDq4Zf5R1wDM4qvmzTUQlzyv1LoonvP12Hk6l5DBy612m5GxkLsOQkuHR
         7XuGMwFudqCpXDufGM137H2LMjdt0ocCs0ZeTz2ioYKFOBSNh19OB5tbKu0IEVZhmr7o
         dqNg==
X-Gm-Message-State: AOAM532GThEV+xSjqalGug3/tIDBDSlX5UKd9gQ0X8IgSWTO8Wq/l/RG
        sL3CWGBPYg83J4LeV/xeAmV0OA==
X-Google-Smtp-Source: ABdhPJxaEwr/pVgQRGR6oItzZwZipY1ky/bn7O+vG2jFuV4Le4fXzFXjJf1hnC0sL5fZCeu+yYTOuw==
X-Received: by 2002:a05:6830:10cc:: with SMTP id z12mr1216616oto.99.1641516750511;
        Thu, 06 Jan 2022 16:52:30 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bi20sm760074oib.29.2022.01.06.16.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:52:30 -0800 (PST)
Date:   Thu, 6 Jan 2022 16:53:17 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        greg@kroah.com, linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH V3 5/7] arm64: dts: qcom: sc7280: Add EUD dt node and
 dwc3 connector
Message-ID: <YdeO/T0kQtNQfmx+@ripper>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <baf41480be71bd4472fe09c2993e43a780554d94.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf41480be71bd4472fe09c2993e43a780554d94.1641288286.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jan 03:58 PST 2022, Souradeep Chowdhury wrote:

> Add the Embedded USB Debugger(EUD) device tree node. The
> node contains EUD base register region and EUD mode
> manager register regions along with the interrupt entry.
> Also add the connector to EUD which is mapped as the child
> of dwc3. The connector is attached to EUD via port. Also add
> the role-switch property to dwc3 node.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 53a21d0..2d14e5c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1315,6 +1315,18 @@
>  				phys = <&usb_2_hsphy>;
>  				phy-names = "usb2-phy";
>  				maximum-speed = "high-speed";
> +				usb-role-switch;
> +				usb_con: eud_usb_connector {

I think this is backwards.

Iiuc you have dwc3 <-> EUD <-> connector, where the connector typically
would be represented in relation to a Type-C controller.

So I think this graph should be looking something like:


dwc3 {
    ports {
        port {
            dwc3_eud: endpoint {
                remote-endpoint = <&eud_ep>;
            };
        };
    };
};

eud {
    ports {
        port {
            eud_dwc3: endpoint {
                remote-endpoint = <&dwc3_eud>;
            };
        };

        port {
            eud_con: endpoint {
                remote-endpoint = <&con_eud>;
            };
        };
    };
};

connector {
    compatible = "usb-c-connector";

    ports {
        port {
            con_eud: endpoint {
                remote-endpoint = <&eud_con>;
            };
        };
    };
};

With EUD "forwarding" the role switching requests from the connector, or
overriding them if the EUD is enabled.

Alternatively the dwc3 would be in a graph with both the eud and the
connector, but I don't know how to ensure that the EUD decision takes
precedence over the type-c controllers role request...


In the case of us having a type-c controller, such as the pmic_glink,
the connector node would then be a child of the controller.

Regards,
Bjorn

> +					compatible = "qcom,usb-connector-eud",
> +						     "usb-c-connector";
> +					ports {
> +						port@0 {
> +							usb2_role_switch: endpoint {
> +								remote-endpoint = <&eud_ep>;
> +							};
> +						};
> +					};
> +				};
>  			};
>  		};
>  
> @@ -1339,6 +1351,19 @@
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		eud:  eud@88e0000 {
> +			compatible = "qcom,sc7280-eud","qcom,eud";
> +			reg = <0 0x88e0000 0 0x2000>,
> +			      <0 0x88e2000 0 0x1000>;
> +			interrupt-parent = <&pdc>;
> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +			port {
> +				eud_ep: endpoint {
> +					remote-endpoint = <&usb2_role_switch>;
> +				};
> +			};
> +		};
> +
>  		nsp_noc: interconnect@a0c0000 {
>  			reg = <0 0x0a0c0000 0 0x10000>;
>  			compatible = "qcom,sc7280-nsp-noc";
> -- 
> 2.7.4
> 
