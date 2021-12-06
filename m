Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8246A318
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbhLFRjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhLFRjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:39:21 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B11C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:35:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id p3so10552840qvj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6tr1Reds9kQ+9oe0dwUbB2J9W/qli+gaQlDjPxmEfS4=;
        b=F7SoMdCKTWe4fHyJuvunnrOPAxzBB4lpolo6nRqAwGST74pMZWBnqHgRGYsu/7UuYY
         fVXYK2L1YwziaEjkgnmVF1p8OnP0VtWAZjco2ua5k0vIo6svNewaTZovSOTGw1m2dqV8
         NSZE2gNXVzS0BZ4d58XOXuLHNPOrNo39W8g2RpkMZGrcwt9Gp/UqcQn9uvkOcdLjC2FJ
         ymodjvfvinpnzPkfofJZBq/0jgjCkiQqIpMo1u5i1Quh2D3hOwXGV4UHf0GaKRt16yAS
         Gfy/8WptgauXUvqdEnk2d+nQhDjDMfGdfhZiRyPWRFmPSKyLnuWzIEwEAqkOtp1wW7JR
         CTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6tr1Reds9kQ+9oe0dwUbB2J9W/qli+gaQlDjPxmEfS4=;
        b=x3cePriCXS52E5QGHaimsbWLBT19r+vp79bJb0UwWWgU38dlOqi/qfPwwWCl1FLm8P
         QEtC7j4Xo6HDbLOdNq9zcHCOT8QuabzlHe4ivUj8ZAlqnHjYWP6AeyGqCnj0kLAyyg5y
         mZRa17qAD7frmPIzIKJkyZhu0EOUkJID2/aZGlNRz3UjsSkb+tiGHWd8F+4cUsfGP/Zs
         eMekbY3Wq6/j9Ii+s5EYjMfauKSVkJ/16O8QfniUXsZvPznxPXLrkBIL57NcI1WcMTog
         f9QHbf/0TzW1OEGHLYBQ1GLZoKf7KCGy/3Z7rX2bf3OxmdQKtEhuu+Ufng16RCr+EpW6
         +kxw==
X-Gm-Message-State: AOAM533FVZsEYWGFfxcWYeEJ/fzhR/ZVuy5XCgADESAgz2U/ccKHsMGr
        feI++WgOeg7jFsFO+N+m5tEp3A==
X-Google-Smtp-Source: ABdhPJy5cwucofkTtdDk4ZZ/Cm2K69W2AHPBFpVCP/kzA2+aoLytcEaX+Bm6fPuGDllWHTOeYlMWXA==
X-Received: by 2002:a05:6214:f09:: with SMTP id gw9mr38210398qvb.36.1638812151598;
        Mon, 06 Dec 2021 09:35:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u27sm8429201qtc.58.2021.12.06.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:35:51 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1muHu2-00900W-BG; Mon, 06 Dec 2021 13:35:50 -0400
Date:   Mon, 6 Dec 2021 13:35:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
Message-ID: <20211206173550.GQ5112@ziepe.ca>
References: <000000000000c3eace05d24f0189@google.com>
 <20211206154159.GP5112@ziepe.ca>
 <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:46:40PM +0100, Dmitry Vyukov wrote:
> On Mon, 6 Dec 2021 at 16:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sat, Dec 04, 2021 at 01:54:17AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..
> >
> > ??
> >
> > This commit is nearly a year old?
> >
> > $ git describe --contains bf152b0b41dc
> > v5.12-rc4~28
> >
> > I think this has probably been fixed since, why did a report for such
> > an old kernel get sent?
> 
> Hi Jason,
> 
> Oh, that's because the arm32 kernel was broken for that period, so
> syzbot tested the latest working kernel. There is a more fresh x86_64
> crash available on the dashboard:
> https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74

??

There is nothing there newer than a year?

Jason
