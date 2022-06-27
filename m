Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB855CEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiF0OBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiF0OAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:00:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F54BC19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:00:46 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h85so9640090iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfQIPcnnZ/8AhvVrSSeRNLZ+wx9pV8K5i+/PaAmnetU=;
        b=jANAnPC+NShW3s8/M7l2+iL3WxhOCnhIa0tvqhV5Z1Kb6Gbv6FCk7lzqF+0oO3kH3Y
         6IvLi3TfITmP+0VW4nSnSK6JExRBhb/B37CEmLgXeCD7edIJgiOEIdzAaULe9nEivEbe
         ahyz6ui+veVsicFEGpibEWE0B8uyOF4DzETr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfQIPcnnZ/8AhvVrSSeRNLZ+wx9pV8K5i+/PaAmnetU=;
        b=SAPkVYgiMm6yaTTKBb3/vvrQijeKruESIv4DZPxUX8DrBSPQx3h984ve8+31akb7Up
         hYVTBfGNMKK0PH4E3BS/sKvwZGo3ZcTyM+FlltSWhrePMTv4mOCa8hZQVPhgAArNME3M
         bLUpNPueVRZ9c/7asEvwc5oYP5NBtlvARg4z/8ThJhXMG0tMBjWM4Lnk1CXaCG5VhFoE
         zCHwioIg9A+gESZXpXXetT8gYBZ2f6suJUEUkQVz7ofg1npxKaALG8kjlJg8aUqmRZEA
         wCneFuLEF5kIYtkqNeFqXDyT/JkeTZ4sDNaW9Em3kKsZE23zXCjRlQA2adaL/IU6CswT
         83vQ==
X-Gm-Message-State: AJIora+2UNu7vqRii8m99feP9m87jUUDcY7ZWsRCpHKZCrRinsO2FiHL
        vBFp8mBOHrkowNVTPuCsbftQKdExLo8Fl4NW
X-Google-Smtp-Source: AGRyM1thop9FMTZLBBjh+pZaBAsNLO6Y1FFaXb+xBXhR3eg5gdQweCeK3E3kpqO0qhYswI4g+CBrkA==
X-Received: by 2002:a5d:981a:0:b0:672:4ea1:5f55 with SMTP id a26-20020a5d981a000000b006724ea15f55mr6707748iol.186.1656338446162;
        Mon, 27 Jun 2022 07:00:46 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id a14-20020a056638018e00b00335d7c314b1sm4834959jaq.53.2022.06.27.07.00.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:00:45 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id m13so9698796ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:00:45 -0700 (PDT)
X-Received: by 2002:a5e:a506:0:b0:66a:2cdc:e6f7 with SMTP id
 6-20020a5ea506000000b0066a2cdce6f7mr3706555iog.113.1656338445097; Mon, 27 Jun
 2022 07:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220626013906.885523-1-joebar@chromium.org> <20220625183538.v14.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
In-Reply-To: <20220625183538.v14.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 07:00:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwhrHJEmEAqz-9MaBcbKO79vXjswqAt8NVnAo7Bf3mnA@mail.gmail.com>
Message-ID: <CAD=FV=UwhrHJEmEAqz-9MaBcbKO79vXjswqAt8NVnAo7Bf3mnA@mail.gmail.com>
Subject: Re: [PATCH v14 4/5] arm64: dts: qcom: sc7180: Add pazquel dts files
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
> Pazquel is a trogdor-based board. These dts files are unchanged copies
> from the downstream Chrome OS 5.4 kernel.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
> Changes in v14:
> - Remove unidiomatic compile-time test for duplicate include.
>
> Changes in v13:
> - Remove 'include sc7180-trogdor.dtsi' in sc7180-trogdor-ti-sn65dsi86.dtsi.
> - Add compile-time test for duplicate include in sc7180-trogdor.dtsi.
>
> Changes in v12:
> - Replace 'include sc7180.dtsi' with 'include sc7180-trogdor.dtsi'
>   in sc7180-trogdor-ti-sn65dsi86.dtsi.
>
> Changes in v11:
> - Add 'include sc7180-trogdor.dtsi' to sc7180-trogdor-pazquel-* files.
> - Restore 'include sc7180.dtsi' to sc7180-trogdor-ti-sn65dsi86.dtsi.
>
> Changes in v10:
> - Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-pazquel* files.
> - Move "okay" for ap_tp_i2c to proper location.
>
> Changes in v9:
> - Restore two lines accidentally removed from ap_sar_sensor.
> - Simplify trackpad enabling (51d30402be75).
>
> Changes in v7:
> - Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
> - Simplify spi0/spi6 labeling (d277cab7afc7).
> - Remove #include of <arm/cros-ec-keyboard.dtsi>.
> - Accidentally removed two lines from ap_sar_sensor.
>
> Changes in v6:
> - Copy changes to ap_sar_sensor from v5.4.
> - Add #include of <arm/cros-ec-keyboard.dtsi>.
>
> Changes in v4:
> - Fix description (no downstream bits removed).
> - Add missing version history.
>
> Changes in v3:
> - First inclusion in series.
>
>  arch/arm64/boot/dts/qcom/Makefile             |   4 +
>  .../sc7180-trogdor-pazquel-lte-parade.dts     |  22 ++
>  .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  22 ++
>  .../qcom/sc7180-trogdor-pazquel-parade.dts    |  17 ++
>  .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  17 ++
>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 221 ++++++++++++++++++
>  6 files changed, 303 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I put this on a google,pazquel-rev3-sku1 and confirmed that it at
least booted up and showed stuff on the screen.

Tested-by: Douglas Anderson <dianders@chromium.org>
