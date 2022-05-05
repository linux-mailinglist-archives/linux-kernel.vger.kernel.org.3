Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2F51CB97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386089AbiEEVtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386121AbiEEVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:48:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008DE13F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 14:45:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y3so11068628ejo.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9a49K+nsIpClkkZJMCjWXi8/OJdtqcmRhzbltH+MvOc=;
        b=kp3l63ItWPcoj3mIJFjL1IS0DRKLyCgq8rg4f+5Xx4U7BSNFu/vpr3X3kPrINxWG1y
         d4JS+qP+fmnZlhoPr5rrxuKxTeRFD8zpP3dHL+NRp/2aruwblCvzL3UEjWgzvScPOgHO
         OoIyC3l+RahxKrVlyOwHDLG9nq+F4L/tutw2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9a49K+nsIpClkkZJMCjWXi8/OJdtqcmRhzbltH+MvOc=;
        b=6xTEc+bosi6p8OdqgpJWgxhhxXWDgv5jSjefVMj5CDHXHq34kMcKH2Wqrsif7EUzM2
         bdR+DiMY37RMV6kHeKyHezdel42vKtV7HwHsu+hMe6MZmsDJuqZJoug/dEgQ0yMNBdnT
         iPazOyQowHMf1P/rBmjP6wCsudna6gyvcv5xoJgM7cCemXbaJgvyQDCPygxl/US9lYMI
         2FsDeHdx1/OT5bW9+YVup3A3r1CJ+mHEY0HgKEdbP4cZsmJuUtbSrUcx1nGCAFDZ9HxW
         wvZ3y7eJBU24yAzZUs99xajtRRy7YItE/917Vu4shojIsOweS7/Kq4QHHyi5zt6iP9zj
         5Hxw==
X-Gm-Message-State: AOAM531pPiUCGwcRadIaunqzGUSQmpnZSgNtc8xOjNHMRtUTwwrL5FZY
        rm4S+NOUz56s8GADRYgjuYONiA3Vsag4uDaGIT4=
X-Google-Smtp-Source: ABdhPJyrMRsu5HTIi3183QWP3opdE7Uon0huuiFK9Lea6QaP07mmVS5GVttPc8GLSTeAQ3dxkismsA==
X-Received: by 2002:a17:906:58c7:b0:6da:955b:d300 with SMTP id e7-20020a17090658c700b006da955bd300mr164951ejs.481.1651787113153;
        Thu, 05 May 2022 14:45:13 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b006f3ef214e03sm1178166eju.105.2022.05.05.14.45.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 14:45:12 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id q23so7714156wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 14:45:12 -0700 (PDT)
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id
 t8-20020a5d42c8000000b0020ad91f87b5mr103577wrr.301.1651787111509; Thu, 05 May
 2022 14:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220505104024.v4.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
In-Reply-To: <20220505104024.v4.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 May 2022 14:44:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vb8EJJakDYkZLiAEqU1iFUfU4oNwAbTqiH9dM7Ph0BxQ@mail.gmail.com>
Message-ID: <CAD=FV=Vb8EJJakDYkZLiAEqU1iFUfU4oNwAbTqiH9dM7Ph0BxQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts files
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

On Thu, May 5, 2022 at 10:43 AM Joseph S. Barrera III
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
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 417 ++++++++++++++++++
>  9 files changed, 628 insertions(+)

This series looks great now to me now. Bjorn: if you agree and if it's
not too land to land these for 5.19 that'd be wonderful. Otherwise I
guess we've snooze for the next 4.5-5.5 weeks... ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
