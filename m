Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA14F9E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiDHUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiDHUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:36:20 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901DB20
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:34:15 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso6918514otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tb7nkyFqE34RRTlLRoG1km8bVnXOaIVICbmcAyGpqE=;
        b=qf9hwC2ZAJUrQGucNvdkwy9P94NQ8YUJKTc9ftTiIAGVg717G2CRCsPSbCJ6QXaTXD
         Tfik5F8Aj4fWdkSr6sqTytj3f1nNXEl68b/Omv/Z0IVPiIvoaj8yu1XUunLvc7vIDCy7
         WLS2UOttB/CajtlOwArqft/vqJADfdcI2w/oJ7lavxpUUBs8qPjllbYetqPL+qKS3m0G
         LTvU8HnLXpA4CHfIK8aOJD18DAhupXBkF38Gs5CsKD+uztRVHTS7+aAX+6N40pfTtYMO
         HkaO1YkTBu8JCTMtGYHJlwdf4omD+PZiC9s25xrG2JylL3BkdUajNJy91RrzFXVD+ynp
         wglg==
X-Gm-Message-State: AOAM5312g33euLzxTMWECruGgSuPISuy0sz713BzFNzHKaYCoU46Lze5
        Pfn6+AcQXJWnsTiDVM2CpeL50Ul9Yg==
X-Google-Smtp-Source: ABdhPJzMzXVe63JufD0lQqPJtXEdj/NUIeQfYjOCpnAqM1V6RIgd/08z+V5fG3uzYd8mxZdcPLL19w==
X-Received: by 2002:a9d:51c4:0:b0:5e6:af95:d553 with SMTP id d4-20020a9d51c4000000b005e6af95d553mr4192298oth.133.1649450054362;
        Fri, 08 Apr 2022 13:34:14 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id l12-20020a056808020c00b002da28c240dfsm8968219oie.16.2022.04.08.13.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:34:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm_pmu: Validate single/group leader events
Date:   Fri,  8 Apr 2022 15:33:30 -0500
Message-Id: <20220408203330.4014015-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case where there is only a cycle counter available (i.e.
PMCR_EL0.N is 0) and an event other than CPU cycles is opened, the open
should fail as the event can never possibly be scheduled. However, the
event validation when an event is opened is skipped when the group
leader is opened. Fix this by always validating the group leader events.

Reported-by: Al Grant <al.grant@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/perf/arm_pmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 9694370651fa..59d3980b8ca2 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -400,6 +400,9 @@ validate_group(struct perf_event *event)
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
 
+	if (event == leader)
+		return 0;
+
 	for_each_sibling_event(sibling, leader) {
 		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
@@ -489,12 +492,7 @@ __hw_perf_event_init(struct perf_event *event)
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
 
-	if (event->group_leader != event) {
-		if (validate_group(event) != 0)
-			return -EINVAL;
-	}
-
-	return 0;
+	return validate_group(event);
 }
 
 static int armpmu_event_init(struct perf_event *event)
-- 
2.32.0

