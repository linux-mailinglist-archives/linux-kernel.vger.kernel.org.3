Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04AE561A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiF3M0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiF3MZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:25:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4A2B254;
        Thu, 30 Jun 2022 05:25:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso2710193pjj.0;
        Thu, 30 Jun 2022 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkHYOhJM2c9y390Fvehg2as/eHGMXd+hD7+AN1EM9Hk=;
        b=PvO6+OEEu12TpdotNoiaVC3Y2k+hqoXKxzm/fust/MXyJGVsgJTQxopZTfpbouCTzm
         Z8bEBHZ1hE6ajbL85cIfM66xRco/8AGGpmLM/kRiDNeLSe7kWEkWTlxnfz+14XsmkGeZ
         pMnfyxqD18pAi+orXakcTAhOckimSL7bRyrBr/eKqIxW4QedsWhqkJ482SV06mK6ITxl
         uIzbI7B5vOzdXx2k8gouUGvkMoYgcM2KYH+kWMNd8qEZfeM1xMqt8Ff7WhFcFYn4Sk4s
         pC5iNDxGt7Fmeud71ORT9T7vSDe6zHX+f3449MY+oDsbJxx6XOYz3DMGsBzPwODEm9rX
         FHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkHYOhJM2c9y390Fvehg2as/eHGMXd+hD7+AN1EM9Hk=;
        b=kAPgrk9whWXWaoTMrK3ZhunuQHiHtFpZDJqxBOx+Ww/+vOKva/kL9kwov0AV/Y9yQ2
         zpFFth96P7CQMqUeyzp5k7r3SJqaLTFAKAS7yAL0uCH/VFZ8FY15XowN/CXZ/sbeB0LF
         OfwYXRRt2gD8X2DojQjU//mKZLU8Y4/wv0hxI8ZSKiBc8rfNsC2omMqDaxnGLVJDAKc3
         qtgkCFOgTFvX48viwzD8b84hVzcAEb9Nv3ikvyNFCoAg1n1Rtupu3xQQ4HGpYb2ih+s2
         Xtspo8iI0/03FKG9yqJyC65VZXb9IOsxWJlHZ1ZPbd0t9zBBJD2BOj1Hy8QmcAF4TkiO
         f3Jg==
X-Gm-Message-State: AJIora/3XmOf4m/H/yCbvdn419IGpckYMJ+a+dIHGiwCcGUvNvVu7qNV
        9gNfqr8qM675Ase8Qt7xUsc=
X-Google-Smtp-Source: AGRyM1umtmOk5qnLsnGcbL/ju4/z5YSUD/snffNJOlMAgvcpnx1K0zsBt6y3p4RhdDd6bvBdw20SMQ==
X-Received: by 2002:a17:903:1207:b0:16a:7e87:dad3 with SMTP id l7-20020a170903120700b0016a7e87dad3mr14402077plh.99.1656591958042;
        Thu, 30 Jun 2022 05:25:58 -0700 (PDT)
Received: from sebin-inspiron ([103.160.233.84])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090300d400b0016a1252976fsm13244844plc.107.2022.06.30.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 05:25:57 -0700 (PDT)
Date:   Thu, 30 Jun 2022 17:55:50 +0530
From:   Sebin Sebastian <mailmesebin00@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] usb: gadget: dereference before null check
Message-ID: <Yr2WTqafL1X565dE@sebin-inspiron>
References: <20220630044706.10772-1-mailmesebin00@gmail.com>
 <Yr1IjFBe6JjrDq8n@kroah.com>
 <Yr2DDkdFdt/A7pmL@sebin-inspiron>
 <Yr2EaEqEbYC7LViw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr2EaEqEbYC7LViw@kroah.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:09:28PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 30, 2022 at 04:33:42PM +0530, Sebin Sebastian wrote:
> > On Thu, Jun 30, 2022 at 08:54:04AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jun 30, 2022 at 10:17:06AM +0530, Sebin Sebastian wrote:
> > > > Fix coverity warning dereferencing before null check. _ep and desc is
> > > > dereferenced on all paths until the check for null. Move the
> > > > initializations after the check for null.
> > > 
> > > How can those values ever be NULL?
> > > 
> > > > Coverity issue: 1518209
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > kernel test robot did not find this issue.
> > > 
> >  After I submitted the PATCH v1, kernel test robot ran some tests and
> >  produced a report of the things that I broke while creating the patch.
> >  That's why I kept this tag.
> 
> Yes, but the kernel test robot reported your first patch was broken, not
> that this commit itself was reported by that.  Please drop that, it's
> confusing I know, and trips lots of people up, but is not needed here.
> 
> > 
> > > > Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> > > 
> > > What commit id does this change fix?
> > > 
> >  So should I provide the commit ID of the patch v1 that kernel
> >  test robot referred to?
> 
> No, report the commit id that this commit you are creating fixes.  It
> had to be added to the tree sometime in the past, right?
> 
> > 
> > > > ---
> > > >  Changes since v1: Fix the build errors and warnings due to first patch.
> > > >  Fix the undeclared 'ep' and 'maxpacket' error. Fix the ISO C90 warning.
> > > > 
> > > >  drivers/usb/gadget/udc/aspeed_udc.c | 21 ++++++++++++++-------
> > > >  1 file changed, 14 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> > > > index d75a4e070bf7..a43cf8dde2a8 100644
> > > > --- a/drivers/usb/gadget/udc/aspeed_udc.c
> > > > +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> > > > @@ -341,26 +341,33 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
> > > >  static int ast_udc_ep_enable(struct usb_ep *_ep,
> > > >  			     const struct usb_endpoint_descriptor *desc)
> > > >  {
> > > > -	u16 maxpacket = usb_endpoint_maxp(desc);
> > > > -	struct ast_udc_ep *ep = to_ast_ep(_ep);
> > > 
> > > checking that ep is NULL here is an impossible thing on its own.  You
> > > did change this so that you didn't check this anymore, which is odd as
> > > you did not mention that in the changelog text :(
> > > 
> >  Yes, I missed the checking for ep. I thought of checking it after
> >  initilizing ep.
> > 
> > > > -	struct ast_udc_dev *udc = ep->udc;
> > > > -	u8 epnum = usb_endpoint_num(desc);
> > > >  	unsigned long flags;
> > > >  	u32 ep_conf = 0;
> > > >  	u8 dir_in;
> > > >  	u8 type;
> > > > +	u16 maxpacket;
> > > > +	struct ast_udc_ep *ep;
> > > > +	struct ast_udc_dev *udc;
> > > > +	u8 epnum;
> > > 
> > > Why did you reorder these?
> > > 
> > This is actually the original order that these were in. I reordered it
> > while creating the first patch, then I changed it back to the original
> > order they were in the source tree for this patch.
> 
> So this patch does not apply cleanly on linux-next?  We did not apply
> your intermediate, broken, patch for obvious reasons, so you can not
> send a change on top of that, right?
> 
> > > >  
> > > > -	if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
> > > > -	    maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
> > > > +	if (!_ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
> > > >  		EP_DBG(ep, "Failed, invalid EP enable param\n");
> > > >  		return -EINVAL;
> > > >  	}
> > > > -
> > > 
> > > Why did you remove this line?
> > >
> > I removed the check for maxpacket because it is not initialized in this
> > part, the check for the same thing comes after initialization.
> > This is the check for that, this is also included in the patch.
> > +	if (maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
> > +               EP_DBG(ep, "Failed, invalid EP enable param\n");
> > +               return -EINVAL;
> > +       }
> > Should I add the check for 'ep' in this part?
> > 
> > > Also, your To: line is messed up somehow, please fix your email
> > > client...
> > > 
> > Ok, I will surely do it.
> > 
> > > thanks,
> > > 
> > > gre gk-h
> > 
> > I did many mistakes in the patch v1, so I had to bring this patch to the
> > original state things were. I left all the declarations in the same
> > order (which made it seem like reordering) and moved the initialization
> > part after the check for _ep and desc. 
> 
> 
> Perhaps you might want to start out doing coding style cleanups in
> drivers/staging/* to get the process of how to submit patches properly
> and test your changes before sending them out, before going out into the
> real part of the kernel.
> 
> thanks,
> 
> greg k-h
I am sorry to mess things up like this. I understand the entire process
of sending out patches and to not waste maintainer's time on these kind
of things.
This patch does apply cleanly on linux-next. There are no warnings or
errors while building and no checkpatch errors. Can I just send one
final patch including proper commit ID and the missing check for ep.
Thanks for pointing out all these mistakes.
