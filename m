Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FFC5ABE32
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiICJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiICJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 05:38:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58789B56D5;
        Sat,  3 Sep 2022 02:38:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q15so4131141pfn.11;
        Sat, 03 Sep 2022 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9JI/4sTLYEP4qjrqdu4vBGJWCWh4ts5jBH6TaDxFm2M=;
        b=XMwQvR+wAp9DfsI7ldrGy0tzrOwPV3hrOAsDk5oJOvE1dM5Jmk0sRc6dBhr4PFYoYx
         uNmljk0/PEX+lQCCg9/PaQoqQFPL/Ojf0KEUxVBAHMyZBH/3KRraVhaVcGyViXQWN+he
         pt3VrL4rh7CUjICaQxA1LOH8EqPn+xUDrkbJht1NNG90/6D3YjKQ5fakjgqKgYe4KsQ+
         LFEpnEc3IAsWsEmjsdiyVH2lvaI8r+MGCZTMPOj3mbpvhc+FsT9OxUphtC9uu5q62jza
         N4olFDuPE1tcnjr1g7vLzRZZd2R6U092WePm5lGEN+hIlwd+badTdRvdFFI3VkTQxaFE
         ZGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9JI/4sTLYEP4qjrqdu4vBGJWCWh4ts5jBH6TaDxFm2M=;
        b=cJd4ND2vWnATHBDdKvep9lTpjbGDRyQbafjGTw8G2GDeHM1X5CLwQmThTS9ev59yiM
         RMT9QxhZUT87DFi3qUrYZ0RWVYB0m3Rvn3xUGQNwWpwxS4Ami/VAS2UUF1w5zow8vqQN
         C2pijar7FHguiq/TA2lG7jgkig4cSv2NvO7IrB6eEAEXByGFXdsu3NLODxvhSMN8VIKS
         Ktz3FL27Hn/k3/abz4wKWwFwMM23dOxr9i5kWNtQlRtcTCFZjVqyA3l3NALVMEuNe/tg
         B57YiKfZtMOLG48ZQrlhNfl1Od54I2k7f5Zt1t8URDgbPrjU1+bWu0MH91uE109BrOvU
         BfnA==
X-Gm-Message-State: ACgBeo3tE8xmhfrZMvcN+KVcNqyd1JBZgpGca6Ff5auDTkj7sfXtTVyL
        VtnlTzY67wMUxcsz3LUK0nwnlxPeD6AYlg==
X-Google-Smtp-Source: AA6agR4SF+9cxVCowhT7YIYuX2Ty5EfWBH9l3jwQE34EGLz2yobfHpy3VFoFhaYBrGr+M5JR0qpUnQ==
X-Received: by 2002:a65:6d89:0:b0:421:94bc:cb89 with SMTP id bc9-20020a656d89000000b0042194bccb89mr33380126pgb.129.1662197909827;
        Sat, 03 Sep 2022 02:38:29 -0700 (PDT)
Received: from biggie ([103.230.148.184])
        by smtp.gmail.com with ESMTPSA id s21-20020a170903201500b0016d2db82962sm3141068pla.16.2022.09.03.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 02:38:29 -0700 (PDT)
Date:   Sat, 3 Sep 2022 15:08:23 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com,
        hdanton@sina.com
Subject: Re: [PATCH] drivers/media/rc: Ensure usb_submit_urb() is not called
 if write is in progress
Message-ID: <YxMgj9CoUyY+r2qa@biggie>
References: <20220814142543.24910-1-gautammenghani201@gmail.com>
 <YxJHmYDMtmzaHWQG@biggie>
 <YxMHJNNq2e3kLxdQ@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxMHJNNq2e3kLxdQ@gofer.mess.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 08:49:56AM +0100, Sean Young wrote:
> On Fri, Sep 02, 2022 at 11:42:41PM +0530, Gautam Menghani wrote:
> > On Sun, Aug 14, 2022 at 07:55:42PM +0530, Gautam Menghani wrote:
> > > The warning "URB submitted while active" is reported if the function
> > > send_packet() in imon.c is called if a write is already is in progress.
> > > Add a check to return -EBUSY in case a write is already is in progress.
> > > Also, mark tx.busy as false after transmission is completed.
> > > 
> > > Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
> > > Cc: hdanton@sina.com
> > > Suggested-by: hdanton@sina.com
> > > Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
> > > Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
> > > Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> > > ---
> > >  drivers/media/rc/imon.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> > > index 735b925da998..a5b997c2c7e2 100644
> > > --- a/drivers/media/rc/imon.c
> > > +++ b/drivers/media/rc/imon.c
> > > @@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
> > >  	int retval = 0;
> > >  	struct usb_ctrlrequest *control_req = NULL;
> > >  
> > > +	if (ictx->tx.busy)
> > > +		return -EBUSY;
> > >  	/* Check if we need to use control or interrupt urb */
> > >  	if (!ictx->tx_control) {
> > >  		pipe = usb_sndintpipe(ictx->usbdev_intf0,
> > > @@ -654,6 +656,7 @@ static int send_packet(struct imon_context *ictx)
> > >  			pr_err_ratelimited("task interrupted\n");
> > >  		}
> > >  		mutex_lock(&ictx->lock);
> > > +		ictx->tx.busy = false;
> > >  
> > >  		retval = ictx->tx.status;
> > >  		if (retval)
> > > -- 
> > > 2.34.1
> > > 
> > Hi,
> > 
> > Please review the above fix and let me know if any changes are needed.
> 
> Greg has pointed out issues with this patch: there is no locking.
> 
> Thanks,
> 
> Sean

Hi,

I am a bit confused about the locking part. All the calls to send_packet() are
made with ictx->lock held. So will the following be sufficient?

lockdep_assert_held(&ictx->lock);
if (ictx->tx.busy)
	return -EBUSY;

Or do we need to add a mutex/spin lock inside ictx->tx structure? 

Or should we instead wait for the the tx to be completed as follows:
wait_for_completion(&ictx->tx.finished);

Please advise.

Thanks,
Gautam
