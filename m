Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2689535227
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbiEZQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348120AbiEZQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12A3B3C0;
        Thu, 26 May 2022 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=QFpsM5wOFwLypD3Q3mbBTRFnFWC7MDH6tJU6p0xkT1Y=; b=NXyZRA9h5Q7EUC5SzV4twNKTg5
        Ub83ZjTYB2jJ9poEN66Fe5NLUqY133CsNgI0/9FmxEPcW/fSxDc5qFdk/+3o13X0xerwiunF7O/6W
        siQIWX+qoFHWdL8K/pQEPvpGP3BD6V7Ehccqh5AHRYkgigldUgyXsLciGN6m05U2iQIKvrtH7Vsdf
        NhCOswOP0LvKbnqn+ADxxXf5Xd3q5T92eKzaqDfI4sARME0sNwJyk4QN5qUNFZ1y6MrPgQUbFhbGS
        HgW+ngbq/IxGzywxAvrGwQhS0DA4vLEoZP3opEMMevJPPBhc3vFpcnoBO6KnZAH7hs0yueBXV9v0R
        Q4x0AMkQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTC-008A7R-ND; Thu, 26 May 2022 10:36:19 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGT7-0008X4-QD; Thu, 26 May 2022 10:36:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 26 May 2022 10:35:47 -0600
Message-Id: <20220526163604.32736-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 00/17] Bug fixes for mdadm tests
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the updated series with the feedback received in v1[1].

This series includes fixes to fix all the kernel panics in the mdadm
tests and some, related, sparse issues. The first 12 patches
clean refactor the raid5-cache code so that the RCU usage of conf->log
can be cleaned up which is done in patch 13 -- fixing some actual kernel
NULL pointer dereference crashes in the mdadm test.

Patch 14 fixes some of the remaining sparse warnings that are just
missing __rcu annotations.

Patches 15 provides a cleanup for patches 16 and 17 which fix a couple
additional hangs seen in an mdadm test.

This series will be followed by another series for mdadm which fixes
the segfaults and annotates some failing tests to make mdadm tests
runnable fairly reliably, but I'll wait for a stable hash for this
series to note the kernel version tested against. Following that,
v3 of my lock contention series will be sent with more confidence
of its correctness.

This series is based on the current md/md-next branch as of today
(42b805af10). A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem md-bug_v2

Thanks,

Logan

[1] https://lore.kernel.org/all/20220519191311.17119-1-logang@deltatee.com

--

Changes since v1:
  * Add a patch to move the struct r5l_log to raid5-log.h in order
    to fix a compiler error with rcu_access_pointer() in versions
    prior to gcc-10
  * Rework r5c_is_writeback() changes to make less churn (per Christoph)
  * Change some 1s to trues in rcu_dereference_protected calls (per
    Christoph)
  * Fix an odd hunk mistake in the RCU protection patch (per Christoph)
  * Fix an inverted conditional (noticed by Donald)
  * Add a patch to add an enum for the overloaded values used by
    mddev->curr_resync to make the status_resync() fixes clearer
    (per Christoph)

--

Logan Gunthorpe (17):
  md/raid5-log: Drop extern decorators for function prototypes
  md/raid5-cache: Add r5c_conf_is_writeback() helper
  md/raid5-cache: Refactor r5l_start() to take a struct r5conf
  md/raid5-cache: Refactor r5l_flush_stripe_to_raid() to take a struct
    r5conf
  md/raid5-cache: Refactor r5l_wake_reclaim() to take a struct r5conf
  md/raid5-cache: Refactor remaining functions to take a r5conf
  md/raid5-ppl: Drop unused argument from ppl_handle_flush_request()
  md/raid5-cache: Pass the log through to r5c_finish_cache_stripe()
  md/raid5-cache: Don't pass conf to r5c_calculate_new_cp()
  md/raid5-cache: Take struct r5l_log in
    r5c_log_required_to_flush_cache()
  md/raid5: Ensure array is suspended for calls to log_exit()
  md/raid5-cache: Move struct r5l_log definition to raid5-log.h
  md/raid5-cache: Add RCU protection to conf->log accesses
  md/raid5-cache: Annotate pslot with __rcu notation
  md: Use enum for overloaded magic numbers used by mddev->curr_resync
  md: Ensure resync is reported after it starts
  md: Notify sysfs sync_completed in md_reap_sync_thread()

 drivers/md/md.c          |  55 +++----
 drivers/md/md.h          |  15 ++
 drivers/md/raid5-cache.c | 304 ++++++++++++++++++---------------------
 drivers/md/raid5-log.h   | 178 ++++++++++++++++-------
 drivers/md/raid5-ppl.c   |   2 +-
 drivers/md/raid5.c       |  50 +++----
 drivers/md/raid5.h       |   2 +-
 7 files changed, 336 insertions(+), 270 deletions(-)


base-commit: 42b805af102471f53e3c7867b8c2b502ea4eef7e
--
2.30.2
