Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA824F5230
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849549AbiDFCio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442824AbiDEWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:19:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4114FFF3;
        Tue,  5 Apr 2022 13:57:13 -0700 (PDT)
Date:   Tue, 05 Apr 2022 20:57:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649192230;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgLzDdhreQ+Hp0Qdc8LWg04tmX4e8gJx2x/idoElhgE=;
        b=qLeVRlQg2X9aJ243MX96Zvf1wLwbzCZEb3qjCAP2wVRBvMBcvVQcQo+ZJVgTQRp1wqmQJ9
        QD2HtlJOyq1WEE4A7gNREB30SWb2rB1sYriHYV8g9cXCywcMU65zP7k5fKjm7ibzr/0lVn
        58S21+ndzDdWsrjbCDWixtLdKLMJhWWs+IjrfgBz+RJ05VQFKNHeKjD4MIk2+nEPgKCo3U
        3kzdvOaAmoXKd6VFmrDoKLV4rXFheymANM75SChVh1XnNjcA67+ggOMEpdptq7QQwObwnF
        +HkT+Y/wI1wdrxl+QGnOIiyZkN/WAmC/nugJUZojY+Uil0HEJr6Y6IRsulIrxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649192230;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgLzDdhreQ+Hp0Qdc8LWg04tmX4e8gJx2x/idoElhgE=;
        b=+SBGeY3+Kccqb2ETVxyB16Jef9O41UBvRpd+uNxIUvRscefEsz5zm6yFrEDa7qAczRXQ9E
        AuJb3pk7WjcIW6DQ==
From:   tip-bot2 for Ricardo =?utf-8?q?Ca=C3=B1uelo?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/speculation/srbds: Do not try to turn mitigation
 off when not supported
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        ricardo.canuelo@collabora.com, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220401074517.1848264-1-ricardo.canuelo@collabora.com>
References: <20220401074517.1848264-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Message-ID: <164919222889.389.6325233463959483512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0205f8a738ab9e62d849e88e543cfa6ce4c13163
Gitweb:        https://git.kernel.org/tip/0205f8a738ab9e62d849e88e543cfa6ce4c=
13163
Author:        Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
AuthorDate:    Fri, 01 Apr 2022 09:45:17 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Apr 2022 21:55:57 +02:00

x86/speculation/srbds: Do not try to turn mitigation off when not supported

When SRBDS is mitigated by TSX OFF, update_srbds_msr() will still read
and write to MSR_IA32_MCU_OPT_CTRL even when that MSR is not supported
due to not having loaded the appropriate microcode.

Check for X86_FEATURE_SRBDS_CTRL which is set only when the respective
microcode which adds MSR_IA32_MCU_OPT_CTRL is loaded.

Based on a patch by Thadeu Lima de Souza Cascardo <cascardo@canonical.com>.

  [ bp: Massage commit message. ]

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220401074517.1848264-1-ricardo.canuelo@coll=
abora.com
---
 arch/x86/kernel/cpu/bugs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1e..d879a6c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -446,6 +446,13 @@ void update_srbds_msr(void)
 	if (srbds_mitigation =3D=3D SRBDS_MITIGATION_UCODE_NEEDED)
 		return;
=20
+	/*
+	 * A MDS_NO CPU for which SRBDS mitigation is not needed due to TSX
+	 * being disabled and it hasn't received the SRBDS MSR microcode.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
+		return;
+
 	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
=20
 	switch (srbds_mitigation) {
