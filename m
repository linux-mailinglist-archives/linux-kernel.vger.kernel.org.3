Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323BB492F11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349092AbiARUN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348488AbiARUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:13:51 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB35C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:13:51 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t9so598283oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpoF/evSGX0quKC3ojWlZTaHsolih4rnXmKXZB109js=;
        b=n8WE+2ligzVvQw/ftNjaP0Jz2I1BoZsxvck3BbPbUE2kP5cwZAgXweL6E9LBtnJvJM
         1Z+RJvetEolqEgtBCwkmyNZ48Dog0SO60DM9dFkETYnmCh/xaeKp+fzwHVNyAqRLLemj
         tADuUkyCCcJF9iQFwMdF/H+JhaKN2HGHFsC0Lrrb/z9jS1Yf4Q0S1Z1+eIG0uoK+uvQP
         cCcvC6YIqQ0LRWQpCXPLkr3tCrYJUHYK4AiYcEkUXQUMOomxqNl5rupsd0ne7DWp4Hym
         lPUhAymAfQZHw0K887F/ecfeKL/1bSKmAffodTve5rE3R4E9fyHgU28XaLZco31L8wv8
         8YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpoF/evSGX0quKC3ojWlZTaHsolih4rnXmKXZB109js=;
        b=j44KjL4L3yLy7GSfA/RX3nZOP12CuF+E+1CLa7tMoHBAcU2PdbP5dhJTBmbO91tRrn
         leSh87gLPi5IRn1hzgmdPqqV2H9ac6DFaaannWsE3a9ott/JzlTz7EUqWNBNXpCmRUs+
         Qo8uqDy2sQLKA1uCrMKyG1jQQq7s1ve8ioj3ATpgS/1WGL2nrdZtiN/k9XQU9YGdPfhF
         nak0oM5kQvHikElVuVA0BfHNBTsXQCv8Ox7oNmCqvkRAxA8zOz8I1swZecKUYOqBC+oU
         j/d7x0NljChbQBvlKjZHweq7EWrHEPOn6HdkjUQ3fNewDt+o7mju0PTbKdbyGLzTD+p2
         Fyuw==
X-Gm-Message-State: AOAM5311WWgdnumxgopHuOwlHkTCmuTsHOzeQ2A5v0+x0AftYf6VzUfg
        LMmruPTwV/fGSLMyHxjmnurvdDUT6jnCyyNvVcg=
X-Google-Smtp-Source: ABdhPJxvYFNlS33t9IOQ2TLxkoGORZjhSHiI7VuLU21HAwY3nvkX4Ewt2BR5wBKsVHdRKvXiVgMiEuFSpuxy058YkGI=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr176939oig.5.1642536830297;
 Tue, 18 Jan 2022 12:13:50 -0800 (PST)
MIME-Version: 1.0
References: <1642507272-17545-1-git-send-email-lyz_cs@pku.edu.cn> <0ba294a9-1428-98cf-93b6-f9a195924a8f@amd.com>
In-Reply-To: <0ba294a9-1428-98cf-93b6-f9a195924a8f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Jan 2022 15:13:39 -0500
Message-ID: <CADnq5_M7SqB_OjKaYaqKvdC=8xAo=Zn4NFzAuPxZrKPEOJtU8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add missing pm_runtime_put_autosuspend
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Yongzhi Liu <lyz_cs@pku.edu.cn>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Jingwen Chen <Jingwen.Chen2@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>, Jack Zhang <Jack.Zhang1@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Strangely I can't seem to find this patch in my inbox or in
the dri-devel or amd-gfx archives.

Alex

On Tue, Jan 18, 2022 at 9:03 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 1/18/2022 5:31 PM, Yongzhi Liu wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > when it returns an error code, thus a matching decrement is needed
> > on the error handling path to keep the counter balanced.
> >
> > Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
>
> Thanks!
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 9aea1cc..4b950de 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1120,8 +1120,10 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
> >               return -EINVAL;
> >
> >       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> > -     if (r < 0)
> > +     if (r < 0) {
> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >               return r;
> > +     }
> >
> >       while (size) {
> >               uint32_t value;
> >
