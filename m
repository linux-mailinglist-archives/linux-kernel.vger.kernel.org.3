Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65F4FA05D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbiDIABl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiDIABi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:01:38 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21B335645
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:59:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c199so4391094qkg.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ep4HFxZGemluJutovsTbozz4aCXR3Ya1T5frn7xqC+A=;
        b=W1MkNAp8xV5HT+QqAx4kLm0SNYJQBh84WYuvZfZmLltO29+iMFuxhXu/9iPkvvyghd
         evMPG3QDhUti9BYqPcLkpVCb1PNebe36yhEAlsoPSXsm3ZX1Vdjytwd28ik26yCTeZwo
         8ssm5qZ2k165XPYHn58Y0MR0QZWeokpgdMBw3N386WqBL6BOOU30pUPL/lORltzQpyTH
         fZQwOHaCVMxUgS8CNdYui496fBoMJXXkV5Jw1OyddA+IJeRUUkw8w5mANj0JWfU8wwEK
         8W0sKFHiwwsInstAxplk6zqDrVbY6DTjdc+00p/zKab3JIGMD0QrQkir+tnW0GGs9w0e
         ReAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ep4HFxZGemluJutovsTbozz4aCXR3Ya1T5frn7xqC+A=;
        b=FEhPhLAkzCO37KGGoj0mI6QrSH/cE5kByuvBy/NgWZUjz07DGxzy3XpYTxPvOsfwxS
         Jeng1V/yKI+AW/w2vzHZpq4XYIgv6qAVSngkcBoq+vlX96w9jwtNAkqZLE7dDNlC8igV
         ET9qBsYaNd4u4c4O/ITY6nlvZ6FbkSfNYu5D9iPi3/NCLHV+SVhTntuzomAd9fPpkoG2
         Ou3slYxBota3M8+isJkDh3sIkBm4iM6hsEZgnL3fY89pHIe5S/5FPlDU5kJS7E0OTsaJ
         osuUyEVAZ1bKekyxg00ZSLgtB2LivfKvAKDHSw3fdXOGe1et7f7WLy9aQ/YUTWcUCwrS
         MHcQ==
X-Gm-Message-State: AOAM531NR98HC0xuCAJpQhCfEzAubEIk4b5ye/SYlTSIiAuPwIUa2IMJ
        F/Zg/GmOUxMeQL/+fG9Qb072zcu7eRwpwc8tT1IHXg==
X-Google-Smtp-Source: ABdhPJybXQIl400imv5u+eLq4wIpQrgRiwQ4eURC/e6m01mzUErigFhQXkQJfEw+aw8JJtTDDj1iqa8rcBKROaoImMU=
X-Received: by 2002:a05:620a:2449:b0:69a:4ae:85e5 with SMTP id
 h9-20020a05620a244900b0069a04ae85e5mr7089008qkn.30.1649462372909; Fri, 08 Apr
 2022 16:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
 <625ce8a0-4e25-5513-5599-c1cdebf5a3a5@linaro.org> <09fd563f-4a2c-f670-51c2-0e5ff023816d@quicinc.com>
In-Reply-To: <09fd563f-4a2c-f670-51c2-0e5ff023816d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 9 Apr 2022 02:59:21 +0300
Message-ID: <CAA8EJpqzucFGf8ndDi2LZqtKiOt_w=_h1oPAUNVCdmUyh_3+zA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: enhance both connect and disconnect
 pending_timeout handle
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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

On Fri, 8 Apr 2022 at 23:30, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 4/8/2022 5:27 AM, Dmitry Baryshkov wrote:
> > On 07/04/2022 00:28, Kuogee Hsieh wrote:
> >> dp_hpd_plug_handle() is responsible for setting up main link and send
> >> uevent to notify user space framework to start video stream. Similarly,
> >> dp_hdp_unplug_handle is responsible to send uevent to notify user space
> >> framework to stop video stream and then tear down main link.
> >> However there are rare cases, such as in the middle of system
> >> suspending,
> >> that uevent could not be delivered to user space framework. Therefore
> >> some kind of recover mechanism armed by timer need to be in place in the
> >> case of user space framework does not respond to uevent.
> >
> > Hmm, how does userpsace 'respond' to the uevent? The driver should
> > send hotplug notifications to userspace, but it must not expect any
> > particular reaction. The userspace might be as simple, as fbdev
> > emulation, but the driver still should function correctly.
>
> yes, driver is function correctly by setting up main link. but it does
> not know which resolution to display.
>
> It send hotplug notification through uevent to framework after main link
> is ready.
>
> Framework  is responsible to set up MDP timing engine to start video stream.
>
>
> However it does not know which

It's of no concern to the driver. It is completely the userspace
problem. After resuming, it should reread available video output
properties. The display could have been changed while the system is
suspended.
From your description I still do not understand why you need the
'recovery' mechanism.

-- 
With best wishes
Dmitry
