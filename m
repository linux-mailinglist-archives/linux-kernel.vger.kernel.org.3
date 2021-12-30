Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB1482007
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbhL3TuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:50:23 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40571 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235478AbhL3TuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:50:22 -0500
Received: (qmail 1117220 invoked by uid 1000); 30 Dec 2021 14:50:21 -0500
Date:   Thu, 30 Dec 2021 14:50:21 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        jj251510319013@gmail.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: gadget: clear related members when goto fail
Message-ID: <Yc4NfWuIxJOVZail@rowland.harvard.edu>
References: <20211230051132.21056-1-hbh25y@gmail.com>
 <20211230051132.21056-3-hbh25y@gmail.com>
 <Yc4MeIt6JygZ6CrY@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc4MeIt6JygZ6CrY@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 02:46:00PM -0500, Alan Stern wrote:
> On Thu, Dec 30, 2021 at 01:11:32PM +0800, Hangyu Hua wrote:
> > dev->config and dev->hs_config and dev->dev need to be cleaned if
> > dev_config fails to avoid UAF.

> > @@ -1875,6 +1875,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
> >  
> >  	value = usb_gadget_probe_driver(&gadgetfs_driver);
> >  	if (value != 0) {
> > +		dev->dev = NULL;
> > +		dev->hs_config = NULL;
> > +		dev->config = NULL;
> >  		kfree (dev->buf);
> >  		dev->buf = NULL;
> 
> Why not just grep the lock and goto fail?

Wrong word: I meant to write "grab", not "grep".

Alan Stern
