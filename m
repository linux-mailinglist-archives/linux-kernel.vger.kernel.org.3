Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4A4E5D84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347969AbiCXDWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 23:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiCXDWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:22:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4582D1ED;
        Wed, 23 Mar 2022 20:20:36 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KP9Rl2NqlzfZS0;
        Thu, 24 Mar 2022 11:18:59 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 11:20:33 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 11:20:32 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf/x86: Unify format of events sysfs show
Date:   Thu, 24 Mar 2022 11:19:57 +0800
Message-ID: <20220324031957.135595-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs show formats of files in /sys/devices/cpu/events/ are not unified,
some end with "\n", and some do not. Modify sysfs show format of events
defined by EVENT_ATTR_STR to end with "\n".

Before:
  $ ls /sys/devices/cpu/events/* | xargs -i sh -c 'echo -n "{}: "; cat -A {}; echo'
  branch-instructions: event=0xc4$

  branch-misses: event=0xc5$

  bus-cycles: event=0x3c,umask=0x01$

  cache-misses: event=0x2e,umask=0x41$

  cache-references: event=0x2e,umask=0x4f$

  cpu-cycles: event=0x3c$

  instructions: event=0xc0$

  ref-cycles: event=0x00,umask=0x03$

  slots: event=0x00,umask=0x4
  topdown-bad-spec: event=0x00,umask=0x81
  topdown-be-bound: event=0x00,umask=0x83
  topdown-fe-bound: event=0x00,umask=0x82
  topdown-retiring: event=0x00,umask=0x80

After:
  $ ls /sys/devices/cpu/events/* | xargs -i sh -c 'echo -n "{}: "; cat -A {}; echo'
  /sys/devices/cpu/events/branch-instructions: event=0xc4$

  /sys/devices/cpu/events/branch-misses: event=0xc5$

  /sys/devices/cpu/events/bus-cycles: event=0x3c,umask=0x01$

  /sys/devices/cpu/events/cache-misses: event=0x2e,umask=0x41$

  /sys/devices/cpu/events/cache-references: event=0x2e,umask=0x4f$

  /sys/devices/cpu/events/cpu-cycles: event=0x3c$

  /sys/devices/cpu/events/instructions: event=0xc0$

  /sys/devices/cpu/events/ref-cycles: event=0x00,umask=0x03$

  /sys/devices/cpu/events/slots: event=0x00,umask=0x4$

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index eef816fc216d..e3cc099886ab 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1837,7 +1837,7 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, cha
 
 	/* string trumps id */
 	if (pmu_attr->event_str)
-		return sprintf(page, "%s", pmu_attr->event_str);
+		return sprintf(page, "%s\n", pmu_attr->event_str);
 
 	return x86_pmu.events_sysfs_show(page, config);
 }
-- 
2.30.GIT

