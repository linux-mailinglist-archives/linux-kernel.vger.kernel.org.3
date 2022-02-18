Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399274BB1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiBRGBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:01:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiBRGBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:01:14 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35F626512D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:00:58 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so2419970ooi.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vC5rr9/FFwl108xT94dxdS0audFET9/KpZypiZZFFo0=;
        b=UYyjQv6/7mpgSZOWGk2/ust+6hOD4YjQAmr5tQ5iB2PeMarCwuNe5WoWL/dGHhgvg9
         UAbaXSrf5MWippiTC8ws2jSkTlePYQ6tehyZjxPtBc5uAmU3g1bRYXAyb6bXqgS0ouAd
         Ua6Oxx4UzemOIaFN3q8Rccy9D9rGc8UNh4b4nhxyvOnJZheCXdFW+q70UZr5+9A+Lu0U
         aT2kyp7Y+5vOn+OyNyYW6NFy0CTpObikM5/eUuI+JFi0loqXNagB0UJbmFodqmIdR1e5
         T40vkrs+IfV8K3ekT33j48RnBGf6dLsD/v9gpBw7hX7kE1CYVtkzpglin6tJQe5bFrqz
         5mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vC5rr9/FFwl108xT94dxdS0audFET9/KpZypiZZFFo0=;
        b=Ts/DCHJqZHMGM0RSdUchyQfi2h6MdOFSPnESdJGB6BeXoIosrqHqRtT7Vbq2w96CLI
         JbK/YmymmmMTWbnsZn/fonCw8ZJ1z0VAhSZhVinPKlzM5PwdtImv28es0jPeeJ3jwT0U
         NWv1I82nlUMRN5a7jLqIkNv4ttTzEaft/w+O6Gd6xUAvgS9b/3F1JYw4xMHySvk7Nr7T
         VdgcOP9aZ/5PxnVeaOju09lwFV85IqBnsNKDn5WHfGRcS12rtPKmMCjCwcl4Eo3vbFfF
         ouIZYxq+lO9HDifsJRicQFY8VOdiCo9MPsjNkyrW/1UePaqZVY48yHrYHDJCVXyilWRw
         U2Ow==
X-Gm-Message-State: AOAM530nKpQ0yY3ALhQscIQJVBeT44lk0zX87O3LafXma5a4XdFeuBai
        /1giAgoznSYAri1z2LrcA+YUtQ==
X-Google-Smtp-Source: ABdhPJwMUgPMYZgFc7a9CJBSMUtuUqp+3FcdwropR0b3xxEM7qtpwzSq3DvZN9WJm2f428LBq/Z1TQ==
X-Received: by 2002:a05:6870:d24f:b0:cc:f65f:68e4 with SMTP id h15-20020a056870d24f00b000ccf65f68e4mr2408028oac.167.1645164057943;
        Thu, 17 Feb 2022 22:00:57 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id bc36sm948918oob.45.2022.02.17.22.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 22:00:57 -0800 (PST)
Date:   Thu, 17 Feb 2022 22:03:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com, quic_vproddut@quicinc.com
Subject: Re: [PATCH v4 2/5] arm64: dts: qcom: sc7280: Add support for eDP
 panel on CRD
Message-ID: <Yg82lyRCi3XJHCU2@ripper>
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com>
 <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=VVvcn1VpLXjd+X9Xe50sS_vY5ukKJE8i=eAZf1Phofuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VVvcn1VpLXjd+X9Xe50sS_vY5ukKJE8i=eAZf1Phofuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 17:03 PST 2022, Doug Anderson wrote:

> Hi,
> 
> On Thu, Feb 10, 2022 at 3:58 AM Sankeerth Billakanti
> <quic_sbillaka@quicinc.com> wrote:
> >
> > +       backlight_3v3_regulator: backlight-3v3-regulator {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "backlight_3v3_regulator";
> > +
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +
> > +               gpio = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&edp_bl_power>;
> > +       };
> 
> So I'm pretty sure that this is wrong and what you had on a previous
> patch was more correct. Specifically the PMIC's GPIO 7 truly _is_ an
> enable pin for the backlight. In the schematics I see it's named as
> "PMIC_EDP_BL_EN" and is essentially the same net as "EDP_BL_EN". This
> is distinct from the backlight _regulator_ that is named VREG_EDP_BP.
> I believe the VREG_EDP_BP is essentially sourced directly from
> PPVAR_SYS. That's how it works on herobrine and I believe that CRD is
> the same. You currently don't model ppvar_sys, but it's basically just
> a variable-voltage rail that could be provided somewhat directly from
> the battery or could be provided from Type C components. I believe
> that the panel backlight is designed to handle this fairly wide
> voltage range and it's done this way to get the best efficiency.
> 
> So personally I'd prefer if you do something like herobrine and model
> PPVAR_SYS. Then the backlight can use ppvar_sys as its regulator and
> you can go back to providing this as an "enable" pin for the
> backlight.
> 
> I know, technically it doesn't _really_ matter, but it's nice to model
> it more correctly.

While I've not seen your schematics, the proposal does look similar to
what I have on sc8180x, where there's a power rail, the BL_EN and a pwm
signal.

If that's the case I think representing BL_EN using the enable-gpios
property directly in the pwm-backlight node seems more appropriate (with
power-supply being the actual thing that powers the backlight).

If however gpio 7 is wired to something like the enable-pin on an actual
LDO the proposal here seems reasonable, but it seems unlikely that the
output of that would be named "backlight_3v3_regulator"?

Regards,
Bjorn
