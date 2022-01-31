Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC614A4C62
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380584AbiAaQpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380574AbiAaQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:45:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2FEC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:45:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B0F760AE1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B31C340E8;
        Mon, 31 Jan 2022 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643647530;
        bh=9MSg0aCS8sLQUyOSWxm+SNt05q8CIo7n+iLqnp0iDS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KR83EWu6vecCqxOW80b5Y4wdxtsI8kTEhZUgY65a7ew6mCu69HO6ALZ4m8zo3rXbO
         HlKYKd7lJcF6aqlyNEn7Ugi4t3OZE2UxbqPMGXTbRHXa9ugO742ZM6xeA4SKh17DQ6
         l0CkxaOFkQ9+yBOBc7F8DTGIQHELqa/dv/t5F/Os=
Date:   Mon, 31 Jan 2022 17:45:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: pi433: add debugfs interface
Message-ID: <YfgSKNlCm/3DnRmD@kroah.com>
References: <20220126132116.GA1951@kadam>
 <YfX+llwDWZZMz+NY@mail.google.com>
 <20220131134558.GL1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131134558.GL1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:45:58PM +0300, Dan Carpenter wrote:
> On Sun, Jan 30, 2022 at 03:57:26PM +1300, Paulo Miguel Almeida wrote:
> > @@ -1102,12 +1104,75 @@ static const struct file_operations pi433_fops = {
> >  	.llseek =	no_llseek,
> >  };
> >  
> > +static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
> > +{
> > +	struct pi433_device *dev;
> > +	u8 reg_data[114];
> > +	int i;
> > +	char *fmt = "0x%02x, 0x%02x\n";
> > +	int ret = 0;
> 
> No need to initialize.  Bogus initializers just disable ten thousand
> person hours spent developing static analysis.
> 
> > +
> > +	dev = m->private;
> > +
> > +	mutex_lock(&dev->tx_fifo_lock);
> > +	mutex_lock(&dev->rx_lock);
> > +
> > +	// wait for on-going operations to finish
> > +	ret = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
> > +	if (ret)
> > +		return ret;
> 
> Drop the two mutexes before returning.

Ick, I missed that.  I'll go drop this patch from my tree now, good
catch.

greg k-h
