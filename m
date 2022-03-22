Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15D64E3D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiCVLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiCVLUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:20:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AD26DB;
        Tue, 22 Mar 2022 04:18:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5189868AFE; Tue, 22 Mar 2022 12:18:48 +0100 (CET)
Date:   Tue, 22 Mar 2022 12:18:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        bvanassche@acm.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, ming.lei@redhat.com, hare@suse.de,
        chenxiang66@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com, beanhuo@micron.com
Subject: Re: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
Message-ID: <20220322111848.GA29270@lst.de>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com> <1647945585-197349-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647945585-197349-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 06:39:35PM +0800, John Garry wrote:
> Add an API to allocate a request queue which accepts a custom set of
> blk_mq_ops for that request queue.
> 
> The reason which we may want custom ops is for queuing requests which we
> don't want to go through the normal queuing path.

Eww.  I really do not think we should do separate ops per queue, as that
is going to get us into a deep mess eventually.
