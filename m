Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5F53BDEF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiFBSSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiFBSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:18:24 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB94DF50;
        Thu,  2 Jun 2022 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=tXVOIJUGu35WSE9Aj3NZcDtklg/clW5rW00/R8h0CGQ=; b=YuGMAP1k8gfULj4cTJERIm2VdM
        GL7VQkJo0BQ+hZQI9+o4oN3kYoFsDCN0Ki+8ARcBCOpmBra28Cm5sMclB0dyRq7TmgFNi6Me3/QT7
        82sTbiSsVelZcqkGm3RdUXxh2lXIgFwgzBotjY0NlULJiHekiPbQ59MkPNmMlWrwTBW2VaJOQnDm4
        93enhvJIT5Ug3aRZNO8/NH9x5L7+LOlaKd5XFCs9CA+mN59Xkfv3w4pzIqiUcAoyzq3eILChmC4rJ
        /PMQCn81aywjAifqtiPHp6u8EhgDbMaeYCfOxGiRwDARCFo5GbByW1RH2NK47Nb1h5UtCEjMA+p20
        P2StZN3g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOn-00EPmY-Ja; Thu, 02 Jun 2022 12:18:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOm-000DDe-W2; Thu, 02 Jun 2022 12:18:21 -0600
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
Date:   Thu,  2 Jun 2022 12:18:15 -0600
Message-Id: <20220602181818.50729-10-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602181818.50729-1-logang@deltatee.com>
References: <20220602181818.50729-1-logang@deltatee.com>
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
Subject: [PATCH v3 09/11] md: Ensure resync is reported after it starts
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07layouts test in mdadm fails on some systems. The failure
presents itself as the backup file not being removed before the next
layout is grown into:

  mdadm: /dev/md0: cannot create backup file /tmp/md-test-backup:
      File exists

This is because the background mdadm process, which is responsible for
cleaning up this backup file gets into an infinite loop waiting for
the reshape to start. mdadm checks the mdstat file if a reshape is
going and, if it is not, it waits for an event on the file or times
out in 5 seconds. On faster machines, the reshape may complete before
the 5 seconds times out, and thus the background mdadm process loops
waiting for a reshape to start that has already occurred.

mdadm reads the mdstat file to start, but mdstat does not report that the
reshape has begun, even though it has indeed begun. So the mdstat_wait()
call (in mdadm) which polls on the mdstat file won't ever return until
timing out.

The reason mdstat reports the reshape has started is due to an issue
in status_resync(). recovery_active is subtracted from curr_resync which
will result in a value of zero for the first chunk of reshaped data, and
the resulting read will report no reshape in progress.

To fix this, if "resync - recovery_active" is an overloaded value, force
the value to be MD_RESYNC_ACTIVE so the code reports a resync in progress.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0893029865eb..2be429874d18 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8022,10 +8022,20 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 		if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
 			/* Still cleaning up */
 			resync = max_sectors;
-	} else if (resync > max_sectors)
+	} else if (resync > max_sectors) {
 		resync = max_sectors;
-	else
+	} else {
 		resync -= atomic_read(&mddev->recovery_active);
+		if (resync < MD_RESYNC_ACTIVE) {
+			/*
+			 * Resync has started, but the subtraction has
+			 * yielded one of the special values. Force it
+			 * to active to ensure the status reports an
+			 * active resync.
+			 */
+			resync = MD_RESYNC_ACTIVE;
+		}
+	}
 
 	if (resync == MD_RESYNC_NONE) {
 		if (test_bit(MD_RESYNCING_REMOTE, &mddev->recovery)) {
-- 
2.30.2

