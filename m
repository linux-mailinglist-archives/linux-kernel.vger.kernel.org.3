Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F65571F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiFWEoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243990AbiFWDwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CFC63DA6B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655956354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oERTIQYSyhXKjQ8GU8XC7srVUHfe3PX7kQp/nyf4Iak=;
        b=TwyuuIuXqsp6OvqlELIUNlT+PK0lypudWpUVT90CWk0xsAwbUohnc3PQapncRiAz5WDTga
        HToLLjQik1BSANZLHWlrgXMnBgYjK6VbkJy55lCoNj9gtggAOLc4X/DwUuRED9Ldt/qdcX
        hWGGff8dcBxVxDkNEsW1rggaH+XNf4I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-pHaKGqAVOWufY4SMPmiKQg-1; Wed, 22 Jun 2022 23:52:32 -0400
X-MC-Unique: pHaKGqAVOWufY4SMPmiKQg-1
Received: by mail-lf1-f71.google.com with SMTP id c5-20020a056512238500b0047954b68297so9399160lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oERTIQYSyhXKjQ8GU8XC7srVUHfe3PX7kQp/nyf4Iak=;
        b=QY0EriuclJ7KZcCv9PMpF2RZwT99eUUeIBrliGYvDtWgYg1ESQCiN05MbEXwz9k/YR
         XiJdrLoK2L1L2tlra/0a6Re6LnJZ7M+zOU+0wUJmrVCp13EghU+QkhOjyImeMP9titFX
         Mp5cD45rvjSEVSo60qJBqpJjtBAKhawzsao55PtTwQsZ68n3ttpd1Jw56zEmuqLsZ+CY
         ctmn6/azn1HLhfB7x1XlF6jVw9Qwmb9A0x+RYXHjrPAW7MC/Et6mh5BR6+rqel0pxlrX
         oIGkXrAeCsecQsdWCcWufLWR6QPv77YG4YfpiJhy3w7A0nPchIbJu6kRJnBNwZ1UBI8Q
         FS2g==
X-Gm-Message-State: AJIora+yL/yyp+TvrIa/UVY+45V9rWCwde8UkgiVAw/GvS32uTlxBCNP
        ZTVM3z+fi+8lCdUnL9sN0jpIfDUFAnGFWcM5sTBDMMDAREg0graZ5bRelINf7IxdfbW4and7ipr
        ob10u6d9HKhTErhLoMQqaBLr1tMfT2Fw4s4mjqEZZ
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id z23-20020a2e8417000000b0025a7fa7fe5amr3560105ljg.323.1655956350771;
        Wed, 22 Jun 2022 20:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSjD9XhGJKPyenHAlWNgLInipzPx6LybWaTzbpUqxCCMKR0OcRWGtAVXq+T87H4VBC/po+k+b6agP6rWTAm10=
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id
 z23-20020a2e8417000000b0025a7fa7fe5amr3560098ljg.323.1655956350580; Wed, 22
 Jun 2022 20:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com> <20220621161252.197173-1-sgarzare@redhat.com>
In-Reply-To: <20220621161252.197173-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Jun 2022 11:52:19 +0800
Message-ID: <CACGkMEv1Y_rKSc799qi2=EkrQfm4E_d9aMWefXyz5h4vdXjxgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] vdpa_sim_blk: call vringh_complete_iotlb() also in
 the error path
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:13 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Call vringh_complete_iotlb() even when we encounter a serious error
> that prevents us from writing the status in the "in" header
> (e.g. the header length is incorrect, etc.).
>
> The guest is misbehaving, so maybe the ring is in a bad state, but
> let's avoid making things worse.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index ac86478845b6..de9cd9843143 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -63,6 +63,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>  {
>         size_t pushed = 0, to_pull, to_push;
>         struct virtio_blk_outhdr hdr;
> +       bool handled = false;
>         ssize_t bytes;
>         loff_t offset;
>         u64 sector;
> @@ -78,12 +79,12 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
>                 dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
>                         vq->out_iov.used, vq->in_iov.used);
> -               return false;
> +               goto err;
>         }
>
>         if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
>                 dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
> -               return false;
> +               goto err;
>         }
>
>         /* The last byte is the status and we checked if the last iov has
> @@ -97,7 +98,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                       sizeof(hdr));
>         if (bytes != sizeof(hdr)) {
>                 dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
> -               return false;
> +               goto err;
>         }
>
>         to_pull -= bytes;
> @@ -182,16 +183,19 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         /* Last byte is the status */
>         bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov, &status, 1);
>         if (bytes != 1)
> -               return false;
> +               goto err;
>
>         pushed += bytes;
>
>         /* Make sure data is wrote before advancing index */
>         smp_wmb();
>
> +       handled = true;
> +
> +err:
>         vringh_complete_iotlb(&vq->vring, vq->head, pushed);
>
> -       return true;
> +       return handled;
>  }
>
>  static void vdpasim_blk_work(struct work_struct *work)
> --
> 2.36.1
>

