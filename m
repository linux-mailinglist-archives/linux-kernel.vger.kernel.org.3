Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5745175A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386643AbiEBRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386632AbiEBRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:21:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79EB1E0
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:17:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l18so28940082ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5e/P3oCGEzzkwU7JvpMT6jdvjjKGHwDIEd56ZHarYG8=;
        b=LRJmQXlGVU2DXOpRaxkWINyGq8im14P66sIAc+s5stQ6gWHu3ieT0hyw9ypui62TL/
         0HCNbJb78UhLPPcP7Ys6YMx+plMmvVyOV+dmgS4Xq9ldBPtLIhKx9EA+OME3u5GsimO6
         VrZS8x+d3mWw1OZ1V0rFOEn2qc5IdDiE1Xsxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5e/P3oCGEzzkwU7JvpMT6jdvjjKGHwDIEd56ZHarYG8=;
        b=6CDsIQyH5/FiQVy4mmmY8QYUHw1meEy0ESWs1wjB/X+hekzUC0ypqEdgJah8xKln32
         SKa8cUGQY1dfRpm9r2whUx2aKo2vXf3Fl2RSTg570fLZrbMFT5InbDAvgZqQwyakmNpz
         hFksMlXpR+L1AYmxsm3P3jWAB1WNbCa5dMS3eCGgh8F8m3S+ujwT5TQKbC0eJ3g6aiPn
         sJjinUW98ilYDvgnGikcrxgSl67Tw0Nza5JzZJH1DEPNuCQNh3+L7Hxej58pfCPeHVTO
         N2bthfdTdqZZ/dJSrcQTwN6/W+5zu83mQLe3y4TXngPAqsT+W/UJ1X0iY/vjJq8BWcuV
         Ds2g==
X-Gm-Message-State: AOAM531xhZF/Zm6P7ZPt0Kputc/U/cBW5+u1c/i5vccPvgRfLS2uKCE5
        r6Oek+zhlRHxcYSL8/NdFJQUE7DPl3H5BmQA
X-Google-Smtp-Source: ABdhPJwHvVljYGr4++I72hxcI/jlBbqRKxd/024Wc9AtPqUEFTgmpHlES5dSPXdBNwt+pnBHCpUNgA==
X-Received: by 2002:a17:906:8585:b0:6f3:99f0:d061 with SMTP id v5-20020a170906858500b006f399f0d061mr11902993ejx.436.1651511869102;
        Mon, 02 May 2022 10:17:49 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id f23-20020aa7d857000000b0042617ba63b4sm6842326eds.62.2022.05.02.10.17.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:17:48 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id t6so20394768wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:47 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr10002004wro.679.1651511867348;
 Mon, 02 May 2022 10:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
 <20220430011402.4.Ifba00241fe6e70b59dc3c07eb234da3146e11a03@changeid>
In-Reply-To: <20220430011402.4.Ifba00241fe6e70b59dc3c07eb234da3146e11a03@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 10:17:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxPimB8uyboWtUcuCJW3NkVB-nKzaw=dE9xqCtpNj2rg@mail.gmail.com>
Message-ID: <CAD=FV=XxPimB8uyboWtUcuCJW3NkVB-nKzaw=dE9xqCtpNj2rg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sc7180: Add pazquel dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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

On Sat, Apr 30, 2022 at 1:18 AM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Pazquel is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.

Actually, in pazquel's case no downstream bits are removed.


> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   4 +
>  .../sc7180-trogdor-pazquel-lte-parade.dts     |  22 ++
>  .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  22 ++
>  .../qcom/sc7180-trogdor-pazquel-parade.dts    |  17 ++
>  .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  17 ++
>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 221 ++++++++++++++++++
>  6 files changed, 303 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
