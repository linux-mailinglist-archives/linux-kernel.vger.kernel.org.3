Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D0567D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGFFGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiGFFGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:06:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0680F1F61D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:06:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e16so604267pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3nmW2W5f1Ags3bIprl9TznXZAGwoHC4aKKQYqLLiCg=;
        b=n7uEfOwsq5qFDVeWprIqk1KtV0v6owA0bqRupKBSPiKqr1WaL2/1F8NHjeJyRFFvIU
         9HrTPjY5oKceBj9vp6hh2aJS9DvJei2JNd8j/5vPdzXFQeicp9+l+pTsjEuf96P1UMoW
         MsaiV8ApH1r302AlLcYHQhP2yDxMIGOlAI9Sfu5fTnqI4VEOEsWU9aoskpTBM0LGvwLg
         qsJethNZE0uv1tUs/fsF5o1V84IHSACVcs6mpxLS5OLB4j6mDUng+1HsQ2GL5B3AzHUx
         D9Fi4C1dMn0wpZSE/yW/EWaN/B/rsbOFnzR0sykP0sZAzEF0tory0H5xNVHD2+mKdhFw
         nzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3nmW2W5f1Ags3bIprl9TznXZAGwoHC4aKKQYqLLiCg=;
        b=IBhDSb+bGsekdkecjYEJyM1VrEhZpexA4gfQDreWZ9Q3mVF3S5PPxqNmC7VG0GzkU9
         ZJA5odcE7X2I3FwilRsXRA53x7il6Hf/xerdmabRGTNKedQbdJC00VYHndVEc+MeiRDZ
         Ppe0wToJynB6To4OGANZ52koh7xWgIg1qcMT8DZKr39k36DA46xd4ZBBxR/XlGYlohCy
         v3k37uWFczf2Mnb4qTBCD1jh6XmGMmcbdoWPtvFY1jqlcsteLoGl9ei60k6/FI0fxvR2
         eCnjPh07JEHv1bMDLAEjYwQxATN0WTZV1H6fL3PP+mfHmF0vXkL1s8GKw/G1f/zERA1R
         pNJQ==
X-Gm-Message-State: AJIora8A6ewhQV8zXRiO17e9Ro5vrD0gT/U01nfAbq9PHJVR5u6yZc9O
        dh3eoY5jHpWbmjoWC7xHaRJj
X-Google-Smtp-Source: AGRyM1stEPseYajiuoOqqCaxCJvv46n9hdAVXLo3g0VdzKfYo1mQdWhiwo7qQXQ14ZCWen5L+gS71w==
X-Received: by 2002:aa7:8b51:0:b0:525:5132:8a84 with SMTP id i17-20020aa78b51000000b0052551328a84mr45047050pfd.45.1657083964436;
        Tue, 05 Jul 2022 22:06:04 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902f64a00b0016bf01394e1sm2938332plg.124.2022.07.05.22.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 22:06:03 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] vduse: Support querying IOLTB information
Date:   Wed,  6 Jul 2022 13:05:02 +0800
Message-Id: <20220706050503.171-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706050503.171-1-xieyongji@bytedance.com>
References: <20220706050503.171-1-xieyongji@bytedance.com>
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

