Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076B74A2AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbiA2Ax4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344788AbiA2Axy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:53:54 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790FAC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:53:54 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id k17so23412726ybk.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NbgrXX9sQyQqD1q4C3GFzViJjmAGZOetKlNWCOO/pM=;
        b=Pfp4YCdOr2yQOd7FkT/46L3gRqIdCB3FKGbQSWjL7Jv9HB3Vkq5bvUtqkeB2QHbz4U
         fGUrjjrO4mFrfIYqh2ojE7Ecp6dosiYuLt2HPhbu91qaINGyJw21WI6tP19we01sA6ic
         iq8s3U1FBnCbUL93EClwVm59wQTGmtG6K4e0WFUxfTs6/g1gsllVFA9DbRwjmntkUod1
         9z7Jfr371C0hVd48SzVYueHp8b5e/J7+cXwrwLfJaupCw2HvwkV4k5h/oI3E5mNhpXp/
         KEfY5k+asYhJkptKlz9fb6f1bKgHniRNOAX8/xFzGnaJ19EWB5CdF2p91f0wrul/kKTd
         u44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NbgrXX9sQyQqD1q4C3GFzViJjmAGZOetKlNWCOO/pM=;
        b=HO8XzK9UUzhOVYH270FSfpQf8iXVW4YwFlXLybfW+sBW8Ib2cTy6vplFUNgPtHgNgN
         gRWDe3XOtuQG+h9DtBtw2pwUIIc9aPqL29lVKQp5bHH6NAq4haSe3NYpm7M08hzGy4g5
         8CaGeJTq2gvJs1FsMxmYUMQ+uc3pA2LQ0ZhCTz1k4jzKg4NwROofgDS06M0kIz51hLIB
         v0TUMxakwyMpCgSPBtH+9O+eEECElXv2gRp8xmltxhSsJxLUaNVdmj6GTJau5+q7e4Yg
         Qy0K1sChjfwWYGyUZxvijPupNV30M43JBWFNFU65hPeliGVQe16R7mTILaK0/wDzit08
         pIVg==
X-Gm-Message-State: AOAM533sIw26Zgwaav/UBVrtfTf4tvphwIkg7qglTZFDHW9GYGRtSBPi
        SxNPLY4378B3DLigBe9Oqy1du+pVPUrBhox184EHgw==
X-Google-Smtp-Source: ABdhPJyc08fF90vzpDGv/xVPDhy6Iv5LyGya40KeDPPiy5sPSbVGKGf3NJKWnx3e5lOhPILw2YeoNY/sTNN3PVwtthE=
X-Received: by 2002:a05:6902:124a:: with SMTP id t10mr14882868ybu.634.1643417633741;
 Fri, 28 Jan 2022 16:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20220128173336.643-1-linmq006@gmail.com>
In-Reply-To: <20220128173336.643-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Jan 2022 01:53:42 +0100
Message-ID: <CACRpkdaTmWomZY6WgozTJKVMvTmesDRsLqhn5BP+QeaMoAA1VA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: Fix memory leak in ab8500_chargalg_sysfs_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 6:33 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()
>
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
>
> Fix this issue by adding kobject_put().
>
> Fixes: c5b64a990e7f ("power: supply: ab8500: Rename charging algorithm symbols")

Really? I think this code is older.

> @@ -1907,8 +1907,10 @@ static int ab8500_chargalg_sysfs_init(struct ab8500_chargalg *di)
>         ret = kobject_init_and_add(&di->chargalg_kobject,
>                 &ab8500_chargalg_ktype,
>                 NULL, "ab8500_chargalg");
> -       if (ret < 0)
> +       if (ret < 0) {
>                 dev_err(di->dev, "failed to create sysfs entry\n");
> +               kobject_put(&di->chargalg_kobject);
> +       }

I wouldn't bother with this.

This code is getting deleted in this patch:
https://lore.kernel.org/linux-pm/20220129004925.639684-10-linus.walleij@linaro.org/T/#u

Yours,
Linus Walleij
