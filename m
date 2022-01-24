Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D95498178
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiAXNxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235042AbiAXNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643032415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=10jjCwVWraQntNdBxVG806Q7wvKbwg1gvSBpyTQbEiA=;
        b=HWww4wEp+ry8Vubd0tXvNWJpXKEO2w1UNqd8lX05XgKGFOIxMp53uDZSsoBR5MK0KBEgUz
        j/OgvV4HehAOSP8whj8Ngv7ZEUFZ2slkoQs/iaS69A8MmQb0qGxR96KvFPeHlspqGTxk/o
        rkK8QhsL8mog0tXf65eJV0vmjx4xiNs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-PqWAcv5DP3CJ0M4jJSaVqQ-1; Mon, 24 Jan 2022 08:53:34 -0500
X-MC-Unique: PqWAcv5DP3CJ0M4jJSaVqQ-1
Received: by mail-oi1-f199.google.com with SMTP id bq20-20020a05680823d400b002cac339e9b0so9165683oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10jjCwVWraQntNdBxVG806Q7wvKbwg1gvSBpyTQbEiA=;
        b=hYOohnvFodlE3HLhecagvcgBbKDKDU15KscULDTNwNLUKLG4ogChkUUpnfFuXTChaW
         1u36UcrGSpJVdzNEvPLGzKGLU8ZlT6urkTyQTirD8kncU+Xz/cULXQCxMA56El6ofZPc
         X6XD5DDmQ+Mr7yKvuSJbaExdsHTZYoUWUqTrSaUG9kOAv/YZGhvMkTUBgvMyjvBmmf/C
         DF4McgnnuvONgNw7R7hwfRtvpHkjuGb78WMbr/g0F18reXTFSDBR8lFZj99GGhlWh0EU
         439SPNvHb0j0cugh0/UhHNzbgnX8DrnS0Vy5ylx1H+1TUBYPcwus/kIHToguhYetr7ti
         bPSQ==
X-Gm-Message-State: AOAM531gtSrYJT54i1//qVnZVIYswJ5bI4O+xxLbdwxlFgCECViO5jOQ
        NIQ1iv5ZBbLKD6wkP+bpmjrWg28vElFyobt0MUR3xAowpylRS7FyD4oSmIeT0wwFoimcUQcr1ZY
        wrMv3wq8iHUm0ULeVvQY6kSeg
X-Received: by 2002:a4a:d095:: with SMTP id i21mr3016411oor.66.1643032414029;
        Mon, 24 Jan 2022 05:53:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXcXYp8AXPTplh6to4AiTnWP2fz7OgXjj9IzEQpUNCJmvn968uNUEQkbgSQYBOEJwbNzIXMA==
X-Received: by 2002:a4a:d095:: with SMTP id i21mr3016389oor.66.1643032413803;
        Mon, 24 Jan 2022 05:53:33 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v26sm1881619ooq.20.2022.01.24.05.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 05:53:33 -0800 (PST)
From:   trix@redhat.com
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        lijo.lazar@amd.com, darren.powell@amd.com, guchun.chen@amd.com,
        Arunpravin.PaneerSelvam@amd.com, andrey.grodzovsky@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/pm: set min,max to 0 if there is no get_dpm_ultimate_freq function
Date:   Mon, 24 Jan 2022 05:52:59 -0800
Message-Id: <20220124135259.1057828-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this represenative problem
amdgpu_smu.c:144:18: warning: The left operand of '*' is a garbage value
        return clk_freq * 100;
               ~~~~~~~~ ^

If there is no get_dpm_ultimate_freq function,
smu_get_dpm_freq_range returns success without setting the
output min,max parameters.  Because this is an extern function,
set the min,max to 0 when there is no get_dpm_ultimate_freq.

Fixes: e5ef784b1e17 ("drm/amd/powerplay: revise calling chain on retrieving frequency range")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5ace30434e603..35fbe51f52eaa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -121,11 +121,17 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	if (!min && !max)
 		return -EINVAL;
 
-	if (smu->ppt_funcs->get_dpm_ultimate_freq)
+	if (smu->ppt_funcs->get_dpm_ultimate_freq) {
 		ret = smu->ppt_funcs->get_dpm_ultimate_freq(smu,
 							    clk_type,
 							    min,
 							    max);
+	} else {
+		if (min)
+			*min = 0;
+		if (max)
+			*max = 0;
+	}
 
 	return ret;
 }
-- 
2.26.3

