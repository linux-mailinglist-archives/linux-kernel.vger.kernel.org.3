Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE33351161B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiD0LaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiD0LaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:30:17 -0400
X-Greylist: delayed 3610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 04:27:03 PDT
Received: from qq.com (smtpbg480.qq.com [59.36.132.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC634BA5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:27:02 -0700 (PDT)
X-QQ-mid: bizesmtp64t1651050605tiahcm92
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 27 Apr 2022 17:10:04 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000000
X-QQ-FEAT: k0yT7W7BRd2hJ3e44CTTxZClb4VhkQvqeT8/1vbIYdFEXyYRmRAwUKNJDbxwE
        bSyNufrz103kdN+HSbexV3zJ8frcy35rH0dSEjze32oxJ67/YIg1Ui0wQp6jPjn8sdrWouw
        6976pNoA+b9xTCtCGDlASzzAo7GYAHhfsvSoxHvnHqa+FcOK+Cho3d6AGJe0ZnzzrSHCFmm
        xQX6+ciD4+yQzVq4GHlS39n+Cp4rnT9gUp+fINjO2aG+gzX7OSyOH7yH0DpFVoacHuI4ZLx
        4TSq8q5Cf/PbqPJGvV1TIKb+dn/PEScJtoBQxsWLRYegEU3g+82O1ClsQ0NXVyEWh+hNc0V
        r5UDk6YJJlj4Ih5JBAdRqHCXfY1Ag==
X-QQ-GoodBg: 1
From:   jinxiaobo <jinxiaobo@uniontech.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jinxiaobo <jinxiaobo@uniontech.com>
Subject: [PATCH] scsi: sr: Fix some cdroms automatically ejected when booting into the system
Date:   Wed, 27 Apr 2022 17:09:06 +0800
Message-Id: <20220427090906.2257940-1-jinxiaobo@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sr_get_events() has been called before udev starts when SCSI CDROM is
built-in and AHCI SATA is bulit-in,so sr events propagated to 
user space are not handled.
if both is loadable, udev will handle sr events, some cdroms may eject.
We need call sr_get_events() once before device_add_disk() 
to keep the same result, whether both are built-in or loadable.

Signed-off-by: jinxiaobo <jinxiaobo@uniontech.com>
---
 drivers/scsi/sr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index cbd92891a762..043b3ab72d7a 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -676,6 +676,7 @@ static int sr_probe(struct device *dev)
 	set_capacity(disk, cd->capacity);
 	disk->private_data = cd;
 
+	sr_get_events(sdev);
 	if (register_cdrom(disk, &cd->cdi))
 		goto fail_minor;
 
-- 
2.20.1



