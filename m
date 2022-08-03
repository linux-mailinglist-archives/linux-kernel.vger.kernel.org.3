Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656985886AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiHCE4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiHCEz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:55:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C057262
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:55:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p8so15317386plq.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=D9BaynpFeg1cissmMMk3El8bdcStQPJmmpGe2Ac/WHE=;
        b=3YHUqLWcTCVwi8y0GoB9CUMxob38hovVKdCk8RDJlCEhrGym82MQ1U0Wd3Djz+WTKb
         Gyj98u4RhOfMAuF/3d8zx/RD8TBOojzfbwYqLESwtXq7DKUqRS0oOv8xL8BWL17fuK5o
         Yic9MlsWBF/2P46wDRcKTutjCYTnrsfE6BNtgn33mCczYswJHZRqX8pWudeHasx934LK
         LKGrTe0IL2dJvLF9WlG0C+2mc3QMiZF8VOXZXh2MjGCLcGWsghvGQtc3FVvrW5uI34U3
         TX8agESvP3ZT68jma4F50LYMxEumtCXEKPbE/aXtpyxWo+AkKCGC+qrg1K0t41oIYwGr
         nuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D9BaynpFeg1cissmMMk3El8bdcStQPJmmpGe2Ac/WHE=;
        b=NitnOeC5ecPqWl8/RLQQiNnhyDy5KBY1uqQx7IajlxSIh4dyZRJ8RiS+0sLndrgE/x
         tdIYejDAFWuepUQksxZcsIUTJE45hf03uTsYX7lTXzi3cdAfW3eP7Bgd2CRY4mK6fHJY
         Hso5f8TQ6uqcj5E5ET1eiWvoEiVtmzX9tm5k+R4rxZW+APTJR1d2sRtqV94OhkY8lZnW
         cYtiNvyIwkiFh3DTYE2gzCtd1yKXbDjtY+Ox+zllos8s6uyf5pu8pSFLVq6cH7H8hoMz
         sE/eHRepBwT+Fv3z6rzatSxmyDLf6EyHnqj/QNNQjeg05sEllqLiprPhMlOsJHpeLm+f
         XIuA==
X-Gm-Message-State: ACgBeo0qNSU0rOiE0nFK0aB9N5QS3S9bD7Kfv34Y/bTOjhiQ9DJJ2V7l
        V+0LSwsbzJnbM74Z4310yq1R
X-Google-Smtp-Source: AA6agR5rQtknt4UQzv/fLAdhF0xPgp51E6QNM96gyKsvHZ/gngRXcYr2ya12Nqs3Xq0n60l83/WJKQ==
X-Received: by 2002:a17:90b:4d84:b0:1f5:3aee:7999 with SMTP id oj4-20020a17090b4d8400b001f53aee7999mr3091144pjb.75.1659502556486;
        Tue, 02 Aug 2022 21:55:56 -0700 (PDT)
Received: from localhost ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0016dd667d511sm631968plk.252.2022.08.02.21.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:55:55 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     jasowang@redhat.com, mst@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v5 5/5] vduse: Support querying information of IOVA regions
Date:   Wed,  3 Aug 2022 12:55:23 +0800
Message-Id: <20220803045523.23851-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803045523.23851-1-xieyongji@bytedance.com>
References: <20220803045523.23851-1-xieyongji@bytedance.com>
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
index eedff0a3885a..41c0b29739f1 100644
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
+			if (domain->bounce_map && map->start == 0 &&
+			    map->last == domain->bounce_size - 1)
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

