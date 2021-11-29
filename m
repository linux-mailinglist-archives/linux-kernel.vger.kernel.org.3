Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4E4610FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbhK2JYi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 04:24:38 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:48615 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbhK2JWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:22:30 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 36F2E200008;
        Mon, 29 Nov 2021 09:19:09 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:19:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211129101908.6f1aa715@xps13>
In-Reply-To: <20211123140715.280b2f70@collabora.com>
References: <20211102110204.3334609-1-sean@geanix.com>
        <20211102110204.3334609-4-sean@geanix.com>
        <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
        <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
        <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
        <20211123140715.280b2f70@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

boris.brezillon@collabora.com wrote on Tue, 23 Nov 2021 14:07:15 +0100:

> On Tue, 23 Nov 2021 13:50:12 +0100
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > @Boris do we need to do something similar here to what we did with the
> > mtdconcat stuff?  
> 
> Absolutely, physmasp subdevices are never initialized/registered, so
> you can't call any of the mtd helpers taking the suspend lock on those.
> I guess it'd be better to call mtd_suspend/resume() on the concat device
> in though:

Any chance that you will come up with a fix or v6 of the series anytime
soon?

> 
> static void physmap_flash_shutdown(struct platform_device *dev)
> {
> 	struct physmap_flash_info *info = platform_get_drvdata(dev);
> 
> 	mtd_suspend(info->cmtd);
> }


Thanks,
Miquèl
