Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164494824AD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 16:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhLaP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 10:57:45 -0500
Received: from netrider.rowland.org ([192.131.102.5]:36577 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229453AbhLaP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 10:57:42 -0500
Received: (qmail 1133443 invoked by uid 1000); 31 Dec 2021 10:57:41 -0500
Date:   Fri, 31 Dec 2021 10:57:41 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        jj251510319013@gmail.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: gadget: clear related members when goto fail
Message-ID: <Yc8odYb41iNuQ16J@rowland.harvard.edu>
References: <20211230051132.21056-1-hbh25y@gmail.com>
 <20211230051132.21056-3-hbh25y@gmail.com>
 <Yc4MeIt6JygZ6CrY@rowland.harvard.edu>
 <CAOo-nLLpNfHzrOyF4P0XvFK1h+J+aZqGL+AqmZP2PG6C=rcFjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOo-nLLpNfHzrOyF4P0XvFK1h+J+aZqGL+AqmZP2PG6C=rcFjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 10:31:51AM +0800, Hangyu Hua wrote:
> On 2021/12/31 上午3:46, Alan Stern wrote:

> >> @@ -1892,7 +1895,12 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
> >>      }
> >>      return value;
> >>
> >> +fail2:
> >> +    dev->dev = NULL;
> >> +fail1:
> >> +    dev->hs_config = NULL;
> >
> > It is not necessary to have all these different statement labels.  You
> > can simply have "fail:" clear all three pointers.

> I don't think so. It is not necessary to clean all three pointers if
> some of them aren't kbuf. I think it may be better to keep their own
> pointers.

If the pointers aren't set to a region inside kbuf then they are 
meaningless.  There is no reason to keep the old values.  It is better 
to avoid multiple unnecessary statement labels.

Alan Stern
