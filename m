Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07274C803C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiCABP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiCABPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:15:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF8102;
        Mon, 28 Feb 2022 17:15:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d17so12746107pfl.0;
        Mon, 28 Feb 2022 17:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2N3D8QoxsO13zBELM1/Sh7gQDfV1csfU7R3EV5hbjg=;
        b=jAjr++urMjFqZOxqosIYjxZh6gr09ljDTG1GcyPszajT6UIGE90xMe7xV6+f55PGi2
         IMZc9keMiMgldlUik5lDaR5dXJ6eR6XabNDMP4QrBWxFqO6U05csb0Eq4VwPwwMdugLZ
         hs5LLsgh16882JU1xpHVR9sOMA9kyhfptrn1G4t6Z2Ett1i7nLbnvqZXc5Ylv1IvPl3F
         7+Rrb9YLS9Tcxfp4JCQXWZHFYkRp+G/Wgt/rXfO3bUMP0WsA22q6kHoTZYP96a3jfeWA
         Itp3CWib/DQ0QNjvpEhkCT5wlCDekPqamgzuSQS8NGJFuTfWcedAtb1HeLbGPF5TY3Fu
         adUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2N3D8QoxsO13zBELM1/Sh7gQDfV1csfU7R3EV5hbjg=;
        b=zhXoaLTEjwilOAXN7ZfjPm9Ecu4Y8HUOG3ZImTKpXnJ6eqnPJO6G24rV+l3FntWxmv
         6pN4r+syiepZf2hUJs10D7sikfJiJlGGugm0RU98Ws3iSsgLiXPaloX0SeLy0ty0FiS/
         iIf0Nf9ctN3lEgJZeieWlJeVvLjBX+YVed/kvVqu25WqjTlG1UkG3No+yRGUnSBrebyy
         hhIpvfBmTuK1UvFRSYYcJ0IjLpaQDjQ9yYP4XxyTTqSeEp9KQk0mH0Ihl6KIyjGAoIY8
         TGhhvFoas8VQyTZLUHVNeoldxXf8S7T4WMNJHLv+HxPuCFZERXKLGN7D3T/8W/zjyPHH
         OG5g==
X-Gm-Message-State: AOAM533kHZOLNE86RPNFWZG5eH/YmOKm2BUDPlqr2nrhdgcGngHHAuIQ
        J932jZGme3mbaRcBeNyzg0M=
X-Google-Smtp-Source: ABdhPJxuSyD3s5Dsiwi+BWQ5j4La3ZVUYFJ1aYPfrdAjAX1pB8xBzusNoaInIh8eZ6Dix6xZPtQqTQ==
X-Received: by 2002:a63:3e45:0:b0:378:c5a9:abd1 with SMTP id l66-20020a633e45000000b00378c5a9abd1mr3770459pga.25.1646097314412;
        Mon, 28 Feb 2022 17:15:14 -0800 (PST)
Received: from z640-arch.lan ([2602:61:739f:8300::9d4])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b004e1bf2f5818sm15568633pfj.87.2022.02.28.17.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:15:14 -0800 (PST)
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
To:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: mt7621: use bitwise NOT instead of logical
Date:   Mon, 28 Feb 2022 17:15:07 -0800
Message-Id: <20220301011507.15494-1-ilya.lipnitskiy@gmail.com>
X-Mailer: git-send-email 2.35.1
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

It was the intention to reverse the bits, not make them all zero by
using logical NOT operator.

Fixes: cc19db8b312a ("MIPS: ralink: mt7621: do memory detection on KSEG1")
Suggested-by: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
---
 arch/mips/ralink/mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 12c8808e0dea..fb0565bc34fd 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -69,7 +69,7 @@ static bool __init mt7621_addr_wraparound_test(phys_addr_t size)
 	__raw_writel(MT7621_MEM_TEST_PATTERN, dm);
 	if (__raw_readl(dm) != __raw_readl(dm + size))
 		return false;
-	__raw_writel(!MT7621_MEM_TEST_PATTERN, dm);
+	__raw_writel(~MT7621_MEM_TEST_PATTERN, dm);
 	return __raw_readl(dm) == __raw_readl(dm + size);
 }
 
-- 
2.35.1

