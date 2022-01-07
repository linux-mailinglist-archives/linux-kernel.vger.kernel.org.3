Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0704870A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbiAGCk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:40:58 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:42830 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345521AbiAGCk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:40:57 -0500
Received: by mail-qt1-f171.google.com with SMTP id y17so4244983qtx.9;
        Thu, 06 Jan 2022 18:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3oveBvk/TJ7E2R11hx57UheCl6wg4a+PXG4wzrlHrU=;
        b=hjn9/K5rvc2Ha8WtWuYlzdDB7rXIUES/BGuCsw0Ze5c+xf0aDS3rCT2xdXH3UoDQz/
         AnSMDlqbeevPSznDd/95ZyRDwjK3baP/wYgOtFk50XcnG+3X3SDmKveq23gP4IfpzZ/7
         ELJpzEiqPtaLqC74AXP7JliExKdjamqeCpncKW06kpylkMSAiJo8NTmYvj8JXpLPMRjR
         riALwYWbMiBwz8j1zx5sieDDmTHV9iB9ggaJmYzcnhWKjxx/q+aujbWaHVNJp3gBJ8b1
         R/n8BCaqzaj3A2AThqQt/RP637blJL61XYjApzWyGYscWGQPHJENqxnwej3sn7k8tb6b
         a1aw==
X-Gm-Message-State: AOAM531j4zr/iupMDBZjWlZFATmZ4SmREUyPnkyf5rKVYYHIGdlT9WKM
        zE9FhoESzs3GPuJVUV6vYdQVUN1nhlg5Fw==
X-Google-Smtp-Source: ABdhPJy+98KZMdgRomHIl0wQjDyz6kJktgoGwWe6gB9SvpeCcSM2U5jMQWiwUSwgG06T1v5aP3Xh3g==
X-Received: by 2002:a05:622a:11c3:: with SMTP id n3mr53518144qtk.213.1641523256268;
        Thu, 06 Jan 2022 18:40:56 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id p16sm2904028qtx.19.2022.01.06.18.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 18:40:56 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id f17so1756295qtf.8;
        Thu, 06 Jan 2022 18:40:55 -0800 (PST)
X-Received: by 2002:ac8:4e85:: with SMTP id 5mr54938490qtp.416.1641523255287;
 Thu, 06 Jan 2022 18:40:55 -0800 (PST)
MIME-Version: 1.0
References: <1063e5a4738d897adcaffce2ab8e4e45f07998ff.1635969326.git.christophe.jaillet@wanadoo.fr>
 <4890990418ecbcfb8921efe8adb2019a03e5a1c1.1635969326.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4890990418ecbcfb8921efe8adb2019a03e5a1c1.1635969326.git.christophe.jaillet@wanadoo.fr>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 7 Jan 2022 10:40:43 +0800
X-Gmail-Original-Message-ID: <CADRPPNTRE9sUX-4XxvtoQkGqOXzBPm_1h-FRSRepWsxdFz3Tvg@mail.gmail.com>
Message-ID: <CADRPPNTRE9sUX-4XxvtoQkGqOXzBPm_1h-FRSRepWsxdFz3Tvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: fsl: guts: Add a missing memory allocation
 failure check
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     tyreld@linux.ibm.com, kernel-janitors@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 4:10 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If 'devm_kstrdup()' fails, we should return -ENOMEM.
>
> While at it, move the 'of_node_put()' call in the error handling path and
> after the 'machine' has been copied.
> Better safe than sorry.
>
> Suggested-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied with Fixes tag and Depends-on tag added.  Thanks.

> ---
> Not sure of which Fixes tag to add. Should be a6fc3b698130, but since
> another commit needs to be reverted for this patch to make sense, I'm
> unsure of what to do. :(
> So, none is given.
> ---
>  drivers/soc/fsl/guts.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index af7741eafc57..5ed2fc1c53a0 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -158,9 +158,14 @@ static int fsl_guts_probe(struct platform_device *pdev)
>         root = of_find_node_by_path("/");
>         if (of_property_read_string(root, "model", &machine))
>                 of_property_read_string_index(root, "compatible", 0, &machine);
> -       of_node_put(root);
> -       if (machine)
> +       if (machine) {
>                 soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
> +               if (!soc_dev_attr.machine) {
> +                       of_node_put(root);
> +                       return -ENOMEM;
> +               }
> +       }
> +       of_node_put(root);
>
>         svr = fsl_guts_get_svr();
>         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> --
> 2.30.2
>
