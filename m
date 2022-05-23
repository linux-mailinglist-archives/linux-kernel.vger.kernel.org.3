Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94007531EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiEWWpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiEWWpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:45:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180EABF4B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:45:01 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id b11so4488601qvv.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rypfduMofq52o9Cw4bRVJ4YmnkHY5oYB2ohQA+ESkAI=;
        b=k21oHGm0XlDpBA85Iv8KLMxGl747dSSdXE/EQyrLw9mufTBWj0M6QTD5xziStZGSax
         rsRSKgHWBLMlhZ92G8QYix9zssd7roGkDcKcOVZ78tx2ubdiDauy3Vbkx008q6bxygJ4
         DUmQ26ZXi3O2lWLDlZDoUFt85gOIQ6f1dlS2AhQ9k28X+yfGX3ow6kOvQNJgZHpnnzvF
         FWbQfK8KuSu9LWM1QZyd6uCIrhja4Y/y3XPc/g+P4FxJwERhcMptBoMl3Xb/l+rYfkJh
         8rebEvtWe+YSg431tnavm1SWe+NxnNWr/h9TNjHOIcf+Fj+ppVEv6ttuw9iIYwaoBIu5
         4SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rypfduMofq52o9Cw4bRVJ4YmnkHY5oYB2ohQA+ESkAI=;
        b=SvDu1n5BcERy66bVSrSGjsWK5c1l+IFpQ2gsSNY6ZqeEErx639XQS0zH0Y2MSt5kzY
         82Cq4trqpO0HyUWlms2Cpdvm65hpTqHUVK342bkskztlLTzobMhedMgQobexeJJQA70m
         WfLDZrXr3vncx0CNWvurRNmIAHSwNnhgd9j3yybYAD/9S8QEEu18x2zJUxuQ5ZYridmz
         BaMVhDOABlOHLH0ULT2SXV5qqLIhp4wKs/+4xnYNF7KDRrBbAUlVpqV89/wHN7D/99ky
         NOQC8iz3NOt4oOuzseEdLsWuXDooXLXheQTnjsGUTqrcAEQERoKnBl5g+lRuAEQMUpni
         edlQ==
X-Gm-Message-State: AOAM531kMuPlnPT4c6rRmeikhQdSmQ7c7QcER4afDmUvwcuB2mompp/G
        vXssLCF+pu+iXRYIfqMEdTez8bhTcz1/fJw4tE9BuA==
X-Google-Smtp-Source: ABdhPJzz71U22o77PPLCWll4LOjtW5ov17NvyPyylFN9GoUFs7JpXdQIQhFptHaspJJWWce0ytJssabLtNao3p4Y8No=
X-Received: by 2002:a05:6214:3e1:b0:461:f0b1:6b12 with SMTP id
 cf1-20020a05621403e100b00461f0b16b12mr18964358qvb.122.1653345900868; Mon, 23
 May 2022 15:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220523213837.1016542-1-marijn.suijten@somainline.org>
 <20220523213837.1016542-6-marijn.suijten@somainline.org> <CAA8EJprN833M+KOZXOyuaL_KqzEV61P69VXw7mfWo5OiXjE2FA@mail.gmail.com>
In-Reply-To: <CAA8EJprN833M+KOZXOyuaL_KqzEV61P69VXw7mfWo5OiXjE2FA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 May 2022 01:44:49 +0300
Message-ID: <CAA8EJpqB4wAZo_EVX9dgTvAyX7yqTUUPNeEUsG58nckdDKxr-A@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/msm/dsi_phy_28nm_8960: Replace parent names with
 clk_hw pointers
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 at 01:44, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 24 May 2022 at 00:38, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > parent_hw pointers are easier to manage and cheaper to use than
> > repeatedly formatting the parent name and subsequently leaving the clk
> > framework to perform lookups based on that name.
>
> Can you please add a followup patch (or a preface one) removing the
> rest of devm_kzalloc()'ed clock names.

Argh, stupid me, you did that in the next patch. Please ignore this.

>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
