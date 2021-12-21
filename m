Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F1C47C3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhLUQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:22:27 -0500
Received: from relay07.th.seeweb.it ([5.144.164.168]:52451 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbhLUQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:22:26 -0500
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A98263F659;
        Tue, 21 Dec 2021 17:22:22 +0100 (CET)
Date:   Tue, 21 Dec 2021 17:22:21 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 0/2] Use "ref" clocks from firmware for DSI PLL VCO
 parent
Message-ID: <20211221162221.jkbpi3oehcrpnz2s@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20210911131922.387964-1-marijn.suijten@somainline.org>
 <163165584152.763609.4056232270079096475@swboyd.mtv.corp.google.com>
 <20210918144038.6q352hzqopx7vvdu@SoMainline.org>
 <20211214194656.mayiy4xhcshjluwf@SoMainline.org>
 <69e44191-201f-8714-8a83-1a65a7026b54@linaro.org>
 <20211216004346.77383C36AE1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216004346.77383C36AE1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-15 16:43:45, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2021-12-15 12:02:37)
> > On 14/12/2021 22:46, Marijn Suijten wrote:
> > > Hi all,
> > > 
> > > On 2021-09-18 16:40:38, Marijn Suijten wrote:
> > >> On 2021-09-14 14:44:01, Stephen Boyd wrote:
> > >>> Quoting Marijn Suijten (2021-09-11 06:19:19)
> > >>>> All DSI PHY/PLL drivers were referencing their VCO parent clock by a
> > >>>> global name, most of which don't exist or have been renamed.  These
> > >>>> clock drivers seem to function fine without that except the 14nm driver
> > >>>> for sdm6xx [1].
> > >>>>
> > >>>> At the same time all DTs provide a "ref" clock as per the requirements
> > >>>> of dsi-phy-common.yaml, but the clock is never used.  This patchset puts
> > >>>> that clock to use without relying on a global clock name, so that all
> > >>>> dependencies are explicitly defined in DT (the firmware) in the end.
> > >>>
> > >>> I can take this through clk tree if it helps avoid conflicts. There are
> > >>> some other patches to sdm660.c in the clk tree already.
> > >>
> > >> Might be useful to maintain proper ordering of these dependent patches
> > >> but it's up to Dmitry and Rob to decide, whom I'm sending this mail
> > >> directly to so that they can chime in.
> > > 
> > > Dependent patch [3] landed in 5.15 and [2] made it into 5.16 rc's - is
> > > it time to pick this series up and if so through what tree?
> > 
> > I'd also second the idea of merging these two patches into 5.17.
> > Most probably it'd be easier to merge both of them through the clk tree. 
> > Or we can take the first patch into drm-msm (but then we'd have a 
> > dependency between msm-next and clk-qcom-next).
> > 
> > Bjorn, Stephen?
> > 
> 
> Sounds fine to take through clk tree.

Thanks Stephen, would be great to take this in through the clk tree for
5.17.  I don't have anything to add that could possibly warrant a v3,
only msm8996 remains with the "xo" clock but that needs more work in
other drivers and is best dealt with separately.  Please take v2,
assuming there are enough acks/reviews :)

- Marijn
