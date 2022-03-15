Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3374D9339
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbiCOEQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCOEQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:16:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148693D1C6;
        Mon, 14 Mar 2022 21:15:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h14so30799090lfk.11;
        Mon, 14 Mar 2022 21:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MX+6thpdmH9Fmh6G8WI/hYT23j8vgEmJnH4dIzx5fhI=;
        b=VYtL8vemdJkuH/Vis/B8Rof9Cp3UWDhYCJj/PVdFco+0KeaZ8btcr5zxL/DxWpUOOZ
         nuUiJMoTnqiAIb5l1ZywONQgyQF2U3KUwkYHZAL2y3JpWG+bsocGuEY/cHWxkwn2SBSc
         fcZ0ZL38lizuWMJjn9Vzp7a9bZt414Nn26+BD+F5xBTzfwsgW2t6tFPDuO7A+F32ATHi
         Ooytl5VhT02NLwbgaduZySpG0XfqkxTA4dCo6LuKypk5jZGHX2ENR5ReRTWpAiXwS9KJ
         OPPxH09ZwYSCbUGLeKXJxThPoNkXkDPdKzDUFpHs1Dj9d03WONUwopdi+dgAZVpbsxLc
         8MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MX+6thpdmH9Fmh6G8WI/hYT23j8vgEmJnH4dIzx5fhI=;
        b=giio+/I44tZBP11iJHy+ybzt7Tp76ZHwNhkIH++ujg0QUt7wgUrKRToSNdAb3BrYVt
         AMMJw9gb0D0IHIOhUd7Ot8yO+oXYvoDOGOrKVpKZriBNJVgTJ/DuFDF4YewPtYgXkt+T
         qTsR+mF6Jmpe/oPcaqmS5i9rKyGV1rRltm0vYj5TzEJsvjy9fHXBazCSkmrBCPMcvIG+
         t+AGFvnFFT7+ySo/qY9iXLGBIQJdaYo8BPii/pzE+LG/VHk0mHN7mSlvkxhgnjnG452Y
         v0LkekIjhi+3eGSfFAqLe8qVpMGwuAh1Bm6tf2h3C+qByyINxWEXuYrLGVWW/rhy7wa7
         L8UQ==
X-Gm-Message-State: AOAM531AR2xIBt/uD4XJllE6I6cITTFin+Hckez1mIfnfTQPnWZImJSw
        l02PjQxH8jbaKHAvmbRgnLFZxnEtI3dyebQgJtOs3C87vC8=
X-Google-Smtp-Source: ABdhPJz37KwMUSCRY+zf4rBXiMdU8hH8Ijn8GNbH3cY07jiXP3+drPZ9RfdPXYk9LDPnv/CO8u6fcDfxk+ak4Ncq8+0=
X-Received: by 2002:a19:490f:0:b0:448:4bf8:6084 with SMTP id
 w15-20020a19490f000000b004484bf86084mr14810015lfa.537.1647317731326; Mon, 14
 Mar 2022 21:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220312102705.71413-1-Julia.Lawall@inria.fr> <20220312102705.71413-2-Julia.Lawall@inria.fr>
In-Reply-To: <20220312102705.71413-2-Julia.Lawall@inria.fr>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 14 Mar 2022 23:15:20 -0500
Message-ID: <CAH2r5mtD3=BiSDE4pLMpsc708dkP43hXosdyorfENawV9ura9g@mail.gmail.com>
Subject: Re: [PATCH 1/6] cifs: use kzalloc
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which tree should this be merged from?  cifs-2.6.git for-next ... or
do you prefer that these all go together through a different tree

On Sun, Mar 13, 2022 at 11:36 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Use kzalloc instead of kmalloc + memset.
>
> The semantic patch that makes this change is:
> (https://coccinelle.gitlabpages.inria.fr/website/)
>
> //<smpl>
> @@
> expression res, size, flag;
> @@
> - res = kmalloc(size, flag);
> + res = kzalloc(size, flag);
>   ...
> - memset(res, 0, size);
> //</smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  fs/cifs/transport.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index eeb1a699bd6f..4ff8e165a180 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -464,13 +464,12 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
>                 return -EIO;
>         }
>
> -       tr_hdr = kmalloc(sizeof(*tr_hdr), GFP_NOFS);
> +       tr_hdr = kzalloc(sizeof(*tr_hdr), GFP_NOFS);
>         if (!tr_hdr)
>                 return -ENOMEM;
>
>         memset(&cur_rqst[0], 0, sizeof(cur_rqst));
>         memset(&iov, 0, sizeof(iov));
> -       memset(tr_hdr, 0, sizeof(*tr_hdr));
>
>         iov.iov_base = tr_hdr;
>         iov.iov_len = sizeof(*tr_hdr);
>


-- 
Thanks,

Steve
