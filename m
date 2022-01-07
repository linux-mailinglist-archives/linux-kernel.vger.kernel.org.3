Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32726487069
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbiAGCbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345422AbiAGCbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:31:31 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5AC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:31:31 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id y9so4189223pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9zD8rbf6qAqQOxdkAoI37yqWQ/rdxMv8DCOF1Su0rA=;
        b=eBAGcmqHPUySjwBo0c8y0Aj1cvcnAhFIB84dAcxvbmc3oAPkiImoJPQ75rX3hqlhBi
         Zv3UIMa4j5guCaG4etDZciJ+I9uPpohxPy2gI/qHvDSC5TbjYweBp0y66IK459695Du0
         hK7CR8psWH0NlIH4nzSgEacQFHpOxK/cmW1s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9zD8rbf6qAqQOxdkAoI37yqWQ/rdxMv8DCOF1Su0rA=;
        b=5/V8Rd0W/wfIikd+YHvnMJno7JHn3bT0LCm472QKO9UkKLHx0S+EXkH8+hzZ2ETYap
         bFRIG0+24UyHduN0qBL9yEwTPlOopavgGfQxg8GlXjsm4YAUDu/fvNX4FfcHvFa/vjAT
         2i4/yuGKKlNJSUfhA4LHCgVh+WOqLIabcVaSNAQdPOjg3QfiG/3lCW2zO+knMmfEQeZF
         gJbZShW9ifvgJY7e8oSZAo5iLfyD2eEeZVj9vgw4yTVaMdTsAn7p/Tvqckd4mQWthAeW
         TOkKIksBM+S8KChe+uxb1ciQNutamIjKGPMRg1VhGISooJ8hcPMUs2o/Vx9ljedso+IN
         6nig==
X-Gm-Message-State: AOAM530YlAmWwbWq3evtAdmfidJvkEoonWaLXgJSlnVjl9oXsWy4XFdl
        AiMpvDIhVM+R4mhvX5IQXI7ROcQRqSTKyQ==
X-Google-Smtp-Source: ABdhPJxNsIGDWP/HrcbVTJ5pOscXT1zsV2PDTzSOMs60WRPb9n8fAFhu+PztANXdrBPmrVuEzUypnQ==
X-Received: by 2002:a05:6a00:10d5:b0:4bc:a0eb:c6a0 with SMTP id d21-20020a056a0010d500b004bca0ebc6a0mr22421007pfu.70.1641522691035;
        Thu, 06 Jan 2022 18:31:31 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:6942:d6a2:95c9:2ac8])
        by smtp.gmail.com with UTF8SMTPSA id z2sm3035795pge.86.2022.01.06.18.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 18:31:30 -0800 (PST)
From:   Knox Chiou <knoxchiou@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Knox Chiou <knoxchiou@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: qfprom: Increase fuse blow timeout to prevent write fail.
Date:   Fri,  7 Jan 2022 10:31:11 +0800
Message-Id: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180 blow fuses got slightly chances to hit qfprom_reg_write timeout.
Current timeout is simply too low. Since blowing fuses is a
very rare operation, so the risk associated with overestimating this
number is low.
Increase fuse blow timeout from 1ms to 10ms.

Signed-off-by: Knox Chiou <knoxchiou@chromium.org>
---

 drivers/nvmem/qfprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c500d6235bf6b..1840d400fb53c 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -22,7 +22,7 @@
 
 /* Amount of time required to hold charge to blow fuse in micro-seconds */
 #define QFPROM_FUSE_BLOW_POLL_US	100
-#define QFPROM_FUSE_BLOW_TIMEOUT_US	1000
+#define QFPROM_FUSE_BLOW_TIMEOUT_US	10000
 
 #define QFPROM_BLOW_STATUS_OFFSET	0x048
 #define QFPROM_BLOW_STATUS_BUSY		0x1
-- 
2.34.1.448.ga2b2bfdf31-goog

