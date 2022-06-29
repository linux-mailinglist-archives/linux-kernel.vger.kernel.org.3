Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A843755FA73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiF2I1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiF2I0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:26:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100E43C735
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso792111pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3nmW2W5f1Ags3bIprl9TznXZAGwoHC4aKKQYqLLiCg=;
        b=o8Kmf8Xd02DdhVt1ctE4MA/5ssQp+IuiM2ha/VbaglCobl8zDjOSqxeeKc+x6sJyoM
         8Vdqo+JCPCWzrF0Zby2l4aD9KgVH0z7CDR8eB/a1723c6UWYkSAgwXH+NO8pedHB/abs
         /IlGcj9HPuH+MEoVBFBdM/qjHX1UOMLEpC5C8IvCqmL0PdI4P1iV23rW8DQL2d/LVN9u
         FHxW69BwT3wf1olLOJ0goLn7jUSrLLqLqx133BlrA+Hyn3T+4CF18i42BA2Pa2d1SB8g
         11nVynPxQL4SUfReYxsX+ViCM6t1udm01kZg0vAW5Vony3cK4CZQhXYMuFesBHxM7b62
         L1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3nmW2W5f1Ags3bIprl9TznXZAGwoHC4aKKQYqLLiCg=;
        b=huQ+iyZS/Rsofa4yYuCy5LMt+UynbejpmJ74dUDRk5vHDEdHiLc4sJwoP5ow2Z582z
         urx3uFAfSre0USWQOPWlL6JoiPBV/9JY2Wmx6vnZpCXKnIYjtElBQzxVmb/cGMC347yR
         mrYr2CycdzqauJPW8M5TNR11aS/7eVy6k5wzwT2BkbVSzEu98J3X5CIl/wH4BL8KNtkt
         zCjt9nBgsRORa29gdkCfFJc0c4zvR0XsAf0Z/CwnBPBvB8/bYROHzf7l1m5eBJ2Qx7Av
         MRrvqERWHqXGWa4naBNQt+sqel/QzhWRdjDgFi07iFGr3qQM10c13FsphxrPiGkKxm+i
         cEVw==
X-Gm-Message-State: AJIora8LUtcQXN94lyrmNtRm4zlY9qXU4TTVV9KKd8tBMuiATPxybISo
        Q5fgOMHUsLjZATk9XZShftzL
X-Google-Smtp-Source: AGRyM1u7e1+pr2JcYff6aR+DVYfeHtUsTX/ipRso2Je67hgXKKfOyk0M7qPDU7Ll09Sc9f6qBiZRMQ==
X-Received: by 2002:a17:903:1208:b0:16b:81f6:e992 with SMTP id l8-20020a170903120800b0016b81f6e992mr9287932plh.55.1656491205377;
        Wed, 29 Jun 2022 01:26:45 -0700 (PDT)
Received: from localhost ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id 2-20020a631442000000b003f24d67d226sm10584442pgu.92.2022.06.29.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:26:44 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] vduse: Support querying IOLTB information
Date:   Wed, 29 Jun 2022 16:25:39 +0800
Message-Id: <20220629082541.118-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
support querying IOLTB information such as bounce
buffer size.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
 include/uapi/linux/vduse.h         | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 3bc27de58f46..c47a5d9765cf 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1089,6 +1089,19 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
 		break;
 	}
+	case VDUSE_IOTLB_GET_INFO: {
+		struct vduse_iotlb_info iotlb;
+
+		iotlb.bounce_iova = 0;
+		iotlb.bounce_size = dev->domain->bounce_size;
+
+		ret = -EFAULT;
+		if (copy_to_user(argp, &iotlb, sizeof(iotlb)))
+			break;
+
+		ret = 0;
+		break;
+	}
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 7cfe1c1280c0..c201b7a77c2c 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -210,6 +210,23 @@ struct vduse_vq_eventfd {
  */
 #define VDUSE_VQ_INJECT_IRQ	_IOW(VDUSE_BASE, 0x17, __u32)
 
+/**
+ * struct vduse_iotlb_info - IOTLB information
+ * @bounce_iova: start IOVA of bounce buffer
+ * @bounce_size: bounce buffer size
+ * @reserved: for future use, needs to be initialized to zero
+ *
+ * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get IOTLB information.
+ */
+struct vduse_iotlb_info {
+	__u64 bounce_iova;
+	__u64 bounce_size;
+	__u64 reserved[2];
+};
+
+/* Get IOTLB information, e.g. bounce buffer size */
+#define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
-- 
2.20.1

