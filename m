Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5343576803
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiGOUMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiGOUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:11:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040367C89
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:11:58 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1oCRfC-0006TK-7c; Fri, 15 Jul 2022 22:11:50 +0200
Date:   Fri, 15 Jul 2022 22:11:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: r888eu: use dynamic allocation for efuse buffer
Message-ID: <20220715201150.nnbdfc4tgj67zyic@viti.kaiser.cx>
References: <20220713075804.140986-1-martin@kaiser.cx>
 <5445d915-0c6c-b84f-158e-160e7645cbbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5445d915-0c6c-b84f-158e-160e7645cbbd@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thus wrote Pavel Skripkin (paskripkin@gmail.com):

> Hi Martin,

> Martin Kaiser <martin@kaiser.cx> says:
> > Use kmalloc to allocate the efuse buffer in ReadAdapterInfo8188EU and
> > free it on exit. This is better than using a 512 byte array on the stack.

> > It's ok to drop the __aligned(4) qualifier. kmalloc aligns to
> > ARCH_KMALLOC_MINALIGN, this is at least 8 bytes.

> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >   drivers/staging/r8188eu/hal/usb_halinit.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)

> > diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> > index 8902dda7b8d8..421fe7c40390 100644
> > --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> > +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> > @@ -926,7 +926,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
> >   {
> >   	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
> >   	struct led_priv *ledpriv = &Adapter->ledpriv;
> > -	u8 efuse_buf[EFUSE_MAP_LEN_88E] __aligned(4);
> > +	u8 *efuse_buf;
> >   	u8 eeValue;
> >   	int res;
> > @@ -937,7 +937,10 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
> >   	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
> > -	memset(efuse_buf, 0xFF, sizeof(efuse_buf));
> > +	efuse_buf = kmalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
> > +	if (!efuse_buf)
> > +		return;

> I think, it worth returning an error to caller. Functions right after the
> allocation do initialization, so leaving fields as-is seems to be dangerous

yes, that makes sense. We could refuse to load the driver in this case.

Larry and Greg already accepted the patch as is, I'll add error handling
in a separate patch.

Thanks,
   Martin
