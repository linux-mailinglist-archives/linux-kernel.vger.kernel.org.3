Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFA55DD63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiF0N7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiF0N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:59:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F269FE5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:59:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so13192409eda.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xr9C6lKJBWSsgA7sh+r218LRs6Tue8WKsUgtQwWr6II=;
        b=OwyNsXe+N1ciOYY5a2+9p/kLZBgOMX6lCaNRB23dU31VZwWM4QVHT0ZuaX3kdB2DbC
         ERSE26axXBNxCwF0OcqQfjtC9679Xw09G2J2qx5IZG44oez2hZcOXdCo/BnWrMyAYbcj
         hlp2r6sSjOvJIRcIleSBWhrpORJsxe5M17J4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xr9C6lKJBWSsgA7sh+r218LRs6Tue8WKsUgtQwWr6II=;
        b=slTPSiRnUfZKUetrAgtxXvaP+dgZ0+X+8bQCuUXIrat+3ckGAEa9braGe/9lR2QdMP
         7Y1PhQetYYoF4ZQsNPvz/lN3wfysLkAhTxOMi+1Om7R0oeZyEnDQhn3qoLm8SLKk0fYX
         zTZvZmudZeXSH+83+tHXmnggzSDDJn5S0A6N4/Jx029MQVQx2qdQr541+HkyRMt5j/PD
         OYFzmIjdI8aOkQDAJ7YNXH8l2b6TWdVGs0c/4Uq0JZI8DDZH6b1XyPRdZ66aAXPaqSNk
         gZknnSUt+JkwaYRsgK7SJ/2OnZPhKLPlGONfHf/Q05PzdK98cCJu2HiASpvdhUJCSwEx
         FSOQ==
X-Gm-Message-State: AJIora9mHor43l6sw+NES04SzrZuNRpLHIyoDbZqeFgbG9nMYzVrC8uw
        6g5E/uRZ7bM8HRGhoifK0yr2fzheL8mdbQ==
X-Google-Smtp-Source: AGRyM1tXnuh+rvXi+fyvrii+acqQf8yfPWw/iNW8yWfk+UREdTX8OV/LUiFp7/V+mN2v3ZNDFDdtwA==
X-Received: by 2002:a05:6402:1d50:b0:436:beac:a4e3 with SMTP id dz16-20020a0564021d5000b00436beaca4e3mr17136089edb.191.1656338362361;
        Mon, 27 Jun 2022 06:59:22 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id j24-20020aa7de98000000b00435726bd375sm7516060edv.57.2022.06.27.06.59.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:59:21 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 189so5014055wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:59:21 -0700 (PDT)
X-Received: by 2002:a7b:c14c:0:b0:3a0:4a8b:e2e5 with SMTP id
 z12-20020a7bc14c000000b003a04a8be2e5mr5559120wmi.188.1656338360672; Mon, 27
 Jun 2022 06:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220626013906.885523-1-joebar@chromium.org> <20220625183538.v14.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
In-Reply-To: <20220625183538.v14.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 06:59:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xs20zLOSwhqL+30ziQquCaqtQ2Od_-3oLF5YAv3FRdUA@mail.gmail.com>
Message-ID: <CAD=FV=Xs20zLOSwhqL+30ziQquCaqtQ2Od_-3oLF5YAv3FRdUA@mail.gmail.com>
Subject: Re: [PATCH v14 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 25, 2022 at 6:40 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Wormdingler is a trogdor-based board, shipping to customers as the
> Lenovo IdeaPad Chromebook Duet 3. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with the camera
> (sc7180-trogdor-mipi-camera.dtsi) #include removed.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
>
> ---
>
> (no changes since v9)
>
> Changes in v9:
> - Correct version history, based on diffing earlier patches.
>
> Changes in v7:
> - Restore changes requested by Doug.
>
> Changes in v6:
> - Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
> - Simplify spi0/spi6 labeling (d277cab7afc7).
> - Simplify trackpad enabling (51d30402be75).
> - Accidentally deleted changes requested by Doug.
>
> Changes in v5:
> - Replace _ in node name with -
> - Order nodes by name
>
> Changes in v4:
> - Clean up rt5682s files
> - Restore camcc definition
> - Add missing version history
>
> Changes in v3:
> - Remove camcc definition
>
> Changes in v2:
> - Word wrap patch description.
> - Remove "Author" from patch description.
> - Fix whitespace around "en_pp3300_dx_edp"
>
>  arch/arm64/boot/dts/qcom/Makefile             |   6 +
>  .../sc7180-trogdor-wormdingler-rev0-boe.dts   |  22 +
>  .../sc7180-trogdor-wormdingler-rev0-inx.dts   |  22 +
>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  53 +++
>  ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts |  29 ++
>  .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  28 ++
>  ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  29 ++
>  .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  22 +
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 408 ++++++++++++++++++
>  9 files changed, 619 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I put this on a google,wormdingler-rev2-sku0 and confirmed that it at
least booted up and showed stuff on the screen.

Tested-by: Douglas Anderson <dianders@chromium.org>
