Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6C54718F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349791AbiFKDW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiFKDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:22:56 -0400
Received: from p3plwbeout17-01.prod.phx3.secureserver.net (p3plsmtp17-01-2.prod.phx3.secureserver.net [173.201.193.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296826BFE8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:22:53 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id zri8nb3t0aBvfzri9nSpZR; Fri, 10 Jun 2022 20:22:53 -0700
X-CMAE-Analysis: v=2.4 cv=V5m4bcri c=1 sm=1 tr=0 ts=62a40a8d
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=JPEYwPQDsx4A:10 a=g6NoVSEHmQBr8nN1tTEA:9
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  zri8nb3t0aBvf
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=localhost.localdomain)
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nzri7-0001TR-K0; Sat, 11 Jun 2022 04:22:52 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     willy@infradead.org, hsinyi@chromium.org,
        Xiongwei.Song@windriver.com, linux-mm@kvack.org,
        squashfs-devel@lists.sourceforge.net,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 0/2] Squashfs: handle missing pages decompressing into page cache
Date:   Sat, 11 Jun 2022 04:21:31 +0100
Message-Id: <20220611032133.5743-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfFPR4GQ5qdTjuM35SEY6erd2E6IoszUcvMsi+EcuPSwuC8WxE0pkbc/3oks7zLRJoXz+w1Vg1ltT4SStSIyeTIqJcihbeps6RMDC40gsGzDVOYXX2VFB
 UefB31ioGtqN0VvX1I2Lc2bzfJFJib/WHYFE4zWqs2EVYT6hFWeOaGfwUwELjbnVezBNCkiyZa3tLD/0JWwfcUe1nYX89JN1IsI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch-set enables Squashfs to handle missing pages when directly
decompressing datablocks into the page cache.

Previously if the full set of pages needed was not available, Squashfs
would have to fall back to using an intermediate buffer (the older
method), which is slower, involving a memcopy, and it introduces
contention on a shared buffer.

The first patch extends the "page actor" code to handle missing pages.

The second patch updates Squashfs_readpage_block() to use the new
functionality, and removes the code that falls back to using
an intermediate buffer.

This patch-set is independent of the readahead work, and it is
standalone.  It can be merged on its own.

But the readahead patch for efficiency also needs this patch-set.

Phillip

----------------------------------------------------------------
Phillip Lougher (2):
      Squashfs: extend "page actor" to handle missing pages
      Squashfs: don't use intermediate buffer if pages missing

 fs/squashfs/block.c        | 10 ++++--
 fs/squashfs/decompressor.h |  1 +
 fs/squashfs/file_direct.c  | 90 +++++++++++-----------------------------------
 fs/squashfs/lz4_wrapper.c  |  7 ++--
 fs/squashfs/lzo_wrapper.c  |  7 ++--
 fs/squashfs/page_actor.c   | 67 ++++++++++++++++++++++++++++------
 fs/squashfs/page_actor.h   | 17 +++++++--
 fs/squashfs/xz_wrapper.c   | 11 +++++-
 fs/squashfs/zlib_wrapper.c | 12 ++++++-
 fs/squashfs/zstd_wrapper.c | 12 ++++++-
 10 files changed, 142 insertions(+), 92 deletions(-)
