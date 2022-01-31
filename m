Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323B94A3C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 02:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiAaBqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 20:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiAaBqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 20:46:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C2C061714;
        Sun, 30 Jan 2022 17:46:48 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e16so10885668pgn.4;
        Sun, 30 Jan 2022 17:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cW2Lx4AI8MPH4Bk7KXj4Vkw5vzZl1ppTAqKUBR+xkU=;
        b=di32sGTYWtFxvcNV7gCw2VmdXnsDRngMicftxh+8EjZE6gpb7tN6DJZMCuZRsEEbD/
         JUdpGLJKHjdRbpzM0MWLnd1kPW03aNsegwJsWU0jIw1Yj6F5bdAd333iH9X+IwQuLOIf
         JT3z0BD0YIEc+a3Zusez0XBzJ0/dSTUs28POo6p9a6T81wXr8aX4Mz/ll8bb3lWlRne9
         dNO/Bf5ex6mNBAXc12cpcX2UpV4NAvfPAypCx+lkEKSqLBf64MmYGJe8LDsFRhBGtDAu
         gE6LDBqVvwxucKPxGas8FnsWgUVBlI6OkBOjGhx54iknNXISVrATVWZwNmIT+R/UMs7r
         9gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cW2Lx4AI8MPH4Bk7KXj4Vkw5vzZl1ppTAqKUBR+xkU=;
        b=QRfmts7w7D6qZutOA8BPbJhhdDN5zk/gpbc3C0MqS0jfE2ncWLpmQCr0X5+tA1mDmR
         CJkcBKfcAnxRxhL1og/1Zj/Ac6MXotvm9RyAr0Q7OT8qoyyFvEXswoX1Ab0M5BW5LuI5
         +bKzEvNuVgKJjoXXxO0kUfQLzbtBCFHqusKqcyWp5Gnq0IfmYowKZtPQZzwaXV1Hnetb
         sMbs+YOsGWbBJ9iUDFvStKagqE5uAlvdMxpUVlORrI5pBk9datZ1MfmBscrpIkOz3hNm
         6a0YOEazryt2KRAcwDVXsE/fhNO4KFQJoKBvylM9GjnV9OlQiYB0PuL99mIRQ2HqG5wb
         WuLw==
X-Gm-Message-State: AOAM532qAlAf8ejkHutNPBhe4lDrruefyNBzamPyvnwfhY57ihQITYmQ
        AMjR69mXeOQptJD0vjXj6PY=
X-Google-Smtp-Source: ABdhPJxjS7AM92NRmg0JyGGcwR5KFUYFuWzwtfbLZUdnNRXDZ2kOIuGTNdOkF67TRR1wqVEnmDYw7g==
X-Received: by 2002:a05:6a00:1805:: with SMTP id y5mr18664694pfa.6.1643593607472;
        Sun, 30 Jan 2022 17:46:47 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c20sm15361033pfn.190.2022.01.30.17.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 17:46:47 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] kernel/cpu.c: fix init_cpu_online
Date:   Sun, 30 Jan 2022 17:46:48 -0800
Message-Id: <20220131014648.941629-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_online_mask has an associate counter of online cpus, which must be
initialized in init_cpu_online().

Fixes: 0c09ab96fc82010 (cpu/hotplug: Cache number of online CPUs)
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..cd7605204d4d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2616,6 +2616,7 @@ void init_cpu_possible(const struct cpumask *src)
 void init_cpu_online(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_online_mask, src);
+	atomic_set(&__num_online_cpus, cpumask_weight(cpu_online_mask));
 }
 
 void set_cpu_online(unsigned int cpu, bool online)
-- 
2.30.2

