Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C095A929F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiIAJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiIAJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670312BC1E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662022841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mt67aF+6co4O3ixWvunn6QiNw9LDIbjyfyYr/fh0ZY=;
        b=c+/fTIpNLeR7YhfphaF5fIXLH6sCuapXX8TRQ1FTPKyIELjEMthJw0nNJ39JdIbQmgJ3dc
        QuZqP9Q9bWj75WhlhWkNAx3h6VwGz+qz5SdU8M+Lxdd/vvqU+saroOZ0rNyY7rYIE28TYp
        8gSZF2MfjtpZgHGH9sCMb7M37BtNYFk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-CrBXpJY6PmS9UqBNSp1KaA-1; Thu, 01 Sep 2022 05:00:40 -0400
X-MC-Unique: CrBXpJY6PmS9UqBNSp1KaA-1
Received: by mail-qk1-f200.google.com with SMTP id m19-20020a05620a24d300b006bb85a44e96so13967284qkn.23
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8mt67aF+6co4O3ixWvunn6QiNw9LDIbjyfyYr/fh0ZY=;
        b=Yi6Ql9S5JfsMGLUgoHEk4mLHurKhigX8r7lkvu1ICgeYSd4lMoTi6H0qbUE+lPD9pi
         v1EKVuksjysOZ9xtkWs2z5vKgssAFfhd32CTZbWJQHhihmPW1xOJ+LvKh5X4AWq3FrWm
         yocCkwTwmsN2kZ+/3S0kWSK3w05C9DURuZfaUWU1QWB4dx//6sRS3XncRvdeRqrEOLg2
         btCAUdKyBrpBBSiCrK+f6poTd+W/+Nq8RVd+bpfQt0RYHS8hB9ogGk/iMdpCwLGrxjiA
         xnFVciCcwIYOb6qH3KGO4qwSXSWHoCLrBFPMY3wSs5x8dJ9FDLpYZTFvs3ktrPCsj/Nm
         hrzg==
X-Gm-Message-State: ACgBeo1fdjEVricBFIq/XxnxYig44IiKuoNc0xDLvvbirrxZwjF0lGWS
        cCacGjBAWAPkEvvNrlhns5Ufeoz3DwzapqLXNkmZjBD5TxXk05FaurxuoS8neJrlBKspuN/VxSU
        qkC+DTUcfooEMh8Pdah/DCvblw6OyRqToZPZMt8gK
X-Received: by 2002:a05:622a:15c3:b0:344:7c48:bfb2 with SMTP id d3-20020a05622a15c300b003447c48bfb2mr22660911qty.370.1662022839488;
        Thu, 01 Sep 2022 02:00:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6JniwzUbUHGWnENjDhen1GCDMSpZDyCOvT0FUaBOPK2wQyDY0m971rfQdjcLbJ80DkWju9fbvsYnge8l7FCVE=
X-Received: by 2002:a05:622a:15c3:b0:344:7c48:bfb2 with SMTP id
 d3-20020a05622a15c300b003447c48bfb2mr22660890qty.370.1662022839181; Thu, 01
 Sep 2022 02:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220901055434.824-1-qtxuning1999@sjtu.edu.cn> <20220901055434.824-4-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220901055434.824-4-qtxuning1999@sjtu.edu.cn>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 1 Sep 2022 11:00:03 +0200
Message-ID: <CAJaqyWdSNVyWeHyeZgzhczL0+bcvYShwJEfzHpjmy45cSSre3Q@mail.gmail.com>
Subject: Re: [RFC v3 3/7] vsock: batch buffers in tx
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Michael Tsirkin <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 7:55 AM Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
>
> Vsock uses buffers in order, and for tx driver doesn't have to
> know the length of the buffer. So we can do a batch for vsock if
> in order negotiated, only write one used ring for a batch of buffers
>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/vhost/vsock.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 368330417bde..e08fbbb5439e 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -497,7 +497,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>         struct vhost_vsock *vsock = container_of(vq->dev, struct vhost_vsock,
>                                                  dev);
>         struct virtio_vsock_pkt *pkt;
> -       int head, pkts = 0, total_len = 0;
> +       int head, pkts = 0, total_len = 0, add = 0;
>         unsigned int out, in;
>         bool added = false;
>
> @@ -551,10 +551,18 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>                 else
>                         virtio_transport_free_pkt(pkt);
>
> -               vhost_add_used(vq, head, 0);
> +               if (!vhost_has_feature(vq, VIRTIO_F_IN_ORDER)) {
> +                       vhost_add_used(vq, head, 0);
> +               } else {
> +                       vq->heads[add].id = head;
> +                       vq->heads[add++].len = 0;

Knowing that the descriptors are used in order we can save a few
memory writes to the vq->heads[] array. vhost.c is checking for the
feature in_order anyway.

Thanks!

> +               }
>                 added = true;
>         } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
>
> +       /* If in order feature negotiaged, we can do a batch to increase performance */
> +       if (vhost_has_feature(vq, VIRTIO_F_IN_ORDER) && added)
> +               vhost_add_used_n(vq, vq->heads, add);
>  no_more_replies:
>         if (added)
>                 vhost_signal(&vsock->dev, vq);
> --
> 2.17.1
>

