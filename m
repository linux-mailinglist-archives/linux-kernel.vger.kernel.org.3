Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A409473EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhLNJCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhLNJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:02:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985BC061748
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:02:46 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id v15so27397251ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jFBX9yl8OuZno/C6fLygAYklHtY6iYJvavTvIpDFcxo=;
        b=eOnBTKDAk48mXNMWjJMfNcm5m2oT2n7RkpgCV5azH66/22m89o5Dd+6UXFC4n2s9zY
         zN7vD2aYRZ1v1dzLejVTTn1PRXVoXAcxDX1AUVWmNHqlmYkGerHx4Z1gl7cYcknj1poX
         6hnuBLLCO6604rDn4NtH2c/+lLFBqlptbngyiddsBVckkBqKHyFoBErfukYk9s509U88
         hxkz71PHunNncPzyi/iaWK6FSb6J7K/1HbxWjRPQXtBGGJiv8T5v5IPDEgtSkjQtbgd7
         dqeXvFd6NCknuZL0CKtPizpDdSb+c0ezAKKqRuX+rg/+igOv0C3m5XYp6K+RD1hvuAGs
         zGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jFBX9yl8OuZno/C6fLygAYklHtY6iYJvavTvIpDFcxo=;
        b=ag+jxTV3o/fhRbxnBU0HtbRr3fJPqmZ62FeSSGiiScWerQfQp2t08Q/vWzGcY083SU
         zkj3u71LIqF5SQOC8YPg2rjbRNGiLKd+5a175CqkVFi+pTGcZVht99E+hr/6mEUpeeS+
         UBhjs1NXeVrLMLxKxqtvRdm7yFkaakaHjSLb8FCRBeb7VIMDvnZcowsOMvVpsc2CiHF+
         wZrkEesl2cfJAQIU9sqfPwKHxqZjDCNtQt9UVq2spWCBwCtn1dEQh5o/R7JdZEfCm1d/
         g0TMVX0qdv2QcocZRnF1ZGOn8nSSQpWgv72uF1PCh7tYUg8RO+2pLW4u6l+QyNZYSfnl
         sK6Q==
X-Gm-Message-State: AOAM530Xqc74G9TfYk8RGlCXEj9Zu4C+TGN6XmnaIN10JzOePsYSgjRF
        xsWLXQRjv1lEUTl3qqRT44W1iwMirFVWHVuPUSWhbQ==
X-Google-Smtp-Source: ABdhPJzch8DjAwgC+U70MPuToKQq3f+VPd1o4wk1gzly+UxZwlYNEPITNyH13qa9lAhfykr0jNmgObXlMM/g5DDYrt8=
X-Received: by 2002:a05:651c:1791:: with SMTP id bn17mr3741577ljb.525.1639472564655;
 Tue, 14 Dec 2021 01:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20211122110817.33319-1-mie@igel.co.jp> <CANXvt5oB8_2sDGccSiTMqeLYGi3Vuo-6NnHJ9PGgZZMv=fnUVw@mail.gmail.com>
 <20211207171447.GA6467@ziepe.ca> <CANXvt5rCayOcengPr7Z_aFmJaXwWj9VcWZbaHnuHj6=2CkPndA@mail.gmail.com>
 <20211210124204.GG6467@ziepe.ca> <880e25ad-4fe9-eacd-a971-993eaea37fc4@amd.com>
 <20211210132656.GH6467@ziepe.ca> <d25b2895-63b6-158d-ff73-f05e437e0f91@amd.com>
 <CANXvt5rzmEnF3Gph4U6NT-XzJhV6zqyay1g7dHkTgH=Aqc6Geg@mail.gmail.com> <51bcad64-8df8-b9a3-0aef-d88eb70fdbba@amd.com>
In-Reply-To: <51bcad64-8df8-b9a3-0aef-d88eb70fdbba@amd.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 14 Dec 2021 18:02:31 +0900
Message-ID: <CANXvt5qVrfeGthzckcZh8xgu1JPG1k84rh1Q-hn2a8K6o0yPJg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] RDMA/rxe: Add dma-buf support
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=E5=B9=B412=E6=9C=8814=E6=97=A5(=E7=81=AB) 17:54 Christian K=C3=B6nig <=
christian.koenig@amd.com>:
>
> Am 13.12.21 um 12:18 schrieb Shunsuke Mie:
> > 2021=E5=B9=B412=E6=9C=8810=E6=97=A5(=E9=87=91) 22:29 Christian K=C3=B6n=
ig <christian.koenig@amd.com>:
> >> Am 10.12.21 um 14:26 schrieb Jason Gunthorpe:
> >>> On Fri, Dec 10, 2021 at 01:47:37PM +0100, Christian K=C3=B6nig wrote:
> >>>> Am 10.12.21 um 13:42 schrieb Jason Gunthorpe:
> >>>>> On Fri, Dec 10, 2021 at 08:29:24PM +0900, Shunsuke Mie wrote:
> >>>>>> Hi Jason,
> >>>>>> Thank you for replying.
> >>>>>>
> >>>>>> 2021=E5=B9=B412=E6=9C=888=E6=97=A5(=E6=B0=B4) 2:14 Jason Gunthorpe=
 <jgg@ziepe.ca>:
> >>>>>>> On Fri, Dec 03, 2021 at 12:51:44PM +0900, Shunsuke Mie wrote:
> >>>>>>>> Hi maintainers,
> >>>>>>>>
> >>>>>>>> Could you please review this patch series?
> >>>>>>> Why is it RFC?
> >>>>>>>
> >>>>>>> I'm confused why this is useful?
> >>>>>>>
> >>>>>>> This can't do copy from MMIO memory, so it shouldn't be compatibl=
e
> >>>>>>> with things like Gaudi - does something prevent this?
> >>>>>> I think if an export of the dma-buf supports vmap, CPU is able to =
access the
> >>>>>> mmio memory.
> >>>>>>
> >>>>>> Is it wrong? If this is wrong, there is no advantages this changes=
..
> >>>>> I don't know what the dmabuf folks did, but yes, it is wrong.
> >>>>>
> >>>>> IOMEM must be touched using only special accessors, some platforms
> >>>>> crash if you don't do this. Even x86 will crash if you touch it wit=
h
> >>>>> something like an XMM optimized memcpy.
> >>>>>
> >>>>> Christian? If the vmap succeeds what rules must the caller use to
> >>>>> access the memory?
> >>>> See dma-buf-map.h and especially struct dma_buf_map.
> >>>>
> >>>> MMIO memory is perfectly supported here and actually the most common=
 case.
> >>> Okay that looks sane, but this rxe RFC seems to ignore this
> >>> completely. It stuffs the vaddr directly into a umem which goes to al=
l
> >>> manner of places in the driver.
> >>>
> >>> ??
> >> Well, yes that can go boom pretty quickly.
> > Sorry, I was wrong. The dma_buf_map treats both iomem and vaddr region,=
 but
> > this RFC only supports vaddr. Advantage of the partial support is we ca=
n use the
> > vaddr dma-buf in RXE without changing a rxe data copy implementation.
>
> Well that is most likely not a good idea.
>
> For example buffers for GPU drivers can be placed in both MMIO memory
> and system memory.
>
> If you don't want to provoke random failures you *MUST* be able to
> handle both if you want to use this.
I agree with you. I'll add the support and resubmit patch series.

Thanks a lot,
Shunsuke.
>
> Regards,
> Christian.
>
> >
> > An example of a dma-buf pointing to a vaddr is some gpu drivers use RAM=
 for
> > VRAM and we can get dma-buf for the region that indicates vaddr regions=
.
> > Specifically, the gpu driver using gpu/drm/drm_gem_cma_helper.c is one =
such
> > example.
> >
> >> Not sure what they want to use this for.
> > I'd like to use RDMA with RXE for that memory region.
> >
> > Best,
> > Shunsuke
> >> Christian.
> >>
> >>> Jason
>
