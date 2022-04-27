Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E35511323
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359236AbiD0IFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Apr 2022 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiD0IFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:05:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85DB22A7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:01:50 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-BVrDXIS1P7uuIKPSUrae-A-1; Wed, 27 Apr 2022 09:01:47 +0100
X-MC-Unique: BVrDXIS1P7uuIKPSUrae-A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 27 Apr 2022 09:01:46 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 27 Apr 2022 09:01:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
CC:     Forest Bond <forest@alittletooquiet.net>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Thread-Topic: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with
 ioread32
Thread-Index: AQHYWftqR1H/yljgC0KSKJflip6fA60DZMOg
Date:   Wed, 27 Apr 2022 08:01:46 +0000
Message-ID: <b8853bc9a9d041009103b76bd02ce08d@AcuMS.aculab.com>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
 <Ymjaxby2vDJYz6KA@kroah.com>
In-Reply-To: <Ymjaxby2vDJYz6KA@kroah.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman
> Sent: 27 April 2022 06:55
> 
> On Wed, Apr 27, 2022 at 07:42:23AM +0200, Philipp Hortmann wrote:
> > Replace macro VNSvInPortD with ioread32 and as it was
> > the only user, it can now be removed.
> > The name of macro and the arguments use CamelCase which
> > is not accepted by checkpatch.pl
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > ---
> > V1 -> V2: This patch was 5/7 and is now 4/6
> > V2 -> V3: Inserted patch that was before in a different way in
> >           "Rename macros VNSvInPortB,W,D with CamelCase ..."
> >           This patch was part of 4/6 and is now 3/7
> > V3 -> V4: Removed casting of the output variable
> > V4 -> V5: Joint patch "Replace two VNSvInPortD with ioread64_lo_hi"
> >           with this patch. Changed ioread64 to two ioread32 as
> >           ioread64 does not work with 32 Bit computers.
> >           Shorted and simplified patch description.
> > V5 -> V6: Added missing version in subject
> > ---
> >  drivers/staging/vt6655/card.c        |  6 ++++--
> >  drivers/staging/vt6655/device_main.c |  6 +++---
> >  drivers/staging/vt6655/mac.h         | 18 +++++++++---------
> >  drivers/staging/vt6655/rf.c          |  2 +-
> >  drivers/staging/vt6655/upc.h         |  3 ---
> >  5 files changed, 17 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> > index 022310af5485..0dd13e475d6b 100644
> > --- a/drivers/staging/vt6655/card.c
> > +++ b/drivers/staging/vt6655/card.c
> > @@ -744,6 +744,7 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
> >  	void __iomem *iobase = priv->port_offset;
> >  	unsigned short ww;
> >  	unsigned char data;
> > +	u32 low, high;
> >
> >  	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
> >  	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
> > @@ -753,8 +754,9 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
> >  	}
> >  	if (ww == W_MAX_TIMEOUT)
> >  		return false;
> > -	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
> > -	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
> > +	low = ioread32(iobase + MAC_REG_TSFCNTR);
> > +	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> > +	*pqwCurrTSF = low + ((u64)high << 32);
> 
> Are you _sure_ this is doing the same thing?
> 
> Adding 1 to a u64 pointer increments it by a full u64.  So I guess the
> cast to u32 * moves it only by a u32?  Hopefully?  That's messy.

The new code is mostly better.
But is different on BE systems - who knows what is actually needed.
Depends what is being copied.

Actually I suspect that 'iobase' should be an __iomem structure
pointer, pqwCurrTSF a point of the same type and MAC_REG_xxxx
structure members.

Then the code should be using readl() not ioread32().
I very much doubt that 'iobase' is in PCI IO space.

	David

> 
> Why not keep the current mess and do:
> 	pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
> 	((u32 *)pqwCurTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> 
> Or does that not compile?  Ick, how about:
> 	u32 *temp = (u32 *)pqwCurTSF;
> 
> 	temp = ioread32(iobase + MAC_REG_TSFCNTR);
> 	temp++;
> 	temp = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> As that duplicates the current code a bit better.
> 
> I don't know, it's like polishing dirt, in the end, it's still dirt...
> 
> How about looking at the caller of this to see what it expects to do
> with this information?  Unwind the mess from there?
> 
> thanks,
> 
> greg k-h

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

