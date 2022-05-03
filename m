Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81B55191A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiECWtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243819AbiECWsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:48:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D706421
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:45:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k27so21432089edk.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcoJyd6IQhefQYX8YmS8kRdiPp97xel2zqR6ovb3t1o=;
        b=mSx7kXDA9VtimMmq2W2PO1IrRIczfsMh72TqK8A7iswnmIOVOSVsWOnR5nGU8MAgsd
         DP3spwwVJVqXGF8a6KPc51AMcglh4r1h9aB1i+VYB9rbuibnvdq2/64fP6xwIRRqhJPc
         lWmeVHp18dsk6pOXkY4G3D0ohs++wfKJOc+EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcoJyd6IQhefQYX8YmS8kRdiPp97xel2zqR6ovb3t1o=;
        b=LbAGfQDnjsU3A9kIlAkSJiESSmjUoJDxhtVTMcx8v/qWZGJ4ceVl2D/JTmDQEkKMG8
         YLBzQ50DAdKHb3KEmY+rlDfaYPz/dEqJxx876VJU79N1dbdZkyCXik3HIRwCdeivFrXP
         wjD7OkEzUmc7teI7gTofzb6TyPdOjihnxlC3iv0RRrLXEsq/mctXxWK0/0lKeu0bsUHn
         XT1z9h0+0tdBnmDeiIsabMHc36OtVZwfGwcEx57eeVaS0K5llcqX92MR0UN9oqJppC/v
         fjYQAiZAv2daeC9kn37embQAwDA60xFCTURGiK/iB139nzryM7sV5DVl4sbwOj06qP3n
         74Vg==
X-Gm-Message-State: AOAM531doDTB0yR7aVf+kt2sqh+UIJydkbVbESHHNFB6zSqjYoJgKxR6
        nfywaxyaskHkabqRJVTkN8bJ6CB/brgMArDt
X-Google-Smtp-Source: ABdhPJznWrGIbyfugcRXVEqjn2Trx2Bj1Ee5cOcd9rG5zymssrOrqgdugRe7feM7F8eVy2FSZEUtbA==
X-Received: by 2002:a50:ce19:0:b0:425:d85c:90e3 with SMTP id y25-20020a50ce19000000b00425d85c90e3mr20418461edi.350.1651617918872;
        Tue, 03 May 2022 15:45:18 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id qs24-20020a170906459800b006f3ef214e1bsm5044891ejc.129.2022.05.03.15.45.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 15:45:18 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id bg25so10645754wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:45:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr5127000wmb.199.1651617916164; Tue, 03
 May 2022 15:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid>
 <a9a5dfb7-819b-d3a2-2c47-d5b239d21ad3@linaro.org> <CAD=FV=WKwErpD7iCu+2jFvMutmmmgLUEhAnw8s=27wUxcpF-aQ@mail.gmail.com>
 <CAA8EJppOVqaAEVeQY7p0EfCObJxfL591kbaYLYfbgOHHtmfhXw@mail.gmail.com>
 <CAD=FV=UmXzPyVOa-Y0gpY0qcukqW3ge5DBPx6ak88ydEqTsBiQ@mail.gmail.com>
 <ddb8d8fa-89dc-268b-0505-9ee7df8c272e@linaro.org> <CAD=FV=Ur3afHhsXe7a3baWEnD=MFKFeKRbhFU+bt3P67G0MVzQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Ur3afHhsXe7a3baWEnD=MFKFeKRbhFU+bt3P67G0MVzQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 15:45:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEgcrLYzLcPkf+n20VcMBD2BVFo++0BSaDWniDPzM2Hw@mail.gmail.com>
Message-ID: <CAD=FV=XEgcrLYzLcPkf+n20VcMBD2BVFo++0BSaDWniDPzM2Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] drm/dp: Helpers to make it easier for drivers to
 use DP AUX bus properly
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 4:10 PM Doug Anderson <dianders@chromium.org> wrote:
>
> So I guess where does that leave us? Maybe:
>
> 1. I'll add a WARN_ON() in of_dp_aux_populate_ep_devices() if there is
> more than one DP AUX endpoint with a comment explaining why we assume
> one DP AUX endpoint.
>
> 2. I'll create this new structure in drm_dp_aux_bus.h:
>
> struct dp_aux_populate_callbacks {
>   int (*done_probing)(struct drm_dp_aux *aux);
>   void (*pre_remove)(struct drm_dp_aux *aux);
> };
>
> 3. I'll add a second version of the populate functions that AUX bus
> providers can use if they want callbacks:
>
> int of_dp_aux_populate_ep_devices_cb(struct drm_dp_aux *aux,
>                                      struct dp_aux_populate_callbacks *cb);
> int devm_of_dp_aux_populate_ep_devices_cb(struct drm_dp_aux *aux,
>                                           struct dp_aux_populate_callbacks *cb);
>
> The old functions will just be changed to wrap the above and pass NULL
> for the callbacks. To me, this seems better/simpler than notifiers or
> any other scheme, but yell if you disagree.
>
> 4. I'll call the callsbacks in dp_aux_ep_probe() after a successful
> probe. I'll add a second callback and will call it in
> dp_aux_ep_remove() before passing the remove through to the panel.
>
>
> If that sounds peachy then I think it should be pretty doable.

I never heard any response about whether people liked the above, but I
went ahead and did something similar to it. It can be found at:

https://lore.kernel.org/r/20220503224029.3195306-1-dianders@chromium.org
