Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949557CDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiGUO3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiGUO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FB3181B2D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658413743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g8hbGfcC3t7kTzh0ZPdNVBr4O3qAdtse/t3zfVgk4NA=;
        b=GxfzpQZBqZqMkuCR5kMomQNTu24hA572TOv44n6A96OZTGlGsow7NGVnqBuq2MlTTxVjq7
        ZhybtQ+M37QSNyMHco2GFBfxA7Y/I9c3CVas2C9nGEMbC6JAA2PHOzANhWT9bLry1uvFxh
        yZ2XRYk8YIOTrYOUxJ3x0vufunkaDBg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-NpsUqWbLMJ2nJHMsgvV5hA-1; Thu, 21 Jul 2022 10:28:54 -0400
X-MC-Unique: NpsUqWbLMJ2nJHMsgvV5hA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50DAB294EDE2;
        Thu, 21 Jul 2022 14:28:54 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2903540CF916;
        Thu, 21 Jul 2022 14:28:54 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v4 2/2] cpuhp: Set cpuhp target for boot cpu
Date:   Thu, 21 Jul 2022 10:28:52 -0400
Message-Id: <20220721142852.2712895-3-pauld@redhat.com>
In-Reply-To: <20220721142852.2712895-1-pauld@redhat.com>
References: <20220721142852.2712895-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the boot cpu does not go through the hotplug process it ends
up with state == CPUHP_ONLINE but target == CPUHP_OFFLINE.
So set the target to match in boot_cpu_hotplug_init().

Signed-off-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 979de993f853..3f704a8896b0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2690,6 +2690,7 @@ void __init boot_cpu_hotplug_init(void)
 	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
+	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
 
 /*
-- 
2.31.1

