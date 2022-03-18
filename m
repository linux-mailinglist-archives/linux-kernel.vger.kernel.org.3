Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C764DDD33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiCRPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiCRPqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:46:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154465E3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:45:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a8so17800360ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iEoUOGNuvWutEIurlLjPrbp6aIbsgX9NoeRfOy5dLGk=;
        b=DNyxJPUVY3a3yXjwkgNmDeTZP28aOjJhD5zrO8oUQV22xMuvBRqBEhj1Hz6aw8f95K
         N8SWbRTkgRh550F17RVQonRKEUhmCMq485ad48SfTs5Wp7ZL0q3xCFzgnCOzNxwjcPyN
         jJJn8Dn3GnOsMI9itRww5SZHhy+ue+yoUXy6kGuBH6f/vGXHl+XElD/C/ZWF2YZOCyKk
         3awiI+4OmS6AcWEVUMpZkPNQdaBX6jhechb1HE1LWI8p0rvC0gMQOmOrOcAmV+tmRQ1B
         7bmzYgr0CGm5TQ4rOAAGpkGn5+pB/s5vNs7CJUqvYz/xOAesYKJ1weQh4wnHdbSbcK11
         JArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iEoUOGNuvWutEIurlLjPrbp6aIbsgX9NoeRfOy5dLGk=;
        b=sSymZXCrGgQUHKhf78y5JxnYt6m6ITpZA65bY0NBUyCf3GP53EIEeqt8FLpJ8RuxsZ
         mTRGk4yht1+zrvFAXtwURY/RJvXI+i5U2xiN4w/NZAyMIkMDCM7HIoArV3a4PscQTYyE
         BiuJMqSdSRNXvjLPF3y7iKcTZe2fFBVhJW01uS+SvTwB/ZAUiV6aFpxt9/WWt5KDHpqX
         MmW02oMbWIfNnKWO2ZkjNbuONRu8794pKbi4C3fd5A9/tvBec0QKPv9atmTzJVFfzH4F
         Io/12xK/hcQKIP89Oj2P4+0IpC/YSAGBh8j4cQoY/YYRJPA1tAwZpOmdj5C9L3kVN0IK
         TzAA==
X-Gm-Message-State: AOAM530HTRgU9oC+/j+Y/quMZhjasNsQe4YyDWPrSe8EuFoglIfHYGrX
        JfojnQMQEiPR+COKE7zSRusxbFTOX6NfK//5L9NNIQ==
X-Google-Smtp-Source: ABdhPJxxSv8Wsl18jpwozD6dMsfMf8L0YR73y4KRlXnN10+bPOK6orQ78rzB9xVNxs5f1eYNMbp9Q+OYDrzJs/kGJSo=
X-Received: by 2002:a17:907:869f:b0:6da:888b:4258 with SMTP id
 qa31-20020a170907869f00b006da888b4258mr9648477ejc.720.1647618303898; Fri, 18
 Mar 2022 08:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220317140115.541007-1-shraash@google.com> <f1ff7e95-c177-09dd-9393-d0156ce81387@molgen.mpg.de>
In-Reply-To: <f1ff7e95-c177-09dd-9393-d0156ce81387@molgen.mpg.de>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 18 Mar 2022 08:44:52 -0700
Message-ID: <CABXOdTecWs5oTfEDyK4onzrzcBnD7u-3j3ikbz4bvo20PEd17w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fixed the unused-but-set-variable warning
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Aashish Sharma <shraash@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Mar 17, 2022 at 10:58 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Aashish,
>
>
> Am 17.03.22 um 15:01 schrieb Aashish Sharma:
>
> Thank you for your patch. If you are going to send a v2, please use
> imperative mood. Maybe:
>

Uuh, sorry, I have to take the blame for that. I am guiding Aashish
through the process of submitting patches upstream, and I completely
missed that.

> drm/amd/display: Fix unused-but-set-variable warning
>
>
> > Fixed this kernel test robot warning:
>
> Maybe:
>
> Fix the kernel test robot warning below:
>
> > drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
> > warning: variable 'temp' set but not used [-Wunused-but-set-variable]
> >
> > Replaced the assignment to the unused temp variable with READ_ONCE()
> > macro to flush the writes.
>
> Replace =E2=80=A6
>
> Excuse my ignorance regarding `READ_ONCE()`, but is that the reason you
> remove the volatile qualifier?
>

It is not the reason to remove volatile, it is to enable removing it.
I had suggested using it, following its description " ... Ensuring
that the compiler does not fold, spindle, or otherwise  * mutilate
accesses ... ", to avoid the use of volatile, and to make it obvious
from the code that the read is intentional. My apologies if that is
the wrong approach. A simpler solution would be to just remove the
temp variable if that is preferred.

> Some robots ask in their report to add a Found-by tag. If so, please add
> one.

I think that should be "Reported-by", or more specifically

Reported-by: kernel test robot <lkp@intel.com>

>
> > Signed-off-by: Aashish Sharma <shraash@google.com>
> > ---
> >   drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/=
gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> > index 873ecd04e01d..b7981a781701 100644
> > --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> > +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> > @@ -2913,13 +2913,12 @@ static inline void dmub_rb_flush_pending(const =
struct dmub_rb *rb)
> >       uint32_t wptr =3D rb->wrpt;
> >
> >       while (rptr !=3D wptr) {
> > -             uint64_t volatile *data =3D (uint64_t volatile *)((uint8_=
t *)(rb->base_address) + rptr);
> > +             uint64_t *data =3D (uint64_t volatile *)((uint8_t *)(rb->=
base_address) + rptr);
> >               //uint64_t volatile *p =3D (uint64_t volatile *)data;
> > -             uint64_t temp;
> >               uint8_t i;
> >
> >               for (i =3D 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i+=
+)
> > -                     temp =3D *data++;
> > +                     (void)READ_ONCE(*data++);
>
> Did you verify, that the generated code is the same now, or what the
> differences are. If it=E2=80=99s different from before, you should docume=
nt in
> the commit message, that it=E2=80=99s wanted, as otherwise, it=E2=80=99s =
an invasive
> change just to fix a warning.
>

The generated code is exactly the same on x86.

Thanks,
Guenter

> >               rptr +=3D DMUB_RB_CMD_SIZE;
> >               if (rptr >=3D rb->capacity)
>
>
> Kind regards,
>
> Paul
