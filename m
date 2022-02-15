Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986A94B7553
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbiBOSrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiBOSrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:47:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9113B031;
        Tue, 15 Feb 2022 10:47:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7931068AA6; Tue, 15 Feb 2022 19:47:04 +0100 (CET)
Date:   Tue, 15 Feb 2022 19:47:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215184704.GB24543@lst.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com> <20220215152240.GB1663897@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215152240.GB1663897@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 07:22:40AM -0800, Keith Busch wrote:
> I can't actually tell if not checking the DYING flag check was
> intentional or not, since the comments in blk_queue_start_drain() say
> otherwise.
> 
> Christoph, do you know the intention here? Should __bio_queue_enter()
> check the queue DYING flag, or do you prefer drivers explicity set the
> disk state like this? It looks to me the queue flags should be checked
> since that's already tied to the freeze wait_queue_head_t.

It was intentional but maybe not fully thought out.  Do you remember why
we're doing the manual setting of the dying flag instead of just calling
del_gendisk early on in nvme?  Because calling del_gendisk is supposed
to be all that a tree needs to do.
