Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E37448704A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbiAGCWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:22:30 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33607 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbiAGCW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:22:29 -0500
Received: by mail-qk1-f170.google.com with SMTP id de30so4660967qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ozs941wKBNQg3LxRfsqbP6OaMzoQiK3QsZ3gg9gac/I=;
        b=gVle5U3uroiVNOrc//pSaayI2TrK4rt+PcvXJlgZKzuJrLvJy06nhrOvr0Fo8ds9o9
         XVE6CfGc7Ja4TTNbicaELjh9KaUL33VJij7TpXM5W7D5ZsO303mJlEQsUMsI68jTKXjc
         Hi65M9tcBLdw8MW0hCjAQfEk0cBYaTEucKKVZ831ITdMyVLDLkKl+kQGr+PuZkhLBqdb
         wvPwpWxpoEfWae5USKE0DPJVFC+fvOrXNX2gFnv8Ar85W2mJIQSSHeD1x25GWQGnU4Fb
         SyvHET1amqL1SPRRYXwufyYVokYKIcMgqF1Xu79MK70GH1c7sPKHY18iU3zXOEOXDeog
         0Jbw==
X-Gm-Message-State: AOAM531lRdfoY+iKpzhZ0jMIF5kl6NLnrj13o3LkXH7qkHwl20pgfZ6A
        /bhHVOtU3uJzCa4T2fNGFPkvfLDIb+g8Ycf9
X-Google-Smtp-Source: ABdhPJwVTSNqkpnFR42PZcd6sbHrGIi3qTOhfcAnMm3VgYk2mm9CSdgpRUp3dHxDDiHj12ix+grAiQ==
X-Received: by 2002:a05:620a:4485:: with SMTP id x5mr42125706qkp.277.1641522148858;
        Thu, 06 Jan 2022 18:22:28 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id bs30sm2496214qkb.87.2022.01.06.18.22.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 18:22:28 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id kd9so4176042qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:22:27 -0800 (PST)
X-Received: by 2002:a05:6214:1d01:: with SMTP id e1mr4141088qvd.72.1641522147639;
 Thu, 06 Jan 2022 18:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20211230014543.1799867-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211230014543.1799867-1-jiasheng@iscas.ac.cn>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 7 Jan 2022 10:22:15 +0800
X-Gmail-Original-Message-ID: <CADRPPNSsLYzv6ueSqVu4b3yep7JYLJBJcNwbiBVG61ADyqaPBw@mail.gmail.com>
Message-ID: <CADRPPNSsLYzv6ueSqVu4b3yep7JYLJBJcNwbiBVG61ADyqaPBw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Check of ioremap return value
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Zhao Qiang <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 9:47 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the possible failure of the ioremap(), the par_io could be NULL.
> Therefore it should be better to check it and return error in order to
> guarantee the success of the initiation.
> But, I also notice that all the caller like mpc85xx_qe_par_io_init() in
> `arch/powerpc/platforms/85xx/common.c` don't check the return value of
> the par_io_init().
> Actually, par_io_init() needs to check to handle the potential error.
> I will submit another patch to fix that.
> Anyway, par_io_init() itsely should be fixed.
>
> Fixes: 7aa1aa6ecec2 ("QE: Move QE from arch/powerpc to drivers/soc")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/qe/qe_io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
> index e277c827bdf3..a5e2d0e5ab51 100644
> --- a/drivers/soc/fsl/qe/qe_io.c
> +++ b/drivers/soc/fsl/qe/qe_io.c
> @@ -35,6 +35,8 @@ int par_io_init(struct device_node *np)
>         if (ret)
>                 return ret;
>         par_io = ioremap(res.start, resource_size(&res));
> +       if (!par_io)
> +               return -ENOMEM;
>
>         if (!of_property_read_u32(np, "num-ports", &num_ports))
>                 num_par_io_ports = num_ports;
> --
> 2.25.1
>
