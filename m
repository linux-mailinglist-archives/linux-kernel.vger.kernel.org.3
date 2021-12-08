Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F846DE7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhLHWmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:42:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53220 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhLHWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:42:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D96ECE23FC;
        Wed,  8 Dec 2021 22:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973BDC00446;
        Wed,  8 Dec 2021 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639003107;
        bh=8fExRh+afZIO7FELL5sgjxjuaNK9bqeYqXxeg5IkSs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JalaltZ+6ymFW1LxrO+4PKYgOp26hko3WXqHPkAmcQNFYtoBG8PSAZaRbH8B6HpZ+
         Uo7drmbepb+Tn+Ws0IkwWIwAh4nLHkE/Y4xDqSoLSOPFDuj0E4wXaZSTPR6fBVcEnp
         6XJ+8LaGekY6C7qe+BGVcFMwQHxgApjaxoUsVoL1qFIScAWtOTvgqnd7YviOwllZMd
         2oBLGyR6YJXx2c0FAQI78Y8ammiV1nEaBsOcw24s/9upuxuxCySjimLSPBkUZU5izd
         Lwtgsj/4qbmkeP4Xk4eEGp+CMD4mNTxKRRmc0vqXETe/gqeeN2TfMLk4qWbhEB3Sod
         VdM7f6//mLrFQ==
Date:   Wed, 8 Dec 2021 14:38:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 6/8] docs: sysfs-block: document virt_boundary_mask
Message-ID: <YbEz4pq2xMfAufwJ@gmail.com>
References: <20211208005640.102814-1-ebiggers@kernel.org>
 <20211208005640.102814-7-ebiggers@kernel.org>
 <13462e59-82f3-d6fc-a84e-2cf3083e0cc7@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13462e59-82f3-d6fc-a84e-2cf3083e0cc7@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:33:19AM -0800, Bart Van Assche wrote:
> On 12/7/21 4:56 PM, Eric Biggers wrote:
> > +What:		/sys/block/<disk>/queue/virt_boundary_mask
> > +Date:		April 2021
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] This file shows the I/O segment alignment mask for the
> > +		block device.  I/O requests to this device will be split between
> > +		segments wherever either the end of the previous segment or the
> > +		beginning of the current segment is not aligned to
> > +		virt_boundary_mask + 1 bytes.
> 
> "I/O segment alignment" looks confusing to me. My understanding is that this
> attribute refers to the alignment of the internal data buffer boundaries and not
> to the alignment of the offset on the storage medium. The name "virt_boundary"
> refers to the property that if all internal boundaries are a multiple of
> (virt_boundary_mask + 1) then an MMU with page size (virt_boundary_mask + 1) can
> map the entire data buffer onto a contiguous range of virtual addresses. E.g.
> RDMA adapters have an MMU that can do this. Several drivers that set this
> attribute support a storage controller that does not have an internal MMU. As an
> example, the NVMe core sets this mask since the NVMe specification requires that
> only the first element in a PRP list has a non-zero offset. From the NVMe
> specification: "PRP entries contained within a PRP List shall have a memory page
> offset of 0h. If a second PRP entry is present within a command, it shall have a
> memory page offset of 0h. In both cases, the entries are memory".

Sure, I meant for it to be talking about the memory addresses.  How about this:

		[RO] This file shows the I/O segment memory alignment mask for
		the block device.  I/O requests to this device will be split
		between segments wherever either the memory address of the end
		of the previous segment or the memory address of the beginning
		of the current segment is not aligned to virt_boundary_mask + 1
		bytes.

- Eric
