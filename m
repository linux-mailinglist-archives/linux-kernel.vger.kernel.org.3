Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767384E6E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354777AbiCYHAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiCYHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:00:00 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CE535DED;
        Thu, 24 Mar 2022 23:58:25 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id w189so3755972vke.10;
        Thu, 24 Mar 2022 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bZQjBiTCWibkRDP7e4BTH2l7xdqhYCGD2WZveNtlQNY=;
        b=qNO1EB3ivsl79XhRFIYQFVbfyN/Gc9nWCh3/WvbAdUtfCY9pxrPkjKGrZLec5wXd8e
         AB9ycniZgHSF+sfW2BFLR8847waNpRCgKia2kqXx0DKQCdpWbrcchMShM5yBGWdyjLw0
         zhBIcKxfNcU5JpxG/OFXGB+2yrGK2BQIs7DYqWCOzzDdC7CPIsw5ArXX861JQo6QRyVT
         PejoSgM02fSUg4CA/gTQGq6xm/kdPyJp7CyVkc5MoloR05WRQkGqJ21ykwh0ck4nQa+n
         mCqrRw908pMbGtT5cbIQO+o5RItxHGxmvwvIGCxjRqQcfvfXlUttMtrgz9P46UPoplKw
         gRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bZQjBiTCWibkRDP7e4BTH2l7xdqhYCGD2WZveNtlQNY=;
        b=TusMgOC/XC/BUC76rXptUD+J1RyZxyFuBRsyRgPsrqWwfyjoJ5e4+76meWvQ3U0Mp+
         4uvSzUpqLyYy0YMwmA1BXEZoErlg6Px52GVgKzQXd2+lz3iCryrN+UPN9c8JUGulqJpq
         1kWOS0Iw6aklBCwHcJtXaVUiP7dn2VOZKjDQPKbvYke3OP/fXtFrfs1faabfl0p3rxKm
         nJYphy9CDA2xPFQ8wIdkxfFvNKEayyqdCAd0i24HhRAYVCOWhlS6woS9rA7zKGZlHpxf
         I2+GLrdoRElkKpxaZk5/Hsbn9Y4y8Al0kkbIRk+GXosJbXMzH92vOJZXzXWxp/ZOyV/W
         +gbA==
X-Gm-Message-State: AOAM530UkfEf9BxZ7YU6q8tHjuTR059KEEfyuk8nBan0d57Jd796X/n4
        hb5QUMPNrFejResuxJ4LPS4WeWdZ+rX4jumUoo1q+kvqssc=
X-Google-Smtp-Source: ABdhPJxMtjRqxgyytDOkIzCPeFWfNw6IFKXnJmecl8iaw6rO8VmfvUP268d+qLGxOyDDChQeggSRaiDld12/O67kuTA=
X-Received: by 2002:a05:6122:1311:b0:338:39b4:2cf5 with SMTP id
 e17-20020a056122131100b0033839b42cf5mr4441424vkp.9.1648191504736; Thu, 24 Mar
 2022 23:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220324071301.60228-1-jakobkoschel@gmail.com>
In-Reply-To: <20220324071301.60228-1-jakobkoschel@gmail.com>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Fri, 25 Mar 2022 15:58:13 +0900
Message-ID: <CANFS6banUM8ycVyjTz2rHQCbNFttX6HkDHo-2eEwAei9XEu1XQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: replace usage of found with dedicated list
 iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

2022=EB=85=84 3=EC=9B=94 24=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 4:13, J=
akob Koschel <jakobkoschel@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXP=
wr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  fs/ksmbd/smb2pdu.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 67e8e28e3fc3..be9606b9a944 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -6618,8 +6618,7 @@ int smb2_cancel(struct ksmbd_work *work)
>         struct ksmbd_conn *conn =3D work->conn;
>         struct smb2_hdr *hdr =3D smb2_get_msg(work->request_buf);
>         struct smb2_hdr *chdr;
> -       struct ksmbd_work *cancel_work =3D NULL;
> -       int canceled =3D 0;
> +       struct ksmbd_work *cancel_work =3D NULL, *iter;
>         struct list_head *command_list;
>
>         ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%=
x\n",
> @@ -6629,11 +6628,11 @@ int smb2_cancel(struct ksmbd_work *work)
>                 command_list =3D &conn->async_requests;
>
>                 spin_lock(&conn->request_lock);
> -               list_for_each_entry(cancel_work, command_list,
> +               list_for_each_entry(iter, command_list,
>                                     async_request_entry) {
> -                       chdr =3D smb2_get_msg(cancel_work->request_buf);
> +                       chdr =3D smb2_get_msg(iter->request_buf);
>
> -                       if (cancel_work->async_id !=3D
> +                       if (iter->async_id !=3D
>                             le64_to_cpu(hdr->Id.AsyncId))
>                                 continue;
>
> @@ -6641,7 +6640,7 @@ int smb2_cancel(struct ksmbd_work *work)
>                                     "smb2 with AsyncId %llu cancelled com=
mand =3D 0x%x\n",
>                                     le64_to_cpu(hdr->Id.AsyncId),
>                                     le16_to_cpu(chdr->Command));
> -                       canceled =3D 1;
> +                       cancel_work =3D iter;
>                         break;
>                 }
>                 spin_unlock(&conn->request_lock);
> @@ -6649,24 +6648,24 @@ int smb2_cancel(struct ksmbd_work *work)
>                 command_list =3D &conn->requests;
>
>                 spin_lock(&conn->request_lock);
> -               list_for_each_entry(cancel_work, command_list, request_en=
try) {
> -                       chdr =3D smb2_get_msg(cancel_work->request_buf);
> +               list_for_each_entry(iter, command_list, request_entry) {
> +                       chdr =3D smb2_get_msg(iter->request_buf);
>
>                         if (chdr->MessageId !=3D hdr->MessageId ||
> -                           cancel_work =3D=3D work)
> +                           iter =3D=3D work)
>                                 continue;
>
>                         ksmbd_debug(SMB,
>                                     "smb2 with mid %llu cancelled command=
 =3D 0x%x\n",
>                                     le64_to_cpu(hdr->MessageId),
>                                     le16_to_cpu(chdr->Command));
> -                       canceled =3D 1;
> +                       cancel_work =3D iter;
>                         break;
>                 }
>                 spin_unlock(&conn->request_lock);
>         }
>
> -       if (canceled) {
> +       if (cancel_work) {
>                 cancel_work->state =3D KSMBD_WORK_CANCELLED;
>                 if (cancel_work->cancel_fn)
>                         cancel_work->cancel_fn(cancel_work->cancel_argv);
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> --
> 2.25.1
>


--
Thanks,
Hyunchul
