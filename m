Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93611464F78
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbhLAOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:20:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38416 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbhLAOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:19:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4736CE1EC9;
        Wed,  1 Dec 2021 14:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65DAC53FAD;
        Wed,  1 Dec 2021 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638368179;
        bh=dNETAE48SGngHMkBimjmm+5Ifbx/aRR27K7m+rJiZ1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRlA2AQxJgXxIQpdn7yem+H5nYjeCOZwodyKgZ7zOSfC1hbvaqoYRW3vnQs7Qb47X
         7p4jp1iBfA6SucPHKFKN2vYpqJwSc9DWwKXTMubbDChPuy71kKd3zY95rfZ6b75OgA
         Z7dveoCaKEaLqvPpa+tn+LUsvilcFE9k+ZLGZjj1U8EsfoS+EyCTcAHNG64o/jYPnM
         5AKzY/6SsQe9zBbsWKDUun2mL5eOfGHRZFikFhqO9LahWTppv4PmDd5s4gLV+WlBR+
         IJiWW9FaMzKUURNIA9XKoDix6MnZRJa2C0az1LzRLhX1Iw2jRiaj0GX5TcBrYrGn2R
         iQg0BnU6MuUGQ==
Date:   Wed, 1 Dec 2021 22:16:07 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix a NULL pointer dereference in
 cdnsp_endpoint_init()
Message-ID: <20211201141607.GC3720@Peter>
References: <20211130172700.206650-1-zhou1615@umn.edu>
 <BYAPR07MB5381BE5297FA4905E8BD40C0DD689@BYAPR07MB5381.namprd07.prod.outlook.com>
 <BYAPR07MB53815000E619C1E80BFFD275DD689@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB53815000E619C1E80BFFD275DD689@BYAPR07MB5381.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-01 07:39:05, Pawel Laszczak wrote:
> Only fixed Peter Chen address email:
> peter.chen@nxp.com  doesn't exist, should be peter.chen@kernel.org
> 
> >-----Original Message-----
> >From: Pawel Laszczak
> >Sent: Wednesday, December 1, 2021 8:28 AM
> >To: Zhou Qingyang <zhou1615@umn.edu>
> >Cc: kjlu@umn.edu; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Peter Chen <peter.chen@nxp.com>; linux-
> >usb@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: RE: [PATCH] usb: cdnsp: Fix a NULL pointer dereference in cdnsp_endpoint_init()
> >
> >>
> >>In cdnsp_endpoint_init(), cdnsp_ring_alloc() is assigned to pep->ring
> >>and there is a dereference of it in cdnsp_endpoint_init(), which could
> >>lead to a NULL pointer dereference on failure of cdnsp_ring_alloc().
> >>
> >>Fix this bug by adding a check of pep->ring.
> >>
> >>This bug was found by a static analyzer. The analysis employs
> >>differential checking to identify inconsistent security operations
> >>(e.g., checks or kfrees) between two code paths and confirms that the
> >>inconsistent operations are not recovered in the current function or
> >>the callers, so they constitute bugs.
> >>
> >>Note that, as a bug found by static analysis, it can be a false
> >>positive or hard to trigger. Multiple researchers have cross-reviewed
> >>the bug.
> >>
> >>Builds with CONFIG_USB_CDNSP_GADGET=y show no new warnings,
> >>and our static analyzer no longer warns about this code.
> >>
> >>Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> >>Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> >>---
> >> drivers/usb/cdns3/cdnsp-mem.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >>
> >>diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
> >>index ad9aee3f1e39..97866bfb2da9 100644
> >>--- a/drivers/usb/cdns3/cdnsp-mem.c
> >>+++ b/drivers/usb/cdns3/cdnsp-mem.c
> >>@@ -987,6 +987,9 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
> >>
> >> 	/* Set up the endpoint ring. */
> >> 	pep->ring = cdnsp_ring_alloc(pdev, 2, ring_type, max_packet, mem_flags);
> >>+	if (!pep->ring)
> >>+		return -ENOMEM;
> >>+
> >> 	pep->skip = false;
> >>
> >> 	/* Fill the endpoint context */
> >>--
> >>2.25.1
> >
> >
> >Acked-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

> >
> >--
> >
> >Thanks,
> >Pawel Laszczak

-- 

Thanks,
Peter Chen

