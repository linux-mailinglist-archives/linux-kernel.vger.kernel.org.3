Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9041F5167D9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354776AbiEAUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiEAUty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:49:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C8559B87;
        Sun,  1 May 2022 13:46:27 -0700 (PDT)
Date:   Sun, 01 May 2022 20:46:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651437985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=557Zdz5NnkEbZAML/Rf00CcEcDkEAYNoO9M1iqJXXJg=;
        b=BQCZ4I1GCX7u4Gxj7oF4nPU93AjM1MM4zWhkhZoP/SWkLz5imU30cuAeB0GZpE1GaokLSv
        seALoXUqH07L8ri0N47rurJT8oq1zmSlHm3PFzP9Dj7kxIxlUvfAZr9Iz7OlrzrDZ8I/mF
        fbOKkUfibi+jEM/IR0fd6sUntwwaBxeftVXOSvdtPaxjBjPKDjN3UFZvi3VvUVeM7KlUIv
        wyx6yGFpFCum6VEUcY9ztmgDQZKku5R92IJw3KBDq0bdjoXhqJUcMa1NIYqs037AYgsn/0
        PgQwhPswfQlDqXUvuYkAJPPYG/YYeG7uy/2+So2H6xG+F1td4MvXXcaVHfOk+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651437985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=557Zdz5NnkEbZAML/Rf00CcEcDkEAYNoO9M1iqJXXJg=;
        b=ZTZMmiKF/orzzHWjUFrPDJ7Jqp5HGrLTJatvmpHVMf3G7gAnaebeD3JI9p5sx0JY1BQQIa
        lawFwMF+/1sZyABA==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Do apic driver probe for "nosmp" use case
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca64f864e1114bcd63593286aaf61142cfce384ea=2E16500?=
 =?utf-8?q?76869=2Egit=2Esathyanarayanan=2Ekuppuswamy=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ca64f864e1114bcd63593286aaf61142cfce384ea=2E165007?=
 =?utf-8?q?6869=2Egit=2Esathyanarayanan=2Ekuppuswamy=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165143798346.4207.13836898834353689685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     7a116a2dd32d96869f0f93bac00b900859ba0434
Gitweb:        https://git.kernel.org/tip/7a116a2dd32d96869f0f93bac00b900859ba0434
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Sat, 16 Apr 2022 02:45:32 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 01 May 2022 22:40:29 +02:00

x86/apic: Do apic driver probe for "nosmp" use case

For the "nosmp" use case, the APIC initialization code selects
"APIC_SYMMETRIC_IO_NO_ROUTING" as the default interrupt mode and avoids
probing APIC drivers.

This works well for the default APIC modes, but for the x2APIC case the
probe function is required to allocate the cluster_hotplug mask. So in the
APIC_SYMMETRIC_IO_NO_ROUTING case when the x2APIC is initialized it
dereferences a NULL pointer and the kernel crashes.

This was observed on a TDX platform where x2APIC is enabled and "nosmp"
command line option is allowed.

To fix this issue, probe APIC drivers via default_setup_apic_routing() for
the APIC_SYMMETRIC_IO_NO_ROUTING interrupt mode too.

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/a64f864e1114bcd63593286aaf61142cfce384ea.1650076869.git.sathyanarayanan.kuppuswamy@intel.com

---
 arch/x86/kernel/apic/apic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 13819bf..25e92d7 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1428,22 +1428,21 @@ void __init apic_intr_mode_init(void)
 		return;
 	case APIC_VIRTUAL_WIRE:
 		pr_info("APIC: Switch to virtual wire mode setup\n");
-		default_setup_apic_routing();
 		break;
 	case APIC_VIRTUAL_WIRE_NO_CONFIG:
 		pr_info("APIC: Switch to virtual wire mode setup with no configuration\n");
 		upmode = true;
-		default_setup_apic_routing();
 		break;
 	case APIC_SYMMETRIC_IO:
 		pr_info("APIC: Switch to symmetric I/O mode setup\n");
-		default_setup_apic_routing();
 		break;
 	case APIC_SYMMETRIC_IO_NO_ROUTING:
 		pr_info("APIC: Switch to symmetric I/O mode setup in no SMP routine\n");
 		break;
 	}
 
+	default_setup_apic_routing();
+
 	if (x86_platform.apic_post_init)
 		x86_platform.apic_post_init();
 
