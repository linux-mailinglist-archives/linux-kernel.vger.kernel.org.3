Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CCF4BF9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiBVNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiBVNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:42:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C588D68B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:41:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y24so12489680lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYjRWsW9pcEcQ2t56kY0xhwAZ/vjldT5YxHAgh3ZMy8=;
        b=pd2VrkzjJ4DBKAhv8/hr9VAZh4WjtLOx7ruO96wujvdkx/wDgPKZa5mu60uS6OIePa
         Sa9iKw2/HEoCvRBUHHhYkkzuacsAL6Z6rJoNPxvLQuzftqPq74Q85SThu6HaspZs1IuE
         MpP4w255u+2HMw6vlJJjXSkvrtoL7TJL5rptqS72lZ5ap0OofJHvmEZd4UANtlq8tUTv
         5mRJFuS97fwv7YoArKXUtkOC02JRz8GSO5+N4d5b8f5hRdJgMiNCTTeoQeXYC1ZiqPUn
         4u+g5xMJwyogUDEcRQy2wZ3AU3S+ZcmdrYMdvBT6jeQx05vhucub6pJwijTBQKGpd7nG
         fLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYjRWsW9pcEcQ2t56kY0xhwAZ/vjldT5YxHAgh3ZMy8=;
        b=gzAqD5zDd9rPPXPI/+tF610WLe4W8/5Jxcjfx776PZtd+fJSapjcYGwakwbNv2Vjhe
         O48iOnhxBx67fGW+1YzKYxCnOME0bLXIoIdLCEgi84gtIKuveU8pMGAApN2lIx+h2AkB
         QZpvEe5iQdGBDf5tb9X7IJSjlJopu9Vco54nQI1IQFHlWsU6BmR2qjw9Jg9j9zmEYm60
         EKTMew9W8tOxi7IA5veqlwoFl2fpJwhaWeHGJ70iSaOrFD4BPBldbxBYJprsBFvFVgxI
         cq6+TQ7JseJx4s1RD58VGfkyHkJ9vtPXAfewP72wkJ7X8dx96cexEXEfmiKNdK5FWIem
         jqGA==
X-Gm-Message-State: AOAM533lqeQLLkGTotSwIM6Gd7E3Pl6cyhgWwX34be0x9lE2MhRRO+Pk
        pqzDfwJp/Fm1ZKKbzzzKMJYHfIRjNpof2rQ9/4Z0iw==
X-Google-Smtp-Source: ABdhPJxt9zV8dVY/0aDDpkL90WGgkd5FN2NEf8alpUvu7/9ecS098UHve0gpczfD3R14rIkO5fSzXtB8tRbj+L3iREs=
X-Received: by 2002:a19:ee17:0:b0:443:5f2c:289e with SMTP id
 g23-20020a19ee17000000b004435f2c289emr17236703lfb.57.1645537317803; Tue, 22
 Feb 2022 05:41:57 -0800 (PST)
MIME-Version: 1.0
References: <tencent_22C6C2E595DEFED1417A98A5736539482809@qq.com>
In-Reply-To: <tencent_22C6C2E595DEFED1417A98A5736539482809@qq.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 22 Feb 2022 19:11:46 +0530
Message-ID: <CAO_48GGSPnQzo2D3zK-TuWHSdHn6XGV0=9MuF2d06XSAn1isVQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: check the return value of kstrdup()
To:     xkernel.wang@foxmail.com
Cc:     christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
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

Hi Xiaoke,

On Tue, 22 Feb 2022 at 17:00, <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> kstrdup() is a memory allocation function which can return NULL when
> some internaly memory errors happen. It is better to check the return
> value of it to prevent further wrong memory access.
Thanks for the patch; looks sane.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

Will queue it up.
> ---
>  drivers/dma-buf/selftest.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma-buf/selftest.c b/drivers/dma-buf/selftest.c
> index c60b694..2c29e2a 100644
> --- a/drivers/dma-buf/selftest.c
> +++ b/drivers/dma-buf/selftest.c
> @@ -50,6 +50,9 @@ static bool apply_subtest_filter(const char *caller, const char *name)
>         bool result = true;
>
>         filter = kstrdup(__st_filter, GFP_KERNEL);
> +       if (!filter)
> +               return false;
> +
>         for (sep = filter; (tok = strsep(&sep, ","));) {
>                 bool allow = true;
>                 char *sl;
> --


Best,
Sumit.
