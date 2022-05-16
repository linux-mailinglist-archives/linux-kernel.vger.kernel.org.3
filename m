Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11277527EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiEPHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiEPHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:44:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA1C24F04
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:44:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso13594543pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7GuWHsJybHMQGpKO0nmV9x7SQtARUoRM/1CQH6XR9g=;
        b=jhAbH65rJRpjxi787HhYLR7MxfS7Km1gQDSHipikR+X/k0I3MorZBjDFcrS1ZsDOT1
         qiJTnH8FhghWwFV7fkwUgBKTxZa77mjbxd96NZGjPp1Jo8O/cP7BSeFTdDYidGocDSdk
         HQc3sFHNv8qpY3HTccUjeI9XAUhBariveV0AJ6T/cTKOIK1YHDMbI1I6qNXR7YGbbWiw
         doA60CZKDuDjhp3xoO78GljWrGq7nmY2axy7udbqSDZ5jpPUSNarW/8otX06onWAvG6o
         Sa+Avg7WScsMXAnp9o44YNYV5ti9PZl96FbmBwP7RKyzusZJ7RAuENFNdlkAr+rGXrUC
         7C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7GuWHsJybHMQGpKO0nmV9x7SQtARUoRM/1CQH6XR9g=;
        b=Xerc/o8OLM1L38uSoT0AVyBoFHl0pJiNB3M9whZKHnO1MXrIIu6234qHyZnV1n9CQA
         XrrGJeOwEk0Q12Yvqug6VkyIVOU+/BYhMy14FIoWtLu5/LmgGSTWRwGyPakgW9Ik4xF+
         /PITyR+IyrhiqQiNW+SxgIpv885cv878Dd9ilkaslHMcQmPyKjbOcbyHqDETwBlseD1M
         /dGOeXXlbOw+hwHuogyr58AQJXYY2FSuQjMLkJ/tniVA4NgNHrfUiwsvGHvMY479LjY1
         +vv6b3o1hupH2WDCUui5518F+0OusZfqMeyKo97RQrw6vb6YoD+MeYpdjEIgR6oyn0aQ
         qnbg==
X-Gm-Message-State: AOAM5336HXGcKBtUfbP02WzSBdBAPeRm73/5YfWpKuoxAB6LN1Pf7UjQ
        4DLXUqKhH/T1jecx/75RiTA=
X-Google-Smtp-Source: ABdhPJyLvH98LklY2E6TRF91Nh6p+BlKJA9ZsYLI8kfsl2/dp5boXhBGYLNMEcQ4JbGJdHLa4EF2jw==
X-Received: by 2002:a17:902:988e:b0:161:8750:480b with SMTP id s14-20020a170902988e00b001618750480bmr2133268plp.154.1652687081061;
        Mon, 16 May 2022 00:44:41 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a1f4c00b001ded49491basm13290517pjy.2.2022.05.16.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:44:40 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] regulator: scmi: Fix refcount leak in scmi_regulator_probe
Date:   Mon, 16 May 2022 11:44:33 +0400
Message-Id: <20220516074433.32433-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/regulator/scmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 1f02f60ad136..41ae7ac27ff6 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -352,7 +352,7 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 			return ret;
 		}
 	}
-
+	of_node_put(np);
 	/*
 	 * Register a regulator for each valid regulator-DT-entry that we
 	 * can successfully reach via SCMI and has a valid associated voltage
-- 
2.25.1

