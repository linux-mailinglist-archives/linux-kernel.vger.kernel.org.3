Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D983464515
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbhLACwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbhLACwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:52:35 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF7FC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:49:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p13so15097844pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9a0buZerOCPxhv6UaAX+0cPFzZ+N89wMLNskqW/RXk=;
        b=UjQm/i7kaDCTA37/lk38Ipmprcab/Gk8TBkrnYfPM6PsO6VqibW/MZcnhcuZ0HKESd
         +Oaj0lFWswo1GKg/8NG7x8CZ1UOh4JG5R+1exPit9eU0W+YI9Bha+a7nUR/Tnnfgo2al
         MOkLHQMaF/hGGMXVR3fndsRXprPNKjYsEkbjtxd3TwS+mUAzEj5b68dFvE7GFx0I6bv7
         B18IpQyLPs9zs4dKXSWLwbpsCfOS9tQozlFk+x+nKb8EGKKzlfCWNfKCU+7HTz32zwaQ
         uuL6pbfLIU1fVvL7j/zYBVciXkAN35pVKqDjbJcseXiRXOUsSzqXlddUmpM6WNHcX7h8
         ih7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9a0buZerOCPxhv6UaAX+0cPFzZ+N89wMLNskqW/RXk=;
        b=8SE4nEwYcQyNukt1p8STmvmxAYvPH5o05yQjrAViYYuh29hPedII+vA/CBFU7M+EOy
         JU/3f5XCPj0RFwRrxfwZJVeCfJ9xCKRfEnwLSIEGEUjJAwOlCJbM7fvJ3tV4SGYJyoQQ
         pXNg2OrTUpAedhxEyaTDHl4ry46CzY4Ni/VwcX01tu1aQEwfHtGMUrBKX90CnmOnFwo5
         H/RgT9kcDeZXotwr/gP3skuPwnQcuk2BHOFZI3hJa9z0nJVhU5dQFWAbJNot4d89DrZc
         UU0oSF5GAbPcrloqMXH2NofM08OhUdCeUJWv33G8zPik8pU11DM49bhJuOFjkLK/UpAD
         TnhQ==
X-Gm-Message-State: AOAM5321dIr7eaXxOEHhPXFx+twcME8kFrA/XiN+wmMkQXRpx195IjpS
        j2abQOBHTml+PrV+tn2g6+zmNg==
X-Google-Smtp-Source: ABdhPJx7AfbsJqsZjjWbTqY5avPIPtGA9U4n5u5NdAObu6QCrtDZNsR4rHJk7wKJlS4qsd8KESphEw==
X-Received: by 2002:a63:115c:: with SMTP id 28mr2617661pgr.123.1638326955633;
        Tue, 30 Nov 2021 18:49:15 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id f1sm24291704pfj.184.2021.11.30.18.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 18:49:15 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     tglx@linutronix.de, pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 2/2] KVM: x86: use x86_get_freq to get freq for kvmclock
Date:   Wed,  1 Dec 2021 10:46:50 +0800
Message-Id: <20211201024650.88254-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201024650.88254-1-pizhenwei@bytedance.com>
References: <20211201024650.88254-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the host side supports APERF&MPERF feature, the guest side may get
mismatched frequency.

KVM uses x86_get_cpufreq_khz() to get the same frequency for guest side.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 arch/x86/kvm/x86.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5a403d92833f..125ed3c8b21a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8305,10 +8305,8 @@ static void tsc_khz_changed(void *data)
 
 	if (data)
 		khz = freq->new;
-	else if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
-		khz = cpufreq_quick_get(raw_smp_processor_id());
 	if (!khz)
-		khz = tsc_khz;
+		khz = x86_get_cpufreq_khz(raw_smp_processor_id());
 	__this_cpu_write(cpu_tsc_khz, khz);
 }
 
-- 
2.25.1

