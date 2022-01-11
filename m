Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA91A48AC40
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiAKLQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiAKLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:16:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4908C06173F;
        Tue, 11 Jan 2022 03:16:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3513861596;
        Tue, 11 Jan 2022 11:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B931C36AE3;
        Tue, 11 Jan 2022 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641899816;
        bh=Ih4XNkfQCbJ3g/tQh7glo+kyu5MaCrOm3tNTG01znjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M21rEXm/nbRu43fGrxd8N3k5B+1BCzABIZNlPUzQNkpJmqKIPDLPcQ5sYDCdwI/Hc
         44a/9IOdoDUMh4xsGnE2YyILZiwez6eTnAzZirGbN0/ywBdMQz1AjNmO5qrs9DCyhE
         SYMObuf1FJ3dK4mweeCf4DwEkqjpUSz76WXaU5qI=
Date:   Tue, 11 Jan 2022 12:16:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, surenb@google.com, kaleshsingh@google.com,
        tjmercier@google.com, keescook@google.com
Subject: Re: [PATCH] dma-buf: Move sysfs work out of DMA-BUF export/release
 path
Message-ID: <Yd1nJqmHXULnccNF@kroah.com>
References: <20220104235148.21320-1-hridya@google.com>
 <49b29081-42df-ffcd-8fea-bd819499ff1b@amd.com>
 <CA+wgaPMWT0s0KNo_wM7jU+bH626OAVtn77f7_WX=E1wyU8aBzg@mail.gmail.com>
 <3a29914d-0c7b-1f10-49cb-dbc1cc6e52b0@amd.com>
 <CA+wgaPOmRTAuXiSRRmj-s=3d2W6ny=EMFtroOShYKrp0u+xF+g@mail.gmail.com>
 <CA+wgaPO81R+NckRt0nzZazxs9fqSC_V_wyChU=kcMqJ01WxXNw@mail.gmail.com>
 <5a6bd742-10ca-2e88-afaa-3744731c2c0c@amd.com>
 <CA+wgaPPdCMPi1t+ObyO4+cqsk7Xx3E=K5BOPM37=QAviQDAfmw@mail.gmail.com>
 <CAKMK7uGRUrP+0PcY-yxTweb_K_QacHJchgPoa0K9K_kwGO+K3g@mail.gmail.com>
 <934ac18c-d53e-beeb-48c1-015a5936e713@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <934ac18c-d53e-beeb-48c1-015a5936e713@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:58:07AM +0100, Christian König wrote:
> > > This is also not a problem due to the high number of DMA-BUF
> > > exports during launch time, as even a single export can be delayed for
> > > an unpredictable amount of time. We cannot eliminate DMA-BUF exports
> > > completely during app-launches and we are unfortunately seeing reports
> > > of the exporting process occasionally sleeping long enough to cause
> > > user-visible jankiness :(
> > > 
> > > We also looked at whether any optimizations are possible from the
> > > kernfs implementation side[1] but the semaphore is used quite extensively
> > > and it looks like the best way forward would be to remove sysfs
> > > creation/teardown from the DMA-BUF export/release path altogether. We
> > > have some ideas on how we can reduce the code-complexity in the
> > > current patch. If we manage to
> > > simplify it considerably, would the approach of offloading sysfs
> > > creation and teardown into a separate thread be acceptable Christian?
> 
> At bare minimum I suggest to use a work_struct instead of re-inventing that
> with kthread.
> 
> And then only put the exporting of buffers into the background and not the
> teardown.
> 
> > > Thank you for the guidance!
> > One worry I have here with doing this async that now userspace might
> > have a dma-buf, but the sysfs entry does not yet exist, or the dma-buf
> > is gone, but the sysfs entry still exists. That's a bit awkward wrt
> > semantics.
> > 
> > Also I'm pretty sure that if we can hit this, then other subsystems
> > using kernfs have similar problems, so trying to fix this in kernfs
> > with slightly more fine-grained locking sounds like a much more solid
> > approach. The linked patch talks about how the big delays happen due
> > to direct reclaim, and that might be limited to specific code paths
> > that we need to look at? As-is this feels a bit much like papering
> > over kernfs issues in hackish ways in sysfs users, instead of tackling
> > the problem at its root.
> 
> Which is exactly my feeling as well, yes.

More and more people are using sysfs/kernfs now for things that it was
never designed for (i.e. high-speed statistic gathering).  That's not
the fault of kernfs, it's the fault of people thinking it can be used
for stuff like that :)

But delays like this is odd, tearing down sysfs attributes should
normally _never_ be a fast-path that matters to system throughput.  So
offloading it to a workqueue makes sense as the attributes here are for
objects that are on the fast-path.

thanks,

greg k-h
