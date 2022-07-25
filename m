Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6657F9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiGYGyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiGYGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:23 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690C11161
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:17 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220725065311epoutp0364fb0612df71cf6157d65447c7363d3e~E--VB3HFr1827518275epoutp03H
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220725065311epoutp0364fb0612df71cf6157d65447c7363d3e~E--VB3HFr1827518275epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731991;
        bh=f/Tk7QPHmHvnLX0TTqkpwKZHuCUlDZdKaFD5eqvHi70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Czr/yQHxRGLshcHoHaHEnN6jlzwTudi7OEGWlPY3ZY/ydu5GDF/L2JdLcEukvjxBm
         CFFncnV9+m64WsCxKQbGnUCWvs+TTqPy4zx1lsDCfrVw9RRiB7m5pTwOMSfUN/CdDg
         S+hpQyH8dc+w+uHZVQH30Nw2DaJIXiCRmpRa4sOY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220725065311epcas1p320fc367618ba4b77773ae7798d8d1186~E--UvdJT_2509525095epcas1p3D;
        Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.133]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LrrN63Dkyz4x9Q0; Mon, 25 Jul
        2022 06:53:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.29.09657.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epcas1p20c847655e7332c818fc0fd2c50fb0e27~E--TFURq62833028330epcas1p2j;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220725065309epsmtrp29ab38f0dbb2870940aeaa9bfb0b612ab~E--TEeTJn0769507695epsmtrp2s;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
X-AuditID: b6c32a35-f4312a80000025b9-c5-62de3dd5546f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.B6.08802.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epsmtip29180d39c6e7186d726066a3671e8035d~E--SzdMmV2536525365epsmtip2U;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 3/9] trinity: Add load/unload IDU files
Date:   Mon, 25 Jul 2022 15:53:02 +0900
Message-Id: <20220725065308.2457024-4-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmru5V23tJBpcaDC3+TjrGbtG8eD2b
        xfvu3cwWl3fNYbO43biCzeL5tOssDmwev39NYvTYP3cNu0ffllWMHp83yQWwRGXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ8x8lVbwtIWx
        Yv3laawNjBtzuhg5OSQETCRO/T/H3MXIxSEksINRYvXmWYwQzidGiYbFT5ggnM+MEg9PP2eF
        aXkz4S1U1S5GiZ9921jhqs53r2ACqWITUJWYOWMNO4gtIuAtMb+1CyjOwcEsEClxbUUVSFhY
        wFzi2f5uRhCbBah8fs9NZhCbV8AaqHUHC4jNKWAjseDHbqi4oMTJmU/A4swC8hLNW2eD3S0h
        cIpd4uL3qcwQ17lILNj9hw3CFpZ4dXwLO4QtJfH53V6oeLbElI5FLBB2gcS551uZQW6TEDCW
        uLgiBeJMTYn1u/QhKhQldv6eywixlk/i3dceVohqXomONiGIEiWJJX8OQy2SkJg64xsThO0h
        0fZzNTR0+hklrjdNZpnAKD8LyTezkHwzC2HzAkbmVYxiqQXFuempxYYFhvBITc7P3cQITn9a
        pjsYJ779oHeIkYmD8RCjBAezkghvV9rtJCHelMTKqtSi/Pii0pzU4kOMpsDwncgsJZqcD0zA
        eSXxhiaWBiZmRsYmFoZmhkrivKumnU4UEkhPLEnNTk0tSC2C6WPi4JRqYCo5a/fqQPKXHIFz
        E7/8TTn/JyXzhV+tCR/zri8uv7nMFX42JPNvd1i3Ws94Lcsk5j3MJ0qL5t0rvVa6sFpzdVFW
        X1ki6xRetcNa6zdmzdmq/u+qrcW6hGdbRNLK9tTly7W67FNknLh8/tmFpq6HL2dMmB6UmnF4
        yaXJ2/iuTXGsMDDb61QnOe/Cqpx1zzUqfrmrvb5c81dyytPrXEp3JKVDP1R9KbrEzTBhR5fT
        vtc7p3755P16ZeQpRnfOoNlTw/NZpBVS4rQb9kzIqepnmV8+pyZ3gtDl43nzGeqfflr/88my
        Vrvnq2rU/thKrJj2uWB1yN5OprX6zIr//5r6l7XO3rXoWYXFlenLud4a885SYinOSDTUYi4q
        TgQAfdleyQgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO5V23tJBut7JC3+TjrGbtG8eD2b
        xfvu3cwWl3fNYbO43biCzeL5tOssDmwev39NYvTYP3cNu0ffllWMHp83yQWwRHHZpKTmZJal
        FunbJXBlzHyVVvC0hbFi/eVprA2MG3O6GDk5JARMJN5MeMsIYgsJ7GCUODk/EiIuIbHp3nLm
        LkYOIFtY4vDh4i5GLqCSj4wSHb2zmEBq2ARUJWbOWMMOYosI+Ev8/XSMFcRmFoiWWL3tPguI
        LSxgLvFsfzfYfBag+vk9N5lBbF4Ba6DeHWA1nAI2Egt+7GaGuMFaor/rBCtEjaDEyZlPWCBm
        yks0b53NPIGRfxaS1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYLDVEtr
        B+OeVR/0DjEycTAeYpTgYFYS4e1Ku50kxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0
        xJLU7NTUgtQimCwTB6dUA9NUvTr3WRqRy29edxfTVIo/q+574vbvpxw1PE3S31mCdR536iu9
        lGraY1PcHdg8vV7HiaP0aFO17l2jzBMW2wylWkTz3TiYk9NmJd34aHF/yZqD177tOclwd595
        KVPpiWC1utOXm1wORR91D+Pa23h3St9Hng35dzm2XxC/P09fwVH5+byDeaYWITdnyG6omT/n
        2N81qbk/Xi5eL3+osmZv6nS12J+PH3w98KeSNSrz663/qSd7lzUfl+p+HRN/l8HqUsJfPlv5
        7mMa95rN/Gctbp+yMEa+3lWWi6GU/2RpJENj+FqrJI71n3aF2PjK5OZ+tbN/yKTfczvNxed7
        ve/8c5vvSKlue1oTwuWlq8RSnJFoqMVcVJwIAGZ2eRXCAgAA
X-CMS-MailID: 20220725065309epcas1p20c847655e7332c818fc0fd2c50fb0e27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065309epcas1p20c847655e7332c818fc0fd2c50fb0e27
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065309epcas1p20c847655e7332c818fc0fd2c50fb0e27@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements IDU load/unload works.

Samsung NPU loads Instruction Decoder Unit (IDU) program,
which can decode binary code generated by NPU compiler.
The IDU program is loaded while loading driver, and it
starts to parse the codes of compiled decoder binary.
Then, all operations of the NPU is working with the decoder
program which is using predefined virtual ISA.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/trinity.c             |  10 +
 drivers/misc/trinity/trinity_common.h      |   1 +
 drivers/misc/trinity/trinity_vision2_drv.c | 397 ++++++++++++++++++++-
 3 files changed, 404 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 1ee9403dbdca..4c1b8a7108d6 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -37,12 +37,22 @@
 
 #define BASE_DEV_NAME "trinity"
 
+#define TRINITY_PADDR_BASE (0x0)
+
 /* A global lock for shared static variables such as dev_bitmap */
 static DEFINE_SPINLOCK(trinity_lock);
 
 /* A bitmap to keep track of active Trinity devices */
 static unsigned long dev_bitmap[TRINITY_DEV_END];
 
+phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr)
+{
+	if (domain)
+		return iommu_iova_to_phys(domain, daddr);
+
+	return TRINITY_PADDR_BASE + daddr;
+}
+
 /**
  * trinity_release() - A common callback for close() in file_operations for a
  *		Trinity	device node. If there are device-specific data to be
diff --git a/drivers/misc/trinity/trinity_common.h b/drivers/misc/trinity/trinity_common.h
index 7f576d4a71a5..6940318362f6 100644
--- a/drivers/misc/trinity/trinity_common.h
+++ b/drivers/misc/trinity/trinity_common.h
@@ -378,6 +378,7 @@ static inline int32_t trinity_get_app_id(void)
 int trinity_create_node(struct trinity_driver *drv);
 void trinity_destroy_node(struct trinity_driver *drv);
 int trinity_wait_ready(struct trinity_driver *drv);
+phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr);
 
 /* File operations */
 int trinity_open(struct inode *inode, struct file *f);
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index f1c1e06d188e..9e616466c57b 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -105,6 +105,7 @@ struct triv2_cmd_info {
 
 	struct triv2_req *reqs[TRIV2_MAX_CMDSLOTS];
 	struct triv2_cmd cur_cmd;
+	struct trinity_resv_mem buf;
 };
 
 struct triv2_hashed_cmd_info {
@@ -124,6 +125,8 @@ struct triv2_kernel_req {
 struct triv2_req {
 	struct trinity_req req;
 
+	struct trinity_hwmem_import *seg_import;
+
 	int cmd_slot;
 
 	/** kernel requets */
@@ -140,6 +143,9 @@ struct triv2_req {
 struct triv2_idu {
 	phys_addr_t *addrs;
 	size_t addr_num;
+	struct trinity_resv_mem data;
+	struct trinity_resv_mem code;
+	dma_addr_t dspm;
 };
 
 struct triv2_pdata {
@@ -153,6 +159,9 @@ struct triv2_pdata {
 
 	/* command info */
 	struct triv2_cmd_info cmd_info;
+
+	/* back buffer for context switching */
+	struct trinity_resv_mem back_buf;
 };
 
 static void triv2_setup_buffers(struct trinity_driver *drv);
@@ -161,6 +170,74 @@ static int triv2_idu_load(struct trinity_driver *drv, const char *dirpath,
 
 static LIST_HEAD(triv2_driver_list);
 
+/**
+ * triv2_get_state() - Get state (TRINITY_STATE_READY/TRINITY_STATE_PAUSE) of the device.
+ * @returns (enum triv2_state) TRINITY_STATE_READY (i.e., 1) or TRINITY_STATE_PAUSE (i.e., 0 )
+ * according to the state of the device
+ */
+int32_t triv2_get_state(const struct trinity_driver *drv)
+{
+	if (ioread32(drv->mmreg_vaddr[0] + OFFSET_NPU_CMD_READY) == 1)
+		return TRINITY_STATE_READY;
+
+	return TRINITY_STATE_PAUSE;
+}
+
+/**
+ * triv2_set_state() - Set state of the device to TRINITY_STATE_READY (1) or TRINITY_STATE_PAUSE (0)
+ */
+static void triv2_set_state(const struct trinity_driver *drv,
+			    enum trinity_state state)
+{
+	void __iomem *addr;
+
+	switch (state) {
+	case TRINITY_STATE_PAUSE:
+		/* CP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					      OFFSET_CP_PROC_SET);
+		trinity_set_bit(BIT_SET_PAUSE, addr);
+		iowrite32(0, addr);
+
+		/* DSP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[1],
+					      OFFSET_DSP_PROC_SET);
+		trinity_set_bit(BIT_SET_PAUSE, addr);
+		iowrite32(0, addr);
+
+		break;
+	case TRINITY_STATE_READY:
+		/* CP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					      OFFSET_CP_PROC_CLR);
+		trinity_set_bit(BIT_CLR_PAUSE, addr);
+		iowrite32(0, addr);
+
+		/* DSP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[1],
+					      OFFSET_DSP_PROC_CLR);
+		trinity_set_bit(BIT_CLR_PAUSE, addr);
+		iowrite32(0, addr);
+
+		/* Performance Counter */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					      OFFSET_CP_CNT_CFG);
+		trinity_set_bit(BIT_CNT_IST_EN | BIT_CNT_FR_EN, addr);
+		break;
+	default:
+		dev_err(drv_to_dev_ptr(drv),
+			"failed to set state of the NPU state: %d", state);
+	}
+}
+
+static void triv2_wakeup_cp(const struct trinity_driver *drv)
+{
+	void *addr =
+		trinity_get_iomem_addr(drv->mmreg_vaddr[0], OFFSET_CP_PROC_SET);
+
+	trinity_set_bit(BIT_SET_SEND_EVT1, addr);
+}
+
 static void triv2_cancel_reqs(struct trinity_driver *drv)
 {
 	struct triv2_cmd_info *info;
@@ -204,6 +281,8 @@ static void triv2_reset(struct trinity_driver *drv)
 	do_test = true;
 	list_for_each_entry(pdata, &triv2_driver_list, list) {
 		triv2_reset_devices(pdata->drv, do_test);
+		if (pdata->drv->opened > 0)
+			triv2_set_state(pdata->drv, TRINITY_STATE_READY);
 		do_test = false;
 	}
 
@@ -233,6 +312,20 @@ static const struct file_operations triv2_fops = {
 	.llseek = noop_llseek,
 };
 
+static void triv2_setup_cp(struct trinity_driver *drv, phys_addr_t paddr)
+{
+	iowrite32(TRIV2_IDU_ADDR(paddr) >> 4,
+		  drv->mmreg_vaddr[0] + OFFSET_CP_IMIF_BASE);
+	iowrite32(TRIV2_IDU_ADDR(drv->mmreg_paddr[2]),
+		  drv->mmreg_vaddr[0] + OFFSET_NPU_CBOX_BASE);
+}
+
+static void triv2_setup_dsp(struct trinity_driver *drv, phys_addr_t paddr)
+{
+	iowrite32(TRIV2_IDU_ADDR(paddr) >> 4,
+		  drv->mmreg_vaddr[1] + OFFSET_DSP_IMIF_BASE);
+}
+
 static void triv2_init_common(void)
 {
 	static bool done;
@@ -244,6 +337,20 @@ static void triv2_init_common(void)
 	done = true;
 }
 
+static int triv2_idu_alloc(struct device *dev, struct trinity_resv_mem *mem)
+{
+	return trinity_alloc_from_resv_mem(mem->size, mem, false);
+}
+
+static void triv2_idu_free(struct device *dev, struct trinity_resv_mem *mem)
+{
+	if (!mem->vaddr)
+		return;
+
+	trinity_free_from_resv_mem(mem, false);
+	mem->vaddr = NULL;
+}
+
 static int triv2_idu_version(struct trinity_driver *drv, uint32_t *major,
 			     uint32_t *minor, uint32_t *extra)
 {
@@ -272,36 +379,276 @@ static void triv2_idu_check(struct trinity_driver *drv)
 	struct device *dev = drv_to_dev_ptr(drv);
 	uint32_t major, minor, extra;
 
+	if (trinity_wait_ready(drv) != 0) {
+		dev_warn(dev, "Unable to load IDU properly");
+		return;
+	}
+
 	pdata->idu_version =
 		ioread32(drv->mmreg_vaddr[0] + OFFSET_NPU_IDU_VERSION);
 	if (triv2_idu_version(drv, &major, &minor, &extra) == 0)
 		dev_info(dev,
 			 "Instruction Decoder Unit (IDU) v%u.%u.%u detected",
 			 major, minor, extra);
+
+	/* paused until device is opened */
+	triv2_set_state(drv, TRINITY_STATE_PAUSE);
+}
+
+static int triv2_idu_load_file(struct trinity_driver *drv, const char *dirpath,
+			       const char *file_name,
+			       struct trinity_resv_mem *sector)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct trinity_resv_mem mem;
+	char filepath[NAME_MAX];
+	struct kstat *stat;
+	struct file *filp;
+	loff_t pos = 0;
+	size_t size;
+	int ret;
+
+	dev = drv_to_dev_ptr(drv);
+	stat = vmalloc(sizeof(*stat));
+	if (stat == NULL)
+		return -ENOMEM;
+
+	/* if dirpath is null, use the default path */
+	if (dirpath)
+		snprintf(filepath, NAME_MAX, "%s/%s", dirpath, file_name);
+	else
+		snprintf(filepath, NAME_MAX, TRIV2_IDU_DIRPATH_FMT "/%s",
+			 utsname()->release, file_name);
+
+	filp = filp_open(filepath, O_RDONLY, 0400);
+	if (IS_ERR(filp)) {
+		dev_err(dev, "Failed to open the idu binary: %s", filepath);
+		ret = PTR_ERR(filp);
+		goto out_free;
+	}
+
+	/* check file existence first */
+	ret = vfs_getattr(&filp->f_path, stat, STATX_SIZE,
+			  AT_STATX_SYNC_AS_STAT);
+
+	if (ret != 0 || stat->size == 0) {
+		dev_warn(dev, "File not found: %s", filepath);
+		ret = -ENOENT;
+		goto out_close;
+	}
+
+	size = stat->size;
+	if (size > TRIV2_IDU_MAXSIZE) {
+		dev_err(dev, "Too large idu binary: %zu MiB", size >> 20);
+		ret = -EINVAL;
+		goto out_close;
+	}
+
+	mem.size = PAGE_ALIGN(size);
+	ret = triv2_idu_alloc(dev, &mem);
+	if (ret < 0) {
+		dev_err(dev, "Failed to allocate memory for idu");
+		goto out_close;
+	}
+
+	ret = read_idu_file(filp, pos, mem.vaddr, size);
+	if (ret != size) {
+		dev_err(dev, "Failed to read the file %s", filepath);
+		triv2_idu_free(dev, &mem);
+		ret = -ERANGE;
+		goto out_close;
+	}
+
+	/* free previous idu if exists */
+	if (sector->vaddr)
+		triv2_idu_free(dev, sector);
+
+	sector->daddr = mem.daddr;
+	sector->vaddr = mem.vaddr;
+	sector->size = mem.size;
+	sector->orig_size = size;
+
+	ret = 0;
+out_close:
+	filp_close(filp, NULL);
+out_free:
+	vfree(stat);
+
+	return ret;
+}
+
+static int triv2_idu_load_files(struct trinity_driver *drv, const char *dirpath)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct iommu_domain *domain;
+	phys_addr_t paddr;
+	int ret;
+
+	domain = iommu_get_domain_for_dev(drv_to_dev_ptr(drv));
+
+	ret = triv2_idu_load_file(drv, dirpath, "cp/data.bin",
+				  &(pdata->idu_cp.data));
+	if (ret < 0)
+		return ret;
+
+	ret = triv2_idu_load_file(drv, dirpath, "cp/code.bin",
+				  &(pdata->idu_cp.code));
+	if (ret < 0)
+		return ret;
+
+	paddr = trinity_get_paddr(domain, pdata->idu_cp.code.daddr);
+	pdata->idu_cp.addrs[TRIV2_IDU_CODEIDX] = paddr;
+
+	if (!pdata->idu_dsp.addrs)
+		return 0;
+
+	ret = triv2_idu_load_file(drv, dirpath, "dsp/data.bin",
+				  &(pdata->idu_dsp.data));
+	if (ret < 0)
+		return ret;
+
+	ret = triv2_idu_load_file(drv, dirpath, "dsp/code.bin",
+				  &(pdata->idu_dsp.code));
+	if (ret < 0)
+		return ret;
+
+	paddr = trinity_get_paddr(domain, pdata->idu_dsp.code.daddr);
+	pdata->idu_dsp.addrs[TRIV2_IDU_CODEIDX] = paddr;
+
+	return 0;
+}
+
+static void triv2_idu_fill_zero(struct trinity_driver *drv, phys_addr_t paddr,
+				size_t size)
+{
+	void *__iomem vaddr;
+
+	vaddr = ioremap(paddr, PAGE_ALIGN(size));
+	if (vaddr == NULL) {
+		dev_err(drv_to_dev_ptr(drv), "Failed to do ioremap() for 0x%lx",
+			(unsigned long)paddr);
+		return;
+	}
+	memset_io(vaddr, 0, size);
+
+	iounmap(vaddr);
+}
+
+static void triv2_idu_fill_data(struct trinity_driver *drv, phys_addr_t paddr,
+				struct trinity_resv_mem *data)
+{
+	void *__iomem vaddr;
+
+	vaddr = ioremap(paddr, data->size);
+	if (vaddr == NULL) {
+		dev_err(drv_to_dev_ptr(drv), "Failed to do ioremap() for 0x%lx",
+			(unsigned long)paddr);
+		return;
+	}
+	memcpy_toio(vaddr, data->vaddr, data->orig_size);
+
+	iounmap(vaddr);
+}
+
+static void triv2_idu_load_code(struct trinity_driver *drv)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+
+	/* CP is mandatory */
+	triv2_setup_cp(drv, pdata->idu_cp.addrs[TRIV2_IDU_CODEIDX]);
+
+	/* DSP is optional */
+	if (pdata->idu_dsp.addrs)
+		triv2_setup_dsp(drv, pdata->idu_dsp.addrs[TRIV2_IDU_CODEIDX]);
 }
 
 static int triv2_idu_load(struct trinity_driver *drv, const char *dirpath,
 			  bool load_files)
 {
-	/* load idu data */
+	struct triv2_pdata *pdata;
+	struct triv2_idu *idu_cp;
+	struct triv2_idu *idu_dsp;
+	struct device *dev;
+
+	if (!drv)
+		return -EINVAL;
+
+	dev = drv_to_dev_ptr(drv);
+	if (load_files) {
+		int ret = triv2_idu_load_files(drv, dirpath);
+
+		if (ret != 0) {
+			dev_warn(dev, "Unable to load IDU files: %d", ret);
+			goto load_code;
+		}
+	}
+
+	pdata = TRIV2_DRV_GET_PDATA(drv);
+	idu_cp = &pdata->idu_cp;
+	idu_dsp = &pdata->idu_dsp;
+
+	triv2_idu_fill_zero(drv, idu_cp->addrs[TRIV2_IDU_ZEROIDX],
+			    TRIV2_IDU_CP_DSPM_SIZE);
+	triv2_idu_fill_data(drv, idu_cp->addrs[TRIV2_IDU_DATAIDX],
+			    &idu_cp->data);
+
+	if (!pdata->idu_dsp.addrs)
+		goto load_code;
+
+	triv2_idu_fill_zero(drv, idu_dsp->addrs[TRIV2_IDU_ZEROIDX],
+			    drv->dspm + TRIV2_DSP_DSPM_OFFSET);
+	triv2_idu_fill_data(drv, idu_dsp->addrs[TRIV2_IDU_DATAIDX],
+			    &idu_dsp->data);
+
+load_code:
+	triv2_idu_load_code(drv);
 
 	return 0;
 }
 
 static void triv2_idu_unload(struct trinity_driver *drv)
 {
-	/* unload idu data */
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+
+	triv2_idu_free(dev, &pdata->idu_cp.data);
+	triv2_idu_free(dev, &pdata->idu_dsp.data);
+
+	triv2_idu_free(dev, &pdata->idu_cp.code);
+	triv2_idu_free(dev, &pdata->idu_dsp.code);
 }
 
 static void triv2_setup_buffers(struct trinity_driver *drv)
 {
-	/* setup buffer */
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct iommu_domain *domain;
+	struct trinity_resv_mem *cmd_buf;
+	struct trinity_resv_mem *back_buf;
+	phys_addr_t paddr;
+
+	domain = iommu_get_domain_for_dev(dev);
+	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
+	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
+
+	/* command */
+	paddr = trinity_get_paddr(domain, cmd_buf->daddr);
+	iowrite32(TRIV2_IDU_ADDR(paddr),
+		  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					 OFFSET_NPU_CMD_BASE));
+	/* backup */
+	iowrite32(TRIV2_IDU_ADDR(back_buf->daddr),
+		  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					 OFFSET_NPU_BACK_ADDR));
+	iowrite32(back_buf->size, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+							 OFFSET_NPU_BACK_SIZE));
 }
 
 static int32_t triv2_init_pdata(struct trinity_driver *drv)
 {
 	struct triv2_pdata *pdata;
 	struct triv2_cmd_info *cmd_info;
+	struct trinity_resv_mem *cmd_buf;
+	struct trinity_resv_mem *back_buf;
 
 	/* alloc triv2 pdata */
 	drv->pdata = kzalloc(sizeof(struct triv2_pdata), GFP_KERNEL);
@@ -312,6 +659,8 @@ static int32_t triv2_init_pdata(struct trinity_driver *drv)
 	pdata->drv = drv;
 
 	cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
+	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
 
 	spin_lock_init(&cmd_info->lock);
 	/* init cmd bitmap */
@@ -393,7 +742,21 @@ static int triv2_setup_idu(struct trinity_driver *drv)
 		triv2_idu_check(drv);
 	}
 
-	/* setup dma info */
+	if (pdata->idu_dsp.addrs && drv->dspm > 0) {
+		struct iommu_domain *domain;
+		phys_addr_t paddr;
+		dma_addr_t daddr;
+
+		/* iommu mapping for dspm segment */
+		domain = iommu_get_domain_for_dev(dev);
+		if (!domain)
+			return 0;
+
+		paddr = pdata->idu_dsp.addrs[0] + TRIV2_DSP_DSPM_OFFSET;
+		daddr = dma_map_resource(dev, paddr, drv->dspm,
+					 DMA_BIDIRECTIONAL, 0);
+		pdata->idu_dsp.dspm = daddr;
+	}
 
 	return 0;
 }
@@ -412,11 +775,23 @@ static int32_t triv2_init(struct trinity_driver *drv)
  */
 static void triv2_cleanup(struct trinity_driver *drv)
 {
+	struct trinity_resv_mem *cmd_buf;
+	struct trinity_resv_mem *back_buf;
+
 	if (!drv->pdata)
 		return;
 
 	triv2_idu_unload(drv);
 
+	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
+	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
+
+	if (cmd_buf->vaddr)
+		trinity_free_from_resv_mem(cmd_buf, false);
+
+	if (back_buf->vaddr)
+		trinity_free_from_resv_mem(back_buf, false);
+
 	list_del(&(TRIV2_DRV_GET_PDATA(drv)->list));
 	kfree(drv->pdata);
 	drv->pdata = NULL;
@@ -430,6 +805,8 @@ static struct trinity_desc triv2_desc = {
 	.reset = triv2_reset,
 	.idu_load = triv2_idu_load,
 	.idu_version = triv2_idu_version,
+	.get_state = triv2_get_state,
+	.set_state = triv2_set_state,
 	/* req management */
 	.alloc_req = triv2_alloc_req,
 	.dealloc_req = triv2_dealloc_req,
@@ -456,6 +833,18 @@ static int trinity_triv2_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	drv = (struct trinity_driver *)platform_get_drvdata(pdev);
+	if (drv->dspm > 0) {
+		/* DSPM's some region is reserved for DSP kernel operations */
+		if (drv->dspm < TRIV2_DSP_DSPM_OFFSET) {
+			dev_err(drv_to_dev_ptr(drv),
+				"Too small DSPM size.. wrong device tree?");
+			err = -EINVAL;
+			goto out_remove;
+		}
+		drv->dspm -= TRIV2_DSP_DSPM_OFFSET;
+	}
+
 	err = triv2_init(drv);
 	if (err < 0)
 		goto out_remove;
-- 
2.25.1

