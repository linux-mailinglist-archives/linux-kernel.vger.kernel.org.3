Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244855CAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbiF0X2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiF0X2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:28:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51146DBE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:28:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o9so15162966edt.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Spj1S0nEmr3mdqe+SBysZnlIvOHa+5hXVGG2oJZ/gY4=;
        b=gw3JBCSK7pUmYmcwcMUIWMn5+CWQcbCcDcRx8oxASvz6jD1mczE+qT/ZBB96doH0dX
         qxC84Qwu/KkCO1VhbGAoN9YlrzNXn09yMegVa/n1J8QvW3Q3oJx4knBJfVyM5HtrHzZJ
         Ev5mkfHH/F3gv31lSwwOzmPUd433yiR6r7Vq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Spj1S0nEmr3mdqe+SBysZnlIvOHa+5hXVGG2oJZ/gY4=;
        b=v0jq4k/lQ5A5ZjI382Jx1ncUBsDFyDdGYY0wTn8nsXsKPF8EOol1bLdXHBWks65yKx
         ac4iRk+Q8SUrpHfPJjiJwAzq1crfSyQBHlPT+U5x1L7Wv9ArIVgeDa0PF4lPqGz5l6uX
         r959tJ1QSV+SJllvIIsHeDNFpCY/xmgSWlC8yhGtOJNdDCP6okheZOq/izAfDveU7uvD
         TW7qjh3/eaoqhpAsST0K2oJQZwkAJqb4L2HrlL3HUpGA1qxszNbT9CBZZ7BA7EY3tCfY
         leeqKOe6LRJ6Hqk5OtJALLRpJM0tDmA0Cq8TXQ4OFzOK9umYllbD8mE4UvcK7e/dwN6J
         Q1vA==
X-Gm-Message-State: AJIora/v6dXdmMUkH0MUAK/Z32n5rK+b8KYTI15YlijiR3jRDRJ3gjGt
        HzlpPZ+r5HPC/pY+WPMqjYzszEv2PaxrchNo
X-Google-Smtp-Source: AGRyM1tuJSFdlnF5awyww44DzZELW8up4AGXlJMmRHbd0JnhLksQljq6sNTNClIgMyrUs4Cp+IVAyg==
X-Received: by 2002:a05:6402:2687:b0:437:652e:26a1 with SMTP id w7-20020a056402268700b00437652e26a1mr20032523edd.36.1656372492691;
        Mon, 27 Jun 2022 16:28:12 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709063a5200b007262d69543fsm5510527ejf.106.2022.06.27.16.28.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 16:28:12 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so6746398wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:28:12 -0700 (PDT)
X-Received: by 2002:a05:600c:5107:b0:3a0:4342:ed75 with SMTP id
 o7-20020a05600c510700b003a04342ed75mr15187921wms.93.1656372020510; Mon, 27
 Jun 2022 16:20:20 -0700 (PDT)
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
 <6523e533-960b-d148-0f87-2ad327a3ac3b@quicinc.com> <CAA8EJprQBnZAc-2AxXD8cV_qMoKrusNa+VSHW9Kw-xKS_ZWAkg@mail.gmail.com>
In-Reply-To: <CAA8EJprQBnZAc-2AxXD8cV_qMoKrusNa+VSHW9Kw-xKS_ZWAkg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 16:20:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvNrfYaUgbDayxU0wJUbZbgwVMWjeyTjtd+Sqcvj=e2A@mail.gmail.com>
Message-ID: <CAD=FV=WvNrfYaUgbDayxU0wJUbZbgwVMWjeyTjtd+Sqcvj=e2A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Vinod Koul <vkoul@kernel.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 25, 2022 at 1:48 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 25 Jun 2022 at 04:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > On 6/24/2022 5:11 PM, Dmitry Baryshkov wrote:
> > > On Sat, 25 Jun 2022 at 03:03, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >> On 6/24/2022 4:56 PM, Kuogee Hsieh wrote:
> > >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> > >> b/drivers/gpu/drm/msm/dp/dp_display.c
> > >> index dcd80c8a794c..7816e82452ca 100644
> > >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > >> @@ -140,8 +140,8 @@ static const struct msm_dp_config sc7180_dp_cfg = {
> > >>
> > >>    static const struct msm_dp_config sc7280_dp_cfg = {
> > >>           .descs = (const struct msm_dp_desc[]) {
> > >> -               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
> > >> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> > >>                   [MSM_DP_CONTROLLER_1] = { .io_start = 0x0aea0000,
> > >> .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
> > >> +               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
> > >> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> > >>           },
> > >>           .num_descs = 2,
> > >>    };
> > >>
> > >>
> > >> The reason order is important is because  in this function below, even
> > >> though it matches the address to find which one to use it loops through
> > >> the array and so the value of *id will change depending on which one is
> > >> located where.
> > >>
> > >> static const struct msm_dp_desc *dp_display_get_desc(struct
> > >> platform_device *pdev,
> > >>                                unsigned int *id)
> > >> {
> > >>       const struct msm_dp_config *cfg = of_device_get_match_data(&pdev->dev);
> > >>       struct resource *res;
> > >>       int i;
> > >>
> > >>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >>       if (!res)
> > >>           return NULL;
> > >>
> > >>       for (i = 0; i < cfg->num_descs; i++) {
> > >>           if (cfg->descs[i].io_start == res->start) {
> > >>               *id = i;
> > >
> > > The id is set to the index of the corresponding DP instance in the
> > > descs array, which is MSM_DP_CONTROLLER_n. Correct up to now.
> >
> > Right, this is where I misunderstood his explanation.
> >
> > Even if we swap the order, but retain the index correctly it will still
> > work today.
> >
> > Hes not sure of the root-cause of why turning on the primary display
> > first fixes the issue.
> >
> > I think till we root-cause that, lets put this on hold.
>
> Agreed. Let's find the root cause.

FWIW, I was poking a little bit about the glitch that Kuogee was
trying to fix here. Through a bunch of hacky heuristics I think the
dpu_hw_ctl_trigger_flush_v1() is the function that "causes" the
corruption. Specifically I managed to do something like:

if (hacky_heuristic)
  pr_info("About to call flush\n);
  mdelay(2000);
}
ctl->ops.trigger_flush(ctl)
if (hacky_heuristic)
  pr_info("Finished calling flush\n);
  mdelay(2000);
  pr_info("Finished calling flush delay done\n);
}

I then watched my display and reproduced the problem. When I saw the
problem I looked over at the console and saw "Finished calling flush"
was the last thing printed.

I don't know if this helps much. Presumably we're flushing a bunch of
previous operations so whatever we had queued up probably matters
more, but maybe it'll give a clue?


Other notes FWIW:

* If you increase the amount of time of the glitching, you can
actually see that we are glitching both the internal and external
displays.

* You can actually make the glitch stay on the screen "permanently" by
unplugging the external display while the internal screen is off. I
don't know why it doesn't always happen, but it seems to happen often
enough. Presumably if someone knew the display controller well they
could try to figure out what state it was in and debug the problem.


-Doug
