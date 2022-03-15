Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDAB4D961D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbiCOI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiCOI0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:26:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7323981F;
        Tue, 15 Mar 2022 01:25:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 08FED68AA6; Tue, 15 Mar 2022 09:24:57 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:24:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Message-ID: <20220315082457.GB3502@lst.de>
References: <20220312144415.20010-1-linux@zary.sk> <202203132015.18183.linux@zary.sk> <5161ed17-5f55-e851-c2e2-5340cc62fa3b@kernel.dk> <202203142125.40532.linux@zary.sk> <f8c176d4-74f0-3e4f-446f-2a5f8ace3b28@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c176d4-74f0-3e4f-446f-2a5f8ace3b28@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 02:29:20PM -0600, Jens Axboe wrote:
> The controller would set
> 
> ->needs_blocking_queue_rq = true;
> 
> or something, and we'd default to false. And if that is set, when the
> blk-mq queue is created, then we'd set BLK_MQ_F_BLOCKING upon creation
> if that flag is true.
> 
> That's the block layer side. Then in libata you'd need to ensure that
> you check that same setting and invoke ata_qc_issue() appropriately.
> 
> Very top level stuff, there might be more things lurking below. But
> you'll probably find them as you test this stuff...

FYI, this somewhat mistitled series:

https://lore.kernel.org/all/20220308003957.123312-1-michael.christie@oracle.com/

adds BLK_MQ_F_BLOCKING support to the scsi core.  Doing libata
should be fairly easy and can built ontop of that.
