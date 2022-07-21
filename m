Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77657D381
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiGUSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiGUSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:42:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A3989A87
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:42:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b25so1963200qka.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RQnuRQVAxAGI0N6/NnLGG+FggFTKyFm89xEXb36pkw=;
        b=iyniFeKPwDu5YPSQmW8iQt+xqhxFQoPdxQjdUIgapHfOqPMwIDAiMIsP8KHWWmUUqc
         VBlBRg7crLnY3rJMYSRDh2ATS1OW2p4cK1dEkdliPUAbxZa3mfkqy2FAjNp/eouhe0QV
         BvDeWRn33axasZAOviZ1Vau68l6ZKppGw+WAPxwCd6aEe3VaM3Zz3Q63Gz7OCFFaSflj
         eFsgsWbn2OLOQPDP72jbZ5ZQY168A2emerxJYUpXrhBAJuQBSaQf1ib0yGUzE3yVMJKO
         0fzeU7s5SEoi8OAk5sb9a1b+uvGGEuddx7cfMtcL6lsZetlLUhFLOCseY/xQJFvFLSU9
         RCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RQnuRQVAxAGI0N6/NnLGG+FggFTKyFm89xEXb36pkw=;
        b=haU4NO0CSTA9G3TDGcWr+yk0Kv1AsYiVscYO4oP7LkuS+SFierZuYYzdSkouFd36cv
         CqZxk7E+juaOi0F27uVm7hgI7igb9XjAuyPPdYl5CzWriH8IL0V/qlSbwVgQzyNL6c3/
         spbUt45K3D0CaOIDb2PHQ6U1N1JQMUMacTVZ/2sfh8motnfrJL7no3Tkgc+aMJLZW5lS
         uo3wnsKVM/k78x/NcsXvjkkEikixwnbRz+/y1Gzwbg7xGj4ojdjK0L5HtfDPDuBSvaJL
         eFTqKjDRbIjSY8xbJv3p3r/iUjHO/RWu2V1NFo4ukyFcuMyLUTRiOlGcuXwXQH9ewR7a
         432Q==
X-Gm-Message-State: AJIora+tR1rdNrIwgbdpbwY2hPy1rpa97KhJZxzp7jUzbe8DujjXv693
        bAk8v9/pJM3ZLvntSEqeeJJWpW1uM4XqXBkpVgEf6A==
X-Google-Smtp-Source: AGRyM1v29kSP8xawWrXzI8sSr5FM+BvUWfSZ3Fu+pP7hxXeMYCoPETKED42dCZUElsVZdMDlopzzF1/ML7pLO8dDpb0=
X-Received: by 2002:a05:620a:2408:b0:6b6:2df3:d18b with SMTP id
 d8-20020a05620a240800b006b62df3d18bmr55176qkn.203.1658428920842; Thu, 21 Jul
 2022 11:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com> <CAA8EJprQnnWjDZJy9+zUBsVQCi3jtc0Ngtzzk9MXpwOvuAS68g@mail.gmail.com>
 <CAD=FV=W0m-x9JC=5hQ3urSNmUp8sY-u8YkNd66yrKfRNAH4rcg@mail.gmail.com>
In-Reply-To: <CAD=FV=W0m-x9JC=5hQ3urSNmUp8sY-u8YkNd66yrKfRNAH4rcg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 21 Jul 2022 21:41:49 +0300
Message-ID: <CAA8EJppWeDXAMqYmw6iOs_tr2mpnxmdbSKT79SH9f8=TYaBLnQ@mail.gmail.com>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
To:     Doug Anderson <dianders@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 17:50, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jul 21, 2022 at 6:25 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > > This series breaks USB and PCIe for some SC8280XP and SA540P machines
> > > where the DP PHY regulators are shared with other PHYs whose drivers do
> > > not request a load.
> >
> > I'm trying to understand, why does this series cause the regression.
> > Previously it would be the DP controller voting on the regulators
> > load, now it has been moved to the DP/eDP PHYs.
>
> I think in the past not many device trees actually hooked up the
> regulators to the DP/eDP but did hook up the regulators to the PHYs?
> That means they didn't used to get a regulator_set_load() on them and
> now they do?
>
> It should also be noted that we're now setting the load for a bunch of
> USB PHYs that we didn't used to set a load on...

Might be the case, yes.

> > > It seems quite likely that changes like this one affects other systems
> > > too, and the effects may be hard to debug. So a more general solution
> > > than playing whack-a-mole using DT would be good to have.
> >
> > I think enabling a regulator which supports set_load() and without
> > load being set should cause a warning, at least with
> > CONFIG_REGULATOR_DEBUG. WDYT?
>
> I'm not a total fan. I'd love to see evidence to the contrary, but I'm
> a believer that the amount of extra cruft involved with all these
> regulator_set_load() calls is overkill for most cases. All the extra
> code / per-SoC tables added to drivers isn't ideal.

I'm fine with the load being specified in the DT (and that sounds like
a good idea for me too).
What I'd like to achieve is catching load-enabled regulators for which
we did not set the load (via an API call or via the DT).

-- 
With best wishes
Dmitry
