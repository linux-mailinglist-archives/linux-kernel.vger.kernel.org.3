Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ED84A72A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbiBBODJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236875AbiBBODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643810586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6KXCGEFBC2qGgarcr/cMXne8594TK1z4xd4VBjpj0mM=;
        b=VutIb82QFoDxBK7y1NMIggC3qDcLNcr/Xe+qNMz2R0Fnw2+SApt2zTWROXUrAbnihqnsCQ
        k8ds0Iq78Sq67zvxv+Q9ArbGHAdkv27xi/iAEB1s1x+c2l8/KDl1VUtxjPqun4+w2Lmw9a
        YJtyQivoMEfnuhobstblRajsHJNX8aw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-8euJdAIvOZ2cWGkymPW2Cw-1; Wed, 02 Feb 2022 09:03:05 -0500
X-MC-Unique: 8euJdAIvOZ2cWGkymPW2Cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3113D814243;
        Wed,  2 Feb 2022 14:03:03 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.40.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 202DE57F20;
        Wed,  2 Feb 2022 14:02:45 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] apic: fix timer base macro definitions
Date:   Wed,  2 Feb 2022 15:02:44 +0100
Message-Id: <20220202140244.1681140-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if the aliasing of APIC_TIMER_BASE_TMBASE and
APIC_LVT_TIMER_TSCDEADLINE was intentional or we need to << 19?

Also it seems the GET_APIC_TIMER_BASE, APIC_TIMER_BASE_CLKIN and
APIC_TIMER_BASE_TMBASE are not even being used. Perhaps, can we
just remove them?

Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 arch/x86/include/asm/apicdef.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 5716f22f81ac..00b4ca49f3ea 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -95,9 +95,9 @@
 #define	APIC_LVTTHMR	0x330
 #define	APIC_LVTPC	0x340
 #define	APIC_LVT0	0x350
-#define		APIC_LVT_TIMER_BASE_MASK	(0x3 << 18)
-#define		GET_APIC_TIMER_BASE(x)		(((x) >> 18) & 0x3)
-#define		SET_APIC_TIMER_BASE(x)		(((x) << 18))
+#define		APIC_LVT_TIMER_BASE_MASK	(0x3 << 19)
+#define		GET_APIC_TIMER_BASE(x)		(((x) >> 19) & 0x3)
+#define		SET_APIC_TIMER_BASE(x)		(((x) << 19))
 #define		APIC_TIMER_BASE_CLKIN		0x0
 #define		APIC_TIMER_BASE_TMBASE		0x1
 #define		APIC_TIMER_BASE_DIV		0x2
-- 
2.34.1

