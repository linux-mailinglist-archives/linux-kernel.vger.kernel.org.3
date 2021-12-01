Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F61464F67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349767AbhLAOO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:14:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349712AbhLAOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638367881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=44DmGJCM71PMnaeTZP6TQRDBqOIP9Ji0NQKrnFfyg3k=;
        b=AJAw6Tt66z87ZYos/d+uRIQvUmFI5I+l7TZ9sCbs00KNI29fbp2bSVRfRORMIKj7aFU0c5
        VwUp1dF7TD+vUY9RQbI7gzlyzk3JVmM1gUg6Hs+T0eCZfLjsmn7qnmbIXA1S3YnOQ4qXh7
        Gx7aCjFqHSevZM+GS5J2Im49vmv2gMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-c8m6ceT7MT-7NiGisl-IOQ-1; Wed, 01 Dec 2021 09:11:15 -0500
X-MC-Unique: c8m6ceT7MT-7NiGisl-IOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E16483DCD2;
        Wed,  1 Dec 2021 14:11:14 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B5D55D6BA;
        Wed,  1 Dec 2021 14:11:12 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-s390@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the "ap" parent bus
Date:   Wed,  1 Dec 2021 15:11:10 +0100
Message-Id: <20211201141110.94636-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crypto devices that we can use with the vfio_ap module are sitting
on the "ap" bus, not on the "vfio_ap" bus that the module defines
itself. With this change, the vfio_ap module now gets automatically
loaded if a supported crypto adapter is available in the host.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Marked as "RFC" since I'm not 100% sure about it ...
       please review carefully!

 drivers/s390/crypto/vfio_ap_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 4d2556bc7fe5..5580e40608a4 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
 	{ /* end of sibling */ },
 };
 
-MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
+MODULE_DEVICE_TABLE(ap, ap_queue_ids);
 
 /**
  * vfio_ap_queue_dev_probe:
-- 
2.27.0

