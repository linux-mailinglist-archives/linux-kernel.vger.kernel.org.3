Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE65583778
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiG1DVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiG1DUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC152E70
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w10so710604plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W27PbFQBOEtYu/AUpLa0T34nwDCtRWW9P2Ho6Sv79sc=;
        b=TMAttHkq8BIg/KPSZ6FIlxZdNLHS92T9ut0EojowHl740AZgYZ9moT+AZcg5Lr28oG
         KxW3ojB+dopKWxvnR1+0tcL2JhYd7Hf74ZrMwZc22RsdYJKeAEgMm0Z6/XD+A46MqFY8
         6MRV7I7csmMsZJ9eqquKu7RPkjzD2M++gF7NaZ5O98/lVBcu48jwhSs65wHhMyBoesqK
         DUQKlbeQOkfKlIPe4kaPVGby5VAi3KibaO1vMAWhf+WdnfC3Ah/wLbYvdaBEARDy5D5E
         iaDaoRlhOxeUEa5RkF1Pt6YnAsaifwjyVik+PcI8m0exFjgGcX69UpaqgAh+yso4JAe4
         EdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W27PbFQBOEtYu/AUpLa0T34nwDCtRWW9P2Ho6Sv79sc=;
        b=hSVBKzwRqmf34Ww3Q6DrMH7EFSLmmkx58we9j0yj7WHFXd8HtikGcxa02rEP0Z1JQB
         lzZvhVHdjWznHeVMFOEJxCWmkkKqeHy/DhAOQKHOM0ciZYdo43T/H/Y3qKIm/Ycdt5eg
         rGuV8rklKDaF9L5+8nZHoASUuxS9DQVrkeI3XTL0KQoH8QW3MuYdm3I7Ryq/jFcZhLDZ
         HXIexty0v3RzTZigL5ghXebGhAQP8K2YeS3AkMPl8V4tULu8ioXpTYxUE03+dpUMWNBX
         JgZ+H36p7OnmR1aUY17fHGHAdrBqQlOOHPTL/hNwrbcw9kaYZHhOoE21jCKnSKWt/nkV
         8d1A==
X-Gm-Message-State: AJIora/dHOYg7i50UiSDXB9GGaTsf6pzzgQ3/o8n0Mf9ZlT7SHvLh/vX
        vV7vkYLCuj90BrBFWLLaMmdf
X-Google-Smtp-Source: AGRyM1vosJM9CKT8Z9K6hhBE4ha1tQA6K0EilqqQXM8NOG5kfID96n960S55zvC69bXddH7cRsUyeg==
X-Received: by 2002:a17:902:d4d1:b0:16d:798a:51b9 with SMTP id o17-20020a170902d4d100b0016d798a51b9mr17279355plg.110.1658978432753;
        Wed, 27 Jul 2022 20:20:32 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id x187-20020a6286c4000000b0052ac2e23295sm14680214pfd.44.2022.07.27.20.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:20:32 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
Date:   Thu, 28 Jul 2022 11:20:00 +0800
Message-Id: <20220728032000.127-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728032000.127-1-xieyongji@bytedance.com>
References: <20220728032000.127-1-xieyongji@bytedance.com>
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
 include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index eedff0a3885a..e820c37dcba8 100644
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
+				info.capability |= VDUSE_IOVA_CAP_UMEM;
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
index 9885e0571f09..11bd48c72c6c 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -233,6 +233,30 @@ struct vduse_iova_umem {
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
+#define VDUSE_IOVA_CAP_UMEM (1 << 0)
+	__u64 capability;
+	__u64 reserved[3];
+};
+
+/*
+ * Find the first IOVA region that overlaps with the range [start, last]
+ * and return some information on it. Caller should set start and last fields.
+ */
+#define VDUSE_IOTLB_GET_INFO	_IOWR(VDUSE_BASE, 0x1a, struct vduse_iova_info)
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
-- 
2.20.1

