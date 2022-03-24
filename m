Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428424E691C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352869AbiCXTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352858AbiCXTLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:11:54 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D137B82DA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:10:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DC8801218FC;
        Thu, 24 Mar 2022 19:10:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 58A72121C39;
        Thu, 24 Mar 2022 19:10:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648149014; a=rsa-sha256;
        cv=none;
        b=0nzXfzfLI07AaejyBkztazlRPVQfvN98+FGboF1xM3Qu39nhUECQNmFA3C1KzirWvun5ry
        rxMITcKiBMQPu8om5iq1E1UKwqiayUNbr1z/ZDEytdGpXRLTVj6YRn55gy9a0rDu+Wv1DX
        TyiF1LIpHkufpsvFLDzjgfX4wuQXkHc33bJ+a+sfmLqbDPEdMB24JnUyUSbWGX5n4KUHP0
        XWevHy9eFcAf7I9GtEe3Oyv+rDeDIhPq47Wmix+39CDsNvll3ggDj1EAhrJfXnhsa3eW+e
        ENF/amEd8TivAmB1yZxj8XAWdxKzRk1Qb0sNDXb+VPRdbqL34RN70cUDXrywIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648149014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Ef/BhbfXwmRdWt8+0XEDOKb36uGcLnF/IyiMjiB8D58=;
        b=PIa71Tms2QdiN6UU1vZQDzf9pgWrOqsEqvdmRJJBjZyf18A26r3mkQ0dkmhfHmWrbSL4ia
        rq8yR9QK5jeXw0B9/wFdTOiAqbCDCVDpz8rKWy/ZzGziSPX+GaXFD0aCxRNH2ck6rWM4EW
        6nR/F18wL67UShoS3vpjfCwrtZhzw+pHL4sAIYYjXNBAEz3H8S5mi9+aeuXvLumLKWL1Gs
        cYUFNHIqcHZxb45x3wqTCOQhunB9HmNG+cDmfJPASsDctkJS58eNplMFX1dgTV3xRZuU8l
        aVaXBO2poYetBN5jgwptu0PydiVK72LYYmJPRt8xaV3qpiBBpC9XH4XHEYbw0A==
ARC-Authentication-Results: i=1;
        rspamd-7b6f4d8d7c-bzsvp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.153 (trex/6.5.3);
        Thu, 24 Mar 2022 19:10:14 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Cold: 6c6a2a0908ddba89_1648149014717_3988453761
X-MC-Loop-Signature: 1648149014717:1742392537
X-MC-Ingress-Time: 1648149014717
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4KPZYK04DMz2p;
        Thu, 24 Mar 2022 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648149013;
        bh=Ef/BhbfXwmRdWt8+0XEDOKb36uGcLnF/IyiMjiB8D58=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=E9rGkPZUfIij56Cr/ZcU85FPINwwDZMLBs1RCp0VMUQ5SMPnPlyOekTd1/1IXR9wV
         d1fwUTZYohGRHv3o4gk9vx4kFwrCG9jobtw6ZSa5Lx1xWo9TwoCQL0MmCxpcva9S86
         pcK4FuxEBg7ZlJCoK0Uj+ReS+GdwwiDbDtJLHQtoaqZpjrQi9no8JsdqN/5fYPxnOI
         TwUP68JS3wLJz+H0V82HIfah+HxIQfcA2GW9MfgVsG7xKlUxl2SxNgtFPWkvGKoUyf
         J0XIFLLQNZEBqz725+300Yk+r/lABWM9TPAZ6WchrIS7XWbUusnFLqXBVVfU/VXutS
         QjaXzhaBZeYpw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 2/3] thermal: int340x: Consolidate freeing of acpi_buffer pointer
Date:   Thu, 24 Mar 2022 12:09:49 -0700
Message-Id: <20220324190950.70486-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220324190950.70486-1-dave@stgolabs.net>
References: <20220324190950.70486-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a single point of freeing/exit after ensuring no error in
int3400_setup_gddv().

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 .../thermal/intel/int340x_thermal/int3400_thermal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 0e7931c286ec..e299873d50b8 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -508,21 +508,18 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 
 	obj = buffer.pointer;
 	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 1
-	    || obj->package.elements[0].type != ACPI_TYPE_BUFFER) {
-		kfree(buffer.pointer);
-		return;
-	}
+	    || obj->package.elements[0].type != ACPI_TYPE_BUFFER)
+		goto out_free;
 
 	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
 				   obj->package.elements[0].buffer.length,
 				   GFP_KERNEL);
-	if (!priv->data_vault) {
-		kfree(buffer.pointer);
-		return;
-	}
+	if (!priv->data_vault)
+		goto out_free;
 
 	bin_attr_data_vault.private = priv->data_vault;
 	bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
+out_free:
 	kfree(buffer.pointer);
 }
 
-- 
2.26.2

