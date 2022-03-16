Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3704DB7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbiCPSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiCPSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:06:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947A4C436;
        Wed, 16 Mar 2022 11:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51DC9B81637;
        Wed, 16 Mar 2022 18:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED1DC340E9;
        Wed, 16 Mar 2022 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647453931;
        bh=EUwl1rJPMN38j2p42kZ+S3LhlRJpuLGqUxqQYMv+5QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgCW7RY/0j2r7RQhPEWzTAdZHI91zrT43bm01uJMd9tulx3QwbBL8PBjcxHTe5Uor
         B6gu/3FB37YqzAa2bnXyFSLn2ugdAAPHJWucZ2ynC4yonofmq1dErOcRo7CTLyVmBX
         QscVjgfsN3QeWa9mjSPnS9HLWUnohQDReVoFkrpd5GcIyoa/VgtJbypGyH6CS0WbaM
         5Erftk/ilvDwQyzctnRJrZ+h3oSecgWG5tVoAjk4FN+D8Kcnr5Px94xWmz9IUnzxeQ
         gmiedvhyi1MJB1coBxncSbLAHo1HeV2tRDLTcbnCXAfroE0UEruDfV0azXZiaDsWPp
         0h+qWumkY3SfQ==
Date:   Wed, 16 Mar 2022 18:05:29 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, jaegeuk@kernel.org, chao@kernel.org,
        ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: security issue: data exposure when using block layer secure erase
Message-ID: <YjIm6f6pSX1CKeqb@gmail.com>
References: <20220316093740.GA7714@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316093740.GA7714@lst.de>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:37:40AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> while staring at the block layer code I found what I think is a major
> security issue with the use of REQ_OP_SECURE_ERASE.
> 
> The issue is not about the actual protocol implementation, which only
> exists for eMMC [1], but about we handle issuing the operation in the
> block layer.  That is done through __blkdev_issue_discard, which
> takes various parameters into account to align the issue discard
> request to what the hardware prefers.  Which is perfectly fine for
> discard as an advisory operation, but deadly for an operation that
> wants to make data inaccessible.  The problem has existed ever since
> secure erase support was added to the kernel with commit
> 8d57a98ccd0b ("block: add secure discard"), which added secure erase
> support as a REQ_SECURE flag to the discard operation.

__blkdev_issue_discard() can break up the region into multiple bios, but I don't
see where it actually skips parts of the region.  Can you explain more
specifically where the problem is?

- Eric
