Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB65113BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359557AbiD0Iv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbiD0IvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:51:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BC1738E5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37099B820BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6922FC385AA;
        Wed, 27 Apr 2022 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651049290;
        bh=GCSsrSfqFe47j3Z7zE0OfdO0l5Qo38nLWrsgnGBCesw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+0ZdgUEdGvBfDP8hWRlPPUtgDuOj5dc3AEfBF1/5LtdnpNKRAi/G9Pkg5uOhDKDh
         9J86mzUpH+iXsN5coWH+oYh7zNlxfBQovPvtZzij6h4VbGGIQ/cCTt74rlTLUWj0tx
         WjBltC/l6+NaRuAHdNhe7+EldhgzcX9pTurcH70M=
Date:   Wed, 27 Apr 2022 10:48:07 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Message-ID: <YmkDRxgW06qYsnep@kroah.com>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
 <Ymjaxby2vDJYz6KA@kroah.com>
 <b8853bc9a9d041009103b76bd02ce08d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8853bc9a9d041009103b76bd02ce08d@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:01:46AM +0000, David Laight wrote:
> From: Greg Kroah-Hartman
> > Sent: 27 April 2022 06:55
> > 
> > On Wed, Apr 27, 2022 at 07:42:23AM +0200, Philipp Hortmann wrote:
> > > Replace macro VNSvInPortD with ioread32 and as it was
> > > the only user, it can now be removed.
> > > The name of macro and the arguments use CamelCase which
> > > is not accepted by checkpatch.pl
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > > ---
> > > V1 -> V2: This patch was 5/7 and is now 4/6
> > > V2 -> V3: Inserted patch that was before in a different way in
> > >           "Rename macros VNSvInPortB,W,D with CamelCase ..."
> > >           This patch was part of 4/6 and is now 3/7
> > > V3 -> V4: Removed casting of the output variable
> > > V4 -> V5: Joint patch "Replace two VNSvInPortD with ioread64_lo_hi"
> > >           with this patch. Changed ioread64 to two ioread32 as
> > >           ioread64 does not work with 32 Bit computers.
> > >           Shorted and simplified patch description.
> > > V5 -> V6: Added missing version in subject
> > > ---
> > >  drivers/staging/vt6655/card.c        |  6 ++++--
> > >  drivers/staging/vt6655/device_main.c |  6 +++---
> > >  drivers/staging/vt6655/mac.h         | 18 +++++++++---------
> > >  drivers/staging/vt6655/rf.c          |  2 +-
> > >  drivers/staging/vt6655/upc.h         |  3 ---
> > >  5 files changed, 17 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> > > index 022310af5485..0dd13e475d6b 100644
> > > --- a/drivers/staging/vt6655/card.c
> > > +++ b/drivers/staging/vt6655/card.c
> > > @@ -744,6 +744,7 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
> > >  	void __iomem *iobase = priv->port_offset;
> > >  	unsigned short ww;
> > >  	unsigned char data;
> > > +	u32 low, high;
> > >
> > >  	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
> > >  	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
> > > @@ -753,8 +754,9 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
> > >  	}
> > >  	if (ww == W_MAX_TIMEOUT)
> > >  		return false;
> > > -	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
> > > -	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
> > > +	low = ioread32(iobase + MAC_REG_TSFCNTR);
> > > +	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> > > +	*pqwCurrTSF = low + ((u64)high << 32);
> > 
> > Are you _sure_ this is doing the same thing?
> > 
> > Adding 1 to a u64 pointer increments it by a full u64.  So I guess the
> > cast to u32 * moves it only by a u32?  Hopefully?  That's messy.
> 
> The new code is mostly better.
> But is different on BE systems - who knows what is actually needed.

Yeah, the endian issues here are totally ignored, my proposal would
ensure it stays the same.  The change here breaks this on big endian
systems.  So I'll drop this patch for now and just apply the first 2.

> Depends what is being copied.
> 
> Actually I suspect that 'iobase' should be an __iomem structure
> pointer, pqwCurrTSF a point of the same type and MAC_REG_xxxx
> structure members.
> 
> Then the code should be using readl() not ioread32().
> I very much doubt that 'iobase' is in PCI IO space.

Who knows, but that should be unwound eventually...

thanks,

greg k-h
