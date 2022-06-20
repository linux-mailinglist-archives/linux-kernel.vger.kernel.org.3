Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D93551052
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiFTG3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiFTG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:28:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC363FE;
        Sun, 19 Jun 2022 23:28:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D91C6732D; Mon, 20 Jun 2022 08:28:28 +0200 (CEST)
Date:   Mon, 20 Jun 2022 08:28:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hch@lst.de, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Message-ID: <20220620062828.GA10753@lst.de>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com> <1654770559-101375-4-git-send-email-john.garry@huawei.com> <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com> <88d192b5-741b-7104-7f72-0178aa18bafb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d192b5-741b-7104-7f72-0178aa18bafb@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 08:24:24AM +0200, Hannes Reinecke wrote:
> So my idea for SATA is simply _not_ to use reserved tags.
> Any TMF functions (or the equivalent thereof) should always be sent as 
> non-NCQ commands. And when doing so we're back to QD=1 on SATA anyway, so 
> there _must_ be tags available. Consequently the main reason for having 
> reserved tags (namely to guarantee that tags are available for TMF) doesn't 
> apply here.

At least in the non-elevator case (which includes all passthrough I/O)
request have tags assigned as soon as they are allocated.  So, we
absolutely can have all tags allocated and then need to do a TMF.
