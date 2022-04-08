Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BDE4F91E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiDHJR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiDHJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3C11F7B0;
        Fri,  8 Apr 2022 02:09:10 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Evvz/PXDJGJDoyiWegg09d/VEn3ghqS3QJIybSX0JeA=;
        b=w2Sl4JOrwx82OpEkk3kJeV5+rT5ITfUVMZ05mWVEnB8MyMs4XjkwoC2OUdnkB2Q1KFFaH7
        BduPvPsKn+n7a7JTSxfCk8gVnMTcuEgr39t4TJyuMGq129RPho4iE180Fo3klafcbJ8LmA
        gu0J4JDsTvFzYdno4gtMJHF6RUvcRfYOROD7TunJPYorqTomp/jVYFwijCirG9sBhqCEHT
        PzWJBFMFyBznhZloO+FAll6Cc9lwled6LxwPnaKKQ638eTm1ojPk5Jzgf/GqmYa+9MLOEc
        IOIeb++P6erCPl3hLC55GWoUvBScLa1vrRcCCqctufOKXCDzKvo3Y0Rb1gytkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Evvz/PXDJGJDoyiWegg09d/VEn3ghqS3QJIybSX0JeA=;
        b=MDbB+4ey4sNoKpqzTBr/crZIQ5rvcwGowAeNkNV928SLGWjT+XFSgRVorEXRDbcev6g3Rk
        qG07Jqs13uiAGIBA==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add a helper for the PVALIDATE instruction
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Venu Busireddy <venu.busireddy@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-14-brijesh.singh@amd.com>
References: <20220307213356.2797205-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894813.389.3850536396114238497.tip-bot2@tip-bot2>
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

Commit-ID:     0bd6f1e526070271dbe0f626b123b4f6b01dc79c
Gitweb:        https://git.kernel.org/tip/0bd6f1e526070271dbe0f626b123b4f6b01=
dc79c
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:07 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:10:30 +02:00

x86/sev: Add a helper for the PVALIDATE instruction

An SNP-active guest uses the PVALIDATE instruction to validate or
rescind the validation of a guest page=E2=80=99s RMP entry. Upon completion, a
return code is stored in EAX and rFLAGS bits are set based on the return
code. If the instruction completed successfully, the carry flag (CF)
indicates if the content of the RMP were changed or not.

See AMD APM Volume 3 for additional details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Link: https://lore.kernel.org/r/20220307213356.2797205-14-brijesh.singh@amd.c=
om
---
 arch/x86/include/asm/sev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 17b75f6..4ee9897 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -60,6 +60,9 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
=20
+/* Software defined (when rFlags.CF =3D 1) */
+#define PVALIDATE_FAIL_NOUPDATE		255
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -87,12 +90,30 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *gh=
cb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool valida=
te)
+{
+	bool no_rmpupdate;
+	int rc;
+
+	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
+		     CC_SET(c)
+		     : CC_OUT(c) (no_rmpupdate), "=3Da"(rc)
+		     : "a"(vaddr), "c"(rmp_psize), "d"(validate)
+		     : "memory", "cc");
+
+	if (no_rmpupdate)
+		return PVALIDATE_FAIL_NOUPDATE;
+
+	return rc;
+}
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) {=
 return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool valida=
te) { return 0; }
 #endif
=20
 #endif
