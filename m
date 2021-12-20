Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1693C47A64B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhLTIyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbhLTIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:54:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88968C061574;
        Mon, 20 Dec 2021 00:54:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2052660EED;
        Mon, 20 Dec 2021 08:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF850C36AE8;
        Mon, 20 Dec 2021 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639990478;
        bh=w9Ckuk8ZRZpMruE//Ln5jMCz28zvDkic5YFOBHHk3Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNpoVb+Iqqm4QiOc9s+MO/KIKnV0HBvtU0MHsVQYPfxDngN/0ofP9lP5Q++bJrIRS
         f/eotD7ioGdfO/ym0/EBBt3fATUCmfMV/nnYiE/3PyVe1ZqOkvsaISGLgpJIPf5g4N
         PuGx76aNwWqg644Eoi/6GIV9C4c3vY1YRYQukjnU=
Date:   Mon, 20 Dec 2021 09:54:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wigin zeng <wigin.zeng@dji.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        First Light <xiaoguang.chen@dji.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?= =?utf-8?B?5aSNOg==?=
 [PATCH] serial: 8250: add lock for dma rx
Message-ID: <YcBEy9zi2G7UYErE@kroah.com>
References: <20211209073339.21694-1-wigin.zeng@dji.com>
 <YbGygPtkz6ihyW51@kroah.com>
 <674707a0388c4a3a9bb25676c61e1737@MAIL-MBX-cwP12.dji.com>
 <YbHBb2uB9JRP0tWc@kroah.com>
 <f2150f8a7b7242b48227e30e5550da0b@MAIL-MBX-cwP12.dji.com>
 <YbHVXwdCUCvmZrbS@kroah.com>
 <62dd5f2fedbb4332a4d04dea4970a347@MAIL-MBX-cwP12.dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62dd5f2fedbb4332a4d04dea4970a347@MAIL-MBX-cwP12.dji.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:27:24AM +0000, wigin zeng wrote:
> Sorry for late response.
> 
> > >> What issue exactly?
> > The interval of UART input packages is very small(1ms~ 10ms), and some package size larger than configured DMA transfer size.
> >What do you mean exactly by "package size"?  Isn't it up to the DMA transfer to do the whole copy?
>  
> The attachment is an example for the race condition issue. E.g: 514bytes input stream from UART, 512bytes should be copied by DMA(block size set as 512), left 2bytes should be copied by serial interrupt handler.

That makes no sense, as what orders the data coming in?  The 2 bytes
could be added to the tty buffer before the 512 bytes, or the other way
around.

What hardware are you using that is mixing dma and irq data like this?
That feels very wrong.

> >Again, what changed recently to cause this to start happening?  Why is this only showing up now?  What is unique about your system that causes this and prevents it from happening on any other system?
> I think it is a corner case and exist in previous kernel version, we just reproduced it in pressure test.
> Our system running multi cores and enabled RT feature, DMA interrupt thread and serial interrupt thread are running on different cores in parallel.

If they are running on different cores, then you will have data
corruption issues no matter if you have a lock or not, so this is not
the correct solution for this hardware configuration problem.

thanks,

greg k-h
