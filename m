Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D332596864
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiHQFMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiHQFMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:12:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4756DFA5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660713122; x=1692249122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D80ulUAhbmrV7L9/yOfZt2Tb37WVpYS3nBYfSyUXRLU=;
  b=AWdNW9ruEInt7Z2b2+PExU05ZuJelHRN2YsPF2qwr3FnAfWT3Wzo6jTT
   y6dvKlERFY/BJEHQwYumovZ0aiLn3KXDo6muNubT3Dyy+WyDe2rL6I3UR
   C9Nuh7AOhATVV9voZi8AqniHhGbFU0HwkYA337FaOJRq/Lh2jaJUsln/7
   Je9adQ4Afjtamd5oWGAIkNL4P1WwO3nfuRg2d/exRZxxydbUAwglMBIz4
   GUr60tlf/8icTDDTU7It524jNsvo6/LIDo7WzcG1IRIt4HXgxBkjzLihx
   ZLKlGau3tIzh8dU76gmrdmp437eS+B+ldr3VeV0xoKWZs9v5ZbFld/U4Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289972502"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="289972502"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:12:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="557976693"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:11:59 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Jacon Jun Pan" <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 4/5] x86/x2apic: Support x2apic self IPI with NMI_VECTOR
Date:   Wed, 17 Aug 2022 05:11:26 +0000
Message-Id: <20220817051127.3323755-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817051127.3323755-1-ashok.raj@intel.com>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X2APIC architecture introduced a dedicated register for sending self-IPI.
Though highly optimized for performance, its semantics limit the delivery
mode to fixed mode.  NMI vector is not supported, this created an
inconsistent behavior between X2APIC and others.

This patch adds support for X2APIC NMI_VECTOR by fall back to the slower
ICR method.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/apic/x2apic_phys.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..cf187f1906b2 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -149,7 +149,11 @@ int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
 
 void x2apic_send_IPI_self(int vector)
 {
-	apic_write(APIC_SELF_IPI, vector);
+	if (unlikely(vector == NMI_VECTOR))
+		apic->send_IPI_mask(cpumask_of(smp_processor_id()),
+				    NMI_VECTOR);
+	else
+		apic_write(APIC_SELF_IPI, vector);
 }
 
 static struct apic apic_x2apic_phys __ro_after_init = {
-- 
2.32.0

