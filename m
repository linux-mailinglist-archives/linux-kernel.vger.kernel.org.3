Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050B94816EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 22:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhL2VLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 16:11:55 -0500
Received: from netrider.rowland.org ([192.131.102.5]:52309 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229754AbhL2VLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 16:11:54 -0500
Received: (qmail 1100361 invoked by uid 1000); 29 Dec 2021 16:11:52 -0500
Date:   Wed, 29 Dec 2021 16:11:52 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: use after free in dev_config
Message-ID: <YczPGL/1Er/vh+X6@rowland.harvard.edu>
References: <20211228092126.29510-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228092126.29510-1-hbh25y@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 05:21:26PM +0800, Hangyu Hua wrote:
> There are two bugs:

You should break this up into two separate patches, one for each bug.

> dev->buf does not need to be released if it already exists before
> executing dev_config.

That's right.  The call to dev_config should fail without changing any 
of the stored values.

> dev->config and dev->hs_config and dev->dev need to be cleaned if
> dev_config fails to avoid UAF.

Do they really need to be cleared?  I think if dev_config fails then 
those pointers never get used, so it doesn't matter what they contain.

Of course, clearing them doesn't hurt, but it would be best to clear 
all of them in the "fail:" part of the routine.  And then you would 
want to change the pathway where usb_gadget_probe_driver fails, to make 
it go to "fail:" also.

Alan Stern
