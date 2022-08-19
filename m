Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED1159A80B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiHSWBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHSWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:01:02 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D1EE11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:01:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t8so6155093oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=o8iYYAnCTLcF0RHoVEFEI4W9A1FPsaaEbHxceZXQpik=;
        b=YXgeZg28e0kHRgTYGQJH0LhX1VaFd9xeb3QTMJDjfis9JiP8BFIRXCG/AsGaixepIJ
         E5tSi5uJ8NCEwvtdEjd+V+U9XnePf5U4DpAwxKWumVfUdWhJCbaisEk6Z/wa2xyagJ8+
         dvDV4YQk+YiSwek9p2c1N1G1ntR5mDt1o1lX4ewlyOxu6lyIYKPJZw57fxBNC1ofKait
         DSoU/P6lNw0cOMKZM2k07tVo1EneL7GHo/PFU1Pe14LDluuybagcCkgJdhdtRurNR/8X
         oQ+qyXnpRAA2eua7DtTivTrVcKJHgMGWWt6FTIKfF0Q6OBIU27wmwVPwdMcdId0jwnWX
         /7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=o8iYYAnCTLcF0RHoVEFEI4W9A1FPsaaEbHxceZXQpik=;
        b=oyPKjSWg3cD8L1pygJUZFBwb7bhJcS/Sa9PFZYcezATrW+1m0J/MEwHrWadm1uGqIH
         tks8jx8iBt5vo8kx2E27dVChuDVd8gTbu8wsQ/9i7XVuNY0DdfIfs5zERo8iBXdjGPy3
         P3Ofn7vEqWTKm6GSfMaQRfNqM0RaKUSo33O+5+Y62e50xzs3pTtP+jj6v5VLIah8AJud
         kIiTfJRjrMf3foTMM95Q13SqzLF/LrGp3cLsn9Qs8hp2gyocn4o6L6Ym3PBUB8l7omra
         So0sxRLrY39PtXFTtY+FnVpmTMCHQp+TkFFNZsR1KPWHw09w/8K8xVgSbYMWj89yOsw4
         QkYg==
X-Gm-Message-State: ACgBeo13jHNRHS5aLcebaN7pN1UBUuKaiR/zgEQXEJD33RK+IWi8myLb
        UgS9U8bzlVuVTLvXt37x3CBXgA==
X-Google-Smtp-Source: AA6agR6t+mnakNIjRSQF/xcrCwwGUbChZla4wD4sS/NAQjVRl5mABQYyxf5N6ui99QoekeDYmZZ1QA==
X-Received: by 2002:a05:6808:13d4:b0:343:7127:fab with SMTP id d20-20020a05680813d400b0034371270fabmr4184660oiw.86.1660946460329;
        Fri, 19 Aug 2022 15:01:00 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g19-20020a4a8953000000b00435a8024bc1sm1214510ooi.4.2022.08.19.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:00:59 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:00:57 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <YwAIGf59H9iKUhXF@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
 <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Aug 15:14 CDT 2022, Prashant Malani wrote:

> > This would do that for us, but when all four lanes are connected from
> > the qmp phy directly to the connector we could just as easily have done
> > it with one endpoint.
> >
> >         qmp_phy {
> >                 ports {
> >                         port@0 {
> >                                 reg = <0>;
> >                                 endpoint@0 {
> >                                         reg = <0>;
> >                                         remote-endpoint = <&usb_c_ss>;
> >                                         data-lanes = <1 2 3 0>
> >                                 };
> >                         };
> >                 };
> >         };
> >
> > So should we explicitly have two endpoints in the usb-c-connector for
> > the two pairs all the time, or should we represent that via data-lanes
> > and only split up the connector's endpoint if we need to connect the
> > usb-c-connector to two different endpoints?
> 
> I like 2 endpoints to represent the usb-c-connector, but that doesn't seem
> to be compatible (without introducing `data-lanes`, at least) with all
> the various
> combinations on the remote side, if that remote side is a DRM bridge with DP
> output capability (like it6505 or anx7625).
> That type of DRM bridge supports 1, 2 or 4 lane DP connections.
> 

You can't physically connect 1, 2 or 4 lanes of DP from a DP chip to
your usb-c-connector at the same time as you physically connect 0, 2 or
4 lanes of USB from a USB PHY.

You must either have another component inbetween, or you will connect
some predefined subset of those signals to each output.

In the case where you have a mux of some sort inbetween, that would be
the thing that the usb-c-connector's port@1/endpoint references.

In the case that you hardwire 2 SS lanes to USB and 2 to the DP
hardware, you could specify port@1 with two endpoints and the Type-C
controller would be able to signal both when to turn on/off their
signals. But you wouldn't be able to do orientation switching.

> So, how about 4 endpoints (1 for each SS lane) in the usb-c-connector port@1?
> That should support every conceivable configuration and bridge/PHY hardware.
> and also allows a way to specify any lane remapping (similar to what
> "data lanes" does)
> if that is required.

Wouldn't that prevent you from handling orientation switching, given
that the graph is static?

> Then we are consistent with what an endpoint represents, regardless of whether
> the DRM bridge has a DP panel (1,2 or 4 lane) or Type-C connector  (2
> or 4 lane) on its output side.

We can represent that perfectly fine with the proposed bindings.
In the USB Type-C case I have:

dp-controller {
    phys = <&qmp>;

    ports {
       dp_hpd: port@1 {
            endpoint = <&port_1_endpoint_1>;
        };
    };
};

qmp: qmp {
    port {
        qmp_out: endpoint {
            remote-endpoint = <&port_1_endpoint_0>;
        };
    };
};

connector {
    compatible = "usb-c-connector";
    ports {
        port@1 {
            port_1_endpoint_0: endpoint@0 {
                remote-endpoint = <&qmp_out>;
            };
            port_1_endpoint_1: endpoint@1 {
                remote-endpoint = <&dp_hpd>;
            };
        };
    };
};

The dp-controller binding is defined to have the output on port@1 and by
implementing a drm_bridge in the controller backing the connector it
will find that. The controller can use the links to inform the QMP about
muxing and orientation switching.

In the case of DP we have:

dp-controller {
    phys = <&dp_phy>;

    ports {
       dp_hpd: port@1 {
            endpoint = <&dp_connector>;
        };
    };
};

dp_phy: dp-phy {
    compatible = "qcom,dp-phy";
};

connector {
    compatible = "dp-connector";
    port {
        dp_connector: endpoint@0 {
            remote-endpoint = <&dp_hpd>;
        };
    };
};


The link between the dp_phy and the dp connector could be expressed
further, but this is a binding that already exists...

Regards,
Bjorn
