Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED94B1A46
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbiBKASB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:18:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346262AbiBKAR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:17:59 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608AF105;
        Thu, 10 Feb 2022 16:18:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d3so5708865ilr.10;
        Thu, 10 Feb 2022 16:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7yoyMsL7SyevN/y4cH9y7HBy5JcN4ZPi5dkNOU9qEgE=;
        b=cjSHDomLYdafXDclCfXftX/KeP7y/uJEw/qtk1hqGp3MaWFhiinNwkVAsrB7zXZXCw
         UVpHjhSNynzmJ61ExawDF3np2A97Q0Qk9+NS7JQ1RHeNCc98/fX5RgP2h74m9/niOGwz
         B61BqZAjfNBdF5xjhtIPK4DCq7HoJ70gA4gvTK5G9H6BdJ9QDEMId+UXZVzrTgpFvta5
         7/W1oUpxy8YRdTXbKeWTowVYdpiYUmb5uj2hA2xc0McmxJjnR+QcHrVajxS9eeQAKZt5
         B2aDKNlfCGJWkf4SSI+yqbkb6Wro/HcRN4rSQ9nt5esXZW/ooo18jiA9RogOaF/Ry2Om
         nGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yoyMsL7SyevN/y4cH9y7HBy5JcN4ZPi5dkNOU9qEgE=;
        b=HGl/nkrauDdjCXX8twYSM9xCN+csOmanps7dI5wHm6FYktQlxSs8VFW4/+h+JU9R8L
         SPlDu1VuuDa0jyPsFNiGm2zOkNByW+hcNny4z4qKa67VoYBvcp5HeVGP9ld2GBO1YcSs
         y0ABZ+8QXR2s+djRGqqDfOB2LoRCBQCaNT+xv11RCet8oIYoKfDUNLIFkoKEG34K51CP
         rUryvp5eJoaf55LIwTHcrogryWdiyNs0EK+xHFmiEnbLFFtxmUv3QxBHV1kgWXyQkeTT
         t5jFX7bcPtcedr7dc6/TXDr9fvEONVApVl8otUYuzBlo5tppOJvjjVColZoA9N/1LXTC
         HMDg==
X-Gm-Message-State: AOAM531EKtfl0fPMTOoUoO4PDy8EInGMk1gU98o4Y+VgnEgqHqxHOp69
        rSMmm6xtq62JuzQLKC+nWkM=
X-Google-Smtp-Source: ABdhPJxcPsfzEQtc8co4G0V78MxZQ0H3JjCQJHCLjHTl1WrVlCNlJ/iGZcNVR1Vxlyc4FGh8gOvSfA==
X-Received: by 2002:a05:6e02:180b:: with SMTP id a11mr5307358ilv.196.1644538679746;
        Thu, 10 Feb 2022 16:17:59 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id q16sm11837074ion.27.2022.02.10.16.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:17:59 -0800 (PST)
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
Subject: [PATCH 39/49] arch/s390: replace cpumask_weight with cpumask_weight_eq where appropriate
Date:   Thu, 10 Feb 2022 14:49:23 -0800
Message-Id: <20220210224933.379149-40-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfset_all_start() calls cpumask_weight() to compare the weight of cpumask
with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is (or can't be) met.

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
2.32.0

