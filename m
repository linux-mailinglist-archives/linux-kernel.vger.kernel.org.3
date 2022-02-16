Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0D4B8DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiBPQXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:23:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiBPQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:23:51 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE4521FC69
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:23:37 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m14so4819065lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzBX1lIAVYZwdECaRMhi8WBrfRP47BlcmzYMUdivK5U=;
        b=keZIpHeTvTHtXJK9/pje+DNhUxw0b6g+PN/54W4qKYTwwl6ZJRBqCLk+Ha4D0P3YDk
         keJ+8z+bB0sqMQSQ+0zNF7slV8OZcHf4s6wxH6qzHd5ASQOvrX3XUVvMB5dMNUJyXziA
         8/qqX1s8UTd9azWkIx/zpio+3RTiTuBAiMGwosSvP/wcs5847OmkKHy14EwFN48ryB4E
         64rDmMsiuaio/5wVmJJO7FDtXkrk0wMmgMQLSMJE6V5mTwghA43jQn2/N9MJmmr83Owl
         k1WO7Sozach4DT+6Rqd7bja50HPUyDDTciIU1+cfATD2c66XAcqk/wl4ZwMA8SPq27OV
         hQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzBX1lIAVYZwdECaRMhi8WBrfRP47BlcmzYMUdivK5U=;
        b=Jy86jQETSzsdvTM2X2FQmU6kzM5ALa9hzx1pDapMUZ+C+JKgKJnt9F6ofWyv1AcJRq
         RwG99o8KkCBakxO4JPRYZXYJThC+Z7+8RnoxZyFePgCHKlUWHtu7aO+3yL4VfhgsWINE
         Jbbd+C2dK323u7ksYLWSVlNxS8uivDYGoK4OK4k/Tb2zlp07cv5Igb0FOYSYm/CKEc1r
         9pGrheeWYSFdGcbr6ZuJIqPnb6AqW4skmLahw58ejaXRESygpPnrPnBREI7yVsC/KGAN
         5Wu5sE7dGt3CoEbuOOPJEV7auoF9XGe4g64vZW9QXeMjZWQahMUVeu8YXpMCCoG4yNmf
         /BgA==
X-Gm-Message-State: AOAM530pBuk7X5pLoRkd74YdWybkix+frElGFarFOeUdG9kJxl2nzzIz
        k0qnXwfpGGyUKnPveXNVnO5/k1oUH70VNnWDPNpRaCTR6LA=
X-Google-Smtp-Source: ABdhPJyUuQz4Diml1VJhvSdyugYzUWtSBf05c5HD9+nNLuAQ4WtatF+oZKRsz3jYwQcAMJd0SuaAXICsTz85sxLyZxc=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr2576104lfj.254.1645028615997; Wed, 16
 Feb 2022 08:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-3-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-3-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 17:22:59 +0100
Message-ID: <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> When the node is virtual there is no release function associated which
> can free the memory.
>
> Free the memory when no 'ops' exists.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/dtpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 0b0121c37a1b..7bddd25a6767 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -181,12 +181,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>
>         if (dtpm->ops)
>                 dtpm->ops->release(dtpm);
> +       else
> +               kfree(dtpm);
>

This doesn't look correct. Below you check dtpm against "root", which
may be after its memory has been freed.

If the ->release() function should be responsible for freeing the
dtpm, it needs to be called after the check below.

>         if (root == dtpm)
>                 root = NULL;
>
> -       kfree(dtpm);
> -
>         return 0;
>  }
>

Kind regards
Uffe
