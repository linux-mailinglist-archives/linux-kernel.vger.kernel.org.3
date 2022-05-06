Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5496051D720
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391564AbiEFMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbiEFMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:00:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC64A918
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:57:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so7187905plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QFEKTm3c/3DmlDrhE1ib/HKhjnKpS26QMeK/Vh3TqOw=;
        b=neOpOS03v4zvqDco6290dPcCpeZ9nA6siiN5SvxDBv5EiCUzLEtayElhYJCeQ5rECW
         KlxzIgqOfg0cX2+C1cvlsdsscKP0lGkA+heOh9pISozYz6ayM7+vksRIxrRfJXkEuOta
         CL1j/o4fx1+HMi1EPGxGt+dNyEoB+G76tgmdxBHgWOKKUY0fAF6xa/MJjtpyAdB/T6l5
         w69T3lUXTqPnxw9VIWUruTyCgZ88+7GVkBEkGE62SQgBQIEmiwz7MiLlMQl5i8mCjQDU
         X/J8apuU+M9Bytrz78ayolSq4DFPaB8x3/HSTWW8rg3n+1qcynVtk6NneqSUecZ55l9c
         a0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QFEKTm3c/3DmlDrhE1ib/HKhjnKpS26QMeK/Vh3TqOw=;
        b=kHMeNQP/PPlY9f0GSL+XqbrdGQwof+PiXmy5bki8uTgoN61QcgGXUpmLGQ1Vd0hWPx
         n9T7KuCxNsihcRyEb28T7ra3NwGhOy2WLGadRmU15g6RfSAAYVQObj/T+pCIrABbIQp4
         Se8ya/SrHQqrdnFkatvuLPLYOxVPhK6S7mAqcSv9p9x3L3eLfRV3X5Rz0NnTURxSPw9f
         sCyrOHE5vRIQEGtfX5ixmw8Fruwn1YIT0lLtlXYGsB0FqqEp8F/BaIVKVanyzhBqcvjF
         UtmXKzTX4lZ2agdVNk84qNItsK6bmdSh+6D9IzKlfLYJeAURN1eKDkJsG4ERcF7jutBY
         hHgQ==
X-Gm-Message-State: AOAM532gzy6XJ4r5knlg/nqMvbPNlBTzmBvjwWrRhH4tAm7eSe4vM0jO
        Up0Dmkl9C7UVe+syAH2czgMDtJSCl+mq6g==
X-Google-Smtp-Source: ABdhPJyGYYGy+SoZMbeVzpvs2C3ES+/XktW1UbrWBLIjcJukzKKs5gzS9+Jn1MTsJ+bz7GsypNhEdw==
X-Received: by 2002:a17:902:7888:b0:15e:be95:516b with SMTP id q8-20020a170902788800b0015ebe95516bmr3239742pll.104.1651838225813;
        Fri, 06 May 2022 04:57:05 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id y15-20020a170902b48f00b0015e8d4eb211sm1516274plr.91.2022.05.06.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 04:57:05 -0700 (PDT)
Date:   Fri, 6 May 2022 19:56:57 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
Message-ID: <20220506115657.vmowparwv5pcq2yy@ppc.localdomain>
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <14c3886173dfa4597f0704547c414cfdbcd11d16.1651760402.git.wanngchenng@gmail.com>
 <46b89616-5ec7-fb04-f561-2647efd968c4@gmail.com>
 <20220506113320.gc6zryhm7uqnbva5@ppc.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506113320.gc6zryhm7uqnbva5@ppc.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/06 07:33PM, Wang Cheng wrote:
> On 22/05/06 10:41AM, Pavel Skripkin wrote:
> > Hi Wang,
> > 
> > On 5/6/22 06:16, Wang Cheng wrote:
> > 
> > [snip]
> > 
> > > 
> > > Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> > > Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> > > ---
> > >   drivers/staging/rtl8712/usb_intf.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> > > index ee4c61f85a07..50dcd3ecb685 100644
> > > --- a/drivers/staging/rtl8712/usb_intf.c
> > > +++ b/drivers/staging/rtl8712/usb_intf.c
> > > @@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
> > >   		} else {
> > >   			AutoloadFail = false;
> > >   		}
> > > -		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
> > > +		if ((!AutoloadFail) ||
> > > +		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
> > >   		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
> > >   		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> > >   		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
> > >   		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
> > > -		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
> > > -		     (!AutoloadFail)) {
> > > +		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
> > 
> > 
> > That looks ugly. I mean mac checks. Can we, please, use sane kernel API like
> > is_valid_ether_addr()?
> 
> Good idea! But will is_valid_ether_addr() check a larger range?
> The comment of is_valid_ether_addr()(include/linux/etherdevice.h) says:
>   Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
>   a *multicast address*, and is not FF:FF:FF:FF:FF:FF.

is_zero_ether_addr() in etherdevice.h could check the all zero mac address.

thanks,
- w

> 
> 
> > 
> > 
> > >   			mac[0] = 0x00;
> > >   			mac[1] = 0xe0;
> > >   			mac[2] = 0x4c;
> > 
> > 
> > 
> > 
> > With regards,
> > Pavel Skripkin
