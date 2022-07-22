Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F365657D804
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiGVB3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGVB3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:29:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7B45986
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:29:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id va17so6160315ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVPqfwH/07HlNOv2TRkPmLswn/QUPlQGAJ5mgKuBLO4=;
        b=MFIlp/LiIilyP6VUEC691FGgrKDYwLe0ZTn31yUfuKe208ESUqpgsUsgzvHrgZXuho
         CpRTNoUgxieKQSsv3drg4QbWVAb4S1/EUdYV3IRzwlqztu3dG35B1B1M3F/imiT3P5Am
         7L80f1thRVsnKNVab/YwGzlYyexpswU1yBHkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVPqfwH/07HlNOv2TRkPmLswn/QUPlQGAJ5mgKuBLO4=;
        b=OQYATomB48DpGZsUjy0RBgePjcAuBDBiwQvSTb3747Tt213eC4MG2T6aJUlnL3yZEe
         GUY93BuEYJhS6OakePc4ViZYmT5zb/g/NaKbMYxnbiUBASdV1F6oSvLiF6jCBfxYqoaL
         bMBU5pSp3hXqPr+t+ocDUBc28K/gkrfjsXt/VnhsS+WagucHtw6i0DB1/Dq3VXMDCtix
         lrWAoRXfo0zpIpncHsJ7YBCR4mAsWA2qjavcBVJeEodKtmoZOmibL1nZ/Eb2yk787tWj
         PNMfJLJGLBi2Jckdn3tkV5PX3WNbfZOAEv88/HtppliGkFoJayD46mVUbqT992++6Rwq
         LHIA==
X-Gm-Message-State: AJIora/hMK9fMAJhr2GOhPEy0j1alk0qQM3a3BzalfKEAajeAtk2s39t
        +8RpHfJ6FDGug4j7GuEpOlTVCJPtzneF8ayY+hg=
X-Google-Smtp-Source: AGRyM1t3rrVLMz8DfbuTcjvkdeCvIxx84I3WiQzFYsw+V5P5C1+0sMlY5Qp/FW+tZJgvoFcU+qqlIA==
X-Received: by 2002:a17:907:94ce:b0:72f:2cfa:b7b7 with SMTP id dn14-20020a17090794ce00b0072f2cfab7b7mr1087033ejc.630.1658453340383;
        Thu, 21 Jul 2022 18:29:00 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id bn17-20020a170906c0d100b0072b2cc08c48sm1419133ejb.63.2022.07.21.18.28.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 18:28:58 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id a18-20020a05600c349200b003a30de68697so4428946wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:28:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4e86:b0:3a3:2edc:bcb4 with SMTP id
 f6-20020a05600c4e8600b003a32edcbcb4mr5596548wmq.85.1658453335156; Thu, 21 Jul
 2022 18:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com> <Ytk2dxEC2n/ffNpD@sirena.org.uk>
 <CAD=FV=UQGXqVkew544f3RDtWb3virRHWiafBAxK3ncb5wmVYwQ@mail.gmail.com> <CAD=FV=WuyKAwLwJ80uv15jBPO=W9F7FGZ4dAci+CncwF0WPfOw@mail.gmail.com>
In-Reply-To: <CAD=FV=WuyKAwLwJ80uv15jBPO=W9F7FGZ4dAci+CncwF0WPfOw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 18:28:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XVxhZwJFmOAg2v1UmfOt9_HWz0LG8M3wac+RkMPGOwYg@mail.gmail.com>
Message-ID: <CAD=FV=XVxhZwJFmOAg2v1UmfOt9_HWz0LG8M3wac+RkMPGOwYg@mail.gmail.com>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
To:     Mark Brown <broonie@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Thu, Jul 21, 2022 at 7:52 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jul 21, 2022 at 7:39 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > > You could add a way to specify constant base loads in DT on either a per
> > > regulator or per consumer basis.
> >
> > Yes, this please! ...on a per consumer basis. :-) It's been on my
> > wishlist for a while and would eliminate a massive amount of code /
> > tables in the drivers.
> >
> > We could debate syntax, but I guess you'd either do it w/ two cells
> >
> > vdda-phy-supply = <&vdda_mipi_dsi0_1p2 21800>;
> >
> > ...or with matching properties:
> >
> > vdda-phy-supply = <&vdda_mipi_dsi0_1p2>;
> > vdda-phy-supply-base-load = <21800>;
>
> Ah, sorry to respond to my own thread so quickly, but I just thought
> of a reason for the "matching properties" solution instead of the two
> cells. It would allow the SoC "dtsi" file to specify a base load while
> the board "dts" file can then specify the supply. That feels like it
> could be a nice solution.

This seemed easy, so I whipped up a quick prototype. Forewarned that I
did very little detailed testing. I didn't CC everyone on this thread,
but hopefully folks can find it if they are interested...

https://lore.kernel.org/r/20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid

-Doug
