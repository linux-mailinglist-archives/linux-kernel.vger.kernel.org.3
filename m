Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A794700E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhLJMpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhLJMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:45:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C96C061A72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:42:06 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id a24so7875234qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eO1oR3bssJVHG9Y26Y6bMlgt2qf5AyUrhg5Krs2dEgs=;
        b=nDHGUjCVp/Nzed1y5hlgRbG1rB1VpqFejneQkFUgnd/dOKi9xhgwHQdeHAU7UDO7dL
         LrYc4w9gGDZHDdSVQdmKeccT3bIBJv7XQs872y9Y9XmBMpsEqHghVBMYh1Jti+XjO52O
         5oG93oP6lP3YQYxXNywJisYGEi+hLH2uCUqTDaIh/Q1JWkkeuNkYpct45+7o7lGV0wEW
         xOqVnUOjCMIJRJDI3rkolyOSf0l2vFrO32O8YRFCag4oY1wM7wZGDFAM59KpogZqZPpm
         Iwzd5dUmyO/Y3bq4AshpPEOuX7z2kNyU7O/xsL9Dfv6wYok7wZgOUM+bfh0yRBCNlwSa
         QzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eO1oR3bssJVHG9Y26Y6bMlgt2qf5AyUrhg5Krs2dEgs=;
        b=0r8URup4a9J1dtaRbhx0C4JAXIFNBy2gajJrh//Jfv7uxbCPGapXXC6EMj8iWXXUPI
         zrIvYVK7Iu3csHaAegUsMymSQmXWmQfTR+CWIIhtk3aeTcpLo7ViqQMrn3Q7zykBOGyU
         egyoCVVt4OVqagapX7mNUKqkIY2kC0cIjtOhU77S6tnUiQ4zOKzPkqnXenOVZK5RrCtz
         8+r0jDaCuG8RhlLhweTBYVSnJIVS5dX6CGrRrem+2NyveYZ2hyPu8c7sFylfB8nlx+vZ
         0FQajmQNYiRB8ZyHvdpolo3b6dZwIR2IWtzeJP9eTsWpt9rcdfzGGjX9mwisaGjG7pFX
         WgmQ==
X-Gm-Message-State: AOAM530o1JY2VvMid1AoNkHxEtCapwC6J4GlzMQFbI2t0IUlDhkE1Xb1
        C0mOCvo7REmX8jJbhCZykV1Eig==
X-Google-Smtp-Source: ABdhPJzRWU9mGRPVsRFVZCG14NYr/la8f9ijUEtK7ktXons/NVCP2JFtcdHPZxBHFIA6Sx/+qJ1MWA==
X-Received: by 2002:a0c:f6c5:: with SMTP id d5mr24246637qvo.111.1639140125710;
        Fri, 10 Dec 2021 04:42:05 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n6sm1766301qtx.88.2021.12.10.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:42:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mvfDw-001eiM-2r; Fri, 10 Dec 2021 08:42:04 -0400
Date:   Fri, 10 Dec 2021 08:42:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [RFC PATCH v4 0/2] RDMA/rxe: Add dma-buf support
Message-ID: <20211210124204.GG6467@ziepe.ca>
References: <20211122110817.33319-1-mie@igel.co.jp>
 <CANXvt5oB8_2sDGccSiTMqeLYGi3Vuo-6NnHJ9PGgZZMv=fnUVw@mail.gmail.com>
 <20211207171447.GA6467@ziepe.ca>
 <CANXvt5rCayOcengPr7Z_aFmJaXwWj9VcWZbaHnuHj6=2CkPndA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5rCayOcengPr7Z_aFmJaXwWj9VcWZbaHnuHj6=2CkPndA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 08:29:24PM +0900, Shunsuke Mie wrote:
> Hi Jason,
> Thank you for replying.
> 
> 2021年12月8日(水) 2:14 Jason Gunthorpe <jgg@ziepe.ca>:
> >
> > On Fri, Dec 03, 2021 at 12:51:44PM +0900, Shunsuke Mie wrote:
> > > Hi maintainers,
> > >
> > > Could you please review this patch series?
> >
> > Why is it RFC?
> >
> > I'm confused why this is useful?
> >
> > This can't do copy from MMIO memory, so it shouldn't be compatible
> > with things like Gaudi - does something prevent this?
> I think if an export of the dma-buf supports vmap, CPU is able to access the
> mmio memory.
> 
> Is it wrong? If this is wrong, there is no advantages this changes..

I don't know what the dmabuf folks did, but yes, it is wrong.

IOMEM must be touched using only special accessors, some platforms
crash if you don't do this. Even x86 will crash if you touch it with
something like an XMM optimized memcpy.

Christian? If the vmap succeeds what rules must the caller use to
access the memory?

Jason
