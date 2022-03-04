Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6450D4CDFFC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiCDV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiCDV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:58:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A6340DF;
        Fri,  4 Mar 2022 13:57:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i66so5760219wma.5;
        Fri, 04 Mar 2022 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7TkAsAlGjYObu7TdoSPfW2GLOJ6vTkBbos7TJsttN0=;
        b=BqLiIbJ2zBK8K4Mx2Wc69vkqiE6eSWCmhXdOWjGffvI1NnSyh+d/WjNITwq2v6V6IG
         9CF1Vd1ELchUlXHCi2qtVEPvMP67rMnevW/VefZ/rTFRxHteb7EduhgXZHP8+kgJqJpA
         j8P97CDzjtcfDnIPMBSDzoFJQwggj+2TH2BsAnWLschCKYYWEnUT1KLDCQPcs2JFkpxB
         vIseJhijpjiEb/6de+dXVHR0sC5UDep93zYf6N/8tHJ18wtCD/Am0L6A3LOWCm3b+iDO
         sSg1K1JMQNULPZIbQ/NVL/aHK4rGD14lMcuCjqLBQGblRQS7zCnKEIVqFpYDwh9rVRdZ
         EJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7TkAsAlGjYObu7TdoSPfW2GLOJ6vTkBbos7TJsttN0=;
        b=L9/SbrTeAIWkpB03n9FpXQanj33FnImXmGGNe/OW4OExWOjx4F/1pq5OGIRn8+UXG3
         rfMgWInyRhKPIoDyRtaDgsdXV+sO46VOjR+E90Qv+4HWf6+67DaU3xRpLyMjhkc7Grka
         ccqApJaWqZiGLX8rWpXC4FSxtYALZKAbZlOtYgLUkuvQC1j28GoHw8pgawL59JvCrjhL
         Uld2/bRF7jhoGWxj9OzJ1LVizZ8FwPN4MefuVh7k0362k+3sQzPYIKWqFqLvi5CaPShF
         WwOHAEKdSXFjqc0gvPihgiamUQHdsZmMrdB7xfgqDbzpZkrTyHRPH1Xl6LBZpS4g2sXA
         QC6g==
X-Gm-Message-State: AOAM533TtOCMg3mW7n5GtHbKvvDW8owNmhB7LciUMljhY1VB8NU/Eppr
        zC/eZEngnDRv/viCJPneTaktrvW6a6pwzbVdOp9SI5Za1jA=
X-Google-Smtp-Source: ABdhPJwO/bkqOVAmUnFtqrqafLEOzfVIo5UA/cHC4Nov19WqzYp+G1wTFEVO22Hl3ZTxVFCeC3Tccb4ArfhCXkYSmTI=
X-Received: by 2002:a7b:cf23:0:b0:385:17a6:9b9f with SMTP id
 m3-20020a7bcf23000000b0038517a69b9fmr298717wmg.151.1646431062329; Fri, 04 Mar
 2022 13:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20220304202406.846485-1-robdclark@gmail.com> <CAA8EJprik57F+t0KicoYaRm=oDOgcQHyHSBjJKbekBKjO_-=0A@mail.gmail.com>
In-Reply-To: <CAA8EJprik57F+t0KicoYaRm=oDOgcQHyHSBjJKbekBKjO_-=0A@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 4 Mar 2022 13:58:11 -0800
Message-ID: <CAF6AEGtM+Jhye7ahW3uFg-8PFHH257-T7Qudo=XMU5-AU2LvcA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Fix missing ARRAY_SIZE() check
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
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

On Fri, Mar 4, 2022 at 1:47 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 4 Mar 2022 at 23:23, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Fixes: f6d62d091cfd ("drm/msm/a6xx: add support for Adreno 660 GPU")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> However see the comment below.
>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index 02b47977b5c3..6406d8c3411a 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -687,6 +687,7 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
> >
> >         BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
> >         BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
> > +       BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
>
> The magic number 32 and 48 are repeated through this code. I'd suggest
> to define them and use defined names.
> It can come up as a separate commit.
>

Or perhaps instead:
----
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6406d8c3411a..58c371930fb4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -683,20 +683,23 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 {
        struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
        const u32 *regs = a6xx_protect;
-       unsigned i, count = ARRAY_SIZE(a6xx_protect), count_max = 32;
-
-       BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
-       BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
-       BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
+       unsigned i, count, count_max;

        if (adreno_is_a650(adreno_gpu)) {
                regs = a650_protect;
                count = ARRAY_SIZE(a650_protect);
                count_max = 48;
+               BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
        } else if (adreno_is_a660_family(adreno_gpu)) {
                regs = a660_protect;
                count = ARRAY_SIZE(a660_protect);
                count_max = 48;
+               BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
+       } else {
+               regs = a6xx_protect;
+               count = ARRAY_SIZE(a6xx_protect);
+               count_max = 32;
+               BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
        }

        /*
----

that moves each of the two uses of constant together..  adding three
#defines each used only twice seems a bit silly, IMHO

BR,
-R
