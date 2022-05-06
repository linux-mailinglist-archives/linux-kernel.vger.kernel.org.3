Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7A51D6B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391376AbiEFLhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391357AbiEFLhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:37:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A25DF21
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:33:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so5872046pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kEe9bONQmq9ohWEt3TV5uTVzHHwOBhEohRih07NRtWU=;
        b=Vh3gSUvd46M0R/pWpy/3Mxaqvh/h7IOd21XkHmNWvJdvrc6V0kQZVM/Mri7fJgABWL
         yBYA43P/bYzJgkbdyHdqz6pfqN7eUnkJst96PVRF1R73uvfm9RJcQLqW0Nx2mPj/e+P1
         yoJQ9HOonpgIo1IHOFRfIdMU7deDMH0E+nb4JlFf48B/CkhZuqxUW/3c7UFeQrBIdkBn
         MHQI2Y3TfPDHUixdCR/RB9kac797kb06aOcbZxa0RQ5FPXJgW+uFDmBALvw3pnsU5KCR
         iI4aBnGgf0Pi/+xObtiCpfxnHBF/bboAoFbPDw3fVZztmekVeoJBTsyB9fiWtDSueF9M
         n9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kEe9bONQmq9ohWEt3TV5uTVzHHwOBhEohRih07NRtWU=;
        b=ibkc91makxJszZKiIP7kNPncCXmzWIuE9H3IbKdLflxwG5ClVxswtgvla0F3cFnMc0
         AibQ/iT61qFQwWoaXKF2+FOOZ84FfpSZir5bIwCWNZ6/Vzx87KZ+dlp0oNFsZgNRi1Nj
         Lc6oAPsNfqIO+6eUMAxEYEnhX7iPJe4r09CVa0ayWH+wBR78tNsf/g/3R3TUaq4TmT4N
         aKOQGgKBQPIC+/zW7EeTw9pvI7pzeie8HVPvqkNTMVCZ6AJWBccwcctlaYs1nfcwsLls
         OZq/ghRjF0xdqhu2dz0wB8Dy/kY3gao0CeKO7B3018ef3khz87GiG+Hw7c25Ptco0Fed
         2yNQ==
X-Gm-Message-State: AOAM533YjKK1ss/mo0HYKzg9Esx9ozkRsAVEnMTlPCYepOy+DxLX1IbB
        wbDxUvV9ioIvqOFB+ij9TIs6GxkKD+E=
X-Google-Smtp-Source: ABdhPJxRGp/GfZbKawE4vkOnEbaaJknMo2n9UA0O506I0ue5M1cEKDOqSt/Mw3L+3TUFxaf9quQbOw==
X-Received: by 2002:a63:d43:0:b0:3c1:475e:8341 with SMTP id 3-20020a630d43000000b003c1475e8341mr2353195pgn.533.1651836804467;
        Fri, 06 May 2022 04:33:24 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id d133-20020a621d8b000000b0050dc7628196sm3158093pfd.112.2022.05.06.04.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 04:33:23 -0700 (PDT)
Date:   Fri, 6 May 2022 19:33:20 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
Message-ID: <20220506113320.gc6zryhm7uqnbva5@ppc.localdomain>
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <14c3886173dfa4597f0704547c414cfdbcd11d16.1651760402.git.wanngchenng@gmail.com>
 <46b89616-5ec7-fb04-f561-2647efd968c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b89616-5ec7-fb04-f561-2647efd968c4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/06 10:41AM, Pavel Skripkin wrote:
> Hi Wang,
> 
> On 5/6/22 06:16, Wang Cheng wrote:
> 
> [snip]
> 
> > 
> > Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> > Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> > ---
> >   drivers/staging/rtl8712/usb_intf.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> > index ee4c61f85a07..50dcd3ecb685 100644
> > --- a/drivers/staging/rtl8712/usb_intf.c
> > +++ b/drivers/staging/rtl8712/usb_intf.c
> > @@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
> >   		} else {
> >   			AutoloadFail = false;
> >   		}
> > -		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
> > +		if ((!AutoloadFail) ||
> > +		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
> >   		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
> >   		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> >   		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
> >   		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
> > -		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
> > -		     (!AutoloadFail)) {
> > +		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
> 
> 
> That looks ugly. I mean mac checks. Can we, please, use sane kernel API like
> is_valid_ether_addr()?

Good idea! But will is_valid_ether_addr() check a larger range?
The comment of is_valid_ether_addr()(include/linux/etherdevice.h) says:
  Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
  a *multicast address*, and is not FF:FF:FF:FF:FF:FF.

thanks,
- w

> 
> 
> >   			mac[0] = 0x00;
> >   			mac[1] = 0xe0;
> >   			mac[2] = 0x4c;
> 
> 
> 
> 
> With regards,
> Pavel Skripkin
