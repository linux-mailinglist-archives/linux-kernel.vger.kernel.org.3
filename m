Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5246E621
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhLIKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhLIKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:09:34 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04DC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:06:00 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u22so8145130lju.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w36fp1nUxLNl01gIZrbdm3X2NLGN2590MhIP+OlhOPY=;
        b=P+s6ehTWyDJ/VhvvBz9FH0Jb2SfO1d7AWBgutJqjwi8kvIbRuYZerRq3vyjvJ/8EgK
         nVr5DU9J62WfntH2uh8GKg9lnivmw4eRH19gm14YY3mF/lBrQqld9C19nchREebN3o2q
         L5PFZbr3Rs21rATPDQrZesAMbDOdnjINomyDiGssQ/esn7SfD7pM4fyIL8HbL+x1r8s5
         L05UDEvzCpoEpy66CKczh8uAEQKMdz6qL+zFlw+lLwV8C/TeW0PeYq91fpAk5ImAU3q+
         6KZu0pYdAP+gPE0t1BjQB9An5x417PIIENIN9Jke6qBnMFhOqUSOyziC+6C8y7L0nJ3V
         NC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w36fp1nUxLNl01gIZrbdm3X2NLGN2590MhIP+OlhOPY=;
        b=NqyR89bHq0XXaaAVVm7hOX7cizcZ/8Ycx4E3z3sOp0TpLUh4pBeg7eACBQP9z0chQG
         ZiByx71SRKcLGzwioIoJr4ng2RlngnvSIJxj5AaDeVcIgVb5hwkqZ71Mpio3Dr27qXDa
         g85jMqgjZ7rpTPJIQ0Bui/f/h4LfwFuucXVnzR3VWd6azTDmbyNh7SiLdQW6nypuRSNS
         0EzwBFM2LH/I1PhwVis/UAm1DJhrwDVtDMlYt1uzZAwjVwJcwvIGVZSiDW7RYkMKl56t
         F/KBGcCE2u/Nph1/fE587C+R4Qv+FXtf0476YvGRjS3S5nYtuvWV89Wi2s1vuXF0f5HH
         b83w==
X-Gm-Message-State: AOAM530vmUmYzi3EH4gEAuMeacXyjhqLyVeaAbrwTjXrttIaseAgxRMJ
        CpvW3gTYqJ1aMXY/D22pZFV9GfbVKeFhcQbo3THJUxN7a+k=
X-Google-Smtp-Source: ABdhPJxPQvjGNEWf0th0e18SCo+paR5oLM6Uhr+HHuOyleEObMRBh/ntqrQ6aUCjP1j7HkeQmAZEgS5QzD5nnnOLeHY=
X-Received: by 2002:a2e:93c4:: with SMTP id p4mr5261242ljh.367.1639044359013;
 Thu, 09 Dec 2021 02:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20211206115218.73874-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211206115218.73874-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 11:05:22 +0100
Message-ID: <CAPDyKFp6bfCR=GXpT_JO95nek_QKFgvwDFtETKLkvhi8QA_wxQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: mmc_spi: Convert 'multiple' to be boolean in mmc_spi_data_do()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 12:52, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Convert 'multiple' to be boolean in mmc_spi_data_do() since
> it's initially being used as boolean.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index b431cdd27353..4b0f9035ad29 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -547,7 +547,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
>  static void
>  mmc_spi_setup_data_message(
>         struct mmc_spi_host     *host,
> -       int                     multiple,
> +       bool                    multiple,
>         enum dma_data_direction direction)
>  {
>         struct spi_transfer     *t;
> @@ -862,7 +862,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>         enum dma_data_direction direction;
>         struct scatterlist      *sg;
>         unsigned                n_sg;
> -       int                     multiple = (data->blocks > 1);
> +       bool                    multiple = (data->blocks > 1);
>         u32                     clock_rate;
>         unsigned long           timeout;
>
> --
> 2.33.0
>
