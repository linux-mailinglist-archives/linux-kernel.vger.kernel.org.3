Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA14FF403
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiDMJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiDMJqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49A103B3C0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649843069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bRkyB4PbFZ1fbO3XHovGn6TsXRtRWyjrzEzQotyYPuQ=;
        b=RN9/xp7NKXl+BIiYQRNM9R7Z5bS7VzWKgqd896qnp8zdVmjmZW+PCQLezKF28FgO2340jL
        kCXJqu+0zwLkN9+wj07zdpdLWrNJqKhFnSE9mxyTHKbn2xOIQkJkFk5c1Hpc9VkcmkyopB
        l/Nw6Aiu2vFioeKfgNvMVpKtDTMqj5Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-0QdxnFSqMUCOK2gBg7-BEA-1; Wed, 13 Apr 2022 05:44:26 -0400
X-MC-Unique: 0QdxnFSqMUCOK2gBg7-BEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF4F11C01700;
        Wed, 13 Apr 2022 09:44:25 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D05EE53CD;
        Wed, 13 Apr 2022 09:44:23 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: vfio-ap: Remove the superfluous MODULE_DEVICE_TABLE declaration
Date:   Wed, 13 Apr 2022 11:44:16 +0200
Message-Id: <20220413094416.412114-1-thuth@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio_ap module tries to register for the vfio_ap bus - but that's
the interface that it provides itself, so this does not make much sense,
thus let's simply drop this statement now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 See also my previous patch to register it for the "ap" bus instead:
 https://lore.kernel.org/linux-s390/20211201141110.94636-1-thuth@redhat.com/
 ... but since it has been decided to not auto-load the module uncondi-
 tionally, I'd like to suggest to rather drop this line now instead.

 drivers/s390/crypto/vfio_ap_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 29ebd54f8919..4ac9c6521ec1 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -46,8 +46,6 @@ static struct ap_device_id ap_queue_ids[] = {
 	{ /* end of sibling */ },
 };
 
-MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
-
 static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
 {
 	struct ap_matrix_mdev *matrix_mdev;
-- 
2.27.0

