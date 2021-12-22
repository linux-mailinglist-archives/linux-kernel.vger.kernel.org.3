Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9745047D724
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbhLVSss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:48:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbhLVSsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:48:42 -0500
Date:   Wed, 22 Dec 2021 18:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640198921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ektKpjNzoJvn745jebVJ8h6y1qLtHh8tHQdeksxQ2oQ=;
        b=Y9keVkznmx75qTnHR1SEVIDdvcd1xB5XFHWzYfueJ3v9wiMTPTplRFNa/T9umeM3G/3Qdo
        kBd+8c5lKkwtczyv8845w4jZs7tXw1H65IsBcwCnlQO0tbIj6TYwkBKAsjrMNu6GeG48j9
        4tM+yLf4zspsDNuqkD3xcY39WI6iJuPRGtw4Vyaco9nVmqlZbY69t5cwAxCi5oPtmMg9Yx
        uT+JXAN7buFV7RJZUPuTfLY04xQ1KXln4svh4jHfZXN6VQ0Y1CaNlrjwkwSSHC7quXAPlU
        1KoOzzg7NTq4gzaFhY3nGoS7kJ+xFqXqLatxqi/ftiNPX7Jk3RFi2DddFhHCig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640198921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ektKpjNzoJvn745jebVJ8h6y1qLtHh8tHQdeksxQ2oQ=;
        b=GzhzzncVTosr+DSkq8mcSy760860MqYzjypM5gLpRII+qeRYrZJnNZAJwT0ew1vbyLu3dO
        7g8cA91FXW42j7AQ==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211216162905.4132657-2-yazen.ghannam@amd.com>
References: <20211216162905.4132657-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <164019891996.16921.9739943959210067880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     5176a93ab27aef1b9f4496fc68e6c303a011d7cc
Gitweb:        https://git.kernel.org/tip/5176a93ab27aef1b9f4496fc68e6c303a011d7cc
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 16 Dec 2021 16:29:04 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Dec 2021 17:19:18 +01:00

x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types

Add HWID and McaType values for new SMCA bank types, and add their error
descriptions to edac_mce_amd.

The "PHY" bank types all have the same error descriptions, and the NBIF
and SHUB bank types have the same error descriptions. So reuse the same
arrays where appropriate.

  [ bp: Remove useless comments over hwid types. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211216162905.4132657-2-yazen.ghannam@amd.com
---
 arch/x86/include/asm/mce.h    |   7 ++-
 arch/x86/kernel/cpu/mce/amd.c |  21 +++--
 drivers/edac/mce_amd.c        | 135 +++++++++++++++++++++++++++++++--
 3 files changed, 151 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index d58f4f2..52d2b35 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -313,12 +313,19 @@ enum smca_bank_types {
 	SMCA_SMU,	/* System Management Unit */
 	SMCA_SMU_V2,
 	SMCA_MP5,	/* Microprocessor 5 Unit */
+	SMCA_MPDMA,	/* MPDMA Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
 	SMCA_PCIE_V2,
 	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
+	SMCA_NBIF,	/* NBIF Unit */
+	SMCA_SHUB,	/* System HUB Unit */
+	SMCA_SATA,	/* SATA Unit */
+	SMCA_USB,	/* USB Unit */
+	SMCA_GMI_PCS,	/* GMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
+	SMCA_GMI_PHY,	/* GMI PHY Unit */
 	N_SMCA_BANK_TYPES
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2f35183..9407cdc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -95,11 +95,18 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
 	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
 	[SMCA_MP5]			= { "mp5",		"Microprocessor 5 Unit" },
+	[SMCA_MPDMA]			= { "mpdma",		"MPDMA Unit" },
 	[SMCA_NBIO]			= { "nbio",		"Northbridge IO Unit" },
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= { "pcie",		"PCI Express Unit" },
 	[SMCA_XGMI_PCS]			= { "xgmi_pcs",		"Ext Global Memory Interconnect PCS Unit" },
+	[SMCA_NBIF]			= { "nbif",		"NBIF Unit" },
+	[SMCA_SHUB]			= { "shub",		"System Hub Unit" },
+	[SMCA_SATA]			= { "sata",		"SATA Unit" },
+	[SMCA_USB]			= { "usb",		"USB Unit" },
+	[SMCA_GMI_PCS]			= { "gmi_pcs",		"Global Memory Interconnect PCS Unit" },
 	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
 	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
+	[SMCA_GMI_PHY]			= { "gmi_phy",		"Global Memory Interconnect PHY Unit" },
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -174,6 +181,9 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* Microprocessor 5 Unit MCA type */
 	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2)	},
 
+	/* MPDMA MCA type */
+	{ SMCA_MPDMA,	 HWID_MCATYPE(0x01, 0x3)	},
+
 	/* Northbridge IO Unit MCA type */
 	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0)	},
 
@@ -181,14 +191,15 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0)	},
 	{ SMCA_PCIE_V2,	 HWID_MCATYPE(0x46, 0x1)	},
 
-	/* xGMI PCS MCA type */
 	{ SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)	},
-
-	/* xGMI PHY MCA type */
+	{ SMCA_NBIF,	 HWID_MCATYPE(0x6C, 0x0)	},
+	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
+	{ SMCA_SATA,	 HWID_MCATYPE(0xA8, 0x0)	},
+	{ SMCA_USB,	 HWID_MCATYPE(0xAA, 0x0)	},
+	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
-
-	/* WAFL PHY MCA type */
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
+	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 67dbf4c..cfd3f7a 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -399,6 +399,63 @@ static const char * const smca_mp5_mce_desc[] = {
 	"Instruction Tag Cache Bank B ECC or parity error",
 };
 
+static const char * const smca_mpdma_mce_desc[] = {
+	"Main SRAM [31:0] bank ECC or parity error",
+	"Main SRAM [63:32] bank ECC or parity error",
+	"Main SRAM [95:64] bank ECC or parity error",
+	"Main SRAM [127:96] bank ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"System Hub Read Buffer ECC or parity error",
+	"MPDMA TVF DVSEC Memory ECC or parity error",
+	"MPDMA TVF MMIO Mailbox0 ECC or parity error",
+	"MPDMA TVF MMIO Mailbox1 ECC or parity error",
+	"MPDMA TVF Doorbell Memory ECC or parity error",
+	"MPDMA TVF SDP Slave Memory 0 ECC or parity error",
+	"MPDMA TVF SDP Slave Memory 1 ECC or parity error",
+	"MPDMA TVF SDP Slave Memory 2 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 0 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 1 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 2 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 3 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 4 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 5 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 6 ECC or parity error",
+	"MPDMA PTE Command FIFO ECC or parity error",
+	"MPDMA PTE Hub Data FIFO ECC or parity error",
+	"MPDMA PTE Internal Data FIFO ECC or parity error",
+	"MPDMA PTE Command Memory DMA ECC or parity error",
+	"MPDMA PTE Command Memory Internal ECC or parity error",
+	"MPDMA PTE DMA Completion FIFO ECC or parity error",
+	"MPDMA PTE Tablewalk Completion FIFO ECC or parity error",
+	"MPDMA PTE Descriptor Completion FIFO ECC or parity error",
+	"MPDMA PTE ReadOnly Completion FIFO ECC or parity error",
+	"MPDMA PTE DirectWrite Completion FIFO ECC or parity error",
+	"SDP Watchdog Timer expired",
+};
+
 static const char * const smca_nbio_mce_desc[] = {
 	"ECC or Parity error",
 	"PCIE error",
@@ -448,7 +505,7 @@ static const char * const smca_xgmipcs_mce_desc[] = {
 	"Rx Replay Timeout Error",
 	"LinkSub Tx Timeout Error",
 	"LinkSub Rx Timeout Error",
-	"Rx CMD Pocket Error",
+	"Rx CMD Packet Error",
 };
 
 static const char * const smca_xgmiphy_mce_desc[] = {
@@ -458,11 +515,66 @@ static const char * const smca_xgmiphy_mce_desc[] = {
 	"PHY APB error",
 };
 
-static const char * const smca_waflphy_mce_desc[] = {
-	"RAM ECC Error",
-	"ARC instruction buffer parity error",
-	"ARC data buffer parity error",
-	"PHY APB error",
+static const char * const smca_nbif_mce_desc[] = {
+	"Timeout error from GMI",
+	"SRAM ECC error",
+	"NTB Error Event",
+	"SDP Parity error",
+};
+
+static const char * const smca_sata_mce_desc[] = {
+	"Parity error for port 0",
+	"Parity error for port 1",
+	"Parity error for port 2",
+	"Parity error for port 3",
+	"Parity error for port 4",
+	"Parity error for port 5",
+	"Parity error for port 6",
+	"Parity error for port 7",
+};
+
+static const char * const smca_usb_mce_desc[] = {
+	"Parity error or ECC error for S0 RAM0",
+	"Parity error or ECC error for S0 RAM1",
+	"Parity error or ECC error for S0 RAM2",
+	"Parity error for PHY RAM0",
+	"Parity error for PHY RAM1",
+	"AXI Slave Response error",
+};
+
+static const char * const smca_gmipcs_mce_desc[] = {
+	"Data Loss Error",
+	"Training Error",
+	"Replay Parity Error",
+	"Rx Fifo Underflow Error",
+	"Rx Fifo Overflow Error",
+	"CRC Error",
+	"BER Exceeded Error",
+	"Tx Fifo Underflow Error",
+	"Replay Buffer Parity Error",
+	"Tx Overflow Error",
+	"Replay Fifo Overflow Error",
+	"Replay Fifo Underflow Error",
+	"Elastic Fifo Overflow Error",
+	"Deskew Error",
+	"Offline Error",
+	"Data Startup Limit Error",
+	"FC Init Timeout Error",
+	"Recovery Timeout Error",
+	"Ready Serial Timeout Error",
+	"Ready Serial Attempt Error",
+	"Recovery Attempt Error",
+	"Recovery Relock Attempt Error",
+	"Deskew Abort Error",
+	"Rx Buffer Error",
+	"Rx LFDS Fifo Overflow Error",
+	"Rx LFDS Fifo Underflow Error",
+	"LinkSub Tx Timeout Error",
+	"LinkSub Rx Timeout Error",
+	"Rx CMD Packet Error",
+	"LFDS Training Timeout Error",
+	"LFDS FC Init Timeout Error",
+	"Data Loss Error",
 };
 
 struct smca_mce_desc {
@@ -490,12 +602,21 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_SMU]	= { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
 	[SMCA_SMU_V2]	= { smca_smu2_mce_desc,	ARRAY_SIZE(smca_smu2_mce_desc)	},
 	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
+	[SMCA_MPDMA]	= { smca_mpdma_mce_desc,	ARRAY_SIZE(smca_mpdma_mce_desc)	},
 	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
 	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
 	[SMCA_PCIE_V2]	= { smca_pcie2_mce_desc,   ARRAY_SIZE(smca_pcie2_mce_desc)	},
 	[SMCA_XGMI_PCS]	= { smca_xgmipcs_mce_desc, ARRAY_SIZE(smca_xgmipcs_mce_desc)	},
+	/* NBIF and SHUB have the same error descriptions, for now. */
+	[SMCA_NBIF]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
+	[SMCA_SHUB]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
+	[SMCA_SATA]	= { smca_sata_mce_desc, ARRAY_SIZE(smca_sata_mce_desc)	},
+	[SMCA_USB]	= { smca_usb_mce_desc,	ARRAY_SIZE(smca_usb_mce_desc)	},
+	[SMCA_GMI_PCS]	= { smca_gmipcs_mce_desc,  ARRAY_SIZE(smca_gmipcs_mce_desc)	},
+	/* All the PHY bank types have the same error descriptions, for now. */
 	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-	[SMCA_WAFL_PHY]	= { smca_waflphy_mce_desc, ARRAY_SIZE(smca_waflphy_mce_desc)	},
+	[SMCA_WAFL_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
+	[SMCA_GMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
 };
 
 static bool f12h_mc0_mce(u16 ec, u8 xec)
