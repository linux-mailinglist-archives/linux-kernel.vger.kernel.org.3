Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DE5130CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiD1KH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiD1KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:06:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD63337C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:55:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x33so7679837lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V0XeT7IXBftt0apFPjjxPnSRBK1X7ldQ9u0yIYHiPlU=;
        b=YCg4LQSCCHVcvC/S2cQuookZz0GMC3S83n5ovXl/cTO4vUS871u/K85uaoRnHXZi5n
         s8HCkmeTShWkJtH/RqXwANzdsUpcmgKpDfbzBqKiXU7uJ6y/1V3S9dxb8m8M+jiijopy
         QA4yKCLxZguaqkZJ64WGbrnlJOHQkRyG8j9nUnVtKNMnMXpfRSznH0OX9F+VIoHEIv1n
         ulAWX0gv39ng0xftKnC1sBNS+j1hQ5UpILJw+cEeg9Y66AOHRf+sOQpVKsLiXa64cyui
         guTOM8XV+qM+BriDGY6F6KIbFr2f9PgoC9XHjHUfqp3QxuZ7owy9GFz3dzitjKq+QOKx
         RE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V0XeT7IXBftt0apFPjjxPnSRBK1X7ldQ9u0yIYHiPlU=;
        b=oVdZ2f2cP5LtXPndSdeV7o86j5J07UJMos3IkUK///oPpM6AQSdmTDQu53q0PHy4i6
         VhV82twfwpdMJ9mLR8bOQ8vfDsyqgFJWrs8okeI4s3dRE4kFOeLHvKNFT3DJ+ZRp5O0c
         zlU9wiXZIz5TlRe1GWEjl0gxeK8usPw3NhuiSCQ6FYRIETOVfWGkdZr7hwqIF8rDVw0z
         uEpSYzmwnyuHXJO+8a0LV9YiRpdjEaWV0n9V/uzDS4I2Z7l9bIcqY090qISeHnSSfD0z
         spkQQftv30FIEjeNXSqcg7TGhCWrUOdueP9RUwQQgpEJ1ChBSfEnmw5DEFRg1mr1WuXV
         Ya/A==
X-Gm-Message-State: AOAM533n9TBZgRSgnCHpfhV1wUlK4jFeSVdOxfVH1DPBLarYQqhG8gSE
        65d0qOjHRkmgbzyGpqwA8YdRkytq8z7xG/CRzlQw1Q==
X-Google-Smtp-Source: ABdhPJy0ybox27E6e84jHMcEqHixOb1KpVI0stK6pmS/L2GkVDTmApxzKoDq6QSEYP6f0A9CtGwOMHzZsfN+e/ROgxI=
X-Received: by 2002:a05:6512:110c:b0:472:3d96:bd24 with SMTP id
 l12-20020a056512110c00b004723d96bd24mr678751lfg.389.1651139701661; Thu, 28
 Apr 2022 02:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220428063924.3570409-1-songyuanzheng@huawei.com> <e4e5bd41-df5b-bb65-b92f-47122d1e7738@amd.com>
In-Reply-To: <e4e5bd41-df5b-bb65-b92f-47122d1e7738@amd.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 28 Apr 2022 15:24:49 +0530
Message-ID: <CAO_48GG6vX35HTZNXz5Bqf341K9+6a5M63Jxb+nYSbpWDqMH=w@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: add the name field to the table header
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Yuanzheng Song <songyuanzheng@huawei.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Thu, 28 Apr 2022 at 13:33, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 28.04.22 um 08:39 schrieb Yuanzheng Song:
> > 'cat /sys/kernel/debug/dma_buf/bufinfo' will print the Dma-buf
> > Objects' information when the CONFIG_DEBUG_FS=3Dy.
> > However, the printed table header information does not contain
> > the name field. So we need to add the name field to the table
> > header and use the '<none>' to replace the empty buf_obj->name.
> >
> > Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Sumit do you want to push this or should I go ahead?

No worries, I can push it out.

Thanks :)
>
> > ---
> >   drivers/dma-buf/dma-buf.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 79795857be3e..a2f9a1815e38 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1351,7 +1351,7 @@ static int dma_buf_debug_show(struct seq_file *s,=
 void *unused)
> >               return ret;
> >
> >       seq_puts(s, "\nDma-buf Objects:\n");
> > -     seq_printf(s, "%-8s\t%-8s\t%-8s\t%-8s\texp_name\t%-8s\n",
> > +     seq_printf(s, "%-8s\t%-8s\t%-8s\t%-8s\texp_name\t%-8s\tname\n",
> >                  "size", "flags", "mode", "count", "ino");
> >
> >       list_for_each_entry(buf_obj, &db_list.head, list_node) {
> > @@ -1368,7 +1368,7 @@ static int dma_buf_debug_show(struct seq_file *s,=
 void *unused)
> >                               file_count(buf_obj->file),
> >                               buf_obj->exp_name,
> >                               file_inode(buf_obj->file)->i_ino,
> > -                             buf_obj->name ?: "");
> > +                             buf_obj->name ?: "<none>");
> >               spin_unlock(&buf_obj->name_lock);
> >
> >               dma_resv_describe(buf_obj->resv, s);
>

Best,
Sumit.
