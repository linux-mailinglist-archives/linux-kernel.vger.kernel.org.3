Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1795AB71B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiIBRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiIBRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:03:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37223D9E9C;
        Fri,  2 Sep 2022 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=jpsICczICn8Q4xTvkjWRgq8EqQ73PfJQ2wJlU/1VNwo=; b=X5vJ/NgGF2bmx349FqaKM6X2sM
        jMRG0gVeG6XxRFfKWLZZk1WyUbQfWng2Ipl0USLQug1kY90PGNem0SuSM4w4+CGehumnY3ME6fFvJ
        0y0dPVrexJLbvoihJy9qL99nR5Xh8axfeKtu8L2n2+kYp8GvHUf8TRzRIq4ybkPDxbHScQGXOooka
        NTYoy3Yxv2ADymExZAw0RQp/xJXAhIVCaqF7DZbS+aS45AmSDUH09MBrkYNZydhX9CDWHNNTQA8iD
        TCA2rTlGu+NPEYmOwgw0IqY+3wGukRkySnsnEIOHQ3WSnprgVehzHtvIuFFchl7atl2onZTkUnkxc
        zoxL4kBA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oUA4x-00Ejgx-P2; Fri, 02 Sep 2022 11:03:40 -0600
Message-ID: <04571bb7-10b3-e841-a975-d9b6e0305e8a@deltatee.com>
Date:   Fri, 2 Sep 2022 11:03:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
 <b87d0e03-ea92-4e79-f304-7d4c1cbf3fbf@huaweicloud.com>
 <3d07a8fd-3b5e-dc68-4c32-6c0dcd0c1264@huaweicloud.com>
Content-Language: en-CA
In-Reply-To: <3d07a8fd-3b5e-dc68-4c32-6c0dcd0c1264@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yukuai3@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 2022-09-02 02:14, Yu Kuai wrote:
> Can you try the following patch? I'm running mdadm tests myself and I
> didn't see any problems yet.

Yes, that patch seems to fix the issue.

However, may I suggest we do this without trying to introduce new
helpers into wait.h? I suspect that could result in a fair amount of
bike shedding and delay. wait_event_cmd() is often used in situations 
where a specific lock type doesn't have a helper.

My stab at it is in a diff below which also fixes the bug. 

I'd also recommend somebody clean up that nasty condition in 
wait_barrier(). Put it into an appropriately named function
with some comments. As is, it is pretty much unreadable.

Logan

--


diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0e3229ee1ebc..ae297bc870bd 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -934,22 +934,26 @@ static void flush_pending_writes(struct r10conf *conf)
  *    lower_barrier when the particular background IO completes.
  */
 
+#define wait_event_barrier_cmd(conf, cond, cmd) \
+	wait_event_cmd((conf)->wait_barrier, cond, \
+		       write_sequnlock_irq(&(conf)->resync_lock); cmd, \
+		       write_seqlock_irq(&(conf)->resync_lock))
+#define wait_event_barrier(conf, cond) wait_event_barrier_cmd(conf, cond, )
+
 static void raise_barrier(struct r10conf *conf, int force)
 {
 	write_seqlock_irq(&conf->resync_lock);
 	BUG_ON(force && !conf->barrier);
 
 	/* Wait until no block IO is waiting (unless 'force') */
-	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
-			    conf->resync_lock.lock);
+	wait_event_barrier(conf, force || !conf->nr_waiting);
 
 	/* block any new IO from starting */
 	WRITE_ONCE(conf->barrier, conf->barrier + 1);
 
 	/* Now wait for all pending IO to complete */
-	wait_event_lock_irq(conf->wait_barrier,
-			    !atomic_read(&conf->nr_pending) && conf->barrier < RESYNC_DEPTH,
-			    conf->resync_lock.lock);
+	wait_event_barrier(conf, !atomic_read(&conf->nr_pending) &&
+			   conf->barrier < RESYNC_DEPTH);
 
 	write_sequnlock_irq(&conf->resync_lock);
 }
@@ -1007,20 +1011,19 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
 			ret = false;
 		} else {
 			raid10_log(conf->mddev, "wait barrier");
-			wait_event_lock_irq(conf->wait_barrier,
-					    !conf->barrier ||
-					    (atomic_read(&conf->nr_pending) &&
-					     bio_list &&
-					     (!bio_list_empty(&bio_list[0]) ||
-					      !bio_list_empty(&bio_list[1]))) ||
+			wait_event_barrier(conf,
+					   !conf->barrier ||
+					   (atomic_read(&conf->nr_pending) &&
+					    bio_list &&
+					    (!bio_list_empty(&bio_list[0]) ||
+					     !bio_list_empty(&bio_list[1]))) ||
 					     /* move on if recovery thread is
 					      * blocked by us
 					      */
-					     (conf->mddev->thread->tsk == current &&
-					      test_bit(MD_RECOVERY_RUNNING,
-						       &conf->mddev->recovery) &&
-					      conf->nr_queued > 0),
-					    conf->resync_lock.lock);
+					    (conf->mddev->thread->tsk == current &&
+					     test_bit(MD_RECOVERY_RUNNING,
+					       &conf->mddev->recovery) &&
+					     conf->nr_queued > 0));
 		}
 		conf->nr_waiting--;
 		if (!conf->nr_waiting)
@@ -1058,10 +1061,9 @@ static void freeze_array(struct r10conf *conf, int extra)
 	conf->array_freeze_pending++;
 	WRITE_ONCE(conf->barrier, conf->barrier + 1);
 	conf->nr_waiting++;
-	wait_event_lock_irq_cmd(conf->wait_barrier,
-				atomic_read(&conf->nr_pending) == conf->nr_queued+extra,
-				conf->resync_lock.lock,
-				flush_pending_writes(conf));
+	wait_event_barrier_cmd(conf,
+		atomic_read(&conf->nr_pending) == conf->nr_queued+extra,
+		flush_pending_writes(conf));
 
 	conf->array_freeze_pending--;
 	write_sequnlock_irq(&conf->resync_lock);
