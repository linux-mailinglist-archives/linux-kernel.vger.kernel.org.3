Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC22749BDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiAYVmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiAYVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:42:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE90C06173B;
        Tue, 25 Jan 2022 13:42:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j23so60604003edp.5;
        Tue, 25 Jan 2022 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfqL9mj2KCJbt88XzmWNl7ImpBHRr6UqUYUR2d96obI=;
        b=WhblZBYWEuHBiEdSzlkyeVNyauyH8c+tQWFhAdJl8nHQWD6u1YPolul4bbvkG5duVd
         ZEkk/zMHHxWVpH0oIQa8zXN1rlJK/qd2Cs2ygT4HZYj3tvfCShvceqg4lu+2r9MHcmgl
         O7ep1ntgVTjn5aVLkmiLVaoS52fK+19BBwltKPH513ITUESyMRJ28ciX50xH+HE3jreK
         g8uIgvsv70ByH/6MlIr4zPDc1A0sg7Oyjf2M9tGe7k5H7Lgghh/WFntPUv5G+QrFXgsD
         j/3RjKGxwGZDDcYL0B5w3gGSTCkuLD0bMWBZgbXJ/+zIYRCWAT37gnYXdaPjVIxTkzXP
         Op0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfqL9mj2KCJbt88XzmWNl7ImpBHRr6UqUYUR2d96obI=;
        b=y480uXmm/an4ke890xsYQ+76GDJxgXBG4HlRc0loyqjtNhYshkBcdJGhNdwhAKfeR9
         V+IoSXTBoG7/1kyqauz2k27RQVXQxMJ+W3IrW7aqxUbEeNz//mZLPh1avvz05x+n8zqi
         mYKMVccOee/MFouKpvqZDu73Obzuds5u4vVXxlBc6TRGw+6GXyjm1W9H9tQEnYywODcV
         43CSoQtq2evMr7R/puTwQ3i7m00RRxsl+6A8NWvHsrKPMVrQIIUnEU9hX0/eq4FIgR+F
         Yjfn2XWM4CJ7vm5AwOwk8xCxVHbNqOCMHPlBwF0q1kKPRrJkv01MytJ0Babgn5jaUvbn
         4gng==
X-Gm-Message-State: AOAM53115PMDcvoJ+pRbmZ+p0fjl6NOBuXqylL8L/x9xjzKWIXxpZBEJ
        hoLmWlYtI+Xuf+aJ0ISHEdE=
X-Google-Smtp-Source: ABdhPJyJLwT4XaGnVZrCLJDjFUS0NYqYmjWGZ7oYT+AkAgNyXA1uWspJA/VzUshsjTIDZBh4pp1Eaw==
X-Received: by 2002:aa7:c7c6:: with SMTP id o6mr22525003eds.32.1643146968986;
        Tue, 25 Jan 2022 13:42:48 -0800 (PST)
Received: from tom-ThinkPad-T470p (net-93-71-218-227.cust.vodafonedsl.it. [93.71.218.227])
        by smtp.gmail.com with ESMTPSA id a20sm8813711edb.12.2022.01.25.13.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:42:48 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:42:45 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
Cc:     "linuxfancy@googlegroups.com" <linuxfancy@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
Subject: Re: [PATCH] usb: usb251xb: add boost-up property support
Message-ID: <20220125214245.GA4196@tom-ThinkPad-T470p>
References: <20220121232612.7283-1-tomm.merciai@gmail.com>
 <Ye5PUpp9eMX9jSRe@ltleri2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye5PUpp9eMX9jSRe@ltleri2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:03:57AM +0000, Richard Leitner - SKIDATA wrote:
> Hi Tommaso,
> 
> thanks for implementing the boost up register.
> 
> On Sat, Jan 22, 2022 at 12:26:12AM +0100, Tommaso Merciai wrote:
> > Add u8 property to support boost-up register of usb251xb hub.
> > boost-up property control USB electrical drive strenght
> > This register can be set:
> > 
> >  - Normal mode -> 0x00
> >  - Low         -> 0x01
> >  - Medium      -> 0x10
> >  - High        -> 0x11
> > 
> > (Normal Default)
> > 
> > References:
> >  - http://www.mouser.com/catalog/specsheets/2514.pdf p29
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/usb/misc/usb251xb.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> > index 507deef1f709..74fd8ac0c303 100644
> > --- a/drivers/usb/misc/usb251xb.c
> > +++ b/drivers/usb/misc/usb251xb.c
> > @@ -402,6 +402,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
> >  	struct device_node *np = dev->of_node;
> >  	int len, err;
> >  	u32 property_u32 = 0;
> > +	u8 property_u8 = 0;
> >  	const char *cproperty_char;
> >  	char str[USB251XB_STRING_BUFSIZE / 2];
> >  
> > @@ -543,6 +544,12 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
> >  	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
> >  		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
> >  
> > +	if (!of_property_read_u8(np, "boost-up", &property_u8)){
> > +		hub->boost_up = property_u8;
> 
> IMHO we don't need the property_u8 var here as you could pass
> &hub->boost_up directly to of_property_read_u8() ?

Hi Richard,
Thanks for your reply. You mean like:

if (!of_property_read_u8(np, "boost-up", &hub->boost_up))

Let me know. I'll fix that in v2.

Thanks,
Tommaso
> 
> regards;rl
