Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB16C46FFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhLJLdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbhLJLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:33:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBBAC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:29:37 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id v15so13353772ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NoFmsSrPPIXAa6UPVY+mW7OCxWGbDYJZNT+23nos+Sg=;
        b=qWwEZ0dr3wB90wKhnvHvxBcIiKESCW7Al3Ey5haBrU1NXSjxw6Uk3WvGDEa73lpqKG
         oiOphDZpol/2qK5XeiKoCvwFEfbP+YBlSXRB/dFfSAo5X9qKzfR0oNKdlMAMQ5AQ8U8j
         R0Gvr1N/O5jjntEM1/7X2LjEU2aZJTmDvyzAM/jyGd0WqVl6RoRR5zgDWr3NaQOCGcdn
         g+9Sc5QNZ6eEU5cYybryGjYZJSR5eBFNLlYWNsZStFZTnAwIJz2D0DQYgDFWMiApQrsm
         3hkNlUbn6wXEVai/1RmAL2B+lMUBsYjU9WPgvuzyTtgvuDMBsr4fFoKyp7gcZvukpd1H
         fiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NoFmsSrPPIXAa6UPVY+mW7OCxWGbDYJZNT+23nos+Sg=;
        b=hh+wdmcHkkRd/RGxaRG9xWvK8/v1Z84dWX4etejIP+914wk8CCS6uG0XYpxc0LGfW3
         Ief+JK0gVgCmp/Z1TOTzkHq6AxDUm4c889s1jb36i+JBDkeyI+9nnNtP88Oo2Chzgr5y
         BSOE6UStAzuAR13ksT60mHqPNCFn9+nTtJVnD38iWxNseBSewuaTjMs4XO28YtlnzBEi
         LMX9aHtVGcRUrmhxqo0gdiHzC6ulEQcW+C+82coVz/vk614Ejr96PSnDiXS5FzTE038k
         dZdfrNQktw5XaQDWo9VCC3k+tUfwSNwZ27TN0VBpGgpaFn4dnW12RY8Sbo+hIdOdDZzX
         hyvA==
X-Gm-Message-State: AOAM533Z8sfTQolLy6sdtlinZLRyLeInV5QWRx5U5Q071ms6uzPGAsal
        NArSRqxkpKQs4d4bsn/pGf2oThpWewBzmqw50VIkBA==
X-Google-Smtp-Source: ABdhPJxW80fXD1lPzt8qWiH7Rg3BsOb2N9Z56Edp5343fNtBZQTJ4N/w3p0jxa7LzbmAiq6ABQIafercLd1qNZpj6cY=
X-Received: by 2002:a2e:6e0d:: with SMTP id j13mr11934080ljc.124.1639135775473;
 Fri, 10 Dec 2021 03:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20211122110817.33319-1-mie@igel.co.jp> <CANXvt5oB8_2sDGccSiTMqeLYGi3Vuo-6NnHJ9PGgZZMv=fnUVw@mail.gmail.com>
 <20211207171447.GA6467@ziepe.ca>
In-Reply-To: <20211207171447.GA6467@ziepe.ca>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 10 Dec 2021 20:29:24 +0900
Message-ID: <CANXvt5rCayOcengPr7Z_aFmJaXwWj9VcWZbaHnuHj6=2CkPndA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] RDMA/rxe: Add dma-buf support
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

Hi Jason,
Thank you for replying.

2021=E5=B9=B412=E6=9C=888=E6=97=A5(=E6=B0=B4) 2:14 Jason Gunthorpe <jgg@zie=
pe.ca>:
>
> On Fri, Dec 03, 2021 at 12:51:44PM +0900, Shunsuke Mie wrote:
> > Hi maintainers,
> >
> > Could you please review this patch series?
>
> Why is it RFC?
>
> I'm confused why this is useful?
>
> This can't do copy from MMIO memory, so it shouldn't be compatible
> with things like Gaudi - does something prevent this?
I think if an export of the dma-buf supports vmap, CPU is able to access th=
e
mmio memory.

Is it wrong? If this is wrong, there is no advantages this changes..
>
> Jason

Regards,
Shunsuke
