Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3198949C226
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbiAZDan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiAZDam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:30:42 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0BC06161C;
        Tue, 25 Jan 2022 19:30:42 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id d8so6947025qvv.2;
        Tue, 25 Jan 2022 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nR/2qASV68S+qbCb4NFTdiqEMN7v1LnkjxhCU3OugNo=;
        b=alCXqezT8WzMVzmL21JOByzmt95cMtz8ztaUHZ/2eNk4I7uoorGsWSg4uvmKw11Hzo
         pAuE68eST8fIJa/OWdWASTRZO8421UFkuiUhmZLTYiW/VTeGX6UTq4eJD173JLuBybHf
         7F6JL6rzDdam/4EEAXXbNQacaPP/7IHUheB11w2pRO9L3ZYFdf3mzxPeY1FCjCEL1eyE
         7ABqZW7wlxn7XiPe+fuguQ25XK5qetKbcCf7HJffI1tljyxOB4qfpf2fDsMVsZ4BJ372
         He5C/hX81V2Ov8LykMhijqVCz0Kcl4L0a2TpVeK+y5Ef4v0NYYytgY6n3e9IY/HR0wnZ
         qlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nR/2qASV68S+qbCb4NFTdiqEMN7v1LnkjxhCU3OugNo=;
        b=1mVfZZ1b761lP64XcE4azVF0zQ8VGoUE3wZUsxM8V5NaFSkg5zoOkXcEBRA8GwdeBJ
         LIKaNtPb+JDmMrrHUT0pr8V97f5xvSKVr1KNLr1q9+OTX7NCN/KM1pAsDqu+T2FbBPnj
         SoWH9iTLr3I3HLLsLvmUUteUnvqGD4FcwgGSRuyknFgrqJ2spbkPFAdTi12qvFWTUqwi
         CS/0IR7qtn/vz8JrEP14OZ1cvDv+usgym3yBBUMyhJFGjPBk/TKn3uHUrL8SGNgWdqvf
         Tp1rBlUI9wT5gt4KWzOtEnBT4fOrQpjbmfYsQPh6aHnCkew4mQNPUl6vXlIm4dV+x70J
         pmzQ==
X-Gm-Message-State: AOAM532CsKnwYFzx+nm7KZkHPc/Z7igGXgcojwFLHHsFMKzPcZEUXzeN
        cayZ7qQyp2K44mp1ngYykl3WwaroRRwuxu5mmSg=
X-Google-Smtp-Source: ABdhPJz9KH+uAz3QUjXErjdEt7bV+Hvjv8J8ogL1YLXpBzgKl96Ikh9TISpKxbrnviOUH9Tdn7YDvEWXkyO9+SpLLP8=
X-Received: by 2002:ad4:5fcd:: with SMTP id jq13mr22674064qvb.60.1643167841312;
 Tue, 25 Jan 2022 19:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20220125225723.GA78256@embeddedor>
In-Reply-To: <20220125225723.GA78256@embeddedor>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 26 Jan 2022 11:31:23 +0800
Message-ID: <CADBw62qd45fuER5oXKoDPwKbOOvwba9ek0Oz+AxtGrF0OL_64A@mail.gmail.com>
Subject: Re: [PATCH][next] hwspinlock: sprd: Use struct_size() helper in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 6:50 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
>
> Also, address the following sparse warnings:
> drivers/hwspinlock/sprd_hwspinlock.c:96:36: warning: using sizeof on a flexible structure
>
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/hwspinlock/sprd_hwspinlock.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
> index d221fc9d756d..22e2ffb91743 100644
> --- a/drivers/hwspinlock/sprd_hwspinlock.c
> +++ b/drivers/hwspinlock/sprd_hwspinlock.c
> @@ -93,8 +93,7 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
>                 return -ENODEV;
>
>         sprd_hwlock = devm_kzalloc(&pdev->dev,
> -                                  sizeof(struct sprd_hwspinlock_dev) +
> -                                  SPRD_HWLOCKS_NUM * sizeof(*lock),
> +                                  struct_size(sprd_hwlock, bank.lock, SPRD_HWLOCKS_NUM),
>                                    GFP_KERNEL);
>         if (!sprd_hwlock)
>                 return -ENOMEM;
> --
> 2.27.0
>


-- 
Baolin Wang
