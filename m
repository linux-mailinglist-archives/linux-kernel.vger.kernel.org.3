Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7384F91A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiDHJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiDHJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE411F7B5;
        Fri,  8 Apr 2022 02:08:42 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0kWs+WghlwT8VtlvOoAJGorRrHANni8bNYa3nn38+o=;
        b=M12Dbp3Z2/3vq42U0+qsZ2SDPeBLbAQe0uNhP4DGf/OZ6QmY4VZb7Q9XSEIeJ4YBAKqoBr
        Gar/9TvFxQcA2Se3MElnZ9duh+MjxWGbo4jNqZ1cmqfxC3LdbLdlW8p+RCTxQ9i2F/tDaE
        a/BfK+X6WayzyQDl+0Jq+w4gP108vKqUCS4+Slk0SoL2cLjpiAyL8AfGJsWgFrRdPyYwV9
        dvlHPXviyRuiKB//ciZdTa4aoEh//ZWwDOOT76VuLI4Lea5X7d0C67hMtH6mFP08QXB4bK
        t2rQwrGiiXo9MFUrEi31lpOYqLH1wu6M270yoRqQA/qvvJkSFt7iuBUEjzysig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0kWs+WghlwT8VtlvOoAJGorRrHANni8bNYa3nn38+o=;
        b=NESKrTpCgrcbbe9khdGOSwjwarCjIDW1DMxFp5SjucoArwFiLR2ApgSn//I9YaAIeo+azh
        JK6/gTC+08D/ahCw==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Register SEV-SNP guest request platform device
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-43-brijesh.singh@amd.com>
References: <20220307213356.2797205-43-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892061.389.5667091212072705185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     3a45b3753849c4a12cca2dd176c0192cd2a63e62
Gitweb:        https://git.kernel.org/tip/3a45b3753849c4a12cca2dd176c0192cd2a=
63e62
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:21 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:12 +02:00

x86/sev: Register SEV-SNP guest request platform device

Version 2 of the GHCB specification provides a Non Automatic Exit (NAE)
event type that can be used by the SEV-SNP guest to communicate with the
PSP without risk from a malicious hypervisor who wishes to read, alter,
drop or replay the messages sent.

SNP_LAUNCH_UPDATE can insert two special pages into the guest=E2=80=99s memor=
y:
the secrets page and the CPUID page. The PSP firmware populates the
contents of the secrets page. The secrets page contains encryption keys
used by the guest to interact with the firmware. Because the secrets
page is encrypted with the guest=E2=80=99s memory encryption key, the hypervi=
sor
cannot read the keys. See SEV-SNP firmware spec for further details on
the secrets page format.

Create a platform device that the SEV-SNP guest driver can bind to get
the platform resources such as encryption key and message id to use to
communicate with the PSP. The SEV-SNP guest driver provides a userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-43-brijesh.singh@amd.c=
om
---
 arch/x86/include/asm/sev.h |  4 +++-
 arch/x86/kernel/sev.c      | 56 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c63a1d4..9c2d33f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -95,6 +95,10 @@ struct snp_req_data {
 	unsigned int data_npages;
 };
=20
+struct snp_guest_platform_data {
+	u64 secrets_gpa;
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7237b41..ace43e1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,9 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/efi.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
=20
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2163,3 +2166,56 @@ e_restore_irq:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
+
+static struct platform_device guest_req_device =3D {
+	.name		=3D "snp-guest",
+	.id		=3D -1,
+};
+
+static u64 get_secrets_page(void)
+{
+	u64 pa_data =3D boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map =3D early_memremap(pa_data, sizeof(info));
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* smoke-test the secrets page passed */
+	if (!info.secrets_phys || info.secrets_len !=3D PAGE_SIZE)
+		return 0;
+
+	return info.secrets_phys;
+}
+
+static int __init snp_init_platform_device(void)
+{
+	struct snp_guest_platform_data data;
+	u64 gpa;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	gpa =3D get_secrets_page();
+	if (!gpa)
+		return -ENODEV;
+
+	data.secrets_gpa =3D gpa;
+	if (platform_device_add_data(&guest_req_device, &data, sizeof(data)))
+		return -ENODEV;
+
+	if (platform_device_register(&guest_req_device))
+		return -ENODEV;
+
+	pr_info("SNP guest platform device initialized.\n");
+	return 0;
+}
+device_initcall(snp_init_platform_device);
