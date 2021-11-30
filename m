Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418B9462B81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhK3EIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbhK3EIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:08:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00AC061574;
        Mon, 29 Nov 2021 20:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F16ECE13AB;
        Tue, 30 Nov 2021 04:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB07C53FC7;
        Tue, 30 Nov 2021 04:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638245121;
        bh=gZL3YiEbDYaALjslD7r/yjn7clyqtIQcn/3AlzuZLWY=;
        h=From:To:Cc:Subject:Date:From;
        b=oa8BuM5+uLqUS9KjAe9mYaTqU15U37M//eHUkiM91ODNLoQh04fh4CzUO8gp89YyO
         AQutY/IKskV5b5vINhQBJ+RlkZyuA1rmOo/14cOQaGVBxHvqYWmjK/Oh0nQNLnkgbT
         dCEsO0o8SG0FbmisSctaJmciIY1UGei9KS41JCL6OaZC6ihPOqu0CBndk/fawnxdTT
         OxZnjB8b7IJezLquJ9I63r8jnXnebcoqtWIGWZQ3JEUbu1d1Kqt8irmvyX+bMZyloX
         KMIW0vBGVLmnQTudwKkXFQSo+mJTn2el4g+4M7RN1Rpa4z4nBcV3ukbJtO5y13nSLh
         O4psSvCM+CkbA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] block: show crypto capabilities in sysfs
Date:   Mon, 29 Nov 2021 20:03:03 -0800
Message-Id: <20211130040306.148925-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sysfs files that expose the inline encryption
capabilities of request queues.

Patches 1 and 2 are some related cleanups for existing blk-sysfs code.
Patch 3 is the real change; see there for more details.

This applies to linux-block/for-next.

Changed v1 => v2:
   - Use sysfs_emit() instead of sprintf().
   - Use __ATTR_RO().

Eric Biggers (3):
  block: simplify calling convention of elv_unregister_queue()
  block: don't delete queue kobject before its children
  blk-crypto: show crypto capabilities in sysfs

 Documentation/block/queue-sysfs.rst |  30 +++++
 block/Makefile                      |   3 +-
 block/blk-crypto-internal.h         |  12 ++
 block/blk-crypto-sysfs.c            | 172 ++++++++++++++++++++++++++++
 block/blk-crypto.c                  |   3 +
 block/blk-sysfs.c                   |  17 ++-
 block/elevator.c                    |   8 +-
 include/linux/blkdev.h              |   1 +
 8 files changed, 236 insertions(+), 10 deletions(-)
 create mode 100644 block/blk-crypto-sysfs.c


base-commit: c2626d30f312afc341158e07bf088f5a23b4eeeb
-- 
2.34.1

