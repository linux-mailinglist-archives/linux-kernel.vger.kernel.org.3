Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5805337EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiEYIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiEYIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:01:47 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA627CB20
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:01:45 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p123so6633795qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5llnQ0HkqBxFbZt5az1NecvFrmyi/1RVbD73twHaCqM=;
        b=zZwgi2desRjXdWtXNwoEvX6wsB2Qhsj85lZVg/nLI8ghYM7OjRBlJ9Pi4V/DxPJ1Bb
         WZX+2l4VDbos162+9LTh3lTgITVULB14ootMx8ZWnHPxrGJl2hSY1UiFq7OVYQweoBuf
         qLOsguArxFrn6puv/z2Fc8rEjxR89d2kRFl2uwfq2nLOr2Q9fmjIB22aheH10RuXhgoY
         6WODq69uvHhKl7jHwDQ+87jmzfLIflNyEp6/gCudMQhdFsI2Gj2Ztk6y9qG+CLJgxYb0
         QOn/cB9uBnLShJowJr7E7LNRBNZ1wicPBHkaF0wf+jwMbmIYLpWF6Kaw2b0mBrZXddfy
         pgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5llnQ0HkqBxFbZt5az1NecvFrmyi/1RVbD73twHaCqM=;
        b=gE7I7rziCD0w+v7xouKntF8W1TdOgUDDxx5NPvl1u4QaG946/P5F+rWenooH6ifRqX
         Xsh1b45oHEUV2TQHlMGp5yskOd11jmT5qHYbRSCwICp32N67rSE5zSXVU+hxV1Ij2TYu
         C+4fa8i12muI0NkaEkm8WKR15hN9jnMUKjnLBvYEluaPLIUTFepjghtoOPZJAyHnBb9R
         lGdmpr3D2o0aGVEaCSkbL+GuMjOia104Jo0kqkp7Btqs+VwBgDDYwhanSBzkgNHTCs2c
         Yxn4lRMX0KlPWXGlx2pd0txbx6TiBfvniVJMRhRQLhsQ6KpxqVK/mRzEKMr+5XaNy5ce
         JGBQ==
X-Gm-Message-State: AOAM533+sBzxGwP/TUs5vUrUfOPLsjVkU9bKff0luljRu80Ie2ko2MEe
        nFZDZvj/dGJ2Ly7iUfXPNnpVb6o4V6IzXF55jkJavw==
X-Google-Smtp-Source: ABdhPJyLzdihFq5P1mvTRP2MzB7lIfIvefw77o57mf6LyputxZqyr2pOmunz6FAsXzFu9/HvX3f2WImcrWg1neFlU9Y=
X-Received: by 2002:a05:620a:414e:b0:6a5:8dec:57bb with SMTP id
 k14-20020a05620a414e00b006a58dec57bbmr1765575qko.30.1653465704537; Wed, 25
 May 2022 01:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220523213837.1016542-1-marijn.suijten@somainline.org>
 <CAA8EJprEjOWRh98V3sprjXZJZMeR25Bz1U3a_uX_KhRbU48srQ@mail.gmail.com> <20220524220312.jrdkolu7eoxtcyju@SoMainline.org>
In-Reply-To: <20220524220312.jrdkolu7eoxtcyju@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 May 2022 11:01:33 +0300
Message-ID: <CAA8EJpofvyxH22qWs5HLqG-EkKkecbFySXd36YDmK8cdeNaGUg@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm/msm/dsi_phy: Replace parent names with clk_hw pointers
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 at 01:03, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-05-24 02:43:01, Dmitry Baryshkov wrote:
> > Hi,
> >
> > On Tue, 24 May 2022 at 00:38, Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > As stated in [1] I promised to tackle and send this series.
> > >
> > > parent_hw pointers are easier to manage and cheaper to use than
> > > repeatedly formatting the parent name and subsequently leaving the clk
> > > framework to perform lookups based on that name.
> > >
> > > This series starts out by adding extra constructors for divider, mux and
> > > fixed-factor clocks that have parent_hw(s) pointer argument(s) instead
> > > of some DT index or name.  Followed by individual patches performing the
> > > conversion, one DSI PHY at a time.
> > >
> > > dsi_phy_28nm_8960 includes an extra fixup to replace "eternal"
> > > devm_kzalloc allocations (for the lifetime of the device) with
> > > stack-local char arrays, like all the other DSI PHY drivers.
> > >
> > > I couldn't help but notice that clock names are wildly varying:
> > >
> > > - Some use underscores in the _clk suffix where others have nothing;
> > > - Some have an _ after the %d, others have not;
> > > - Some use a _pll suffix after dsi%d or even _phy_pll suffix.
> > >
> > > Are there any thoughts or feelings towards unifying these?
> > > Theoretically no clock names are used anywhere in the kernel, and
> > > everything is based on a phandle + index in DT (I have yet to validate
> > > this).  Obviously no .name/.fw_name will be updated to not break DT.
> >
> > I'd say, leave them as is. Even if they are historical, we don't have
> > a strong pressure to change them.
>
> Leave them as it is, or - as suggested below - clean them up?

Let's leave the names as is for now, convert all clock drivers to
fetch clocks from DT and decide how to continue with clock names
afterwards.

> > Significant number of older platforms still use names to identify the
> > clock. And moreover apq8096/msm8960 uses dsi1/dsi2 instead of
> > dsi0/dsi1.
> >
> > Probably we should call the next cycle "The Cycle of clocks cleaning".
> > I can volunteer to take care of 8960/8064/8016/8996, as at least I can
> > test them. But if you wish, you (or anybody else of course) can take
> > any of these platforms too, just ping me, so that I won't spend time
> > duplicating somebody's efforts.
>
> We can at least clean up the names of clocks that are not "exported" by
> the drivers.  However, we should also convert all other clk drivers to
> utilize DT to define clk dependencies instead of depending on global
> names, and already got quite some platforms tackled.  At that point we
> can just convert all names (give or take the often discussed "backwards
> compatbility" between the kernel and some ancient DT someone may still
> be running on their device).
>
> I don't own any device for the SoCs you mentioned, all good from my
> side if you take them.  We should probably note down all clock drivers
> that still need conversion and split them across devs with physical
> access, then I can check what I still have lying around here as well.

Can you please make a google spreadsheet? Then anybody can take a look
and volunteer (or check that the platform is being taken care of).
I have 8064 (and thus I can cover 8960 too), 8016, 8096 on my desk and
qcs404 and 8998 in the remote lab (but I can leave them to somebody
else).

> > > Which, by the way, is there a particular reason for:
> > >
> > >   #define DSI_BYTE_PLL_CLK              0
> > >   #define DSI_PIXEL_PLL_CLK             1
> > >
> > > To not be in the dt-bindings and used in the DT?
> >
> > Before my restructure of the DSI PHY subsys, each driver defined them
> > separately. And the idea of moving them to a dt-bindings header didn't
> > come to my mind. Feel free to do so, it looks like a good idea.
> > Just as a note, DP PHY also uses 0 for the link clock and 1 for the
> > pixel clock. What do you think about having a single header for these
> > names?
>
> No worries, it's already much better to have them defined once :), now
> we can just go one step further and move it to dt-bindings.  Great to
> clean up the "magic constant indices" for the DP PHY as well
> (phy-qcom-qmp.c is the only one defining these clocks, right?)

No, phy-qcom-edp.c also uses these magic numbers.

> and I
> think we're fine having them in one header, pending someone suggesting a
> name as I have no idea what to call it nor where to put it.  Under
> dt-bindings/clock most likely, but what common name would we choose?
> Something including qcom and mdss?

dt-bindings/phy/phy-qcom-dsi.h and dt-bindings/phy/phy-qcom-dp.h?


-- 
With best wishes
Dmitry
