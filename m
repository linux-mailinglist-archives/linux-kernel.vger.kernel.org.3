Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BAA461140
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbhK2Jqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:46:51 -0500
Received: from first.geanix.com ([116.203.34.67]:37670 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234647AbhK2Jou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:44:50 -0500
Received: from skn-laptop (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id A396BE1F09;
        Mon, 29 Nov 2021 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1638178890; bh=NCEArx1B70jzAxcX0m4Z4cy7XyKhf3Y81vVBNvyz5Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JlGDa80F+jbVJ2g2JOvzWixbNqzNRqGdQ9yNkYCNv6R9ky6vKeL6zxx6pDpux3E/8
         9Of4HPzFnYgDViHO7WCLpRaoU39mNAwibE7Kqwx9mclj/d+P4HGxEGM5ZU3qC1GNiL
         VdxaZYtQE3T0DiXbZBwrGzGiGTTycP+V8EyOdpM1j2fOpjZhmtbDvK56/W+TSwzrxy
         HOeGRL3RmNv9LBUEDpZdUfHcOHO+MmcXP46fL2rwRU8LeJyAw39xBN5n3q/OoG2A2A
         N2CUEtllkWhfGMRm6PoQ8WMs9aW3r7KL1C/TMP6VSYjLJcCe/UrlBQS4WQYSW3R+5W
         sJ8q3Klk00Cyg==
Date:   Mon, 29 Nov 2021 10:41:29 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while in
 suspend
Message-ID: <20211129094129.xn364czofrgtvfb4@skn-laptop>
References: <20211102110204.3334609-1-sean@geanix.com>
 <20211102110204.3334609-4-sean@geanix.com>
 <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
 <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
 <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
 <20211123140715.280b2f70@collabora.com>
 <20211129101908.6f1aa715@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211129101908.6f1aa715@xps13>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:19:08AM +0100, Miquel Raynal wrote:
> Hi Sean,
> 
> boris.brezillon@collabora.com wrote on Tue, 23 Nov 2021 14:07:15 +0100:
> 
> > On Tue, 23 Nov 2021 13:50:12 +0100
> > Sean Nyekjaer <sean@geanix.com> wrote:
> > 
> > > @Boris do we need to do something similar here to what we did with the
> > > mtdconcat stuff?  
> > 
> > Absolutely, physmasp subdevices are never initialized/registered, so
> > you can't call any of the mtd helpers taking the suspend lock on those.
> > I guess it'd be better to call mtd_suspend/resume() on the concat device
> > in though:
> 
> Any chance that you will come up with a fix or v6 of the series anytime
> soon?
> 
> > 
> > static void physmap_flash_shutdown(struct platform_device *dev)
> > {
> > 	struct physmap_flash_info *info = platform_get_drvdata(dev);
> > 
> > 	mtd_suspend(info->cmtd);
> > }
> 
> 
> Thanks,
> Miquèl

Hi Miquèl,

I'm not 100% comfortable in doing this.

During this patch series I have mostly been Boris' tester and
implemented his ideas :/

I'm willing to give it a try, if Marek shares how to reproduce this with qemu :)

/Sean
