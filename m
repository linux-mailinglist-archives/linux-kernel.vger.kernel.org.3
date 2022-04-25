Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B785150DBDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbiDYJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbiDYJDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0510C13EB7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650877200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QoTWwUG44ZKREs24srdlBz4+nuuWL7M2R9CG+RWwjCM=;
        b=AvHd2uJQ/ns7geJALpoa5nSM9lBckk3XaOX0uE6cKBflPEWm7rqvg22AWjbjwAe4qp6hPZ
        SrJ6TnoQR+2xQNfPUaEayPOQRvouBr5opuWpUtapRThoPiotDnPoWm47ULvoXBIwpzU51S
        kJv6PW2kfqS2pxO4edIFrd8/s1MSW8w=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-ZW4VoTtXPRqxTBJ6KJtlRw-1; Mon, 25 Apr 2022 04:59:58 -0400
X-MC-Unique: ZW4VoTtXPRqxTBJ6KJtlRw-1
Received: by mail-lf1-f72.google.com with SMTP id bt27-20020a056512261b00b004720e026d4dso379196lfb.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoTWwUG44ZKREs24srdlBz4+nuuWL7M2R9CG+RWwjCM=;
        b=p7ahE8Is0O/AI44fbBGBCzlF8fRaD6tWszP3aHxiUqxslMYRXu2XROVoK/1HxDB+YX
         qZMme6n/+iKOnlVgASOkxKAZS/rTr1ZrbarAGzevLw21HbEcEP/jX2C7fuUIZzrc7PWc
         hVGAVcuQmhbjls/Q1o8Ezo/1DXaolPgQAIxrLo2xdxpzc+9D2AY/ZYyBjXRRcZO5C7Wm
         WeS1PMrfIvBVC9btkHpt659WuTtLT/7Zdc2nxouyDWJ7x5NM9v3JvOSH0+ygft4nEvyN
         SAyccIHOVRn26hakXdrhLcO7xVreMXHENcWbgF6W3FHz1YPoZluxxcSOnjGIP8MuYFMi
         TnCw==
X-Gm-Message-State: AOAM530vvarpDRcltp7EKp4qer0LNlIJCFNOIvtGyZ5j+5dIsXi7+rD9
        OFKdRl1rhiDx5NHZwuukzRDlzgiRXXVLnIz3fn2p4paQkbx+7trUovBt/G1HFtriymuj7ZUH1UJ
        ZJVWhknH2rRs8VDFkNTQMz+xiHCMjTOjt3xwvAWXS
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr8263989lfj.587.1650877196646;
        Mon, 25 Apr 2022 01:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlYpVuOzIkIA+vc2xFy0TnS5ZsUxhcqSLHkTFpvCIBbhfh/tNsQlp8CDlTy9fsTg2OmIpnYGAbNnBRZJXk/LI=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr8263984lfj.587.1650877196461; Mon, 25
 Apr 2022 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com>
In-Reply-To: <20220425062735.172576-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Apr 2022 16:59:45 +0800
Message-ID: <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct vdpa_mgmt_dev
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
>
> To support the dynamic ids in vp_vdpa, we need to add the check for
> id table. If the id table is NULL, will not set the device type
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1ea525433a5c..09edd92cede0 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>         if (err)
>                 goto msg_err;
>
> -       while (mdev->id_table[i].device) {
> -               if (mdev->id_table[i].device <= 63)
> -                       supported_classes |= BIT_ULL(mdev->id_table[i].device);
> -               i++;
> +       if (mdev->id_table != NULL) {
> +               while (mdev->id_table[i].device) {
> +                       if (mdev->id_table[i].device <= 63)
> +                               supported_classes |=
> +                                       BIT_ULL(mdev->id_table[i].device);
> +                       i++;
> +               }
>         }

This will cause 0 to be advertised as the supported classes.

I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need to
export it to via uAPI probably).

Thanks

>
>         if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> --
> 2.34.1
>

