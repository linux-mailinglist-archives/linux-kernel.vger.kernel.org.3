Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806B1592BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiHOIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiHOIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:46:36 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1702225E2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:46:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f16-20020a17090a4a9000b001f234757bbbso2558104pjh.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=P7I+W84R6mug3QmKLPOAQrurRQQGcCWpUQ0NeTQs4YY=;
        b=om2nQxLe94jjvLjFGv+pYcs1iVP1OJMoXrCXGBZnTWAAbQmI3vJkVaI1j3WiN2aMxb
         W/FrgENZlOFeXh+7ZnaiueYFSZsKdjaT5+kg7lp+386BkswUIxeRU3vfPHd/UZcpWSoX
         Vea7DGa7mSzB0B3I41/jCAO6q1//GzPF80zsSs1UFiR2hioYH/Esy/33WQkaUNgzx2mC
         OOVTGErtFHOsgo6GN1wa5Cz16mY7lHfXvC5nADqnY8AhqJlvYiHWHTQovks+K1zFjyw4
         S61iigPog3yqMwnmerdPg8rLYOdSoiIbrOsPnnZFTVFm6ihU0AVDnlttVITZKaDBmz90
         dkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=P7I+W84R6mug3QmKLPOAQrurRQQGcCWpUQ0NeTQs4YY=;
        b=jiS6A3TePpVjTM8szlg87sRVpPBtEJlcnS8lPQMKvvkL8YwA22syPwNFVzzapH8sb7
         m18jILJ0dOCJ2aH1XBbAdyTAWTRBUEyRt1W64fIy//OthQMH1pSyIHMBPYaB6fe9g4cY
         7vaVJnsSL8/rvioJTID9745dCBdmQ725SmQk4Vf5Uf1vnSv30+XjprIg8Wx5b+6ylmBn
         UyMTxP1nWkzPkwaLRbH56CCSsdPKJLVhcaGR/rtadz6/JGNo5fL1eczLZDoU282+ZO7N
         1CM7ic/wO83OWLUNTUUHcScByy0b/O9cwHqBb6e7y+/Op5t3ja7uUm5D/O4MOn5J6eSt
         YXwA==
X-Gm-Message-State: ACgBeo393N8yt6hgoNPhNz5XFJQd+WDsoX4t5oi2pVpkT4cn+pRmUKRv
        Wzl9Xbub4gqMQ+0mPXTc2VInzdCaOQ==
X-Google-Smtp-Source: AA6agR6L5FwaNqn3Ac9cQ4ICwNnRYEAOmfQtXC1KjopYcl/Nu7/ur+M+K+zBurR4d44DT5ZIPA+lPZn7iw==
X-Received: from wnliu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:270f])
 (user=wnliu job=sendgmr) by 2002:a17:902:ec90:b0:16e:d8d8:c2db with SMTP id
 x16-20020a170902ec9000b0016ed8d8c2dbmr15592456plg.69.1660553195555; Mon, 15
 Aug 2022 01:46:35 -0700 (PDT)
Date:   Mon, 15 Aug 2022 08:45:47 +0000
Message-Id: <20220815084547.864400-1-wnliu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] x86/reboot: Avoid nmi shutdown all CPUs twice
From:   Weinan Liu <wnliu@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CPU with VMX feature, if there's no crash kernel loaded and
crash_kexec_post_notifiers is true, then it will endup call
nmi_shootdown_cpus() twice. This will crash the system because it double
register the same nmi callback

The first call is:

    nmi_shootdown_cpus+0x21/0xc0
    kdump_nmi_shootdown_cpus+0x15/0x20
    crash_smp_send_stop+0x23/0x40
    __panic+0xec/0x2d0

The second call is:

    nmi_shootdown_cpus+0x21/0xc0
    native_machine_emergency_restart+0x7d/0x270
    machine_emergency_restart+0x1c/0x20
    emergency_restart+0x1a/0x20
    __panic+0x231/0x2d0

Fixes: d176720d34c7 ("x86: disable VMX on all CPUs on reboot")
Fixes: 2340b62f77c7 ("kdump: forcibly disable VMX and SVM on machine_crash_shutdown()")
Signed-off-by: Weinan Liu <wnliu@google.com>
---
 arch/x86/kernel/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index c3636ea4aa71..f9890e299750 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -837,7 +837,17 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
  */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
+	static bool cpus_shutdown;
 	unsigned long msecs;
+
+	/*
+	 * Only shutdown CPUs once. Double register nmi callback will crash the
+	 * system
+	 */
+	if (cpus_shutdown)
+		return;
+	cpus_shutdown = true;
+
 	local_irq_disable();
 
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
-- 
2.37.1.595.g718a3a8f04-goog

