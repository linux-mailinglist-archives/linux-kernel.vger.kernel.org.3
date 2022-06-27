Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E055D1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiF0PjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiF0PjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:39:12 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007B11A29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:39:11 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id p31so15257665qvp.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGHpc9v4ZCMNdJ9NQhZJ5H1k92hYzQTSlPYYZud8X1I=;
        b=xQWAPBTTIhVQhksDJ8SQhq5YkJ3JB9vPfTqgFFG4CUdhMwxCpNu4R1/LfEULM/n21+
         zkKghcQb6PoQa4YcXy79yo1wMwSc0r2BidbBAbJ1NwK9fG2czyhRIkU9+Adq2+SSBHyd
         uX2Vg/8xEDsJ5t9PVo6VJuEAVcgLkMxoI3uY1OiVlPjJCHquDTKk+iRxYrSWqv1nuQBP
         9S0qCMpuT224v6otYJUuTPaBDSZtAZy/4ZT/OdbyiusYywVLClseH5V8HKF2Imzm0tsg
         0DQdBJcoq5mgBAbioB2WOcG8YtYYKQLElCxgZ0ed2N+UFCRXmmYZaBRhv3ZSZQa4WPmo
         6EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGHpc9v4ZCMNdJ9NQhZJ5H1k92hYzQTSlPYYZud8X1I=;
        b=m+e6Yn2hhlbYLIjGfl3cvqC8YjA2mekRL8HzQL2srFlon4LPSbltbHYh/b2V46MC6c
         njS8jpL2N6GF7iBWTGBbH9z2plQDad/z8OeOWrVdCt/fXgH5jOhi4Xm2KvRuRtH8RPN8
         IpsvMVTQEtVwe6ydx85HYaLBtzWXklxR69WiW/ghywdw0hSDdPcA/Z8BTfcrd6kuR5h8
         w/Wqst4IHVcoiAhICGHYzKPv1Q2imsvepC48L1PVN3DZiJvn5OS+cgxfO5bPdbheVpDX
         FG7vjG6eqYEgK09aKN+Z9yP0bHoGbH96zAlV7+QOcBN0UmBnSeM1VYbLggA9CbEVQcv5
         B5fw==
X-Gm-Message-State: AJIora9MS+F9bd2w8/IqdHafQqmEOvSVd3chzIyJsFU5Mp0KrbGVg74m
        iKyypIKeBnh2Wls03Q8M2/KNX8c+adtdVGfWSoyzkQ==
X-Google-Smtp-Source: AGRyM1uU6Dx/UDeMD3519ioenI9SxoOtfqH7zR2iki7/D0bO2iset7jb3RERavSGfQgMto8/UpwFn/xIj0aB0434K00=
X-Received: by 2002:ac8:5c96:0:b0:31a:c19a:7da1 with SMTP id
 r22-20020ac85c96000000b0031ac19a7da1mr3219570qta.62.1656344350582; Mon, 27
 Jun 2022 08:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <66ff4642-f268-f5b0-7e28-b196368c508a@quicinc.com> <5cf094cf-343a-82d7-91c4-1284683f9748@quicinc.com>
 <CAA8EJprqq=vxXT2DmEWii_Ajx2UbkHRexPTT58xFcWkBa_D5hA@mail.gmail.com>
 <26263c16-8cbc-ccca-6081-7eba14635d73@quicinc.com> <CAA8EJpqEoXXA=eKGHRGuQ3VOHnmEShY8u_SMZ6WFWORCFhFcrw@mail.gmail.com>
 <8445f93a-00f0-64af-5650-07f2bc487742@quicinc.com> <CAA8EJpqB2KPyvFehK9WRGgiVnqvD24cz5BcHsw8a5PQ2Vs1oKA@mail.gmail.com>
 <CAA8EJppZdyutyNBG+OFinickQoDxg0i4GwbaNQubo_LSRWNh4w@mail.gmail.com>
 <1a2e7574-8f78-d48e-a189-020ffcd39f60@quicinc.com> <CAE-0n52L1fvvpEH56+HD_UXuV61tMvhh8Qjp781bW9tTKRQymw@mail.gmail.com>
 <9b197183-5306-bf19-0195-2dc1bb72c33b@quicinc.com>
In-Reply-To: <9b197183-5306-bf19-0195-2dc1bb72c33b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Jun 2022 18:38:58 +0300
Message-ID: <CAA8EJppnELtjmOp+Yp7rbrrjf9UixBb82Uvfyg9ofcq+EqaOnw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 27 Jun 2022 at 18:33, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 6/24/2022 6:15 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2022-06-24 18:02:50)
> >> On 6/24/2022 5:46 PM, Dmitry Baryshkov wrote:
> >>> On Sat, 25 Jun 2022 at 03:28, Dmitry Baryshkov
> >>> <dmitry.baryshkov@linaro.org> wrote:
> >>>> On Sat, 25 Jun 2022 at 03:23, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >>>>> On 6/24/2022 5:21 PM, Dmitry Baryshkov wrote:
> >>>>>> On Sat, 25 Jun 2022 at 03:19, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >>>>>>> How can I have eDP call dpu_encoder_init() before DP calls with
> >>>>>>> _dpu_kms_initialize_displayport()?
> >>>>>> Why do you want to do it? They are two different encoders.
> >>>>> eDP is primary display which in normal case should be bring up first if
> >>>>> DP is also presented.
> >>>> I do not like the concept of primary display. It is the user, who must
> >>>> decide which display is primary to him. I have seen people using just
> >>>> external monitors and ignoring built-in eDP completely.from
> >>>> Also, why does the bring up order matters here? What do you gain by
> >>>> bringing up eDP before the DP?
> >>> I should probably rephrase my question to be more clear. How does
> >>> changing the order of DP vs eDP bringup help you 'to fix screen
> >>> corruption'.
> >> it did fix the primary display correction issue if edp go first and i do
> >> not know the root cause yet.
> >>
> >> We are still investigating it.
> >>
> >> However I do think currently msm_dp_config sc7280_dp_cfg has issues need
> >> be addressed.
> >>
> > What issues exist with sc7280_dp_cfg? It looks correct to me.
>
>
> If we are going to bring up a new chipset with edp as primary only, i am
> not sure the below configuration will work?
>
> > static const struct msm_dp_config sc7280_dp_cfg = {
> >          .descs = (const struct msm_dp_desc[]) {
> >                  [MSM_DP_CONTROLLER_1] = { .io_start = 0x0aea0000, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
> >          },
> >          .num_descs = 1,
> > };

As I wrote in one of the comments, there is an issue with num_descs
being not obvious (in your example it should be 2, not 1). I thought
about dropping it and looping until the MSM_DP_CONTROLLER_COUNT, but
this would result in other kinds of hard-to-catch issues. Let me muse
about it.

-- 
With best wishes
Dmitry
