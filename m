Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D820B5B090F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIGPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIGPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:46:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9DB86FFB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:46:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so14948939plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=o4ouWFzrxI306Mkvi1g00iFUOC1Xlx6br+pck/+37ak=;
        b=bQjsydOBwSpAY7GCFbmwkmz20KF84ENWHERlpNxAfBYZ7FGRTHIX45ObOZNpcvPfPq
         WtebGvv117RbX8FoXmqUjbanzwFJA3BbGbQeW8knzSeBolzxdgrijwlFahBY6yE/cdeB
         SPSXmE39pQbfdfoS4ISYszBIYoSxFpx2tgt4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=o4ouWFzrxI306Mkvi1g00iFUOC1Xlx6br+pck/+37ak=;
        b=VeXw5NoNAY118KbF4mJ+s18sJDjOBfaAjwnhsh8uc8vNnt0/2+in+yoGGsZECKs7x3
         GKz+EIoUKnUI0AWX/VEAqqYUUdwm69bcz4wWNvOgQFlutG+lmErr5Fbp2l8yfKfsyN9H
         7OzUGKhh/S0IKYeY3DOduRML02Yez/zHvuEJDOSsVMNMZO+OT+nG4/vhlHAYhcTkLsog
         wCnlxQS7oGTF5a3vLPsCJ/ABDyemgf5VahQaP783sRb4U5go6IgIbPNfPAXi5yQO8gBa
         DkhB6Z2PszrNjmK5q3HpfXzA42AkrKS6dyrw1S/T4xzF4kICAQzNdAuxUDyVuYk94Jiz
         iMdw==
X-Gm-Message-State: ACgBeo1z6ZbmSP++6ir1180ILLAVVyAPwEFguHjhCyziRA0Z17VkZEGI
        zvmS7upyL1M+Ec4dBa99g1UUP/HI1szcMw==
X-Google-Smtp-Source: AA6agR4AMLfYmQ/6XnBmEodJgHE0lJ47tpNnT7FEi3eCWWn3qhk3bqkquCUtVFw17urR6r8Qm/afPg==
X-Received: by 2002:a17:903:204b:b0:176:a6c5:4277 with SMTP id q11-20020a170903204b00b00176a6c54277mr4415234pla.24.1662565571171;
        Wed, 07 Sep 2022 08:46:11 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:7731:4d19:a7d1:20d])
        by smtp.gmail.com with UTF8SMTPSA id be7-20020a656e47000000b0041a716cec9esm10595529pgb.62.2022.09.07.08.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:46:09 -0700 (PDT)
Date:   Wed, 7 Sep 2022 08:46:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Fix Dmic no sound on
 villager-r1
Message-ID: <Yxi8vnmtowA83WLm@google.com>
References: <20220826065621.2255795-1-judyhsiao@chromium.org>
 <CAD=FV=VrgrvJb_sJ8AO6pN8dRNXzzOJ9WvngeJrtVYw_wD1Akg@mail.gmail.com>
 <Yw07xSlVpQcXDqe7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yw07xSlVpQcXDqe7@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 03:20:53PM -0700, Matthias Kaehlcke wrote:
> On Fri, Aug 26, 2022 at 10:14:58AM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Aug 25, 2022 at 11:56 PM Judy Hsiao <judyhsiao@chromium.org> wrote:
> > >
> > > Fix the DMIC no sound issue of villager-r1 by using "PP1800_L2C" as the
> > > DMIC power source to match the hardware schematic.
> > >
> > > This patch:
> > >    1. set vdd-micb-supply to PP1800_L2C as the MIC Bias voltage regulator.
> > >    2. In audio-routing, set VA DMIC01~VA DMIC03 to use the vdd-micb-supply
> > >       setting.
> > >
> > > Co-developed-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> > > ---
> > > Changes since V3:
> > >   -- Update the commit message and fix extra blank line.
> > > Changes since V2:
> > >   -- Update the commit message.
> > > Changes since V1:
> > >   -- Update the commit message.
> > >
> > > This patch depends on:
> > > arm64: dts: qcom: sc7280: Add herobrine-villager-r1. [1]
> > >
> > > [1] https://patchwork.kernel.org/patch/12929106
> > 
> > After applying your [1] then your patch applies without merge
> > conflicts. However, it still doesn't compile. You also depend on
> > whatever patch adds the nodes "lpass_va_macro" and "sound" since
> > you're referencing them in your patch. I haven't been keeping track of
> > the latest status of all the audio patches, so I myself can't point to
> > exactly what patches you depend on and whether those patches are ready
> > to land.
> > 
> > In any case, the contents of this patch seem OK assuming the dependent
> > patches cause something that looks like the current (downstream)
> > chromeos-5.15 tree.
> > 
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> To my best knowledge the dependencies of the audio mess are (roughly in
> order):
> 
> Add support for audio clock gating resets for SC7280 (v8)
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=671887
>   ready to land? (patch 2 has a minor comment about SoB tag)

The comment has been addressed in v9:

https://patchwork.kernel.org/project/linux-arm-msm/list/?series=673055

So it seems all the audio bits should be ready to land.

Satya: please make sure to include change logs in all future patches to
help reviewers understand what changed in each version.

> Add DT support for audio clock gating resets for SC7280 (v4)
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=666480
>   ready to land after dependencies land
> 
> Add soundcard support for sc7280 based platforms (v14)
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=657417
>   ready to land after dependencies land
> 
> Add dtsi for sc7280 herobrine boards that using rt5682 codec (v3)
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=644812
>   ready to land after dependencies land
> 
> Add new board revision and LTE SKUs for sc7280-villager family (v8)
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=663014
>   ready to land after dependencies land
> 
> arm64: dts: qcom: sc7280: Fix Dmic no sound on villager-r1 (v4)
> https://patchwork.kernel.org/project/linux-arm-msm/patch/20220826065621.2255795-1-judyhsiao@chromium.org/
>   ready to land after dependencies land
> 
> So it looks like things are generally ready to land, unless [1] needs a
> re-spin to fix the SoB tag.
> 
> m.
> 
> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1661754153-14813-3-git-send-email-quic_c_skakit@quicinc.com/
