Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A745357B010
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiGTEmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiGTEmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:42:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5964D81A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o18so2497052pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4m2weMM8YDI1AY1uHJfVhQZtY/uy0KHLS609X7iYawY=;
        b=0L65C5AQK0NkEUvGAXW28Z/fq9HRbWlWPLagjsxFoYtj7t5bk6rkaM323htOQU4pDx
         HgIg6Pauj8G4m+x8S7qjq8xpjpeiNqTew4+z/0bmRr58Ned7VfjJXqMH5MEEN4aUon1y
         r+eKPsUhNjUoH8bIJksZWPVCL4C6Wbz+X9ow1k3sCyBbmelZW5GDRxl4gFLXMqQESM5H
         uPGSjqnjpfs5JaDOZSJ0VGVARUFP/wWMUYjacEQTd/57Zxao8QnSGCrxF4uud5dSk6qV
         V+pO1NYx+Y/aHeagPAC31hfnfVH76Jm11M+7Pfcu6Ddf8eIQNfH7R2tmG1RPqLS9HDUx
         twig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4m2weMM8YDI1AY1uHJfVhQZtY/uy0KHLS609X7iYawY=;
        b=L33Eiv8o3r2ZNPWPT1sYogcInkxj500r7AIim/tWAqKgq3xnoRH5qTvsHWrrb3JygW
         CxgO2jaxrzkcHGaUxfutQM9HRDmGb4KduHKxPio7xZg3hVpjksiRBmIhBRRRjPu8W9EE
         Ctbx08xvFFV6Troxs/Lt2KInYg09Ss9/cmU5wG0KKYFsz2K0cjlDQ6W6uSufD/Ux/wmK
         x6D4+d2ba9UGRkwe5dcJbURJAgdslcF7Ty2fnGO1yYmHZLvZ2PsI9l4DoNrnPzXxi6ia
         RpG82tGpS6dLN8IVF+b2rLBYw7ucyX6IGb8UJ3tb2RMW2SUKECk7oxY0NDPNjpl6uyxM
         HK5A==
X-Gm-Message-State: AJIora+xqvZqlSbbDcPDPvLnz9HDVnUUvJ1R/pVa2N5mSpzzn9jHgrdY
        3HVnbEc3Glu/EUUrNG1OUJLn
X-Google-Smtp-Source: AGRyM1tmqPnWXZ8d2pOEhG0jDiN/4F7QPQ20CS4xB+n9O0oKl13nGyzNFHoyRSOZ9iuvKZO10vLGcA==
X-Received: by 2002:a17:902:e80a:b0:16c:3340:aba5 with SMTP id u10-20020a170902e80a00b0016c3340aba5mr37802433plg.102.1658292141755;
        Tue, 19 Jul 2022 21:42:21 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b0016c454598b5sm12790879plh.167.2022.07.19.21.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:42:21 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] vduse: Support querying information of IOVA regions
Date:   Wed, 20 Jul 2022 12:41:44 +0800
Message-Id: <20220720044144.90-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720044144.90-1-xieyongji@bytedance.com>
References: <20220720044144.90-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
support querying some information of IOVA regions.

Now it can be used to query whether the IOVA region
supports userspace memory registration.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
 include/uapi/linux/vduse.h         | 25 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index eedff0a3885a..cc4a9a700c24 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 					   umem.size);
 		break;
 	}
+	case VDUSE_IOTLB_GET_INFO: {
+		struct vduse_iova_info info;
+		struct vhost_iotlb_map *map;
+		struct vduse_iova_domain *domain = dev->domain;
+
+		ret = -EFAULT;
+		if (copy_from_user(&info, argp, sizeof(info)))
+			break;
+
+		ret = -EINVAL;
+		if (info.start > info.last)
+			break;
+
+		if (!is_mem_zero((const char *)info.reserved,
+				 sizeof(info.reserved)))
+			break;
+
+		spin_lock(&domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(domain->iotlb,
+					      info.start, info.last);
+		if (map) {
+			info.start = map->start;
+			info.last = map->last;
+			info.capability = 0;
+			if (domain->bounce_map && map->start >= 0 &&
+			    map->last < domain->bounce_size)
+				info.capability |= VDUSE_IOVA_CAP_UMEM_SUPPORT;
+		}
+		spin_unlock(&domain->iotlb_lock);
+		if (!map)
+			break;
+
+		ret = -EFAULT;
+		if (copy_to_user(argp, &info, sizeof(info)))
+			break;
+
+		ret = 0;
+		break;
+	}
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 9885e0571f09..720fb0b6d8ff 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -233,6 +233,31 @@ struct vduse_iova_umem {
 /* De-register the userspace memory. Caller should set iova and size field. */
 #define VDUSE_IOTLB_DEREG_UMEM	_IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
 
+/**
+ * struct vduse_iova_info - information of one IOVA region
+ * @start: start of the IOVA region
+ * @last: last of the IOVA region
+ * @capability: capability of the IOVA regsion
+ * @reserved: for future use, needs to be initialized to zero
+ *
+ * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
+ * one IOVA region.
+ */
+struct vduse_iova_info {
+	__u64 start;
+	__u64 last;
+#define VDUSE_IOVA_CAP_UMEM_SUPPORT (1 << 0)
+	__u64 capability;
+	__u64 reserved[3];
+};
+
+/*
+ * Find the first IOVA region that overlaps with the range [start, last]
+ * and return some information on it. Caller should set start and last fields.
+ */
+#define VDUSE_IOTLB_GET_INFO	_IOW(VDUSE_BASE, 0x1a, struct vduse_iova_info)
+
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
-- 
2.20.1

