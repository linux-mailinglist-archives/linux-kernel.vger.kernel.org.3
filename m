Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9C552BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346957AbiFUHNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346890AbiFUHNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:13:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5374011A08;
        Tue, 21 Jun 2022 00:13:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id pk21so2375978ejb.2;
        Tue, 21 Jun 2022 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aIA+1YSKl9xwh+U2jOA5P7gKHxbZ6zMzzGEJxc9zUpQ=;
        b=gw44OF7Rv5WwcyW2uRl5S9mv3PN3asE1qfIL+6ip5FO7uqHz9PcKBZFFX0aoetq713
         brFkBPLS6h1/RqUUac8/Vk8JJfrJuwO5mfQEEKS3nrf8LExZuGqjOxBU6Iu85Cr0r578
         u3Ts2oWxO1y/UFm8E1QgPMiYHu6il/JC4htTWmrPvOeKvMUxZMxBkgBJCFa183DNfy4O
         EwREmPnaIWjOaqSJqMtdzrwNg3BqZqK5VZDvdkIyVLLo8ZtCod+MAi0RDmJB5Hp5BOqW
         U7GfgZTna8g8jLS8Kak28/9/zp2S04T39Vv2qwIWsc5p/ycxcMlY2AI7cC2o3QkkUnBg
         rQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aIA+1YSKl9xwh+U2jOA5P7gKHxbZ6zMzzGEJxc9zUpQ=;
        b=vofpxo/C/MYXJRfW4bZxHZOEedB9/rojNZmxYPWTbtKOXF/m+weuC8s+B8nu0y0lRs
         /OFBg34cq89UV6aAE6yeo9z+QA5NNiLTVEITDdx+EjURiZuHpxCUXoxiaqS3Ta4Zbb1u
         QvGJqivBUljD1xBcGZ65T2sv6kUPRUNOkNbNd1H9/3bGeTUR6whzr/AJ1yZVHRagXi6h
         71wBMwTAmOxLVms4HmOTw4yjnGuDy4+Jg4u0Cy140B8ySSU6s+bGlgH0KSQ3quW0Phto
         j/u+zjtoy/VOZm30APZCkaLPw9Ct8zahRMle3gsn4q9t7F3AXvbdqeJi2B/btDHjrBny
         1Lww==
X-Gm-Message-State: AJIora/BQ/jMFsPyHxhGZ2i/OTKrFnX7NX62NFZqIzI1o7pQCKqWVIS+
        NdKoZTNc4Q18SQpBIbRRStrJLJN2kmcBaL+T7kVUndeTgOgfiXYB
X-Google-Smtp-Source: AGRyM1vVwEZRj74D/u4+iIayf3lq1ZmASOLg9o3Kp/fWePh/ZCc4vGcwKsevzboSlgJ+oyGILaPtM2tJUAaeSKpk0bI=
X-Received: by 2002:a17:907:3f88:b0:711:d5a6:105 with SMTP id
 hr8-20020a1709073f8800b00711d5a60105mr24734412ejc.727.1655795613765; Tue, 21
 Jun 2022 00:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220621070224.1231039-1-zhangshida@kylinos.cn>
In-Reply-To: <20220621070224.1231039-1-zhangshida@kylinos.cn>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Tue, 21 Jun 2022 15:12:57 +0800
Message-ID: <CANubcdVceGMyjKbBLyrWZ9jStjWOLgk8AT7_1UDkx8eEb9VgLw@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: add check before calling xfs_mod_fdblocks
To:     djwong@kernel.org, dchinner@redhat.com
Cc:     zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
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

Shida Zhang <starzhangzsd@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Checks are missing when delta equals 0 in __xfs_ag_resv_free() and
> __xfs_ag_resv_init().
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  Changes from v1:
>  -Add checks before calling xfs_mod_fdblocks instead.
>
>  fs/xfs/libxfs/xfs_ag_resv.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/fs/xfs/libxfs/xfs_ag_resv.c b/fs/xfs/libxfs/xfs_ag_resv.c
> index fe94058d4e9e..c8fa032e4b00 100644
> --- a/fs/xfs/libxfs/xfs_ag_resv.c
> +++ b/fs/xfs/libxfs/xfs_ag_resv.c
> @@ -149,7 +149,12 @@ __xfs_ag_resv_free(
>                 oldresv =3D resv->ar_orig_reserved;
>         else
>                 oldresv =3D resv->ar_reserved;
> -       error =3D xfs_mod_fdblocks(pag->pag_mount, oldresv, true);
> +
> +       if (oldresv)
> +               error =3D xfs_mod_fdblocks(pag->pag_mount, oldresv, true)=
;
> +       else
> +               error =3D 0;
> +
>         resv->ar_reserved =3D 0;
>         resv->ar_asked =3D 0;
>         resv->ar_orig_reserved =3D 0;
> @@ -215,8 +220,13 @@ __xfs_ag_resv_init(
>
>         if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_AG_RESV_FAIL))
>                 error =3D -ENOSPC;
> -       else
> -               error =3D xfs_mod_fdblocks(mp, -(int64_t)hidden_space, tr=
ue);
> +       else {
> +               error =3D 0;
> +               if (hidden_space)
> +                       error =3D xfs_mod_fdblocks(mp, -(int64_t)hidden_s=
pace,
> +                                               true);
> +       }
> +
>         if (error) {
>                 trace_xfs_ag_resv_init_error(pag->pag_mount, pag->pag_agn=
o,
>                                 error, _RET_IP_);
> --
> 2.25.1
>

And the code path that lead delta =3D 0 is shown below:

=3D> xfs_mod_freecounter+0x84/0x2b8
=3D> __xfs_ag_resv_free+0xc4/0x188
=3D> xfs_ag_resv_free+0x24/0x50
=3D> xfs_fs_unreserve_ag_blocks+0x40/0x160
=3D> xfs_mountfs+0x500/0x900
=3D> xfs_fs_fill_super+0x3d8/0x810
=3D> get_tree_bdev+0x164/0x258
=3D> xfs_fs_get_tree+0x20/0x30
=3D> vfs_get_tree+0x30/0xf8
=3D> path_mount+0x3c4/0xa58
=3D> do_mount+0x74/0x98

=3D> xfs_mod_freecounter+0x84/0x2b8
=3D> __xfs_ag_resv_init+0x64/0x1d0
=3D> xfs_ag_resv_init+0x108/0x1c8
=3D> xfs_fs_reserve_ag_blocks+0x4c/0x110
=3D> xfs_mountfs+0x57c/0x900
=3D> xfs_fs_fill_super+0x3d8/0x810
=3D> get_tree_bdev+0x164/0x258
=3D> xfs_fs_get_tree+0x20/0x30
=3D> vfs_get_tree+0x30/0xf8
=3D> path_mount+0x3c4/0xa58
=3D> do_mount+0x74/0x98
