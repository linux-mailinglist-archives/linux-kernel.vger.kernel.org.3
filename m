Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00BF4C8D56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiCAOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiCAOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:09:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943411D0EF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:08:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d17so14352462pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 06:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EXe7kCkvoVySWS7NDybEWGjJI7VTkRTM5K2XTeA48M=;
        b=BnU3SGJbHdN3D2WYcP41BQh0jc/9FhwlQ6R6WZaEaAgS9KAo3pZ/5usqTELZf3m6nl
         XP8S3ynDO2vQTblrp8fv7x+65QPQem4s9ITfvrrzTOqj0VSUjyockkKba98UnFlwEjA/
         Us4Q0ie0b4UUlUfkOc2Bm0GEf6yyGD7BDbQvrB3WoqYlpTYXHrgYHHg+dHs9K/qSbgO3
         3FuFYMECTJYdkNTrXAGBG+yBQIPxRuNO+3dxJcRV815UKSj1aCQ+d1iJFhd3i0mQVmee
         wwAl0cPRe0NFzhCvAzC+dJ5YA61MfcpNdmDZm0U9AR8430Vk+A+6OhNSfwd3LXqBWQyj
         Nvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EXe7kCkvoVySWS7NDybEWGjJI7VTkRTM5K2XTeA48M=;
        b=0JwslAHwL4Ck/zFn1sVGBrIw5Esy05COVCRlOyGIvF59Z4YULY0uT3JvwKQ7FyW6sF
         S0e7Zr6BHu23WCI1WYurKwizKriDwJS6zs/Z1mO3/MAv3K6oRdl/ZkJZSid4HsTkDPmf
         DgW70LBw81Ikf0PJINmmgubyJTm8DtUyFKMd2ESVl/S91WL3Np5LIzPUeJpoQ4yX9MKj
         +cOTBksxM+BgmbFFBcfGWscbl7qWx4zXuNv+kCqq7UNcwpWX2YWsA6Sa+/XkPIn1qWOJ
         h5Beg7zdV1QjFEzGsze3fe4FAzdAbfCFY6JFoXkmlASYnjzum52cJaRFFIB34Lif2TEx
         TySQ==
X-Gm-Message-State: AOAM532MxAe0RtDLqhmaJk0hELvBHyfnIgGVe+Z4EdWVkpWkLt7J+GNZ
        zvnphr9I+7qEKZWWem3/OJ7VJA==
X-Google-Smtp-Source: ABdhPJzXPDrukQGTza7+DOawnjWJWVOY67CPIgDYANP1SXI2mtt/5N9lBLvXpLy2FuBE4dw1bE0vsQ==
X-Received: by 2002:a63:4a44:0:b0:372:db13:5583 with SMTP id j4-20020a634a44000000b00372db135583mr21596475pgl.210.1646143731686;
        Tue, 01 Mar 2022 06:08:51 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id q24-20020aa79618000000b004e0e89985eesm16310318pfg.156.2022.03.01.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 06:08:51 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, joe.lawrence@redhat.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] livepatch: Only block the removal of KLP_UNPATCHED forced transition patch
Date:   Tue,  1 Mar 2022 22:08:40 +0800
Message-Id: <20220301140840.29345-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_put() is currently never called for a patch with forced flag, to block
the removal of that patch module that might still be in use after a forced
transition.

But klp_force_transition() will flag all patches on the list to be forced, since
commit d67a53720966 ("livepatch: Remove ordering (stacking) of the livepatches")
has removed stack ordering of the livepatches, it will cause all other patches can't
be unloaded after disabled even if they have completed the KLP_UNPATCHED transition.

In fact, we don't need to flag a patch to forced if it's a KLP_PATCHED forced
transition. It can still be unloaded only if it has passed through the consistency
model in KLP_UNPATCHED transition.

So this patch only set forced flag and block the removal of a KLP_UNPATCHED forced
transition livepatch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/livepatch/transition.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5683ac0d2566..8b296ad9e407 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -641,6 +641,6 @@ void klp_force_transition(void)
 	for_each_possible_cpu(cpu)
 		klp_update_patch_state(idle_task(cpu));
 
-	klp_for_each_patch(patch)
-		patch->forced = true;
+	if (klp_target_state == KLP_UNPATCHED)
+		klp_transition_patch->forced = true;
 }
-- 
2.20.1

