Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB314E691D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352864AbiCXTLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbiCXTLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:11:50 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A9B82D8;
        Thu, 24 Mar 2022 12:10:16 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A9FB32A2F4A;
        Thu, 24 Mar 2022 19:10:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E27C62A2D14;
        Thu, 24 Mar 2022 19:10:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648149013; a=rsa-sha256;
        cv=none;
        b=ikrL/FRlJrmDSdm8eK6R9vC8KwT8dU1cgNagVULJ6ssIp2iT29Rp1rxSyeNm4P+ivUpLGN
        x6i+K9EkdinWxfyATJYjygU0n8QwdBgLuVeqR74eNIJyt2sYSXUbVfDjHpPbI/5BIppPXX
        fNezTnQWDWltaEPj53kh1hZFpGg52iy1BnauMdOf+c4b4t/Wv0IuFpx8X98BdgCUTCVkl/
        Kzg0bMo04K05bV/vXufNRRUPolg9826CKnu5ZK40+DYAQAwf/3heWugOqNdmitPeZnCyFB
        zoTp58LVi64SlbFHvDIMmRYvxD7gh1wxtivKJE4m+SQGZSNEXgkTHwOYq1bwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648149013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Ung/rILZ29OpCBmyEd160HryqWv0UQx2teHkWsgSM38=;
        b=vd50b15dwiUpw7EQVVzkwKHgGxFl6AHuSNJ/G2qUGGB1Gym+iCbznvkK0yvGWuGfpY7do3
        DtrnfLvQYAIz2QBgVA+UE+URIy+Mj130Uvi/CzZc+K9vTzIk27D/UaNxqrOSGqvpf/9VeD
        Z/Kfu2VKYquu96QOr6myWS4Kvml9W5mXwjljCnCR609DWakkpuGPMhttCxQXEjq6wb5nxU
        /e6DKn1ri6x0YX3OZ5nttkAKZFQdW6u+4asAIsewIefm+E6lM0pAWuJlLju6go3a19Ob28
        dw8Dp/8AjAkvlIO5rwj8BygLms8G48j1r4sbafhUaOnceCERXEp9/WVcV3eKAA==
ARC-Authentication-Results: i=1;
        rspamd-7b6f4d8d7c-ktks5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.255.147 (trex/6.5.3);
        Thu, 24 Mar 2022 19:10:13 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spill-Quick: 7398b87717486304_1648149013455_3469798804
X-MC-Loop-Signature: 1648149013455:3057219792
X-MC-Ingress-Time: 1648149013455
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4KPZYF46G5z47;
        Thu, 24 Mar 2022 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648149012;
        bh=Ung/rILZ29OpCBmyEd160HryqWv0UQx2teHkWsgSM38=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=htxnRqLBpOT5aON8j9qGAFa3WdpANECm4YVDV86rUH19UHc34hss4a/GOLtVZGDHf
         iT30v9iBTk3Bj6HYWGanPooDbESSkuAJpmtwwdVuR/GLposKL0HBcMpR90iWMdb8Zg
         n3GtBxgyDM6LGTF6W55fWoq/wH8gMMXOq7plx4P+pAy+hgO+GCiSIvnsbBwK1WLJlo
         AsHWJwAJZ56VRD0IqiWnNkGX2yJUBkqXBW0PIePcoh84wEW/0FITJeTwGSqLE8Nin7
         g6r6X7PvTwgn+Uvv9fxopEvHlwa7nnz2UoD+AWKgyNfPBYpiCEGch4kiFqdz0dYM7/
         wv/tOiLXlEoBQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 1/3] thermal: int340x: Fix bogus acpi_buffer pointer freeing
Date:   Thu, 24 Mar 2022 12:09:48 -0700
Message-Id: <20220324190950.70486-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220324190950.70486-1-dave@stgolabs.net>
References: <20220324190950.70486-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is the caller's responsibility to free only upon ACPI_SUCCESS.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 4954800b9850..0e7931c286ec 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -186,11 +186,11 @@ static int int3400_thermal_run_osc(acpi_handle handle, char *uuid_str, int *enab
 		ret = *((u32 *)(context.ret.pointer + 4));
 		if (ret != *enable)
 			result = -EPERM;
+
+		kfree(context.ret.pointer);
 	} else
 		result = -EPERM;
 
-	kfree(context.ret.pointer);
-
 	return result;
 }
 
-- 
2.26.2

