Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F4A5790C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiGSCX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGSCXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:23:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096D13C8D9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:23:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ez10so24578260ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxemPh1G2bV0CErrw/K/K5kZfPDDvrAnSzpKEzeBXc4=;
        b=MS/gx6WdiejfkjXBNgMQ/VZF7RonuoyhbwV39y3Q+ClHIaBb4f9ztx3WkUpa+2gyfF
         /q4cGzo3PJu1rCudrXlNEZJmtNZqtgR91O2tbHgWY+7SYrSavF4Q6p7EKS5BIzgEwJzF
         D4yy3UZbr20IcYfupTbEIjLYDo+XQGUWkUqZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxemPh1G2bV0CErrw/K/K5kZfPDDvrAnSzpKEzeBXc4=;
        b=FouSiw6Y0lKJPOy7gH4P70ibkF/PU8HF1/H7UGihmbTuevAIcTiNg9QHGziZ81GeAG
         cRAY/TUlLBE2pI0P7yGXvDFF7e5kJTSQC2ktkShmSPPX7z2MoXhPD3TaPgRd6sco39C0
         aeyYlTJORGO5+W4uk2zj1NAlCRg84IxTiCpA+BuBAPaUGlc8oJibIHcDWo5lUByeZ2NN
         tVFozdVP+jH5+5ACh20s7lesC6T5Mm524QtHXQQBoH6UhWXMRKX0YSMuy7dZj6arAie8
         H6HM81MT+q/loIcTDWdgkWpsZkazw9FhPOs18PsizUMlyijnwUBlNcpe49oeUHx7Aduu
         b6JA==
X-Gm-Message-State: AJIora8hvPfdsEwgBTLnXET0PSG0fYRDC68Unf4Ol4I1nyx1xer5l5eP
        k21sefjpJ0FVv0+qRxEyWo1PSs2tNSAShrn7
X-Google-Smtp-Source: AGRyM1u0Hh7QVuaLJHnTwNEcOJYXxp5ol8E1O4QA+NuuEcoUhdrLvOt1ZHk0JUcSB8CdizaiQGXirg==
X-Received: by 2002:a17:907:2854:b0:72b:7daf:cc0d with SMTP id el20-20020a170907285400b0072b7dafcc0dmr27741610ejc.524.1658197432369;
        Mon, 18 Jul 2022 19:23:52 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id gz13-20020a170906f2cd00b00722e1bca239sm6089940ejb.204.2022.07.18.19.23.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 19:23:51 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bu1so19567415wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:23:51 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr24317717wrf.659.1658197430996; Mon, 18
 Jul 2022 19:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220719020327.1.I3aa6575984116a740e0fd15d13562424af73fd07@changeid>
In-Reply-To: <20220719020327.1.I3aa6575984116a740e0fd15d13562424af73fd07@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jul 2022 19:23:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+HsufL=rKDhEnAyM9pF+FHq_+LP3UZUr5ahfFddptgg@mail.gmail.com>
Message-ID: <CAD=FV=W+HsufL=rKDhEnAyM9pF+FHq_+LP3UZUr5ahfFddptgg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add sc7180-trogdor-pazquel
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 18, 2022 at 7:03 PM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> Pazquel is a trogdor variant.
> There are 4 types:LTE+TI/LTE+Parade/Wifi+TI/Wifi+Parade.
> The current builds is relatively stable.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   4 +
>  .../sc7180-trogdor-pazquel-lte-parade.dts     |  22 ++
>  .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  22 ++
>  .../qcom/sc7180-trogdor-pazquel-parade.dts    |  17 ++
>  .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  17 ++
>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 225 ++++++++++++++++++
>  6 files changed, 307 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi

Pazquel support has already landed upstream. See commit fb69f6adaf88
("arm64: dts: qcom: sc7180: Add pazquel dts files"), which is in the
for-next branch of:

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/

I think you're trying to add -rev6. You should just add it and update
the yaml as I suggested in <https://crrev.com/c/3764209>

-Doug
