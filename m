Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D43535225
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348209AbiEZQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348132AbiEZQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79D48E61;
        Thu, 26 May 2022 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=tiDb5N7DtJWgf5i+viE/JdrxQoObOCh/lk7c62dUGdI=; b=H3fM8eJI/0Qi9l/+we2qC4Mb3x
        L1PRPZ/Eyb2qmb6zyuF5YCumWK0SqoNfzrwmsjoYUsd6AMFuyFcVgXrPf5kOWkHUUeGvjO4iNJm4X
        sn0Q+bxbp+wvUOAT8WrTGhmVcIPmcIRBeiMQ8gxiF7EJASkZ+zghGMhrsZuxJ58ZdED4GLwvNXRk4
        gUQUxzAcorulWSm3HU/DFK//cF3Q2Uj2J5kei2+jhBN2I1cAzNXBktg+PlC7IqY/+F8Xos4ZH5M4o
        klHseeSuxmsyCAwnhonR/SQ3PThrtBLE17kuxG2fMNJCaWVT7cohWKym2XGoEbTeorktyiagvk90u
        6YJ38UvA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTD-008A7T-HN; Thu, 26 May 2022 10:36:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTB-0008Y3-C7; Thu, 26 May 2022 10:36:17 -0600
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
Date:   Thu, 26 May 2022 10:36:04 -0600
Message-Id: <20220526163604.32736-18-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526163604.32736-1-logang@deltatee.com>
References: <20220526163604.32736-1-logang@deltatee.com>
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
Subject: [PATCH v2 17/17] md: Notify sysfs sync_completed in md_reap_sync_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mdadm test 07layouts randomly produces a kernel hung task deadlock.
The deadlock is caused by the suspend_lo/suspend_hi files being set by
the mdadm background process during reshape and not being cleared
because the process hangs. (Leaving aside the issue of the fragility of
freezing kernel tasks by buggy userspace processes...)

When the background mdadm process hangs it, is waiting (without a
timeout) on a change to the sync_completed file signalling that the
reshape has completed. The process is woken up a couple times when
the reshape finishes but it is woken up before MD_RECOVERY_RUNNING
is cleared so sync_completed_show() reports 0 instead of "none".

To fix this, notify the sysfs file in md_reap_sync_thread() after
MD_RECOVERY_RUNNING has been cleared. This wakes up mdadm and causes
it to continue and write to suspend_lo/suspend_hi to allow IO to
continue.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2be429874d18..2c07c9508222 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9476,6 +9476,7 @@ void md_reap_sync_thread(struct mddev *mddev, bool reconfig_mutex_held)
 	wake_up(&resync_wait);
 	/* flag recovery needed just to double check */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+	sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	md_new_event();
 	if (mddev->event_work.func)
-- 
2.30.2

