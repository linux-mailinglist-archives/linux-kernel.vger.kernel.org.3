Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78A46C841
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbhLGXgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbhLGXgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:36:45 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2D4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:33:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id m16-20020a628c10000000b004a282d715b2so506028pfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S9HhHEaCqq8juujlhIoNSDxxgNKBtqtxQU5YxI2svaw=;
        b=buSpmo6M3pApRVi2NMxwXaGteg1Oc/DvWa79jtkAI+ISl8TMCW35+eMMUUoyoK1QcC
         UNqEVoxRdO14/y7jxx3fFTNE/w03VlqjR5XRmzAjoaOo1cA5i/L16zjXiP1lJetwqWaW
         BaJGKQsoPMOZKtEVCEYj6C2Gvv2q1Qs6kzwiTSzyaSVtSZT5rxfRo3zEFhl0giCg8wCi
         D2tx/VgNUgAiLa+EXrAZltK+ZxoM05XdFIitPQ4pU11Wn46OdyarwbMXktqnTEpQDqWp
         SdUtliVCq5zCL1Ir3WMMMZQFNgz2Q0mLMQYgQur4KZ0oOgPibVDbZaOMEZXg1WxSl9d1
         q7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S9HhHEaCqq8juujlhIoNSDxxgNKBtqtxQU5YxI2svaw=;
        b=v3dJJ21dUHsFtLRZ1shVNQLk7gB6LJ+SoTOjXE6bZ0lgo4eGvlgKr00k832uh/ar7N
         o+ekQeytNyYbERq75x94jeNXL5r7s72Z88DUX8BpSQREMFgV5IFA5yY/XN2Y5acw2wCY
         iAUGTREYO1Th+FnDM5UnhxA3a68yeSksxKim0kj+Z0C1K0HhR0CFdL7yoMxOb3IDZ2/L
         jno0rS1jkUvbxqmYbLBY+eugcP1MTQoW6qc1IZt+aGclalicNQIlAZdRRx7IlXrE8SDF
         E+nR/8b2kosYoeuRNhIheryKruFwI86dj6H/99u9cw8Avf+7VkzPV1TLGKEj+YF1LZGZ
         V59A==
X-Gm-Message-State: AOAM531811JK+RbZXs4dzFraVruYGT9RcuYHi1/yVH9myfWPSBM5sJHL
        ribL0Jn0wqgLdw7bVp1JYh5Jya7n61Q=
X-Google-Smtp-Source: ABdhPJzik9hif76tFQLVlE/NgW3Vi0SZTTbgEMWcCDandafb499HCVkP0qAqheDHdbNZvEjUyQek2sCGZOI=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:46ed:9c47:8229:475d])
 (user=pgonda job=sendgmr) by 2002:a17:902:c20d:b0:142:21e:b1e8 with SMTP id
 13-20020a170902c20d00b00142021eb1e8mr54167478pll.27.1638919994074; Tue, 07
 Dec 2021 15:33:14 -0800 (PST)
Date:   Tue,  7 Dec 2021 15:33:02 -0800
In-Reply-To: <20211207233306.2200118-1-pgonda@google.com>
Message-Id: <20211207233306.2200118-2-pgonda@google.com>
Mime-Version: 1.0
References: <20211207233306.2200118-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH V6 1/5] crypto: ccp - Add SEV_INIT rc error logging on init
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the firmware error code is printed. This is incomplete
and also incorrect as error cases exists where the firmware is never
called and therefore does not set an error code.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e09925d86bf3..f527e5f9ed1f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1104,7 +1104,8 @@ void sev_pci_init(void)
 	}
 
 	if (rc) {
-		dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
+		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
+			error, rc);
 		return;
 	}
 
-- 
2.34.1.400.ga245620fadb-goog

