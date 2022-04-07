Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF48C4F85E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbiDGRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346170AbiDGRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:24:17 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81D133E07;
        Thu,  7 Apr 2022 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=Rh0EdEfVAD3LFkwOeFqoKK6fKePqsB8IaNskci6Qleo=; b=ehhkv6TOCZi3EMvIL/7cxCKUmL
        1ofmwTSG0njRc1Ym+cYBjgYnGVBuqk3qlIWCAbSNb8GdtduaM7qoPcr/7ff6Jvy7aSZ6ait7hgzAW
        hTmOoJRZnHSKFjHVivyBgqMNiojIQrkWphmLP1u1j+LuYF3qplGhTY7Tru67Cnyl6T4Peptg9pGs3
        3J6ncnboeDKbeJCaJALPD/3W/EpGCVATPKw3Zf5ixuAXNJj/jNnsAugZWCwrleAD51LHdhxceonXf
        4bW3loWffn2d1FMjxKY9sfQwCTsO/gfmBOVo98QOweD4MaighgYFFT+2/M1sm6AaK7Og8gYVnAKJh
        1bLAX+/w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG1-002CHk-9v; Thu, 07 Apr 2022 10:45:19 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVFz-0002DZ-O2; Thu, 07 Apr 2022 10:45:15 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:45:03 -0600
Message-Id: <20220407164511.8472-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, shli@kernel.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 0/8] Improve Raid5 Lock Contention
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been doing some work trying to improve the bulk write performance of
raid5 on large systems with fast NVMe drives. The bottleneck appears
largely to be lock contention on the hash_lock and device_lock. This
series improves the situation slightly by addressing a couple of low
hanging fruit ways to take the lock fewer times in the request path.

Patch 5 adjusts how batching works by keeping a reference to the
previous stripe_head in raid5_make_request(). Under most situtations,
this removes the need to take the hash_lock in stripe_add_to_batch_list()
which should reduce the number of times the lock is taken by a factor of
about 2.

Patch 8 pivots the way raid5_make_request() works. Before the patch, the
code must find the stripe_head for every 4KB page in the request, so each
stripe head must be found once for every data disk. The patch changes this
so that all the data disks can be added to a stripe_head at once and the
number of times the stripe_head must be found (and thus the number of
times the hash_lock is taken) should be reduced by a factor roughly equal
to the number of data disks.

The remaining patches are just cleanup and prep patches for those two
patches.

Doing apples to apples testing this series on a small VM with 5 ram disks,
I saw a bandwidth increase of roughly 14% and lock contentions on the
hash_lock (as reported by lock stat) reduced by more than a factor of
5 (though is still significantly contended).

Testing on larger systems with NVMe drives saw similar small bandwidth
increases from 3% to 20% depending on the parameters. Oddly small arrays
had larger gains, likely due to them having lower starting bandwidths; I
would have expected larger gains with larger arrays (seeing there
should have been even fewer locks taken in raid5_make_request()).

Logan

--

Logan Gunthorpe (8):
  md/raid5: Refactor raid5_make_request loop
  md/raid5: Move stripe_add_to_batch_list() call out of add_stripe_bio()
  md/raid5: Move common stripe count increment code into __find_stripe()
  md/raid5: Make common label for schedule/retry in raid5_make_request()
  md/raid5: Keep a reference to last stripe_head for batch
  md/raid5: Refactor add_stripe_bio()
  md/raid5: Check all disks in a stripe_head for reshape progress
  md/raid5: Pivot raid5_make_request()

 drivers/md/raid5.c | 442 +++++++++++++++++++++++++++------------------
 drivers/md/raid5.h |   1 +
 2 files changed, 270 insertions(+), 173 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
--
2.30.2
