Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED251466471
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhLBNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:23:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47208 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358205AbhLBNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:23:28 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3D6ED1F46508;
        Thu,  2 Dec 2021 13:20:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638451203; bh=wb6wZrB6CrdpvFdY2JMiuIUqjBwm6A1CO87QchUy4nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VTlDz/Ax+F1uGBBpltQyoVCsgarU84mFF+UVCQ3Ukd1WYVMSYH24U2Ds10bXtejP/
         oqeCyXLz8vWrZ6Mbqi/an1/lKblkS5KXhcCf83fmupll0eap/8+6jh4DIqrnrB/6f/
         7tBhmcL8nwln0MGuK+0MXef6RxJcWkV3/FhC5qFyA1p4jdI5PS7IXfTVh3r7zMrV5C
         HQWiP5uP8DAGLMzJ3BKM9AE+kGYXevP9Rm7hGQ/rhVZrnoMx8ySBGWsYC+GmjOfUq9
         5d+75dS2Kqj6Ce22hJDIYkXlKO077WosM14tAZsvzC7o2NRZrKV58nEtdNl1EiSn7f
         v0+jYgypeLofA==
Date:   Thu, 2 Dec 2021 14:19:58 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        sean@geanix.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [next] WARNING: CPU: 2 PID: 66 at kernel/locking/rwsem.c:1298
 __up_read
Message-ID: <20211202141958.638f224b@collabora.com>
In-Reply-To: <CADYN=9KeKhZ-OSbx1QHKYfXu+p-nXVjubbay1sXd_g75LLSZRg@mail.gmail.com>
References: <CA+G9fYuupqqemLbgoVL2kYL4d2AtZLBo1xcshWWae7gX5Ln-iA@mail.gmail.com>
        <CADYN=9KeKhZ-OSbx1QHKYfXu+p-nXVjubbay1sXd_g75LLSZRg@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 13:28:46 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> On Tue, 30 Nov 2021 at 18:01, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > [Please ignore this email if it is already reported]
> >
> > Regression found on qemu_arm64.
> > Following kernel warnings reported on Linux next-20211130 while booting.  
> 
> I bisected down to 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT")
> 
> and when I reverted 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT") and the
> 3 releated patches so patch 1ebe2e5f9d68 was reverted cleanly I
> managed to boot without
> a warning.
> 
> Related patches from next-20211130:
> 9f18db572c97 ("block: don't set GENHD_FL_NO_PART for hidden gendisks")
> 430cc5d3ab4d ("block: cleanup the GENHD_FL_* definitions")
> a4561f9fccc5 ("sr: set GENHD_FL_REMOVABLE earlier")
> 
> With this said, if I revert 9d6abd489e70 ("mtd: core: protect access
> to MTD devices while in suspend")
> I didn't see the warning either.

I think 9d6abd489e70 ("mtd: core: protect access to MTD devices while
in suspend") is at fault here. Miquel, would you mind
reverting/dropping the "mtd: core: protect access to mtd devices while
in  suspend" series?

> 
> Any idea what can be wrong here or what a fix could be?
> 
> Only apply this patch from Geert
> https://lore.kernel.org/lkml/c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be/
> makes the warning go away too.
> 
> Cheers,
> Anders

