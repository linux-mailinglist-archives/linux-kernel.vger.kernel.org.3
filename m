Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972EB5676BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiGESoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGESog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:44:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF213F01;
        Tue,  5 Jul 2022 11:44:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so22064236lfg.7;
        Tue, 05 Jul 2022 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1MHwn+GKadhbWhl+pmiAbRLusUdng+bCgPqMGzl2ho=;
        b=JGANbw9owNb0x4nI1DqlH3Xdq34RtShqND/JbIgc+zpMCucrLZNdYuPFFtpLn+sDng
         +aSF0ct7OIRB70EeUH/veXoN9Qp0yneuMhuEzs1/w6V9HFf5WmwonZcZdeGvDgGg2efA
         TgfQDtx4TvnTrqUvHKU2Bb5D2TPnPGzeX7mtCvV6w7gjg8+tlT2Th8xlmQOYs3eVFFP+
         f7Q5Zm4ZG7IushBaY6EM6pkNqJ6lUV2Hro8irH3ydi8FyTKlyHc9N9giSLy0D8N/GkFW
         qnBaJ6zarBxS10FefAP46Ph90iX0+73oqwUN6zsVq5PlLnsZcEFrCuBjQApQyuc7DAqu
         mwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1MHwn+GKadhbWhl+pmiAbRLusUdng+bCgPqMGzl2ho=;
        b=PlArxUwAXAcREzLRrZ7PWJ1kcUIcqFYVpUZMru7lY2cV7EAeSJuacsxjl1RS7E64hm
         nfrf+o5MpFb7lFTFllfF/Gd+L18G5hI84d7mRA+Hwfuvfek9bmGoY/WLWtkgE1dsDIf0
         DXyDfHqgjl6XYz0TFMkzyhS4grp1mlbm8VwI+anryBPqrtNOaIehzsBggbtxnOMdzCfi
         GRa+6k6m0IdvDi4oS5pSzlkjc43sbRTpivndZCnhpBJkz01YfUI7VEw5ohNgK4j2/xVu
         nTwsOO0tQY0ELUP7IQhDpIuAjEle+MeABObzeKpZES8Yl+qXT6wzWokG/LSqr0186kem
         UR0Q==
X-Gm-Message-State: AJIora96rZFY5xYNVOtd1VF/6rzsXpmCw4q5GrPvXCfKcm/ZP+3W5w2h
        ojoWBjlad/04G0GFG82pOA==
X-Google-Smtp-Source: AGRyM1sAQWIhs5IUvlCo85D4kpQ9DcdJRAGvXmB/WdYHR70i9twVQoxHKc0/TmJylTK+mQW6WxMLTQ==
X-Received: by 2002:ac2:495d:0:b0:47f:a2bc:762c with SMTP id o29-20020ac2495d000000b0047fa2bc762cmr22347895lfi.93.1657046672731;
        Tue, 05 Jul 2022 11:44:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:df9:b500::20e])
        by smtp.googlemail.com with ESMTPSA id t6-20020a19ad06000000b0047f933622c8sm5835687lfc.163.2022.07.05.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 11:44:32 -0700 (PDT)
From:   =?UTF-8?q?P=C3=A4r=20Eriksson?= <parherman@gmail.com>
Cc:     parherman@gmail.com,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: gigabyte-wmi: add support for B660I AORUS PRO DDR4
Date:   Tue,  5 Jul 2022 20:44:07 +0200
Message-Id: <20220705184407.14181-1-parherman@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pär Eriksson <parherman@gmail.com>
---
 drivers/platform/x86/gigabyte-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
index 497ad2f64a51..5e7e6659a849 100644
--- a/drivers/platform/x86/gigabyte-wmi.c
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -150,6 +150,7 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
+	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z490 AORUS ELITE AC"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE"),
-- 
2.36.1

