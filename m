Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC387474E69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhLNXC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhLNXCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:02:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7250CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:02:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z9so13427096edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rn/GT7DgBbk/oW4rJC6hy7Ss/nDkJtDZDhoaw9Zw4iw=;
        b=Wjdowxc4SEQi/KdHC722G96ed2+b8aJ33YzjtT0PxB3ueqGAuvTHpRnyvvkDLwgwPt
         Q2iL7hhHhr34shhZO7Dob4M+sg+HOO0iU1kK/xl7nC1TkjddiSD2ZAKihyBcTrZkCYR+
         fuljFo47FIzwz4KOnx8POArO1LIbYunQGuflLvWpwRAppOPCx4WAoAlw5n8o19hD74V7
         xor2xVT/YA50NLy9PPV7tLyCn+nqe/sfVljhUiP6UoP+FyvlTAMUZTHvp+NiP0vKNM9R
         D0ZEb+Btq4+VMlGRAwrumG5aBl0Z+n9q/M46asMWNsT5FCqF0NJICY9zLFyUYZX8ceMA
         EePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rn/GT7DgBbk/oW4rJC6hy7Ss/nDkJtDZDhoaw9Zw4iw=;
        b=0WRJSvnKIovpv7FtxovvLqmji3VRK7nB/uf8p6rMaJaU/UnySZs6w/SXT6vuVLbFEQ
         qmvj09y23PL6QCOW3XJ+6wK5b08Z71KBcZvJn6bW7nPk/OBwU7BUNVUR3jmf+auUHZ/e
         L3QGhGeYjqQn5g8ka1V6rHOy3l3+Z176JNDowfs1yjMVU4HCjlmPMZNDUrrvazLvCFug
         x6g1Da7DPajUuVcUx7zEIM1OYAE0zjoS4QfU/JjiO2rGWE8xpexvmcBDTVSx2345qmsj
         jPH3uVpLDHGZOG0Gbla4Pw5n8hQPeFMvUWYcu4yZAesxf5QdYPdmHv+KhDGEwnDpLB9X
         u6JA==
X-Gm-Message-State: AOAM532aL20mhhep3mJBzVXT7DNOVUzU7czsqqKTbEHmDEhQKvJL0l/s
        bHtvNrVMByaiCsV45qHZjvT2bGcnonm23I47YM+AAA==
X-Google-Smtp-Source: ABdhPJyZzEXABB2jVKF7c+30I1OgLhDcmEEO6WPjfnmuxMXZu+L6pRvmmexrJotKJ33smKZItaGp0zyTMEguAYeW+2Q=
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr11354625edd.245.1639522972746;
 Tue, 14 Dec 2021 15:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20211209143501.GA3041@kili>
In-Reply-To: <20211209143501.GA3041@kili>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 14 Dec 2021 15:02:41 -0800
Message-ID: <CABXOdTcny657JOxK-iau2Sj06a5hcDOdWFg8wKUNupgAceUU9w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: fix read overflow in cros_ec_lpc_readmem()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Bill Richardson <wfrichar@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Dec 9, 2021 at 6:35 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> If bytes is larger than EC_MEMMAP_SIZE (255) then "EC_MEMMAP_SIZE -
> bytes" is a very high unsigned value and basically offset is
> accepted.  The second problem is that it uses >= instead of > so this
> means that we are not able to read the very last byte.
>
> Fixes: ec2f33ab582b ("platform/chrome: Add cros_ec_lpc driver for x86 devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index d6306d2a096f..7e1d175def9f 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -290,7 +290,8 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
>         char *s = dest;
>         int cnt = 0;
>
> -       if (offset >= EC_MEMMAP_SIZE - bytes)
> +       if (offset > EC_MEMMAP_SIZE ||
> +           bytes > EC_MEMMAP_SIZE - offset)

I think that means we have the same problem if offset >
EC_MEMMAP_SIZE, only now that condition isn't detected anymore because
EC_MEMMAP_SIZE - offset is a very large number.
I think what we really want is
        if (offset + bytes > EC_MEMMAP_SIZE)
only without the overflow. Not sure how we can get there without
checking each part.
        if (offset > EC_MEMMAP_SIZE || bytes > EC_MEMMAP_SIZE || bytes
+ offset > EC_MEMMAP_SIZE)
                return -EINVAL;
Maybe that ?
        if ((u64) offset + bytes > EC_MEMMAP_SIZE)
                return -EINVAL;

Thanks,
Guenter

>                 return -EINVAL;
>
>         /* fixed length */
> --
> 2.20.1
>
