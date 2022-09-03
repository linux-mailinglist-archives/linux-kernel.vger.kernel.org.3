Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45CE5ABDB9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiICH7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiICH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:59:00 -0400
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Sep 2022 00:58:53 PDT
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4155979EE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 00:58:53 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 9E6EF100072; Sat,  3 Sep 2022 08:49:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1662191396; bh=G4MT1MV4esuAr0v8xfY1oNqEbcDxmnusDDYk2WFLurE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPjBKz4YJU0zBRkohIzEImV5T8Vdxs3wm3YIKJvuSG6n3TB5kkoRxK7v2E4acMO2d
         wRNpdZ7ncFfzgIgDoTZ0FPXvOJYNkd1qBW3JGyLXG+hwHoLR+dtAK2mB/V+xbG8BOj
         kr+24owdZBA84+AdXiaC3KBw8zpIJlwIw06m7r01O4VbhvPt3hWdfaAPdNHigCVaDT
         cq2ekM0T3kjS54NikN5pyi+teKRf6CeO/9Fs7iMj7rrHpP0PIGSjr92PwUXDMF1ZxM
         JT4G088rtwYzRwPVxDTHTZ39ZEaLduSAbFMESumMoT3B+cgDOI7Df06ATHNCqloLPN
         48CCuyN81XiXA==
Date:   Sat, 3 Sep 2022 08:49:56 +0100
From:   Sean Young <sean@mess.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com,
        hdanton@sina.com
Subject: Re: [PATCH] drivers/media/rc: Ensure usb_submit_urb() is not called
 if write is in progress
Message-ID: <YxMHJNNq2e3kLxdQ@gofer.mess.org>
References: <20220814142543.24910-1-gautammenghani201@gmail.com>
 <YxJHmYDMtmzaHWQG@biggie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxJHmYDMtmzaHWQG@biggie>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:42:41PM +0530, Gautam Menghani wrote:
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
> >  	/* Check if we need to use control or interrupt urb */
> >  	if (!ictx->tx_control) {
> >  		pipe = usb_sndintpipe(ictx->usbdev_intf0,
> > @@ -654,6 +656,7 @@ static int send_packet(struct imon_context *ictx)
> >  			pr_err_ratelimited("task interrupted\n");
> >  		}
> >  		mutex_lock(&ictx->lock);
> > +		ictx->tx.busy = false;
> >  
> >  		retval = ictx->tx.status;
> >  		if (retval)
> > -- 
> > 2.34.1
> > 
> Hi,
> 
> Please review the above fix and let me know if any changes are needed.

Greg has pointed out issues with this patch: there is no locking.

Thanks,

Sean
