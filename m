Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63D50E131
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiDYNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiDYNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:13:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118553584D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650892227; x=1682428227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CEWV/Z+GlppMECo73UC2kLNULAnWi/wSuZ1HeiCWPO0=;
  b=YYUoJB6NnW35XNyw+ip0SGaYvgjkFCdfjr9t1OK6lhZpcVC1sjd0V+sZ
   ZC2sXFR7l2tIK8p3vymIU9pQ4SHVz0KK2z43d/lMebcFfiuenXi/7ypm/
   2OF4Dz4eNtuhdlTXprzuDr3WNPLzMA86dwzF345uve3FhrqCvCXzagtpJ
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Apr 2022 06:10:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:10:25 -0700
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 06:10:22 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2 ] devcoredump : Serialize devcd_del work
Date:   Mon, 25 Apr 2022 18:39:53 +0530
Message-ID: <1650892193-12888-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In following scenario(diagram), when one thread X running dev_coredumpm() adds devcd
device to the framework which sends uevent notification to userspace
and another thread Y reads this uevent and call to devcd_data_write()
which eventually try to delete the queued timer that is not initialized/queued yet.

So, debug object reports some warning and in the meantime, timer is initialized
and queued from X path. and from Y path, it gets reinitialized again and
timer->entry.pprev=NULL and try_to_grab_pending() stucks.

To fix this, introduce mutex to serialize the behaviour.

 	cpu0(X)			                      cpu1(Y)

    dev_coredump() uevent sent to userspace
    device_add()  =========================> userspace process Y reads the uevents
                                             writes to devcd fd which
                                             results into writes to

                                            devcd_data_write()
                                              mod_delayed_work()
                                                try_to_grab_pending()
                                                  del_timer()
                                                    debug_assert_init()
   INIT_DELAYED_WORK
   schedule_delayed_work
                                                     debug_object_fixup()
                                                      timer_fixup_assert_init()
                                                       timer_setup()
                                                         do_init_timer()   ==> reinitialized the
                                                                                 timer to
                                                                                 timer->entry.pprev=NULL

                                                  timer_pending()
                                                   !hlist_unhashed_lockless(&timer->entry)
                                                     !h->pprev  ==> del_timer checks
                                                                  and finds it to be NULL
 								  try_to_grab_pending() stucks.

Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
v1->v2:
 - Added del_wk_queued to serialize the race between devcd_data_write()
   and disabled_store().

 drivers/base/devcoredump.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d..3e6fd6b 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -25,6 +25,8 @@ struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
 	size_t datalen;
+	struct mutex mutex;
+	bool del_wk_queued;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
@@ -84,7 +86,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	mutex_lock(&devcd->mutex);
+	if (!devcd->del_wk_queued) {
+		devcd->del_wk_queued = true;
+		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	}
+	mutex_unlock(&devcd->mutex);
 
 	return count;
 }
@@ -112,7 +119,12 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	mutex_lock(&devcd->mutex);
+	if (!devcd->del_wk_queued)
+		devcd->del_wk_queued = true;
+
 	flush_delayed_work(&devcd->del_wk);
+	mutex_unlock(&devcd->mutex);
 	return 0;
 }
 
@@ -278,13 +290,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
-
+	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
+	mutex_lock(&devcd->mutex);
+	devcd->del_wk_queued = false;
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -301,10 +315,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-
+	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
 	put_device(&devcd->devcd_dev);
+	mutex_unlock(&devcd->mutex);
  put_module:
 	module_put(owner);
  free:
-- 
2.7.4

