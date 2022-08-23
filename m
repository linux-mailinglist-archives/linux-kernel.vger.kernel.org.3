Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9B59E009
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356592AbiHWKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiHWKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC1AB052
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so5000120wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=LG0uBul7JWvbK6rlaTen26I5SXJEv/D7DhhHJp6FhtNH2DaSus7+I3xfk4h9h8cBxY
         ju4ArQTKNm+S0ZIVLPqoV/KU/WxjS1OSM1Q6rGiQPYbal2gzih3Rfd1Z6B0NPAYtWw0U
         wVaeolxhGcg+lWcx3tt9AuR8zz70Nz/HCITxS5npAfmC8MrHsmDzlDSp/4I9Xwxn1PJi
         4aTaFfS1/awdlj9KmBI9MS1RnJj+vdHai6IFfvUjglgL3nXjeeKhwKYWnFIIegfjSLHv
         3A4J4dKECJWAU52w/v1gykJTeOWmWSOLY4961lhUWVCk0Tq0+V4iyvFxUvsrI/pW1BLO
         REQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=VpiMdjpudXpkD77Rz2511GuWmvgSyLR9f6SqULOvfOxIsYzo08TOBCfa9ym9A9FXHT
         jhRjwM6KrfdjRHGWsqZLP/g0f0kAkVM1rECqkMSzoV5O3od1WaXohh5npt0gi6jcBMxQ
         lonE1sdBr07PWLSmfTUcos4Cl+IqzJzvzI5WUfy2m5OnRi2tk+01mQ4xYpHNkeVD6oSY
         36DxvcuwpjvTIgKeZm27XTLnbVyKgeqQ2GmRtJoFkbQa6iHuepxVlzsIr72vnDjOkeYl
         jQzDFprbfkjXHqR5ha9358/SNyAProVtRGfXu+fGorg4ttTGHortBL0qhO0EQ5PZDQv/
         O5Gg==
X-Gm-Message-State: ACgBeo2xU67IyNEFuUSX3E1wfWJbVaLajD7VfLVNlJQpgOmm1kGMNtY+
        ByxNqhZy16j+NQmdcJFXA5TvPw==
X-Google-Smtp-Source: AA6agR5i0OGJJj/Hn6w7u4mF0zrw3CvQptA+b0ncS08T4HuYTJy2luWzxhEJienGgJdv18Byld9Igg==
X-Received: by 2002:a05:600c:154b:b0:3a6:1863:acc0 with SMTP id f11-20020a05600c154b00b003a61863acc0mr1541219wmg.29.1661245824501;
        Tue, 23 Aug 2022 02:10:24 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:23 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 10/13] kernel: events: Export perf_report_aux_output_id()
Date:   Tue, 23 Aug 2022 10:10:06 +0100
Message-Id: <20220823091009.14121-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight trace being updated to use the perf_report_aux_output_id()
in a similar way to intel-pt.

This function in needs export visibility to allow it to be called from
kernel loadable modules, which CoreSight may configured to be built as.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..f5835e5833cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9117,6 +9117,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 
 	perf_output_end(&handle);
 }
+EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
-- 
2.17.1

