Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702F14EA6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiC2FAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiC2FAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF275F07
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648529894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMiLcrQExvhVCoUkftH7rHDXBOzH1kZg7AAMME34QKg=;
        b=ekxNtgdw3yrog09N236DEYi0Kvybzhw+SvZbHlpiThYlsbixIHPnJv0HE5bBzBACShW5k2
        stk6fOjnN1vPde9JSb+crQctHWM0iQf8HZdnUny0k4X3phHBozRrn8K3/Kdvyfam/3QNvR
        mmbqfVF8l5q+22FPwDZUDzqK6u0J3Lg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206--6aS5ezZNWmrW1BOdxPDwQ-1; Tue, 29 Mar 2022 00:58:12 -0400
X-MC-Unique: -6aS5ezZNWmrW1BOdxPDwQ-1
Received: by mail-lj1-f197.google.com with SMTP id o25-20020a2e7319000000b0024aa653c564so4177966ljc.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMiLcrQExvhVCoUkftH7rHDXBOzH1kZg7AAMME34QKg=;
        b=ZapCxRhAQBVq/Z1LUGzK9HsLxn3uutUo+t0SkfXqmRpNFVmmC2mzGHQuAJOvpDlNKh
         +caUeK6+F7XPwqasD+rKYjqKc9kNBf8eWnD/p4aJ81LAiFh9TfGQGeBQTmGfUFqPG0Z+
         405JRd1vpxzOeNQY++E2OB31f1bRgKMkwOvxR3OXt3Um2Gz6QndBL+mJmc5y2hgPrN5a
         zNo9fJq5X7J1zHGksBMVv3YmP2ceS2Z7V4ZS7eAIyvsB2kkCP8SKapRfBozhb5rt01XX
         L94dYy8aq3rmzED7hK04KBNy4VTb5w0HQ+Lrha/IaQraiCgZmV1XH824t4Ji/F53Tfey
         dB1A==
X-Gm-Message-State: AOAM53385SjVm8qM8wRXn9kdY/nYg3iKsfEPMd8ZECjgt5xkVf1aDiPh
        q4g4SJoeJBCg5lnzf+RO4bZ3+NEkUNseYXKAAXSJ2C+kM1TOFwirILbK2fapo+FiqC8C8Jed7+4
        33vUXVoYk9osrbwkLuaMiIPTotgeyBq4kVe5LY5vh
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id d18-20020a05651c089200b002499e230015mr940098ljq.492.1648529891363;
        Mon, 28 Mar 2022 21:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo1ucp6iRI2NP8W/KCNXb4J4giLjR7oB42N/dthtVzQ5VaU8sSt/uhEAIYgGEW7MXrw7+yBOvKOwQKxLnbqos=
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id
 d18-20020a05651c089200b002499e230015mr940084ljq.492.1648529891181; Mon, 28
 Mar 2022 21:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com> <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Mar 2022 12:57:59 +0800
Message-ID: <CACGkMEsVjcQGLr8=OwpbhSJY3_Nn_am_YK7gQKdvV6PKUb9qRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs check
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 6:58 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> The 'if (vq->vq.num_free < descs_used)' check will almost always be false.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d597fc0874ec..ab6d5f0cb579 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -525,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>                 descs_used = total_sg;
>         }
>
> -       if (vq->vq.num_free < descs_used) {
> +       if (unlikely(vq->vq.num_free < descs_used)) {
>                 pr_debug("Can't add buf len %i - avail = %i\n",
>                          descs_used, vq->vq.num_free);
>                 /* FIXME: for historical reasons, we force a notify here if
> --
> 2.17.1
>

