Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA104974B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiAWSnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiAWSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:54 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE0C061763;
        Sun, 23 Jan 2022 10:41:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x11so7708017plg.6;
        Sun, 23 Jan 2022 10:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O3KT5VKSFvO3GdRn4FJX6rtqnPjQLFUvXRpKrWgV0vk=;
        b=Kl5oq/zPHhzFnmY1AQ/X1WXwEJ/77u/DsV5WzawwBW5htJum8noY7sVHr104trMone
         0luZQz2YmdZVgBfkBF7XUtbU9U5NNNE77xLkoQ6e44CE/RvA9plyW2k9hGC6yj4hcQuJ
         3veVmDisG0BBCnjxVejMYJbzG51E1SUUiavOLrCnhpLmFLG2cjoWTdfbKr211UkALHeQ
         2UQ9q6rFTw5kdo2WkXGDG4DycaPBW+FTwLqtIRIMJWOFHbQOJNBGAkvI2xkJd9ogpR0/
         QJ92P/ea5Xg/x4A1RP8yiI6aL+2j8Go7YQU125GnF0jEpsfIT0Swhds7G6WuudRZkBgQ
         i7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3KT5VKSFvO3GdRn4FJX6rtqnPjQLFUvXRpKrWgV0vk=;
        b=cPzUMJk09ubWBOfHQVyNaidwKQeXM9xI6A1XzbcTEhAak0AhuWUEqBFHPkCWj0KZSX
         j3oPNkNzRlAXFAp55HdQDLYjGIJei7qZmd8EnvVsIQIhX6O71OxSbdDUW7/01R4FdvZ2
         bbzn83m4K+ltj3rs278T54MvHjYlzM+vLi8B7DT4M5vZRj52wyL8UEk23voWihuOsPDV
         sQKBAuCorZtUl6FLCfdnyno+Xx6FnRMyGjiJscBsFmQ7jC3WfoGCnl2KXRjymlVCLUUu
         lxvUdQ94uL2ovlu4dRa3v6nT6YQqq7gNSVFja9QRvrHGhNTOJ6J88hGAkeaE/G2SODPI
         T+9A==
X-Gm-Message-State: AOAM531kY/DhehXPe8LpqVC6Fxa6HY7rUWi/3J8Ueg5doX5Lyc0lq2Wn
        dGGHYuMBwTpNvAQvo9+UCYE=
X-Google-Smtp-Source: ABdhPJyA03nygberi3JeFhIpeLaKgTDTgDNIwOWLUJrakKCuQW5OTWU8/LphWZHA5drEVEeiqoOhkA==
X-Received: by 2002:a17:902:6841:b0:149:6791:5a4f with SMTP id f1-20020a170902684100b0014967915a4fmr11869454pln.123.1642963313406;
        Sun, 23 Jan 2022 10:41:53 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id my11sm8413621pjb.35.2022.01.23.10.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:53 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>, linux-s390@vger.kernel.org
Subject: [PATCH 40/54] arch/s390: replace cpumask_weight with cpumask_weight_eq where appropriate
Date:   Sun, 23 Jan 2022 10:39:11 -0800
Message-Id: <20220123183925.1052919-41-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfset_all_start() calls cpumask_weight() to compare the weight of cpumask
with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index ee8707abdb6a..4d217f7f5ccf 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -975,7 +975,7 @@ static int cfset_all_start(struct cfset_request *req)
 		return -ENOMEM;
 	cpumask_and(mask, &req->mask, cpu_online_mask);
 	on_each_cpu_mask(mask, cfset_ioctl_on, &p, 1);
-	if (atomic_read(&p.cpus_ack) != cpumask_weight(mask)) {
+	if (!cpumask_weight_eq(mask, atomic_read(&p.cpus_ack))) {
 		on_each_cpu_mask(mask, cfset_ioctl_off, &p, 1);
 		rc = -EIO;
 		debug_sprintf_event(cf_dbg, 4, "%s CPUs missing", __func__);
-- 
2.30.2

