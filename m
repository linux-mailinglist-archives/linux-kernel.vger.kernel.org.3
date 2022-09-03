Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031B5ABF2A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiICNwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiICNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:52:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C1C5C342
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:52:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so4632710pji.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+5qJofjqWUy5lZd4VFANhZ1h3tbGIlYWCmOlY/PP/TI=;
        b=ikS8uGLT+gKKILkbfV234ebG/8G8CMCxL4Na1lxbBBAottTVeeQGurTywX4GwnYCZ6
         GduxIdNJ3v2bb1KvUrQbQE774z3wacW1B9BvLHCUf+jSs91qZwFlakLdnzqypnfhFMMx
         75kDOyjHNuDs2bDljMrA6Gr05UP6c7r5oL8MWJztzdzwZ5ts+VTQTE3sOs4S0sZjpVc3
         HP6QvN0dMB1tt9moTZMCZ6N4lbGJXAxCfk+YLs1o07Po3KndiQMwc+OdmeDQFhUgKKB7
         +kOPD8e0WAsurGaRbOcHRD0XrkaL+xvg+uo9Y8UOLEkqgBfYdNb37T+ZJYzjdAQgN0WC
         3PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+5qJofjqWUy5lZd4VFANhZ1h3tbGIlYWCmOlY/PP/TI=;
        b=MHy2cd3xg3HCzq1bM8dZwn9p0N9r0aEHbRgYcm3+irxpnfsKvZWP3Jcmuglpi8BUHl
         RPwaKN+Z28Agju0n1cmTK4MEmbS51t1AF7f78ljAgaJj20FNguzmNXfJqZp2z+tWvsx2
         bpLujzC2lrf+DwuFw3CeSBgX+ntYsUwWD0jOS+V2Vtn9+TJ4rOKZ/xsCbZWcEUOfwVqM
         XnaS+5790PNDRuOZu9NsOENcT2UCML/Fl/x6dnqFa6sFpPIOnLiwdDLISZDnkufiIQYR
         9JmLSEgS5kvapvibocSC6vRppmojYi41oxOYFP1d7hCxZ2snma84pRDSytFdyMDpcDc5
         Fv+Q==
X-Gm-Message-State: ACgBeo0Xlh/2wrfCyGtpIQ3OjoATsyBvTVwaaU6Jcrz7JPwcd80BT6qZ
        1k9jShBfcvj0OpvpQXn2QlR1un8BtsY=
X-Google-Smtp-Source: AA6agR4m4I/IgNV99zfo91P/hqcsQKGEgL4seVwSMqVfxswgoxOUBkAn9qbc2f16qHgR4eLEakc3YA==
X-Received: by 2002:a17:903:1205:b0:171:4f8d:22a7 with SMTP id l5-20020a170903120500b001714f8d22a7mr39642617plh.164.1662213159196;
        Sat, 03 Sep 2022 06:52:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id u195-20020a6279cc000000b00537eb00850asm3986204pfc.130.2022.09.03.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 06:52:38 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     mcgrof@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] latencytop: use the last element of latency_record of system
Date:   Sat,  3 Sep 2022 21:52:33 +0800
Message-Id: <20220903135233.5225-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

In function account_global_scheduler_latency(), when we don't find
the matching latency_record, try to select one which is unused in
latency_record[MAXLR], but the condition will skip the last one.

if (i >= MAXLR-1)

Fix that.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 kernel/latencytop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 76166df011a4..781249098cb6 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -112,7 +112,7 @@ static void __sched
 account_global_scheduler_latency(struct task_struct *tsk,
 				 struct latency_record *lat)
 {
-	int firstnonnull = MAXLR + 1;
+	int firstnonnull = MAXLR;
 	int i;
 
 	/* skip kernel threads for now */
@@ -150,7 +150,7 @@ account_global_scheduler_latency(struct task_struct *tsk,
 	}
 
 	i = firstnonnull;
-	if (i >= MAXLR - 1)
+	if (i >= MAXLR)
 		return;
 
 	/* Allocted a new one: */
-- 
2.20.1

