Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5D4E4928
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiCVW3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiCVW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:29:33 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E3048E49;
        Tue, 22 Mar 2022 15:28:04 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id g21so20648760vsp.6;
        Tue, 22 Mar 2022 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HjP+WYgkuquMP9HLNm0D3kb+9NTb8P2x7yQwd4RNgpQ=;
        b=aH3Em2Ln7Yyh931WTdExYFWl/LYNVEPDi2+0dPgdzm8nrlyrNGgYU6uiYnJHMg1OcI
         zzlWkhTVpGKj7MKenfW0CQVLGGCqIzE08ozETz/ruaR8RdPsabJzPK1VJrxzcwzKXb8q
         5zh1I5Ufw0j/KhViKfNfAYx2sPcQJy2Z74wX7iMFnR/TY+qayywwWnI+jmk3nU7B7RWG
         0XCxHBZ3DfC0xrTJ0JP565aQJ8lt2TuShs8wdf8IusCQ4wQe3BzHehCq9MnXD0pEvXXx
         viPERF716BvAe2iuwhRFFJDg0ZRC/W1fTeuFd+ROFz5C1YMnu+ntnaDd6uSWLoKRUhI1
         EfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HjP+WYgkuquMP9HLNm0D3kb+9NTb8P2x7yQwd4RNgpQ=;
        b=LfW17BYBXKpum6kTD8U0KvBR5yVoVieAh/3GC9ccrUgaHnw/74bJNIg/Fyu8hpzHxR
         MQ17RWEhcZdo1SgrFFTSq6mxggQVzvMeWGC3QE/SLxRlG9mI1aTynwcJw3srI6cdZrbW
         xEHiznau9dlTqNhWHpVxL9wGsdcVXUYPL+qSGrcjfaBKVFcPYx4OJfXTHPpjyxdZz2lC
         Jt58mujCFTD5sgRr2JALDj6vrxwH+/+wAfYMkNaM8M7Gf4HCscBurT7cjwNkKsoNisk2
         Bi1Gdg9vKfh1ZopELEJG1hB3hVkNlbwpGWOpxvYT3Yg6XmNHNjfn2tBhnjB9ytyPxDAF
         6Rgg==
X-Gm-Message-State: AOAM530v3cBcvL36WgzI8uvWs2rR6DE28Whh1p6m4BxFQllcqJKq6RYN
        Svt5bJGTzP/aVByQFuIkhcGSq0+zYvtGJt3gwf0=
X-Google-Smtp-Source: ABdhPJxavs/AEHRq5EzJNKwgi55bRPwWQ4fu9Cx2wzgWmN9Ra3rM6mqBRbogaT7+kB58XPj3D8U2s3nmDbUhuxLxmtc=
X-Received: by 2002:a05:6102:83c:b0:324:e435:eb01 with SMTP id
 k28-20020a056102083c00b00324e435eb01mr8046903vsb.13.1647988083767; Tue, 22
 Mar 2022 15:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Wed, 23 Mar 2022 07:27:52 +0900
Message-ID: <CANFS6bZGXA_9eMo=Wv=H6BG4kt5-mKuK8A=m-P3VqKKxamnK2w@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Remove a redundant zeroing of memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Hyunchul Lee <hyc.lee@gmail.com>

2022=EB=85=84 3=EC=9B=94 23=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 5:29, C=
hristophe JAILLET
<christophe.jaillet@wanadoo.fr>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> fill_transform_hdr() already call memset(0) on its 1st argument, so there
> is no need to clear it explicitly before calling this function.
>
> Use kmalloc() instead of kzalloc() to save a few cycles.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Alternatively, fill_transform_hdr() has only one caller. So its memset()
> could be removed instead and this kzalloc() left as is.
> ---
>  fs/ksmbd/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index bcb98109bac9..0e4f819e5859 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -8434,7 +8434,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
>         if (ARRAY_SIZE(iov) < rq_nvec)
>                 return -ENOMEM;
>
> -       work->tr_buf =3D kzalloc(sizeof(struct smb2_transform_hdr) + 4, G=
FP_KERNEL);
> +       work->tr_buf =3D kmalloc(sizeof(struct smb2_transform_hdr) + 4, G=
FP_KERNEL);
>         if (!work->tr_buf)
>                 return rc;
>
> --
> 2.32.0
>


--=20
Thanks,
Hyunchul
