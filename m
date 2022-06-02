Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0953B95E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiFBNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiFBNFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:05:40 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B906CF5D;
        Thu,  2 Jun 2022 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=iSgidqt3314KrT58FqhYk4IWrdEq/fp5zlV6LXz/zvg=; b=O4SXb
        azmr75iSV27mGL0s/f3ES9lL6mOv0EIxfLeyBjIN+hjQQtpw2c/J9IqNTcTACAgcuz18cSwxGAX6Y
        wP3UmnjqTSl+q7HTxs84zgSZ9FyF3u3+hQu8Va+KJyvYvCohnu7gkqqk86rhdTaxnrGVuYt7+g2Ra
        ajPVvwsk0G4HOP6J7/C+5QW3py+g6yy1ng2AJje5Vijb5hmUY2YcKeasS/0pO0FnaSc671zRImr6R
        mr+wtqP2Q/Y3O2s7CpMZ5KgCc6bCZ+Su+SZhGw016F3lrT3zPWXaMcKecMqvVA+URwDNydD3rEHX0
        BYgll9qvJlWiLiw0DSlAW/MrvAsvQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nwkVj-0003GP-W6; Thu, 02 Jun 2022 14:05:12 +0100
Date:   Thu, 2 Jun 2022 14:05:10 +0100
From:   John Keeping <john@metanate.com>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     quic_linyyuan@quicinc.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, axboe@kernel.dk,
        quic_pkondeti@quicinc.com, wcheng@codeaurora.org,
        quic_ugoswami@quicinc.com, andrew_gabbasov@mentor.com,
        plr.vincent@gmail.com, gustavoars@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: Re: [PATCH] usb: f_fs: Fix crash during gadget function switching
Message-ID: <Ypi1hksGneVFEM8L@donbot>
References: <20220510080105.126146-1-michael@allwinnertech.com>
 <YpUJkxWBNuZiW7Xk@donbot>
 <f2e4f523-9d56-9b5d-cc8e-c9d2c3660996@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e4f523-9d56-9b5d-cc8e-c9d2c3660996@allwinnertech.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 06:36:47PM +0800, Michael Wu wrote:
> On 5/31/2022 2:14 AM, John Keeping wrote:
> > On Tue, May 10, 2022 at 04:01:05PM +0800, Michael Wu wrote:
> > > On arm64 android12 and possibly other platforms, during the usb gadget
> > > function switching procedure (e.g. from mtp to midi), a synchronization
> > > issue could occur, which causes an use-after-free panic as shown below:
> > 
> > I assume this is the path through ffs_epfile_io() with !io_data->aio.
> > It looks like there is no check there for epfile->ep == ep which the
> > other paths do check.
> > 
> > Does the patch below fix the problem without needing to add a new
> > completion?
> > 
> 
> Hi John,
> Thanks for your suggestion. I've tested your patch and it did work -- When
> my issue occurs, (epfile->ep != ep) is satisfied, and the error is handled.
> 
> > -- >8 --
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -1084,16 +1084,22 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
> >                           */
> >                          usb_ep_dequeue(ep->ep, req);
> >                          wait_for_completion(&done);
> > -                       interrupted = ep->status < 0;
> > +                       interrupted = true;
> >                  }
> > -               if (interrupted)
> > +               spin_lock_irq(&epfile->ffs->eps_lock);
> > +               if (epfile->ep != ep)
> > +                       ret = -ESHUTDOWN;
> > +               else if (interrupted && ep->status < 0)
> >                          ret = -EINTR;
> > -               else if (io_data->read && ep->status > 0)
> > -                       ret = __ffs_epfile_read_data(epfile, data, ep->status,
> > -                                                    &io_data->data);
> >                  else
> >                          ret = ep->status;
> > +               spin_unlock_irq(&epfile->ffs->eps_lock);
> > +
> > +               if (io_data->read && ret > 0)
> > +                       ret = __ffs_epfile_read_data(epfile, data, ret,
> > +                                                    &io_data->data);
> > +
> >                  goto error_mutex;
> >          } else if (!(req = usb_ep_alloc_request(ep->ep, GFP_ATOMIC))) {
> >                  ret = -ENOMEM;
> Tested-by: Michael Wu <michael@allwinnertech.com>
> 
> 
> I also tested Linyu's patch [1][2]. It also works.
> Is there a preference on these solutions?

Linyu's patch is more complete and covers some cases that I missed with
this attempt, so let's drop this thread and focus on that series.
