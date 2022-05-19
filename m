Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA452DD79
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244374AbiESTNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbiESTNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:20 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D1AF1CD;
        Thu, 19 May 2022 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=MZeXC7bp8nJCmM9SY95bVbKQFzLlTbsMUaxfluhzO2Y=; b=RPIvY7qK8UKUvD7bTulAKZiK0d
        ce2ZThn9g9TLUzlbITS7c+JtcTuZtGtbrLJEbtHJF3UubBKNIzs4kYCx/S/tIWsu2euBSkUIfAIdK
        cYHblTEf+wARPXXWLnBqttcp/KwEUbpwcWrBi3kmPSd0zD8aT4iI8gxh48q0uGt1Bs68pZK/Qz5IT
        wFA57fEuHP08DSsmENaeXqjyHZxfHQvQxQM4uGa4G4iIpjKDyDLwIli1a8mqZiyRVEPGj6CxkpTvj
        bPWZ7lcfg0YUtdWel1udUIKnUXU/QC3rtAvf4dj3qTkWw/znUFv1dEAQh/vZn+2/ZeOWe6caFAPFJ
        BpQcg80A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaF-002TqQ-7D; Thu, 19 May 2022 13:13:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaD-0004T9-0S; Thu, 19 May 2022 13:13:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:12:56 -0600
Message-Id: <20220519191311.17119-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v1 00/15] Bug fixes for mdadm tests
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series includes fixes to fix all the kernel panics in the mdadm
tests and some, related, sparse issues. The first 10 patches
clean refactor the raid5-cache code so that the RCU usage of conf->log
can be cleaned up which is done in patches 11 and 12 -- fixing some
actual kernel NULL pointer dereference crashes in the mdadm test.

Patch 13 fixes some of the remaining sparse warnings that are just
missing __rcu annotations.

Patches 14 and 15 fix a couple additional hangs in an mdadm test.

This series also originally included a patch[1] to fix the
mddev->private=NULL issue in raid0. That bug caused an mdadm tests to
crash, but it seems Xiao beat me to the fix by a few days. Hopefully,
this work to improve mdadm tests will mean these types of bugs will
be caught much sooner, before merging.

This series will be followed by another series for mdadm which fixes
the segfaults and annotates some failing tests to make mdadm tests
runnable fairly reliably, but I'll wait for a stable hash for this
series to note the kernel version tested against. Following that,
v3 of my lock contention series will be sent with more confidence
of its correctness.

This series is based on the current md/md-next branch as of today
(6ad84d559b8c). A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem md-bug

Thanks,

Logan

[1] https://github.com/sbates130272/linux-p2pmem/commit/5a538f9f48d77cba111773759256bbc3ccaaa74a

--

Logan Gunthorpe (15):
  md/raid5-log: Drop extern decorators for function prototypes
  md/raid5-cache: Refactor r5c_is_writeback() to take a struct r5conf
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
  md/raid5-cache: Add RCU protection to conf->log accesses
  md/raid5-cache: Annotate pslot with __rcu notation
  md: Ensure resync is reported after it starts
  md: Notify sysfs sync_completed in md_reap_sync_thread()

 drivers/md/md.c          |  13 ++-
 drivers/md/raid5-cache.c | 240 ++++++++++++++++++++++++---------------
 drivers/md/raid5-log.h   | 103 ++++++++---------
 drivers/md/raid5-ppl.c   |   2 +-
 drivers/md/raid5.c       |  50 ++++----
 drivers/md/raid5.h       |   2 +-
 6 files changed, 231 insertions(+), 179 deletions(-)


base-commit: 6ad84d559b8cbce9ab27a3a2658c438de867c98e
--
2.30.2
