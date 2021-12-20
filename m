Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D547A789
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhLTJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:59:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51840 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLTJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:59:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BCBB60F70;
        Mon, 20 Dec 2021 09:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76427C36AE2;
        Mon, 20 Dec 2021 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639994367;
        bh=1Dwzm5P68OohgasCaYVB5/wmfN7QtOCdTNyDk9p1DzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OI/NRU/PHBlvZtBD5THPleGqnxWbKhhYuZHEZQ6UnYpzd7ACeowFje09P/O0fS+56
         6/mvo02nwaMBoa3EvfSHFGbYMw2Txt3vlIHBNO65za/t27ryuKoz1wSkDRA17HyVUC
         HQ967pab5fEgwogKGj//WzxUR6Wj31fTgob3wSyk=
Date:   Mon, 20 Dec 2021 10:59:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wigin zeng <wigin.zeng@dji.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        First Light <xiaoguang.chen@dji.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06?= [PATCH] serial: 8250: add lock for dma rx
Message-ID: <YcBT/Vf41PWUYdxT@kroah.com>
References: <20211209073339.21694-1-wigin.zeng@dji.com>
 <YbGygPtkz6ihyW51@kroah.com>
 <674707a0388c4a3a9bb25676c61e1737@MAIL-MBX-cwP12.dji.com>
 <YbHBb2uB9JRP0tWc@kroah.com>
 <f2150f8a7b7242b48227e30e5550da0b@MAIL-MBX-cwP12.dji.com>
 <YbHVXwdCUCvmZrbS@kroah.com>
 <62dd5f2fedbb4332a4d04dea4970a347@MAIL-MBX-cwP12.dji.com>
 <YcBEy9zi2G7UYErE@kroah.com>
 <c35df81a176f418eb90e18563170de67@MAIL-MBX-cwP12.dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c35df81a176f418eb90e18563170de67@MAIL-MBX-cwP12.dji.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 09:44:04AM +0000, wigin zeng wrote:
> >That makes no sense, as what orders the data coming in?  The 2 bytes could be added to the tty buffer before the 512 bytes, or the other way around.
> 
> >What hardware are you using that is mixing dma and irq data like this?
> >That feels very wrong.
> 
> It is not normal case, normally, the input size should smaller than DMA block size and DMA complete the whole copy.
> However, there are some abnormal situations. The external input is unexpectedly larger than the data length of the DMA configuration. This situation in my example will appear, and it may cause the kernel to panic.

You did not answer my question about hardware type :(

And again, how is this happening?  If you use DMA, all data should be
coming through DMA and not the irq.  Otherwise crazy stuff like this
will happen in any type of driver, your hardware can not mix this type
of stuff up.

> >If they are running on different cores, then you will have data corruption issues no matter if you have a lock or not, so this is not the correct solution for this hardware configuration problem.
> 
> The purpose of adding lock is to ensure that the kernel will not panic in this extreme case, If you want to ensure the integrity of the serial port data, you need to add more flow control logic

How can flow control handle this at all?  Flow control is at the serial
data stream level.  This is confusing the PCI data stream order.

thanks,

greg k-h
