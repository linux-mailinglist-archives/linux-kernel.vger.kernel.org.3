Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386EB4BF902
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiBVNSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiBVNSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:49 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DECBC12D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:22 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so5096234otn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDN/q36ne++w24m6ta6Mu8DvTucc3A8JRf+sG15A4uk=;
        b=gwNgQ82BffFNGYRWppEJcVbH9lkHH4pDVyKTZaRhGLp+f2xO5A1Rx15s9yci3hHm4w
         FR1uQhg8pvxh6Nres53U9+5PeQJjeY4FqukANXW+8jQxQv139/laPSL8d4aiynsMT7my
         oM5Wamd+Hc1OYtVIoCGTe5UqhD9E3zG6UB+aAagv3NxkPhAqTy845/1Yegz+Ca/xHwmK
         YaQM48FZyG/26ee4ISyofDBH3oxrbmeQdpILyFa49nlOGi9EKrN2uGD9mf6DccDzN5M1
         DUU+/U+aSWi9pPrfoohDvEJclSE8CUZvlfVrqhZg4DwOkDj8i05D6c/wK2OrBZbxVyJ3
         DXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDN/q36ne++w24m6ta6Mu8DvTucc3A8JRf+sG15A4uk=;
        b=HQ2Ezb5aCrDwQZewMX5N5ZsCQe6hPZ6DnR2sY1SE0erTlIKss4HFWqfQp1Db7fp/k8
         zpvlqf+CygR3ujTASel+0+JTbT/QZGP167FJMW6Fq2Uq0g0zHsA2WzBdayo9vTcvygHS
         GdNfkNfPBJVvCMC8KFUtGjvX14Az9yVvFKvZtY+s9S2LJidGxNWbQCD2dK8K7+XnWZeJ
         ssXIYe2ig1hg173qHAn1DpDF0HH2hILWXAmKP4wgjxzL5+ZBfiLVVqgWFROD+BfjzMaS
         4ouRHyJKgS87ur+UW2CnsGXvWPyjekVH6cbw2OAAoyIGbWcxbG4CfjM5aIuiwWh0/tmT
         CgGQ==
X-Gm-Message-State: AOAM530+XFkACXgQiBdH298tEPBoNs3nrT84I/SQi0zy+X/JRDVFX4kT
        +4wUAvDDrsk9d8A+y3t/0ZMc6Q==
X-Google-Smtp-Source: ABdhPJyc2O86+E0dEG/No0hmALq+XxmG2EgDiNrBeWwpqJKHrw0001sfFqK9Y7CYkpxQ9BvdfQuGzg==
X-Received: by 2002:a9d:714a:0:b0:5ad:f8f9:b50d with SMTP id y10-20020a9d714a000000b005adf8f9b50dmr4817459otj.47.1645535902206;
        Tue, 22 Feb 2022 05:18:22 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:18:21 -0800 (PST)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, Hawking.Zhang@amd.com, john.clements@amd.com,
        tao.zhou1@amd.com, YiPeng.Chai@amd.com, luben.tuikov@amd.com,
        Stanley.Yang@amd.com, Dennis.Li@amd.com, mukul.joshi@amd.com,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, magalilemes00@gmail.com,
        mwen@igalia.com, isabbasso@riseup.net,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH 07/10] drm/amd/display: Remove unused dmub_outbox_irq_info_funcs variable
Date:   Tue, 22 Feb 2022 10:16:58 -0300
Message-Id: <20220222131701.356117-8-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused struct irq_source_info_funcs
dmub_outbox_irq_info_funcs from the file, which was declared but never
hooked up.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn201/irq_service_dcn201.c:141:43:
warning: unused variable 'dmub_outbox_irq_info_funcs'
[-Wunused-const-variable]
static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
                                          ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 .../gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c   | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index aa708b61142f..45f99351a0ab 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -138,11 +138,6 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
-	.set = NULL,
-	.ack = NULL
-};
-
 #undef BASE_INNER
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
 
-- 
2.35.1

