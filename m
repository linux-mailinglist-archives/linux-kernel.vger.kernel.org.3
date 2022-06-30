Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012465618AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiF3LDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiF3LDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:03:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88728403F1;
        Thu, 30 Jun 2022 04:03:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso2494691pjj.0;
        Thu, 30 Jun 2022 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8V7ADY+zFVOUBZ7Rju9ar4QXAaErxZ2CHOzbzSN9aU=;
        b=ghcVJngFT59Awjf2m+9tt7nkxAzRI7AzqoBXPWYNru3ZRPZsjKH/Ic/7qq1mtSJGfY
         /c+6+WG83JgVPEytgHUxTRJXf2mZoWeEH87TOzN/sPmiVZzUyDZJ3jd32XbX/GqiKvS+
         p6mRm5cLKJfdpeCdErCDzbaziT19/wEIyRO3Mzh/aVQV7ak/DPCSR/u9Z70N29roPJ/A
         AVNbuWq5nFZ0dFlJ0ONeoByVbEuibt0y3/y4CkhCYVpefBX/wd1/vRElsKFFWkDyyY3u
         xNAM0NubeP4aGLIhSdnjmvotlcaiLtcet6kjSVqeKPeH4fK8+eDFX4n2pbC6r595tZLW
         I7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8V7ADY+zFVOUBZ7Rju9ar4QXAaErxZ2CHOzbzSN9aU=;
        b=t4S5IfYDr59urdticpOE8i04jwqOqqlVUgxDBkbVD/GOrJDpx6fFW0Aqy4XOTWXR6w
         cQu1HzBtX6yfH9aovtHovH98czjjD77/f9zPLxevtiX/1AB/Zea2H8KStEy0FmAJR7hw
         eXqN6Ckd6jutCkTtB03yqVte+wHJ6/fHA3EquvtVHDhTDjPI692CDlZdj5YjIEOtSio3
         KUTmDKhpeWcq/BIBQUN2O004ukvYkz82AeLPcEQrhIbQStRfVvJsmn7MfuDd+B3xDFvV
         nPz0R3eUGYqBgMkAdjxt6LdtdyGMs02UXgFgoPdlmBdZfgcwyB5fLTA64H+i4TOR9Coa
         t3oQ==
X-Gm-Message-State: AJIora9egaYU45Ue+yRDBux0iIW5ruR/j12UyKKTZ+zEcSkgdV3x6inM
        xTBUVL5CKV6UX7dpzs6Jsbc=
X-Google-Smtp-Source: AGRyM1ukhTWAIPYaktK2CZ95Dz22JWNG1wp6pO6utXGwC8iUrqhPhxq8MXvgizcmNMtAKu/hlmW+Xw==
X-Received: by 2002:a17:90a:760e:b0:1ec:83e0:3ae1 with SMTP id s14-20020a17090a760e00b001ec83e03ae1mr11095167pjk.25.1656587029967;
        Thu, 30 Jun 2022 04:03:49 -0700 (PDT)
Received: from sebin-inspiron ([103.160.233.84])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b0016b82ff7072sm7509155plm.138.2022.06.30.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 04:03:49 -0700 (PDT)
Date:   Thu, 30 Jun 2022 16:33:42 +0530
From:   Sebin Sebastian <mailmesebin00@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] usb: gadget: dereference before null check
Message-ID: <Yr2DDkdFdt/A7pmL@sebin-inspiron>
References: <20220630044706.10772-1-mailmesebin00@gmail.com>
 <Yr1IjFBe6JjrDq8n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1IjFBe6JjrDq8n@kroah.com>
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

On Thu, Jun 30, 2022 at 08:54:04AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 30, 2022 at 10:17:06AM +0530, Sebin Sebastian wrote:
> > Fix coverity warning dereferencing before null check. _ep and desc is
> > dereferenced on all paths until the check for null. Move the
> > initializations after the check for null.
> 
> How can those values ever be NULL?
> 
> > Coverity issue: 1518209
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> kernel test robot did not find this issue.
> 
 After I submitted the PATCH v1, kernel test robot ran some tests and
 produced a report of the things that I broke while creating the patch.
 That's why I kept this tag.

> > Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> 
> What commit id does this change fix?
> 
 So should I provide the commit ID of the patch v1 that kernel
 test robot referred to?

> > ---
> >  Changes since v1: Fix the build errors and warnings due to first patch.
> >  Fix the undeclared 'ep' and 'maxpacket' error. Fix the ISO C90 warning.
> > 
> >  drivers/usb/gadget/udc/aspeed_udc.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> > index d75a4e070bf7..a43cf8dde2a8 100644
> > --- a/drivers/usb/gadget/udc/aspeed_udc.c
> > +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> > @@ -341,26 +341,33 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
> >  static int ast_udc_ep_enable(struct usb_ep *_ep,
> >  			     const struct usb_endpoint_descriptor *desc)
> >  {
> > -	u16 maxpacket = usb_endpoint_maxp(desc);
> > -	struct ast_udc_ep *ep = to_ast_ep(_ep);
> 
> checking that ep is NULL here is an impossible thing on its own.  You
> did change this so that you didn't check this anymore, which is odd as
> you did not mention that in the changelog text :(
> 
 Yes, I missed the checking for ep. I thought of checking it after
 initilizing ep.

> > -	struct ast_udc_dev *udc = ep->udc;
> > -	u8 epnum = usb_endpoint_num(desc);
> >  	unsigned long flags;
> >  	u32 ep_conf = 0;
> >  	u8 dir_in;
> >  	u8 type;
> > +	u16 maxpacket;
> > +	struct ast_udc_ep *ep;
> > +	struct ast_udc_dev *udc;
> > +	u8 epnum;
> 
> Why did you reorder these?
> 
This is actually the original order that these were in. I reordered it
while creating the first patch, then I changed it back to the original
order they were in the source tree for this patch.

> >  
> > -	if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
> > -	    maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
> > +	if (!_ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
> >  		EP_DBG(ep, "Failed, invalid EP enable param\n");
> >  		return -EINVAL;
> >  	}
> > -
> 
> Why did you remove this line?
>
I removed the check for maxpacket because it is not initialized in this
part, the check for the same thing comes after initialization.
This is the check for that, this is also included in the patch.
+	if (maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
+               EP_DBG(ep, "Failed, invalid EP enable param\n");
+               return -EINVAL;
+       }
Should I add the check for 'ep' in this part?

> Also, your To: line is messed up somehow, please fix your email
> client...
> 
Ok, I will surely do it.

> thanks,
> 
> gre gk-h

I did many mistakes in the patch v1, so I had to bring this patch to the
original state things were. I left all the declarations in the same
order (which made it seem like reordering) and moved the initialization
part after the check for _ep and desc. 
