Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7928F5A22A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiHZILG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiHZILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:11:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8FD2771;
        Fri, 26 Aug 2022 01:11:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bq11so855866wrb.12;
        Fri, 26 Aug 2022 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=v4H+4AvGFUQ4X3fIy7w2GNzFwXOQBQhFujlzuWD9IjY=;
        b=OuOtNoLcjmkerE26piau/BBAmyQeBWWJkFV58GBry+HSm1QOf12Wf52ETbS/4swFqt
         RpG0fLp7sf8KvPbnEj9ZB2pTKlL3bUVHjcowxS2N1cnm4WnN+B7kDFFipvgXAOXWgZs0
         MfLFr6BQKC4USPKszgF7/pPZcr3vHgg+xVpQJn4YMBFKmQ7+wTn8mtWeAoQal3vI3cqv
         GPzr/Byw7ZiQXZco5ec70eUVMuohUFyEAGDp+RX3hBqzUFdjBJj9S9z4lgVtrMdpRsBi
         OupQC1G8CwSlHs+JVynTj0+4eT2PAfs7c1p/JFs4WrNbFMdDpaDxiBLyNZQWQGNGL7O/
         gBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=v4H+4AvGFUQ4X3fIy7w2GNzFwXOQBQhFujlzuWD9IjY=;
        b=GbbiYpseqH4CDESt1zzKrG2ERypZfQSjAwVd2AW4LCzUb2BMn5492KQjDco8dP95fT
         Au4gOHxzVIki5JDqNZP90ArmDzI0EHAs8TdjeWECvQhB/bPoIW00fcvvZlzehQ1f2Tnd
         L5Zx9BNvC34tuOLFA03FsfeNEN1BjKVcDrQd5RWkRLiJBEjp9JvD62gnlMpnkJzP6W5U
         Wk3M+5wcsIIeoravcJx12OqA9O9de3PljFHOsw+dSh4SIpVxVCoqUtE9fUfeVOAEmftD
         ve3aMwDiNiwgJODbkdwdVY47XfNGcLyLKwTejf4m5DNpnY1pGHlhyw5ZbYInzKNHGBLT
         RWMA==
X-Gm-Message-State: ACgBeo3xqust+s/KvHCPp+/Fs+HI/IP5Jsgb8AoFcAA242CevcrOTB7t
        vPND6omhJyGBpekskha8IzI=
X-Google-Smtp-Source: AA6agR7ysxe9JNOKfIwiIIgPuKqoR5ZYpJJUcQVOQgPdpzLzxZskEsNeXkzfxokh5KxwZ7dlKEKHTw==
X-Received: by 2002:adf:d1c1:0:b0:220:5ec3:fb62 with SMTP id b1-20020adfd1c1000000b002205ec3fb62mr4154423wrd.69.1661501459865;
        Fri, 26 Aug 2022 01:10:59 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u10-20020adfdd4a000000b00225232c03fdsm1500927wrm.27.2022.08.26.01.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:10:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Rahul Kumar Singh <rahul.kumar.singh@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@Intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/guc: Fix spelling mistake "heatbeat" -> "heartbeat"
Date:   Fri, 26 Aug 2022 09:10:58 +0100
Message-Id: <20220826081058.1605094-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a drm_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
index 01f8cd3c3134..d7857cf7c08f 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
@@ -61,7 +61,7 @@ static int intel_hang_guc(void *arg)
 	old_beat = engine->props.heartbeat_interval_ms;
 	ret = intel_engine_set_heartbeat(engine, BEAT_INTERVAL);
 	if (ret) {
-		drm_err(&gt->i915->drm, "Failed to boost heatbeat interval: %d\n", ret);
+		drm_err(&gt->i915->drm, "Failed to boost heartbeat interval: %d\n", ret);
 		goto err;
 	}
 
-- 
2.37.1

