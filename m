Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43946E63E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhLIKLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbhLIKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:11:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAD3C061A32;
        Thu,  9 Dec 2021 02:07:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D39C7CE2558;
        Thu,  9 Dec 2021 10:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB7EC341C3;
        Thu,  9 Dec 2021 10:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639044451;
        bh=eYHGNo6XJlvsFWymga9gq7flRAXqKIivvr3RMKBg0oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRDOO4oaEnzhDqlp0g5Wyokuppkn8TbujDT2Yay7kvN2EzcVopcMolG58ymykc/ox
         v7hyQ+pCd8qFaHl/KHCPkaZYxL2GYe9/YqQI+GHyhgK+CY03h/4MXL2+bWTTnRE162
         3V9zhMfmvQ3jw6DuIOy2n6DbCd8yOwLdqlIy2GHs=
Date:   Thu, 9 Dec 2021 11:07:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wigin zeng <wigin.zeng@dji.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        First Light <xiaoguang.chen@dji.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH] serial:
 8250: add lock for dma rx
Message-ID: <YbHVXwdCUCvmZrbS@kroah.com>
References: <20211209073339.21694-1-wigin.zeng@dji.com>
 <YbGygPtkz6ihyW51@kroah.com>
 <674707a0388c4a3a9bb25676c61e1737@MAIL-MBX-cwP12.dji.com>
 <YbHBb2uB9JRP0tWc@kroah.com>
 <f2150f8a7b7242b48227e30e5550da0b@MAIL-MBX-cwP12.dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2150f8a7b7242b48227e30e5550da0b@MAIL-MBX-cwP12.dji.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:08:51AM +0000, wigin zeng wrote:
> > What issue exactly?
> The interval of UART input packages is very small(1ms~ 10ms), and some package size larger than configured DMA transfer size.

What do you mean exactly by "package size"?  Isn't it up to the DMA
transfer to do the whole copy?

> > But what data is being accessed at the same time to cause a crash?
> > How is data being added into the buffer at the same time in two different places into the same queue?  What userspace programs are causing this?
> Both places will modify tty_port *port->buf.tail (kmalloc operation and write the data/flag into this address)

What is the "second" place here?  Data should only be coming in from the
DMA transfer copy, right?

> >So all tty buffer accesses need to be protected by your new lock?
> New lock only protected the tty_buffer alloc and write operation in serial-tty case. 

You need to document that really well as it does not seem that all
accesses are now protected by this lock.  Only one odd access is, and I
still do not understand how this is happening at the same time now.

Again, what changed recently to cause this to start happening?  Why is
this only showing up now?  What is unique about your system that causes
this and prevents it from happening on any other system?

thanks,

greg k-h
