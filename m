Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D0855FF96
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiF2MPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiF2MPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:15:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212351CB23;
        Wed, 29 Jun 2022 05:15:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l2so14337558pjf.1;
        Wed, 29 Jun 2022 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIylpPsCi1ABfV76nWqOfFV4XRKIutPZz0K9Tp2LFOs=;
        b=hEgZ7x9S/UmFFpJP6ILkWqIiAIijBVgh/17UnOdeP4h/8EVNVHwK6Sf5QwY9W07TfL
         fc82dLWOLOerZOEdwY0Gn7oM0fCiArB35bcVUXgdN5JR6UHTPdK21RvIvLYRIV83VMJ5
         Dbfqp22pSs2CAcDCHMuatIFTg2Al4tiijmqlixG9WEszg2LRbDKwI3wtkwwZ+uDPBzAw
         21flIiBHL8BqfPwbZhZhsWhCinwakwDPQc1NMgPIvBacX2qcwiAWzj9XvtyEqYo68fV9
         /GO3GKMrT3gYOuVxA4Y55Mp4TZCguAVE56rnAuwKi2tsvlQSH2J/UYAwIzAEWNdN4R3T
         IHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIylpPsCi1ABfV76nWqOfFV4XRKIutPZz0K9Tp2LFOs=;
        b=cDFGTAZNH3DNDF7zx6/RFVWzACHTCWhtlF8qhqT+lWO6OX3/auGtfL7RXmi5fJYIgO
         InXbcyzsTaBACtGvggE9vQdW1BYaUDQYyppcT8DsrvouGRo2x3Qt7Fc+u2og6zZRIKV2
         65m2na1L7E0LTIsPvX69vHvYZJjQoIxSek0L8rT6vp7ZIn4rXBlcxR52O7bqj9ON3/Q0
         e8IfpSzTomHLbe8diMlS+r7Tq8uT7dw2ZmC0T3jFp4XRfz1l5ShW5lzSSMdh+7trsCdW
         k1Lw16d42kZ0wGQu5ZblX2zLY3ki7NCWM1LjZr71ksCcG5erfnjr9iVaq5EVDJKRTZP8
         3KoA==
X-Gm-Message-State: AJIora/y+1ER6ABitW3jX2HXSttTN9E0CLnF1jCAcmo9Cx61jL82YMRp
        0gp68zNLbGksSrm4CGVRvHc=
X-Google-Smtp-Source: AGRyM1u6hbzWp4S+iMWlHW2RimxNvNSEmwFQFCSTNBB1DoA0RlhNEq+qsoUpMlMKYTptqX0hE37lOA==
X-Received: by 2002:a17:90b:1b11:b0:1ed:37b0:be25 with SMTP id nu17-20020a17090b1b1100b001ed37b0be25mr3517713pjb.99.1656504902573;
        Wed, 29 Jun 2022 05:15:02 -0700 (PDT)
Received: from sebin-inspiron ([103.160.233.84])
        by smtp.gmail.com with ESMTPSA id m14-20020a056a00080e00b00525b61f4792sm6365353pfk.109.2022.06.29.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:15:01 -0700 (PDT)
Date:   Wed, 29 Jun 2022 17:44:55 +0530
From:   Sebin Sebastian <mailmesebin00@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: gadget: dereference before null check
Message-ID: <YrxCP4EE2jhUm8e+@sebin-inspiron>
References: <20220629080726.107297-1-mailmesebin00@gmail.com>
 <YrwMJ+3mdFO2Lpm0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrwMJ+3mdFO2Lpm0@kroah.com>
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 10:24:07AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 29, 2022 at 01:37:25PM +0530, SebinSebastian wrote:
> > Fix coverity warning dereferencing before null check. _ep and desc is
> > dereferenced on all paths until the check for null. Move the
> > initializations after the check for null.
> > Coverity issue: 1518209
> > 
> > Signed-off-by: SebinSebastian <mailmesebin00@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed_udc.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> > index d75a4e070bf7..96f8193fca15 100644
> > --- a/drivers/usb/gadget/udc/aspeed_udc.c
> > +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> > @@ -341,10 +341,6 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
> >  static int ast_udc_ep_enable(struct usb_ep *_ep,
> >  			     const struct usb_endpoint_descriptor *desc)
> >  {
> > -	u16 maxpacket = usb_endpoint_maxp(desc);
> > -	struct ast_udc_ep *ep = to_ast_ep(_ep);
> > -	struct ast_udc_dev *udc = ep->udc;
> > -	u8 epnum = usb_endpoint_num(desc);
> >  	unsigned long flags;
> >  	u32 ep_conf = 0;
> >  	u8 dir_in;
> > @@ -356,6 +352,11 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
> >  		return -EINVAL;
> >  	}
> > 
> > +	u16 maxpacket = usb_endpoint_maxp(desc);
> > +	struct ast_udc_ep *ep = to_ast_ep(_ep);
> > +	struct ast_udc_dev *udc = ep->udc;
> > +	u8 epnum = usb_endpoint_num(desc);
> > +
> >  	if (!udc->driver) {
> >  		EP_DBG(ep, "bogus device state\n");
> >  		return -ESHUTDOWN;
> > --
> > 2.34.1
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - Your patch breaks the build.
> 
> - Your patch contains warnings and/or errors noticed by the
>   scripts/checkpatch.pl tool.
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

I am sorry to keep on bothering with this incorrect patches. I am
running the checkpatch script everytime before I sent any patches. It is
not showing any warnings or errors. Is it because of my name that my
patches are getting rejected? I can see a space missing.

