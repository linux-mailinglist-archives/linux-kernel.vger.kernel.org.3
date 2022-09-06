Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862165AE0E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbiIFHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiIFHWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:22:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9150189
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:22:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x19so10516513pfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fPDIo8AnJ/TgVDHfUwRSNpd+cxGXL8zCoEIE9JVhIR4=;
        b=QDujIXtDWyc2YFHyGC7Xd5Ps1E5h/NkPYe1UYvf1ZfB3jliMkIiZFIz093ZU+onE5z
         wA+ZzlcsNNxL4fqYgipBx6VM3kv0EmGh6DEHO57FR3H3/UDeFHY6mIZz82f8aH5RHFgu
         3ELSBC6AHYnS8xkhX5GypU1CneYkXy6jGvfNDfv/rCq9DxP9IuZjBgv3HYpVLc++BaAR
         M6d7si/JXVas/hCOplCYhEPZiwLvMIu1cMWU2M8ZOFgM/xldW1DZYMjFSFZuXC9TZhzn
         Q9FucEHHdjx2Ez0jxDW0quNCgPFSbOgObZuE8yoQSdftv140fVnA7Z8ttox9Wwos/Fjm
         z5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fPDIo8AnJ/TgVDHfUwRSNpd+cxGXL8zCoEIE9JVhIR4=;
        b=vCrFZSeU4XQdd9wUqcKwVYPw7zVTG0FKWZ9HloZCTRCUDxWv2wVeOEJyrwfR23Xdi3
         0JQM7UGnrBVGaA2LDBAkC7nsb3POZMb/0NzSnlZ8TWALWMgtRyFmqOwXWpIc2vNThOs3
         n98qkyV3BS4WNGlwNCiowmGFPgEUxzgxanVwGSZWwUcmxEKNqM4jsY8Vc4iYhFQwmlqc
         ltcJ/eISraDgWCsck7JRm9yA90CyL1rYGBvFkwREm7n2oBUEVYWrcLNA9oXtbmF96DIC
         X0dloTUk31ChEOCIQVFqgHZ25xmi2FqxeCWqFXPkhuNmokBJSROr4W+wXSJmxwWU1V7q
         JKmA==
X-Gm-Message-State: ACgBeo0J33j1RsVeWRPSvrJK5loGlpd0VyB9zRe1xSBZEUCRdEKLBM92
        gnaG9izQQfDxiWpriyJ9q7E=
X-Google-Smtp-Source: AA6agR6E2jyI51Yo9+W4aYy6g/P8pHbNHdQ8NmXycBD2arC8wCYnG6oTCIESXdupKxlQq71WXrkjfw==
X-Received: by 2002:a63:4b5a:0:b0:434:a821:5ed7 with SMTP id k26-20020a634b5a000000b00434a8215ed7mr1765443pgl.474.1662448922425;
        Tue, 06 Sep 2022 00:22:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f64300b0016c9e5f291bsm8934853plg.111.2022.09.06.00.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 00:22:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tracing: Remove the unneeded result variable
Date:   Tue,  6 Sep 2022 07:21:59 +0000
Message-Id: <20220906072159.337188-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value trace_remove_event_call() directly instead of storing
it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 kernel/trace/trace_events_synth.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 5e8c07aef071..bf57801b139b 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -831,11 +831,8 @@ static int register_synth_event(struct synth_event *event)
 static int unregister_synth_event(struct synth_event *event)
 {
 	struct trace_event_call *call = &event->call;
-	int ret;
-
-	ret = trace_remove_event_call(call);
 
-	return ret;
+	return trace_remove_event_call(call);
 }
 
 static void free_synth_event(struct synth_event *event)
-- 
2.25.1
