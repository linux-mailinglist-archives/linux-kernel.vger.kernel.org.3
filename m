Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA798548181
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiFMILH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiFMIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8C951E3DD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655107853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3I59FmykDLK1GNxLZhq5VJ8322YMgbR0Ph4Y1aaHOU=;
        b=OeK1DQ9CYl9tEOEP/Mtqyx9djBXPkQ+NUqevEx7oA91BFHk8aTzz4FpLruu5TJCsCiEfuc
        xdEGV1CEWPG6OOVVIdiDtzIIdMHaQUr5WZ09g7gBAgrhtsBFvcl39KZaX6/urXg79plFWL
        Ngl6ALMDkjxue7hYQkJTew9FcQmVyEc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-BC_hWUVqNTSSzjDbWs5Tyw-1; Mon, 13 Jun 2022 04:10:52 -0400
X-MC-Unique: BC_hWUVqNTSSzjDbWs5Tyw-1
Received: by mail-lj1-f199.google.com with SMTP id a16-20020a05651c211000b002557bb9091bso473593ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3I59FmykDLK1GNxLZhq5VJ8322YMgbR0Ph4Y1aaHOU=;
        b=C39PtbQiXUfxeHsT7WL3AadTKpzpsOPsEtFRjKNdW3rJZewwCIMIU3TIInvOySkSUh
         oR9W7m31PuBIav8VRItelAcePMrP/QqqR0fDcWOMhqVkY44EYscnlli51WabN96Ck3St
         rY7jGFlZnTTun8e/OY83H1ZVdO6JLgKSoAYofYTXJb2DmlZwTH1swCIO2xy9qsNumTo2
         l0dHTA1TikjXht+IF/K1ZvPv5iTgiOILOyinhIM38qAk8HijXyzwlZI2SZkTr9bxqm6A
         2z4BLaHU14Wpoq7o01Aej4uCcYFPGfCiqYMUPjuj+o4CL2PkOX/zm1lZBQLbDoVqbMEO
         KO2A==
X-Gm-Message-State: AOAM531NHK/kVPp+I4+qlRIwxgba3rdAuFQY/5MLXRj2As9FqouI4jln
        k31fgPyggF54KABXNCRKdnnsENgkYIAHo0mSrpEL7YmzOQbY8ug/fANabySPuA8EAHXaz1V6yuV
        /GuyJd2Q6MO0AWxcJwY0PpR8eDRb3IGkbf7RniZFj
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id m18-20020a194352000000b0047905d13fefmr35944836lfj.411.1655107849673;
        Mon, 13 Jun 2022 01:10:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXvb0hR2HEZzfJ9SDV+9irQx/3lYtrRjA6yvv01usuhZ8nwVb+Wp5sp88+2Jmm40d9StFVtY2gm5fE/VRhrIo=
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr35944781lfj.411.1655107848004; Mon, 13
 Jun 2022 01:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220613075958.511064-1-elic@nvidia.com>
In-Reply-To: <20220613075958.511064-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Jun 2022 16:10:36 +0800
Message-ID: <CACGkMEsxgs4DTs3w0Mtwrn26Cpww=_5VuApCKm=tHrTwDmZ0rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Update Control VQ callback information
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst <mst@redhat.com>, eperezma <eperezma@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 4:00 PM Eli Cohen <elic@nvidia.com> wrote:
>
> The control VQ specific information is stored in the dedicated struct
> mlx5_control_vq. When the callback is updated through
> mlx5_vdpa_set_vq_cb(), make sure to update the control VQ struct.
>
> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1b6d46b86f81..789c078ff1af 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1962,6 +1962,8 @@ static void mlx5_vdpa_set_vq_cb(struct vdpa_device *vdev, u16 idx, struct vdpa_c
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>
>         ndev->event_cbs[idx] = *cb;
> +       if (is_ctrl_vq_idx(mvdev, idx))
> +               mvdev->cvq.event_cb = *cb;
>  }
>

Acked-by: Jason Wang <jasowang@redhat.com)

In the future, I wonder if we can simply just use event_cbs[] since it
has took cvq into account:

struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];

Thanks

>  static void mlx5_cvq_notify(struct vringh *vring)
> --
> 2.35.1
>

