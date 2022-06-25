Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4755A580
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiFYA2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiFYA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:28:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD360E1A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:28:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u124so2992325qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vO2qD2XXjUZOfZrbQAZ+jo3zJKcu1SEluqgJYAyM3W4=;
        b=bT0TGKZ31rhy+fJIUdvuACHnYjOFWuM9ZHq58WZdqWmx85U5H5yAyAl0YFpE/3gdcD
         MDxF8e5qO+8KKHWgOXyD63B6R3g03zCgEVoF8pyuY64xeZTG6PLa7M+O4NZC9W9J3ee5
         h1k8uC/qtfHY9zZsLhEQbLCLrIm4izlMlt7SKrcLLLTh4PnuoOcwyuOrgmwVFvEpwfL8
         qRAKQdyMPJzcB7j+U1Ql55JD1OuADzVobdko3h2gC4j1TZLeZRQJiZmOxwWsfnnGYeEw
         KgFRlrRgWY+DQdP6W1jrZzsEfejwljvWyfXstn1/SnaGN7/BmcCNXG6ZDhUxOzgEgiVp
         L+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vO2qD2XXjUZOfZrbQAZ+jo3zJKcu1SEluqgJYAyM3W4=;
        b=JIU/VceUBhmjo1h68BO+F9v2n/HpgtqNYJkFHSodI9vixW501qTXvCfkXJhGsmbfOB
         iHXlKzGE/omqQ8k4pQErIe/Z54Xonrt5q5h69C+gp/zbrL0sh51ygNoseGATi+XmIyJX
         lBEQHyLGTk+lRZc0LKSCTshigUW/JsxPQoWb0V/MFHzyti+xXco5ebE+rU1mEEccSKc+
         rQaueHcgx+Bj1urrFda63MBzVUwPpKnWpGIRJ0vulu/hjgS0geTvl9cREVIrujajR2Gz
         gsGaY4P+xph8EM6gvGAJ+mNyR/TOX5T8s25AIiI4U3wMLQgXkeG5CeP56aSFPl6Of+mj
         P1vQ==
X-Gm-Message-State: AJIora+Xo+lJ4QN1GuJa1CWN6lSIOXjlcELs1Eq/1wx7mQpSrWp6fRxi
        xomX8Xe86+OuVF2IRJFF2P3fWU/pM2g5Vb8wJNVgZQ==
X-Google-Smtp-Source: AGRyM1vxoZI3m9hElle4o62W9mKIrDr0LOAaKuoUqqlt2TO3csI8K7FZPgCmvM8deSM7HEPtdV6x2TJv7RpMJkrO860=
X-Received: by 2002:a05:620a:2a0e:b0:6a7:8346:1601 with SMTP id
 o14-20020a05620a2a0e00b006a783461601mr1415421qkp.593.1656116917557; Fri, 24
 Jun 2022 17:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52RW+UFJ=hqMWjwR8qvEbww7QjzPW1nhL3Atd97QXAnYw@mail.gmail.com>
 <007ea4c9-9701-f4ab-3278-5d36bf2018c4@quicinc.com> <CAE-0n53kNCK0ajHfY2WQr5HEQZtZSBLnhfbTuZwaUNEOZhsKPg@mail.gmail.com>
 <fa7f8bf1-33cd-5515-0143-6596df2bd740@quicinc.com> <CAE-0n51g-EVsC-i9=sJV-ySa8VnE+yT7cg=b-TNMi9+3uBiOVA@mail.gmail.com>
 <326912ff-9771-0711-366d-79acd436908b@quicinc.com> <CAE-0n51qrdrFtSr0vRwgYkMgSZfnzQuinaUROQsp30QoDchWQA@mail.gmail.com>
 <0ff3d6a3-dc5c-7c77-f8a1-6c4f6c1a3215@quicinc.com> <CAE-0n515hMKqQ+Vj1Sg54PpwkbWMYJ77QN+y+KZNBWymjhpWKw@mail.gmail.com>
 <66ff4642-f268-f5b0-7e28-b196368c508a@quicinc.com> <5cf094cf-343a-82d7-91c4-1284683f9748@quicinc.com>
 <CAA8EJprqq=vxXT2DmEWii_Ajx2UbkHRexPTT58xFcWkBa_D5hA@mail.gmail.com>
 <26263c16-8cbc-ccca-6081-7eba14635d73@quicinc.com> <CAA8EJpqEoXXA=eKGHRGuQ3VOHnmEShY8u_SMZ6WFWORCFhFcrw@mail.gmail.com>
 <8445f93a-00f0-64af-5650-07f2bc487742@quicinc.com>
In-Reply-To: <8445f93a-00f0-64af-5650-07f2bc487742@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 03:28:26 +0300
Message-ID: <CAA8EJpqB2KPyvFehK9WRGgiVnqvD24cz5BcHsw8a5PQ2Vs1oKA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
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

On Sat, 25 Jun 2022 at 03:23, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> On 6/24/2022 5:21 PM, Dmitry Baryshkov wrote:
> > On Sat, 25 Jun 2022 at 03:19, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> How can I have eDP call dpu_encoder_init() before DP calls with
> >> _dpu_kms_initialize_displayport()?
> > Why do you want to do it? They are two different encoders.
>
> eDP is primary display which in normal case should be bring up first if
> DP is also presented.

I do not like the concept of primary display. It is the user, who must
decide which display is primary to him. I have seen people using just
external monitors and ignoring built-in eDP completely.

Also, why does the bring up order matters here? What do you gain by
bringing up eDP before the DP?

>
> We want eDP encoder  help functions be executed before DP.

Why?

-- 
With best wishes
Dmitry
