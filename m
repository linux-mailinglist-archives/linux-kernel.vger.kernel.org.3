Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA046DE71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhLHWiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLHWiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:38:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C0C061746;
        Wed,  8 Dec 2021 14:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 58EF1CE23C4;
        Wed,  8 Dec 2021 22:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53291C00446;
        Wed,  8 Dec 2021 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639002872;
        bh=vrWumqdF9FcUSCqyl/Y7iRjjHDoOqLA415fQumlLiVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjg4BERRFnE3aBRdaHQEiuroVYGpV64miBHiRR+d3iY8lHi6CkkgMpUY5DVaVNGas
         E6JlHavNdO5b2pLmvULjNvqqFckyhNNJncPr91qbv9K6p+9JcQIpKok9Lh628Nmlxm
         hJpctMeqOdSIJg1FVwLI+UMvvhG9MRmC1++e0uC4BloS2EnOizK55o5nCvnNqCjdE+
         0qiwplCSzvQjhhCy/Va4Zi4zUR1q+jcIGONp4D8py+ejoLCLU7cM4Z3OxfutBEhh3x
         s5xjLOTpLW1Yl/SKmrps0XW9skEWj7z86iPHPUvdtzt1QxuvkaQGQ2IlpS1SLWtTkU
         szdoVMS3mUK7A==
Date:   Wed, 8 Dec 2021 14:34:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 5/8] docs: sysfs-block: document stable_writes
Message-ID: <YbEy9tKDwf5Jthl1@gmail.com>
References: <20211208005640.102814-1-ebiggers@kernel.org>
 <20211208005640.102814-6-ebiggers@kernel.org>
 <7d9f9469-5347-780a-c560-77fca6e7008b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9f9469-5347-780a-c560-77fca6e7008b@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:01:10AM -0800, Bart Van Assche wrote:
> On 12/7/21 4:56 PM, Eric Biggers wrote:
> > +What:		/sys/block/<disk>/queue/stable_writes
> > +Date:		September 2020
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] If the device requires that memory must not be modified
> > +		while it is being written out to disk, this file will contain
> > +		'1'.  Otherwise it will contain '0'.  This file is writable for
> > +		testing purposes.
> 
> Hmm ... doesn't this attribute apply to the process of transferring data from
> host memory to the device instead of to writing to the disk? Whether data goes
> to the storage device cache or to the storage medium itself depends on attributes
> like FUA.
> 

Yes, I meant "written out to disk" in the general sense of writeback, not in the
sense of when the data reaches its final destination.  I'm not sure what the
best way to explain it is.  I think it's more than just "the process of
transferring data from host memory to the device", as that is just part of a
write request, whereas stable_writes applies to whole requests.  How about:

		[RW] This file will contain '1' if memory must not be modified
		while it is being used in a write request to this device.  When
		this is the case and the kernel is performing writeback of a
		page, the kernel will wait for writeback to complete before
		allowing the page to be modified again, rather than allowing
		immediate modification as is normally the case.  This
		restriction arises when the device accesses the memory multiple
		times where the same data must be seen every time -- for
		example, once to calculate a checksum and once to actually write
		the data.  If no such restriction exists, this file will contain
		'0'.  This file is writable for testing purposes.

- Eric
