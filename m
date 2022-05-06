Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523AA51E134
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444539AbiEFVhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444538AbiEFVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:37:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3596FA0B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:33:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ks9so10284569ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zo9daRgMENoWgb46CKOdULHnCxF/Ml14SgBAmDBgwx8=;
        b=JPR3xRXkaQhIjAMcIOg8/hg9FlzTH96vSm+GEO6s5SjXmTBOftGQZsm75mgh8QCgZM
         oORNqtTSaS4QLD7M/8toYBmevqdTOyfGSk0hJMARhtBB5J0LmTrIb+yzXmsStAqXzjmC
         hRuBl+OFSBSaOTRwN+kcFK1bIFvNc+JnAVPsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zo9daRgMENoWgb46CKOdULHnCxF/Ml14SgBAmDBgwx8=;
        b=poz7FVlw6z1ciktBzUfvPH+gs++y1cgdhXnQ5wktmQb4RAxOAmiZP7Q0wV7aaoOqBi
         zItUUEDxjfJqIEIbdYv2aBzMfnaXKVL8wi+sKTpI84WjOeBflb9Z5cVfU12Wg9kuF+7z
         ERXOdjoYOv6mH9Hya2o9+l8d+YSm3lYfrqUm6u6vkgsbah2BnbhQgEJ92+kola6a4rn4
         u7ilf/lMBaXzB+VYk0heo7xCaTOb14w6D+P0ACREabb7wqhVtgqbFMTLpRc+zOTIoj96
         uohED0nyzi4QVq/67heDRibHAgIKQ8nzPz7W9XAdaqA/shECyf+neEbmdzmdJt68K01M
         /EAQ==
X-Gm-Message-State: AOAM533wf26iEZjgLTHs7qbBqSnziW4doE4Q9mCFOleTlRG+cZXuQIkT
        sxZPM5qoH8dNK/N0FpnRo0Pz6/EVHRQ9abAC40s=
X-Google-Smtp-Source: ABdhPJzJoSV2kLduxVdkSd6X/agld5opykiDkMNdd3jHS4q3fiGs6C1k/ryRJB/aFSnZKKrI48o9VA==
X-Received: by 2002:a17:907:6d25:b0:6f4:d753:f250 with SMTP id sa37-20020a1709076d2500b006f4d753f250mr4801386ejc.580.1651872810453;
        Fri, 06 May 2022 14:33:30 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id f17-20020a50fc91000000b0042617ba63d3sm2717304edq.93.2022.05.06.14.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 14:33:29 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id d5so11543569wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 14:33:29 -0700 (PDT)
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id
 t8-20020a5d42c8000000b0020ad91f87b5mr4251819wrr.301.1651872808982; Fri, 06
 May 2022 14:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org> <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org> <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
 <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org> <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
 <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
 <CAD=FV=XQqQSQDNh-zXqEQkwsrax5Qb3OtfKZoQLkncJj_4mcQw@mail.gmail.com> <daf66d41-42ac-50dc-3f8d-c261da8e452d@linaro.org>
In-Reply-To: <daf66d41-42ac-50dc-3f8d-c261da8e452d@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 May 2022 14:33:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WhA=n_=Ys6NfedPtNPddL81HnG6Qws_R+vq9w8Nrsn5A@mail.gmail.com>
Message-ID: <CAD=FV=WhA=n_=Ys6NfedPtNPddL81HnG6Qws_R+vq9w8Nrsn5A@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 4, 2022 at 12:04 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> >>>> The most specific compatible identifies or, like recently Rob confirmed
> >>>> in case of Renesas, the list of compatibles:
> >>>> https://lore.kernel.org/linux-devicetree/Yk2%2F0Jf151gLuCGz@robh.at.kernel.org/
> >>>
> >>> I'm confused. If the device tree contains the compatibles:
> >>>
> >>> "google,lazor-rev4", "google,lazor-rev3", "google,lazor", "qualcomm,sc7180"
> >>>
> >>> You want to know what board you're on and you look at the compatible,
> >>> right? You'll decide that you're on a "google,lazor-rev4" which is the
> >>> most specific compatible. ...but you could have booted a
> >>> "google,lazor-rev3". How do you know?
> >>
> >> Applying the wrong DTB on the wrong device will always give you the
> >> wrong answer. You can try too boot google,lazor-rev3 on x86 PC and it
> >> does not make it a google,lazor-rev3...
> >
> > I don't understand what you're saying here. If a device tree has the compatible:
> >
> > "google,lazor-rev4", "google,lazor-rev3", "google,lazor", "qualcomm,sc7180"
> >
> > You wouldn't expect to boot it on an x86 PC, but you would expect to
> > boot it on either a "google,lazor-rev4" _or_ a "google,lazor-rev3".
>
> Yes, but booting it does not mean that the hardware is rev3 or rev4.
> Booting it means only that we are running DTB on a compatible hardware.
> The DTB determines what is accessible to user-space, not what *really*
> the hardware is. The user-space (since we are going now to original
> question) reads it and can understand that it is running on hardware
> compatible with rev3 - either rev3 or rev4 - and act accordingly.
>
> > Correct? Now, after we've booted software wants to look at the
> > compatible of the device tree that was booted. The most specific entry
> > in that device tree is "google,lazor-rev4". ...but we could have
> > booted it on a "google,lazor-rev3". How can you know?
>
> No, providing and loading a rev4 DTB on a rev3 board is not correct and
> does not make any sense. rev3 boards are not compatible with rev4, it's
> the other way. Not every fruit is an apple, but every apple is a fruit.
> This is why I used that example - if you load rev4 DTB on rev3 hardware
> then you have totally wrong booting process.

I think this is the crux of the difference in opinion and there's no
reasonable way I'm aware of to do what you're asking. If -rev3 and
-rev4 are identical from a software point of view it would be silly
not to share a device tree for the two of them. The number of device
trees we'd have to land in the kernel tree would be multiplied by
several times and we'd have many that are identical except for this
compatible string. I see no benefit here and lots of downside.


-Doug
