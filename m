Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B84679B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381598AbhLCOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381558AbhLCOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:50:18 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C059C0698C5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:46:50 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id r199-20020a6b2bd0000000b005e234972ddfso2388559ior.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GkLWwamCLpeu755q7ahqpZmgGU2lUT+JeuNBLp8zyBc=;
        b=Xi8QyKx6s/gGK72hkYf9vgJYCLbypIxWU+OPYoteOcPJbqNxy8NRpx5PUIHi1PdSRN
         Tl9N0fZnIOBogMo/Gjjzw6Z/612XvGxhRzYtuN4FyRIuoevamGd2OpkSY1Rw4B5sVjSh
         ulu5Zt65DNM6rPzmTGbcCJN/jV9rAduPJVZnBw5+31eX+dHcdxcTwSnHlR1h3qEDz4VG
         mq8pFZzelTYxBn47km5ngJ/uXR84h+UdLDwZylI324GDzWgkqATjIcp3MI2usMId5zNN
         yJu0rlgGEo5DnsqqE25docVICX8eHRHUrjLkYEOPvBlluppNVYaYoU5aVK87t1pxPxGa
         qt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GkLWwamCLpeu755q7ahqpZmgGU2lUT+JeuNBLp8zyBc=;
        b=SGS/vrhWKl8eB/dl2x75u28JUhNwf4WjDomxDCNNwxHbR8YvqBZ2fT9UeGE90Wgx8d
         e3JOJ17RJSm4xPhoqaMUI0XCn0QAbtjcaq2dDqUsO9vJnhU4x24WEP5KgX63CEfAcoNX
         Jfn/N9V4jg/q2RrBR+CNnCmMJ65e7czzrfVbdC7osbdAvngBL07Xz40/nZkUzQyDQm7C
         CF2TuP29Nt+trAtD666cUODmgQKNITolWmf39DZNInRd8N/LR3wEPM/BijmGBC9VxFZY
         KgCmcC48pDiqxT/OyIMBDQMhb18lfIVjDSfvVIx7woyBiLkdbwd7mCHcMfgZi02iBm+O
         Xgtw==
X-Gm-Message-State: AOAM530GiWxYBMz52sR7pMPmS7P0u7np7H0DFyejhdrOA+lx8pZlzVoX
        6CYxDO/Tb/fy0pEY+HkMORuX/dCXPJk=
X-Google-Smtp-Source: ABdhPJx5WTDXaVAellERAYEDARwYdEGCZNUyvhCxri6/aOCC7bjMfEtiPljPp8/1Pr2YsvnHj8oBSGaqsLE=
X-Received: from pgonda2.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:ac9])
 (user=pgonda job=sendgmr) by 2002:a6b:2ccf:: with SMTP id s198mr19254886ios.101.1638542809577;
 Fri, 03 Dec 2021 06:46:49 -0800 (PST)
Date:   Fri,  3 Dec 2021 14:46:42 +0000
In-Reply-To: <20211203144642.3460447-1-pgonda@google.com>
Message-Id: <20211203144642.3460447-6-pgonda@google.com>
Mime-Version: 1.0
References: <20211203144642.3460447-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH V5 5/5] crypto: ccp - Add SEV_INIT_EX support
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     David Rientjes <rientjes@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>

Add new module parameter to allow users to use SEV_INIT_EX instead of
SEV_INIT. This helps users who lock their SPI bus to use the PSP for SEV
functionality. The 'init_ex_path' parameter defaults to NULL which means
the kernel will use SEV_INIT, if a path is specified SEV_INIT_EX will be
used with the data found at the path. On certain PSP commands this
file is written to as the PSP updates the NV memory region. Depending on
file system initialization this file open may fail during module init
but the CCP driver for SEV already has sufficient retries for platform
initialization. During normal operation of PSP system and SEV commands
if the PSP has not been initialized it is at run time. If the file at
'init_ex_path' does not exist the PSP will not be initialized. The user
must create the file prior to use with 32Kb of 0xFFs per spec.

Signed-off-by: David Rientjes <rientjes@google.com>
Co-developed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../virt/kvm/amd-memory-encryption.rst        |   6 +
 drivers/crypto/ccp/sev-dev.c                  | 193 ++++++++++++++++--
 include/linux/psp-sev.h                       |  21 ++
 3 files changed, 205 insertions(+), 15 deletions(-)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 5c081c8c7164..1c6847fff304 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -85,6 +85,12 @@ guests, such as launching, running, snapshotting, migrating and decommissioning.
 The KVM_SEV_INIT command is used by the hypervisor to initialize the SEV platform
 context. In a typical workflow, this command should be the first command issued.
 
+The firmware can be initialized either by using its own non-volatile storage or
+the OS can manage the NV storage for the firmware using the module parameter
+``init_ex_path``. The file specified by ``init_ex_path`` must exist. To create
+a new NV storage file allocate the file with 32KB bytes of 0xFF as required by
+the SEV spec.
+
 Returns: 0 on success, -negative on error
 
 2. KVM_SEV_LAUNCH_START
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ab3752799011..d0d5962fa6aa 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -22,6 +22,7 @@
 #include <linux/firmware.h>
 #include <linux/gfp.h>
 #include <linux/cpufeature.h>
+#include <linux/fs.h>
 
 #include <asm/smp.h>
 
@@ -43,6 +44,10 @@ static int psp_probe_timeout = 5;
 module_param(psp_probe_timeout, int, 0644);
 MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during PSP device probe");
 
+static char *init_ex_path;
+module_param(init_ex_path, charp, 0444);
+MODULE_PARM_DESC(init_ex_path, " Path for INIT_EX data; if set try INIT_EX");
+
 static bool psp_init_on_probe = true;
 module_param(psp_init_on_probe, bool, 0444);
 MODULE_PARM_DESC(psp_init_on_probe, "  if true, the PSP will be initialized on module init. Else the PSP will be initialized on the first command requiring it");
@@ -62,6 +67,14 @@ static int psp_timeout;
 #define SEV_ES_TMR_SIZE		(1024 * 1024)
 static void *sev_es_tmr;
 
+/* INIT_EX NV Storage:
+ *   The NV Storage is a 32Kb area and must be 4Kb page aligned.  Use the page
+ *   allocator to allocate the memory, which will return aligned memory for the
+ *   specified allocation order.
+ */
+#define NV_LENGTH (32 * 1024)
+static void *sev_init_ex_buffer;
+
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -111,6 +124,7 @@ static int sev_cmd_buffer_len(int cmd)
 {
 	switch (cmd) {
 	case SEV_CMD_INIT:			return sizeof(struct sev_data_init);
+	case SEV_CMD_INIT_EX:                   return sizeof(struct sev_data_init_ex);
 	case SEV_CMD_PLATFORM_STATUS:		return sizeof(struct sev_user_data_status);
 	case SEV_CMD_PEK_CSR:			return sizeof(struct sev_data_pek_csr);
 	case SEV_CMD_PEK_CERT_IMPORT:		return sizeof(struct sev_data_pek_cert_import);
@@ -156,6 +170,101 @@ static void *sev_fw_alloc(unsigned long len)
 	return page_address(page);
 }
 
+static int sev_read_init_ex_file(void)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct file *fp;
+	ssize_t nread;
+
+	lockdep_assert_held(sev_cmd_mutex);
+
+	if (!sev_init_ex_buffer)
+		return -EOPNOTSUPP;
+
+	fp = filp_open(init_ex_path, O_RDONLY, 0);
+	if (IS_ERR(fp)) {
+		int ret = PTR_ERR(fp);
+
+		dev_err(sev->dev,
+			"SEV: could not open %s for read, error %d\n",
+			init_ex_path, ret);
+		return ret;
+	}
+
+	nread = kernel_read(fp, sev_init_ex_buffer, NV_LENGTH, NULL);
+	if (nread != NV_LENGTH) {
+		dev_err(sev->dev,
+			"SEV: failed to read %u bytes to non volatile memory area, ret %ld\n",
+			NV_LENGTH, nread);
+		return -EIO;
+	}
+
+	dev_dbg(sev->dev, "SEV: read %ld bytes from NV file\n", nread);
+	filp_close(fp, NULL);
+
+	return 0;
+}
+
+static void sev_write_init_ex_file(void)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct file *fp;
+	loff_t offset = 0;
+	ssize_t nwrite;
+
+	lockdep_assert_held(sev_cmd_mutex);
+
+	if (!sev_init_ex_buffer)
+		return;
+
+	fp = filp_open(init_ex_path, O_CREAT | O_WRONLY, 0600);
+	if (IS_ERR(fp)) {
+		dev_err(sev->dev,
+			"SEV: could not open file for write, error %d\n",
+			PTR_ERR(fp));
+		return;
+	}
+
+	nwrite = kernel_write(fp, sev_init_ex_buffer, NV_LENGTH, &offset);
+	vfs_fsync(fp, 0);
+	filp_close(fp, NULL);
+
+	if (nwrite != NV_LENGTH) {
+		dev_err(sev->dev,
+			"SEV: failed to write %u bytes to non volatile memory area, ret %ld\n",
+			NV_LENGTH, nwrite);
+		return;
+	}
+
+	dev_dbg(sev->dev, "SEV: write successful to NV file\n");
+}
+
+static void sev_write_init_ex_file_if_required(int cmd_id)
+{
+	lockdep_assert_held(sev_cmd_mutex);
+
+	if (!sev_init_ex_buffer)
+		return;
+
+	/*
+	 * Only a few platform commands modify the SPI/NV area, but none of the
+	 * non-platform commands do. Only INIT(_EX), PLATFORM_RESET, PEK_GEN,
+	 * PEK_CERT_IMPORT, and PDH_GEN do.
+	 */
+	switch (cmd_id) {
+	case SEV_CMD_FACTORY_RESET:
+	case SEV_CMD_INIT_EX:
+	case SEV_CMD_PDH_GEN:
+	case SEV_CMD_PEK_CERT_IMPORT:
+	case SEV_CMD_PEK_GEN:
+		break;
+	default:
+		return;
+	};
+
+	sev_write_init_ex_file();
+}
+
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
@@ -225,6 +334,8 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 		dev_dbg(sev->dev, "sev command %#x failed (%#010x)\n",
 			cmd, reg & PSP_CMDRESP_ERR_MASK);
 		ret = -EIO;
+	} else {
+		sev_write_init_ex_file_if_required(cmd);
 	}
 
 	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
@@ -251,37 +362,71 @@ static int sev_do_cmd(int cmd, void *data, int *psp_ret)
 	return rc;
 }
 
-static int __sev_platform_init_locked(int *error)
+static int __sev_init_locked(int *error)
 {
-	struct psp_device *psp = psp_master;
 	struct sev_data_init data;
-	struct sev_device *sev;
-	int psp_ret, rc = 0;
 
-	if (!psp || !psp->sev_data)
-		return -ENODEV;
+	memset(&data, 0, sizeof(data));
+	if (sev_es_tmr) {
+		/*
+		 * Do not include the encryption mask on the physical
+		 * address of the TMR (firmware should clear it anyway).
+		 */
+		data.tmr_address = __pa(sev_es_tmr);
 
-	sev = psp->sev_data;
+		data.flags |= SEV_INIT_FLAGS_SEV_ES;
+		data.tmr_len = SEV_ES_TMR_SIZE;
+	}
 
-	if (sev->state == SEV_STATE_INIT)
-		return 0;
+	return __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
+}
+
+static int __sev_init_ex_locked(int *error)
+{
+	struct sev_data_init_ex data;
+	int ret;
 
 	memset(&data, 0, sizeof(data));
-	if (sev_es_tmr) {
-		u64 tmr_pa;
+	data.length = sizeof(data);
+	data.nv_address = __psp_pa(sev_init_ex_buffer);
+	data.nv_len = NV_LENGTH;
+
+	ret = sev_read_init_ex_file();
+	if (ret)
+		return ret;
 
+	if (sev_es_tmr) {
 		/*
 		 * Do not include the encryption mask on the physical
 		 * address of the TMR (firmware should clear it anyway).
 		 */
-		tmr_pa = __pa(sev_es_tmr);
+		data.tmr_address = __pa(sev_es_tmr);
 
 		data.flags |= SEV_INIT_FLAGS_SEV_ES;
-		data.tmr_address = tmr_pa;
 		data.tmr_len = SEV_ES_TMR_SIZE;
 	}
 
-	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, &psp_ret);
+	return __sev_do_cmd_locked(SEV_CMD_INIT_EX, &data, error);
+}
+
+static int __sev_platform_init_locked(int *error)
+{
+	struct psp_device *psp = psp_master;
+	struct sev_device *sev;
+	int rc, psp_ret;
+	int (*init_function)(int *error);
+
+	if (!psp || !psp->sev_data)
+		return -ENODEV;
+
+	sev = psp->sev_data;
+
+	if (sev->state == SEV_STATE_INIT)
+		return 0;
+
+	init_function = sev_init_ex_buffer ? __sev_init_ex_locked :
+			__sev_init_locked;
+	rc = init_function(&psp_ret);
 	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
 		/*
 		 * Initialization command returned an integrity check failure
@@ -291,7 +436,7 @@ static int __sev_platform_init_locked(int *error)
 		 * with a reset state.
 		 */
 		dev_dbg(sev->dev, "SEV: retrying INIT command");
-		rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, &psp_ret);
+		rc = init_function(&psp_ret);
 	}
 	if (error)
 		*error = psp_ret;
@@ -1066,6 +1211,12 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 			   get_order(SEV_ES_TMR_SIZE));
 		sev_es_tmr = NULL;
 	}
+
+	if (sev_init_ex_buffer) {
+		free_pages((unsigned long)sev_init_ex_buffer,
+			   get_order(NV_LENGTH));
+		sev_init_ex_buffer = NULL;
+	}
 }
 
 void sev_dev_destroy(struct psp_device *psp)
@@ -1111,6 +1262,18 @@ void sev_pci_init(void)
 	    sev_update_firmware(sev->dev) == 0)
 		sev_get_api_version();
 
+	/* If an init_ex_path is provided rely on INIT_EX for PSP initialization
+	 * instead of INIT.
+	 */
+	if (init_ex_path) {
+		sev_init_ex_buffer = sev_fw_alloc(NV_LENGTH);
+		if (!sev_init_ex_buffer) {
+			dev_err(sev->dev,
+				"SEV: INIT_EX NV memory allocation failed\n");
+			goto err;
+		}
+	}
+
 	/* Obtain the TMR memory area for SEV-ES use */
 	sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
 	if (!sev_es_tmr)
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index d48a7192e881..1595088c428b 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -52,6 +52,7 @@ enum sev_cmd {
 	SEV_CMD_DF_FLUSH		= 0x00A,
 	SEV_CMD_DOWNLOAD_FIRMWARE	= 0x00B,
 	SEV_CMD_GET_ID			= 0x00C,
+	SEV_CMD_INIT_EX                 = 0x00D,
 
 	/* Guest commands */
 	SEV_CMD_DECOMMISSION		= 0x020,
@@ -102,6 +103,26 @@ struct sev_data_init {
 	u32 tmr_len;			/* In */
 } __packed;
 
+/**
+ * struct sev_data_init_ex - INIT_EX command parameters
+ *
+ * @length: len of the command buffer read by the PSP
+ * @flags: processing flags
+ * @tmr_address: system physical address used for SEV-ES
+ * @tmr_len: len of tmr_address
+ * @nv_address: system physical address used for PSP NV storage
+ * @nv_len: len of nv_address
+ */
+struct sev_data_init_ex {
+	u32 length;                     /* In */
+	u32 flags;                      /* In */
+	u64 tmr_address;                /* In */
+	u32 tmr_len;                    /* In */
+	u32 reserved;                   /* In */
+	u64 nv_address;                 /* In/Out */
+	u32 nv_len;                     /* In */
+} __packed;
+
 #define SEV_INIT_FLAGS_SEV_ES	0x01
 
 /**
-- 
2.34.0.384.gca35af8252-goog

