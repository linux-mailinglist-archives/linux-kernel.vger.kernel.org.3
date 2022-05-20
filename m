Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5844552EDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350116AbiETOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiETOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:10:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219A166441
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:10:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so11615559pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fw/8xtbO/77OBVSsbwuLK/fJrTcZqfjeO9mMBE3hl1k=;
        b=gYcU/o1YFIQi1HnR+Y3q2DETW8SRnpOTtKvaPRlWdUw8SXyEhJJ5FsSzpyvqLX70Q2
         aKLsQ1y7qD6APz9gC++fXm6VqF1jjZp/F8HtkvNJxkSSrVpznuOLbeN4qwSJ8Tg8tmo1
         I+GpQnSf8tTXh1KeOuthM1uF9X5XURipi7EByr8hFzeDE2h5Zf97LtHHFcGW9EblFQjz
         W8E9djzuFqAeGb/Nc0dqueeJjkyhkFB+QhhLpZ8OD6w3Jh1Q08ju723iERuneVr8ZOZY
         mhfgLuGY93oxAEg9PGFkHdTJgGKIG1I3e3GPm6mKJI70s89pfsv1koiCOdObrtBSWVi+
         Tt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fw/8xtbO/77OBVSsbwuLK/fJrTcZqfjeO9mMBE3hl1k=;
        b=6V24/LoPaTfnh0wXiaFjZ7jkdhYUMAYUb530JsCzvBMNQRvV1MYKmgEFS/bJ0+DlKW
         S2WjymGJwh3RSOkbBQWoRdMRJiVyVn0LFqNib1N/SlI/XeYHN1PuvL2HFOu5rnHDzyuA
         AQVwdNtJTYH0x6BRPikFZZwfLvnTrx0LhXKW7fHKti2zDBre/rF/1f9Ob0575SqpPZRF
         WT+DV3+WETNhpjUbqM8Gi7fjQZ3q3mdW7lzYt8KuBYD3ITwd4oSwi47d2q11W9hC5pCx
         Z2pLse7okgudQ5H+iieSCkmnO5L3tI4641YvGxIptf8PhdxlMTuDW7lTBIjavYAHjeLE
         7UXQ==
X-Gm-Message-State: AOAM533jFKy0cU87mQaOOEqUiFgn7sxfDpm4javBFfKWbG3u/UmQipPn
        EUEkTslKu+LVZ7NVd4K8VgM=
X-Google-Smtp-Source: ABdhPJzJvN7g9pmdcRYb5DB4rQeYTQqtb6Hw2+Lxb/5SjziGcIgoR9HpxUh4hxsH1WgmC4Y8Hh3tLA==
X-Received: by 2002:a17:902:cf4c:b0:161:e3aa:2708 with SMTP id e12-20020a170902cf4c00b00161e3aa2708mr6644949plg.127.1653055807490;
        Fri, 20 May 2022 07:10:07 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id m11-20020a170902d18b00b0015ee985999dsm5624673plb.97.2022.05.20.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 07:10:07 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v2] x86/vmware: use unsigned integer for shifting
Date:   Fri, 20 May 2022 19:39:54 +0530
Message-Id: <20220520140954.597725-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

From: Shreenidhi Shedi <sshedi@vmware.com>

Shifting signed 32-bit value by 31 bits is implementation-defined
behaviour. Using unsigned is better option for this.

Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933f48d3..cd809c5b17f0 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/bits.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
-	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
+	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
+		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC))
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.36.1

