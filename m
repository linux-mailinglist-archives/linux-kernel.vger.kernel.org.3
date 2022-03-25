Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9864E7BD5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiCYVXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiCYVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:23:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3078615AAE2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:21:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h1so10621824edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sP4tT+y1Nyf2HgPARYD3SdiY0hWEX6wWyyCR4CgxXww=;
        b=O9IxCB0OBfJyAtquU8TmcdLzHhY1UHZ5SXDNc92sA5+18unsjh45n3YfSphgmmTTHS
         iR2eiVQfqj3IeM6+vxePvlDTcO1kymWAuNNNEV1C3PwG8eoIL7tmPM3GkOtQtd9e6DN8
         tsRQsINeLLgCuOqWci0bp2vvAgXQARjHe9y10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sP4tT+y1Nyf2HgPARYD3SdiY0hWEX6wWyyCR4CgxXww=;
        b=kzuuy1UJJtbfuQvVK+sJbzrHynM+pxcfODlvUXGBbeunnCnbxkOlzaTaZneBkuq+V0
         MIQGz9nXGi/nxqDGmd+zJmxtG0LjaTEbw5K+bHgY9CBr0gDCkqpd5WxsdzRM8tC8/GEZ
         vy9CcnU38sly3hRNXBcr2tMWb6DkCKe/E/NXzGfTsN81nrn5fw2gWtV9T0tVhtfhxM2w
         DtlriDNgTulQfFhCqsyozjkfSJPwCYClREU/+CTGXrvIYy1O1Wqn3ClhEpcc0YAA58Yh
         VPIIlXBMNbr9cFDVs6c2dxqNORga3VDfjgTSxwwsIg1yVHR55xCDqC+FRgwC+HiX3GDK
         KIuw==
X-Gm-Message-State: AOAM532OknCbj/dicwy9vZZ2Dp8TJu4l0pCQAHJZhUt0kWpNvQviLBpg
        6yUOz8YA+x+ViEYr2rHzsvy3TdmJXrtJWXgFiK8=
X-Google-Smtp-Source: ABdhPJytDK4DOIrJo5pPVE9CFCh4iFPn67A6OqmcFy8wgxabQWhoiZQq46iLLZPVcEqZPhlJNrR3Qw==
X-Received: by 2002:aa7:d309:0:b0:419:128f:7178 with SMTP id p9-20020aa7d309000000b00419128f7178mr820087edq.109.1648243290445;
        Fri, 25 Mar 2022 14:21:30 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709067d5200b006cb0ba8db9esm2816504ejp.14.2022.03.25.14.21.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 14:21:29 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id i67-20020a1c3b46000000b0038ce25c870dso1594375wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:21:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id
 l16-20020a05600c4f1000b0038cae36d305mr21593082wmq.34.1648243289239; Fri, 25
 Mar 2022 14:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220325211640.54228-1-swboyd@chromium.org>
In-Reply-To: <20220325211640.54228-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Mar 2022 14:21:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WL+u5sQLiU4chNMnbxM2n7hgo+fWhHpK=BLOpFtSOW0Q@mail.gmail.com>
Message-ID: <CAD=FV=WL+u5sQLiU4chNMnbxM2n7hgo+fWhHpK=BLOpFtSOW0Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Simply SAR sensor enabling
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 25, 2022 at 2:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The SAR node, ap_sar_sensor, needs to be enabled in addition to the i2c
> bus it resides on. Let's simplify this by leaving the sensor node
> enabled by default while leaving the i2c bus disabled by default. On
> boards that use the sensor, we already enable the i2c bus so we can
> simply remove the extra bit that enables the sar sensor node. This saves
> some lines but is otherwise a non-functional change.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts | 4 ----
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 4 ----
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts | 4 ----
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi             | 1 -
>  4 files changed, 13 deletions(-)

Makes sense to me and even saves a byte or two.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
