Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2554A206
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiFMWT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiFMWTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:19:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FB2DAB7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:19:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g7so9117479eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiyBV98F9xICzYyJTkP6FjyBl5T6Mi+mUKFDOCM92KU=;
        b=klyXrSi658IJdvf/FimbWgaAprMRP4Gl89sPeMRWaYsKtTIDlGXNU84jXtksjGeKuZ
         YN9DZqiH7mqKnbYfiYAjbb9DY3FfRyVIIjHjdvbZi1N9Vlffy8nv8b1GWSGUVT4q76wg
         yITIyKDsl8jEx4zN2uftjpdy0R/hCB2jOH9eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiyBV98F9xICzYyJTkP6FjyBl5T6Mi+mUKFDOCM92KU=;
        b=7sztJD+SVfeSN4CTwF+PfNAMCXtl71pY70VrLpqzl1RykTxYIRhKHVYCNX/IPNkOXJ
         +1PuEmhrzQ3k41llBA3fEGeD1Gq5f/bqAMGNA+lfSgcsbD+lb+i5h1KHu8HKOkFaRCQ+
         5h1ZIKBLMfLNsteyd5iHcoWCn31B58ZIvbuVBuTsjdZNZ68KSvZuUoThEMtOuEBVSBaU
         9BV0P3iw4iJtmVGsMkHDtl2FveA6cr74ChOJj64HGxnE2GgAi3HhnrzY3UzGl44LQ30K
         Smgl9PFSM07te60ZFOIRjsZsWdTYR/K7+V+M6RX4brgFudaMM+4o+JTqDuLXwYBzemFf
         BZfA==
X-Gm-Message-State: AJIora8VE9E5W9ARsTFZLJajcbQB96cxeynn9WaShFcCvJ/XbWaE1dQJ
        WBIWBolq2rtQ5ZmkWu0FwmR5Z2DXnn1Q6Q==
X-Google-Smtp-Source: ABdhPJwXBYm/fD+jJ3rzUvp9kuyeFLdhzlIYsLf6/tLIQyh12xs1ycrQ3SDqaWguuwSKQ5EbPPapYg==
X-Received: by 2002:a05:6402:f05:b0:42d:d709:b497 with SMTP id i5-20020a0564020f0500b0042dd709b497mr2259251eda.231.1655158792048;
        Mon, 13 Jun 2022 15:19:52 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id m26-20020a056402051a00b0042dd2f2bec7sm5760642edv.56.2022.06.13.15.19.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 15:19:51 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso3827296wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:19:51 -0700 (PDT)
X-Received: by 2002:a05:600c:202:b0:39c:40de:ec19 with SMTP id
 2-20020a05600c020200b0039c40deec19mr852639wmi.29.1655158790748; Mon, 13 Jun
 2022 15:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220602190621.1646679-1-swboyd@chromium.org> <CAD=FV=X6702aSaEnpXUhF40b0kZuz1QvOBLNg-xcNDYbVCbsDw@mail.gmail.com>
In-Reply-To: <CAD=FV=X6702aSaEnpXUhF40b0kZuz1QvOBLNg-xcNDYbVCbsDw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jun 2022 15:19:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UH35GLqzhCuJzqBX12BNw7m4hkF0qdCeAGxOwdnMVqmA@mail.gmail.com>
Message-ID: <CAD=FV=UH35GLqzhCuJzqBX12BNw7m4hkF0qdCeAGxOwdnMVqmA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: Remove duplicate sc7180-trogdor
 include on lazor/homestar
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 2, 2022 at 1:08 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jun 2, 2022 at 12:06 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > The sc7180-trogdor-{lazor,homestar}-*.dtsi files all include
> > sc7180-trogdor.dtsi and sc7180-trogdor-lazor.dtsi or
> > sc7180-trogdor-homestar.dtsi, so including it here in the
> > sc7180-trogdor-{lazor,homestar}.dtsi file means we have a duplicate
> > include after commit 19794489fa24 ("arm64: dts: qcom: Only include
> > sc7180.dtsi in sc7180-trogdor.dtsi"). We include the sc7180-trogdor.dtsi
> > file in a board like sc7180-trogdor-lazor-r1.dts so that we can include
> > the display bridge snippet (e.g. sc7180-trogdor-ti-sn65dsi86.dtsi)
> > instead of making ever increasing variants like
> > sc7180-trogdor-lazor-ti-sn65dsi86.dtsi.
> >
> > Unfortunately, having the double include like this means the display
> > bridge's i2c bus is left disabled instead of enabled by the bridge
> > snippet. Any boards that use the i2c bus for the display bridge will
> > have the bus disabled when we include sc7180-trogdor.dtsi the second
> > time, which picks up the i2c status="disabled" line from sc7180.dtsi.
> > This leads to the display not turning on and black screens at boot on
> > lazor and homestar devices.
> >
> > Fix this by dropping the include and making a note that the
> > sc7180-trogdor-{lazor,homestar}.dtsi file must be included after
> > sc7180-trogdor.dtsi
> >
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Fixes: 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > It would be great to get this into -rc1 if possible to fix broken
> > display.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I tested and this fixes the "no display" problem on Linus's tree on
> both homestar and lazor.
>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Given that this fixes problems in mainline, it would be keen to see it
land sooner rather than later. Is it blocked on anything?

Thanks!

-Doug
