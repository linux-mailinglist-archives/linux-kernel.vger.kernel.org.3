Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E504BF907
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiBVNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiBVNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:19:05 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E3EC3307
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:38 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j2so14402121oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Qcw9bKKE/I3YtOTGrr/IloXYnLQKsqmcABj+F9w5gU=;
        b=c8BAJ4m67w3KkA6R8MfDkVVbI33E3DVexeALTYofb5l6z5ouhhOz4fZsya2JyYKPgi
         sat/gkEnc4YCyfXFmsZ6JizPCfEvFBKy3sUlF5kqA1LOCaburVgG3znbklkOywSEkBWA
         G4dNPu+gyva002SGyTd8sipk9LyYX5MNusk7OkITM29UMV63h0QVBRWT6pIy3yDo9idu
         jgK7nVvQLQAScQ/Glv4ROveNyabb2dodxJT5dc5JgNJIC0pXpAIFcfOgR8kMlIPvhSdn
         hLddDjV84SiN5tH1H6kiw2/03Ghq9xeP9fyF2dPGNWNLtG9Zvhe8yLlqRFgwIim9Y3FD
         ZvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Qcw9bKKE/I3YtOTGrr/IloXYnLQKsqmcABj+F9w5gU=;
        b=upiVh9BZSIuLHM/FjoemyJ6Qa4qj8ereeuWNtQZHP/mMfWe2oadrWITId9uTL/wgIq
         gJ4t9TDPHTDJrqB5HjJvNtUk7e1X0f7jq8b74CYm/AiShb/XYWxVFCTqR3aJcCY/J26t
         8ikjJsCIS97DoJXNlvf2gPOddRua9TSrrVxkn2OU5b4BKBVLe8pRtdsN4QS2mWyKdFWd
         OeFoLfC9hrsO1FAwF4JbI5aptPCOjgDl/aV2HUr2LsJLvP94Ie9/WF5eOTwOrnSrcnSz
         DZ8c/2qTvqQgwyPsnizN5S+CjS2uyEBqYNcoVjQ/+IpxS9rFOjbqSj1B2r03xLMoJV99
         DmhQ==
X-Gm-Message-State: AOAM532UbO0QDHo45kyBhX/JIbrc+mG2DWlnGAsyN515YKuAxCQtgwbp
        KLOPuM9I87687nSvlOHBAp6JbA==
X-Google-Smtp-Source: ABdhPJxEgvmm3gdK2nB9u+S/MLEXPpJvc+viMUQ4NlZZF4yuwT7VswodNQo1pHuKz6DJMA/hokhwcg==
X-Received: by 2002:a05:6808:11cc:b0:2d4:9b7c:6d76 with SMTP id p12-20020a05680811cc00b002d49b7c6d76mr1803271oiv.193.1645535917778;
        Tue, 22 Feb 2022 05:18:37 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:18:37 -0800 (PST)
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
Subject: [PATCH 09/10] drm/amd/display: Add missing prototypes to dcn201_init
Date:   Tue, 22 Feb 2022 10:17:00 -0300
Message-Id: <20220222131701.356117-10-maira.canal@usp.br>
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

Include the header with the prototype to silence the following clang
warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_init.c:127:6:
warning: no previous prototype for function 'dcn201_hw_sequencer_construct'
[-Wmissing-prototypes]
    void dcn201_hw_sequencer_construct(struct dc *dc)
         ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
index f1f89f93603f..1826dd7f3da1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
@@ -27,6 +27,7 @@
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn201_hwseq.h"
+#include "dcn201_init.h"
 
 static const struct hw_sequencer_funcs dcn201_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
-- 
2.35.1

