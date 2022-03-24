Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED64E691B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352882AbiCXTMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352854AbiCXTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:11:53 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611619C23;
        Thu, 24 Mar 2022 12:10:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1301422550;
        Thu, 24 Mar 2022 19:10:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2948123242;
        Thu, 24 Mar 2022 19:10:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648149015; a=rsa-sha256;
        cv=none;
        b=yhzzIByvXbznGmKutQ9ZAWSbwQMbuGWTilGUm64TrYF6Ccs1TO7Uf23IrIO+PI31KT3Ij/
        P4fVeRl8bwJ/lG92xvGpZyW08tFH4xSGOCKpZNRSXTwBjuOsqVklHdH+EQaBhNbrHSI3FH
        Vqc45J5232wKLefZNw0NhtKhIHApzgKuHnr0ALOhkoWCNy4O8AtMR6Xw/5J3j4QC8zvHvN
        83mHneCyoEAnkj750wmePZYHf67hrpHt2UfXhfK6LhsgYQgH/AW+yfdfTbYTYl7t3t2luk
        jLRUtoEY54U383A/y4Y1xIndfwdo3+I099bcD2sAvbNhAD2gfaaCjO5sJ4uszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648149015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BwxgQMQ/2QhljL9zC+DXVkORb2bFuqFJtoHA8uaXDPM=;
        b=2Rw/rqdT+5eD3nW9xk31HLxjzWegMrBru41oK4xAs8qA4Xmq61imuiBzwPuiJKQtPnIhrH
        U0RryXjt1HNjYEeBNNb7P8ClxtpGuXPOqZ3XQteSakEyCEh7n23F4eNOZXGcuRkjlERjQa
        Cq48xhOQN9kNnfXqXCofZeztmYe/rA1mky870mVS4FDJDQAHfPyTlpiQcfq35D7SXmwFLH
        xdH37j/e90V4a8xCx+/5a8hf8oOScoFn8ZmtWbltToOX7ceDG259WRlIC7Ill/oBzbc/GA
        nI1/BaJFgrOSMb8O/kZCP0/CsG5CPnm9eOETAgNX2hVwLDPPVrsvMDIBXdxJRA==
ARC-Authentication-Results: i=1;
        rspamd-7b6f4d8d7c-xq88j;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.100 (trex/6.5.3);
        Thu, 24 Mar 2022 19:10:16 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Supply: 745c0e0402409ac9_1648149015893_1799478203
X-MC-Loop-Signature: 1648149015893:1003998337
X-MC-Ingress-Time: 1648149015893
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4KPZYL12FPz3n;
        Thu, 24 Mar 2022 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648149014;
        bh=BwxgQMQ/2QhljL9zC+DXVkORb2bFuqFJtoHA8uaXDPM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Et5Idvy8iG2kqDEXbmNVZSeV7oiOl/YMku3CwBRsx6njSKsGd6N/vI4unD7mCubWl
         /MgLrvT7pkNKM87Va6dqhSfssQ/37azCy+S29+UfttKc7/eB201ACm22f9TsD0MbmP
         PJQUkS383gQMLU7DsReBqQqBX11UMCfC1megklBP1WtHFIdKs2BsYzYYHzYuLF8K8n
         szosdjKT2o1xXznku/NhSLFqn8TDh7I2+lFkuJGQuRUcEkCM2DNfmLvB+lmsxtcehN
         Gm/CF9Z9ScxEz83o9p1MEkOkPgCq0+W6SZ6UAkA2RPS/4e+VTQbnKJ4JOG52o2j7BZ
         FarsdH0NJxpKg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 3/3] thermal: int340x: Cleanup osc context init
Date:   Thu, 24 Mar 2022 12:09:50 -0700
Message-Id: <20220324190950.70486-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220324190950.70486-1-dave@stgolabs.net>
References: <20220324190950.70486-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the UUID is already sanitized by the caller,
lets trivially cleanup some of the context arming.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index e299873d50b8..4c49a6c9d4df 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -169,18 +169,15 @@ static int int3400_thermal_run_osc(acpi_handle handle, char *uuid_str, int *enab
 	acpi_status status;
 	int result = 0;
 	struct acpi_osc_context context = {
-		.uuid_str = NULL,
+		.uuid_str = uuid_str,
 		.rev = 1,
 		.cap.length = 8,
+		.cap.pointer = buf,
 	};
 
-	context.uuid_str = uuid_str;
-
 	buf[OSC_QUERY_DWORD] = 0;
 	buf[OSC_SUPPORT_DWORD] = *enable;
 
-	context.cap.pointer = buf;
-
 	status = acpi_run_osc(handle, &context);
 	if (ACPI_SUCCESS(status)) {
 		ret = *((u32 *)(context.ret.pointer + 4));
-- 
2.26.2

