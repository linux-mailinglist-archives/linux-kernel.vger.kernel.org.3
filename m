Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A14EA1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbiC1UuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346392AbiC1Usg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:48:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FB2A264;
        Mon, 28 Mar 2022 13:46:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qa43so31102667ejc.12;
        Mon, 28 Mar 2022 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtOIKDwYEmY0G6ZwVjCPJc+EKV3kxgQ9Fb0rQsgCgxk=;
        b=Au6XxjoO3TuN885D6RISvoi4b+Imy6m9ma8wBo5nZXyzrl8us8an+07UXpqcYW8zs0
         MCSmvT+BgeqF+LC5cDbAfNpCwtLF5xXOPMaS88l46OSA1XZAyK5odoPL2mbvJ6cB4vSl
         o1GWvonXJuK6WI14daDAyrKhkAi2IwZs9OFfthpp9zgCke8yrCTZm95PoWNuAOFPK+d/
         SOtOyAdzCfpdQ3lGnMfmrpx1n2bZellSprH310zAmA2p10nge7zkW5yvynqjJUTrYqLj
         Ef4LLKkBC/m64hzJyhYmDT+bEFN9A8v++0Xe/yWHq8Gquj0Yw/CTSjM09awB/tS3ohu6
         ZXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtOIKDwYEmY0G6ZwVjCPJc+EKV3kxgQ9Fb0rQsgCgxk=;
        b=jWCx0DywQu2SXHRdyGOlnN8zcJrX7Mq8dZeeh8Dwao/AQTeppbndKdPwS82EBJx8xr
         tQ6qczgUX+L8FLnviLkjlXMEX8KboHciv+kl2L/OnxdYE5YZr9Ac8+QwXxscFDLMiI8o
         rqji820Qr/DAi6Lxj7VQQ6jbjhMcrgph4430HV/5MslyLj6SeM5bC87VFCR5fyBxqyF/
         fH1F1xvBR0p41ecruMVC8dcS2Xr8LMi3jBostslcYjVDlriPebl7qKY4mPp5wPGZgFKN
         w5pQEmrILTFAG/Mg8k7FnqF8wX6hoDKUA4P914a1hREevhxVhXHPrLI4P6DgJAjDjQ1L
         NKaQ==
X-Gm-Message-State: AOAM532ZaxYKOcbZ9SVOlIamNhapgfuiUbD3G9ltohT7W26kjvmdgAkR
        Mqm1E67+CQWmaGlnIoOoroqrcgGTvH2Evn0AoQ4=
X-Google-Smtp-Source: ABdhPJxuunfwUkBAnwXYx6Ny/ga6aWVlv3hTy52B/L+8KibeTrMHKVtaauHv16KEa6mM9fV/P7rh8AZODW2UuLnRBgI=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr30132608ejc.44.1648500398124; Mon, 28
 Mar 2022 13:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220207125933.81634-1-paul@crapouillou.net> <20220207125933.81634-6-paul@crapouillou.net>
In-Reply-To: <20220207125933.81634-6-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Mar 2022 23:46:02 +0300
Message-ID: <CAHp75Vf8QhosJw79U97rA6u0KHY9avmzTMBUqEyWkY6jxBuPYg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] iio: core: Add new DMABUF interface infrastructure
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 5:26 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add the necessary infrastructure to the IIO core to support a new
> optional DMABUF based interface.
>
> The advantage of this new DMABUF based interface vs. the read()
> interface, is that it avoids an extra copy of the data between the
> kernel and userspace. This is particularly userful for high-speed

useful

> devices which produce several megabytes or even gigabytes of data per
> second.
>
> The data in this new DMABUF interface is managed at the granularity of
> DMABUF objects. Reducing the granularity from byte level to block level
> is done to reduce the userspace-kernelspace synchronization overhead
> since performing syscalls for each byte at a few Mbps is just not
> feasible.
>
> This of course leads to a slightly increased latency. For this reason an
> application can choose the size of the DMABUFs as well as how many it
> allocates. E.g. two DMABUFs would be a traditional double buffering
> scheme. But using a higher number might be necessary to avoid
> underflow/overflow situations in the presence of scheduling latencies.
>
> As part of the interface, 2 new IOCTLs have been added:
>
> IIO_BUFFER_DMABUF_ALLOC_IOCTL(struct iio_dmabuf_alloc_req *):
>  Each call will allocate a new DMABUF object. The return value (if not
>  a negative errno value as error) will be the file descriptor of the new
>  DMABUF.
>
> IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
>  Place the DMABUF object into the queue pending for hardware process.
>
> These two IOCTLs have to be performed on the IIO buffer's file
> descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
>
> To access the data stored in a block by userspace the block must be
> mapped to the process's memory. This is done by calling mmap() on the
> DMABUF's file descriptor.
>
> Before accessing the data through the map, you must use the
> DMA_BUF_IOCTL_SYNC(struct dma_buf_sync *) ioctl, with the
> DMA_BUF_SYNC_START flag, to make sure that the data is available.
> This call may block until the hardware is done with this block. Once
> you are done reading or writing the data, you must use this ioctl again
> with the DMA_BUF_SYNC_END flag, before enqueueing the DMABUF to the
> kernel's queue.
>
> If you need to know when the hardware is done with a DMABUF, you can
> poll its file descriptor for the EPOLLOUT event.
>
> Finally, to destroy a DMABUF object, simply call close() on its file
> descriptor.

...

> v2: Only allow the new IOCTLs on the buffer FD created with
>     IIO_BUFFER_GET_FD_IOCTL().

Move changelogs after the cutter '--- ' line.

...

>  static const struct file_operations iio_buffer_chrdev_fileops = {
>         .owner = THIS_MODULE,
>         .llseek = noop_llseek,
>         .read = iio_buffer_read,
>         .write = iio_buffer_write,
> +       .unlocked_ioctl = iio_buffer_chrdev_ioctl,

> +       .compat_ioctl = compat_ptr_ioctl,

Is this member always available (implying the kernel configuration)?

...

> +#define IIO_BUFFER_DMABUF_SUPPORTED_FLAGS      0x00000000

No flags available right now?

...

> + * @bytes_used:        number of bytes used in this DMABUF for the data transfer.
> + *             If zero, the full buffer is used.

Wouldn't be error prone to have 0 defined like this?

-- 
With Best Regards,
Andy Shevchenko
