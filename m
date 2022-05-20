Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5775D52F487
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353522AbiETUjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiETUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:39:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D15419FF45
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:39:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rs12so5914178ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSGqP8k10DFS00Kv/7Pr3iy8rKQRiyeNX2aJmQ3LLsM=;
        b=FTMVepZP6e/k7QioiDdbKxNtwhWGQn0dhQoWkprd/KGGrVjGhD8TaFhu0SKJJneTu3
         WXVoqKaj9KwLoKuh0hSVIaVAyLbluk+TKxuDlLVhpkvClzrdh8/2Zsf2NWWy/OXqPpZ5
         rJaozeD4h4ZnFkjfHsMC40Q208VRfheGECHpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSGqP8k10DFS00Kv/7Pr3iy8rKQRiyeNX2aJmQ3LLsM=;
        b=ISUy+nIwDlAm0gveNuK2UKUpL5WOqT45Mq+7ffXmmEZ2SmWEKITfTL6Gbvrn8gRsNL
         oV9QEVYLzyArx3MVObzmn28Nlxy7UuV0yHAnEKwOcL+RzxwSzmOnts+WSdWtlyoat4D+
         bZWmjxYeib+41F5o6sL+uJ3b2YbanuAB4SRRF54VOdzqyU19RwPaYBX0my8I9uUJdEaK
         SKBcGqJbwNimtxVMqmh9WragycBW0oXSENJ3/yoYhkiS9AaLRlfUUCPwHmisa1IpUwAQ
         fVMYwrgaOBUVF1dnFXfMJrOEboBUs8YKee2HtL8UcEdp9w0lbU5xucB9EJzRj3937VhI
         DYDw==
X-Gm-Message-State: AOAM533Eb3Oa8YHmyCACnHdyOuxTb+avOYEdrfFksnH1MZTgMQ0tVd/x
        XNPUAkYBqEef791rvKGvp+fTkO0LKtX1Vw2csNo=
X-Google-Smtp-Source: ABdhPJwC4eHy3ov+NictO7kFusDMw+N2yDLvrDP1Mf/XvPFqiih+GrkXsEpz0ZJnMyo81RLbXkB8HQ==
X-Received: by 2002:a17:907:2da4:b0:6fe:a585:8092 with SMTP id gt36-20020a1709072da400b006fea5858092mr5271667ejc.55.1653079175991;
        Fri, 20 May 2022 13:39:35 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id hg23-20020a1709072cd700b006f3ef214decsm3510954ejc.82.2022.05.20.13.39.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:39:34 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id s28so12820110wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:39:33 -0700 (PDT)
X-Received: by 2002:a05:6000:1c03:b0:20e:5cac:1eb5 with SMTP id
 ba3-20020a0560001c0300b0020e5cac1eb5mr9870704wrb.422.1653079173296; Fri, 20
 May 2022 13:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220520161004.1141554-1-judyhsiao@chromium.org>
 <20220520161004.1141554-2-judyhsiao@chromium.org> <CAE-0n53e0bq_MbfgZYdxatP8CpGVMKkBKOnSDOV+MvbBFB6wOA@mail.gmail.com>
In-Reply-To: <CAE-0n53e0bq_MbfgZYdxatP8CpGVMKkBKOnSDOV+MvbBFB6wOA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 13:39:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VX_dr+hrNEGyC7GxcYcbMeL-uMaVLEJ5EgKnb76HVoDA@mail.gmail.com>
Message-ID: <CAD=FV=VX_dr+hrNEGyC7GxcYcbMeL-uMaVLEJ5EgKnb76HVoDA@mail.gmail.com>
Subject: Re: [v2 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf
 settings for mi2s1
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 1:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Judy Hsiao (2022-05-20 09:10:02)
> > 1. Add drive strength property for mi2s1 on sc7280 based platforms.
> > 2. Disbale the pull-up mi2s1_data0, mi2s1_sclk.
>
> s/Disbale/Disable/
>
> The commit text is a list of things done but no reason why they're done.
> I'd appreciate more freeform text with a blurb why a drive strength is
> chosen and why pulls are disabled.
>
> > Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > index 9cb1bc8ed6b5..6d8744e130b0 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > @@ -612,6 +612,20 @@ &dp_hot_plug_det {
> >         bias-disable;
> >  };
> >
> > +&mi2s1_data0 {
> > +       drive-strength = <6>;
> > +       bias-disable;
>
> Is there an external pull on this line?
>
> > +};
> > +
> > +&mi2s1_sclk {
> > +       drive-strength = <6>;
> > +       bias-disable;
>
> Is there an external pull on this line? If so please add that details as
> a comment like we do for other external pulls.

Actually, I think they are output lines, which is why they have a
drive-strength. I think for output lines we don't usually comment
about why we're disabling the pulls, only for input lines?

-Doug
