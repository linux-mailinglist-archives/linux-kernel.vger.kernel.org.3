Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0255925A6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiHNQ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243546AbiHNQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:56:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747F5BBA45;
        Sun, 14 Aug 2022 09:44:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r69so4819878pgr.2;
        Sun, 14 Aug 2022 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=pL8g1BLQVZvrcgdrkNSBsPwGKS843D7eAlV+Ro1JYLM=;
        b=k0ylHWRY53YY1+dlQ/dbkvmTjalxRlqlsppaDkMFbbTxq0XCzrdszvfqaNG/Nxr8py
         Kbgq1NVl7bhB6wOrf45pn0Mc+LvFtpLdp069E9Ft1DI382mxMMCmXTw1FLDoh9tWyYKT
         uHhujxKlnb2eEw982KEegE56z1jeOL/FOtw7eyRJJXxqU9bMWrf+srwYqQ09yIDmTENt
         zMkT5OK8PkEpnmdsrD+1hhZSZ5qIGc8byzvNxRZYGOevjM4ycwbrfo8T3Le3b6cGV2Z7
         cOHne/7l48Bk1kHcNm0kgwEDa/0FLEfQg0FjnJqQ+F3XAGZm1UebDYGurZdOXFqf1mlw
         toug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pL8g1BLQVZvrcgdrkNSBsPwGKS843D7eAlV+Ro1JYLM=;
        b=JcieTw1qKjZfh4H/ibFm13JCTZP/TSrnCrD7qfoQGPQJT867pXDRpRMH7GBzDu747g
         x45L9zgDxYMWtJ3CFfhVn0M6p0tbeolLjqwkHnGMRuYzVUqxYfDNLdEYNQGpQzNMXqXe
         dPkGHzTz/9QlI0PpxsAFrqR3VQrTFa8uZXL99hlxQ16PvacubSEWrnxV85HdP1PkHMse
         10QAnpubSB3W74S9nx89/nhZoMmnwreVDe3FlV0vr2DDCBj40R36n2bvQIhn+59U2kKy
         OXUyeESNVqpkX1r//CQ7Rf18AA3xgNlZzv2bmDsNblOeMJm0a/mVeBpaugjb7OX8/P8P
         F5Ow==
X-Gm-Message-State: ACgBeo07YFLXG/pEKieYlT6tNH9C5mcwc9z0JyDEbk6B7l7HvuUx2hLF
        zPtIbq2XvHBo0K/HFgTzQhI=
X-Google-Smtp-Source: AA6agR7HECHODK6Fh2XDOqfqhpiyfU71JkO8dMXKf22iSRHVqgW246kAntAKOSOqcWg48QKEVu2C/Q==
X-Received: by 2002:a63:d70c:0:b0:420:f9b6:9c3d with SMTP id d12-20020a63d70c000000b00420f9b69c3dmr10701076pgg.377.1660495460514;
        Sun, 14 Aug 2022 09:44:20 -0700 (PDT)
Received: from biggie ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001709e3c755fsm5584531plg.230.2022.08.14.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 09:44:20 -0700 (PDT)
Date:   Sun, 14 Aug 2022 22:14:14 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sean@mess.org, mchehab@kernel.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] drivers/media/rc: Ensure usb_submit_urb() is not called
 if write is in progress
Message-ID: <YvkmXiZ+8zM9uh+Q@biggie>
References: <20220814142543.24910-1-gautammenghani201@gmail.com>
 <YvkKdIL8UVhKrI0Q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvkKdIL8UVhKrI0Q@kroah.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 04:45:08PM +0200, Greg KH wrote:
> On Sun, Aug 14, 2022 at 07:55:42PM +0530, Gautam Menghani wrote:
> > The warning "URB submitted while active" is reported if the function
> > send_packet() in imon.c is called if a write is already is in progress.
> > Add a check to return -EBUSY in case a write is already is in progress.
> > Also, mark tx.busy as false after transmission is completed.
> > 
> > Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
> > Cc: hdanton@sina.com
> > Suggested-by: hdanton@sina.com
> > Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
> > Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
> > Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> > ---
> >  drivers/media/rc/imon.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> > index 735b925da998..a5b997c2c7e2 100644
> > --- a/drivers/media/rc/imon.c
> > +++ b/drivers/media/rc/imon.c
> > @@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
> >  	int retval = 0;
> >  	struct usb_ctrlrequest *control_req = NULL;
> >  
> > +	if (ictx->tx.busy)
> > +		return -EBUSY;
> 
> What happens if we go busy right after this check?  Where is the locking
> here to protect this?

All calls to send_packet() are protected with ictx->lock() held. Are you referring 
to something else?

Also, if we return busy, the task is interrupted and the packet transaction fails, 
just like the current behaviour. With the above patch, warning is not triggered.
Here's the log from running the reproducer (with patch applied).

imon 1-1:0.0: Looks like you're trying to use an IR protocol this device does not support
imon 1-1:0.0: Unsupported IR protocol specified, overriding to iMON IR protocol
rc rc0: iMON Remote (15c2:0040) as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.0/rc/rc0
input: iMON Remote (15c2:0040) as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.0/rc/rc0/input5
imon 1-1:0.0: iMON device (15c2:0040, intf0) on usb<1:2> initialized
imon:vfd_write: send packet #0 failed
imon:send_packet: task interrupted
imon:send_packet: packet tx failed (-2)
imon:vfd_write: send packet #0 failed
usb 1-1: USB disconnect, device number 2

Thanks,
Gautam
