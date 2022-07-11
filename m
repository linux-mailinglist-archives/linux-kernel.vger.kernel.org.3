Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8E570C98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiGKVQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiGKVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C45F80511
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657574182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B17g9wAT+9shoXVHnJnHIlRvD72JVpKr/HdI9ugSZ80=;
        b=eVoBr/yoiV9Q9RvfxupDNxu9tGbVFK6wzolPkTCfKWcS8u1I1wfzOqshhdoHedHONfGwmZ
        +R/MHvphbzSwosyV0tiN+Kib+c3E75h8IsbYIw1e07/PcN1R67v5ant4upXYX/GziZHNo9
        YFfOy58XCzkBlY+auV5YSRZpcA4Hnk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-BymDG5gsMMiVt8p7M54asw-1; Mon, 11 Jul 2022 17:16:21 -0400
X-MC-Unique: BymDG5gsMMiVt8p7M54asw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0D6F8032EA;
        Mon, 11 Jul 2022 21:16:20 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F5212166B26;
        Mon, 11 Jul 2022 21:16:20 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v3 1/2] cpuhp: make target_store() a nop when target == state
Date:   Mon, 11 Jul 2022 17:16:18 -0400
Message-Id: <20220711211619.112854-2-pauld@redhat.com>
In-Reply-To: <20220711211619.112854-1-pauld@redhat.com>
References: <20220711211619.112854-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

writing the current state back in hotplug/target calls cpu_down()
which will set cpu dying even when it isn't and then nothing will
ever clear it. A stress test that reads values and writes them back
for all cpu device files in sysfs will trigger the BUG() in
select_fallback_rq once all cpus are marked as dying.

kernel/cpu.c::target_store()
	...
        if (st->state < target)
                ret = cpu_up(dev->id, target);
        else
                ret = cpu_down(dev->id, target);

cpu_down() -> cpu_set_state()
	 bool bringup = st->state < target;
	 ...
	 if (cpu_dying(cpu) != !bringup)
		set_cpu_dying(cpu, !bringup);

Fix this by letting state==target fall through in the target_store()
conditional. Also make sure st->target == target in that case.

Signed-off-by: Phil Auld <pauld@redhat.com>
---
 kernel/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..305694a2ca26 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2326,8 +2326,10 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
 
 	if (st->state < target)
 		ret = cpu_up(dev->id, target);
-	else
+	else if (st->state > target)
 		ret = cpu_down(dev->id, target);
+	else if (st->target != target)
+		st->target = target;
 out:
 	unlock_device_hotplug();
 	return ret ? ret : count;
-- 
2.31.1

