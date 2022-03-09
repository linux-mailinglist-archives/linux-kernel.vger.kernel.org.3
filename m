Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C935B4D38FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiCISke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiCISkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:40:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A9D1704D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:39:33 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qt6so7033064ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=em6T+/1/fmVib88fJAAgqxswmidjeHxiyizhAcqA5gE=;
        b=qsfwzPQJjVPuRYk/Gl2WM9LTuRk1+MujS+XYWWW0Q996LpOyAl8orlmWSRgUZzgT8n
         QWe/b6XtV7URnHj8+ikt4koBLtqHtSZ7nr+ImB9AVVso+Gmpdl05JZQYw3YseTwsP58c
         9kjcq59jAj3XAR8tvxjVD35baObBUf/LPhvok9ei/VJREjAxoBzbydx4MBvpWePXB8pO
         3rrpslI9oFSa1u4ckjeWrcTb/eTG+NGrbswiBTP3hPwt+LPl38L0YCNK+vus9itCeqXH
         nQof+6mBmYvOEIULFflFPgCEyvuzPVXvlrSP7eXwZKksOxCVl5bZRSpVuD2D+TcegRTR
         Gw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=em6T+/1/fmVib88fJAAgqxswmidjeHxiyizhAcqA5gE=;
        b=oFHCz1tLUmG7T0VBJPZmIsoNtaevc0jgQF4xFjyGevqA+nN2jDYaAOEz44W6Z85VGx
         drM8VoR4BsjjUDbEDZKNMwnJhuTT1AGS4edDp+zoGUgtRvG2tvBceFEoOecWWUQWJoG3
         G5M7vhqz3MoNz2fn4joZs50BksYaFrlO21X+FAJzOkFFhkbEr5YLdf4A+mP87ahlQtGb
         Z+lJOAHXBN79xKGDGV+OJVy9T2fClWKj3bG/nL0no8IDKc06bR7/YgLiovsmxOm4Ma4a
         /qrVzaD6Vdse/0QzazoPF6VzDWpOdvuoXTRy5GkIT07KkCjdngGOAkjHEg4cYWzpwB/k
         Cgcg==
X-Gm-Message-State: AOAM532mfNKssWvBlcGMt+BhJMcSyvIhBiCmDzheg2g4J6ihHrd0RTJW
        qBbud8QiGY9UmpFBw/qzkTLnGNzMYOZOnSWQYj42S45tdebMCg==
X-Google-Smtp-Source: ABdhPJzk76D+ZF0tkgwkfAw5I3tdrLHR30RAL4PrDOT/LTsM0pxV2I2r7F7ruQZJoJdK3VhV9XTDn3977unVvzRME7U=
X-Received: by 2002:a17:907:a41f:b0:6d6:f925:1696 with SMTP id
 sg31-20020a170907a41f00b006d6f9251696mr1098751ejc.62.1646851170563; Wed, 09
 Mar 2022 10:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20220308064821.2154-1-peng.fan@oss.nxp.com> <20220308064821.2154-2-peng.fan@oss.nxp.com>
In-Reply-To: <20220308064821.2154-2-peng.fan@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 9 Mar 2022 11:39:19 -0700
Message-ID: <CANLsYkw2zuquHEb1SiMR6TTy-w329GCXw4mE=Jr_tecKdzvL4A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] remoteproc: support attach recovery after rproc crash
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
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

On Mon, 7 Mar 2022 at 23:08, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Current logic only support main processor to stop/start the remote
> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do attach recovery after crash and trigger watchdog
> reboot. It does not need main processor to load image, or stop/start M4
> core.
>
> Introduce two functions: rproc_attach_recovery, rproc_firmware_recovery
> for the two cases. Firmware recovery is as before, let main processor to
> help recovery, while attach recovery is recover itself withou help.
> To attach recovery, we only do detach and attach.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  use rproc_has_feature in patch 1/2
>
>  drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..366fad475898 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1887,6 +1887,50 @@ static int __rproc_detach(struct rproc *rproc)
>         return 0;
>  }
>
> +static int rproc_attach_recovery(struct rproc *rproc)
> +{
> +       int ret;
> +
> +       mutex_unlock(&rproc->lock);
> +       ret = rproc_detach(rproc);
> +       mutex_lock(&rproc->lock);
> +       if (ret)
> +               return ret;
> +
> +       if (atomic_inc_return(&rproc->power) > 1)
> +               return 0;
> +
> +       return rproc_attach(rproc);
> +}
> +
> +static int rproc_firmware_recovery(struct rproc *rproc)
> +{
> +       const struct firmware *firmware_p;
> +       struct device *dev = &rproc->dev;
> +       int ret;
> +
> +       ret = rproc_stop(rproc, true);
> +       if (ret)
> +               return ret;
> +
> +       /* generate coredump */
> +       rproc->ops->coredump(rproc);
> +
> +       /* load firmware */
> +       ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +       if (ret < 0) {
> +               dev_err(dev, "request_firmware failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* boot the remote processor up again */
> +       ret = rproc_start(rproc, firmware_p);
> +
> +       release_firmware(firmware_p);
> +
> +       return ret;
> +}
> +
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
> @@ -1901,7 +1945,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -       const struct firmware *firmware_p;
>         struct device *dev = &rproc->dev;
>         int ret;
>
> @@ -1915,24 +1958,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
>
>         dev_err(dev, "recovering %s\n", rproc->name);
>
> -       ret = rproc_stop(rproc, true);
> -       if (ret)
> -               goto unlock_mutex;
> -
> -       /* generate coredump */
> -       rproc->ops->coredump(rproc);
> -
> -       /* load firmware */
> -       ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -       if (ret < 0) {
> -               dev_err(dev, "request_firmware failed: %d\n", ret);
> -               goto unlock_mutex;
> -       }
> -
> -       /* boot the remote processor up again */
> -       ret = rproc_start(rproc, firmware_p);
> -
> -       release_firmware(firmware_p);
> +       if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_RECOVERY))
> +               ret = rproc_attach_recovery(rproc);
> +       else
> +               ret = rproc_firmware_recovery(rproc);

Should I assume this set, which is labeled V2, replaces this other
patch [1] that is also labeled V2, sent out on January 26th?  If so,
why are they both labeled with the same tag and why isn't there a
cover letter to clearly state your intent?  More importantly, why am I
having this conversation with an experienced kernel developer that
should know better?

Any reason I should not move this work to the very bottom of my patch
queue or better yet, simply drop it?

[1]. https://lore.kernel.org/lkml/20220207173456.GA3355405@p14s/t/

>
>  unlock_mutex:
>         mutex_unlock(&rproc->lock);
> --
> 2.30.0
>
