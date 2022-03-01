Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6DC4C83B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiCAGG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiCAGGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:06:25 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5162120;
        Mon, 28 Feb 2022 22:05:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 195so13572989pgc.6;
        Mon, 28 Feb 2022 22:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUjj6TEe+83dCjS8RX0jAf7rSkzSpvGOk1hJbgvtBtY=;
        b=DxYpK0jV+QEPd20yIaRaBcP5pT5xy0FoABCkWe/WDEq9qlcMIEEXZ4iXcH8x6a/Id2
         jTfA4jsZbhVee4h+e8jUxmnWz+ym+UxXVqf9Yj+jyvwuIw4bMZKBh++iMgugY7fYOYMl
         iwSqicVK/G4VW5MPP+qDa1NQKl90Ma48qf+2C+U4DdOyd2eKNmQIuqv7o/2YTt2IJJHz
         f44wFrtst1fNuaoRayEdYpugwSlizSOGojTgzvynk5FxlI/bA5WOpUG4EaygL//GwthA
         Oeur+PFX4AWmZPyYbwYyc34SRsvWLnqwE4/NqhV6zeSxgH5Zazl8wkBI6isQfjfeucoR
         mc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUjj6TEe+83dCjS8RX0jAf7rSkzSpvGOk1hJbgvtBtY=;
        b=7cb1OIA2RSpdbTCPCecaPFzInXajZnsqJkEz/W6j2KuAvH6N/syTmkzNO7EVjTNd3T
         po3TBrM9AMcJ5EybApqIps53gc99J/A7BVhehyPpaucNVeOQgjKy5Nnwigf7Nu3Mmk/M
         TG+LQB93N7Xgx4Ns8NIIjVwtZCEnAX+meQ7eNtiw6Pls83BEqKVhteljR/LOTcackATX
         hkzG5O8lLMmGs9yjflGjLdrV+dMquPgD6NQJEuQcJRckESwzYnOCSlFJNYqnTabrtzVR
         V8sdnPgnX8QD0sTEVlFSdwYAvt33yIAgYDVhOTH9QGp+Neb8ya10ZKgXsy+elixkFaCP
         GltA==
X-Gm-Message-State: AOAM533wNAjpw8cQU5YBE3VuveqcAyUN4J+mbYDnerlI91cPd7zzy8g9
        AR29fTjOKXAScaCnrUxwKMI=
X-Google-Smtp-Source: ABdhPJzoM5r6A72aCOV8FF/+Op4ZDplQaiVIBtr2PnIg7IFjdp32qTPOMs+QHihMavXo6ljYJ/wkmw==
X-Received: by 2002:a63:921a:0:b0:373:df77:ee5d with SMTP id o26-20020a63921a000000b00373df77ee5dmr20027488pgd.90.1646114744736;
        Mon, 28 Feb 2022 22:05:44 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9005:88cd:3423:e74e:cf1d:8494])
        by smtp.gmail.com with ESMTPSA id q14-20020a056a00150e00b004f1252a21casm15567872pfu.161.2022.02.28.22.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:05:44 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] media: camss: Replace hard coded value with parameter
Date:   Tue,  1 Mar 2022 11:35:30 +0530
Message-Id: <20220301060530.5870-1-jrdr.linux@gmail.com>
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

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot reported below warning ->
drivers/media/platform/qcom/camss/camss-csid-gen2.c:407:3:
warning: Value stored to 'val' is never read
[clang-analyzer-deadcode.DeadStores]

Replace hard coded value with val.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index abbfbf448893..2031bde13a93 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -405,7 +405,7 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(0));
 
 		val = 0;
-		writel_relaxed(0, csid->base + CSID_RDI_FRM_DROP_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PATTERN(0));
 
 		val = 1;
 		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(0));
-- 
2.25.1

