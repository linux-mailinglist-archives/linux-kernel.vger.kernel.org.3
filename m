Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA359A700
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351356AbiHSUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351210AbiHSUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:14:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E7C2775
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:14:37 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3375488624aso120976257b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8L7+bHVm0h1+I67FWChZbZVTBcw+lGpUv6+U3fMiZWM=;
        b=awXeCwO8IpyJ6UloORqQrGJLvPY2JTkO9ru8WppfBpgYyBtTTPTtcvsujXWe8ticC6
         e6oX/xjcqfQoCner5zndlF4U8WLn/q41ztORxe5jAOVij4tkFokRUbTpRbw3KxpGls3p
         LRQv5/eO4NvDlCbdewUPciS4nR7DM5YlqLngc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8L7+bHVm0h1+I67FWChZbZVTBcw+lGpUv6+U3fMiZWM=;
        b=A6xAYTGeUqAPed2ivOGZU+Rmyy32UHRgon8D/C3F9U2p6lhS0FCshyytQ3nAVhwftW
         BpFfsCT9rzqoDgRtuSdSfkZ2R6AnAOrOi9vSviWiIEsotxj96r9a/eE0s4t6saOOxA8O
         GjC74l+g44YEu9mz+Jwv7sCSgbQdnwV4u+OkV+vsho2gL3HJyqffq4zlnjDKSUkDQhj/
         152YYH/EY4osop/rci9X65rRNNBtiFhvMV9Mlh07OfOB9WjzK08O6jJfMUHC/QKdpEss
         EtiCamjyY5/n7mt1nGslcgtNZCvjLxNABvxOfQmoB6GVF6h2fh9eknwQ01YmnAAtEtgD
         9V6Q==
X-Gm-Message-State: ACgBeo3Ct5vuA6Y34BIYhWW0HYNmJToPC9NnB64P2p3EVE5XS6fTKBVG
        d3vhbotz/O6g/D+iYSXfTsA/vN3mttOKTLqAlXsz9g==
X-Google-Smtp-Source: AA6agR6CCayhZnAMrxJ+v1bK9UJnwnwMBBlBDXq/U5wvwtoOFWPmWroCKCGDPD1Muwlj/dj3C1GkJk5po0HudLnx4iA=
X-Received: by 2002:a25:8892:0:b0:66e:fe43:5aa0 with SMTP id
 d18-20020a258892000000b0066efe435aa0mr8893175ybl.445.1660940076645; Fri, 19
 Aug 2022 13:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org> <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org> <Yv1y9Wjp16CstJvK@baldur> <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
In-Reply-To: <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 19 Aug 2022 13:14:25 -0700
Message-ID: <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This would do that for us, but when all four lanes are connected from
> the qmp phy directly to the connector we could just as easily have done
> it with one endpoint.
>
>         qmp_phy {
>                 ports {
>                         port@0 {
>                                 reg = <0>;
>                                 endpoint@0 {
>                                         reg = <0>;
>                                         remote-endpoint = <&usb_c_ss>;
>                                         data-lanes = <1 2 3 0>
>                                 };
>                         };
>                 };
>         };
>
> So should we explicitly have two endpoints in the usb-c-connector for
> the two pairs all the time, or should we represent that via data-lanes
> and only split up the connector's endpoint if we need to connect the
> usb-c-connector to two different endpoints?

I like 2 endpoints to represent the usb-c-connector, but that doesn't seem
to be compatible (without introducing `data-lanes`, at least) with all
the various
combinations on the remote side, if that remote side is a DRM bridge with DP
output capability (like it6505 or anx7625).
That type of DRM bridge supports 1, 2 or 4 lane DP connections.

So, how about 4 endpoints (1 for each SS lane) in the usb-c-connector port@1?
That should support every conceivable configuration and bridge/PHY hardware.
and also allows a way to specify any lane remapping (similar to what
"data lanes" does)
if that is required.
Then we are consistent with what an endpoint represents, regardless of whether
the DRM bridge has a DP panel (1,2 or 4 lane) or Type-C connector  (2
or 4 lane) on its output side.
