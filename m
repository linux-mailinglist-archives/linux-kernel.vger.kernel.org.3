Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2151334E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbiD1MGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345985AbiD1MGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:06:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F87ADD70;
        Thu, 28 Apr 2022 05:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB666B82C97;
        Thu, 28 Apr 2022 12:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005D7C385A9;
        Thu, 28 Apr 2022 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651147364;
        bh=RuozuLWzG4C8Ggsyl8kWlvlvUawIVpr6zx6B7prgFZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hs17iDXfGMIN4DA5xhkGxMW2hsXvLoHy/mlZ1h2K2QQfd0VADQNRs3bkj/+QY8s1J
         lGiXtq7Lv7NaKJ391GPhoq5YSTaJsYdmAmrjO14yNnIIV9AdZQCuI8tmd9HdFitWgZ
         ak385yipdDltz09gEM2Ei+tEQCYt8gDVj4JMV/tM=
Date:   Thu, 28 Apr 2022 14:02:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org
Subject: Re: [PATCHv12 7/9] asm-generic/io: Add logging support for MMIO
 accessors
Message-ID: <YmqCYZwHoRuKtFSN@kroah.com>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <6673a2e73d3dd4c7aa01fee9b26cc4a52176ba7a.1651139070.git.quic_saipraka@quicinc.com>
 <YmpxxW5CZjMVrzF0@kroah.com>
 <6688ffa2-ec14-9126-1296-6180bab3e1d6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6688ffa2-ec14-9126-1296-6180bab3e1d6@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:51:49PM +0530, Sai Prakash Ranjan wrote:
> On 4/28/2022 4:21 PM, Greg KH wrote:
> > On Thu, Apr 28, 2022 at 03:25:30PM +0530, Sai Prakash Ranjan wrote:
> > > Add logging support for MMIO high level accessors such as read{b,w,l,q}
> > > and their relaxed versions to aid in debugging unexpected crashes/hangs
> > > caused by the corresponding MMIO operation.
> > > 
> > > Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> > > ---
> > >   include/asm-generic/io.h | 82 ++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 78 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > index 7ce93aaf69f8..99090722cb4b 100644
> > > --- a/include/asm-generic/io.h
> > > +++ b/include/asm-generic/io.h
> > > @@ -10,6 +10,7 @@
> > >   #include <asm/page.h> /* I/O is all done through memory accesses */
> > >   #include <linux/string.h> /* for memset() and memcpy() */
> > >   #include <linux/types.h>
> > > +#include <linux/instruction_pointer.h>
> > >   #ifdef CONFIG_GENERIC_IOMAP
> > >   #include <asm-generic/iomap.h>
> > > @@ -61,6 +62,35 @@
> > >   #define __io_par(v)     __io_ar(v)
> > >   #endif
> > > +#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
> > Shouldn't you document __DISABLE_TRACE_MMIO__ somewhere?  It's not even
> > in the changelog.  Put a big comment above this for what is is for and
> > how to use it.  Otherwise you will forget all about this in 6 months :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> Didn't you ask me to split the patch to the one actually adding the flag and the one using it.

Yes, and isn't this the commit that adds the flag?  Or was that on an
earlier one that I missed?

Ah, it's in patch 6/9

But you should also document it here in the .h file, otherwise the only
place it is described is in some random kvm Makefile that no one will
ever notice :)

thanks,

greg k-h
