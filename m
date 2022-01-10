Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E89489466
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbiAJIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:55:49 -0500
Received: from verein.lst.de ([213.95.11.211]:37622 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242382AbiAJIyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:54:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE72968AA6; Mon, 10 Jan 2022 09:54:41 +0100 (CET)
Date:   Mon, 10 Jan 2022 09:54:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        james.smart@broadcom.com, martin.petersen@oracle.com
Subject: Re: [PATCH -next] scsi: efct: Use GFP_ATOMIC under spin lock
Message-ID: <20220110085441.GB6124@lst.de>
References: <20211221113706.329791-1-yangyingliang@huawei.com> <20211221142859.GA30187@lst.de> <44ff658e-4a00-ee5b-1f84-fa89f9b9291f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ff658e-4a00-ee5b-1f84-fa89f9b9291f@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 11:56:08AM +0800, Yang Yingliang wrote:
>
> On 2021/12/21 22:28, Christoph Hellwig wrote:
>> On Tue, Dec 21, 2021 at 07:37:06PM +0800, Yang Yingliang wrote:
>>> A spin lock is taken here so we should use GFP_ATOMIC.
>>>
>>> Fixes: efac162a4e4d ("scsi: efct: Don't pass GFP_DMA to dma_alloc_coherent()")
>> No, it does not fix that commit.  The driver did sleeping allocations
>> even before the commit.
>>
>> But wher is "here"?  Can we look into not holding that lock over an
>> allocation if it is preferable?  If not we should at least pass down
>> the gfp_flags so that only the caller(s) that can't sleep pass GFP_ATOMIC.
>
> According the comment of els_ios_lock, it's used to protect els ios list, I 
> think we
>
> can move down the spin lock like this:

This looks sensible to me.  Please submit it to the maintainer as a proper
patch.
