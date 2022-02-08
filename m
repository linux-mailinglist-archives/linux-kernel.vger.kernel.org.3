Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B044AD178
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347244AbiBHGY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240841AbiBHGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:24:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8598C0401F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:24:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id s13so49091794ejy.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F05KrrJ5nwRnJTzF4EHFCUub/SMru0BF05WRRy/F6Pk=;
        b=bHQDT+JW+B0bT2CR3YOv/YW+mOdd+RZtX5FkePRJjdUsBXnKBDk6mgNM+23oTbmdrd
         nrdPoqa/CLBSQWuGpmofiyJt9ss8A8yWrHjEgoIa8Xv7OiBtEtQEf6c392Oa0gdT4guo
         kkKwUGcKP/XhVXaF1w77SLwYUxK+lFZt1iQP4SBwIeaqvc0jgpogqAhVH7Ee2xD+5r9f
         CQXsGQRxOgipfmH5UbxTLv/XDTNk1MfKMv8QM7IwhzIxQ1M5sCVmu2u/1/6gTCNlQdt/
         xvBIoUQifcbWMgHTJOtJsL3oxZCAwbsP8/qJUbtgRzDShxFg3rWUEpkxGbuivR50PT+2
         NaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F05KrrJ5nwRnJTzF4EHFCUub/SMru0BF05WRRy/F6Pk=;
        b=u6POqcMJyk+xmChYHH0EJ7ddDTZ/T8ZHZGufxfux75DzfCphjiwwSNIs+pgilQ1Whc
         EIlOXkGiT+O/oV4EUq8Z9LGanhIhEQMvyjLKfwOufxpBaTIY7OPa8fjm5Q6nB/J7utLg
         i/pIUTBP8tXywhxSj5QwigG1C6JBElOf9Tdv18e69uHj8YdWAs3ACUhIvnsoCYULJkav
         p5P0k8/z0iexfM7S59im9WQz1QH62in9b6ujF963dDVkUEgVl4QDlyAtPLDnL6x1jHuU
         fr7Api6quFSwWIQ2cOTFZXNkOsG0x8Mu83yIFa4ApEeuR0zJvxDGdinFzXy6h6HYVCv1
         j2ug==
X-Gm-Message-State: AOAM533ENar5TSn9lJfmo9GqagjO2SINbYUd7WghGcSYrMXGQ9w2MNSU
        OOV7sagAKP3yhpOtwqsouzUiSbDH/TDxuq593b59tQ==
X-Google-Smtp-Source: ABdhPJw0mV3W8x4mwmjY7Wbc8YNoyW9j3jncLmuwo0IXP3n3B7HZBKW9o3xDHJtoZCmgbTznPN2ywGhGB920b7ymYx8=
X-Received: by 2002:a17:907:1b1c:: with SMTP id mp28mr2441762ejc.624.1644301494293;
 Mon, 07 Feb 2022 22:24:54 -0800 (PST)
MIME-Version: 1.0
References: <7f9eccd8b1fce1bac45ac9b01a78cf72f54c0a61.1644266862.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7f9eccd8b1fce1bac45ac9b01a78cf72f54c0a61.1644266862.git.christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 8 Feb 2022 07:24:43 +0100
Message-ID: <CAMGffE=xiO1tgAeZ9QJr0GyrE2EnYkj3hASJSMsGFHwRCTZ5Cg@mail.gmail.com>
Subject: Re: [PATCH v2] block/rnbd: Remove a useless mutex
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 9:48 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> According to lib/idr.c,
>    The IDA handles its own locking.  It is safe to call any of the IDA
>    functions without synchronisation in your code.
>
> so the 'ida_lock' mutex can just be removed.
> It is here only to protect some ida_simple_get()/ida_simple_remove() calls.
>
> While at it, switch to ida_alloc_XXX()/ida_free() instead to
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thanks!
> ---
>  drivers/block/rnbd/rnbd-clt.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 9a880d559ab8..1f63f308eb39 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -23,7 +23,6 @@ MODULE_LICENSE("GPL");
>
>  static int rnbd_client_major;
>  static DEFINE_IDA(index_ida);
> -static DEFINE_MUTEX(ida_lock);
>  static DEFINE_MUTEX(sess_lock);
>  static LIST_HEAD(sess_list);
>
> @@ -55,9 +54,7 @@ static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
>         if (!refcount_dec_and_test(&dev->refcount))
>                 return;
>
> -       mutex_lock(&ida_lock);
> -       ida_simple_remove(&index_ida, dev->clt_device_id);
> -       mutex_unlock(&ida_lock);
> +       ida_free(&index_ida, dev->clt_device_id);
>         kfree(dev->hw_queues);
>         kfree(dev->pathname);
>         rnbd_clt_put_sess(dev->sess);
> @@ -1460,10 +1457,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>                 goto out_alloc;
>         }
>
> -       mutex_lock(&ida_lock);
> -       ret = ida_simple_get(&index_ida, 0, 1 << (MINORBITS - RNBD_PART_BITS),
> -                            GFP_KERNEL);
> -       mutex_unlock(&ida_lock);
> +       ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
> +                           GFP_KERNEL);
>         if (ret < 0) {
>                 pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
>                        pathname, sess->sessname, ret);
> --
> 2.32.0
>
