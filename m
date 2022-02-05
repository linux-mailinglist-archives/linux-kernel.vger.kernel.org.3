Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2F4AA5D2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379038AbiBECe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:34:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45076 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378991AbiBECeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:23 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 62F3420B6C63;
        Fri,  4 Feb 2022 18:34:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 62F3420B6C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028463;
        bh=IpToOsqqxItEXz6optBBDvTXH5uaCmT+csRrvNEfkko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuXCVfRjs5G0mm9qG2jnnIL0pgjaISOUxTetNFsIrUNvFsnNv9zV0bUIo8uRXqW4p
         eff+TUWvcMAH1v3HJfYE+np2V9J/66FqYbC16bLjVA9jzGFj4rW1Tn+NLT9hJ/HKds
         8NmrdkAOIpicEHmIzf5j+INgHYQsPrYDNzbHt88I=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and creation of dxgadapter
Date:   Fri,  4 Feb 2022 18:33:59 -0800
Message-Id: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first commit for adding support for a Hyper-V based
vGPU implementation that exposes the DirectX API to Linux userspace.

- Handle driver loading, registration for the PCI and VM bus device
  notifications
- Add headers for user mode interfaces, internal driver objects and VM bus
  communication interface
- Handle initialization of VM bus channels and creation of the dxgadapter
  object
- Connect the dxgkrnl module to the drivers/hv/ makefile and Kconfig.
- Create a MAINTAINERS entry

A PCI device is created for each virtual GPU (vGPU) device, projected by
the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device id is
PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles arrival of such
devices and it creates dxgadapter objects. The PCI config space of the
vGPU device has luid of the corresponding per GPU VM bus channel. This is
how the adapters are linked to VM bus channels.

A dxgadapter object represents a virtual GPU, projected to the VM by the
host. This object can start functioning only when the global VM bus
channel and the corresponding per vGPU VM bus channel are initialized in
the guest. Notifications about arrival of vGPU PCI device and VM bus
channels can happen in any order. Therefore, the initial dxgadapter object
state is DXGADAPTER_STATE_WAITING_VMBUS. A list of VM bus channels and a
list of dxgadapter objects are created. When dxgkrnl is notified about a
VM bus channel arrival, if tries to start all adapters, which are not
started yet.

VM bus interface version is exchanged by reading/writing the PCI config
space of the vGPU device.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 MAINTAINERS                     |    7 +
 drivers/hv/Kconfig              |    2 +
 drivers/hv/Makefile             |    1 +
 drivers/hv/dxgkrnl/Kconfig      |   26 +
 drivers/hv/dxgkrnl/Makefile     |    5 +
 drivers/hv/dxgkrnl/dxgadapter.c |  172 +++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  223 ++++
 drivers/hv/dxgkrnl/dxgmodule.c  |  736 ++++++++++++
 drivers/hv/dxgkrnl/dxgprocess.c |   17 +
 drivers/hv/dxgkrnl/dxgvmbus.c   |  578 +++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  855 ++++++++++++++
 drivers/hv/dxgkrnl/hmgr.c       |   23 +
 drivers/hv/dxgkrnl/hmgr.h       |   75 ++
 drivers/hv/dxgkrnl/ioctl.c      |   24 +
 drivers/hv/dxgkrnl/misc.c       |   37 +
 drivers/hv/dxgkrnl/misc.h       |   89 ++
 include/linux/hyperv.h          |   16 +
 include/uapi/misc/d3dkmthk.h    | 1945 +++++++++++++++++++++++++++++++
 18 files changed, 4831 insertions(+)
 create mode 100644 drivers/hv/dxgkrnl/Kconfig
 create mode 100644 drivers/hv/dxgkrnl/Makefile
 create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
 create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
 create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
 create mode 100644 drivers/hv/dxgkrnl/dxgprocess.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
 create mode 100644 drivers/hv/dxgkrnl/hmgr.c
 create mode 100644 drivers/hv/dxgkrnl/hmgr.h
 create mode 100644 drivers/hv/dxgkrnl/ioctl.c
 create mode 100644 drivers/hv/dxgkrnl/misc.c
 create mode 100644 drivers/hv/dxgkrnl/misc.h
 create mode 100644 include/uapi/misc/d3dkmthk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a2bd991db512..5856e09d834c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8841,6 +8841,13 @@ F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
+Hyper-V vGPU DRIVER
+M:	Iouri Tarassov <iourit@microsoft.com>
+L:	linux-hyperv@vger.kernel.org
+S:	Supported
+F:	drivers/hv/dxgkrnl/
+F:	include/uapi/misc/d3dkmthk.h
+
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index dd12af20e467..7006f7b66200 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -29,4 +29,6 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+source "drivers/hv/dxgkrnl/Kconfig"
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index d76df5c8c2a9..aa1cbdb5d0d2 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_DXGKRNL)		+= dxgkrnl/
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
diff --git a/drivers/hv/dxgkrnl/Kconfig b/drivers/hv/dxgkrnl/Kconfig
new file mode 100644
index 000000000000..22d0914d8f1e
--- /dev/null
+++ b/drivers/hv/dxgkrnl/Kconfig
@@ -0,0 +1,26 @@
+#
+# dxgkrnl configuration
+#
+
+config DXGKRNL
+	tristate "Microsoft Paravirtualized GPU support"
+	depends on HYPERV
+	depends on 64BIT || COMPILE_TEST
+	help
+	  This driver supports paravirtualized virtual compute devices, exposed
+	  by Microsoft Hyper-V when Linux is running inside of a virtual machine
+	  hosted by Windows. The virtual machines needs to be configured to use
+	  host compute adapters. The driver name is dxgkrnl.
+
+	  An example of such virtual machine is a  Windows Subsystem for
+	  Linux container. When such container is instantiated, the Windows host
+	  assigns compatible host GPU adapters to the container. The corresponding
+	  virtual GPU devices appear on the PCI bus in the container. These
+	  devices are enumerated and accessed by this driver.
+
+	  Communications with the driver are done by using the Microsoft libdxcore
+	  library, which translates the D3DKMT interface
+	  <https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/>
+	  to the driver IOCTLs. The virtual GPU devices are paravirtualized,
+	  which means that access to the hardware is done in the host. The driver
+	  communicates with the host using Hyper-V VM bus communication channels.
diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
new file mode 100644
index 000000000000..745c66bebe5d
--- /dev/null
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for the Linux video drivers.
+
+obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
+dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
new file mode 100644
index 000000000000..e0a6fea00bd5
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Implementation of dxgadapter and its objects
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/hyperv.h>
+#include <linux/pagemap.h>
+#include <linux/eventfd.h>
+
+#include "dxgkrnl.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev)
+{
+	int ret;
+
+	guid_to_luid(&hdev->channel->offermsg.offer.if_instance,
+		     &adapter->luid);
+	pr_debug("%s: %x:%x %p %pUb\n",
+		    __func__, adapter->luid.b, adapter->luid.a, hdev->channel,
+		    &hdev->channel->offermsg.offer.if_instance);
+
+	ret = dxgvmbuschannel_init(&adapter->channel, hdev);
+	if (ret)
+		goto cleanup;
+
+	adapter->channel.adapter = adapter;
+	adapter->hv_dev = hdev;
+
+	ret = dxgvmb_send_open_adapter(adapter);
+	if (ret < 0) {
+		pr_err("dxgvmb_send_open_adapter failed: %d\n", ret);
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_get_internal_adapter_info(adapter);
+	if (ret < 0)
+		pr_err("get_internal_adapter_info failed: %d", ret);
+
+cleanup:
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+void dxgadapter_start(struct dxgadapter *adapter)
+{
+	struct dxgvgpuchannel *ch = NULL;
+	struct dxgvgpuchannel *entry;
+	int ret;
+
+	pr_debug("%s %x-%x",
+		__func__, adapter->luid.a, adapter->luid.b);
+
+	/* Find the corresponding vGPU vm bus channel */
+	list_for_each_entry(entry, &dxgglobal->vgpu_ch_list_head,
+			    vgpu_ch_list_entry) {
+		if (memcmp(&adapter->luid,
+			   &entry->adapter_luid,
+			   sizeof(struct winluid)) == 0) {
+			ch = entry;
+			break;
+		}
+	}
+	if (ch == NULL) {
+		pr_debug("%s vGPU chanel is not ready", __func__);
+		return;
+	}
+
+	/* The global channel is initialized when the first adapter starts */
+	if (!dxgglobal->global_channel_initialized) {
+		ret = dxgglobal_init_global_channel();
+		if (ret) {
+			dxgglobal_destroy_global_channel();
+			return;
+		}
+		dxgglobal->global_channel_initialized = true;
+	}
+
+	/* Initialize vGPU vm bus channel */
+	ret = dxgadapter_set_vmbus(adapter, ch->hdev);
+	if (ret) {
+		pr_err("Failed to start adapter %p", adapter);
+		adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+		return;
+	}
+
+	adapter->adapter_state = DXGADAPTER_STATE_ACTIVE;
+	pr_debug("%s Adapter started %p", __func__, adapter);
+}
+
+void dxgadapter_stop(struct dxgadapter *adapter)
+{
+	bool adapter_stopped = false;
+
+	down_write(&adapter->core_lock);
+	if (!adapter->stopping_adapter)
+		adapter->stopping_adapter = true;
+	else
+		adapter_stopped = true;
+	up_write(&adapter->core_lock);
+
+	if (adapter_stopped)
+		return;
+
+	if (dxgadapter_acquire_lock_exclusive(adapter) == 0) {
+		dxgvmb_send_close_adapter(adapter);
+		dxgadapter_release_lock_exclusive(adapter);
+	}
+	dxgvmbuschannel_destroy(&adapter->channel);
+
+	adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+}
+
+void dxgadapter_release(struct kref *refcount)
+{
+	struct dxgadapter *adapter;
+
+	adapter = container_of(refcount, struct dxgadapter, adapter_kref);
+	pr_debug("%s %p\n", __func__, adapter);
+	vfree(adapter);
+}
+
+bool dxgadapter_is_active(struct dxgadapter *adapter)
+{
+	return adapter->adapter_state == DXGADAPTER_STATE_ACTIVE;
+}
+
+int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
+{
+	down_write(&adapter->core_lock);
+	if (adapter->adapter_state != DXGADAPTER_STATE_ACTIVE) {
+		dxgadapter_release_lock_exclusive(adapter);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter)
+{
+	down_write(&adapter->core_lock);
+}
+
+void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter)
+{
+	up_write(&adapter->core_lock);
+}
+
+int dxgadapter_acquire_lock_shared(struct dxgadapter *adapter)
+{
+	down_read(&adapter->core_lock);
+	if (adapter->adapter_state == DXGADAPTER_STATE_ACTIVE)
+		return 0;
+	dxgadapter_release_lock_shared(adapter);
+	return -ENODEV;
+}
+
+void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
+{
+	up_read(&adapter->core_lock);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
new file mode 100644
index 000000000000..15208328cb71
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Headers for internal objects
+ *
+ */
+
+#ifndef _DXGKRNL_H
+#define _DXGKRNL_H
+
+#include <linux/uuid.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/refcount.h>
+#include <linux/rwsem.h>
+#include <linux/atomic.h>
+#include <linux/spinlock.h>
+#include <linux/gfp.h>
+#include <linux/miscdevice.h>
+#include <linux/pci.h>
+#include <linux/hyperv.h>
+
+struct dxgadapter;
+
+#include "misc.h"
+#include "hmgr.h"
+#include <uapi/misc/d3dkmthk.h>
+
+struct dxgk_device_types {
+	u32 post_device:1;
+	u32 post_device_certain:1;
+	u32 software_device:1;
+	u32 soft_gpu_device:1;
+	u32 warp_device:1;
+	u32 bdd_device:1;
+	u32 support_miracast:1;
+	u32 mismatched_lda:1;
+	u32 indirect_display_device:1;
+	u32 xbox_one_device:1;
+	u32 child_id_support_dwm_clone:1;
+	u32 child_id_support_dwm_clone2:1;
+	u32 has_internal_panel:1;
+	u32 rfx_vgpu_device:1;
+	u32 virtual_render_device:1;
+	u32 support_preserve_boot_display:1;
+	u32 is_uefi_frame_buffer:1;
+	u32 removable_device:1;
+	u32 virtual_monitor_device:1;
+};
+
+enum dxgobjectstate {
+	DXGOBJECTSTATE_CREATED,
+	DXGOBJECTSTATE_ACTIVE,
+	DXGOBJECTSTATE_STOPPED,
+	DXGOBJECTSTATE_DESTROYED,
+};
+
+struct dxgvmbuschannel {
+	struct vmbus_channel	*channel;
+	struct hv_device	*hdev;
+	struct dxgadapter	*adapter;
+	spinlock_t		packet_list_mutex;
+	struct list_head	packet_list_head;
+	struct kmem_cache	*packet_cache;
+	atomic64_t		packet_request_id;
+};
+
+int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev);
+void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch);
+void dxgvmbuschannel_receive(void *ctx);
+
+/*
+ * The structure defines an offered vGPU vm bus channel.
+ */
+struct dxgvgpuchannel {
+	struct list_head	vgpu_ch_list_entry;
+	struct winluid		adapter_luid;
+	struct hv_device	*hdev;
+};
+
+struct dxgglobal {
+	struct dxgvmbuschannel	channel;
+	struct delayed_work	dwork;
+	struct hv_device	*hdev;
+	u32			num_adapters;
+	u32			vmbus_ver;	/* Interface version */
+	struct resource		*mem;
+	u64			mmiospace_base;
+	u64			mmiospace_size;
+	struct miscdevice	dxgdevice;
+	struct mutex		device_mutex;
+
+	/*  list of created  processes */
+	struct list_head	plisthead;
+	struct mutex		plistmutex;
+
+	/* list of created adapters */
+	struct list_head	adapter_list_head;
+	struct rw_semaphore	adapter_list_lock;
+
+	/* List of all current threads for lock order tracking. */
+	struct mutex		thread_info_mutex;
+	struct list_head	thread_info_list_head;
+
+	/*
+	 * List of the vGPU VM bus channels (dxgvgpuchannel)
+	 * Protected by device_mutex
+	 */
+	struct list_head	vgpu_ch_list_head;
+
+	/* protects acces to the global VM bus channel */
+	struct rw_semaphore	channel_lock;
+
+	bool			dxg_dev_initialized;
+	bool			vmbus_registered;
+	bool			pci_registered;
+	bool			global_channel_initialized;
+	bool			async_msg_enabled;
+};
+
+extern struct dxgglobal		*dxgglobal;
+
+int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
+			     struct winluid host_vgpu_luid);
+void dxgglobal_acquire_adapter_list_lock(enum dxglockstate state);
+void dxgglobal_release_adapter_list_lock(enum dxglockstate state);
+int dxgglobal_init_global_channel(void);
+void dxgglobal_destroy_global_channel(void);
+struct vmbus_channel *dxgglobal_get_vmbus(void);
+struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void);
+int dxgglobal_acquire_channel_lock(void);
+void dxgglobal_release_channel_lock(void);
+
+struct dxgprocess {
+	/* Placeholder */
+};
+
+enum dxgadapter_state {
+	DXGADAPTER_STATE_ACTIVE		= 0,
+	DXGADAPTER_STATE_STOPPED	= 1,
+	DXGADAPTER_STATE_WAITING_VMBUS	= 2,
+};
+
+/*
+ * This object represents the grapchis adapter.
+ * Objects, which take reference on the adapter:
+ * - dxgglobal
+ * - adapter handle (struct d3dkmthandle)
+ */
+struct dxgadapter {
+	struct rw_semaphore	core_lock;
+	struct kref		adapter_kref;
+	/* Entry in the list of adapters in dxgglobal */
+	struct list_head	adapter_list_entry;
+	struct pci_dev		*pci_dev;
+	struct hv_device	*hv_dev;
+	struct dxgvmbuschannel	channel;
+	struct d3dkmthandle	host_handle;
+	enum dxgadapter_state	adapter_state;
+	struct winluid		host_adapter_luid;
+	struct winluid		host_vgpu_luid;
+	struct winluid		luid;	/* VM bus channel luid */
+	u16			device_description[80];
+	u16			device_instance_id[WIN_MAX_PATH];
+	bool			stopping_adapter;
+};
+
+int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev);
+bool dxgadapter_is_active(struct dxgadapter *adapter);
+void dxgadapter_start(struct dxgadapter *adapter);
+void dxgadapter_stop(struct dxgadapter *adapter);
+void dxgadapter_release(struct kref *refcount);
+int dxgadapter_acquire_lock_shared(struct dxgadapter *adapter);
+void dxgadapter_release_lock_shared(struct dxgadapter *adapter);
+int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter);
+void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter);
+void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter);
+
+void init_ioctls(void);
+long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
+long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
+
+static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
+{
+	*luid = *(struct winluid *)&guid->b[0];
+}
+
+/*
+ * VM bus interface
+ *
+ */
+
+/*
+ * The interface version is used to ensure that the host and the guest use the
+ * same VM bus protocol. It needs to be incremented every time the VM bus
+ * interface changes. DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION is
+ * incremented each time the earlier versions of the interface are no longer
+ * compatible with the current version.
+ */
+#define DXGK_VMBUS_INTERFACE_VERSION_OLD		27
+#define DXGK_VMBUS_INTERFACE_VERSION			40
+#define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
+
+void dxgvmb_initialize(void);
+int dxgvmb_send_set_iospace_region(u64 start, u64 len,
+				   struct vmbus_gpadl *shared_mem_gpadl);
+int dxgvmb_send_open_adapter(struct dxgadapter *adapter);
+int dxgvmb_send_close_adapter(struct dxgadapter *adapter);
+int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter);
+int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
+			  void *command,
+			  u32 cmd_size);
+
+int ntstatus2int(struct ntstatus status);
+
+#endif
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
new file mode 100644
index 000000000000..a9a00dae2088
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -0,0 +1,736 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Interface with Linux kernel, PCI driver and the VM bus driver
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/eventfd.h>
+#include <linux/hyperv.h>
+#include <linux/pci.h>
+
+#include "dxgkrnl.h"
+
+/*
+ * Pointer to the global device data. By design
+ * there is a single vGPU device on the VM bus and a single /dev/dxg device
+ * is created.
+ */
+struct dxgglobal *dxgglobal;
+
+#define DXGKRNL_VERSION			0x2111
+#define PCI_VENDOR_ID_MICROSOFT		0x1414
+#define PCI_DEVICE_ID_VIRTUAL_RENDER	0x008E
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+//
+// Interface from dxgglobal
+//
+
+struct vmbus_channel *dxgglobal_get_vmbus(void)
+{
+	return dxgglobal->channel.channel;
+}
+
+struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void)
+{
+	return &dxgglobal->channel;
+}
+
+int dxgglobal_acquire_channel_lock(void)
+{
+	down_read(&dxgglobal->channel_lock);
+	if (dxgglobal->channel.channel == NULL) {
+		pr_err("Failed to acquire global channel lock");
+		return -ENODEV;
+	} else {
+		return 0;
+	}
+}
+
+void dxgglobal_release_channel_lock(void)
+{
+	up_read(&dxgglobal->channel_lock);
+}
+
+void dxgglobal_acquire_adapter_list_lock(enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		down_write(&dxgglobal->adapter_list_lock);
+	else
+		down_read(&dxgglobal->adapter_list_lock);
+}
+
+void dxgglobal_release_adapter_list_lock(enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		up_write(&dxgglobal->adapter_list_lock);
+	else
+		up_read(&dxgglobal->adapter_list_lock);
+}
+
+/*
+ * Returns a pointer to dxgadapter object, which corresponds to the given PCI
+ * device, or NULL.
+ */
+static struct dxgadapter *find_pci_adapter(struct pci_dev *dev)
+{
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dev == entry->pci_dev) {
+			adapter = entry;
+			break;
+		}
+	}
+
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+	return adapter;
+}
+
+/*
+ * Returns a pointer to dxgadapter object, which has the givel LUID
+ * device, or NULL.
+ */
+static struct dxgadapter *find_adapter(struct winluid *luid)
+{
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (memcmp(luid, &entry->luid, sizeof(struct winluid)) == 0) {
+			adapter = entry;
+			break;
+		}
+	}
+
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+	return adapter;
+}
+
+/*
+ * Creates a new dxgadapter object, which represents a virtual GPU, projected
+ * by the host.
+ * The adapter is in the waiting state. It will become active when the global
+ * VM bus channel and the adapter VM bus channel are created.
+ */
+int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
+			     struct winluid host_vgpu_luid)
+{
+	struct dxgadapter *adapter;
+	int ret = 0;
+
+	adapter = vzalloc(sizeof(struct dxgadapter));
+	if (adapter == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	adapter->adapter_state = DXGADAPTER_STATE_WAITING_VMBUS;
+	adapter->host_vgpu_luid = host_vgpu_luid;
+	kref_init(&adapter->adapter_kref);
+	init_rwsem(&adapter->core_lock);
+
+	adapter->pci_dev = dev;
+	guid_to_luid(guid, &adapter->luid);
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_add_tail(&adapter->adapter_list_entry,
+		      &dxgglobal->adapter_list_head);
+	dxgglobal->num_adapters++;
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+
+	pr_debug("new adapter added %p %x-%x\n", adapter,
+		    adapter->luid.a, adapter->luid.b);
+cleanup:
+	pr_debug("%s end: %d", __func__, ret);
+	return ret;
+}
+
+/*
+ * Attempts to start dxgadapter objects, which are not active yet.
+ */
+static void dxgglobal_start_adapters(void)
+{
+	struct dxgadapter *adapter;
+
+	if (dxgglobal->hdev == NULL) {
+		pr_debug("Global channel is not ready");
+		return;
+	}
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+	list_for_each_entry(adapter, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (adapter->adapter_state == DXGADAPTER_STATE_WAITING_VMBUS)
+			dxgadapter_start(adapter);
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+}
+
+/*
+ * Stopsthe active dxgadapter objects.
+ */
+static void dxgglobal_stop_adapters(void)
+{
+	struct dxgadapter *adapter;
+
+	if (dxgglobal->hdev == NULL) {
+		pr_debug("Global channel is not ready");
+		return;
+	}
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+	list_for_each_entry(adapter, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (adapter->adapter_state == DXGADAPTER_STATE_ACTIVE)
+			dxgadapter_stop(adapter);
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+}
+
+/*
+ * File operations for the /dev/dxg device
+ */
+
+static int dxgk_open(struct inode *n, struct file *f)
+{
+	return 0;
+}
+
+static int dxgk_release(struct inode *n, struct file *f)
+{
+	return 0;
+}
+
+static ssize_t dxgk_read(struct file *f, char __user *s, size_t len,
+			 loff_t *o)
+{
+	pr_debug("file read\n");
+	return 0;
+}
+
+static ssize_t dxgk_write(struct file *f, const char __user *s, size_t len,
+			  loff_t *o)
+{
+	pr_debug("file write\n");
+	return len;
+}
+
+const struct file_operations dxgk_fops = {
+	.owner = THIS_MODULE,
+	.open = dxgk_open,
+	.release = dxgk_release,
+	.write = dxgk_write,
+	.read = dxgk_read,
+};
+
+/*
+ * Interface with the PCI driver
+ */
+
+/*
+ * Part of the PCI config space of the vGPU device is used for vGPU
+ * configuration data. Reading/writing of the PCI config space is forwarded
+ * to the host.
+ */
+
+/* vGPU VM bus channel instance ID */
+#define DXGK_VMBUS_CHANNEL_ID_OFFSET 192
+/* DXGK_VMBUS_INTERFACE_VERSION (u32) */
+#define DXGK_VMBUS_VERSION_OFFSET	(DXGK_VMBUS_CHANNEL_ID_OFFSET + \
+					sizeof(guid_t))
+/* Luid of the virtual GPU on the host (struct winluid) */
+#define DXGK_VMBUS_VGPU_LUID_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
+					sizeof(u32))
+/* The guest writes its capavilities to this adderss */
+#define DXGK_VMBUS_GUESTCAPS_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
+					sizeof(u32))
+
+/* Capabilities of the guest driver, reported to the host */
+struct dxgk_vmbus_guestcaps {
+	union {
+		struct {
+			u32	wsl2		: 1;
+			u32	reserved	: 31;
+		};
+		u32 guest_caps;
+	};
+};
+
+/*
+ * A helper function to read PCI config space.
+ */
+static int dxg_pci_read_dwords(struct pci_dev *dev, int offset, int size,
+			       void *val)
+{
+	int off = offset;
+	int ret;
+	int i;
+
+	for (i = 0; i < size / sizeof(int); i++) {
+		ret = pci_read_config_dword(dev, off, &((int *)val)[i]);
+		if (ret) {
+			pr_err("Failed to read PCI config: %d", off);
+			return ret;
+		}
+		off += sizeof(int);
+	}
+	return 0;
+}
+
+static int dxg_pci_probe_device(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	int ret;
+	guid_t guid;
+	u32 vmbus_interface_ver = DXGK_VMBUS_INTERFACE_VERSION;
+	struct winluid vgpu_luid = {};
+	struct dxgk_vmbus_guestcaps guest_caps = {.wsl2 = 1};
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (dxgglobal->vmbus_ver == 0)  {
+		/* Report capabilities to the host */
+
+		ret = pci_write_config_dword(dev, DXGK_VMBUS_GUESTCAPS_OFFSET,
+					guest_caps.guest_caps);
+		if (ret)
+			goto cleanup;
+
+		/* Negotiate the VM bus version */
+
+		ret = pci_read_config_dword(dev, DXGK_VMBUS_VERSION_OFFSET,
+					&vmbus_interface_ver);
+		if (ret == 0 && vmbus_interface_ver != 0)
+			dxgglobal->vmbus_ver = vmbus_interface_ver;
+		else
+			dxgglobal->vmbus_ver = DXGK_VMBUS_INTERFACE_VERSION_OLD;
+
+		if (dxgglobal->vmbus_ver < DXGK_VMBUS_INTERFACE_VERSION)
+			goto read_channel_id;
+
+		ret = pci_write_config_dword(dev, DXGK_VMBUS_VERSION_OFFSET,
+					DXGK_VMBUS_INTERFACE_VERSION);
+		if (ret)
+			goto cleanup;
+
+		if (dxgglobal->vmbus_ver > DXGK_VMBUS_INTERFACE_VERSION)
+			dxgglobal->vmbus_ver = DXGK_VMBUS_INTERFACE_VERSION;
+	}
+
+read_channel_id:
+
+	/* Get the VM bus channel ID for the virtual GPU */
+	ret = dxg_pci_read_dwords(dev, DXGK_VMBUS_CHANNEL_ID_OFFSET,
+				sizeof(guid), (int *)&guid);
+	if (ret)
+		goto cleanup;
+
+	if (dxgglobal->vmbus_ver >= DXGK_VMBUS_INTERFACE_VERSION) {
+		ret = dxg_pci_read_dwords(dev, DXGK_VMBUS_VGPU_LUID_OFFSET,
+					  sizeof(vgpu_luid), &vgpu_luid);
+		if (ret)
+			goto cleanup;
+	}
+
+	/* Create new virtual GPU adapter */
+
+	pr_debug("Adapter channel: %pUb\n", &guid);
+	pr_debug("Vmbus interface version: %d\n",
+		dxgglobal->vmbus_ver);
+	pr_debug("Host vGPU luid: %x-%x\n",
+		vgpu_luid.b, vgpu_luid.a);
+
+	ret = dxgglobal_create_adapter(dev, &guid, vgpu_luid);
+	if (ret)
+		goto cleanup;
+
+	/* Attempt to start the adapter in case VM bus channels are created */
+
+	dxgglobal_start_adapters();
+
+cleanup:
+
+	mutex_unlock(&dxgglobal->device_mutex);
+
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static void dxg_pci_remove_device(struct pci_dev *dev)
+{
+	struct dxgadapter *adapter;
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	adapter = find_pci_adapter(dev);
+	if (adapter) {
+		dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+		list_del(&adapter->adapter_list_entry);
+		dxgglobal->num_adapters--;
+		dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+
+		dxgadapter_stop(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	} else {
+		pr_err("Failed to find dxgadapter");
+	}
+
+	mutex_unlock(&dxgglobal->device_mutex);
+}
+
+static struct pci_device_id dxg_pci_id_table = {
+	.vendor = PCI_VENDOR_ID_MICROSOFT,
+	.device = PCI_DEVICE_ID_VIRTUAL_RENDER,
+	.subvendor = PCI_ANY_ID,
+	.subdevice = PCI_ANY_ID
+};
+
+static struct pci_driver dxg_pci_drv = {
+	.name = KBUILD_MODNAME,
+	.id_table = &dxg_pci_id_table,
+	.probe = dxg_pci_probe_device,
+	.remove = dxg_pci_remove_device
+};
+
+/*
+ * Interface with the VM bus driver
+ */
+
+static int dxgglobal_getiospace(struct dxgglobal *dxgglobal)
+{
+	/* Get mmio space for the global channel */
+	struct hv_device *hdev = dxgglobal->hdev;
+	struct vmbus_channel *channel = hdev->channel;
+	resource_size_t pot_start = 0;
+	resource_size_t pot_end = -1;
+	int ret;
+
+	dxgglobal->mmiospace_size = channel->offermsg.offer.mmio_megabytes;
+	if (dxgglobal->mmiospace_size == 0) {
+		pr_debug("zero mmio space is offered\n");
+		return -ENOMEM;
+	}
+	dxgglobal->mmiospace_size <<= 20;
+	pr_debug("mmio offered: %llx\n",
+		dxgglobal->mmiospace_size);
+
+	ret = vmbus_allocate_mmio(&dxgglobal->mem, hdev, pot_start, pot_end,
+				  dxgglobal->mmiospace_size, 0x10000, false);
+	if (ret) {
+		pr_err("Unable to allocate mmio memory: %d\n", ret);
+		return ret;
+	}
+	dxgglobal->mmiospace_size = dxgglobal->mem->end -
+	    dxgglobal->mem->start + 1;
+	dxgglobal->mmiospace_base = dxgglobal->mem->start;
+	pr_info("mmio allocated %llx  %llx %llx %llx\n",
+		dxgglobal->mmiospace_base,
+		dxgglobal->mmiospace_size,
+		dxgglobal->mem->start, dxgglobal->mem->end);
+
+	return 0;
+}
+
+int dxgglobal_init_global_channel(void)
+{
+	int ret = 0;
+
+	ret = dxgvmbuschannel_init(&dxgglobal->channel, dxgglobal->hdev);
+	if (ret) {
+		pr_err("dxgvmbuschannel_init failed: %d\n", ret);
+		goto error;
+	}
+
+	ret = dxgglobal_getiospace(dxgglobal);
+	if (ret) {
+		pr_err("getiospace failed: %d\n", ret);
+		goto error;
+	}
+
+	ret = dxgvmb_send_set_iospace_region(dxgglobal->mmiospace_base,
+					     dxgglobal->mmiospace_size, 0);
+	if (ret < 0) {
+		pr_err("send_set_iospace_region failed");
+		goto error;
+	}
+
+	hv_set_drvdata(dxgglobal->hdev, dxgglobal);
+
+	dxgglobal->dxgdevice.minor = MISC_DYNAMIC_MINOR;
+	dxgglobal->dxgdevice.name = "dxg";
+	dxgglobal->dxgdevice.fops = &dxgk_fops;
+	dxgglobal->dxgdevice.mode = 0666;
+	ret = misc_register(&dxgglobal->dxgdevice);
+	if (ret) {
+		pr_err("misc_register failed: %d", ret);
+		goto error;
+	}
+	dxgglobal->dxg_dev_initialized = true;
+
+error:
+	return ret;
+}
+
+void dxgglobal_destroy_global_channel(void)
+{
+	down_write(&dxgglobal->channel_lock);
+
+	dxgglobal->global_channel_initialized = false;
+
+	if (dxgglobal->dxg_dev_initialized) {
+		misc_deregister(&dxgglobal->dxgdevice);
+		dxgglobal->dxg_dev_initialized = false;
+	}
+
+	if (dxgglobal->mem) {
+		vmbus_free_mmio(dxgglobal->mmiospace_base,
+				dxgglobal->mmiospace_size);
+		dxgglobal->mem = NULL;
+	}
+
+	dxgvmbuschannel_destroy(&dxgglobal->channel);
+
+	if (dxgglobal->hdev) {
+		hv_set_drvdata(dxgglobal->hdev, NULL);
+		dxgglobal->hdev = NULL;
+	}
+
+	up_write(&dxgglobal->channel_lock);
+}
+
+static void dxgglobal_stop_adapter_vmbus(struct hv_device *hdev)
+{
+	struct dxgadapter *adapter = NULL;
+	struct winluid luid;
+
+	guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
+
+	pr_debug("%s: %x:%x\n", __func__, luid.b, luid.a);
+
+	adapter = find_adapter(&luid);
+
+	if (adapter && adapter->adapter_state == DXGADAPTER_STATE_ACTIVE) {
+		down_write(&adapter->core_lock);
+		dxgvmbuschannel_destroy(&adapter->channel);
+		adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+		up_write(&adapter->core_lock);
+	}
+}
+
+static const struct hv_vmbus_device_id id_table[] = {
+	/* Per GPU Device GUID */
+	{ HV_GPUP_DXGK_VGPU_GUID },
+	/* Global Dxgkgnl channel for the virtual machine */
+	{ HV_GPUP_DXGK_GLOBAL_GUID },
+	{ }
+};
+
+static int dxg_probe_vmbus(struct hv_device *hdev,
+			   const struct hv_vmbus_device_id *dev_id)
+{
+	int ret = 0;
+	struct winluid luid;
+	struct dxgvgpuchannel *vgpuch;
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (uuid_le_cmp(hdev->dev_type, id_table[0].guid) == 0) {
+		/* This is a new virtual GPU channel */
+		guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
+		pr_debug("vGPU channel: %pUb",
+			    &hdev->channel->offermsg.offer.if_instance);
+		vgpuch = vzalloc(sizeof(struct dxgvgpuchannel));
+		if (vgpuch == NULL) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		vgpuch->adapter_luid = luid;
+		vgpuch->hdev = hdev;
+		list_add_tail(&vgpuch->vgpu_ch_list_entry,
+			      &dxgglobal->vgpu_ch_list_head);
+		dxgglobal_start_adapters();
+	} else if (uuid_le_cmp(hdev->dev_type, id_table[1].guid) == 0) {
+		/* This is the global Dxgkgnl channel */
+		pr_debug("Global channel: %pUb",
+			    &hdev->channel->offermsg.offer.if_instance);
+		if (dxgglobal->hdev) {
+			/* This device should appear only once */
+			pr_err("global channel already present\n");
+			ret = -EBADE;
+			goto error;
+		}
+		dxgglobal->hdev = hdev;
+		dxgglobal_start_adapters();
+	} else {
+		/* Unknown device type */
+		pr_err("probe: unknown device type\n");
+		ret = -EBADE;
+		goto error;
+	}
+
+error:
+
+	mutex_unlock(&dxgglobal->device_mutex);
+
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static int dxg_remove_vmbus(struct hv_device *hdev)
+{
+	int ret = 0;
+	struct dxgvgpuchannel *vgpu_channel;
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (uuid_le_cmp(hdev->dev_type, id_table[0].guid) == 0) {
+		pr_debug("Remove virtual GPU channel\n");
+		dxgglobal_stop_adapter_vmbus(hdev);
+		list_for_each_entry(vgpu_channel,
+				    &dxgglobal->vgpu_ch_list_head,
+				    vgpu_ch_list_entry) {
+			if (vgpu_channel->hdev == hdev) {
+				list_del(&vgpu_channel->vgpu_ch_list_entry);
+				vfree(vgpu_channel);
+				break;
+			}
+		}
+	} else if (uuid_le_cmp(hdev->dev_type, id_table[1].guid) == 0) {
+		pr_debug("Remove global channel device\n");
+		dxgglobal_destroy_global_channel();
+	} else {
+		/* Unknown device type */
+		pr_err("remove: unknown device type\n");
+		ret = -EBADE;
+	}
+
+	mutex_unlock(&dxgglobal->device_mutex);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+MODULE_DEVICE_TABLE(vmbus, id_table);
+
+static struct hv_driver dxg_drv = {
+	.name = KBUILD_MODNAME,
+	.id_table = id_table,
+	.probe = dxg_probe_vmbus,
+	.remove = dxg_remove_vmbus,
+	.driver = {
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		    },
+};
+
+/*
+ * Interface with Linux kernel
+ */
+
+static int dxgglobal_create(void)
+{
+	int ret = 0;
+
+	dxgglobal = vzalloc(sizeof(struct dxgglobal));
+	if (!dxgglobal)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&dxgglobal->plisthead);
+	mutex_init(&dxgglobal->plistmutex);
+	mutex_init(&dxgglobal->device_mutex);
+
+	INIT_LIST_HEAD(&dxgglobal->thread_info_list_head);
+	mutex_init(&dxgglobal->thread_info_mutex);
+
+	INIT_LIST_HEAD(&dxgglobal->vgpu_ch_list_head);
+	INIT_LIST_HEAD(&dxgglobal->adapter_list_head);
+	init_rwsem(&dxgglobal->adapter_list_lock);
+
+	init_rwsem(&dxgglobal->channel_lock);
+
+	pr_debug("dxgglobal_init end\n");
+	return ret;
+}
+
+static void dxgglobal_destroy(void)
+{
+	if (dxgglobal) {
+		dxgglobal_stop_adapters();
+
+		if (dxgglobal->vmbus_registered)
+			vmbus_driver_unregister(&dxg_drv);
+
+		dxgglobal_destroy_global_channel();
+
+		if (dxgglobal->pci_registered)
+			pci_unregister_driver(&dxg_pci_drv);
+
+		vfree(dxgglobal);
+		dxgglobal = NULL;
+	}
+}
+
+/*
+ * Driver entry points
+ */
+
+static int __init dxg_drv_init(void)
+{
+	int ret;
+
+
+	ret = dxgglobal_create();
+	if (ret) {
+		pr_err("dxgglobal_init failed");
+		return -ENOMEM;
+	}
+
+	ret = vmbus_driver_register(&dxg_drv);
+	if (ret) {
+		pr_err("vmbus_driver_register failed: %d", ret);
+		return ret;
+	}
+	dxgglobal->vmbus_registered = true;
+
+	pr_info("%s  Version: %x", __func__, DXGKRNL_VERSION);
+
+	ret = pci_register_driver(&dxg_pci_drv);
+	if (ret) {
+		pr_err("pci_driver_register failed: %d", ret);
+		return ret;
+	}
+	dxgglobal->pci_registered = true;
+
+	init_ioctls();
+
+	return 0;
+}
+
+static void __exit dxg_drv_exit(void)
+{
+	dxgglobal_destroy();
+}
+
+module_init(dxg_drv_init);
+module_exit(dxg_drv_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual GPU Driver");
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
new file mode 100644
index 000000000000..81e5b4a137e7
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * DXGPROCESS implementation
+ *
+ */
+
+#include "dxgkrnl.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
new file mode 100644
index 000000000000..84693c98a4af
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * VM bus interface implementation
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/eventfd.h>
+#include <linux/hyperv.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+#include <linux/pagemap.h>
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+#define RING_BUFSIZE (256 * 1024)
+
+/*
+ * The structure is used to track VM bus packets, waiting for completion.
+ */
+struct dxgvmbuspacket {
+	struct list_head packet_list_entry;
+	u64 request_id;
+	struct completion wait;
+	void *buffer;
+	u32 buffer_length;
+	int status;
+};
+
+struct dxgvmb_ext_header {
+	/* Offset from the start of the message to DXGKVMB_COMMAND_BASE */
+	u32		command_offset;
+	u32		reserved;
+	struct winluid	vgpu_luid;
+};
+
+#define VMBUSMESSAGEONSTACK	64
+
+struct dxgvmbusmsg {
+/* Points to the allocated buffer */
+	struct dxgvmb_ext_header	*hdr;
+/* Points to dxgkvmb_command_vm_to_host or dxgkvmb_command_vgpu_to_host */
+	void				*msg;
+/* The vm bus channel, used to pass the message to the host */
+	struct dxgvmbuschannel		*channel;
+/* Message size in bytes including the header and the payload */
+	u32				size;
+/* Buffer used for small messages */
+	char				msg_on_stack[VMBUSMESSAGEONSTACK];
+};
+
+struct dxgvmbusmsgres {
+/* Points to the allocated buffer */
+	struct dxgvmb_ext_header	*hdr;
+/* Points to dxgkvmb_command_vm_to_host or dxgkvmb_command_vgpu_to_host */
+	void				*msg;
+/* The vm bus channel, used to pass the message to the host */
+	struct dxgvmbuschannel		*channel;
+/* Message size in bytes including the header, the payload and the result */
+	u32				size;
+/* Result buffer size in bytes */
+	u32				res_size;
+/* Points to the result within the allocated buffer */
+	void				*res;
+};
+
+static int init_message(struct dxgvmbusmsg *msg, struct dxgadapter *adapter,
+			struct dxgprocess *process, u32 size)
+{
+	bool use_ext_header = dxgglobal->vmbus_ver >=
+			      DXGK_VMBUS_INTERFACE_VERSION;
+
+	if (use_ext_header)
+		size += sizeof(struct dxgvmb_ext_header);
+	msg->size = size;
+	if (size <= VMBUSMESSAGEONSTACK) {
+		msg->hdr = (void *)msg->msg_on_stack;
+		memset(msg->hdr, 0, size);
+	} else {
+		msg->hdr = vzalloc(size);
+		if (msg->hdr == NULL)
+			return -ENOMEM;
+	}
+	if (use_ext_header) {
+		msg->msg = (char *)&msg->hdr[1];
+		msg->hdr->command_offset = sizeof(msg->hdr[0]);
+		if (adapter)
+			msg->hdr->vgpu_luid = adapter->host_vgpu_luid;
+	} else {
+		msg->msg = (char *)msg->hdr;
+	}
+	if (adapter && !dxgglobal->async_msg_enabled)
+		msg->channel = &adapter->channel;
+	else
+		msg->channel = &dxgglobal->channel;
+	return 0;
+}
+
+static void free_message(struct dxgvmbusmsg *msg, struct dxgprocess *process)
+{
+	if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
+		vfree(msg->hdr);
+}
+
+/*
+ * Helper functions
+ */
+
+static void command_vm_to_host_init2(struct dxgkvmb_command_vm_to_host *command,
+				     enum dxgkvmb_commandtype_global t,
+				     struct d3dkmthandle process)
+{
+	command->command_type	= t;
+	command->process	= process;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VM_TO_HOST;
+}
+
+static void command_vgpu_to_host_init1(struct dxgkvmb_command_vgpu_to_host
+					*command,
+					enum dxgkvmb_commandtype type)
+{
+	command->command_type	= type;
+	command->process.v	= 0;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VGPU_TO_HOST;
+}
+
+static void command_vgpu_to_host_init2(struct dxgkvmb_command_vgpu_to_host
+					*command,
+					enum dxgkvmb_commandtype type,
+					struct d3dkmthandle process)
+{
+	command->command_type	= type;
+	command->process	= process;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VGPU_TO_HOST;
+}
+
+int ntstatus2int(struct ntstatus status)
+{
+	if (NT_SUCCESS(status))
+		return (int)status.v;
+	switch (status.v) {
+	case STATUS_OBJECT_NAME_COLLISION:
+		return -EEXIST;
+	case STATUS_NO_MEMORY:
+		return -ENOMEM;
+	case STATUS_INVALID_PARAMETER:
+		return -EINVAL;
+	case STATUS_OBJECT_NAME_INVALID:
+	case STATUS_OBJECT_NAME_NOT_FOUND:
+		return -ENOENT;
+	case STATUS_TIMEOUT:
+		return -EAGAIN;
+	case STATUS_BUFFER_TOO_SMALL:
+		return -EOVERFLOW;
+	case STATUS_DEVICE_REMOVED:
+		return -ENODEV;
+	case STATUS_ACCESS_DENIED:
+		return -EACCES;
+	case STATUS_NOT_SUPPORTED:
+		return -EPERM;
+	case STATUS_ILLEGAL_INSTRUCTION:
+		return -EOPNOTSUPP;
+	case STATUS_INVALID_HANDLE:
+		return -EBADF;
+	case STATUS_GRAPHICS_ALLOCATION_BUSY:
+		return -EINPROGRESS;
+	case STATUS_OBJECT_TYPE_MISMATCH:
+		return -EPROTOTYPE;
+	case STATUS_NOT_IMPLEMENTED:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+}
+
+int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev)
+{
+	int ret;
+
+	ch->hdev = hdev;
+	spin_lock_init(&ch->packet_list_mutex);
+	INIT_LIST_HEAD(&ch->packet_list_head);
+	atomic64_set(&ch->packet_request_id, 0);
+
+	ch->packet_cache = kmem_cache_create("DXGK packet cache",
+					     sizeof(struct dxgvmbuspacket), 0,
+					     0, NULL);
+	if (ch->packet_cache == NULL) {
+		pr_err("packet_cache alloc failed");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	hdev->channel->max_pkt_size = DXG_MAX_VM_BUS_PACKET_SIZE;
+	ret = vmbus_open(hdev->channel, RING_BUFSIZE, RING_BUFSIZE,
+			 NULL, 0, dxgvmbuschannel_receive, ch);
+	if (ret) {
+		pr_err("vmbus_open failed: %d", ret);
+		goto cleanup;
+	}
+
+	ch->channel = hdev->channel;
+
+cleanup:
+
+	return ret;
+}
+
+void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch)
+{
+	kmem_cache_destroy(ch->packet_cache);
+	ch->packet_cache = NULL;
+
+	if (ch->channel) {
+		vmbus_close(ch->channel);
+		ch->channel = NULL;
+	}
+}
+
+static void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host *command,
+				     enum dxgkvmb_commandtype_global type)
+{
+	command->command_type = type;
+	command->process.v = 0;
+	command->command_id = 0;
+	command->channel_type = DXGKVMB_VM_TO_HOST;
+}
+
+static void process_inband_packet(struct dxgvmbuschannel *channel,
+				  struct vmpacket_descriptor *desc)
+{
+	u32 packet_length = hv_pkt_datalen(desc);
+	struct dxgkvmb_command_host_to_vm *packet;
+
+	if (channel->adapter == NULL) {
+		if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
+			pr_err("Invalid global packet");
+		} else {
+			packet = hv_pkt_data(desc);
+			pr_debug("global packet %d",
+				    packet->command_type);
+			switch (packet->command_type) {
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
+				break;
+			case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
+				break;
+			default:
+				pr_err("unexpected host message %d",
+					   packet->command_type);
+			}
+		}
+	} else {
+		pr_err("Unexpected packet for adapter channel");
+	}
+}
+
+static void process_completion_packet(struct dxgvmbuschannel *channel,
+				      struct vmpacket_descriptor *desc)
+{
+	struct dxgvmbuspacket *packet = NULL;
+	struct dxgvmbuspacket *entry;
+	u32 packet_length = hv_pkt_datalen(desc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->packet_list_mutex, flags);
+	list_for_each_entry(entry, &channel->packet_list_head,
+			    packet_list_entry) {
+		if (desc->trans_id == entry->request_id) {
+			packet = entry;
+			list_del(&packet->packet_list_entry);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&channel->packet_list_mutex, flags);
+	if (packet) {
+		if (packet->buffer_length) {
+			if (packet_length < packet->buffer_length) {
+				pr_debug("invalid size %d Expected:%d",
+					    packet_length,
+					    packet->buffer_length);
+				packet->status = -EOVERFLOW;
+			} else {
+				memcpy(packet->buffer, hv_pkt_data(desc),
+				       packet->buffer_length);
+			}
+		}
+		complete(&packet->wait);
+	} else {
+		pr_err("did not find packet to complete");
+	}
+}
+
+/* Receive callback for messages from the host */
+void dxgvmbuschannel_receive(void *ctx)
+{
+	struct dxgvmbuschannel *channel = ctx;
+	struct vmpacket_descriptor *desc;
+	u32 packet_length = 0;
+
+	pr_debug("%s %p", __func__, channel->adapter);
+	foreach_vmbus_pkt(desc, channel->channel) {
+		packet_length = hv_pkt_datalen(desc);
+		pr_debug("next packet (id, size, type): %llu %d %d",
+			desc->trans_id, packet_length, desc->type);
+		if (desc->type == VM_PKT_COMP) {
+			process_completion_packet(channel, desc);
+		} else {
+			if (desc->type != VM_PKT_DATA_INBAND)
+				pr_err("unexpected packet type");
+			else
+				process_inband_packet(channel, desc);
+		}
+	}
+}
+
+int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
+			 void *command,
+			 u32 cmd_size,
+			 void *result,
+			 u32 result_size)
+{
+	int ret;
+	struct dxgvmbuspacket *packet = NULL;
+	struct dxgkvmb_command_vm_to_host *cmd1;
+	struct dxgkvmb_command_vgpu_to_host *cmd2;
+
+	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    result_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("%s invalid data size", __func__);
+		return -EINVAL;
+	}
+
+	packet = kmem_cache_alloc(channel->packet_cache, 0);
+	if (packet == NULL) {
+		pr_err("kmem_cache_alloc failed");
+		return -ENOMEM;
+	}
+
+	if (channel->adapter == NULL) {
+		cmd1 = command;
+		pr_debug("send_sync_msg global: %d %p %d %d",
+			cmd1->command_type, command, cmd_size, result_size);
+	} else {
+		cmd2 = command;
+		pr_debug("send_sync_msg adapter: %d %p %d %d",
+			cmd2->command_type, command, cmd_size, result_size);
+	}
+
+	packet->request_id = atomic64_inc_return(&channel->packet_request_id);
+	init_completion(&packet->wait);
+	packet->buffer = result;
+	packet->buffer_length = result_size;
+	packet->status = 0;
+	spin_lock_irq(&channel->packet_list_mutex);
+	list_add_tail(&packet->packet_list_entry, &channel->packet_list_head);
+	spin_unlock_irq(&channel->packet_list_mutex);
+
+	ret = vmbus_sendpacket(channel->channel, command, cmd_size,
+			       packet->request_id, VM_PKT_DATA_INBAND,
+			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (ret) {
+		pr_err("vmbus_sendpacket failed: %x", ret);
+		spin_lock_irq(&channel->packet_list_mutex);
+		list_del(&packet->packet_list_entry);
+		spin_unlock_irq(&channel->packet_list_mutex);
+		goto cleanup;
+	}
+
+	pr_debug("waiting completion: %llu", packet->request_id);
+	wait_for_completion(&packet->wait);
+	pr_debug("completion done: %llu %x",
+		packet->request_id, packet->status);
+	ret = packet->status;
+
+cleanup:
+
+	kmem_cache_free(channel->packet_cache, packet);
+	if (ret < 0)
+		pr_debug("%s failed: %x", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
+			  void *command,
+			  u32 cmd_size)
+{
+	int ret;
+	int try_count = 0;
+
+	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("%s invalid data size", __func__);
+		return -EINVAL;
+	}
+
+	if (channel->adapter) {
+		pr_err("Async messages should be sent to the global channel");
+		return -EINVAL;
+	}
+
+	do {
+		ret = vmbus_sendpacket(channel->channel, command, cmd_size,
+				0, VM_PKT_DATA_INBAND, 0);
+		/*
+		 * -EAGAIN is returned when the VM bus ring buffer if full.
+		 * Wait 2ms to allow the host to process messages and try again.
+		 */
+		if (ret == -EAGAIN) {
+			usleep_range(1000, 2000);
+			try_count++;
+		}
+	} while (ret == -EAGAIN && try_count < 5000);
+	if (ret < 0)
+		pr_err("vmbus_sendpacket failed: %x", ret);
+
+	return ret;
+}
+
+static int
+dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
+			      void *command, u32 cmd_size)
+{
+	struct ntstatus status;
+	int ret;
+
+	ret = dxgvmb_send_sync_msg(channel, command, cmd_size,
+				   &status, sizeof(status));
+	if (ret >= 0)
+		ret = ntstatus2int(status);
+	return ret;
+}
+
+/*
+ * Global messages to the host
+ */
+
+int dxgvmb_send_set_iospace_region(u64 start, u64 len,
+	struct vmbus_gpadl *shared_mem_gpadl)
+{
+	int ret;
+	struct dxgkvmb_command_setiospaceregion *command;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init1(&command->hdr,
+				 DXGK_VMBCOMMAND_SETIOSPACEREGION);
+	command->start = start;
+	command->length = len;
+	if (command->shared_page_gpadl)
+		command->shared_page_gpadl = shared_mem_gpadl->gpadl_handle;
+	ret = dxgvmb_send_sync_msg_ntstatus(&dxgglobal->channel, msg.hdr,
+					    msg.size);
+	if (ret < 0)
+		pr_err("send_set_iospace_region failed %x", ret);
+
+	dxgglobal_release_channel_lock();
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+/*
+ * Virtual GPU messages to the host
+ */
+
+int dxgvmb_send_open_adapter(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_openadapter *command;
+	struct dxgkvmb_command_openadapter_return result = { };
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_OPENADAPTER);
+	command->vmbus_interface_version = dxgglobal->vmbus_ver;
+	command->vmbus_last_compatible_interface_version =
+	    DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	adapter->host_handle = result.host_adapter_handle;
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_close_adapter(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_closeadapter *command;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_CLOSEADAPTER);
+	command->host_handle = adapter->host_handle;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   NULL, 0);
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_getinternaladapterinfo *command;
+	struct dxgkvmb_command_getinternaladapterinfo_return result = { };
+	struct dxgvmbusmsg msg;
+	u32 result_size = sizeof(result);
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr,
+				   DXGK_VMBCOMMAND_GETINTERNALADAPTERINFO);
+	if (dxgglobal->vmbus_ver < DXGK_VMBUS_INTERFACE_VERSION)
+		result_size -= sizeof(struct winluid);
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, result_size);
+	if (ret >= 0) {
+		adapter->host_adapter_luid = result.host_adapter_luid;
+		adapter->host_vgpu_luid = result.host_vgpu_luid;
+		wcsncpy(adapter->device_description, result.device_description,
+			sizeof(adapter->device_description) / sizeof(u16));
+		wcsncpy(adapter->device_instance_id, result.device_instance_id,
+			sizeof(adapter->device_instance_id) / sizeof(u16));
+		dxgglobal->async_msg_enabled = result.async_msg_enabled != 0;
+	}
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
new file mode 100644
index 000000000000..93cce587158b
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -0,0 +1,855 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * VM bus interface with the host definitions
+ *
+ */
+
+#ifndef _DXGVMBUS_H
+#define _DXGVMBUS_H
+
+struct dxgadapter;
+
+#define DXG_MAX_VM_BUS_PACKET_SIZE	(1024 * 128)
+#define DXG_MAX_OBJECT_COUNT		0xFFF
+
+#define DXGK_DECL_VMBUS_OUTPUTSIZE(Type)\
+	((sizeof(##Type) + 0x7) & ~(u32)0x7)
+#define DXGK_DECL_VMBUS_ALIGN_FOR_OUTPUT(Size) (((Size) + 0x7) & ~(u32)0x7)
+/*
+ * Defines a structure, which has the size, multiple of 8 bytes.
+ */
+#define DXGK_DECL_ALIGNED8_STRUCT(Type, Name, OutputSize)	\
+	const u32 _Size	= DXGK_DECL_VMBUS_OUTPUTSIZE(Type);	\
+	u8 _AlignedStruct[_Size];				\
+	##Type & Name	= (##Type &)_AlignedStruct;		\
+	u32 OutputSize	= _Size
+
+#define DXGK_BUFFER_VMBUS_ALIGNED(Buffer) (((Buffer) & 7)	== 0)
+
+enum dxgkvmb_commandchanneltype {
+	DXGKVMB_VGPU_TO_HOST,
+	DXGKVMB_VM_TO_HOST,
+	DXGKVMB_HOST_TO_VM
+};
+
+/*
+ *
+ * Commands, sent to the host via the guest global VM bus channel
+ * DXG_GUEST_GLOBAL_VMBUS
+ *
+ */
+
+#define DXG_VM_PROCESS_NAME_LENGTH 260
+
+enum dxgkvmb_commandtype_global {
+	DXGK_VMBCOMMAND_VM_TO_HOST_FIRST	= 1000,
+	DXGK_VMBCOMMAND_CREATEPROCESS	= DXGK_VMBCOMMAND_VM_TO_HOST_FIRST,
+	DXGK_VMBCOMMAND_DESTROYPROCESS		= 1001,
+	DXGK_VMBCOMMAND_OPENSYNCOBJECT		= 1002,
+	DXGK_VMBCOMMAND_DESTROYSYNCOBJECT	= 1003,
+	DXGK_VMBCOMMAND_CREATENTSHAREDOBJECT	= 1004,
+	DXGK_VMBCOMMAND_DESTROYNTSHAREDOBJECT	= 1005,
+	DXGK_VMBCOMMAND_SIGNALFENCE		= 1006,
+	DXGK_VMBCOMMAND_NOTIFYPROCESSFREEZE	= 1007,
+	DXGK_VMBCOMMAND_NOTIFYPROCESSTHAW	= 1008,
+	DXGK_VMBCOMMAND_QUERYETWSESSION		= 1009,
+	DXGK_VMBCOMMAND_SETIOSPACEREGION	= 1010,
+	DXGK_VMBCOMMAND_COMPLETETRANSACTION	= 1011,
+	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
+};
+
+/*
+ *
+ * Commands, sent to the host via the per adapter VM bus channel
+ * DXG_GUEST_VGPU_VMBUS
+ *
+ */
+
+enum dxgkvmb_commandtype {
+	DXGK_VMBCOMMAND_CREATEDEVICE		= 0,
+	DXGK_VMBCOMMAND_DESTROYDEVICE		= 1,
+	DXGK_VMBCOMMAND_QUERYADAPTERINFO	= 2,
+	DXGK_VMBCOMMAND_DDIQUERYADAPTERINFO	= 3,
+	DXGK_VMBCOMMAND_CREATEALLOCATION	= 4,
+	DXGK_VMBCOMMAND_DESTROYALLOCATION	= 5,
+	DXGK_VMBCOMMAND_CREATECONTEXTVIRTUAL	= 6,
+	DXGK_VMBCOMMAND_DESTROYCONTEXT		= 7,
+	DXGK_VMBCOMMAND_CREATESYNCOBJECT	= 8,
+	DXGK_VMBCOMMAND_CREATEPAGINGQUEUE	= 9,
+	DXGK_VMBCOMMAND_DESTROYPAGINGQUEUE	= 10,
+	DXGK_VMBCOMMAND_MAKERESIDENT		= 11,
+	DXGK_VMBCOMMAND_EVICT			= 12,
+	DXGK_VMBCOMMAND_ESCAPE			= 13,
+	DXGK_VMBCOMMAND_OPENADAPTER		= 14,
+	DXGK_VMBCOMMAND_CLOSEADAPTER		= 15,
+	DXGK_VMBCOMMAND_FREEGPUVIRTUALADDRESS	= 16,
+	DXGK_VMBCOMMAND_MAPGPUVIRTUALADDRESS	= 17,
+	DXGK_VMBCOMMAND_RESERVEGPUVIRTUALADDRESS = 18,
+	DXGK_VMBCOMMAND_UPDATEGPUVIRTUALADDRESS	= 19,
+	DXGK_VMBCOMMAND_SUBMITCOMMAND		= 20,
+	dxgk_vmbcommand_queryvideomemoryinfo	= 21,
+	DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMCPU = 22,
+	DXGK_VMBCOMMAND_LOCK2			= 23,
+	DXGK_VMBCOMMAND_UNLOCK2			= 24,
+	DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMGPU = 25,
+	DXGK_VMBCOMMAND_SIGNALSYNCOBJECT	= 26,
+	DXGK_VMBCOMMAND_SIGNALFENCENTSHAREDBYREF = 27,
+	DXGK_VMBCOMMAND_GETDEVICESTATE		= 28,
+	DXGK_VMBCOMMAND_MARKDEVICEASERROR	= 29,
+	DXGK_VMBCOMMAND_ADAPTERSTOP		= 30,
+	DXGK_VMBCOMMAND_SETQUEUEDLIMIT		= 31,
+	DXGK_VMBCOMMAND_OPENRESOURCE		= 32,
+	DXGK_VMBCOMMAND_SETCONTEXTSCHEDULINGPRIORITY = 33,
+	DXGK_VMBCOMMAND_PRESENTHISTORYTOKEN	= 34,
+	DXGK_VMBCOMMAND_SETREDIRECTEDFLIPFENCEVALUE = 35,
+	DXGK_VMBCOMMAND_GETINTERNALADAPTERINFO	= 36,
+	DXGK_VMBCOMMAND_FLUSHHEAPTRANSITIONS	= 37,
+	DXGK_VMBCOMMAND_BLT			= 38,
+	DXGK_VMBCOMMAND_DDIGETSTANDARDALLOCATIONDRIVERDATA = 39,
+	DXGK_VMBCOMMAND_CDDGDICOMMAND		= 40,
+	DXGK_VMBCOMMAND_QUERYALLOCATIONRESIDENCY = 41,
+	DXGK_VMBCOMMAND_FLUSHDEVICE		= 42,
+	DXGK_VMBCOMMAND_FLUSHADAPTER		= 43,
+	DXGK_VMBCOMMAND_DDIGETNODEMETADATA	= 44,
+	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE	= 45,
+	DXGK_VMBCOMMAND_ISSYNCOBJECTSIGNALED	= 46,
+	DXGK_VMBCOMMAND_CDDSYNCGPUACCESS	= 47,
+	DXGK_VMBCOMMAND_QUERYSTATISTICS		= 48,
+	DXGK_VMBCOMMAND_CHANGEVIDEOMEMORYRESERVATION = 49,
+	DXGK_VMBCOMMAND_CREATEHWQUEUE		= 50,
+	DXGK_VMBCOMMAND_DESTROYHWQUEUE		= 51,
+	DXGK_VMBCOMMAND_SUBMITCOMMANDTOHWQUEUE	= 52,
+	DXGK_VMBCOMMAND_GETDRIVERSTOREFILE	= 53,
+	DXGK_VMBCOMMAND_READDRIVERSTOREFILE	= 54,
+	DXGK_VMBCOMMAND_GETNEXTHARDLINK		= 55,
+	DXGK_VMBCOMMAND_UPDATEALLOCATIONPROPERTY = 56,
+	DXGK_VMBCOMMAND_OFFERALLOCATIONS	= 57,
+	DXGK_VMBCOMMAND_RECLAIMALLOCATIONS	= 58,
+	DXGK_VMBCOMMAND_SETALLOCATIONPRIORITY	= 59,
+	DXGK_VMBCOMMAND_GETALLOCATIONPRIORITY	= 60,
+	DXGK_VMBCOMMAND_GETCONTEXTSCHEDULINGPRIORITY = 61,
+	DXGK_VMBCOMMAND_QUERYCLOCKCALIBRATION	= 62,
+	DXGK_VMBCOMMAND_QUERYRESOURCEINFO	= 64,
+	DXGK_VMBCOMMAND_INVALID
+};
+
+enum dxgkvmb_commandtype_host_to_vm {
+	DXGK_VMBCOMMAND_SIGNALGUESTEVENT,
+	DXGK_VMBCOMMAND_PROPAGATEPRESENTHISTORYTOKEN,
+	DXGK_VMBCOMMAND_SETGUESTDATA,
+	DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE,
+	DXGK_VMBCOMMAND_SENDWNFNOTIFICATION,
+	DXGK_VMBCOMMAND_INVALID_HOST_TO_VM
+};
+
+struct dxgkvmb_command_vm_to_host {
+	u64				command_id;
+	struct d3dkmthandle		process;
+	enum dxgkvmb_commandchanneltype	channel_type;
+	enum dxgkvmb_commandtype_global	command_type;
+};
+
+struct dxgkvmb_command_vgpu_to_host {
+	u64				command_id;
+	struct d3dkmthandle		process;
+	u32				channel_type	: 8;
+	u32				async_msg	: 1;
+	u32				reserved	: 23;
+	enum dxgkvmb_commandtype	command_type;
+};
+
+struct dxgkvmb_command_host_to_vm {
+	u64					command_id;
+	struct d3dkmthandle			process;
+	u32					channel_type	: 8;
+	u32					async_msg	: 1;
+	u32					reserved	: 23;
+	enum dxgkvmb_commandtype_host_to_vm	command_type;
+};
+
+struct dxgkvmb_command_signalguestevent {
+	struct dxgkvmb_command_host_to_vm hdr;
+	u64				event;
+	u64				process_id;
+	bool				dereference_event;
+};
+
+enum set_guestdata_type {
+	SETGUESTDATA_DATATYPE_DWORD	= 0,
+	SETGUESTDATA_DATATYPE_UINT64	= 1
+};
+
+struct dxgkvmb_command_setguestdata {
+	struct dxgkvmb_command_host_to_vm hdr;
+	void *guest_pointer;
+	union {
+		u64	data64;
+		u32	data32;
+	};
+	u32	dereference	: 1;
+	u32	data_type	: 4;
+};
+
+struct dxgkvmb_command_opensyncobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		global_sync_object;
+	u32				engine_affinity;
+	struct d3dddi_synchronizationobject_flags flags;
+};
+
+struct dxgkvmb_command_opensyncobject_return {
+	struct d3dkmthandle		sync_object;
+	struct ntstatus			status;
+	u64				gpu_virtual_address;
+	u64				guest_cpu_physical_address;
+};
+
+/*
+ * The command returns struct d3dkmthandle of a shared object for the
+ * given pre-process object
+ */
+struct dxgkvmb_command_createntsharedobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle		object;
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroyntsharedobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle		shared_handle;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_setiospaceregion {
+	struct dxgkvmb_command_vm_to_host hdr;
+	u64				start;
+	u64				length;
+	u32				shared_page_gpadl;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_setexistingsysmemstore {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		allocation;
+	u32				gpadl;
+};
+
+struct dxgkvmb_command_createprocess {
+	struct dxgkvmb_command_vm_to_host hdr;
+	void			*process;
+	u64			process_id;
+	u16			process_name[DXG_VM_PROCESS_NAME_LENGTH + 1];
+	u8			csrss_process:1;
+	u8			dwm_process:1;
+	u8			wow64_process:1;
+	u8			linux_process:1;
+};
+
+struct dxgkvmb_command_createprocess_return {
+	struct d3dkmthandle	hprocess;
+};
+
+// The command returns ntstatus
+struct dxgkvmb_command_destroyprocess {
+	struct dxgkvmb_command_vm_to_host hdr;
+};
+
+struct dxgkvmb_command_openadapter {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u32				vmbus_interface_version;
+	u32				vmbus_last_compatible_interface_version;
+	struct winluid			guest_adapter_luid;
+};
+
+struct dxgkvmb_command_openadapter_return {
+	struct d3dkmthandle		host_adapter_handle;
+	struct ntstatus			status;
+	u32				vmbus_interface_version;
+	u32				vmbus_last_compatible_interface_version;
+};
+
+struct dxgkvmb_command_closeadapter {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		host_handle;
+};
+
+struct dxgkvmb_command_getinternaladapterinfo {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+};
+
+struct dxgkvmb_command_getinternaladapterinfo_return {
+	struct dxgk_device_types	device_types;
+	u32				driver_store_copy_mode;
+	u32				driver_ddi_version;
+	u32				secure_virtual_machine	: 1;
+	u32				virtual_machine_reset	: 1;
+	u32				is_vail_supported	: 1;
+	u32				hw_sch_enabled		: 1;
+	u32				hw_sch_capable		: 1;
+	u32				va_backed_vm		: 1;
+	u32				async_msg_enabled	: 1;
+	u32				hw_support_state	: 2;
+	u32				reserved		: 23;
+	struct winluid			host_adapter_luid;
+	u16				device_description[80];
+	u16				device_instance_id[WIN_MAX_PATH];
+	struct winluid			host_vgpu_luid;
+};
+
+struct dxgkvmb_command_queryadapterinfo {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	enum kmtqueryadapterinfotype	query_type;
+	u32				private_data_size;
+	u8				private_data[1];
+};
+
+struct dxgkvmb_command_queryadapterinfo_return {
+	struct ntstatus			status;
+	u8				private_data[1];
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_setallocationpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				allocation_count;
+	/* struct d3dkmthandle    allocations[allocation_count or 0]; */
+	/* u32 priorities[allocation_count or 1]; */
+};
+
+struct dxgkvmb_command_getallocationpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				allocation_count;
+	/* struct d3dkmthandle allocations[allocation_count or 0]; */
+};
+
+struct dxgkvmb_command_getallocationpriority_return {
+	struct ntstatus			status;
+	/* u32 priorities[allocation_count or 1]; */
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_setcontextschedulingpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	int				priority;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_setcontextschedulingpriority2 {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	int				priority;
+	bool				in_process;
+};
+
+struct dxgkvmb_command_getcontextschedulingpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	bool				in_process;
+};
+
+struct dxgkvmb_command_getcontextschedulingpriority_return {
+	struct ntstatus			status;
+	int				priority;
+};
+
+struct dxgkvmb_command_createdevice {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_createdeviceflags	flags;
+	bool				cdd_device;
+	void				*error_code;
+};
+
+struct dxgkvmb_command_createdevice_return {
+	struct d3dkmthandle		device;
+};
+
+struct dxgkvmb_command_destroydevice {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+};
+
+struct dxgkvmb_command_makeresident {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		paging_queue;
+	struct d3dddi_makeresident_flags flags;
+	u32				alloc_count;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_makeresident_return {
+	u64			paging_fence_value;
+	u64			num_bytes_to_trim;
+	struct ntstatus		status;
+};
+
+struct dxgkvmb_command_evict {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dddi_evict_flags	flags;
+	u32				alloc_count;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_evict_return {
+	u64			num_bytes_to_trim;
+};
+
+struct dxgkvmb_command_submitcommand {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_submitcommand	args;
+	/* HistoryBufferHandles */
+	/* PrivateDriverData    */
+};
+
+struct dxgkvmb_command_submitcommandtohwqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_submitcommandtohwqueue args;
+	/* Written primaries */
+	/* PrivateDriverData */
+};
+
+/* Returns  ntstatus */
+struct dxgkvmb_command_flushheaptransitions {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+};
+
+struct dxgkvmb_command_freegpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_freegpuvirtualaddress args;
+};
+
+struct dxgkvmb_command_mapgpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_mapgpuvirtualaddress args;
+	struct d3dkmthandle		device;
+};
+
+struct dxgkvmb_command_mapgpuvirtualaddress_return {
+	u64		virtual_address;
+	u64		paging_fence_value;
+	struct ntstatus	status;
+};
+
+struct dxgkvmb_command_reservegpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_reservegpuvirtualaddress args;
+};
+
+struct dxgkvmb_command_reservegpuvirtualaddress_return {
+	u64	virtual_address;
+	u64	paging_fence_value;
+};
+
+struct dxgkvmb_command_updategpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u64				fence_value;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		context;
+	struct d3dkmthandle		fence_object;
+	u32				num_operations;
+	u32				flags;
+	struct d3dddi_updategpuvirtualaddress_operation operations[1];
+};
+
+struct dxgkvmb_command_queryclockcalibration {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_queryclockcalibration args;
+};
+
+struct dxgkvmb_command_queryclockcalibration_return {
+	struct ntstatus			status;
+	struct dxgk_gpuclockdata	clock_data;
+};
+
+struct dxgkvmb_command_createallocation_allocinfo {
+	u32				flags;
+	u32				priv_drv_data_size;
+	u32				vidpn_source_id;
+};
+
+struct dxgkvmb_command_createallocation {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				private_runtime_data_size;
+	u32				priv_drv_data_size;
+	u32				alloc_count;
+	struct d3dkmt_createallocationflags flags;
+	u64				private_runtime_resource_handle;
+	bool				make_resident;
+/* dxgkvmb_command_createallocation_allocinfo alloc_info[alloc_count]; */
+/* u8 private_rutime_data[private_runtime_data_size] */
+/* u8 priv_drv_data[] for each alloc_info */
+};
+
+struct dxgkvmb_command_openresource {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	bool				nt_security_sharing;
+	struct d3dkmthandle		global_share;
+	u32				allocation_count;
+	u32				total_priv_drv_data_size;
+};
+
+struct dxgkvmb_command_openresource_return {
+	struct d3dkmthandle		resource;
+	struct ntstatus			status;
+/* struct d3dkmthandle   allocation[allocation_count]; */
+};
+
+struct dxgkvmb_command_querystatistics {
+	struct dxgkvmb_command_vgpu_to_host	hdr;
+	struct d3dkmt_querystatistics		args;
+};
+
+struct dxgkvmb_command_querystatistics_return {
+	struct ntstatus				status;
+	u32					reserved;
+	struct d3dkmt_querystatistics_result	result;
+};
+
+struct dxgkvmb_command_getstandardallocprivdata {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	enum d3dkmdt_standardallocationtype alloc_type;
+	u32				priv_driver_data_size;
+	u32				priv_driver_resource_size;
+	u32				physical_adapter_index;
+	union {
+		struct d3dkmdt_sharedprimarysurfacedata	primary;
+		struct d3dkmdt_shadowsurfacedata	shadow;
+		struct d3dkmdt_stagingsurfacedata	staging;
+		struct d3dkmdt_gdisurfacedata		gdi_surface;
+	};
+};
+
+struct dxgkvmb_command_getstandardallocprivdata_return {
+	struct ntstatus			status;
+	u32				priv_driver_data_size;
+	u32				priv_driver_resource_size;
+	union {
+		struct d3dkmdt_sharedprimarysurfacedata	primary;
+		struct d3dkmdt_shadowsurfacedata	shadow;
+		struct d3dkmdt_stagingsurfacedata	staging;
+		struct d3dkmdt_gdisurfacedata		gdi_surface;
+	};
+/* char alloc_priv_data[priv_driver_data_size]; */
+/* char resource_priv_data[priv_driver_resource_size]; */
+};
+
+struct dxgkarg_describeallocation {
+	u64				allocation;
+	u32				width;
+	u32				height;
+	u32				format;
+	u32				multisample_method;
+	struct d3dddi_rational		refresh_rate;
+	u32				private_driver_attribute;
+	u32				flags;
+	u32				rotation;
+};
+
+struct dxgkvmb_allocflags {
+	union {
+		u32			flags;
+		struct {
+			u32		primary:1;
+			u32		cdd_primary:1;
+			u32		dod_primary:1;
+			u32		overlay:1;
+			u32		reserved6:1;
+			u32		capture:1;
+			u32		reserved0:4;
+			u32		reserved1:1;
+			u32		existing_sysmem:1;
+			u32		stereo:1;
+			u32		direct_flip:1;
+			u32		hardware_protected:1;
+			u32		reserved2:1;
+			u32		reserved3:1;
+			u32		reserved4:1;
+			u32		protected:1;
+			u32		cached:1;
+			u32		independent_primary:1;
+			u32		reserved:11;
+		};
+	};
+};
+
+struct dxgkvmb_command_allocinfo_return {
+	struct d3dkmthandle		allocation;
+	u32				priv_drv_data_size;
+	struct dxgkvmb_allocflags	allocation_flags;
+	u64				allocation_size;
+	struct dxgkarg_describeallocation driver_info;
+};
+
+struct dxgkvmb_command_createallocation_return {
+	struct d3dkmt_createallocationflags flags;
+	struct d3dkmthandle		resource;
+	struct d3dkmthandle		global_share;
+	u32				vgpu_flags;
+	struct dxgkvmb_command_allocinfo_return allocation_info[1];
+	/* Private driver data for allocations */
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroyallocation {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				alloc_count;
+	struct d3dddicb_destroyallocation2flags flags;
+	struct d3dkmthandle			allocations[1];
+};
+
+struct dxgkvmb_command_createcontextvirtual {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	struct d3dkmthandle		device;
+	u32				node_ordinal;
+	u32				engine_affinity;
+	struct d3dddi_createcontextflags flags;
+	enum d3dkmt_clienthint		client_hint;
+	u32				priv_drv_data_size;
+	u8				priv_drv_data[1];
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroycontext {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle	context;
+};
+
+struct dxgkvmb_command_createpagingqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_createpagingqueue	args;
+};
+
+struct dxgkvmb_command_createpagingqueue_return {
+	struct d3dkmthandle	paging_queue;
+	struct d3dkmthandle	sync_object;
+	u64			fence_storage_physical_address;
+	u64			fence_storage_offset;
+};
+
+struct dxgkvmb_command_destroypagingqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle	paging_queue;
+};
+
+struct dxgkvmb_command_createsyncobject {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_createsynchronizationobject2 args;
+	u32				client_hint;
+};
+
+struct dxgkvmb_command_createsyncobject_return {
+	struct d3dkmthandle	sync_object;
+	struct d3dkmthandle	global_sync_object;
+	u64			fence_gpu_va;
+	u64			fence_storage_address;
+	u32			fence_storage_offset;
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroysyncobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle	sync_object;
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_signalsyncobject {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u32				object_count;
+	struct d3dddicb_signalflags	flags;
+	u32				context_count;
+	u64				fence_value;
+	union {
+		/* Pointer to the guest event object */
+		u64			cpu_event_handle;
+		/* Non zero when signal from CPU is done */
+		struct d3dkmthandle		device;
+	};
+	/* struct d3dkmthandle ObjectHandleArray[object_count] */
+	/* struct d3dkmthandle ContextArray[context_count]     */
+	/* u64 MonitoredFenceValueArray[object_count] */
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_waitforsyncobjectfromcpu {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	u32				object_count;
+	struct d3dddi_waitforsynchronizationobjectfromcpu_flags flags;
+	u64				guest_event_pointer;
+	bool				dereference_event;
+	/* struct d3dkmthandle ObjectHandleArray[object_count] */
+	/* u64 FenceValueArray [object_count] */
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_waitforsyncobjectfromgpu {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	/* Must be 1 when bLegacyFenceObject is TRUE */
+	u32				object_count;
+	bool				legacy_fence_object;
+	u64				fence_values[1];
+	/* struct d3dkmthandle ObjectHandles[object_count] */
+};
+
+struct dxgkvmb_command_lock2 {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_lock2		args;
+	bool				use_legacy_lock;
+	u32				flags;
+	u32				priv_drv_data;
+};
+
+struct dxgkvmb_command_lock2_return {
+	struct ntstatus			status;
+	void				*cpu_visible_buffer_offset;
+};
+
+struct dxgkvmb_command_unlock2 {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_unlock2		args;
+	bool				use_legacy_unlock;
+};
+
+struct dxgkvmb_command_updateallocationproperty {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_updateallocproperty args;
+};
+
+struct dxgkvmb_command_updateallocationproperty_return {
+	u64				paging_fence_value;
+	struct ntstatus			status;
+};
+
+struct dxgkvmb_command_markdeviceaserror {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_markdeviceaserror args;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_offerallocations {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	u32				allocation_count;
+	enum d3dkmt_offer_priority	priority;
+	struct d3dkmt_offer_flags	flags;
+	bool				resources;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_reclaimallocations {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		paging_queue;
+	u32				allocation_count;
+	bool				resources;
+	bool				write_results;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_reclaimallocations_return {
+	u64				paging_fence_value;
+	struct ntstatus			status;
+	enum d3dddi_reclaim_result	discarded[1];
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_changevideomemoryreservation {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_changevideomemoryreservation args;
+};
+
+/* Returns the same structure */
+struct dxgkvmb_command_createhwqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct ntstatus			status;
+	struct d3dkmthandle		hwqueue;
+	struct d3dkmthandle		hwqueue_progress_fence;
+	void				*hwqueue_progress_fence_cpuva;
+	u64				hwqueue_progress_fence_gpuva;
+	struct d3dkmthandle		context;
+	struct d3dddi_createhwqueueflags flags;
+	u32				priv_drv_data_size;
+	char				priv_drv_data[1];
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroyhwqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		hwqueue;
+};
+
+struct dxgkvmb_command_queryallocationresidency {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_queryallocationresidency args;
+	/* struct d3dkmthandle allocations[0 or number of allocations] */
+};
+
+struct dxgkvmb_command_queryallocationresidency_return {
+	struct ntstatus			status;
+	/* d3dkmt_allocationresidencystatus[NumAllocations] */
+};
+
+/* Returns only private data */
+struct dxgkvmb_command_escape {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		adapter;
+	struct d3dkmthandle		device;
+	enum d3dkmt_escapetype		type;
+	struct d3dddi_escapeflags	flags;
+	u32				priv_drv_data_size;
+	struct d3dkmthandle		context;
+	u8				priv_drv_data[1];
+};
+
+struct dxgkvmb_command_queryvideomemoryinfo {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		adapter;
+	enum d3dkmt_memory_segment_group memory_segment_group;
+	u32				physical_adapter_index;
+};
+
+struct dxgkvmb_command_queryvideomemoryinfo_return {
+	u64			budget;
+	u64			current_usage;
+	u64			current_reservation;
+	u64			available_for_reservation;
+};
+
+struct dxgkvmb_command_getdevicestate {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_getdevicestate	args;
+};
+
+struct dxgkvmb_command_getdevicestate_return {
+	struct d3dkmt_getdevicestate	args;
+	struct ntstatus			status;
+};
+
+int
+dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
+		     void *command, u32 command_size, void *result,
+		     u32 result_size);
+
+#endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/hmgr.c b/drivers/hv/dxgkrnl/hmgr.c
new file mode 100644
index 000000000000..216e0956f8f8
--- /dev/null
+++ b/drivers/hv/dxgkrnl/hmgr.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Handle manager implementation
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+
+#include "misc.h"
+#include "dxgkrnl.h"
+#include "hmgr.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
diff --git a/drivers/hv/dxgkrnl/hmgr.h b/drivers/hv/dxgkrnl/hmgr.h
new file mode 100644
index 000000000000..b8b8f3ae5939
--- /dev/null
+++ b/drivers/hv/dxgkrnl/hmgr.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Handle manager definitions
+ *
+ */
+
+#ifndef _HMGR_H_
+#define _HMGR_H_
+
+#include "misc.h"
+
+struct hmgrentry;
+
+/*
+ * Handle manager table.
+ *
+ * Implementation notes:
+ *   A list of free handles is built on top of the array of table entries.
+ *   free_handle_list_head is the index of the first entry in the list.
+ *   m_FreeHandleListTail is the index of an entry in the list, which is
+ *   HMGRTABLE_MIN_FREE_ENTRIES from the head. It means that when a handle is
+ *   freed, the next time the handle can be re-used is after allocating
+ *   HMGRTABLE_MIN_FREE_ENTRIES number of handles.
+ *   Handles are allocated from the start of the list and free handles are
+ *   inserted after the tail of the list.
+ *
+ */
+struct hmgrtable {
+	struct dxgprocess	*process;
+	struct hmgrentry	*entry_table;
+	u32			free_handle_list_head;
+	u32			free_handle_list_tail;
+	u32			table_size;
+	u32			free_count;
+	struct rw_semaphore	table_lock;
+};
+
+/*
+ * Handle entry data types.
+ */
+#define HMGRENTRY_TYPE_BITS 5
+
+enum hmgrentry_type {
+	HMGRENTRY_TYPE_FREE				= 0,
+	HMGRENTRY_TYPE_DXGADAPTER			= 1,
+	HMGRENTRY_TYPE_DXGSHAREDRESOURCE		= 2,
+	HMGRENTRY_TYPE_DXGDEVICE			= 3,
+	HMGRENTRY_TYPE_DXGRESOURCE			= 4,
+	HMGRENTRY_TYPE_DXGALLOCATION			= 5,
+	HMGRENTRY_TYPE_DXGOVERLAY			= 6,
+	HMGRENTRY_TYPE_DXGCONTEXT			= 7,
+	HMGRENTRY_TYPE_DXGSYNCOBJECT			= 8,
+	HMGRENTRY_TYPE_DXGKEYEDMUTEX			= 9,
+	HMGRENTRY_TYPE_DXGPAGINGQUEUE			= 10,
+	HMGRENTRY_TYPE_DXGDEVICESYNCOBJECT		= 11,
+	HMGRENTRY_TYPE_DXGPROCESS			= 12,
+	HMGRENTRY_TYPE_DXGSHAREDVMOBJECT		= 13,
+	HMGRENTRY_TYPE_DXGPROTECTEDSESSION		= 14,
+	HMGRENTRY_TYPE_DXGHWQUEUE			= 15,
+	HMGRENTRY_TYPE_DXGREMOTEBUNDLEOBJECT		= 16,
+	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEOBJECT	= 17,
+	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEPROXY	= 18,
+	HMGRENTRY_TYPE_DXGTRACKEDWORKLOAD		= 19,
+	HMGRENTRY_TYPE_LIMIT		= ((1 << HMGRENTRY_TYPE_BITS) - 1),
+	HMGRENTRY_TYPE_MONITOREDFENCE	= HMGRENTRY_TYPE_LIMIT + 1,
+};
+
+#endif
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
new file mode 100644
index 000000000000..277e25e5d8c6
--- /dev/null
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Ioctl implementation
+ *
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/anon_inodes.h>
+#include <linux/mman.h>
+
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
diff --git a/drivers/hv/dxgkrnl/misc.c b/drivers/hv/dxgkrnl/misc.c
new file mode 100644
index 000000000000..cb1e0635bebc
--- /dev/null
+++ b/drivers/hv/dxgkrnl/misc.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Helper functions
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/uaccess.h>
+
+#include "dxgkrnl.h"
+#include "misc.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+u16 *wcsncpy(u16 *dest, const u16 *src, size_t n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		dest[i] = src[i];
+		if (src[i] == 0) {
+			i++;
+			break;
+		}
+	}
+	dest[i - 1] = 0;
+	return dest;
+}
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
new file mode 100644
index 000000000000..1ff0c0e28332
--- /dev/null
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Misc definitions
+ *
+ */
+
+#ifndef _MISC_H_
+#define _MISC_H_
+
+/* Max characters in Windows path */
+#define WIN_MAX_PATH		260
+
+extern const struct d3dkmthandle zerohandle;
+
+/*
+ * Synchronization lock hierarchy.
+ *
+ * The higher enum value, the higher is the lock order.
+ * When a lower lock ois held, the higher lock should not be acquired.
+ *
+ * channel_lock
+ * fd_mutex
+ * plistmutex
+ * table_lock
+ * core_lock
+ * device_lock
+ * process->process_mutex
+ * adapter_list_lock
+ * device_mutex
+ */
+
+u16 *wcsncpy(u16 *dest, const u16 *src, size_t n);
+
+enum dxglockstate {
+	DXGLOCK_SHARED,
+	DXGLOCK_EXCL
+};
+
+/*
+ * Some of the Windows return codes, which needs to be translated to Linux
+ * IOCTL return codes. Positive values are success codes and need to be
+ * returned from the driver IOCTLs. libdxcore.so depends on returning
+ * specific return codes.
+ */
+#define STATUS_SUCCESS					((int)(0))
+#define	STATUS_OBJECT_NAME_INVALID			((int)(0xC0000033L))
+#define	STATUS_DEVICE_REMOVED				((int)(0xC00002B6L))
+#define	STATUS_INVALID_HANDLE				((int)(0xC0000008L))
+#define	STATUS_ILLEGAL_INSTRUCTION			((int)(0xC000001DL))
+#define	STATUS_NOT_IMPLEMENTED				((int)(0xC0000002L))
+#define	STATUS_PENDING					((int)(0x00000103L))
+#define	STATUS_ACCESS_DENIED				((int)(0xC0000022L))
+#define	STATUS_BUFFER_TOO_SMALL				((int)(0xC0000023L))
+#define	STATUS_OBJECT_TYPE_MISMATCH			((int)(0xC0000024L))
+#define	STATUS_GRAPHICS_ALLOCATION_BUSY			((int)(0xC01E0102L))
+#define	STATUS_NOT_SUPPORTED				((int)(0xC00000BBL))
+#define	STATUS_TIMEOUT					((int)(0x00000102L))
+#define	STATUS_INVALID_PARAMETER			((int)(0xC000000DL))
+#define	STATUS_NO_MEMORY				((int)(0xC0000017L))
+#define	STATUS_OBJECT_NAME_COLLISION			((int)(0xC0000035L))
+#define STATUS_OBJECT_NAME_NOT_FOUND			((int)(0xC0000034L))
+
+
+#define NT_SUCCESS(status)				(status.v >= 0)
+
+#ifndef DEBUG
+
+#define DXGKRNL_ASSERT(exp)
+
+#else
+
+#define DXGKRNL_ASSERT(exp)	\
+do {				\
+	if (!(exp)) {		\
+		dump_stack();	\
+		BUG_ON(true);	\
+	}			\
+} while (0)
+
+#endif /* DEBUG */
+
+#endif /* _MISC_H_ */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b823311eac79..9d21055b003d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1414,6 +1414,22 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 	.guid = GUID_INIT(0xda0a7802, 0xe377, 0x4aac, 0x8e, 0x77, \
 			  0x05, 0x58, 0xeb, 0x10, 0x73, 0xf8)
 
+/*
+ * GPU paravirtualization global DXGK channel
+ * {DDE9CBC0-5060-4436-9448-EA1254A5D177}
+ */
+#define HV_GPUP_DXGK_GLOBAL_GUID \
+	.guid = GUID_INIT(0xdde9cbc0, 0x5060, 0x4436, 0x94, 0x48, \
+			  0xea, 0x12, 0x54, 0xa5, 0xd1, 0x77)
+
+/*
+ * GPU paravirtualization per virtual GPU DXGK channel
+ * {6E382D18-3336-4F4B-ACC4-2B7703D4DF4A}
+ */
+#define HV_GPUP_DXGK_VGPU_GUID \
+	.guid = GUID_INIT(0x6e382d18, 0x3336, 0x4f4b, 0xac, 0xc4, \
+			  0x2b, 0x77, 0x3, 0xd4, 0xdf, 0x4a)
+
 /*
  * Synthetic FC GUID
  * {2f9bcc4a-0069-4af3-b76b-6fd0be528cda}
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
new file mode 100644
index 000000000000..6e5519d5dbc7
--- /dev/null
+++ b/include/uapi/misc/d3dkmthk.h
@@ -0,0 +1,1945 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * User mode WDDM interface definitions
+ *
+ */
+
+#ifndef _D3DKMTHK_H
+#define _D3DKMTHK_H
+
+/*
+ * This structure matches the definition of D3DKMTHANDLE in Windows.
+ * The handle is opaque in user mode. It is used by user mode applications to
+ * represent kernel mode objects, created by dxgkrnl.
+ */
+struct d3dkmthandle {
+	union {
+		struct {
+			__u32 instance	:  6;
+			__u32 index	: 24;
+			__u32 unique	: 2;
+		};
+		__u32 v;
+	};
+};
+
+/*
+ * VM bus messages return Windows' NTSTATUS, which is integer and only negative
+ * value indicates a failure. A positive number is a success and needs to be
+ * returned to user mode as the IOCTL return code. Negative status codes are
+ * converted to Linux error codes.
+ */
+struct ntstatus {
+	union {
+		struct {
+			int code	: 16;
+			int facility	: 13;
+			int customer	: 1;
+			int severity	: 2;
+		};
+		int v;
+	};
+};
+
+/* Matches Windows LUID definition */
+struct winluid {
+	__u32 a;
+	__u32 b;
+};
+
+#define D3DDDI_MAX_WRITTEN_PRIMARIES		16
+#define D3DDDI_MAX_MPO_PRESENT_DIRTY_RECTS	0xFFF
+
+#define D3DKMT_CREATEALLOCATION_MAX		1024
+#define D3DKMT_MAKERESIDENT_ALLOC_MAX		(1024 * 10)
+#define D3DKMT_ADAPTERS_MAX			64
+#define D3DDDI_MAX_BROADCAST_CONTEXT		64
+#define D3DDDI_MAX_OBJECT_WAITED_ON		32
+#define D3DDDI_MAX_OBJECT_SIGNALED		32
+
+struct d3dkmt_adapterinfo {
+	struct d3dkmthandle		adapter_handle;
+	struct winluid			adapter_luid;
+	__u32				num_sources;
+	__u32				present_move_regions_preferred;
+};
+
+struct d3dkmt_enumadapters2 {
+	__u32				num_adapters;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dkmt_adapterinfo	*adapters;
+#else
+	__u64				*adapters;
+#endif
+};
+
+struct d3dkmt_closeadapter {
+	struct d3dkmthandle		adapter_handle;
+};
+
+struct d3dkmt_openadapterfromluid {
+	struct winluid			adapter_luid;
+	struct d3dkmthandle		adapter_handle;
+};
+
+struct d3dddi_allocationlist {
+	struct d3dkmthandle		allocation;
+	union {
+		struct {
+			__u32		write_operation		:1;
+			__u32		do_not_retire_instance	:1;
+			__u32		offer_priority		:3;
+			__u32		reserved		:27;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dddi_patchlocationlist {
+	__u32				allocation_index;
+	union {
+		struct {
+			__u32		slot_id:24;
+			__u32		reserved:8;
+		};
+		__u32			value;
+	};
+	__u32				driver_id;
+	__u32				allocation_offset;
+	__u32				patch_offset;
+	__u32				split_offset;
+};
+
+struct d3dkmt_createdeviceflags {
+	__u32				legacy_mode:1;
+	__u32				request_vSync:1;
+	__u32				disable_gpu_timeout:1;
+	__u32				gdi_device:1;
+	__u32				reserved:28;
+};
+
+struct d3dkmt_createdevice {
+	struct d3dkmthandle		adapter;
+	__u32				reserved3;
+	struct d3dkmt_createdeviceflags	flags;
+	struct d3dkmthandle		device;
+#ifdef __KERNEL__
+	void				*command_buffer;
+#else
+	__u64				command_buffer;
+#endif
+	__u32				command_buffer_size;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dddi_allocationlist	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_list_size;
+	__u32				reserved1;
+#ifdef __KERNEL__
+	struct d3dddi_patchlocationlist	*patch_location_list;
+#else
+	__u64				patch_location_list;
+#endif
+	__u32				patch_location_list_size;
+	__u32				reserved2;
+};
+
+struct d3dkmt_destroydevice {
+	struct d3dkmthandle		device;
+};
+
+enum d3dkmt_clienthint {
+	_D3DKMT_CLIENTHNT_UNKNOWN	= 0,
+	_D3DKMT_CLIENTHINT_OPENGL	= 1,
+	_D3DKMT_CLIENTHINT_CDD		= 2,
+	_D3DKMT_CLIENTHINT_DX7		= 7,
+	_D3DKMT_CLIENTHINT_DX8		= 8,
+	_D3DKMT_CLIENTHINT_DX9		= 9,
+	_D3DKMT_CLIENTHINT_DX10		= 10,
+};
+
+struct d3dddi_createcontextflags {
+	union {
+		struct {
+			__u32		null_rendering:1;
+			__u32		initial_data:1;
+			__u32		disable_gpu_timeout:1;
+			__u32		synchronization_only:1;
+			__u32		hw_queue_supported:1;
+			__u32		reserved:27;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_createcontext {
+	struct d3dkmthandle		device;
+	__u32				node_ordinal;
+	__u32				engine_affinity;
+	struct d3dddi_createcontextflags flags;
+#ifdef __KERNEL__
+	void				*priv_drv_data;
+#else
+	__u64				priv_drv_data;
+#endif
+	__u32				priv_drv_data_size;
+	enum d3dkmt_clienthint		client_hint;
+	struct d3dkmthandle		context;
+#ifdef __KERNEL__
+	void				*command_buffer;
+#else
+	__u64				command_buffer;
+#endif
+	__u32				command_buffer_size;
+#ifdef __KERNEL__
+	struct d3dddi_allocationlist	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_list_size;
+#ifdef __KERNEL__
+	struct d3dddi_patchlocationlist	*patch_location_list;
+#else
+	__u64				patch_location_list;
+#endif
+	__u32				patch_location_list_size;
+	__u64				obsolete;
+};
+
+struct d3dkmt_destroycontext {
+	struct d3dkmthandle		context;
+};
+
+struct d3dkmt_createcontextvirtual {
+	struct d3dkmthandle		device;
+	__u32				node_ordinal;
+	__u32				engine_affinity;
+	struct d3dddi_createcontextflags flags;
+#ifdef __KERNEL__
+	void				*priv_drv_data;
+#else
+	__u64				priv_drv_data;
+#endif
+	__u32				priv_drv_data_size;
+	enum d3dkmt_clienthint		client_hint;
+	struct d3dkmthandle		context;
+};
+
+struct d3dddi_createhwcontextflags {
+	union {
+		struct {
+			__u32		reserved:32;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dddi_createhwqueueflags {
+	union {
+		struct {
+			__u32		disable_gpu_timeout:1;
+			__u32		reserved:31;
+		};
+		__u32			value;
+	};
+};
+
+enum d3dddi_pagingqueue_priority {
+	_D3DDDI_PAGINGQUEUE_PRIORITY_BELOW_NORMAL	= -1,
+	_D3DDDI_PAGINGQUEUE_PRIORITY_NORMAL		= 0,
+	_D3DDDI_PAGINGQUEUE_PRIORITY_ABOVE_NORMAL	= 1,
+};
+
+struct d3dkmt_createpagingqueue {
+	struct d3dkmthandle		device;
+	enum d3dddi_pagingqueue_priority priority;
+	struct d3dkmthandle		paging_queue;
+	struct d3dkmthandle		sync_object;
+#ifdef __KERNEL__
+	void				*fence_cpu_virtual_address;
+#else
+	__u64				fence_cpu_virtual_address;
+#endif
+	__u32				physical_adapter_index;
+};
+
+struct d3dddi_destroypagingqueue {
+	struct d3dkmthandle		paging_queue;
+};
+
+struct d3dkmt_renderflags {
+	__u32				resize_command_buffer:1;
+	__u32				resize_allocation_list:1;
+	__u32				resize_patch_location_list:1;
+	__u32				null_rendering:1;
+	__u32				present_redirected:1;
+	__u32				render_km:1;
+	__u32				render_km_readback:1;
+	__u32				reserved:25;
+};
+struct d3dkmt_render {
+	union {
+		struct d3dkmthandle	device;
+		struct d3dkmthandle	context;
+	};
+	__u32				command_offset;
+	__u32				command_length;
+	__u32				allocation_count;
+	__u32				patch_location_count;
+#ifdef __KERNEL__
+	void				*new_command_buffer;
+#else
+	__u64				new_command_buffer;
+#endif
+	__u32				new_command_buffer_size;
+#ifdef __KERNEL__
+	struct d3dddi_allocationlist	*new_allocation_list;
+#else
+	__u64				new_allocation_list;
+#endif
+	__u32				new_allocation_list_size;
+#ifdef __KERNEL__
+	struct d3dddi_patchlocationlist	*new_patch_pocation_list;
+#else
+	__u64				new_patch_pocation_list;
+#endif
+	__u32				new_patch_pocation_list_size;
+	struct d3dkmt_renderflags	flags;
+	__u64				present_history_token;
+	__u32				broadcast_context_count;
+	struct d3dkmthandle	broadcast_context[D3DDDI_MAX_BROADCAST_CONTEXT];
+	__u32				queued_buffer_count;
+	__u64				obsolete;
+#ifdef __KERNEL__
+	void				*priv_drv_data;
+#else
+	__u64				priv_drv_data;
+#endif
+	__u32				priv_drv_data_size;
+};
+
+enum d3dkmt_standardallocationtype {
+	_D3DKMT_STANDARDALLOCATIONTYPE_EXISTINGHEAP	= 1,
+	_D3DKMT_STANDARDALLOCATIONTYPE_CROSSADAPTER	= 2,
+};
+
+struct d3dkmt_standardallocation_existingheap {
+	__u64	size;
+};
+
+struct d3dkmt_createstandardallocationflags {
+	union {
+		struct {
+			__u32		reserved:32;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_createstandardallocation {
+	enum d3dkmt_standardallocationtype		type;
+	__u32						reserved;
+	struct d3dkmt_standardallocation_existingheap	existing_heap_data;
+	struct d3dkmt_createstandardallocationflags	flags;
+	__u32						reserved1;
+};
+
+struct d3dddi_allocationinfo2 {
+	struct d3dkmthandle	allocation;
+#ifdef __KERNEL__
+	const void		*sysmem;
+#else
+	__u64			sysmem;
+#endif
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	__u32			priv_drv_data_size;
+	__u32			vidpn_source_id;
+	union {
+		struct {
+			__u32	primary:1;
+			__u32	stereo:1;
+			__u32	override_priority:1;
+			__u32	reserved:29;
+		};
+		__u32		value;
+	} flags;
+	__u64			gpu_virtual_address;
+	union {
+		__u32		priority;
+		__u64		unused;
+	};
+	__u64			reserved[5];
+};
+
+struct d3dkmt_createallocationflags {
+	union {
+		struct {
+			__u32		create_resource:1;
+			__u32		create_shared:1;
+			__u32		non_secure:1;
+			__u32		create_protected:1;
+			__u32		restrict_shared_access:1;
+			__u32		existing_sysmem:1;
+			__u32		nt_security_sharing:1;
+			__u32		read_only:1;
+			__u32		create_write_combined:1;
+			__u32		create_cached:1;
+			__u32		swap_chain_back_buffer:1;
+			__u32		cross_adapter:1;
+			__u32		open_cross_adapter:1;
+			__u32		partial_shared_creation:1;
+			__u32		zeroed:1;
+			__u32		write_watch:1;
+			__u32		standard_allocation:1;
+			__u32		existing_section:1;
+			__u32		reserved:14;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_createallocation {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	struct d3dkmthandle		global_share;
+	__u32				reserved;
+#ifdef __KERNEL__
+	const void			*private_runtime_data;
+#else
+	__u64				private_runtime_data;
+#endif
+	__u32				private_runtime_data_size;
+	__u32				reserved1;
+	union {
+#ifdef __KERNEL__
+		struct d3dkmt_createstandardallocation *standard_allocation;
+		const void *priv_drv_data;
+#else
+		__u64	standard_allocation;
+		__u64	priv_drv_data;
+#endif
+	};
+	__u32				priv_drv_data_size;
+	__u32				alloc_count;
+#ifdef __KERNEL__
+	struct d3dddi_allocationinfo2	*allocation_info;
+#else
+	__u64				allocation_info;
+#endif
+	struct d3dkmt_createallocationflags flags;
+	__u32				reserved2;
+	__u64				private_runtime_resource_handle;
+};
+
+struct d3dddicb_destroyallocation2flags {
+	union {
+		struct {
+			__u32		assume_not_in_use:1;
+			__u32		synchronous_destroy:1;
+			__u32		reserved:29;
+			__u32		system_use_only:1;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_destroyallocation2 {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocations;
+#else
+	__u64				allocations;
+#endif
+	__u32				alloc_count;
+	struct d3dddicb_destroyallocation2flags flags;
+};
+
+struct d3dddi_makeresident_flags {
+	union {
+		struct {
+			__u32		cant_trim_further:1;
+			__u32		must_succeed:1;
+			__u32		reserved:30;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dddi_makeresident {
+	struct d3dkmthandle		paging_queue;
+	__u32				alloc_count;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+	const __u32			*priority_list;
+#else
+	__u64				allocation_list;
+	__u64				priority_list;
+#endif
+	struct d3dddi_makeresident_flags flags;
+	__u64				paging_fence_value;
+	__u64				num_bytes_to_trim;
+};
+
+struct d3dddi_evict_flags {
+	union {
+		struct {
+			__u32		evict_only_if_necessary:1;
+			__u32		not_written_to:1;
+			__u32		reserved:30;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_evict {
+	struct d3dkmthandle		device;
+	__u32				alloc_count;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocations;
+#else
+	__u64				allocations;
+#endif
+	struct d3dddi_evict_flags	flags;
+	__u32				reserved;
+	__u64				num_bytes_to_trim;
+};
+
+struct d3dddigpuva_protection_type {
+	union {
+		struct {
+			__u64	write:1;
+			__u64	execute:1;
+			__u64	zero:1;
+			__u64	no_access:1;
+			__u64	system_use_only:1;
+			__u64	reserved:59;
+		};
+		__u64		value;
+	};
+};
+
+enum d3dddi_updategpuvirtualaddress_operation_type {
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_MAP		= 0,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_UNMAP		= 1,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_COPY		= 2,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_MAP_PROTECT	= 3,
+};
+
+struct d3dddi_updategpuvirtualaddress_operation {
+	enum d3dddi_updategpuvirtualaddress_operation_type operation;
+	union {
+		struct {
+			__u64		base_address;
+			__u64		size;
+			struct d3dkmthandle allocation;
+			__u64		allocation_offset;
+			__u64		allocation_size;
+		} map;
+		struct {
+			__u64		base_address;
+			__u64		size;
+			struct d3dkmthandle allocation;
+			__u64		allocation_offset;
+			__u64		allocation_size;
+			struct d3dddigpuva_protection_type protection;
+			__u64		driver_protection;
+		} map_protect;
+		struct {
+			__u64	base_address;
+			__u64	size;
+			struct d3dddigpuva_protection_type protection;
+		} unmap;
+		struct {
+			__u64	source_address;
+			__u64	size;
+			__u64	dest_address;
+		} copy;
+	};
+};
+
+enum d3dddigpuva_reservation_type {
+	_D3DDDIGPUVA_RESERVE_NO_ACCESS		= 0,
+	_D3DDDIGPUVA_RESERVE_ZERO		= 1,
+	_D3DDDIGPUVA_RESERVE_NO_COMMIT		= 2
+};
+
+struct d3dkmt_updategpuvirtualaddress {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			context;
+	struct d3dkmthandle			fence_object;
+	__u32					num_operations;
+#ifdef __KERNEL__
+	struct d3dddi_updategpuvirtualaddress_operation *operations;
+#else
+	__u64					operations;
+#endif
+	__u32					reserved0;
+	__u32					reserved1;
+	__u64					reserved2;
+	__u64					fence_value;
+	union {
+		struct {
+			__u32			do_not_wait:1;
+			__u32			reserved:31;
+		};
+		__u32				value;
+	} flags;
+	__u32					reserved3;
+};
+
+struct d3dddi_mapgpuvirtualaddress {
+	struct d3dkmthandle			paging_queue;
+	__u64					base_address;
+	__u64					minimum_address;
+	__u64					maximum_address;
+	struct d3dkmthandle			allocation;
+	__u64					offset_in_pages;
+	__u64					size_in_pages;
+	struct d3dddigpuva_protection_type	protection;
+	__u64					driver_protection;
+	__u32					reserved0;
+	__u64					reserved1;
+	__u64					virtual_address;
+	__u64					paging_fence_value;
+};
+
+struct d3dddi_reservegpuvirtualaddress {
+	struct d3dkmthandle			adapter;
+	__u64					base_address;
+	__u64					minimum_address;
+	__u64					maximum_address;
+	__u64					size;
+	enum d3dddigpuva_reservation_type	reservation_type;
+	__u64					driver_protection;
+	__u64					virtual_address;
+	__u64					paging_fence_value;
+};
+
+struct d3dkmt_freegpuvirtualaddress {
+	struct d3dkmthandle	adapter;
+	__u32			reserved;
+	__u64			base_address;
+	__u64			size;
+};
+
+enum d3dkmt_memory_segment_group {
+	_D3DKMT_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
+	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
+};
+
+struct d3dkmt_queryvideomemoryinfo {
+	__u64					process;
+	struct d3dkmthandle			adapter;
+	enum d3dkmt_memory_segment_group	memory_segment_group;
+	__u64					budget;
+	__u64					current_usage;
+	__u64					current_reservation;
+	__u64					available_for_reservation;
+	__u32					physical_adapter_index;
+};
+
+struct d3dkmt_adaptertype {
+	union {
+		struct {
+			__u32		render_supported:1;
+			__u32		display_supported:1;
+			__u32		software_device:1;
+			__u32		post_device:1;
+			__u32		hybrid_discrete:1;
+			__u32		hybrid_integrated:1;
+			__u32		indirect_display_device:1;
+			__u32		paravirtualized:1;
+			__u32		acg_supported:1;
+			__u32		support_set_timings_from_vidpn:1;
+			__u32		detachable:1;
+			__u32		compute_only:1;
+			__u32		prototype:1;
+			__u32		reserved:19;
+		};
+		__u32			value;
+	};
+};
+
+enum kmtqueryadapterinfotype {
+	_KMTQAITYPE_UMDRIVERPRIVATE	= 0,
+	_KMTQAITYPE_ADAPTERTYPE		= 15,
+	_KMTQAITYPE_ADAPTERTYPE_RENDER	= 57
+};
+
+struct d3dkmt_queryadapterinfo {
+	struct d3dkmthandle		adapter;
+	enum kmtqueryadapterinfotype	type;
+#ifdef __KERNEL__
+	void				*private_data;
+#else
+	__u64				private_data;
+#endif
+	__u32				private_data_size;
+};
+
+enum d3dkmt_escapetype {
+	_D3DKMT_ESCAPE_DRIVERPRIVATE	= 0,
+	_D3DKMT_ESCAPE_VIDMM		= 1,
+	_D3DKMT_ESCAPE_VIDSCH		= 3,
+	_D3DKMT_ESCAPE_DEVICE		= 4,
+	_D3DKMT_ESCAPE_DRT_TEST		= 8,
+};
+
+enum d3dkmt_drt_test_command {
+	_D3DKMT_DRT_TEST_COMMAND_HANDLETABLE = 39,
+};
+
+struct d3dkmt_drt_escape_head {
+	__u32				signature;
+	__u32				buffer_size;
+	enum d3dkmt_drt_test_command	command;
+};
+
+enum d3dkmt_ht_command {
+	_D3DKMT_HT_COMMAND_ALLOC,
+	_D3DKMT_HT_COMMAND_FREE,
+	_D3DKMT_HT_COMMAND_ASSIGN,
+	_D3DKMT_HT_COMMAND_GET,
+	_D3DKMT_HT_COMMAND_DESTROY,
+};
+
+struct d3dkmt_ht_desc {
+	struct d3dkmt_drt_escape_head	head;
+	enum d3dkmt_ht_command		command;
+	__u32				index;
+	struct d3dkmthandle		handle;
+	__u32				object_type;
+#ifdef __KERNEL__
+	void				*object;
+#else
+	__u64				object;
+#endif
+};
+
+struct d3dddi_escapeflags {
+	union {
+		struct {
+			__u32		hardware_access:1;
+			__u32		device_status_query:1;
+			__u32		change_frame_latency:1;
+			__u32		no_adapter_synchronization:1;
+			__u32		reserved:1;
+			__u32		virtual_machine_data:1;
+			__u32		driver_known_escape:1;
+			__u32		driver_common_escape:1;
+			__u32		reserved2:24;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_escape {
+	struct d3dkmthandle		adapter;
+	struct d3dkmthandle		device;
+	enum d3dkmt_escapetype		type;
+	struct d3dddi_escapeflags	flags;
+#ifdef __KERNEL__
+	void				*priv_drv_data;
+#else
+	__u64				priv_drv_data;
+#endif
+	__u32				priv_drv_data_size;
+	struct d3dkmthandle		context;
+};
+
+enum dxgk_render_pipeline_stage {
+	_DXGK_RENDER_PIPELINE_STAGE_UNKNOWN		= 0,
+	_DXGK_RENDER_PIPELINE_STAGE_INPUT_ASSEMBLER	= 1,
+	_DXGK_RENDER_PIPELINE_STAGE_VERTEX_SHADER	= 2,
+	_DXGK_RENDER_PIPELINE_STAGE_GEOMETRY_SHADER	= 3,
+	_DXGK_RENDER_PIPELINE_STAGE_STREAM_OUTPUT	= 4,
+	_DXGK_RENDER_PIPELINE_STAGE_RASTERIZER		= 5,
+	_DXGK_RENDER_PIPELINE_STAGE_PIXEL_SHADER	= 6,
+	_DXGK_RENDER_PIPELINE_STAGE_OUTPUT_MERGER	= 7,
+};
+
+enum dxgk_page_fault_flags {
+	_DXGK_PAGE_FAULT_WRITE			= 0x1,
+	_DXGK_PAGE_FAULT_FENCE_INVALID		= 0x2,
+	_DXGK_PAGE_FAULT_ADAPTER_RESET_REQUIRED	= 0x4,
+	_DXGK_PAGE_FAULT_ENGINE_RESET_REQUIRED	= 0x8,
+	_DXGK_PAGE_FAULT_FATAL_HARDWARE_ERROR	= 0x10,
+	_DXGK_PAGE_FAULT_IOMMU			= 0x20,
+	_DXGK_PAGE_FAULT_HW_CONTEXT_VALID	= 0x40,
+	_DXGK_PAGE_FAULT_PROCESS_HANDLE_VALID	= 0x80,
+};
+
+enum dxgk_general_error_code {
+	_DXGK_GENERAL_ERROR_PAGE_FAULT		= 0,
+	_DXGK_GENERAL_ERROR_INVALID_INSTRUCTION	= 1,
+};
+
+struct dxgk_fault_error_code {
+	union {
+		struct {
+			__u32	is_device_specific_code:1;
+			enum dxgk_general_error_code general_error_code:31;
+		};
+		struct {
+			__u32	is_device_specific_code_reserved_bit:1;
+			__u32	device_specific_code:31;
+		};
+	};
+};
+
+enum d3dkmt_deviceexecution_state {
+	_D3DKMT_DEVICEEXECUTION_ACTIVE			= 1,
+	_D3DKMT_DEVICEEXECUTION_RESET			= 2,
+	_D3DKMT_DEVICEEXECUTION_HUNG			= 3,
+	_D3DKMT_DEVICEEXECUTION_STOPPED			= 4,
+	_D3DKMT_DEVICEEXECUTION_ERROR_OUTOFMEMORY	= 5,
+	_D3DKMT_DEVICEEXECUTION_ERROR_DMAFAULT		= 6,
+	_D3DKMT_DEVICEEXECUTION_ERROR_DMAPAGEFAULT	= 7,
+};
+
+struct d3dkmt_devicereset_state {
+	union {
+		struct {
+			__u32	desktop_switched:1;
+			__u32	reserved:31;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_present_stats {
+	__u32		present_count;
+	__u32		present_refresh_count;
+	__u32		sync_refresh_count;
+	__u32		reserved;
+	__u64		sync_qpc_time;
+	__u64		sync_gpu_time;
+};
+
+struct d3dkmt_devicepresent_state {
+	__u32				vidpn_source_id;
+	__u32				reserved;
+	struct d3dkmt_present_stats	present_stats;
+};
+
+struct d3dkmt_present_stats_dwm {
+	__u32	present_count;
+	__u32	present_refresh_count;
+	__u64	present_qpc_time;
+	__u32	sync_refresh_count;
+	__u32	reserved;
+	__u64	sync_qpc_time;
+	__u32	custom_present_duration;
+	__u32	reserved1;
+};
+
+struct d3dkmt_devicepagefault_state {
+	__u64				faulted_primitive_api_sequence_number;
+	enum dxgk_render_pipeline_stage	faulted_pipeline_stage;
+	__u32				faulted_bind_table_entry;
+	enum dxgk_page_fault_flags	page_fault_flags;
+	struct dxgk_fault_error_code	fault_error_code;
+	__u64				faulted_virtual_address;
+};
+
+struct d3dkmt_devicepresent_state_dwm {
+	__u32				vidpn_source_id;
+	__u32				reserved;
+	struct d3dkmt_present_stats_dwm	present_stats;
+};
+
+struct d3dkmt_devicepresent_queue_state {
+	__u32	vidpn_source_id;
+	bool	bQueuedPresentLimitReached;
+};
+
+enum d3dkmt_devicestate_type {
+	_D3DKMT_DEVICESTATE_EXECUTION		= 1,
+	_D3DKMT_DEVICESTATE_PRESENT		= 2,
+	_D3DKMT_DEVICESTATE_RESET		= 3,
+	_D3DKMT_DEVICESTATE_PRESENT_DWM		= 4,
+	_D3DKMT_DEVICESTATE_PAGE_FAULT		= 5,
+	_D3DKMT_DEVICESTATE_PRESENT_QUEUE	= 6,
+};
+
+struct d3dkmt_getdevicestate {
+	struct d3dkmthandle				device;
+	enum d3dkmt_devicestate_type			state_type;
+	union {
+		enum d3dkmt_deviceexecution_state	execution_state;
+		struct d3dkmt_devicepresent_state	present_state;
+		struct d3dkmt_devicereset_state		reset_state;
+		struct d3dkmt_devicepresent_state_dwm	present_state_dwm;
+		struct d3dkmt_devicepagefault_state	page_fault_state;
+		struct d3dkmt_devicepresent_queue_state	present_queue_state;
+	};
+};
+
+enum d3dkmdt_gdisurfacetype {
+	_D3DKMDT_GDISURFACE_INVALID				= 0,
+	_D3DKMDT_GDISURFACE_TEXTURE				= 1,
+	_D3DKMDT_GDISURFACE_STAGING_CPUVISIBLE			= 2,
+	_D3DKMDT_GDISURFACE_STAGING				= 3,
+	_D3DKMDT_GDISURFACE_LOOKUPTABLE				= 4,
+	_D3DKMDT_GDISURFACE_EXISTINGSYSMEM			= 5,
+	_D3DKMDT_GDISURFACE_TEXTURE_CPUVISIBLE			= 6,
+	_D3DKMDT_GDISURFACE_TEXTURE_CROSSADAPTER		= 7,
+	_D3DKMDT_GDISURFACE_TEXTURE_CPUVISIBLE_CROSSADAPTER	= 8,
+};
+
+struct d3dddi_rational {
+	__u32	numerator;
+	__u32	denominator;
+};
+
+enum d3dddiformat {
+	_D3DDDIFMT_UNKNOWN = 0,
+};
+
+struct d3dkmdt_gdisurfacedata {
+	__u32				width;
+	__u32				height;
+	__u32				format;
+	enum d3dkmdt_gdisurfacetype	type;
+	__u32				flags;
+	__u32				pitch;
+};
+
+struct d3dkmdt_stagingsurfacedata {
+	__u32	width;
+	__u32	height;
+	__u32	pitch;
+};
+
+struct d3dkmdt_sharedprimarysurfacedata {
+	__u32			width;
+	__u32			height;
+	enum d3dddiformat	format;
+	struct d3dddi_rational	refresh_rate;
+	__u32			vidpn_source_id;
+};
+
+struct d3dkmdt_shadowsurfacedata {
+	__u32			width;
+	__u32			height;
+	enum d3dddiformat	format;
+	__u32			pitch;
+};
+
+enum d3dkmdt_standardallocationtype {
+	_D3DKMDT_STANDARDALLOCATION_SHAREDPRIMARYSURFACE	= 1,
+	_D3DKMDT_STANDARDALLOCATION_SHADOWSURFACE		= 2,
+	_D3DKMDT_STANDARDALLOCATION_STAGINGSURFACE		= 3,
+	_D3DKMDT_STANDARDALLOCATION_GDISURFACE			= 4,
+};
+
+struct d3dddi_synchronizationobject_flags {
+	union {
+		struct {
+			__u32	shared:1;
+			__u32	nt_security_sharing:1;
+			__u32	cross_adapter:1;
+			__u32	top_of_pipeline:1;
+			__u32	no_signal:1;
+			__u32	no_wait:1;
+			__u32	no_signal_max_value_on_tdr:1;
+			__u32	no_gpu_access:1;
+			__u32	reserved:23;
+		};
+		__u32		value;
+	};
+};
+
+enum d3dddi_synchronizationobject_type {
+	_D3DDDI_SYNCHRONIZATION_MUTEX		= 1,
+	_D3DDDI_SEMAPHORE			= 2,
+	_D3DDDI_FENCE				= 3,
+	_D3DDDI_CPU_NOTIFICATION		= 4,
+	_D3DDDI_MONITORED_FENCE			= 5,
+	_D3DDDI_PERIODIC_MONITORED_FENCE	= 6,
+	_D3DDDI_SYNCHRONIZATION_TYPE_LIMIT
+};
+
+struct d3dddi_synchronizationobjectinfo2 {
+	enum d3dddi_synchronizationobject_type	type;
+	struct d3dddi_synchronizationobject_flags flags;
+	union {
+		struct {
+			__u32	initial_state;
+		} synchronization_mutex;
+
+		struct {
+			__u32			max_count;
+			__u32			initial_count;
+		} semaphore;
+
+		struct {
+			__u64		fence_value;
+		} fence;
+
+		struct {
+			__u64		event;
+		} cpu_notification;
+
+		struct {
+			__u64	initial_fence_value;
+#ifdef __KERNEL__
+			void	*fence_cpu_virtual_address;
+#else
+			__u64	*fence_cpu_virtual_address;
+#endif
+			__u64	fence_gpu_virtual_address;
+			__u32	engine_affinity;
+		} monitored_fence;
+
+		struct {
+			struct d3dkmthandle	adapter;
+			__u32			vidpn_target_id;
+			__u64			time;
+#ifdef __KERNEL__
+			void			*fence_cpu_virtual_address;
+#else
+			__u64			fence_cpu_virtual_address;
+#endif
+			__u64			fence_gpu_virtual_address;
+			__u32			engine_affinity;
+		} periodic_monitored_fence;
+
+		struct {
+			__u64	reserved[8];
+		} reserved;
+	};
+	struct d3dkmthandle			shared_handle;
+};
+
+struct d3dkmt_createsynchronizationobject2 {
+	struct d3dkmthandle				device;
+	__u32						reserved;
+	struct d3dddi_synchronizationobjectinfo2	info;
+	struct d3dkmthandle				sync_object;
+	__u32						reserved1;
+};
+
+struct d3dkmt_waitforsynchronizationobject2 {
+	struct d3dkmthandle	context;
+	__u32			object_count;
+	struct d3dkmthandle	object_array[D3DDDI_MAX_OBJECT_WAITED_ON];
+	union {
+		struct {
+			__u64	fence_value;
+		} fence;
+		__u64		reserved[8];
+	};
+};
+
+struct d3dddicb_signalflags {
+	union {
+		struct {
+			__u32			signal_at_submission:1;
+			__u32			enqueue_cpu_event:1;
+			__u32			allow_fence_rewind:1;
+			__u32			reserved:28;
+			__u32			DXGK_SIGNAL_FLAG_INTERNAL0:1;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dkmt_signalsynchronizationobject2 {
+	struct d3dkmthandle		context;
+	__u32				object_count;
+	struct d3dkmthandle	object_array[D3DDDI_MAX_OBJECT_SIGNALED];
+	struct d3dddicb_signalflags	flags;
+	__u32				context_count;
+	struct d3dkmthandle		contexts[D3DDDI_MAX_BROADCAST_CONTEXT];
+	union {
+		struct {
+			__u64		fence_value;
+		} fence;
+		__u64			cpu_event_handle;
+		__u64			reserved[8];
+	};
+};
+
+struct d3dddi_waitforsynchronizationobjectfromcpu_flags {
+	union {
+		struct {
+			__u32			wait_any:1;
+			__u32			reserved:31;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dkmt_waitforsynchronizationobjectfromcpu {
+	struct d3dkmthandle	device;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+	__u64			*fence_values;
+#else
+	__u64			objects;
+	__u64			fence_values;
+#endif
+	__u64			async_event;
+	struct d3dddi_waitforsynchronizationobjectfromcpu_flags flags;
+};
+
+struct d3dkmt_signalsynchronizationobjectfromcpu {
+	struct d3dkmthandle	device;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+	__u64			*fence_values;
+#else
+	__u64			objects;
+	__u64			fence_values;
+#endif
+	struct d3dddicb_signalflags	flags;
+};
+
+struct d3dkmt_waitforsynchronizationobjectfromgpu {
+	struct d3dkmthandle	context;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+#else
+	__u64			objects;
+#endif
+	union {
+#ifdef __KERNEL__
+		__u64		*monitored_fence_values;
+#else
+		__u64		monitored_fence_values;
+#endif
+		__u64		fence_value;
+		__u64		reserved[8];
+	};
+};
+
+struct d3dkmt_signalsynchronizationobjectfromgpu {
+	struct d3dkmthandle	context;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+#else
+	__u64			objects;
+#endif
+	union {
+#ifdef __KERNEL__
+		__u64		*monitored_fence_values;
+#else
+		__u64		monitored_fence_values;
+#endif
+		__u64		reserved[8];
+	};
+};
+
+struct d3dkmt_signalsynchronizationobjectfromgpu2 {
+	__u32				object_count;
+	__u32				reserved1;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*objects;
+#else
+	__u64				objects;
+#endif
+	struct d3dddicb_signalflags	flags;
+	__u32				context_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*contexts;
+#else
+	__u64				contexts;
+#endif
+	union {
+		__u64			fence_value;
+		__u64			cpu_event_handle;
+#ifdef __KERNEL__
+		__u64			*monitored_fence_values;
+#else
+		__u64			monitored_fence_values;
+#endif
+		__u64			reserved[8];
+	};
+};
+
+struct d3dkmt_destroysynchronizationobject {
+	struct d3dkmthandle	sync_object;
+};
+
+struct d3dkmt_opensynchronizationobject {
+	struct d3dkmthandle	shared_handle;
+	struct d3dkmthandle	sync_object;
+	__u64			reserved[8];
+};
+
+struct d3dkmt_submitcommandflags {
+	__u32					null_rendering:1;
+	__u32					present_redirected:1;
+	__u32					reserved:30;
+};
+
+struct d3dkmt_submitcommand {
+	__u64					command_buffer;
+	__u32					command_length;
+	struct d3dkmt_submitcommandflags	flags;
+	__u64					present_history_token;
+	__u32					broadcast_context_count;
+	struct d3dkmthandle	broadcast_context[D3DDDI_MAX_BROADCAST_CONTEXT];
+	__u32					reserved;
+#ifdef __KERNEL__
+	void					*priv_drv_data;
+#else
+	__u64					priv_drv_data;
+#endif
+	__u32					priv_drv_data_size;
+	__u32					num_primaries;
+	struct d3dkmthandle	written_primaries[D3DDDI_MAX_WRITTEN_PRIMARIES];
+	__u32					num_history_buffers;
+	__u32					reserved1;
+#ifdef __KERNEL__
+	struct d3dkmthandle			*history_buffer_array;
+#else
+	__u64					history_buffer_array;
+#endif
+};
+
+struct d3dkmt_submitcommandtohwqueue {
+	struct d3dkmthandle	hwqueue;
+	__u32			reserved;
+	__u64			hwqueue_progress_fence_id;
+	__u64			command_buffer;
+	__u32			command_length;
+	__u32			priv_drv_data_size;
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	__u32			num_primaries;
+	__u32			reserved1;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*written_primaries;
+#else
+	__u64			written_primaries;
+#endif
+};
+
+struct d3dkmt_setcontextschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_setcontextinprocessschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_getcontextschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_getcontextinprocessschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_setallocationpriority {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	const __u32			*priorities;
+#else
+	__u64				priorities;
+#endif
+};
+
+struct d3dkmt_getallocationpriority {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	__u32				*priorities;
+#else
+	__u64				priorities;
+#endif
+};
+
+enum d3dkmt_allocationresidencystatus {
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_RESIDENTINGPUMEMORY		= 1,
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_RESIDENTINSHAREDMEMORY	= 2,
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_NOTRESIDENT			= 3,
+};
+
+struct d3dkmt_queryallocationresidency {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			resource;
+#ifdef __KERNEL__
+	struct d3dkmthandle			*allocations;
+#else
+	__u64					allocations;
+#endif
+	__u32					allocation_count;
+	__u32					reserved;
+#ifdef __KERNEL__
+	enum d3dkmt_allocationresidencystatus	*residency_status;
+#else
+	__u64					residency_status;
+#endif
+};
+
+struct d3dddicb_lock2flags {
+	union {
+		struct {
+			__u32	reserved:32;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_lock2 {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		allocation;
+	struct d3dddicb_lock2flags	flags;
+	__u32				reserved;
+#ifdef __KERNEL__
+	void				*data;
+#else
+	__u64				data;
+#endif
+};
+
+struct d3dkmt_unlock2 {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			allocation;
+};
+
+enum d3dkmt_device_error_reason {
+	_D3DKMT_DEVICE_ERROR_REASON_GENERIC		= 0x80000000,
+	_D3DKMT_DEVICE_ERROR_REASON_DRIVER_ERROR	= 0x80000006,
+};
+
+struct d3dkmt_markdeviceaserror {
+	struct d3dkmthandle			device;
+	enum d3dkmt_device_error_reason		reason;
+};
+
+struct d3dddi_updateallocproperty_flags {
+	union {
+		struct {
+			__u32			accessed_physically:1;
+			__u32			reserved:31;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dddi_segmentpreference {
+	union {
+		struct {
+			__u32			segment_id0:5;
+			__u32			direction0:1;
+			__u32			segment_id1:5;
+			__u32			direction1:1;
+			__u32			segment_id2:5;
+			__u32			direction2:1;
+			__u32			segment_id3:5;
+			__u32			direction3:1;
+			__u32			segment_id4:5;
+			__u32			direction4:1;
+			__u32			reserved:2;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dddi_updateallocproperty {
+	struct d3dkmthandle			paging_queue;
+	struct d3dkmthandle			allocation;
+	__u32					supported_segment_set;
+	struct d3dddi_segmentpreference		preferred_segment;
+	struct d3dddi_updateallocproperty_flags	flags;
+	__u64					paging_fence_value;
+	union {
+		struct {
+			__u32			set_accessed_physically:1;
+			__u32			set_supported_segmentSet:1;
+			__u32			set_preferred_segment:1;
+			__u32			reserved:29;
+		};
+		__u32				property_mask_value;
+	};
+};
+
+enum d3dkmt_offer_priority {
+	_D3DKMT_OFFER_PRIORITY_LOW	= 1,
+	_D3DKMT_OFFER_PRIORITY_NORMAL	= 2,
+	_D3DKMT_OFFER_PRIORITY_HIGH	= 3,
+	_D3DKMT_OFFER_PRIORITY_AUTO	= 4,
+};
+
+struct d3dkmt_offer_flags {
+	union {
+		struct {
+			__u32	offer_immediately:1;
+			__u32	allow_decommit:1;
+			__u32	reserved:30;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_offerallocations {
+	struct d3dkmthandle		device;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*resources;
+	const struct d3dkmthandle	*allocations;
+#else
+	__u64				resources;
+	__u64				allocations;
+#endif
+	__u32				allocation_count;
+	enum d3dkmt_offer_priority	priority;
+	struct d3dkmt_offer_flags	flags;
+	__u32				reserved1;
+};
+
+enum d3dddi_reclaim_result {
+	_D3DDDI_RECLAIM_RESULT_OK		= 0,
+	_D3DDDI_RECLAIM_RESULT_DISCARDED	= 1,
+	_D3DDDI_RECLAIM_RESULT_NOT_COMMITTED	= 2,
+};
+
+struct d3dkmt_reclaimallocations2 {
+	struct d3dkmthandle	paging_queue;
+	__u32			allocation_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*resources;
+	struct d3dkmthandle	*allocations;
+#else
+	__u64			resources;
+	__u64			allocations;
+#endif
+	union {
+#ifdef __KERNEL__
+		__u32				*discarded;
+		enum d3dddi_reclaim_result	*results;
+#else
+		__u64				discarded;
+		__u64				results;
+#endif
+	};
+	__u64			paging_fence_value;
+};
+
+struct d3dkmt_changevideomemoryreservation {
+	__u64			process;
+	struct d3dkmthandle	adapter;
+	enum d3dkmt_memory_segment_group memory_segment_group;
+	__u64			reservation;
+	__u32			physical_adapter_index;
+};
+
+struct d3dkmt_createhwcontext {
+	struct d3dkmthandle	device;
+	__u32			node_ordinal;
+	__u32			engine_affinity;
+	struct d3dddi_createhwcontextflags flags;
+	__u32			priv_drv_data_size;
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	struct d3dkmthandle	context;
+};
+
+struct d3dkmt_destroyhwcontext {
+	struct d3dkmthandle	context;
+};
+
+struct d3dkmt_createhwqueue {
+	struct d3dkmthandle	context;
+	struct d3dddi_createhwqueueflags flags;
+	__u32			priv_drv_data_size;
+	__u32			reserved;
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	struct d3dkmthandle	queue;
+	struct d3dkmthandle	queue_progress_fence;
+#ifdef __KERNEL__
+	void			*queue_progress_fence_cpu_va;
+#else
+	__u64			queue_progress_fence_cpu_va;
+#endif
+	__u64			queue_progress_fence_gpu_va;
+};
+
+struct d3dkmt_destroyhwqueue {
+	struct d3dkmthandle	queue;
+};
+
+struct d3dkmt_submitwaitforsyncobjectstohwqueue {
+	struct d3dkmthandle	hwqueue;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+	__u64			*fence_values;
+#else
+	__u64			objects;
+	__u64			fence_values;
+#endif
+};
+
+struct d3dkmt_submitsignalsyncobjectstohwqueue {
+	struct d3dddicb_signalflags	flags;
+	__u32				hwqueue_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*hwqueues;
+#else
+	__u64				hwqueues;
+#endif
+	__u32				object_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*objects;
+	__u64				*fence_values;
+#else
+	__u64				objects;
+	__u64				fence_values;
+#endif
+};
+
+#pragma pack(push, 1)
+
+struct dxgk_gpuclockdata_flags {
+	union {
+		struct {
+			__u32	context_management_processor:1;
+			__u32	reserved:31;
+		};
+		__u32		value;
+	};
+};
+
+struct dxgk_gpuclockdata {
+	__u64				gpu_frequency;
+	__u64				gpu_clock_counter;
+	__u64				cpu_clock_counter;
+	struct dxgk_gpuclockdata_flags	flags;
+} __packed;
+
+struct d3dkmt_queryclockcalibration {
+	struct d3dkmthandle	adapter;
+	__u32			node_ordinal;
+	__u32			physical_adapter_index;
+	struct dxgk_gpuclockdata clock_data;
+};
+
+#pragma pack(pop)
+
+struct d3dkmt_flushheaptransitions {
+	struct d3dkmthandle	adapter;
+};
+
+struct d3dkmt_getsharedresourceadapterluid {
+	struct d3dkmthandle	global_share;
+	__u64			handle;
+	struct winluid		adapter_luid;
+};
+
+struct d3dkmt_invalidatecache {
+	struct d3dkmthandle	device;
+	struct d3dkmthandle	allocation;
+	__u64			offset;
+	__u64			length;
+};
+
+struct d3dddi_openallocationinfo2 {
+	struct d3dkmthandle	allocation;
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	__u32			priv_drv_data_size;
+	__u64			gpu_va;
+	__u64			reserved[6];
+};
+
+struct d3dkmt_opensyncobjectfromnthandle {
+	__u64			nt_handle;
+	struct d3dkmthandle	sync_object;
+};
+
+struct d3dkmt_opensyncobjectfromnthandle2 {
+	__u64			nt_handle;
+	struct d3dkmthandle	device;
+	struct d3dddi_synchronizationobject_flags flags;
+	struct d3dkmthandle	sync_object;
+	__u32			reserved1;
+	union {
+		struct {
+#ifdef __KERNEL__
+			void	*fence_value_cpu_va;
+#else
+			__u64	fence_value_cpu_va;
+#endif
+			__u64	fence_value_gpu_va;
+			__u32	engine_affinity;
+		} monitored_fence;
+		__u64	reserved[8];
+	};
+};
+
+struct d3dkmt_openresource {
+	struct d3dkmthandle	device;
+	struct d3dkmthandle	global_share;
+	__u32			allocation_count;
+#ifdef __KERNEL__
+	struct d3dddi_openallocationinfo2 *open_alloc_info;
+	void			*private_runtime_data;
+#else
+	__u64			open_alloc_info;
+	__u64			private_runtime_data;
+#endif
+	int			private_runtime_data_size;
+#ifdef __KERNEL__
+	void			*resource_priv_drv_data;
+#else
+	__u64			resource_priv_drv_data;
+#endif
+	__u32			resource_priv_drv_data_size;
+#ifdef __KERNEL__
+	void			*total_priv_drv_data;
+#else
+	__u64			total_priv_drv_data;
+#endif
+	__u32			total_priv_drv_data_size;
+	struct d3dkmthandle	resource;
+};
+
+struct d3dkmt_openresourcefromnthandle {
+	struct d3dkmthandle	device;
+	__u32			reserved;
+	__u64			nt_handle;
+	__u32			allocation_count;
+	__u32			reserved1;
+#ifdef __KERNEL__
+	struct d3dddi_openallocationinfo2 *open_alloc_info;
+#else
+	__u64			open_alloc_info;
+#endif
+	int			private_runtime_data_size;
+	__u32			reserved2;
+#ifdef __KERNEL__
+	void			*private_runtime_data;
+#else
+	__u64			private_runtime_data;
+#endif
+	__u32			resource_priv_drv_data_size;
+	__u32			reserved3;
+#ifdef __KERNEL__
+	void			*resource_priv_drv_data;
+#else
+	__u64			resource_priv_drv_data;
+#endif
+	__u32			total_priv_drv_data_size;
+#ifdef __KERNEL__
+	void			*total_priv_drv_data;
+#else
+	__u64			total_priv_drv_data;
+#endif
+	struct d3dkmthandle	resource;
+	struct d3dkmthandle	keyed_mutex;
+#ifdef __KERNEL__
+	void			*keyed_mutex_private_data;
+#else
+	__u64			keyed_mutex_private_data;
+#endif
+	__u32			keyed_mutex_private_data_size;
+	struct d3dkmthandle	sync_object;
+};
+
+struct d3dkmt_queryresourceinfofromnthandle {
+	struct d3dkmthandle	device;
+	__u32			reserved;
+	__u64			nt_handle;
+#ifdef __KERNEL__
+	void			*private_runtime_data;
+#else
+	__u64			private_runtime_data;
+#endif
+	__u32			private_runtime_data_size;
+	__u32			total_priv_drv_data_size;
+	__u32			resource_priv_drv_data_size;
+	__u32			allocation_count;
+};
+
+struct d3dkmt_queryresourceinfo {
+	struct d3dkmthandle	device;
+	struct d3dkmthandle	global_share;
+#ifdef __KERNEL__
+	void			*private_runtime_data;
+#else
+	__u64			private_runtime_data;
+#endif
+	__u32			private_runtime_data_size;
+	__u32			total_priv_drv_data_size;
+	__u32			resource_priv_drv_data_size;
+	__u32			allocation_count;
+};
+
+struct d3dkmt_shareobjects {
+	__u32			object_count;
+	__u32			reserved;
+#ifdef __KERNEL__
+	const struct d3dkmthandle *objects;
+	void			*object_attr;	/* security attributes */
+#else
+	__u64			objects;
+	__u64			object_attr;
+#endif
+	__u32			desired_access;
+	__u32			reserved1;
+#ifdef __KERNEL__
+	__u64			*shared_handle;	/* output file descriptors */
+#else
+	__u64			shared_handle;
+#endif
+};
+
+union d3dkmt_enumadapters_filter {
+	struct {
+		__u64	include_compute_only:1;
+		__u64	include_display_only:1;
+		__u64	reserved:62;
+	};
+	__u64		value;
+};
+
+struct d3dkmt_enumadapters3 {
+	union d3dkmt_enumadapters_filter	filter;
+	__u32					adapter_count;
+	__u32					reserved;
+#ifdef __KERNEL__
+	struct d3dkmt_adapterinfo		*adapters;
+#else
+	__u64					adapters;
+#endif
+};
+
+enum d3dkmt_querystatistics_type {
+	_D3DKMT_QUERYSTATISTICS_ADAPTER                = 0,
+	_D3DKMT_QUERYSTATISTICS_PROCESS                = 1,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_ADAPTER        = 2,
+	_D3DKMT_QUERYSTATISTICS_SEGMENT                = 3,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_SEGMENT        = 4,
+	_D3DKMT_QUERYSTATISTICS_NODE                   = 5,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_NODE           = 6,
+	_D3DKMT_QUERYSTATISTICS_VIDPNSOURCE            = 7,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_VIDPNSOURCE    = 8,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_SEGMENT_GROUP  = 9,
+	_D3DKMT_QUERYSTATISTICS_PHYSICAL_ADAPTER       = 10,
+};
+
+struct d3dkmt_querystatistics_result {
+	char size[0x308];
+};
+
+struct d3dkmt_querystatistics {
+	union {
+		struct {
+			enum d3dkmt_querystatistics_type	type;
+			struct winluid				adapter_luid;
+			__u64					process;
+			struct d3dkmt_querystatistics_result	result;
+		};
+		char size[0x328];
+	};
+};
+
+struct d3dkmt_shareobjectwithhost {
+	struct d3dkmthandle	device_handle;
+	struct d3dkmthandle	object_handle;
+	__u64			reserved;
+	__u64			object_vail_nt_handle;
+};
+
+/*
+ * Dxgkrnl Graphics Port Driver ioctl definitions
+ *
+ */
+
+#define LX_DXOPENADAPTERFROMLUID	\
+	_IOWR(0x47, 0x01, struct d3dkmt_openadapterfromluid)
+#define LX_DXCREATEDEVICE		\
+	_IOWR(0x47, 0x02, struct d3dkmt_createdevice)
+#define LX_DXCREATECONTEXT		\
+	_IOWR(0x47, 0x03, struct d3dkmt_createcontext)
+#define LX_DXCREATECONTEXTVIRTUAL	\
+	_IOWR(0x47, 0x04, struct d3dkmt_createcontextvirtual)
+#define LX_DXDESTROYCONTEXT		\
+	_IOWR(0x47, 0x05, struct d3dkmt_destroycontext)
+#define LX_DXCREATEALLOCATION		\
+	_IOWR(0x47, 0x06, struct d3dkmt_createallocation)
+#define LX_DXCREATEPAGINGQUEUE		\
+	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
+#define LX_DXRESERVEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x08, struct d3dddi_reservegpuvirtualaddress)
+#define LX_DXQUERYADAPTERINFO		\
+	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXQUERYVIDEOMEMORYINFO	\
+	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
+#define LX_DXMAKERESIDENT		\
+	_IOWR(0x47, 0x0b, struct d3dddi_makeresident)
+#define LX_DXMAPGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x0c, struct d3dddi_mapgpuvirtualaddress)
+#define LX_DXESCAPE			\
+	_IOWR(0x47, 0x0d, struct d3dkmt_escape)
+#define LX_DXGETDEVICESTATE		\
+	_IOWR(0x47, 0x0e, struct d3dkmt_getdevicestate)
+#define LX_DXSUBMITCOMMAND		\
+	_IOWR(0x47, 0x0f, struct d3dkmt_submitcommand)
+#define LX_DXCREATESYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x10, struct d3dkmt_createsynchronizationobject2)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x11, struct d3dkmt_signalsynchronizationobject2)
+#define LX_DXWAITFORSYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x12, struct d3dkmt_waitforsynchronizationobject2)
+#define LX_DXDESTROYALLOCATION2		\
+	_IOWR(0x47, 0x13, struct d3dkmt_destroyallocation2)
+#define LX_DXENUMADAPTERS2		\
+	_IOWR(0x47, 0x14, struct d3dkmt_enumadapters2)
+#define LX_DXCLOSEADAPTER		\
+	_IOWR(0x47, 0x15, struct d3dkmt_closeadapter)
+#define LX_DXCHANGEVIDEOMEMORYRESERVATION \
+	_IOWR(0x47, 0x16, struct d3dkmt_changevideomemoryreservation)
+#define LX_DXCREATEHWCONTEXT		\
+	_IOWR(0x47, 0x17, struct d3dkmt_createhwcontext)
+#define LX_DXCREATEHWQUEUE		\
+	_IOWR(0x47, 0x18, struct d3dkmt_createhwqueue)
+#define LX_DXDESTROYDEVICE		\
+	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
+#define LX_DXDESTROYHWCONTEXT		\
+	_IOWR(0x47, 0x1a, struct d3dkmt_destroyhwcontext)
+#define LX_DXDESTROYHWQUEUE		\
+	_IOWR(0x47, 0x1b, struct d3dkmt_destroyhwqueue)
+#define LX_DXDESTROYPAGINGQUEUE		\
+	_IOWR(0x47, 0x1c, struct d3dddi_destroypagingqueue)
+#define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
+#define LX_DXEVICT			\
+	_IOWR(0x47, 0x1e, struct d3dkmt_evict)
+#define LX_DXFLUSHHEAPTRANSITIONS	\
+	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
+#define LX_DXFREEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x20, struct d3dkmt_freegpuvirtualaddress)
+#define LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x21, struct d3dkmt_getcontextinprocessschedulingpriority)
+#define LX_DXGETCONTEXTSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x22, struct d3dkmt_getcontextschedulingpriority)
+#define LX_DXGETSHAREDRESOURCEADAPTERLUID \
+	_IOWR(0x47, 0x23, struct d3dkmt_getsharedresourceadapterluid)
+#define LX_DXINVALIDATECACHE		\
+	_IOWR(0x47, 0x24, struct d3dkmt_invalidatecache)
+#define LX_DXLOCK2			\
+	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
+#define LX_DXMARKDEVICEASERROR		\
+	_IOWR(0x47, 0x26, struct d3dkmt_markdeviceaserror)
+#define LX_DXOFFERALLOCATIONS		\
+	_IOWR(0x47, 0x27, struct d3dkmt_offerallocations)
+#define LX_DXOPENRESOURCE		\
+	_IOWR(0x47, 0x28, struct d3dkmt_openresource)
+#define LX_DXOPENSYNCHRONIZATIONOBJECT	\
+	_IOWR(0x47, 0x29, struct d3dkmt_opensynchronizationobject)
+#define LX_DXQUERYALLOCATIONRESIDENCY	\
+	_IOWR(0x47, 0x2a, struct d3dkmt_queryallocationresidency)
+#define LX_DXQUERYRESOURCEINFO		\
+	_IOWR(0x47, 0x2b, struct d3dkmt_queryresourceinfo)
+#define LX_DXRECLAIMALLOCATIONS2	\
+	_IOWR(0x47, 0x2c, struct d3dkmt_reclaimallocations2)
+#define LX_DXRENDER			\
+	_IOWR(0x47, 0x2d, struct d3dkmt_render)
+#define LX_DXSETALLOCATIONPRIORITY	\
+	_IOWR(0x47, 0x2e, struct d3dkmt_setallocationpriority)
+#define LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x2f, struct d3dkmt_setcontextinprocessschedulingpriority)
+#define LX_DXSETCONTEXTSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x30, struct d3dkmt_setcontextschedulingpriority)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
+	_IOWR(0x47, 0x31, struct d3dkmt_signalsynchronizationobjectfromcpu)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU \
+	_IOWR(0x47, 0x32, struct d3dkmt_signalsynchronizationobjectfromgpu)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2 \
+	_IOWR(0x47, 0x33, struct d3dkmt_signalsynchronizationobjectfromgpu2)
+#define LX_DXSUBMITCOMMANDTOHWQUEUE	\
+	_IOWR(0x47, 0x34, struct d3dkmt_submitcommandtohwqueue)
+#define LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE \
+	_IOWR(0x47, 0x35, struct d3dkmt_submitsignalsyncobjectstohwqueue)
+#define LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE \
+	_IOWR(0x47, 0x36, struct d3dkmt_submitwaitforsyncobjectstohwqueue)
+#define LX_DXUNLOCK2			\
+	_IOWR(0x47, 0x37, struct d3dkmt_unlock2)
+#define LX_DXUPDATEALLOCPROPERTY	\
+	_IOWR(0x47, 0x38, struct d3dddi_updateallocproperty)
+#define LX_DXUPDATEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x39, struct d3dkmt_updategpuvirtualaddress)
+#define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
+	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
+#define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \
+	_IOWR(0x47, 0x3b, struct d3dkmt_waitforsynchronizationobjectfromgpu)
+#define LX_DXGETALLOCATIONPRIORITY	\
+	_IOWR(0x47, 0x3c, struct d3dkmt_getallocationpriority)
+#define LX_DXQUERYCLOCKCALIBRATION	\
+	_IOWR(0x47, 0x3d, struct d3dkmt_queryclockcalibration)
+#define LX_DXENUMADAPTERS3		\
+	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
+#define LX_DXSHAREOBJECTS		\
+	_IOWR(0x47, 0x3f, struct d3dkmt_shareobjects)
+#define LX_DXOPENSYNCOBJECTFROMNTHANDLE2 \
+	_IOWR(0x47, 0x40, struct d3dkmt_opensyncobjectfromnthandle2)
+#define LX_DXQUERYRESOURCEINFOFROMNTHANDLE \
+	_IOWR(0x47, 0x41, struct d3dkmt_queryresourceinfofromnthandle)
+#define LX_DXOPENRESOURCEFROMNTHANDLE	\
+	_IOWR(0x47, 0x42, struct d3dkmt_openresourcefromnthandle)
+#define LX_DXQUERYSTATISTICS	\
+	_IOWR(0x47, 0x43, struct d3dkmt_querystatistics)
+#define LX_DXSHAREOBJECTWITHHOST	\
+	_IOWR(0x47, 0x44, struct d3dkmt_shareobjectwithhost)
+
+#define LX_IO_MAX 0x45
+
+#endif /* _D3DKMTHK_H */
-- 
2.35.1

