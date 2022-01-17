Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC44909E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiAQOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:02:11 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:36370 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiAQOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:02:10 -0500
Received: by mail-qt1-f174.google.com with SMTP id c19so19241877qtx.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QRx22hVTpWNuhkrYGZ7CDOh8Y4c3T4FUaJHNtJ9xko=;
        b=uRy+y3CDyoh09gkVC4w9oyN5TpuquUMaveWeX3Y5xNk+nkbjTSt0lMc0DNJL0dcCTh
         udiLAUSjp5W49UwPMgws4numk3Mhta8ZQPSZIjGYrKUibgWakciPY9iUguSbkmU51I/e
         xxT73aJkM/Lg4FbelPgfFvq+63sEXiCEUM0jYxQpWitfIAXlP7MmmJLGQgKs/1a94fln
         GjcbG91IwM88zrYbr6do/lPaK2riCaDnEyzmfznKGCPpNMe8xiu50/1uyGHDwfkM09SP
         +jeQXvp6iYftlAfzWCIlrMSDJWeac7++l/PH8eQsYPGsnWqSM2XGc3fJv5dyYesqMgiI
         XhTQ==
X-Gm-Message-State: AOAM5313jVzkaJERZYPfts8R7dr7n1ElN8JaB1ijNSJsHGdYPqieicaD
        rXbZ+TuqEB0LPXxQQLPYoAWolxtSBidFVyki2dPhklT6
X-Google-Smtp-Source: ABdhPJyHFuUFItOyXZ4vJMv1xBfwgk3TBsfAWgXcXtNsvd3HFIu/y5SOcQEfhCKhxad9mRvFjcOfd/DQlzeBvV5/IGE=
X-Received: by 2002:a05:622a:118b:: with SMTP id m11mr3119641qtk.369.1642428129276;
 Mon, 17 Jan 2022 06:02:09 -0800 (PST)
MIME-Version: 1.0
References: <1642417623-5393-1-git-send-email-lyz_cs@pku.edu.cn>
In-Reply-To: <1642417623-5393-1-git-send-email-lyz_cs@pku.edu.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jan 2022 15:01:54 +0100
Message-ID: <CAJZ5v0heMSa82qSVrrjrv2ioz5y-18rCKThjbPBACJ6xuXQQQg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Add missing pm_runtime_put_noidle
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:08 PM Yongzhi Liu <lyz_cs@pku.edu.cn> wrote:
>
> pm_runtime_get_noresume() in device_shutdown increments the
> runtime PM usage counter,

This is on purpose, to prevent devices from being runtime-suspended
after their shutdown callbacks have run.

> thus a matching decrement is needed

No, it is not, AFAICS.

> to keep the counter balanced.
>
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  drivers/base/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index fd034d7..29950bd 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4523,6 +4523,8 @@ void device_shutdown(void)
>                         dev->driver->shutdown(dev);
>                 }
>
> +               pm_runtime_put_noidle(dev);
> +
>                 device_unlock(dev);
>                 if (parent)
>                         device_unlock(parent);
> --
> 2.7.4
>
