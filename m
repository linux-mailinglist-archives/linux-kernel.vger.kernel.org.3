Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7446E818
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhLIMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhLIMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:10:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E273C061B38
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:07:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a18so9307980wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCE7fs1UAAj6Dc0ZMS53SrXmMny1bT2/od6l+XUax2Q=;
        b=I/ZOMgIrWXdbJ53RfzAnZDdBQ0V8EIEXTm2+A4LysB2bdnKr9yL4aGWqBUQNGzBjJH
         WUkIFPNthXXG9MN940QK2VdARmI4l/8Ebw0TKcXKzFyfIWCJhCwMLkDIIILaF/exbudp
         JSJ9Uv2/ZqWbaDprGi2+Wuiyh2qUOGIDUB+54cueTwJV4Vv6sDunB1Dnz2DmUguJtiSY
         V/TW+k8kwGgbWiannXOKXiD84RWKyoijzpa8KilLZo0L4fn4hMZUmsbhTNXVhcZTjTOx
         Swi6/hV5QgMaq7mSb+PbnsJrRgG19krVPXOTDAUBIbsoTTSENHX/paXcExN7esKq2Uju
         7Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCE7fs1UAAj6Dc0ZMS53SrXmMny1bT2/od6l+XUax2Q=;
        b=6r5x8o/0iSyl9pMPkXXeEKzSQ4YJubGgmwi771d0onMRwOXyazZOpYrlllc+DP9Ei2
         oiqcPprK1nwUi4r49AAWA3Gedj27mPNpLWjr8a67qp+NF7eJrvpUxmhAPtddVaI/d0oP
         5AgnB0nwbCCTzfI7wWoV2001b29InV1phlOY6BFl3f/HI3Wa9KC9WSWqCCcdhhIe95nT
         fOWdxLrLhhfihCvR1OS8zmz24V3s8eHYCiEdUzbnUHLzCe+PvriGnf9TQcc3Jo7gS9em
         KJh3WN4DXV0deF1wNYKy77clBIQbEpiY/novEV/5WLNzTtyCBIk4w2YCLgHuVg8Dl0yl
         Vl6g==
X-Gm-Message-State: AOAM532jX4Mr/T8HfAioSt1Mah2TCAt/fCE9Ljyx/GB7Aik+bDLcHluc
        jZl7R0vJPM9EPtUnjygjOidrSw==
X-Google-Smtp-Source: ABdhPJy4cZz4Jh4F96/QVhkM3/d/2KVZxilkw8k2BsOYn+O/uwTnKXFZvkfJcV0dtHGFoVBNobY+1g==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr5977059wri.439.1639051619660;
        Thu, 09 Dec 2021 04:06:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 4sm7513289wrz.90.2021.12.09.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:06:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/8] misc: fastrpc: add support for FASTRPC_IOCTL_MEM_MAP/UNMAP
Date:   Thu,  9 Dec 2021 12:06:21 +0000
Message-Id: <20211209120626.26373-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeya R <jeyr@codeaurora.org>

Add support for IOCTL requests to map and unmap on DSP based on map
flags.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 155 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |  51 ++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 71d818fed8b8..c2f194dc0e66 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -72,6 +72,8 @@
 #define FASTRPC_RMID_INIT_CREATE	6
 #define FASTRPC_RMID_INIT_CREATE_ATTR	7
 #define FASTRPC_RMID_INIT_CREATE_STATIC	8
+#define FASTRPC_RMID_INIT_MEM_MAP      10
+#define FASTRPC_RMID_INIT_MEM_UNMAP    11
 
 /* Protection Domain(PD) ids */
 #define AUDIO_PD	(0) /* also GUEST_OS PD? */
@@ -108,12 +110,29 @@ struct fastrpc_mmap_req_msg {
 	s32 num;
 };
 
+struct fastrpc_mem_map_req_msg {
+	s32 pgid;
+	s32 fd;
+	s32 offset;
+	u32 flags;
+	u64 vaddrin;
+	s32 num;
+	s32 data_len;
+};
+
 struct fastrpc_munmap_req_msg {
 	s32 pgid;
 	u64 vaddr;
 	u64 size;
 };
 
+struct fastrpc_mem_unmap_req_msg {
+	s32 pgid;
+	s32 fd;
+	u64 vaddrin;
+	u64 len;
+};
+
 struct fastrpc_msg {
 	int pid;		/* process group id */
 	int tid;		/* thread id */
@@ -170,6 +189,7 @@ struct fastrpc_map {
 	u64 size;
 	void *va;
 	u64 len;
+	u64 raddr;
 	struct kref refcount;
 };
 
@@ -1491,6 +1511,135 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_mem_unmap *req)
+{
+	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
+	struct fastrpc_map *map = NULL, *m;
+	struct fastrpc_mem_unmap_req_msg req_msg = { 0 };
+	int err = 0;
+	u32 sc;
+	struct device *dev = fl->sctx->dev;
+
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(map, m, &fl->maps, node) {
+		if ((req->fd < 0 || map->fd == req->fd) && (map->raddr == req->vaddr))
+			break;
+		map = NULL;
+	}
+
+	spin_unlock(&fl->lock);
+
+	if (!map) {
+		dev_err(dev, "map not in list\n");
+		return -EINVAL;
+	}
+
+	req_msg.pgid = fl->tgid;
+	req_msg.len = map->len;
+	req_msg.vaddrin = map->raddr;
+	req_msg.fd = map->fd;
+
+	args[0].ptr = (u64) &req_msg;
+	args[0].length = sizeof(req_msg);
+
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
+	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
+				      &args[0]);
+	fastrpc_map_put(map);
+	if (err)
+		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
+
+	return err;
+}
+
+static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_mem_unmap req;
+
+	if (copy_from_user(&req, argp, sizeof(req)))
+		return -EFAULT;
+
+	return fastrpc_req_mem_unmap_impl(fl, &req);
+}
+
+static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
+	struct fastrpc_mem_map_req_msg req_msg = { 0 };
+	struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
+	struct fastrpc_mem_unmap req_unmap = { 0 };
+	struct fastrpc_phy_page pages = { 0 };
+	struct fastrpc_mem_map req;
+	struct device *dev = fl->sctx->dev;
+	struct fastrpc_map *map = NULL;
+	int err;
+	u32 sc;
+
+	if (copy_from_user(&req, argp, sizeof(req)))
+		return -EFAULT;
+
+	/* create SMMU mapping */
+	err = fastrpc_map_create(fl, req.fd, req.length, &map);
+	if (err) {
+		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
+		return err;
+	}
+
+	req_msg.pgid = fl->tgid;
+	req_msg.fd = req.fd;
+	req_msg.offset = req.offset;
+	req_msg.vaddrin = req.vaddrin;
+	map->va = (void *) req.vaddrin;
+	req_msg.flags = req.flags;
+	req_msg.num = sizeof(pages);
+	req_msg.data_len = 0;
+
+	args[0].ptr = (u64) &req_msg;
+	args[0].length = sizeof(req_msg);
+
+	pages.addr = map->phys;
+	pages.size = map->size;
+
+	args[1].ptr = (u64) &pages;
+	args[1].length = sizeof(pages);
+
+	args[2].ptr = (u64) &pages;
+	args[2].length = 0;
+
+	args[3].ptr = (u64) &rsp_msg;
+	args[3].length = sizeof(rsp_msg);
+
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
+	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
+	if (err) {
+		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
+			req.fd, req.vaddrin, map->size);
+		goto err_invoke;
+	}
+
+	/* update the buffer to be able to deallocate the memory on the DSP */
+	map->raddr = rsp_msg.vaddr;
+
+	/* let the client know the address to use */
+	req.vaddrout = rsp_msg.vaddr;
+
+	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
+		/* unmap the memory and release the buffer */
+		req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
+		req_unmap.length = map->size;
+		fastrpc_req_mem_unmap_impl(fl, &req_unmap);
+		return -EFAULT;
+	}
+
+	return 0;
+
+err_invoke:
+	if (map)
+		fastrpc_map_put(map);
+
+	return err;
+}
+
 static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -1520,6 +1669,12 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_MUNMAP:
 		err = fastrpc_req_munmap(fl, argp);
 		break;
+	case FASTRPC_IOCTL_MEM_MAP:
+		err = fastrpc_req_mem_map(fl, argp);
+		break;
+	case FASTRPC_IOCTL_MEM_UNMAP:
+		err = fastrpc_req_mem_unmap(fl, argp);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index b74407d19ed5..2308650e4a6e 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -13,6 +13,37 @@
 #define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
 #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
+#define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
+#define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+
+/**
+ * enum fastrpc_map_flags - control flags for mapping memory on DSP user process
+ * @FASTRPC_MAP_STATIC: Map memory pages with RW- permission and CACHE WRITEBACK.
+ * The driver is responsible for cache maintenance when passed
+ * the buffer to FastRPC calls. Same virtual address will be
+ * assigned for subsequent FastRPC calls.
+ * @FASTRPC_MAP_RESERVED: Reserved
+ * @FASTRPC_MAP_FD: Map memory pages with RW- permission and CACHE WRITEBACK.
+ * Mapping tagged with a file descriptor. User is responsible for
+ * CPU and DSP cache maintenance for the buffer. Get virtual address
+ * of buffer on DSP using HAP_mmap_get() and HAP_mmap_put() APIs.
+ * @FASTRPC_MAP_FD_DELAYED: Mapping delayed until user call HAP_mmap() and HAP_munmap()
+ * functions on DSP. It is useful to map a buffer with cache modes
+ * other than default modes. User is responsible for CPU and DSP
+ * cache maintenance for the buffer.
+ * @FASTRPC_MAP_FD_NOMAP: This flag is used to skip CPU mapping,
+ * otherwise behaves similar to FASTRPC_MAP_FD_DELAYED flag.
+ * @FASTRPC_MAP_MAX: max count for flags
+ *
+ */
+enum fastrpc_map_flags {
+	FASTRPC_MAP_STATIC = 0,
+	FASTRPC_MAP_RESERVED,
+	FASTRPC_MAP_FD = 2,
+	FASTRPC_MAP_FD_DELAYED,
+	FASTRPC_MAP_FD_NOMAP = 16,
+	FASTRPC_MAP_MAX,
+};
 
 enum fastrpc_proc_attr {
 	/* Macro for Debug attr */
@@ -66,9 +97,29 @@ struct fastrpc_req_mmap {
 	__u64 vaddrout;	/* dsp virtual address */
 };
 
+struct fastrpc_mem_map {
+	__s32 version;
+	__s32 fd;		/* fd */
+	__s32 offset;		/* buffer offset */
+	__u32 flags;		/* flags defined in enum fastrpc_map_flags */
+	__u64 vaddrin;		/* buffer virtual address */
+	__u64 length;		/* buffer length */
+	__u64 vaddrout;		/* [out] remote virtual address */
+	__s32 attrs;		/* buffer attributes used for SMMU mapping */
+	__s32 reserved[4];
+};
+
 struct fastrpc_req_munmap {
 	__u64 vaddrout;	/* address to unmap */
 	__u64 size;	/* size */
 };
 
+struct fastrpc_mem_unmap {
+	__s32 vesion;
+	__s32 fd;		/* fd */
+	__u64 vaddr;		/* remote process (dsp) virtual address */
+	__u64 length;		/* buffer size */
+	__s32 reserved[5];
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.21.0

