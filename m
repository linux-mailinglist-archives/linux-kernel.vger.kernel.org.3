Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956CA5513B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiFTJGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiFTJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:05:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8975DFC;
        Mon, 20 Jun 2022 02:05:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E8CE68AA6; Mon, 20 Jun 2022 11:05:43 +0200 (CEST)
Date:   Mon, 20 Jun 2022 11:05:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hch@lst.de, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Message-ID: <20220620090543.GA13643@lst.de>
References: <1654770559-101375-4-git-send-email-john.garry@huawei.com> <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com> <9e89360d-3325-92af-0436-b34df748f3e2@acm.org> <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com> <3a27b6ff-e495-8f11-6925-1487c9d14fa9@huawei.com> <c702f06e-b7da-92be-3c4f-5dd405600235@opensource.wdc.com> <ecfb0694-21b8-55b4-c9b8-5e738f59ce8d@huawei.com> <98fa010d-3555-a82b-e960-f47aeeb38151@opensource.wdc.com> <7b046321-fdb3-33f0-94a0-78a25cbbe02e@suse.de> <9de5ed1b-e874-28ac-0532-cd5420892064@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de5ed1b-e874-28ac-0532-cd5420892064@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 06:02:30PM +0900, Damien Le Moal wrote:
> So reserving a tag/req to be able to do NCQ at the cost of max qd being 31
> works for that. We could keep max qd at 32 by creating one more "fake" tag
> and having a request for it, that is, having the fake tag visible to the
> block layer as a reserved tag, as John's series is doing, but for the
> reserved tags, we actually need to use an effective tag (qc->hw_tag) when
> issuing the commands. And for that, we can reuse the tag of one of the
> failed commands.

Take a look at the magic flush request in blk-flush.c, which is
preallocated but borrows a tag from the request that wants a pre- or
post-flush.  The logic is rather ugly, but maybe it might actually
become cleaner by generalizing it a bit.
