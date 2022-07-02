Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B983356420E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiGBS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 14:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiGBS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 14:29:03 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996E5DED2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 11:29:01 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 7hrUoTjFU4Ltq7hrUonitC; Sat, 02 Jul 2022 20:28:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 02 Jul 2022 20:28:59 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Cc:     linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] Introduce bitmap_size()
Date:   Sat,  2 Jul 2022 20:28:53 +0200
Message-Id: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie introduces bitmap_size() which returns the size, in bytes, of a
bitmap. Such a function is useful to simplify some drivers that use vmalloc() or
other functions to allocate some butmaps.
It also hides some implementation details about how bitmaps are stored (array of
longs)

Before introducing this function in patch 3, patch 1 and 2 rename some functions
with the same name but with different meaning.

Finaly, patch 4 makes use of the new function in bitmap.h.


Other follow-up patches to simplify some drivers will be proposed later if/when
this serie is merged.

Christophe JAILLET (4):
  s390/cio: Rename bitmap_size() as idset_bitmap_size()
  fs/ntfs3: Rename bitmap_size() as ntfs3_bitmap_size()
  bitmap: Introduce bitmap_size()
  bitmap: Use bitmap_size()

 drivers/md/dm-clone-metadata.c |  5 -----
 drivers/s390/cio/idset.c       |  8 ++++----
 fs/ntfs3/bitmap.c              |  4 ++--
 fs/ntfs3/fsntfs.c              |  2 +-
 fs/ntfs3/index.c               |  6 +++---
 fs/ntfs3/ntfs_fs.h             |  2 +-
 fs/ntfs3/super.c               |  2 +-
 include/linux/bitmap.h         | 15 +++++++++------
 lib/math/prime_numbers.c       |  2 --
 9 files changed, 21 insertions(+), 25 deletions(-)

-- 
2.34.1

