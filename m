Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790D44E5585
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiCWPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiCWPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:44:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861076474;
        Wed, 23 Mar 2022 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WHGiwoQ7jm4I3reye7XZm6CpTzWoNyjTmyKi+u3jjKg=; b=ioGexHFlIpdyX+fUkuYz69BncV
        uesxLQja4XtEx1Izn4rjO4JkbJuc38YGAzFGDsK0D9mJa/KQfjONqpT0uglw4lILKXlZKtbIzIB7r
        XJGOEVe7glYhGDuXXiX6v+Ad0AVihbAhTphVZc+m5EQBAGUyw6WHiYRSTsewasJdsGGQV+3HLJWvN
        FaSGSr48Jz6TCDAD4c+E9uMZNbduvPlNkXpoQug/Lr2/BVRyWtgIMO9xaDvdY99Z2DRFC4+rX6QKS
        EwFj0OD0tI2S64abJRyR/Os562RgpOTr4HpNUGlpQHe0FugO1XIXnGU+o2HnpV+Wr516QZHDI6QFl
        l4EDk7bA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX386-00Ce7z-WB; Wed, 23 Mar 2022 15:42:35 +0000
Date:   Wed, 23 Mar 2022 15:42:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <Yjs/6pLB1uDKBRCG@casper.infradead.org>
References: <20220320143453.GD6208@xsang-OptiPlex-9020>
 <20220323071409.GA25480@lst.de>
 <202203230809.D63BF9511@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203230809.D63BF9511@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:40:30AM -0700, Kees Cook wrote:
> On Wed, Mar 23, 2022 at 08:14:10AM +0100, Christoph Hellwig wrote:
> > The actual warning is;
> > 
> > [   34.496096][  T331] usercopy: Kernel memory overwrite attempt detected to spans multiple pages (off set 0, size 6)!
> > 
> > This is for the cmnd field in struct scsi_cmnd, which is allocated by
> > the block layer as part of the request allocator.  So with a specific
> > packing it can legitimately span pages.
> > 
> > Kees: how can we annotate that this is ok?
> 
> The main problem is that CONFIG_HARDENED_USERCOPY_PAGESPAN=y is broken
> (and nothing should be setting it).
> 
> This series removes it:
> https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/
> 
> Matthew, what's the status of that series? Will it make the current
> merge window?

I thought you were going to merge it!  I haven't put it in any of my
public trees.

> As for the SCSI changes, I'm a bit worried about type confusion, as I
> don't see anything actually validating types/sizes when converting:
> 
> static inline void *blk_mq_rq_to_pdu(struct request *rq)
> {
>         return rq + 1;
> }
> 
> But I guess that ship has sailed. :P
> 
> Regardless, I'm concerned that disabling PAGESPAN will just uncover
> further checks, though. Where is allocation happening? The check is here:
> 
> static int scsi_fill_sghdr_rq(struct scsi_device *sdev, struct request *rq,
>                 struct sg_io_hdr *hdr, fmode_t mode)
> {
>         struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
> 
>         if (hdr->cmd_len < 6)
>                 return -EMSGSIZE;
>         if (copy_from_user(scmd->cmnd, hdr->cmdp, hdr->cmd_len))
>                 return -EFAULT;
> 	...
> }
> 
> I don't see any earlier marking for this copy_from_user(), so I assume
> the old allocation was a plain kmalloc().
> 
> For comparision, a related marking can be seen for a copy_to_user() case
> in commit 0afe76e88c57 ("scsi: Define usercopy region in scsi_sense_cache
> slab cache")
> 
> I *think* the allocation is happening in scsi_ioctl_reset()? But that's
> a plain kmalloc(), so I'm not sure why PAGESPAN would have tripped...
> are there other allocation paths?
> 
> -- 
> Kees Cook
> 
