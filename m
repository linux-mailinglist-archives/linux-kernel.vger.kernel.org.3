Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC754E9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378234AbiFPTUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiFPTTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:55 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28566562DC;
        Thu, 16 Jun 2022 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=PvAePjomhr1jSYt1ijrsImUFjSzKKPrrv6LIN+9RNIw=; b=Mjrk8nB53u0s/Ol+lLKtXMDKKR
        XcMkKel2i4R4qOCVQnSNkhiZJ1i6zlifgr3Y9gV1+qaOmWNvYgSKPo8PoPc+jU18BuASPsZ9tbcgh
        LdZCXqxwESBJml6A0XTy6RqSxbzmSUyFGVDvGJgg0GYfAJ46byXG8W/OIHIxIt/4eMBfBkTs/rFwT
        aSdQy2QZv6ajBTf3k78+cdzgIoyyF5M0Jg4+EOd8n+mhzc9lhIIeCeisn+OAiAr8Vne0XjxhwPMiR
        trKzQS5ZFHkYrCT1hyWgrjMhMgUrU+eV7ie8yOAvDIMaS8njzDu9esDvPLqzs4mc04DVEeMhSzM8h
        zGQZ01Hw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1y-0092ii-51; Thu, 16 Jun 2022 13:19:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1u-0006F5-Q7; Thu, 16 Jun 2022 13:19:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Jun 2022 13:19:30 -0600
Message-Id: <20220616191945.23935-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 00/15] Improve Raid5 Lock Contention
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that I've done some cleanup of the mdadm testing infrastructure
as well as a lot of long run testing and bug fixes I'm much more
confident in the correctness of this series. The previous posting is
at [1].

Patch 14 has been completely reworked from the previous series (where
much of the feedback was on). Rare bugs were found with the original
method where if the array changed shape at just the right time while
first_wrap was true, the algorithm would fail and blocks would not be
written correctly. To fix this, the new version uses a bitmap to track
which pages have been added to the stripe_head. This requires
limitting the size of the request but to a size greater than the
current limit (which is based on the number of segments). I've also
included another patch to remove the limit on the number of segments
(seeing it is not needed) and the limit on the number of sectors is
higher and ends up with less bio splitting and fewer bios that are
unaligned with the chunk size.

--

I've been doing some work trying to improve the bulk write performance
of raid5 on large systems with fast NVMe drives. The bottleneck appears
largely to be lock contention on the hash_lock and device_lock. This
series improves the situation slightly by addressing a couple of low
hanging fruit ways to take the lock fewer times in the request path.

Patch 11 adjusts how batching works by keeping a reference to the
previous stripe_head in raid5_make_request(). Under most situtations,
this removes the need to take the hash_lock in stripe_add_to_batch_list()
which should reduce the number of times the lock is taken by a factor of
about 2.

Patch 14 pivots the way raid5_make_request() works. Before the patch, the
code must find the stripe_head for every 4KB page in the request, so each
stripe head must be found once for every data disk. The patch changes this
so that all the data disks can be added to a stripe_head at once and the
number of times the stripe_head must be found (and thus the number of
times the hash_lock is taken) should be reduced by a factor roughly equal
to the number of data disks.

Patch 16 increases the restriction on block layer IO size to reduce the
amount of bio splitting which decreases the amount of broken batches that
occur with large IOs due to the unecessary splitting.

I've also included Patch 15 which changes some debug prints to make
debugging a bit easier.

The remaining patches are just cleanup and prep patches for those two
patches.

Doing apples to apples testing this series on a small VM with 5 ram
disks, I saw a bandwidth increase of roughly 14% and lock contentions
on the hash_lock (as reported by lock stat) reduced by more than a factor
of 5 (though it is still significantly contended).

Testing on larger systems with NVMe drives saw similar small bandwidth
increases from 3% to 20% depending on the parameters. Oddly small arrays
had larger gains, likely due to them having lower starting bandwidths; I
would have expected larger gains with larger arrays (seeing there
should have been even fewer locks taken in raid5_make_request()).

This series is based on the current md/md-next (facef3b96c5b9565). A git
branch is available here:

  https://github.com/sbates130272/linux-p2pmem raid5_lock_cont_v3

Logan

[1] https://lkml.kernel.org/r/20220420195425.34911-1-logang@deltatee.com

--

Changes since v2:
  - Rebased on current md-next branch (facef3b96c5b9565)
  - Reworked Pivot patch with bitmap due to unfixable bug
  - Changed to a ternary operator in ahead_of_reshape() helper (per Paul)
  - Seperated out the functional change from non-functional change in
    the first patch (per Paul)
  - Dropped an unecessary hash argument in __find_stripe() (per
    Christoph)
  - Fixed some minor commit message and comment errors
  - Collected tags from Christoph and Guoqing

Changes since v1:
  - Rebased on current md-next branch (190a901246c69d79)
  - Added patch to create a helper for checking if a sector
    is ahead of the reshape (per Christoph)
  - Reworked the __find_stripe() patch to create a find_get_stripe()
    helper (per Christoph)
  - Added more patches to further refactor raid5_make_request() and
    pull most of the loop body into a helper function (per Christoph)
  - A few other minor cleanups (boolean return, droping casting when
    printing sectors, commit message grammar) as suggested by Christoph.
  - Fixed two uncommon but bad data corruption bugs in that were found.

--

Logan Gunthorpe (15):
  md/raid5: Make logic blocking check consistent with logic that blocks
  md/raid5: Factor out ahead_of_reshape() function
  md/raid5: Refactor raid5_make_request loop
  md/raid5: Move stripe_add_to_batch_list() call out of add_stripe_bio()
  md/raid5: Move common stripe get code into new find_get_stripe()
    helper
  md/raid5: Factor out helper from raid5_make_request() loop
  md/raid5: Drop the do_prepare flag in raid5_make_request()
  md/raid5: Move read_seqcount_begin() into make_stripe_request()
  md/raid5: Refactor for loop in raid5_make_request() into while loop
  md/raid5: Keep a reference to last stripe_head for batch
  md/raid5: Refactor add_stripe_bio()
  md/raid5: Check all disks in a stripe_head for reshape progress
  md/raid5: Pivot raid5_make_request()
  md/raid5: Improve debug prints
  md/raid5: Increase restriction on max segments per request

 drivers/md/raid5.c | 641 +++++++++++++++++++++++++++++----------------
 1 file changed, 418 insertions(+), 223 deletions(-)


base-commit: facef3b96c5b9565fa0416d7701ef990ef96e5a6
--
2.30.2
