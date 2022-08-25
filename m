Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05445A1649
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbiHYQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiHYQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:01:17 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802098D24
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:01:16 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11c5505dba2so25428833fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RFEbXp9j8ztzn5cw3OPjC4jXsY7xL35PN1g35X+7I4Y=;
        b=ZRxR/uF+SzZ8HHYwG6JXygFtqmhUYCqnImfzdss+e9H5X/1+Gq2wuyaHAwkKUzl9z0
         czXfEC1I6Z2k5he21+fKBp3CGytw6TnQbseFpV3PWN+bnCgGSztWfnr4jq1Rm5W3kLiT
         mrMRtOlZ0S2fbKUqReZ3Lb+rKbNfmsxPuLk9XWjhRdW3INOyjMNlMuccQ9L5oFSi7MV2
         kiIN/w807oVnrekP40R/fSiVUIj8YkY5yM1/NQd+orLnPh4PwbU6s3PN6VHQg0BSQMPc
         9TboOqIMr7dMbWmHGGfDT0rN0DeKFXwwD0DiAplin4oMLij5tUb3LLOVr8vAGHS87AD4
         vEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RFEbXp9j8ztzn5cw3OPjC4jXsY7xL35PN1g35X+7I4Y=;
        b=WEnxZUXZQ3X9/9i4ofT/Runh83I0o+lLBPV3kQCxw9oZMFNGfQiTNTGsEriyfC2UQ5
         H5ihbgIFIpn7uO/8+qQ/IqR38tWT0yKMMCEiwEs42nwDmPY3rMXDlLlTuk0lqG/tDZGt
         3wr4Vl3CScd/n/CE0bYwy6f4eGPJHy6R7jn8QRI6RFzIsFId+asO437Su6rwKFKe+rpW
         grJfiGHS/7wIqB/OJvDgW9kolKJ9QdNxxf3NPg1wCZs1zJkcCZVX5qrhnXzzvU645IIn
         SVF83UxdAgUjC2WgmbwKyL/ebMShGamxBCO74rpy44uAWKg32GFXy4/berQPH80NeC5e
         dM6w==
X-Gm-Message-State: ACgBeo2Guv54u3l5cNcRGVDuZLFCoaSLEgobJ/Yppd/7aUIKOUNJkUGs
        AEixNKYWmuOKQcoBhvV1C+6c0g4sAhJbufex+dk=
X-Google-Smtp-Source: AA6agR5pTBtN+TEDkLbLrHdtSxKwurpwFad1aQD5kTena4GH/G1DjdDZtYCyJJ1W5pYrWkLgNH3oUhDWlaZQujmF8iU=
X-Received: by 2002:a05:6870:3484:b0:11e:4465:3d9b with SMTP id
 n4-20020a056870348400b0011e44653d9bmr703328oah.46.1661443275620; Thu, 25 Aug
 2022 09:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220823070047.20930-1-bernard@vivo.com>
In-Reply-To: <20220823070047.20930-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Aug 2022 12:01:04 -0400
Message-ID: <CADnq5_Ond9WHx46E=zK-j1V08LC_f+29_b0mybaqxwWweigDNw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: remove possible condition with no effect (if == else)
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Martin Leung <martin.leung@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Samson Tam <Samson.Tam@amd.com>, Alex Hung <alex.hung@amd.com>,
        Joshua Aberback <joshua.aberback@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhaojunkui2008@126.com
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

Applied.  Thanks!

Alex

On Tue, Aug 23, 2022 at 3:01 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch fix cocci warning:
> drivers/gpu/drm/amd/display/dc/core/dc.c:3335:2-4: WARNING:
> possible condition with no effect (if == else).
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index aeecca68dea7..2d4c44083d79 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3332,13 +3332,8 @@ static void commit_planes_for_stream(struct dc *dc,
>                 /* Since phantom pipe programming is moved to post_unlock_program_front_end,
>                  * move the SubVP lock to after the phantom pipes have been setup
>                  */
> -               if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
> -                       if (dc->hwss.subvp_pipe_control_lock)
> -                               dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
> -               } else {
> -                       if (dc->hwss.subvp_pipe_control_lock)
> -                               dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
> -               }
> +               if (dc->hwss.subvp_pipe_control_lock)
> +                       dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
>                 return;
>         }
>
> --
> 2.33.1
>
