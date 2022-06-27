Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1130E55DAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiF0OA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiF0OAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:00:12 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0EBC2A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:00:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y18so9640847iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CI2gKPn+n2fDcgFRqBz8cXn2h29L1c+hQX/TyD+r20=;
        b=jteZlLGNTXsQBPp78Rb1uBIQkU60XD5rgTNmv0BDc4hkbCvDkyR838Pmx4FL+maIAu
         7mKyLaD3bvwGLGL3BTk5a0sIwR2szqQ+qBrv61sSceDBsvtbA3Jf9SZ9gK3G2ZZdQXN5
         kjJKybFBRDUM5zuAAmzoB07gZg3IMnw4+EyrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CI2gKPn+n2fDcgFRqBz8cXn2h29L1c+hQX/TyD+r20=;
        b=6wZZuCae85pzk0i+R7Rth+KJX/xYRwl7Id/JxaFEcwgrIBYVOlounVPyT2yzyztmFD
         91oXKBd+71m0oymLRYDrPvcLM/MRlkS8L4rjF+u4BfzAMnwKGNBMiQMgflXRZ0YjGT+2
         wDc2TJOyhbEcOTPf+1JUKbAiNiKVpdQMu3ri+H8wihNcWQetxW5Pzs81UNi4hvkfiZJl
         LqYE6N0YxCGmDupX2EY9jEQtiV6XEK0vMfQT8iufysAXkyKR0CY9b2y4aV5f23qeybI9
         XBtzw63vnOPyiVQ564rLBXZkoEPHTM9bzDbehnQR0evxOfLIM3vYpvHf5wpKBsuZkpCb
         wRQw==
X-Gm-Message-State: AJIora8La1Qgoa4XL1/2McTTbH9BBDtjpl99tR3Dhqmf2/HtZ9hh1SVm
        xXNzt5H+/Nz0x+5a//TMIH8n1Tm6HnQXZ8bJ
X-Google-Smtp-Source: AGRyM1uqBDJfbbF4ZRGxZooYmgaKPLsr6tWuE0BEBqjntZPUFyPQstCaf8n9S+XGD8xI3WbuBhM/YA==
X-Received: by 2002:a05:6638:460e:b0:33b:12ee:21dd with SMTP id bw14-20020a056638460e00b0033b12ee21ddmr8186407jab.78.1656338409285;
        Mon, 27 Jun 2022 07:00:09 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id k30-20020a02335e000000b00339e6f88235sm4805459jak.61.2022.06.27.07.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:00:08 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id v185so2948372ioe.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:00:08 -0700 (PDT)
X-Received: by 2002:a02:cf17:0:b0:33c:976c:ef8f with SMTP id
 q23-20020a02cf17000000b0033c976cef8fmr3622193jar.164.1656338408046; Mon, 27
 Jun 2022 07:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220626013906.885523-1-joebar@chromium.org> <20220625183538.v14.3.I71176ebf7e5aebddb211f00e805b32c08376d1be@changeid>
In-Reply-To: <20220625183538.v14.3.I71176ebf7e5aebddb211f00e805b32c08376d1be@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 06:59:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wq4w=AKYCEy71uYFysHD7F+go5oWBuBs0NwBvtahgpRA@mail.gmail.com>
Message-ID: <CAD=FV=Wq4w=AKYCEy71uYFysHD7F+go5oWBuBs0NwBvtahgpRA@mail.gmail.com>
Subject: Re: [PATCH v14 3/5] arm64: dts: qcom: sc7180: Add mrbland dts files
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> Mrbland is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
> (no changes since v7)
>
> Changes in v7:
> - Restore mrbland patch.
> - Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
> - Simplify spi0/spi6 labeling (d277cab7afc7).
> - Simplify trackpad enabling (51d30402be75).
>
> Changes in v6:
> - Remove mrbland patch.
>
> Changes in v5:
> - Replace _ in node name with -
> - Order nodes by name.
> - Add comment that compatible will be filled in per-board.
>
> Changes in v4:
> - Add missing version history
>
> Changes in v2:
> - Add word wrapping to patch description.
> - Remove "Author" from patch description.
> - Fix whitespace around "en_pp3300_dx_edp".
>
>  arch/arm64/boot/dts/qcom/Makefile             |   4 +
>  .../qcom/sc7180-trogdor-mrbland-rev0-auo.dts  |  22 ++
>  .../qcom/sc7180-trogdor-mrbland-rev0-boe.dts  |  22 ++
>  .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  53 +++
>  .../qcom/sc7180-trogdor-mrbland-rev1-auo.dts  |  22 ++
>  .../qcom/sc7180-trogdor-mrbland-rev1-boe.dts  |  24 ++
>  .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi | 344 ++++++++++++++++++
>  7 files changed, 491 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi

Reviewed-by: Douglas Anderson <dianders@chromium.org>
