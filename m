Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A087952F61D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354052AbiETXV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbiETXV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:21:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D5197F40
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:21:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so18142068ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f989wjQBWky1VnvYFagt1zjTfmuK0hLH870FJFKov5Q=;
        b=V+kj5frWT026Sqek0GhQVobd/rXWEguXk45ZmlnyWIvQCGnsAhnGB4YNjWneQ9yzIo
         nXGaoT/lYx6hAxi0VlTEH2ST42EmfMSwH/eh2HQhA2aSYo3PaApIA++ilEBadxkzs6As
         ILXzSTtH1x1yby8OP+C8kScsWWyWM+hnoBoVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f989wjQBWky1VnvYFagt1zjTfmuK0hLH870FJFKov5Q=;
        b=lsjKTp4Sg6EcMArxyOkJoQPaRbnJt5kySjFcThsPZzRADeBoRa0tgVy0EKcEiNKmmr
         Sd7qP7XTuUn21XUs44ZwLIh4+sByovB28zzARU00nwOGPEm2arDuWt0WToT/hOXngp8m
         CTVVayA8Wt210wvsNSThPsOdGemzvDf1xVLHqVqeKsEVMVhExgZ4/448znkP9v5ZPcGA
         oigO1F3erOR7J4zLnlMq/tQLhkfnsyaZUl0EUDNGyO2HNrteXLefJouLogFmoluAkVdB
         Sma43wJjqGrzjJFGkC3EL6RxQvhTD05fGMXFNyqrtY7LdCM4I5lqnnFh3q590hoCPHnv
         6SCw==
X-Gm-Message-State: AOAM530CzzWC2iTagvZuwVaZHNHTqw73llcBnUL+iTyxAJSgp60ngxY3
        MzTY3nlZr4llDBjpimTH1C9qp57VitYQvjcgWY8=
X-Google-Smtp-Source: ABdhPJxHkW114ut03Igb/+quQj8p3xjfuj2EttUiYdkThqmRUhqjCJYXepxGuWaHxly+kyUvVclHRA==
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id nb7-20020a1709071c8700b006f029eacc01mr10750419ejc.671.1653088914114;
        Fri, 20 May 2022 16:21:54 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id j18-20020a1709066dd200b006feb875503fsm182099ejt.78.2022.05.20.16.21.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 16:21:52 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id h14so13317279wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:21:52 -0700 (PDT)
X-Received: by 2002:a5d:5085:0:b0:20d:5f6:63fa with SMTP id
 a5-20020a5d5085000000b0020d05f663famr9821782wrt.679.1653088911844; Fri, 20
 May 2022 16:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220520231355.1559104-1-swboyd@chromium.org>
In-Reply-To: <20220520231355.1559104-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 16:21:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFnq42qBgsASPD9_71zFehO3kW2jPWPaD8L5AzixCbjA@mail.gmail.com>
Message-ID: <CAD=FV=WFnq42qBgsASPD9_71zFehO3kW2jPWPaD8L5AzixCbjA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Remove duplicate sc7180-trogdor include
 on lazor
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 4:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The sc7180-trogdor-lazor-*.dtsi files all include sc7180-trogdor.dtsi
> and sc7180-trogdor-lazor.dtsi, so including it here in the
> sc7180-trogdor-lazor.dtsi file means we have a duplicate include after
> commit 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in
> sc7180-trogdor.dtsi"). We include the sc7180-trogdor.dtsi file in a
> board like sc7180-trogdor-lazor-r1.dts so that we can include the
> display bridge snippet (e.g. sc7180-trogdor-ti-sn65dsi86.dtsi) instead
> of making ever increasing variants like
> sc7180-trogdor-lazor-ti-sn65dsi86.dtsi.
>
> Fix this by dropping the include and making a note that the
> sc7180-trogdor-lazor.dtsi file must be included after
> sc7180-trogdor.dtsi
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Fixes: 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
