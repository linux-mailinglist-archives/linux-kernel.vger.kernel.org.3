Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FD502884
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344121AbiDOKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiDOKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:54:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB28A5EAC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:51:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k62so956191pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qr7gFSJEZayaVAEa120nHgvdk+ECUuPJNVKWT+OnN8k=;
        b=bpNLh2Q6/xnTIHW0l7y8jXtMPKpCM+CkbwEJZyk2N5s3GvxYRQHVz2X4KQOq0hGMuj
         9cK5+S0gnayrnF43SF32u+ri3DK0TpvQL/K7L6vXaEfwN09yULUNL3gvm8R1Rc/H6HiV
         OxVdZNTZPFtEBIzbqluTdh1gVc1KOuP5VPz0hr6S4G6Yku7fgOPPQXbu0EpCm04fy3LL
         jVd1FEhsNkyIWXcE07Ce5FufZNEe2E7iqTQ1ENfpW0YgpnfKo9NaqiQa2QLMzWJT1FHm
         hP2QjbC6cx139B/OflQ56A+Pm1qnq/SlaNMtjmgqRTENU010xW9aKxcdUuKtxEyefZjY
         bA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qr7gFSJEZayaVAEa120nHgvdk+ECUuPJNVKWT+OnN8k=;
        b=i8Bs9slawSqeuA4yoUMVmF8c3CMpFSNAQX46GkTov2FvjYLTCQ+66lxJPAD/vhO52/
         rfdOyzCksV9zu4mVKwlncLRY+ue3zgG0ZLo9eHZ+iBS1Fhv/D7j235aL13H0Hper1tbM
         B2ixhgaMq/rdEfcQC2LkH9j4EXyeR7eF+VZTdTyoL/ZZnuNzO40650e0CrcUGzupyDNh
         kkEvTGBPM1ozM+wGgBzrwFZBV197W2ZqaPR7y/TI3gKzI3gC8EyxV+PzVU1SoBlw5Ma6
         67A/g8fVXA6dNJwiNousLR1pd2itJ5Srd1kzQYG/7E1nL/1WChE7xrFMr0j059GEmFNH
         bFZA==
X-Gm-Message-State: AOAM531IsS+NLFTGplvt3M4me4Ig7DAmq2v2P1wsb7G9lVheXfZ2aPcZ
        fikEDyGfvt31doWrLtnZvuY=
X-Google-Smtp-Source: ABdhPJyrQzfy9FttfDngmFFkBkaljihRst4amBu012N4/4OFnQUduBrYcVJfIRvHxjhKG9mXSG7M9A==
X-Received: by 2002:a65:5286:0:b0:398:dad:c3d8 with SMTP id y6-20020a655286000000b003980dadc3d8mr5974878pgp.228.1650019916062;
        Fri, 15 Apr 2022 03:51:56 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id x39-20020a056a0018a700b004fa7e6ceafesm2563415pfh.169.2022.04.15.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 03:51:55 -0700 (PDT)
Date:   Fri, 15 Apr 2022 18:51:52 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220415105152.nwj4gd7pizco2kkx@ppc.localdomain>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <20220414154215.GL3293@kadam>
 <20220415094705.aibh3jr4wzhddmud@ppc.localdomain>
 <20220415095721.GR3293@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415095721.GR3293@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/15 12:57PM, Dan Carpenter wrote:
> On Fri, Apr 15, 2022 at 05:47:05PM +0800, Wang Cheng wrote:
> > Hi Dan, thx for your review.
> > 
> > On 22/04/14 06:42PM, Dan Carpenter wrote:
> > > On Thu, Apr 14, 2022 at 10:12:23PM +0800, Wang Cheng wrote:
> > > > Due to the case that "requesttype == 0x01 && status <= 0"
> > > > isn't handled in r8712_usbctrl_vendorreq(),
> > > > "data" (drivers/staging/rtl8712/usb_ops.c:32)
> > > > will be returned without initialization.
> > > > 
> > > > When "tmpU1b" (drivers/staging/rtl8712/usb_intf.c:395)
> > > > is 0, mac[6] (usb_intf.c:394) won't be initialized,
> > > > which leads to accessing uninit-value on usb_intf.c:541.
> > > 
> > > These line numbers are sort of useless because everyone is on a
> > > different git hash.
> > 
> > I will correct this.
> > 
> > >
> > > > 
> > > > Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> > > > Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8712/usb_intf.c      |  6 +++---
> > > >  drivers/staging/rtl8712/usb_ops_linux.c | 14 ++++++++------
> > > >  2 files changed, 11 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> > > > index ee4c61f85a07..50dcd3ecb685 100644
> > > > --- a/drivers/staging/rtl8712/usb_intf.c
> > > > +++ b/drivers/staging/rtl8712/usb_intf.c
> > > > @@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
> > > >  		} else {
> > > >  			AutoloadFail = false;
> > > >  		}
> > > > -		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
> > > > +		if ((!AutoloadFail) ||
> > > > +		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
> > > >  		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
> > > >  		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> > > >  		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
> > > >  		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
> > > > -		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
> > > > -		     (!AutoloadFail)) {
> > > > +		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
> > > >  			mac[0] = 0x00;
> > > >  			mac[1] = 0xe0;
> > > >  			mac[2] = 0x4c;
> > > 
> > > This is a separate fix from the rest of the patch.  Send it by itself.
> > 
> > Ah, thought to send a patch series.
> > 
> 
> Yes, please.  Send two patches.
> 
> > > 
> > > 
> > > > diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> > > > index f984a5ab2c6f..e321ca4453ca 100644
> > > > --- a/drivers/staging/rtl8712/usb_ops_linux.c
> > > > +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> > > > @@ -495,12 +495,14 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
> > > >  	}
> > > >  	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
> > > >  				 pIo_buf, len, 500);
> > > > -	if (status > 0) {  /* Success this control transfer. */
> > > > -		if (requesttype == 0x01) {
> > > > -			/* For Control read transfer, we have to copy the read
> > > > -			 * data from pIo_buf to pdata.
> > > > -			 */
> > > > -			memcpy(pdata, pIo_buf,  status);
> > > > +	/* For Control read transfer, copy the read data from pIo_buf to pdata
> > > > +	 * when control transfer success; otherwise init *pdata with 0.
> > > > +	 */
> > > > +	if (requesttype == 0x01) {
> > > > +		if (status > 0)
> > > > +			memcpy(pdata, pIo_buf, status);
> > > > +		else
> > > > +			*(u32 *)pdata = 0;
> > > >  		}
> > > 
> > > This isn't really correct.  In many cases status is "len" is less than 4.
> > > I'm slightly surprised that nothing complains about that as an
> > > uninitialized access.  But then another problem is that "status" can be
> > > less than "len".
> > 
> > Sorry, I should explain it clearly. If I did right, watching "status"
> > with gdb while running syzkaller reproducer, "status" returns from
> > usb_control_msg() is -71. In which case, *pdata won't be touched in
> > r8712_usbctrl_vendorreq(). As a result, "data" in
> > usb_read8()/usb_read16()/usb_read32() will be returned without
> > initialization. I think that is why kmsan reports:
> > Local variable data created at:
> >  usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
> >  r8712_read8+0xa5/0xd0 drivers/staging/rtl8712/rtl8712_io.c:29
> 
> Yes.  I understood that.
> 
> > 
> > > 
> > > A better fix instead of setting pdata to zero would be to add error
> > > checking in the callers and then change this code to use
> > > usb_control_msg_send/recv().  Probably just initialize "data" in the
> > > callers as well.
> > 
> > I tried something similar which also works fine, but I think this patch
> > does't fix it at root.
> > https://syzkaller.appspot.com/text?tag=Patch&x=15be2970f00000
> > 
> 
> Ugh...  Sorry, I had not looked closely at usb_read8() and friends.
> (This code is all so terrible).  Ideally they would have some way to
> return errors.  Oh well.  Anyway, I guess do like this:
> 
> 	status = r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
> 					 &data, len, requesttype);
> 	if (status < 0)
> 		return 0;
> 	return (u8)(le32_to_cpu(data) & 0x0ff);
> 
> But in r8712_usbctrl_vendorreq() you really need to make the other
> changes I mentioned as well.  If you want to do it as a separate patch
> that's fine too.
> 
> 	if (status < 0)
> 		return status;
> 	if (status != len)
> 		return -EREMOTEIO;
> 
> 	if (reqtype == 0x1)
> 		memcpy();
> 
> 	return 0;

Thx for your time and advice, Dan. Yeah, the code logic looks not easy.
I will think about these code snippets and handle them.

thanks,
-- w
