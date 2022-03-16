Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCA4DAD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354930AbiCPJi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiCPJi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:38:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB0A2E0A4;
        Wed, 16 Mar 2022 02:37:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C37D68AFE; Wed, 16 Mar 2022 10:37:40 +0100 (CET)
Date:   Wed, 16 Mar 2022 10:37:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     jaegeuk@kernel.org, chao@kernel.org, ulf.hansson@linaro.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: security issue: data exposure when using block layer secure erase
Message-ID: <20220316093740.GA7714@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

while staring at the block layer code I found what I think is a major
security issue with the use of REQ_OP_SECURE_ERASE.

The issue is not about the actual protocol implementation, which only
exists for eMMC [1], but about we handle issuing the operation in the
block layer.  That is done through __blkdev_issue_discard, which
takes various parameters into account to align the issue discard
request to what the hardware prefers.  Which is perfectly fine for
discard as an advisory operation, but deadly for an operation that
wants to make data inaccessible.  The problem has existed ever since
secure erase support was added to the kernel with commit
8d57a98ccd0b ("block: add secure discard"), which added secure erase
support as a REQ_SECURE flag to the discard operation.

The ioctl added there also as the only users for a long time, until f2fs
added a second (really strange) user that uses secure erase if offered by 
the device but otherwise plain old discard: 9af846486d78
("f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl") which seems to treat the
secure discard as nice to have but actually is fine with data leaks
from the use of discard or an incorrect implementation of secure erase.

My preference would be to just remove this ill designed feature entirely.
The alternative 1 in this thead does just that.  Alternative 2 tries to
fix it instead, but I haven't bee nable to get any interested party to
actually test in more than three eeks, suggesting we're better off
removing the code.

[1] which is rather dubious as well, as sector based secure erase in
flash based media can't really work due to the lack of in-place write
support.  At best it is the equivalent for a Write Same or Write Zeroes
command without deterministic data on the next read.
