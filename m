Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE13489DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiAJQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:44:23 -0500
Received: from verein.lst.de ([213.95.11.211]:39328 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231379AbiAJQoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:44:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AEF868BEB; Mon, 10 Jan 2022 17:44:18 +0100 (CET)
Date:   Mon, 10 Jan 2022 17:44:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hch@lst.de, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: pmcraid: Fix memory allocation in
 'pmcraid_alloc_sglist()'
Message-ID: <20220110164417.GA7133@lst.de>
References: <11a1bc98501de37baa5bcd10b61136f6e450b82e.1641816080.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a1bc98501de37baa5bcd10b61136f6e450b82e.1641816080.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 01:02:53PM +0100, Christophe JAILLET wrote:
> When the scatter list is allocated in 'pmcraid_alloc_sglist()', the
> corresponding pointer should be stored in 'scatterlist' within the
> 'pmcraid_sglist' structure. Otherwise, 'scatterlist' is NULL.
> 
> This leads to a potential memory leak and NULL pointer dereference.
> 
> Fixes: ed4414cef2ad ("scsi: pmcraid: Use sgl_alloc_order() and sgl_free_order()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is completely speculative and untested.
> 
> Should it be correct, I think that their should be some trouble somewhere.
> Either NULL pointer dereference or incorrect behavior.
> The patch that introduced this potential bug is from 2018-02. So, this
> should have been spotted earlier.
> 
> So unless this driver is mostly unused, this looks odd to me.
> Feedback appreciated.

The whole passthrough ioctl path looks completely broken to me.  For
example it dma maps the scatterlist and after that copies data to it,
which is prohibited by the DMA API contract.

So I'd be tempted to just remove the PMCRAID_PASSTHROUGH_IOCTL ioctl
implementation entirely, and if users for it do pop up we should
reimplement it using the proper block layer request mapping helpers.

If for some reason we don't want that and just fix the obvious
problem without a way to test for it, your patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
