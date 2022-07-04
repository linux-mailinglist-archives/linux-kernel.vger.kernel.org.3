Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC7564F70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiGDIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiGDIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:12:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7051B482
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:12:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso7455880wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=plqraaSJUkeNCDGA4aEvfb+pg8+kvKD5XTON2+h9YBA=;
        b=oz12zjWXxiKYvIUnwdtU+1cpeW4xquYSJyHG0bWhwcfdSFfsDSCYoHXHy/Qjx4VSYr
         e1HSsp3iLxlQcFkWH7+LF6cQbnVq5OXaY7LHK9Mq38WxdbjljKhOlshcZ6D/njgfaBox
         VtT22S1fk56slCsu6XCkh7X/9D9SlseAHIoDINGoJOciVy/zHWho1/3Umceqv+m9+cbk
         /eM90nNK03YRXH/JNdhcjJk2uLPehskE5wZOhv6SupGyyTV8xvlrWPAB5CmdUxEzjixm
         mqNPj5LFBraN09ulIJ3q4MHOhjzJEpCPpwFcl+QkltjicBJfpsn0PAwBlX4n2BRsQNPT
         rQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=plqraaSJUkeNCDGA4aEvfb+pg8+kvKD5XTON2+h9YBA=;
        b=yBto/eDPAj5lDuAgVW3CVl3uDqcPvHtuWx9Wt4w0o755sfPsdFwhtk7NU8Fgnsd2o2
         njRaFuv6O0VcPYbsDDb5MGLh1dVDjsiaUEYc80miXozYkqWiyHJqu98YFXFV1tknK4nd
         r6/kcm1z1LVkrCGYb1gjtZSx4ItEg8nTOmLmufOlu9F1ZsKMubJRZtZZ+rRf+DZiCBWA
         rZFsD0oGXN/rbStlnuFwFvtoTtpncvYZlu/x4jyUoYcDABmKcwSAj+6Dk//cyt4TjiYm
         8PU5gWBiOxnpGoc+AugBtWJAXkZSYP5RalG6a0aYj4u/z1HMwDngEmmoANFpDETxIDC+
         Y5Sg==
X-Gm-Message-State: AJIora/THWzTmqgoWOxDq9RVmmSuRiZ5bH96L44VdP3neXnNa48Ni7ai
        /ntPxgGaI5X0MrmY198ULNTYjg==
X-Google-Smtp-Source: AGRyM1vcBm9hrS+Gdaug34C9Dljbs673NhCTJGPPhK8Fnlnl/szz96TTGBkFZVXyU/g5yAKaKRYb6g==
X-Received: by 2002:a05:600c:a08:b0:3a1:9319:ab78 with SMTP id z8-20020a05600c0a0800b003a19319ab78mr13105975wmp.158.1656922321341;
        Mon, 04 Jul 2022 01:12:01 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:12:00 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 10/13] kernel: events: Export perf_report_aux_output_id()
Date:   Mon,  4 Jul 2022 09:11:46 +0100
Message-Id: <20220704081149.16797-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

