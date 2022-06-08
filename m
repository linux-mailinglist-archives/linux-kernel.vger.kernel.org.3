Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3247543906
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiFHQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245177AbiFHQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:08 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F256D1FE4FD;
        Wed,  8 Jun 2022 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=fV9XINkH2x8RoRhm2xmZEp8mea1e9p3OgesPwBu10Vo=; b=XmaaqdToytFNNjqVfr2LudrrDI
        hczTzpRW7eQwnjYH8Fk1qtFM7NgXp3rMnSyXGHcE3gnuM2FMHD1WbxFkJ0DfeScjJNQdGCvkm0vXO
        luDLw9zMsYMd65KUJJceKnUKQ0RcdOFhbRnZs4uT6DmyLZeq9qvsJbNBFwMWa8aEqZVCozab+DYd+
        0q4hT+vFdKDk9/vhC3NLd5RwM4kd4d1RRLB1ehIhJLxqv1kNUJi6X5OhSO3h/p8hEVfXS5BIDclTD
        MNQPHr9FfWyzldcm3Je4vFfNdYm2WZDNXJETkvf+GMlC3ModbfZUXn5URmgLgAI8MDS/8f3iHNFwz
        koYl3evw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXN-0026n6-Fr; Wed, 08 Jun 2022 10:28:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXH-000bdY-7u; Wed, 08 Jun 2022 10:27:59 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Wed,  8 Jun 2022 10:27:52 -0600
Message-Id: <20220608162756.144600-8-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608162756.144600-1-logang@deltatee.com>
References: <20220608162756.144600-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 07/11] md/raid5-cache: Clear conf->log after finishing work
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NULL pointer dereferlence on conf->log is seen randomly with
the mdadm test 21raid5cache. Kasan reporst:

BUG: KASAN: null-ptr-deref in r5l_reclaimable_space+0xf5/0x140
Read of size 8 at addr 0000000000000860 by task md0_reclaim/3086

Call Trace:
  dump_stack_lvl+0x5a/0x74
  kasan_report.cold+0x5f/0x1a9
  __asan_load8+0x69/0x90
  r5l_reclaimable_space+0xf5/0x140
  r5l_do_reclaim+0xf4/0x5e0
  r5l_reclaim_thread+0x69/0x3b0
  md_thread+0x1a2/0x2c0
  kthread+0x177/0x1b0
  ret_from_fork+0x22/0x30

This is caused by conf->log being cleared in r5l_exit_log() before
stopping the reclaim thread.

To fix this, clear conf->log after the reclaim_thread is unregistered
and after flushing disable_writeback_work.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index b1fc65e113f8..ca57b5fac599 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3165,12 +3165,13 @@ void r5l_exit_log(struct r5conf *conf)
 {
 	struct r5l_log *log = conf->log;
 
-	conf->log = NULL;
-
 	/* Ensure disable_writeback_work wakes up and exits */
 	wake_up(&conf->mddev->sb_wait);
 	flush_work(&log->disable_writeback_work);
 	md_unregister_thread(&log->reclaim_thread);
+
+	conf->log = NULL;
+
 	mempool_exit(&log->meta_pool);
 	bioset_exit(&log->bs);
 	mempool_exit(&log->io_pool);
-- 
2.30.2

