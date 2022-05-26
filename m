Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1089534ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbiEZHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEZHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:24:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5308B0B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:23:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so423118pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTqU4Z0iceEowKyJ8OnRJpll4W/OvfT/neHBYcbAL/0=;
        b=QV+QiVzEVHRxaWHwjIT1P5TtkQU23krWj839r57SqTTZT2tB42XllsyiaWaRCyjbsd
         7BMbSW6b0mswJGQcfutKDc5ewlldmVaF8q0PigRtuarp3Pbn0eZs/x1rGLUj8kYpQWhH
         e/MGNyPGzFx/iIPQBH6K4zpktERY9bOLntXeFSOU8beRe3rltxPU5Ut4BCd1JkiDnblF
         n98Ka43HoUrUwim3Vlt7ohnwl+pWRF6A9vT7sASauoDc3UOmY+HTDgyZaY0aOC7P6iGH
         J6HIzrVM3b885Xti9SoHqTwYwtntEUZsg0b7zR9ZAFUPHdLw05aeu4xM8UD1L0JVjae4
         SE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTqU4Z0iceEowKyJ8OnRJpll4W/OvfT/neHBYcbAL/0=;
        b=pBVf5y9OhqhxdGI0/cR2/EwwYWE+p3WnSDV7SHLdi5M+os2axPd+3LeXfjMoHZXSQp
         mDmLZkH0US7+3A3hM9CGarmjoi33Rfh6cwBK0wOyZZejiXn+EpDqHPMNDH+1e3v4hOlI
         sMuC2ahrBSpMQ2yBj7Zm55iEfNfkIDYBOXb28mJkCq3kkuXg2mQGytHV+7USjsrkK1xq
         dS9oiQ/MyCr+E4XRHdoQeB5o4y5DtttxyDv6V1Ff2ScNBGqy0CRNiCOnQ6ZgllECz+CR
         a548sc1Mjz6ejm2znyiK8OT3IVDhBRAyNaI1VXBcQ3mZqBeom2Ese6wV+unlb+r9A/sg
         tX1A==
X-Gm-Message-State: AOAM532XJa9pWHqVk7zFmKuM+cjN84Sl84t5lFLMJMn6ETEFVXhxDQDC
        pOIyXWKJITRSHZsNRIepyps=
X-Google-Smtp-Source: ABdhPJyhQnpcTgpp58fJdgj8Ek6cEBZfBY2w/S+6deeVpyaT69ah5HLE0QVMNsnwmvewwyFMR0IPWQ==
X-Received: by 2002:a17:902:c412:b0:161:af8b:f472 with SMTP id k18-20020a170902c41200b00161af8bf472mr36159314plk.56.1653549837269;
        Thu, 26 May 2022 00:23:57 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q10-20020aa7982a000000b0050dc76281c1sm659168pfl.155.2022.05.26.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:23:56 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: arm-cci: Fix refcount leak in cci_probe
Date:   Thu, 26 May 2022 11:23:47 +0400
Message-Id: <20220526072350.15357-1-linmq006@gmail.com>
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

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
I don't include Fixes tag, because related code logic changes
, commit includes ed69bdd8fd9b,  896ddd6..., I am not
sure if need to determine one.
---
 drivers/bus/arm-cci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..f49237c209c8 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -538,8 +538,10 @@ static int cci_probe(void)
 	struct resource res;
 
 	np = of_find_matching_node(NULL, arm_cci_matches);
-	if (!of_device_is_available(np))
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	ret = of_address_to_resource(np, 0, &res);
 	if (!ret) {
@@ -548,6 +550,7 @@ static int cci_probe(void)
 	}
 	if (ret || !cci_ctrl_base) {
 		WARN(1, "unable to ioremap CCI ctrl\n");
+		of_node_put(np);
 		return -ENXIO;
 	}
 
-- 
2.25.1

