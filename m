Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDB5B2739
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIHT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIHT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CACA50D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=omuRsfdH4SASi5AXCw7JGKydIaf3lsqyRLYETVJdhrw=;
        b=Pp4Dugk6jLOzeoauI8kv3tyjeJOeUUTAuCuGWqwKPeuxGKAe5g12Pd4o2BmQ1APk+ahimi
        n0DNTuJV3cdX8AafJKtocV55gWKuruaydaQtlLZeMv4i5tPQ2iAcMqVMeItfYq26hnDGSy
        2lTkujP0075cPwOiIKFdW+S5MH4A92s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-L6ZgRyXdPK-C3UIZmB_0JA-1; Thu, 08 Sep 2022 15:57:16 -0400
X-MC-Unique: L6ZgRyXdPK-C3UIZmB_0JA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A2B680231E;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 287F21121315;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 253E1415BE29; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908195111.813208840@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:29:03 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Prasad Pandit <ppandit@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH 4/7] clockevent unbind: use smp_call_func_single_fail
References: <20220908192859.546633738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert clockevents_unbind from smp_call_function_single
to smp_call_func_single_fail, which will fail in case
the target CPU is tagged as block interference CPU.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/kernel/time/clockevents.c
===================================================================
--- linux-2.6.orig/kernel/time/clockevents.c
+++ linux-2.6/kernel/time/clockevents.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/device.h>
+#include <linux/sched/isolation.h>
 
 #include "tick-internal.h"
 
@@ -416,9 +417,14 @@ static void __clockevents_unbind(void *a
  */
 static int clockevents_unbind(struct clock_event_device *ced, int cpu)
 {
+	int ret;
 	struct ce_unbind cu = { .ce = ced, .res = -ENODEV };
 
-	smp_call_function_single(cpu, __clockevents_unbind, &cu, 1);
+	block_interf_read_lock();
+	ret = smp_call_func_single_fail(cpu, __clockevents_unbind, &cu, 1);
+	block_interf_read_unlock();
+	if (ret)
+		return ret;
 	return cu.res;
 }
 


