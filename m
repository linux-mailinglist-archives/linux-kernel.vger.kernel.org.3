Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0552C570732
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiGKPgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A694761D91
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657553757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCPTRHNJfhvgZ7B0pbofR31tAGftahYOIbu8CnQS1SM=;
        b=QCqAmzNcZOIPvNb94UIZVnCi3d0X5zyVn4KvEnEvEa6UqokoAVP8UZIiU8EGaBJGFQ4SDV
        9nmK68zcK6F/gOlhCskSPWjfBBHRNQEs5Cdqo/BAsozraJSbD+IFLwMrxaRJb2y44vx6DN
        C5foZZZVCMt83q3Ek7sk3NLIf/7l744=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-a0ns2EfHPy6IAnLIrLs8cQ-1; Mon, 11 Jul 2022 11:35:50 -0400
X-MC-Unique: a0ns2EfHPy6IAnLIrLs8cQ-1
Received: by mail-qt1-f198.google.com with SMTP id v13-20020a05622a014d00b0031ea4c5d35dso5028683qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCPTRHNJfhvgZ7B0pbofR31tAGftahYOIbu8CnQS1SM=;
        b=TUeUnLYrUHr5+Wb87CTTS0GflnKxqlHzoJHd2Y/DdQPCeWqcFVB/ON5ZuIUEPp4CnI
         usBvjeIMWGwQ2AF0d7gQB3KjMg7uG+GbHtEjB92CFH5zkPEQSy8vMD7wR6rbjNJiLcUz
         a34ZqaWnHiH/OzfR4VKkuQs0PA4A3G1V0gB5faT/JbQxJ1wbRsR2Jdfcdqs1tbYjYQMZ
         IXfvdRs5Poj9nIob0W2cJVuaVjXX7lSaV1ZC3ftjo5LIDIfBHCd7CquHSGKDtM/wOlM+
         0GHCZEMwVudcNWdhb//BiRAjlXxo40Sg8DbvGQGYxe27Bpt8ewHQPVBnK4L8oMET4A0B
         kwxA==
X-Gm-Message-State: AJIora8UymgSt/Z+5NN/tBgNVI0g5E81zutuJIr5Hl7O/8YuTeNKGGau
        /7BhVAUMTc4OfWp4YevzDO6fy9VjKR87jZA0z3Jv8Ugd2BAif34a3pDiIx3p1dzxjQi6F1rHaXA
        BxbVrBsgf7RAoJoY+IDyayCSDy5DGcqEHLFijYls9
X-Received: by 2002:a0c:fe48:0:b0:462:6a02:a17d with SMTP id u8-20020a0cfe48000000b004626a02a17dmr13931683qvs.108.1657553749823;
        Mon, 11 Jul 2022 08:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sUgmA3C+Ag0SCvt4NwutubgIrs1BxVHpjz6uhIusgNCFf454fkNLwhMCsWtzzGZgVjVGAjuYKGVv9ry9npNdY=
X-Received: by 2002:a0c:fe48:0:b0:462:6a02:a17d with SMTP id
 u8-20020a0cfe48000000b004626a02a17dmr13931661qvs.108.1657553749529; Mon, 11
 Jul 2022 08:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn> <20220709022745.21020-3-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220709022745.21020-3-qtxuning1999@sjtu.edu.cn>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 11 Jul 2022 17:35:13 +0200
Message-ID: <CAJaqyWcFbxSSyY81_O_0AaTmw0e7_f+S_6F2Tjs1AHSbv-0jfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] virtio_test: use random length scatterlists to
 test descriptor chain
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 4:28 AM Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
>
> Prior implementation only use one descriptor for each io event, which
> does't test code of descriptor chain. More importantly, one descriptor
> will not use indirect feature even indirect feature is specified. Use
> random length scatterlists here to test descriptor chain.
>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
> v3:
> - drop fda270fcd virtio_test: move magic number in code as defined constant
> ---
>  tools/virtio/virtio_test.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 95f78b311..1408a4a20 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -20,6 +20,7 @@
>  #include "../../drivers/vhost/test.h"
>
>  #define RANDOM_BATCH -1
> +#define MAX_SG_FRAGS 8UL
>
>  /* Unused */
>  void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> @@ -169,7 +170,8 @@ static void wait_for_interrupt(struct vdev_info *dev)
>  static void run_test(struct vdev_info *dev, struct vq_info *vq,
>                      bool delayed, int batch, int reset_n, int bufs)
>  {
> -       struct scatterlist sl;
> +       struct scatterlist sg[MAX_SG_FRAGS];
> +       int sg_size = 0;
>         long started = 0, completed = 0, next_reset = reset_n;
>         long completed_before, started_before;
>         int r, test = 1;
> @@ -194,8 +196,11 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>
>                         while (started < bufs &&
>                                (started - completed) < batch) {
> -                               sg_init_one(&sl, dev->buf, dev->buf_size);
> -                               r = virtqueue_add_outbuf(vq->vq, &sl, 1,
> +                               sg_size = random() % (MAX_SG_FRAGS - 1) + 1;

I'm wondering if it would be simpler to reuse batch randomness here,
and make sg_size = MIN(started - completed, MAX_SG_FRAGS). Vhost test
should go faster because the longer chains, and I guess we should hit
a good range of chain lengths with the batch tail anyway.

Thanks!

> +                               sg_init_table(sg, sg_size);
> +                               for (int i = 0; i < sg_size; ++i)
> +                                       sg_set_buf(&sg[i], dev->buf + i, 0x1);
> +                               r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
>                                                          dev->buf + started,
>                                                          GFP_ATOMIC);
>                                 if (unlikely(r != 0)) {
> --
> 2.17.1
>

