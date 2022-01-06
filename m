Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3044862DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiAFKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiAFKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:21:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D9C06118C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 02:21:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso248050wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 02:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vofa99wOtjdFhQhezy1E37S1XL2YEBI129eGPWKU4r0=;
        b=AkSlh8gb7jpmbNYLGFkTRZdIAm6J/JWwiNQFLKrw/yYGhw9wDDFg4Ck8+y9+iip6m5
         S3UF7XghBkOX6qnO3UMtnkoxqxPd29oFDkl97gJnmlEWPOmFIKHKcruowRF9uVhDOiwU
         8/CkOHy3Q6EfpoF0e4wo9Ljy9ZWkDYGRW6zgd/nL+jCN1/+n0ZFm5EtNx1fb4BG1KcRa
         jtPUufIOwbvnWZxzF95UCvxU79Y7TWlujBg+K4X5jNSxPD5zFgkd8SsDD/+EwKitwIGi
         iHkGSwhz6Rbm8kz62cKsv/0c7uTfBwwLyEAnlhoM+9Tz/FSGBWIaWE72dtId4vsOCpDO
         kxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vofa99wOtjdFhQhezy1E37S1XL2YEBI129eGPWKU4r0=;
        b=1TTMq0tZodpI9MGIrkWLOgvAYjXg3ZvVVCfgHNEI9gBdbCLg5nNQCwFDUNpxNjC8R9
         Bwo3qp8RFzeBpCbCpD3tZfaRFmlLlu0aR0wGNGOmDMxLdoE8w90aZkzXvFb2veqO2F4f
         paK4vNx8hsGWl/uOdGJPM8nLn6R7QHVIGC9r4kxh5UePAu/oC7EKWElXMzYaqp7Na5P3
         mhs4YEUp0ZiYfRXzQoF8dsiA6l7Q9eJwIhPOLiElP7cXcymjkyMvbRHU7UCfdIjSBVsm
         rMtHtAFI9B2VM88o6wDJsfqbovV/KFYLTC5q/c869wKPAj95uR9fbgCa4YpE71B3GqqQ
         FsCg==
X-Gm-Message-State: AOAM5335lYGZdIGXrr6MJUsnKjPDf2iADgw0ftMZX1xa+TPUau+V9guy
        3CmUnvcXT30uo7e4bgDLGPhzRJzdGt0zlQ==
X-Google-Smtp-Source: ABdhPJwah5mmg5z0b3I2dVAhlRIO2OW86Atm2uCjEsx8sUJHA2GWVLIkl73EMPgkPGVB2Mig3FpmSA==
X-Received: by 2002:a05:600c:3d0f:: with SMTP id bh15mr6517240wmb.27.1641464460943;
        Thu, 06 Jan 2022 02:21:00 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id c7sm1852172wri.21.2022.01.06.02.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 02:21:00 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2] mm, oom: OOM sysrq should always kill a process
Date:   Thu,  6 Jan 2022 11:20:27 +0100
Message-Id: <20220106102027.634842-1-jannh@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OOM kill sysrq (alt+sysrq+F) should allow the user to kill the
process with the highest OOM badness with a single execution.

However, at the moment, the OOM kill can bail out if an OOM notifier
(e.g. the i915 one) says that it reclaimed a tiny amount of memory
from somewhere. That's probably not what the user wants.

As documented in struct oom_control, order =3D=3D -1 means the oom kill is
required by sysrq. So check for that, and if it's true, don't bail out
no matter what the OOM notifiers say.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..3c480b24a93c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1057,7 +1057,7 @@ bool out_of_memory(struct oom_control *oc)
=20
 	if (!is_memcg_oom(oc)) {
 		blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
-		if (freed > 0)
+		if (freed > 0 && !is_sysrq_oom(oc))
 			/* Got some memory back in the last second. */
 			return true;
 	}

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
--=20
2.34.1.448.ga2b2bfdf31-goog

