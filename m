Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45C594AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356190AbiHPAHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354305AbiHOX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:58:55 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305C4AD59
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:22:10 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u9so9732611oiv.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=KUREXGO6jnd0bVGmD0b7wZHGhfBeIpSV7ISn3FBvF0g=;
        b=JVd7W9eNeC0LVvIMOinSk+P3PbZ0QvzqiK78lUWaC/aeWGVRVPfOuQQ2twhXTjfHIF
         u7BSqTsZjJkD9tVZIpymEVjuC4ijnZY8oTKHpf3/hmtRAZ+vLY+mOb1wcFGEZSP8Xla0
         67Mvs50TMjeV/4b48ccuKW4FRtzxqKJlYj/+8+D6zDhzo0v8ZVqHx5e2sQbkjAY6Cp7j
         uMkulLi3/iZr+pBL0o5Rc4uEVpQShr3ROTP8nfBYSrf/0yNJLlX6gxWkBOeI2O9IBcJo
         L57K2iFjZ2MYb2AVioKHP59giORw537DKt1r57cFQ8DS6hH5ar+OWJOKMCf385hAp/8J
         9Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=KUREXGO6jnd0bVGmD0b7wZHGhfBeIpSV7ISn3FBvF0g=;
        b=hhFz4vMZFyi4qnSSGI4dNz34rArMwXp/fccjbwK0zDRwuSjcjZ0fNllS5WX0LWHqa/
         v3xqw+yp2+uanXP82xcsAudiPQNvIevPU0G/YU83qfGHhZ/xXp8of0sTrWenJtJ5Ltsl
         BUiFf71XwyvDTL4cuhlyAKpaAqdt8KZVagzuqKbxtw5+f4taxOdM9q337w4/YlcurAdH
         RcTWN/nxSRxMrwydEo0pAYl1pdcCg/fjVtax6ESLiRwoKW7ro9NBERijUTXp1ElDwNn7
         aMH6j78jGYXu0QqyxJvaMKpd/FJDn24Yi86eZVi7i0pdzEBNHpW3WAVzioi/xRkSHZJT
         Jc/w==
X-Gm-Message-State: ACgBeo0k4SQrf5olVKAkKNDJqMuwuWmKnCNMYwoj9ZKTe4+zMD14WVhg
        A5CtSyC76VtUKS+F6s+UwArNO+qTIPIsJpeElYRLppxU
X-Google-Smtp-Source: AA6agR6/HoPU6iiFYk8vyjp+FTggm6uWYFAiy68hDHp9aGnJKMy5dFHVdevch5QQawGn+Cd4BEr765eFuhcI+C+eawI=
X-Received: by 2002:a05:6808:1491:b0:343:7543:1a37 with SMTP id
 e17-20020a056808149100b0034375431a37mr6706596oiw.106.1660594929626; Mon, 15
 Aug 2022 13:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220719103954.6737-1-strochuk@ispras.ru> <fac8ce6e-6f5f-598d-35cc-7bf01ac90f30@amd.com>
 <f750ab62-7deb-21a1-753e-1ee838386265@amd.com>
In-Reply-To: <f750ab62-7deb-21a1-753e-1ee838386265@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Aug 2022 16:21:58 -0400
Message-ID: <CADnq5_ORzjVFR9nxaJO6giVoGT8_BVtdq8PURjPrzOd7jpoH7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove useless condition in amdgpu_job_stop_all_jobs_on_sched()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Andrey Strachuk <strochuk@ispras.ru>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, ldv-project@linuxtesting.org,
        Jack Zhang <Jack.Zhang1@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Surbhi Kakarya <surbhi.kakarya@amd.com>,
        Melissa Wen <mwen@igalia.com>, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Aug 12, 2022 at 7:13 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> @Alex was that one already picked up?
>
> Am 25.07.22 um 18:40 schrieb Andrey Grodzovsky:
> > Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >
> > Andrey
> >
> > On 2022-07-19 06:39, Andrey Strachuk wrote:
> >> Local variable 'rq' is initialized by an address
> >> of field of drm_sched_job, so it does not make
> >> sense to compare 'rq' with NULL.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>
> >> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> >> Fixes: 7c6e68c777f1 ("drm/amdgpu: Avoid HW GPU reset for RAS.")
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 4 ----
> >>   1 file changed, 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> index 67f66f2f1809..600401f2a98f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> @@ -285,10 +285,6 @@ void amdgpu_job_stop_all_jobs_on_sched(struct
> >> drm_gpu_scheduler *sched)
> >>       /* Signal all jobs not yet scheduled */
> >>       for (i =3D DRM_SCHED_PRIORITY_COUNT - 1; i >=3D
> >> DRM_SCHED_PRIORITY_MIN; i--) {
> >>           struct drm_sched_rq *rq =3D &sched->sched_rq[i];
> >> -
> >> -        if (!rq)
> >> -            continue;
> >> -
> >>           spin_lock(&rq->lock);
> >>           list_for_each_entry(s_entity, &rq->entities, list) {
> >>               while ((s_job =3D
> >> to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
>
