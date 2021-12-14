Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4447E474B73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhLNTDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhLNTDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:03:34 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDACC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:03:33 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id a2so19328410qtx.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPut++DE9oSDA7Chd0SjdQdqRXfrEo4dk9mIHr0IEwI=;
        b=kmpqKRnXneoYfsEoIjy2oU4gKiI3YIyrYivpL88Ce7gsi6vwsJWmiAM6ovLZgU14QL
         AWE8I3rlIbmWVDIt2WAsh6rnlRbqJ8yNvF+9CpYvVbjnFg9DFimIJ/CR6spR9kYPcEts
         k/RJYsmNVVlkYMBmLW2w5dJ7/2QY3zdO0Od6+mtG9mo4Ycl6Zz7QvNugwNLkcyib8nQD
         kdhm9AhH4HZ8EpHMYoy9Y9IQE3584FpiwovBTlmGIUNB9s/It8xRpfLRkH0R7ZhNP4VO
         krwitEO0V0hVyz/znayeGuu6H3HBfpwxRZIYLKn71ovidZ/HECUkZPJMz7zbyav9HkxJ
         jp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPut++DE9oSDA7Chd0SjdQdqRXfrEo4dk9mIHr0IEwI=;
        b=palNigSC8n1TEeIovdWShssytDuptx9rXFdN7grdCipA+J+BQtzgno3uBLcJQrkxpX
         ULSr30XnRmgwsF1F7en+HJ62RkTWF1g04pspQtbGNUNFV25b1P+LjPG9MHiFwRxAuBZO
         1qL+5eATpldDhhMmLyXf0/lmOQKT8cFFxlU421eFW3El98Hum9blwtODawQNhE2FsvJ7
         jFc6QvkfrZO9Y36vzggeNX3Ykyp0yuuph8ZQ9UboEV5ZtOnIPAzl0HsYaBcpkNgQrK99
         mbkPQDmQAwS0Tm5dIoTGQ20SA956JUkvj1sgSMWiFq2DTYT4MBFClC4nLGEXvog84QBh
         MNag==
X-Gm-Message-State: AOAM5317nshubb3nKeTtIAWaLc9WmffC+fRNZ8z2tu//cRmmhjPiOrae
        Zgt70QCZASHuiEcA8dzNJFoDJEw8WyzXwTMcxpOKzQ==
X-Google-Smtp-Source: ABdhPJzyRs/SkZa7rM8wtTsEOtQ+XLrgBbLZgqv/9SuBSu3jfTTmtv87+/mDKeEDQ/0sgKqI7jAue3Wsf24yk+u2F5w=
X-Received: by 2002:a05:622a:40d:: with SMTP id n13mr8112713qtx.511.1639508612966;
 Tue, 14 Dec 2021 11:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20211214173917.1496290-1-robdclark@gmail.com> <20211214173917.1496290-4-robdclark@gmail.com>
In-Reply-To: <20211214173917.1496290-4-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Dec 2021 22:03:22 +0300
Message-ID: <CAA8EJpo2ng0mVk0Hsqmg5yTi3Wm0nUp8Lx8+CGF=RBeuYPmviQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/debugfs: Add display/kms state snapshot
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 at 20:34, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_debugfs.c | 90 +++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index 956b1efc3721..088f1160c892 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -15,6 +15,11 @@
>  #include "msm_gpu.h"
>  #include "msm_kms.h"
>  #include "msm_debugfs.h"
> +#include "disp/msm_disp_snapshot.h"
> +
> +/*
> + * GPU Snapshot:
> + */
>
>  struct msm_gpu_show_priv {
>         struct msm_gpu_state *state;
> @@ -109,6 +114,88 @@ static const struct file_operations msm_gpu_fops = {
>         .release = msm_gpu_release,
>  };
>
> +/*
> + * Display Snapshot:
> + */
> +
> +struct msm_kms_show_priv {
> +       struct msm_disp_state *state;
> +       struct drm_device *dev;

I don't see ->dev being used outside of _open() callback. So, I'd
suggest removing it and using struct msm_disp_state instead of struct
msm_kms_show_priv.

> +};
> +
> +static int msm_kms_show(struct seq_file *m, void *arg)
> +{
> +       struct drm_printer p = drm_seq_file_printer(m);
> +       struct msm_kms_show_priv *show_priv = m->private;
> +
> +       msm_disp_state_print(show_priv->state, &p);
> +
> +       return 0;
> +}
> +
> +static int msm_kms_release(struct inode *inode, struct file *file)
> +{
> +       struct seq_file *m = file->private_data;
> +       struct msm_kms_show_priv *show_priv = m->private;
> +
> +       msm_disp_state_free(show_priv->state);
> +       kfree(show_priv);
> +
> +       return single_release(inode, file);
> +}
> +
> +static int msm_kms_open(struct inode *inode, struct file *file)
> +{
> +       struct drm_device *dev = inode->i_private;
> +       struct msm_drm_private *priv = dev->dev_private;
> +       struct msm_kms_show_priv *show_priv;
> +       int ret;
> +
> +       if (!priv->kms)
> +               return -ENODEV;
> +
> +       show_priv = kmalloc(sizeof(*show_priv), GFP_KERNEL);
> +       if (!show_priv)
> +               return -ENOMEM;
> +
> +       ret = mutex_lock_interruptible(&priv->kms->dump_mutex);
> +       if (ret)
> +               goto free_priv;
> +
> +       show_priv->state = msm_disp_snapshot_state_sync(priv->kms);
> +
> +       mutex_unlock(&priv->kms->dump_mutex);
> +
> +       if (IS_ERR(show_priv->state)) {
> +               ret = PTR_ERR(show_priv->state);
> +               goto free_priv;
> +       }
> +
> +       show_priv->dev = dev;
> +
> +       ret = single_open(file, msm_kms_show, show_priv);
> +       if (ret)
> +               goto free_priv;
> +
> +       return 0;
> +
> +free_priv:
> +       kfree(show_priv);
> +       return ret;
> +}
> +
> +static const struct file_operations msm_kms_fops = {
> +       .owner = THIS_MODULE,
> +       .open = msm_kms_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = msm_kms_release,
> +};
> +
> +/*
> + * Other debugfs:
> + */
> +
>  static unsigned long last_shrink_freed;
>
>  static int
> @@ -239,6 +326,9 @@ void msm_debugfs_init(struct drm_minor *minor)
>         debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
>                 dev, &msm_gpu_fops);
>
> +       debugfs_create_file("kms", S_IRUSR, minor->debugfs_root,
> +               dev, &msm_kms_fops);
> +
>         debugfs_create_u32("hangcheck_period_ms", 0600, minor->debugfs_root,
>                 &priv->hangcheck_period);
>
> --
> 2.33.1
>


-- 
With best wishes
Dmitry
