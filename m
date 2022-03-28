Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6EC4EA224
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiC1VBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiC1VA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:00:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDE56D97B;
        Mon, 28 Mar 2022 13:59:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r23so18426861edb.0;
        Mon, 28 Mar 2022 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XpihMQW3ITEGr80CFfEgsPwVbFmNePy8AVTnWzohyno=;
        b=fo6+o9w1krLj+t9+r6Huq6bmXGajiPbFdocT5kBjC0HNvq2kYhvbOf+nwkdlfWEihJ
         XFooInFSC2XxwxaaFa5j9dwDixiymZ80ntOov64y6VfCVLgnJO/ZKY2Y57ZVmLhKjQWJ
         /KiPBhfmc7+I7hQnJ5dkX1W+4t2UZg3u6kMkRFqCqCVPhQ6RAQKAFjgRGHqMLB2uj0J1
         bAKOtVu2J7GY58NXTNyhxAYfj6hhJe2dRqp72oCdamCZpoQ8mDte3MIkEJY+8gATJy1v
         gtJBcT/a+PdVy6KIgnUbTPGh402e++/1EUXLTSuiE81atZEQGIJeIuaDtouqgj4tt2Pu
         FUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XpihMQW3ITEGr80CFfEgsPwVbFmNePy8AVTnWzohyno=;
        b=JxYnhAcyYoBWzRPwwq5YecQrZXK++pXXuxljOioLi4DMW3cpfhPrnvW3k3EUT2pLfA
         qAzJf7bW8gJHkMGc2MrjwS7gBcyBkqfg0CLe0KujhR2wv/5GuLb6OsVBVcRGoTo+nIpo
         Oa2kOIsGKbG8/g67LMuHyPXJioNNVG+zLy1DPdegRgBxM5VD5Mqf2hLVJ005FDIKyuwZ
         ZRw3XzyzgAAgS/1DxUc0gCFSi6bvp1sizpHS5OA3UNyOY2l/vCOe7XCAISs7nQ+xTUgz
         CD53p8LhEQHzvDZkxYljZtawGkDEt13fiMjaGLnWFxYWP7kugSUOtqfXwPq1RKVuE0eL
         qOEw==
X-Gm-Message-State: AOAM532Jc/a2RdUlxcK9N4a/UhbKWu7PtbaX0OUw0tFcFFRhjmJ82yis
        TYLCz9bxiBjyNCtr+4D/rPQK6HxiFoBv1kVSuOI=
X-Google-Smtp-Source: ABdhPJxpdmWGnFCQvTKGOD9NOQ2vNgNaejcUttwdkmLsXR8JqVRfOJExLnuVhfUYDvEwh561/7+o05VS6CAtac5wV6c=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr18962285edu.29.1648501154526; Mon, 28
 Mar 2022 13:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220207125933.81634-1-paul@crapouillou.net> <20220207125933.81634-8-paul@crapouillou.net>
 <20220328185425.56b51f4a@jic23-huawei> <1VYG9R.1JAKRTCN4I411@crapouillou.net>
In-Reply-To: <1VYG9R.1JAKRTCN4I411@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Mar 2022 23:58:38 +0300
Message-ID: <CAHp75VcWisAaHJUKedT7BWGNA8_5xye8-dyCv5Fq_kQWu7m7ew@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] iio: buffer-dma: Use DMABUFs instead of custom solution
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

On Mon, Mar 28, 2022 at 11:30 PM Paul Cercueil <paul@crapouillou.net> wrote=
:
> Le lun., mars 28 2022 at 18:54:25 +0100, Jonathan Cameron
> <jic23@kernel.org> a =C3=A9crit :
> > On Mon,  7 Feb 2022 12:59:28 +0000
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >
> >>  Enhance the current fileio code by using DMABUF objects instead of
> >>  custom buffers.
> >>
> >>  This adds more code than it removes, but:
> >>  - a lot of the complexity can be dropped, e.g. custom kref and
> >>    iio_buffer_block_put_atomic() are not needed anymore;
> >>  - it will be much easier to introduce an API to export these DMABUF
> >>    objects to userspace in a following patch.

> > I'm a bit rusty on dma mappings, but you seem to have
> > a mixture of streaming and coherent mappings going on in here.
>
> That's OK, so am I. What do you call "streaming mappings"?

dma_*_coherent() are for coherent mappings (usually you do it once and
cache coherency is guaranteed by accessing this memory by device or
CPU).
dma_map_*() are for streaming, which means that you often want to map
arbitrary pages during the transfer (usually used for the cases when
you want to keep previous data and do something with a new coming, or
when a new coming data is supplied by different virtual address, and
hence has to be mapped for DMA).

> > Is it the case that the current code is using the coherent mappings
> > and a potential 'other user' of the dma buffer might need
> > streaming mappings?
>
> Something like that. There are two different things; on both cases,
> userspace needs to create a DMABUF with IIO_BUFFER_DMABUF_ALLOC_IOCTL,
> and the backing memory is allocated with dma_alloc_coherent().
>
> - For the userspace interface, you then have a "cpu access" IOCTL
> (DMA_BUF_IOCTL_SYNC), that allows userspace to inform when it will
> start/finish to process the buffer in user-space (which will
> sync/invalidate the data cache if needed). A buffer can then be
> enqueued for DMA processing (TX or RX) with the new
> IIO_BUFFER_DMABUF_ENQUEUE_IOCTL.
>
> - When the DMABUF created via the IIO core is sent to another driver
> through the driver's custom DMABUF import function, this driver will
> call dma_buf_attach(), which will call iio_buffer_dma_buf_map(). Since
> it has to return a "struct sg_table *", this function then simply
> creates a sgtable with one entry that points to the backing memory.

...

> >>  +   ret =3D dma_map_sgtable(at->dev, &dba->sg_table, dma_dir, 0);
> >>  +   if (ret) {
> >>  +           kfree(dba);
> >>  +           return ERR_PTR(ret);
> >>  +   }

Missed DMA mapping error check.

> >>  +
> >>  +   return &dba->sg_table;
> >>  +}

...

> >>  -   /* Must not be accessed outside the core. */
> >>  -   struct kref kref;


> >>  +   struct dma_buf *dmabuf;

Is it okay to access outside the core? If no, why did you remove
(actually not modify) the comment?

--=20
With Best Regards,
Andy Shevchenko
