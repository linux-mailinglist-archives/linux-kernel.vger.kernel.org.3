Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA55570C99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiGKVQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiGKVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187CE823B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657574184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLmRjFgRdRfGxyaNnmOGdO+qzhincW9I2IkPSw2Cgdg=;
        b=Fl6RNpIBiFQB9VeCNkImGO4mD96qhG3sTD6kr+ykKj8Egdgj9jIK9jJaW/3jvaHOhl/QnE
        MaGLioFv1WFyaIgbFu5eIROKgkJE+wCUnNfx9Q/poBAlJ0czNbSy+TwF4HCnQ9Pqq5qFap
        Qd3lG/k78RI8NCjFR2c9MObGSw5X3n8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-d3oeHARRP4iykw2aRydtAg-1; Mon, 11 Jul 2022 17:16:21 -0400
X-MC-Unique: d3oeHARRP4iykw2aRydtAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB191380451A;
        Mon, 11 Jul 2022 21:16:20 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A918D2166B26;
        Mon, 11 Jul 2022 21:16:20 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v3 2/2] cpuhp: Set cpuhp target for boot cpu
Date:   Mon, 11 Jul 2022 17:16:19 -0400
Message-Id: <20220711211619.112854-3-pauld@redhat.com>
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

Since the boot cpu does not go through the hotplug process it ends
up with state == CPUHP_ONLINE but target == CPUHP_OFFLINE.
Set the target to match in boot_cpu_hotplug_init().

Signed-off-by: Phil Auld <pauld@redhat.com>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 305694a2ca26..104f43a6f4ad 100644
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

