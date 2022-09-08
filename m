Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3255B2360
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIHQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiIHQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:15:35 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD64F397;
        Thu,  8 Sep 2022 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=4voS2AeqdwOOI85+fb4G1DXxw0S1Povq/w9IvgPjUE4=; b=l5bHewt+rRkB9AlL0kS0R9HjKa
        GE5WA68uxwkv99W2B/apVsVSY25WQLHa2Ko1WK8lCQ89RLHuqXLwUIGZbcqAxrXSvNGhjocG6GmkI
        DQ7xnL1xlDEWwpnMx52jydii23Y5ICvHaRVKuiwy7/oRWJ8EyrWkFdREUFwY49b70cU7g8e3Mdoz+
        THAGuQqvMNndgcyKK+v9ajgYtzHjf581bLsDTx+PZRoJvcHSlJWYOoOKICuXA8OzMkA/vRiUA0WcS
        jB2jyEdmbps/8YtsiBU+j5Ffy3Riq0SnEb/6BZCYZUFhx8LLcLX6fAF2ssZkkN1Y+FbELOS/dPGCB
        OVNhwHYA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oWKBW-001jK1-2M; Thu, 08 Sep 2022 10:15:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oWKBU-00019J-Od; Thu, 08 Sep 2022 10:15:20 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Sep 2022 10:15:16 -0600
Message-Id: <20220908161516.4361-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908161516.4361-1-logang@deltatee.com>
References: <20220908161516.4361-1-logang@deltatee.com>
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
Subject: [PATCH v2 3/3] md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A complicated deadlock exists when using the journal and an elevated
group_thrtead_cnt. It was found with loop devices, but its not clear
whether it can be seen with real disks. The deadlock can occur simply
by writing data with an fio script.

When the deadlock occurs, multiple threads will hang in different ways:

 1) The group threads will hang in the blk-wbt code with bios waiting to
    be submitted to the block layer:

        io_schedule+0x70/0xb0
        rq_qos_wait+0x153/0x210
        wbt_wait+0x115/0x1b0
        io_schedule+0x70/0xb0
        rq_qos_wait+0x153/0x210
        wbt_wait+0x115/0x1b0
        __rq_qos_throttle+0x38/0x60
        blk_mq_submit_bio+0x589/0xcd0
        wbt_wait+0x115/0x1b0
        __rq_qos_throttle+0x38/0x60
        blk_mq_submit_bio+0x589/0xcd0
        __submit_bio+0xe6/0x100
        submit_bio_noacct_nocheck+0x42e/0x470
        submit_bio_noacct+0x4c2/0xbb0
        ops_run_io+0x46b/0x1a30
        handle_stripe+0xcd3/0x36b0
        handle_active_stripes.constprop.0+0x6f6/0xa60
        raid5_do_work+0x177/0x330

    Or:
        io_schedule+0x70/0xb0
        rq_qos_wait+0x153/0x210
        wbt_wait+0x115/0x1b0
        __rq_qos_throttle+0x38/0x60
        blk_mq_submit_bio+0x589/0xcd0
        __submit_bio+0xe6/0x100
        submit_bio_noacct_nocheck+0x42e/0x470
        submit_bio_noacct+0x4c2/0xbb0
        flush_deferred_bios+0x136/0x170
        raid5_do_work+0x262/0x330

 2) The r5l_reclaim thread will hang in the same way, submitting a
    bio to the block layer:

        io_schedule+0x70/0xb0
        rq_qos_wait+0x153/0x210
        wbt_wait+0x115/0x1b0
        __rq_qos_throttle+0x38/0x60
        blk_mq_submit_bio+0x589/0xcd0
        __submit_bio+0xe6/0x100
        submit_bio_noacct_nocheck+0x42e/0x470
        submit_bio_noacct+0x4c2/0xbb0
        submit_bio+0x3f/0xf0
        md_super_write+0x12f/0x1b0
        md_update_sb.part.0+0x7c6/0xff0
        md_update_sb+0x30/0x60
        r5l_do_reclaim+0x4f9/0x5e0
        r5l_reclaim_thread+0x69/0x30b

    However, before hanging, the MD_SB_CHANGE_PENDING flag will be
    set for sb_flags in r5l_write_super_and_discard_space(). This
    flag will never be cleared because the submit_bio() call never
    returns.

 3) Due to the MD_SB_CHANGE_PENDING flag being set, handle_stripe()
    will do no processing on any pending stripes and re-set
    STRIPE_HANDLE. This will cause the raid5d thread to enter an
    infinite loop, constantly trying to handle the same stripes
    stuck in the queue.

    The raid5d thread has a blk_plug that holds a number of bios
    that are also stuck waiting seeing the thread is in a loop
    that never schedules. These bios have been accounted for by
    blk-wbt thus preventing the other threads above from
    continuing when they try to submit bios. --Deadlock.

To fix this, add the same wait_event() that is used in raid5_do_work()
to raid5d() such that if MD_SB_CHANGE_PENDING is set, the thread will
schedule and wait until the flag is cleared. The schedule action will
flush the plug which will allow the r5l_reclaim thread to continue,
thus preventing the deadlock.

It's not clear when the deadlock was introduced, but the similar
wait_event() call in raid5_do_work() was added in 2017 by this
commit:

    16d997b78b15 ("md/raid5: simplfy delaying of writes while metadata
                   is updated.")

Link: https://lore.kernel.org/r/7f3b87b6-b52a-f737-51d7-a4eec5c44112@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 734f92e75f85..7d1b7e361ef2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6783,6 +6783,10 @@ static void raid5d(struct md_thread *thread)
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
 		}
+
+		wait_event_lock_irq(mddev->sb_wait,
+			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
+			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
-- 
2.30.2

