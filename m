Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3CD52072C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiEIV6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiEIV40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:56:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7012D3D68
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:50:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ch13so922101ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKEvNnMqJr+Ji3wzZ+kyxqDQgYFrf7j1orREUwNHbE8=;
        b=Gr/9HTJiYOlDX6fetpo8rWY8vmbwB2ZeETv9WvSLj426WRc41qKOI2DbQDQw8wYrzl
         VMkbaUCWqEmmuWQSf6QXc97xXftjTcTkNiUat2bVrWg6KDJXGw/3EnKvR23vtrc5ek2d
         Huti8ge5p5gr7z/EQS1UOwMrLB+8Lu6MhHhnjLpWSnbfclaxyHzXbK5+ay0dnHO1rWd4
         zn6yEsKKzT44KtGADaFlK2syri+0W8SljEmBB7/ZYrDE3Ubp9EhoqnPOcO8VAtgffMbT
         vxJMvDlQ8kCM7to3VeTwl0W7qseqYQC11parqS+l1gc0hV4AXHRC6AZMIGvKz12lcw7b
         0hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKEvNnMqJr+Ji3wzZ+kyxqDQgYFrf7j1orREUwNHbE8=;
        b=S9KtW3drsqT0Qmxf/Po9tFOX8h647HpltMh6HxTRmxUk7/fWbnFTjw1Sa5V4xAcXyy
         FLQm5C5v/8Mwa7MxkNhGBD9dZYc8wZTXeOXPPMdvYai+E3NMX1DVv52NuJZI2hSqysY4
         7W/nqCukLudVVR/TsBVXhz5N2S1XjTSz7s4PUFG1/pv3ZQqfy4mk3HB+0ZZxDbI9+QZe
         Z2f41uhnNkzprDmnhE5Q14g7Zw7CuAfrTcJT/djk8NcmXZPDFIzfH9AlBkrF/YrtpgvI
         Pr7msZ5Xu4bov7hgxRMMt1OMJ71CHMBBHDbJ2yziEcJXlEwEh1OZXMMbib1TZ4b8vs1s
         lpag==
X-Gm-Message-State: AOAM532ir6gbCuz6ktTjI2LoWQsjmc71oUbTJ/42tTp1dCc5w8xn4Up7
        Cmt1XuhwonISD+YPhG09lw3ARAowV6n9B8wbiVBVbw==
X-Google-Smtp-Source: ABdhPJykPbx/03p5//2jQ4C7Er1AEW64JcawHsesvTbhr6ztpX0AZiQPHHfGXfUFyhECCsGvdqV3kvR9V0bNS63hXS4=
X-Received: by 2002:a17:907:9813:b0:6fa:78b0:9be2 with SMTP id
 ji19-20020a170907981300b006fa78b09be2mr6269780ejc.159.1652133001507; Mon, 09
 May 2022 14:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <1652125797-2043-1-git-send-email-quic_charante@quicinc.com>
In-Reply-To: <1652125797-2043-1-git-send-email-quic_charante@quicinc.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 9 May 2022 14:49:50 -0700
Message-ID: <CABdmKX2V55tA-Or6Dd+bpbcv3fDHps_+zHHJQwhz819LX_2RSQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: call dma_buf_stats_setup after dmabuf is in
 valid list
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hridya Valsaraju <hridya@google.com>, daniel.vetter@ffwll.ch,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 12:50 PM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> From: Charan Teja Reddy <quic_charante@quicinc.com>
>
> When dma_buf_stats_setup() fails, it closes the dmabuf file which
> results into the calling of dma_buf_file_release() where it does
> list_del(&dmabuf->list_node) with out first adding it to the proper
> list. This is resulting into panic in the below path:
> __list_del_entry_valid+0x38/0xac
> dma_buf_file_release+0x74/0x158
> __fput+0xf4/0x428
> ____fput+0x14/0x24
> task_work_run+0x178/0x24c
> do_notify_resume+0x194/0x264
> work_pending+0xc/0x5f0
>
> Fix it by moving the dma_buf_stats_setup() after dmabuf is added to the
> list.
>
> Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF stats in sysfs")
> Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>

Tested-by: T.J. Mercier <tjmercier@google.com>
Acked-by: T.J. Mercier <tjmercier@google.com>

> ---
>  drivers/dma-buf/dma-buf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 602b12d..a6fc96e 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -543,10 +543,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>         file->f_mode |= FMODE_LSEEK;
>         dmabuf->file = file;
>
> -       ret = dma_buf_stats_setup(dmabuf);
> -       if (ret)
> -               goto err_sysfs;
> -
>         mutex_init(&dmabuf->lock);
>         INIT_LIST_HEAD(&dmabuf->attachments);
>
> @@ -554,6 +550,10 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>         list_add(&dmabuf->list_node, &db_list.head);
>         mutex_unlock(&db_list.lock);
>
> +       ret = dma_buf_stats_setup(dmabuf);
> +       if (ret)
> +               goto err_sysfs;
> +
>         return dmabuf;
>
>  err_sysfs:
> --
> 2.7.4
>
