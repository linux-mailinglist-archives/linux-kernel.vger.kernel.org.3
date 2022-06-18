Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE655012F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349580AbiFRAPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbiFRAPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:15:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FE415732
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:15:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p69so6086807iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QxFN8UrMFcSUUpM3X2yceWSzBEq/6g0OJ+cr8XRfAY=;
        b=WC55Elfj7HnK76ukAdSAcVsAj3IvHlSwmWziZZbsSfFe9kaQmlj1UqUDStr4vyVnGm
         jMRyEqXSNRJT2+H9F/TRdSIX5J6Mu1yAMs+jBhJEizyz3wQvARZg2+lAO9HERJU9Eix4
         l4fzAqlhWhMmu4qEtHW0W/xOf3V2ybkhpf7rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QxFN8UrMFcSUUpM3X2yceWSzBEq/6g0OJ+cr8XRfAY=;
        b=u5dUxmsvkIIcV+ZJ5LBSnRzQoIf6MSzufVpa1bj5z6zWgreKfIBvchdzKJSgDtIOBs
         t1qQ83ow3BVyuJ699wlCsJKrxMEAL/45+jUEHZL1rYvf2FfoDmo7TvKz1SEKqOMhUthx
         EC/HcbDoGU0KDGmOyJghPM14Gn6XCgUBRsUi7MVFfkR86BGTZnWAc9pK27NMeQEj7m43
         dPxksibMrT6u1QuVajGeICI0RflhaxtpeXAXmlclVY0LWEmWMj690iAhORRTT1hWpcLT
         2GHy6qpBNlysUCDP3IW7xXReoi9CmkMplrz7WB5RzCLi1YMATV+7fBoTGuVmz1TE44vt
         CBPw==
X-Gm-Message-State: AJIora+6hhAVSV6yltKJecjV6vf7nzb7OL+1uD7hd1v0c/eI6NxuCsnd
        ZeuMS13BrKMW4Ap8kxR9vYQavZfDwV4ZRJe0JYw=
X-Google-Smtp-Source: AGRyM1uUdwrChP1pILSM+okOm2VnzfDnYGUMMt9j30ae6qb0l6qLBIUtNYzOKi+RRIs5Wx6RjyrUmA==
X-Received: by 2002:a05:6638:218f:b0:332:37c0:40dd with SMTP id s15-20020a056638218f00b0033237c040ddmr6562772jaj.13.1655511303259;
        Fri, 17 Jun 2022 17:15:03 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id g9-20020a02cd09000000b0033192b7fd35sm2852875jaq.128.2022.06.17.17.15.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 17:15:02 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id 9so594613ill.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:15:02 -0700 (PDT)
X-Received: by 2002:a05:6e02:1747:b0:2d3:e571:5058 with SMTP id
 y7-20020a056e02174700b002d3e5715058mr7074748ill.309.1655511301925; Fri, 17
 Jun 2022 17:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
In-Reply-To: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jun 2022 17:14:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XV_FOTT1WKBEUVCXJgGtay1O8qDi7Mj4BG1AUL6nh9TA@mail.gmail.com>
Message-ID: <CAD=FV=XV_FOTT1WKBEUVCXJgGtay1O8qDi7Mj4BG1AUL6nh9TA@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 17, 2022 at 4:40 PM Joseph S. Barrera III
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
> (no changes since v7)
>
> Changes in v7:
> - Incorporated changes from Stephen's "Simplify!" series.
>
> Changes in v5:
> - Replaced _ in node name with -
> - Ordered nodes by name
>
> Changes in v4:
> - Cleaned up rt5682s files
> - Restored camcc definition
> - Added missing version history
>
> Changes in v3:
> - Removed camcc definition
>
> Changes in v2:
> - Word wrapped patch description.
> - Removed "Author" from patch description.
> - Fixed whitespace around "en_pp3300_dx_edp"
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

Something in this patch series you need to talk about how you relate
to Stephen's two patches, AKA

1. https://lore.kernel.org/all/20220602190621.1646679-1-swboyd@chromium.org/
- arm64: dts: qcom: Remove duplicate sc7180-trogdor include on
lazor/homestar

2. https://lore.kernel.org/all/20220518172525.3319993-1-swboyd@chromium.org/
- arm64: dts: qcom: sc7180-trogdor: Split out keyboard node and
describe detachables

Probably that should be in a cover letter. At the moment, it looks as
if you are assuming that patch #1 is there but you're assuming patch
#2 _isn't_ there. Is that correct?

-Doug
