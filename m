Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5453BDF1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiFBSS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiFBSSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:18:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC704D26B;
        Thu,  2 Jun 2022 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=157u6PWKooSuu4KOF7rMgNHIpCSulick1bTC+P/d8hM=; b=P9xP28hD4TKNdYGjPol8Nm765i
        kaaXtDFXkJxC1t/dqOF3m5nfCevjfXT1CJgBAPFLiVsJrxMyF09Vq7ho6dVAGXT9f1E0Pun6jfXe1
        /cqkV1EOrd9NSa2NXK2Dn5ONp+ufqxsV6O4dvcc6yaCxPgo/aV7sjubNEHbNmwVH1aJrd7bOFIXHH
        VcCdfJ+ON92LpCFIO2LgyzCVDrEvp8oWEVfw1nvXVC2qF9c/PwvaVtbJM+W9kov1J2FU+3cJcTFXg
        +CqIEVjnh6ChZ5YXO02EspfW6oz4b6ZS0NfvN+t2BEE7GMBxD0zjRtW9kIos2BzIMETQ0loAAmI5Y
        WomT/fxA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOm-00EPmV-Pu; Thu, 02 Jun 2022 12:18:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOl-000DDB-AR; Thu, 02 Jun 2022 12:18:19 -0600
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
Date:   Thu,  2 Jun 2022 12:18:06 -0600
Message-Id: <20220602181818.50729-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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
Subject: [PATCH v3 00/11] Bug fixes for mdadm tests
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the updated series with the feedback received in v2[1].

This series includes fixes to fix all the kernel panics in the mdadm
tests and some, related, sparse issues, plus some cleanup.

The first two patches are cleanup from the original series that aren't
related now but I thought are worth including.

Patches 3 through 6 fix bugs with conf->log and remove the single,
unecessary, RCU access. This cleans up some sparse errors.

Patch 7 cleans up some sparse warnings with pslot usage.

Patch 8 is a cleanup which adds an enum so that patch 9 can
fix an mdadm hang. Patch 10 also fixes an mdadm hang.

I've also included Patch 11 in this series which fixes a recent
mistake in raid5-ppl that was reported by 0day which I don't think
has been fixed yet.

This series will be followed by another series for mdadm which fixes
the segfaults and annotates some failing tests to make mdadm tests
runnable fairly reliably, but I'll wait for a stable hash for this
series to note the kernel version tested against. Following that,
v3 of my lock contention series will be sent with more confidence
of its correctness.

This series is based on the current md/md-next branch as of yesterday
(42b805af10). A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem md-bug_v3

Thanks,

Logan

--

Changes since v2:
  * Rework the RCU changes to remove the RCU usage instead of using
    it every. This makes more sense seeing most accesses do not need
    RCU due to them being on the IO path, or with mddev_lock() held
    and the remaining ones are on the slow path and may use
    mddev_lock(). (Per Christoph)
  * Collect a couple more Reviewed-by tags from Christoph

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

[1] https://lore.kernel.org/all/20220526163604.32736-1-logang@deltatee.com

Logan Gunthorpe (11):
  md/raid5-log: Drop extern decorators for function prototypes
  md/raid5-ppl: Drop unused argument from ppl_handle_flush_request()
  md/raid5: Ensure array is suspended for calls to log_exit()
  md/raid5-cache: Take mddev_lock in r5c_journal_mode_show()
  md/raid5-cache: Drop RCU usage of conf->log
  md/raid5-cache: Clear conf->log after finishing work
  md/raid5-cache: Annotate pslot with __rcu notation
  md: Use enum for overloaded magic numbers used by mddev->curr_resync
  md: Ensure resync is reported after it starts
  md: Notify sysfs sync_completed in md_reap_sync_thread()
  md/raid5-ppl: Fix argument order in bio_alloc_bioset()

 drivers/md/md.c          | 55 +++++++++++++++-------------
 drivers/md/md.h          | 15 ++++++++
 drivers/md/raid5-cache.c | 34 +++++++++---------
 drivers/md/raid5-log.h   | 77 +++++++++++++++++++---------------------
 drivers/md/raid5-ppl.c   |  6 ++--
 drivers/md/raid5.c       | 18 ++++------
 6 files changed, 109 insertions(+), 96 deletions(-)


base-commit: 42b805af102471f53e3c7867b8c2b502ea4eef7e
--
2.30.2
