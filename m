Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01E158E343
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiHIWfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiHIWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B165817
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:34:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv3so15801304wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=KfyPZURWlklvfmYT3VEFPFFamPr8Uj2ht16c+zF2xnXiTDOiSrgmcoN4rGRx9kmLdA
         txDPiUbXSloZIWzcwh46XiAhQtaahH18D3reai0ISdHNrLBmUPzrGIZmIbT8rIGyaCbj
         dP41MCi93zKmFloo0SK1KIt/GOttlc6WlTtOdDFQiFqJcehoFqRpAEYADdIii0rKB6U6
         FHHjQDlU8h9IM4lx05PQD7EUj0x4fwMWXkbMl/bkdNMSve8WAGgzM5xs7Nln5l3jAjXi
         dNiU8Vxm1CLCWcZSrt0HIXDYlTE9ox/QYUJMC5ItCcdWaqrGGYAPrmrTIYmNPppnTHia
         hRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=0ldC+eKR7vSnHiu7mdv4EgcoHThIOs1+eyIGZQaHHVmgw/TlZ9NUMde87aP3lVt1eo
         q3uadn7RA/eywu5FoL6n+0afRyoVUBb4wb9tyBKdWYFhsKuJYr/OWPXikhooLZaZu7MH
         uM6GsknIU/7/pH8n4sQ4EhFPgDVZWl6gazvxN6BzONOLOnMfQY87mgYSgzbtvktUY8By
         3JGkfFG+XmEkgCOfJV5A4VyTImnm9MSTm+5eeNpyAVp2/lymVYLV3WHYL19GtJRKghTn
         xVcOyC3V1Lly03NmcXLEF7azL8nZGsMJXqORMCHSpIZzLFuAMSpviTqA5UYj47gZPB73
         RPIQ==
X-Gm-Message-State: ACgBeo3eeUurwi535BUsy1mdGtO4naS1U248vFNzYT58i76X3yoJbpx4
        87JmsXzP4VlVb23KOGjeRJWIXA==
X-Google-Smtp-Source: AA6agR5PnwDdpAvLHMvCp6HiwJ28jxHiC1oddi+y/u1VMjCdhK6oOz7Ycxefb97Yha0mnATrTvJhvA==
X-Received: by 2002:a05:6000:1102:b0:220:5c10:5cbe with SMTP id z2-20020a056000110200b002205c105cbemr16129284wrw.359.1660084456145;
        Tue, 09 Aug 2022 15:34:16 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:15 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 10/13] kernel: events: Export perf_report_aux_output_id()
Date:   Tue,  9 Aug 2022 23:33:58 +0100
Message-Id: <20220809223401.24599-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
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

