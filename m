Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB82510D16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356350AbiD0AVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiD0AVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:21:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4822349FA7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:17:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dk23so238294ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34otp1ic0ss1djD2XvGMVif0idr2cQGkKe33kd/rACY=;
        b=RRPUBGP+JGovd3brJQrzeniaOe9vtwrzEuf8ZoaDNHfZ5/xh2IYrUpq2DCGUqCgC9a
         /kdmoLtVb/e6uNWIeSRSDQXO93Z49u8WECf86sUl+Ms7sTyvALfXXEKPzL2/7WnosRp4
         KoiLYuZvPb3aqcb/ylZ40eUUwlQXXniilQpKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34otp1ic0ss1djD2XvGMVif0idr2cQGkKe33kd/rACY=;
        b=5W9yLPPguDu2bst+75kaR4TAXYROGy8GAsOBr6OWQsS5qL60YLhpaj0TF4lVsUBg7Y
         msnBQ3djFcX3Un3P7n36maA6CLvZWP10G6oIcawEJcSgcp4EDVcX/+uIdoUaNvcRDTll
         eeCvwN1vu1oiEehT/KMCAz7qjNzizsa5UMYChx4UAOfkkXXgJ2/CRYX3mJqAQPiYD6a4
         D0lQEP4v+vVh77vcgk0i8yDR4nUrslSoUSmYVgF/iciYkDjTF1W14bCQOatlXKzY5Z+e
         zwo6IE7Po7maSpAyjXckZgRqQoAv5J1oiPEHk/LmR1+XH3h1caoxRZHvdoC8tUpgfpzj
         Bjwg==
X-Gm-Message-State: AOAM532xBlvzWuRwlzIkYs8HI0dXKDc7iNNx50+5jP4odkM/oRPXrX/X
        X7nWKPLwQi0to3XF64p497tEu78HuV6R5bdrA64=
X-Google-Smtp-Source: ABdhPJy3NlFv9iwFW71l9DRlLXaRARFV1D+1n7PIdjqUCoVrzAvAd3h5KLEcEbKgHIFfjFbCj6f4lw==
X-Received: by 2002:a17:906:32d5:b0:6f3:be75:8485 with SMTP id k21-20020a17090632d500b006f3be758485mr2628001ejk.685.1651018670559;
        Tue, 26 Apr 2022 17:17:50 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906768200b006e89514a449sm5631231ejm.96.2022.04.26.17.17.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 17:17:50 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso2511362wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:17:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr23337925wmb.199.1651018669353; Tue, 26
 Apr 2022 17:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220426225748.324759-1-swboyd@chromium.org>
In-Reply-To: <20220426225748.324759-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Apr 2022 17:17:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMf0Jc9oD7CGoLthguzt2aV31sZmFoenbjn72MfwFYEA@mail.gmail.com>
Message-ID: <CAD=FV=WMf0Jc9oD7CGoLthguzt2aV31sZmFoenbjn72MfwFYEA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Remove cros-ec keyboard
 from detachables
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 3:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
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

Presumably we need to do this same thing for wormdingler [1]

[1] https://lore.kernel.org/r/20220426151204.1.Id2821de5fde55ebe928e8fc87a71c8d535edb383@changeid

Reviewed-by: Douglas Anderson <dianders@chromium.org>
