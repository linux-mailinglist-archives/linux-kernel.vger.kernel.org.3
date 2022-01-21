Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572EF4960F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381071AbiAUOcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348810AbiAUOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:32:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889FC061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:32:46 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o12so34171921lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJQIuvj9hZOV2/MczNgBpv+PjMBSGnGqbFntPtlryTc=;
        b=YGxrpvlPmNWGI2zsCCgbxbZKQzQxHQf6iTSL4CHvDpRCmLe6CM0kCd0r4k+av23yUQ
         zNr/T344+alvGwpC2j9kjxZsFPaBeVAGQmBwVDa5N0aSX1MHDOuwko9Lwg7ARvcQ4igm
         Iqvm7nUQrZFT+qoRKLwTdtLm6iqirO1xF91ZFZJ1lw/LoeoIUkp5/IjryEDBtsOQA6Pj
         k27cPvDHYlSgCqHTQQe6Eem78uT+28hF04nRJsmIvw+FYcURr1yuhbE1LI/tANvjw0eL
         pwrV7wkBrs4IALIM7TlcV4yyZreP09/ZbnpU7Hv7Y/fbjfcmApwo39alL90vyvR639d3
         rF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJQIuvj9hZOV2/MczNgBpv+PjMBSGnGqbFntPtlryTc=;
        b=Swr5Jy+tDnFZm6qSb/mj3qBiNTN80j8GnqZVwwjVTJ1RguFyFUCde4CneMN5e3iHA3
         LKrOpFAx1VVpUxdgL+omgsBJ4XLsiiag+R9x8KmsbMgob8bAZkdbD0OZi80m1ZEkD4q7
         mnKactOTZLrtYQDkg1SC0M5axUGR5Duq4pK8Z018jisc0uNkdNkcGGpyit3iMwUxsNGD
         aB2MAfjDATSR3ve3rWxFJTrvjCnXqZQYaAHWKj3RpKtjLWUX+l6LHdClON7/jghmNca7
         WIFt14afDmAsF8kHRMC2YZniNooCga7OiAKv5FcUJANg2qRLp+57mYku1ctLdkNHdZMH
         zgog==
X-Gm-Message-State: AOAM533BYfm648rKhsDuvZy1OqLziac7shEmRftZM6jmzl+lMw6pmIbj
        2klORdOyc3rs54AQoKpCfOarPEhrD0sNUBi+CSCSQQ==
X-Google-Smtp-Source: ABdhPJxL9m3hu+gflkPPsOXKEZYqNST0IhizJLaYKD0fyzC6vjIJ5drVkOqyZIE344+H+owbjEyqeiR6bgDWmtklbFo=
X-Received: by 2002:a05:6512:4014:: with SMTP id br20mr4069029lfb.233.1642775564685;
 Fri, 21 Jan 2022 06:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20220119120006.1426964-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220119120006.1426964-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jan 2022 15:32:08 +0100
Message-ID: <CAPDyKFqp4GPyT+OcVQcFYoE4F1izP_g82nhUqe+yvtZjTYUVyQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sh_mmcif: Check for null res pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 13:00, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> If there is no suitable resource, platform_get_resource() will return
> NULL.
> Therefore in order to avoid the dereference of the NULL pointer, it
> should be better to check the 'res'.
>
> Fixes: df0cc57e057f ("Linux 5.16")

I have changed this to:
Cc: stable@vger.kernel.org # v5.16+

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changelog
>
> v1 -> v2
>
> * Change 1. Change the fixes tag to v5.16.
> ---
>  drivers/mmc/host/sh_mmcif.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index e5e457037235..45dfa3b0be9c 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -405,6 +405,9 @@ static int sh_mmcif_dma_slave_config(struct sh_mmcif_host *host,
>         struct dma_slave_config cfg = { 0, };
>
>         res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
>         cfg.direction = direction;
>
>         if (direction == DMA_DEV_TO_MEM) {
> --
> 2.25.1
>
