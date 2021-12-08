Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852AD46CC95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbhLHEg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbhLHEgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:36:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF74C061574;
        Tue,  7 Dec 2021 20:33:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bi37so3066607lfb.5;
        Tue, 07 Dec 2021 20:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EN1o8XpoKN4as2yUaOYdrp8Cti7k7n7wDJbtCFFci+Y=;
        b=lzk6Ja0MRaTF0ii1RSV3qpELQCzRZ2oDBAf+jsOusYOmESpT5SRM9S8Jyg6NSP9xgI
         ifjeG5Zs1YF+A6Xp2qkVaN36SIzfuOo9wfXseZt42E6Wasnu1Rc99acbnndCpuYWAGat
         dtny7bZZ8z+x4PJubJQy1S/B/dtf9wOHSS3MFT/bskThLk2EHJfoGnLuYtlpIUxyFCQW
         P1dv3UwwoPGIuhnggYWQ1/ZMZs8J6nSCA0DwYvtT8R90GSK4ak1yGa27F9BqmEKKC+ER
         JpRB1E53P2f97NcLueqUpt98tZWAHZCZIvb8Hu9c1BH1B4CXCRWhJIjbp1n2rmuc/1XH
         SK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EN1o8XpoKN4as2yUaOYdrp8Cti7k7n7wDJbtCFFci+Y=;
        b=aXd5dDqSM1gqGsTan/GJWg/H2mxquVu/gQ/yzrNVs4fx0Ptwadox9WNuKzo0IyjUFf
         ZkxGlX6nbztP4ig1vYx/z7xyXR+8N38YqB6Bx15ebJZCch1LC9aEuxf1PMI8qjpMpord
         gLNmTdNxkAObFvUPCngKOOa6TTNCfmBZEQKw7dDMpnw/q9RLb5LELJOi7itTUZ3vsXu1
         jBRgPT2E8q2w30pcUWWZUTEC2hu0tai+Q9YL0TzorZB1jyJk6x7NLPQA5mtz7qb5GnVE
         aNX5tVu7Artfv962Unl2Vt9smB/v9h0RplhOQENZAAND9d/+fM74WCS7LAFK+J1jKC7b
         i8lw==
X-Gm-Message-State: AOAM533YOPkMyYkFqbu6wChwMEGY3MjK+IxDysP5y3EfIWq4Wr7/BTju
        rXuFbfDf6vsobzR2T/Xu0TpNEwFd7hhcr5eICew=
X-Google-Smtp-Source: ABdhPJwIdiWlGyg9QKfiqlNkmB52N2pXz78n6hNt6wd/g8Q34QRsZhd+Zv1DyXbdwQWK8+nGuCI+uiTucfKvH8IFsow=
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr45568787lfu.545.1638938002185;
 Tue, 07 Dec 2021 20:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20211207115420.18713-1-vincent.whitchurch@axis.com>
In-Reply-To: <20211207115420.18713-1-vincent.whitchurch@axis.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 7 Dec 2021 22:33:10 -0600
Message-ID: <CAH2r5mtxkO9whCCKrFXMYNr26RcShx-QT4_EZvLJj52AkQjWqw@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix crash on unload of cifs_arc4.ko
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Steve French <sfrench@samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        kernel <kernel@axis.com>, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Tue, Dec 7, 2021 at 6:11 AM Vincent Whitchurch via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> The exit function is wrongly placed in the __init section and this leads
> to a crash when the module is unloaded.  Just remove both the init and
> exit functions since this module does not need them.
>
> Fixes: 71c02863246167b3d ("cifs: fork arc4 and create a separate module...")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  fs/smbfs_common/cifs_arc4.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/fs/smbfs_common/cifs_arc4.c b/fs/smbfs_common/cifs_arc4.c
> index 85ba15a60b13..043e4cb839fa 100644
> --- a/fs/smbfs_common/cifs_arc4.c
> +++ b/fs/smbfs_common/cifs_arc4.c
> @@ -72,16 +72,3 @@ void cifs_arc4_crypt(struct arc4_ctx *ctx, u8 *out, const u8 *in, unsigned int l
>         ctx->y = y;
>  }
>  EXPORT_SYMBOL_GPL(cifs_arc4_crypt);
> -
> -static int __init
> -init_smbfs_common(void)
> -{
> -       return 0;
> -}
> -static void __init
> -exit_smbfs_common(void)
> -{
> -}
> -
> -module_init(init_smbfs_common)
> -module_exit(exit_smbfs_common)
> --
> 2.33.1
>
>


-- 
Thanks,

Steve
