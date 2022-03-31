Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00834EE228
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiCaT4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiCaT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:56:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A2960A84;
        Thu, 31 Mar 2022 12:54:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c7so1335542wrd.0;
        Thu, 31 Mar 2022 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+woCqSRN/iPJPDhXido2RTys7AhCgzJm7RlMHPDtp4=;
        b=L8zzTUHI02LY2DUF6K1iFRY9ZUoFqty0Mfod+IdwlXRT49VTPLlTNtr6gUjNfio+lH
         UeIfRaTUOb8BICGNlKrumSq8EjzTMrf9tTcPciDWG0CFitmHeCl3gLLQNaG4q8KmCjZv
         UYcLumBp3/XXoj4KVE3vnJ1N8Bf1HAqnNFxUXcnB/xir0UFlooFLKIAOhS/FY59k1jLi
         7sYFTZSWsLgeaxm6RJ/8EKZtiJSEc8bJI1AwxAOJqIoG2AXOIRoFoWDZC2TSDfXYgbyZ
         0ukisy7tdPxLp4C0VX04Hg3zt0igZbMvSCezV/rV2akbZBgoL4XBJucJBGMO0FXseGb1
         5Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+woCqSRN/iPJPDhXido2RTys7AhCgzJm7RlMHPDtp4=;
        b=epphDhGNKZMrSo5lEATJY17jEAR9aruTdh2wqofI6WguOK9+yJ6bIubzAem/eGKEW4
         yn+ifRJeGYv4GngkphBV3lQy6bkq9PTplXHtAOmAV6xIPgjklKAf53+eKuvTb1aTcNNI
         hp1Bp8UKWMH1h4zwAxfwH7u0ptQdDlGH3rQF2ngPiVHbseo+S2GoFRoNlRf23iMu1y0/
         FpUxSLz4JG0LxNixYJ2FaCv3ywJ590y9yRmc3cmY34E255sN8WFKNGZm9IDsCqa9nuDY
         NoCAOuhvDFvx2Tkb58gQfVJ+kkmaMY7CHqXcGgEr/7awkewh7L6WZyNqDAwfl1NQ33wQ
         pXwg==
X-Gm-Message-State: AOAM531k0BHYztW2S3b9WJUh/0wJF2gYkrkrgP41A80QCtaMHnsSQagJ
        gTJWhjHYGkuFjtZcoBWu4d/4TJ1W3Jk5mFYgM5s=
X-Google-Smtp-Source: ABdhPJxCn8bZA1ok0IRYryEvFh8skfsiOCJwEL2rMyo66Je1AvtOILxEmYjajETgMg9CBpv8K4ncluCui4jKiXIE0Yo=
X-Received: by 2002:adf:f20f:0:b0:203:fc73:a9a0 with SMTP id
 p15-20020adff20f000000b00203fc73a9a0mr5302332wro.418.1648756458095; Thu, 31
 Mar 2022 12:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220330204804.660819-1-robdclark@gmail.com> <20220330204804.660819-11-robdclark@gmail.com>
 <ad97096f-cc90-4f20-0f73-f33e9b275f1a@collabora.com> <CAF6AEGvZqM1OT_n1C+x+C1GTd4PbFkH4c7P-BseDOUGj7yj3Eg@mail.gmail.com>
 <22d9a9ff-1c44-ed41-6ae1-59a1f965ab6c@collabora.com>
In-Reply-To: <22d9a9ff-1c44-ed41-6ae1-59a1f965ab6c@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 31 Mar 2022 12:54:06 -0700
Message-ID: <CAF6AEGuX0EKU+XqvkhwNBgR733pa4ZPr2+i51uTQz85mjxh-2Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] drm/msm: Add a way for userspace to allocate GPU iova
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:41 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/31/22 22:02, Rob Clark wrote:
> > On Thu, Mar 31, 2022 at 11:52 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> ...
> >>> +/*
> >>> + * Get the requested iova but don't pin it.  Fails if the requested iova is
> >>> + * not available.  Doesn't need a put because iovas are currently valid for
> >>> + * the life of the object.
> >>> + *
> >>> + * Setting an iova of zero will clear the vma.
> >>> + */
> >>> +int msm_gem_set_iova(struct drm_gem_object *obj,
> >>> +                  struct msm_gem_address_space *aspace, uint64_t iova)
> >>> +{
> >>> +     int ret = 0;
> >>
> >> nit: No need to initialize the ret
> >
> > actually, we do
>
> Indeed, sorry :)
>
> ...
> >>>  int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
> >>>               struct msm_gem_address_space *aspace, uint64_t *iova,
> >>>               u64 range_start, u64 range_end);
> >> nit: There is an odd mix of uint64_t and u64 (and alike) in the MSM code
> >> :) The uint64_t variant shouldn't be used by kernel code in general and
> >> checkpatch should want about it.
> >
> > one of many things that I disagree with checkpatch about ;-)
> >
> > I prefer standard types to custom ones.  I _kinda_ get the argument in
> > case of uapi (but IMHO that doesn't apply to how drm uapi headers are
> > used)
>
> I'd understand if it was all either uint64_t or u64, but the mix.. hm.

yeah, fair, we could be a bit more consistent

BR,
-R
