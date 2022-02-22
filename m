Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA84BF8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiBVNS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiBVNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:26 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B65BD8B6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:01 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s5so14384864oic.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ayEiTJoQMQ+jcjp3UMRNd5LwLeFycUhnaRc8GdLvEdk=;
        b=Wqh8WVyaB3/ePOUVG3qDmLXtRM2V02SqDxNeuWJZyWdRv9S3nWuGPgBol8HVCWBq8s
         DhdiEThHMeaf3oShHr2vzPZEF1glAHISZfrq3028oU3ta8gBcyG3ZW7qCSSEyHOTI3lB
         BnxvSUxinY/c3tq9cibM8S6EyjPjwHVN8UdKR268Zwpzc9EZjOU39PEj/kwRRPUwIzMC
         TJoaaWdEK9eQzLpnFNJIlDEy9QqLPUYMg7l3IH3RF7db55PMl9T1tKhWeuWn2GGMES0C
         X+a0prpgsJLlkvgbGmBRL1Skefle02K+m9wUWk7PYw5kkYDqo0dRaW0HX71nR2+EcEzY
         Q1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ayEiTJoQMQ+jcjp3UMRNd5LwLeFycUhnaRc8GdLvEdk=;
        b=EBfx5lwYRMByZ/aVYLXWJhxWy0NrID+VMn6G4STeM9ML6PWSi81LqAS7ixYAWoAlJK
         i7le6EmUIoIHHOA3VnY88h4/mZFlOaW+wdqfOnIOg5T4YHO0W2Q+LDylcx6JBC381GIt
         TmLHi4qiSYFtOi5Ax5MoBWKNUVKAHU72+5DR4F03NxkCmLXComAD5A8CAAkrQRX1sWYT
         9yTdej0NUFUYtltJ6UwxK7KbjuhiKautvbXigcviyh5khr7E1zVHg+hazioZVvMnkKL5
         WVgk0OhEjm6KvOmSAb4Ka5pHs2gbbV1b8dISEtcbW7BPOsJINonq+CyMTVPalh8Wx0ct
         MDTQ==
X-Gm-Message-State: AOAM530cUkUukIYoYbAMpEVF+9SN8n22/PyQTIQpPjwqmAhK5PzcmUKU
        6g+l9qLiQzYFHPTlphdvZZOg2A==
X-Google-Smtp-Source: ABdhPJwWSQJbsP6uAkrMylNazH+1ImSjAqTPKRnK19++tCqd6JrQXsgHYiKgvyoSEEmR6fmGiVSzTQ==
X-Received: by 2002:a05:6808:f0f:b0:2cf:3d64:2333 with SMTP id m15-20020a0568080f0f00b002cf3d642333mr1897906oiw.23.1645535880803;
        Tue, 22 Feb 2022 05:18:00 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:18:00 -0800 (PST)
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
Subject: [PATCH 04/10] drm/amd/display: Remove unused temp variable
Date:   Tue, 22 Feb 2022 10:16:55 -0300
Message-Id: <20220222131701.356117-5-maira.canal@usp.br>
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

Remove unused temp variable from the dmub_rb_flush_pending function by
using arithmetic to remove the loop.

The -Wunused-but-set-variable warning was pointed out by Clang with the
following warning:

drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning:
variable 'temp' set but not used [-Wunused-but-set-variable]
    uint64_t temp;
             ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index fb01ff49e655..d3088836d4e4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2918,11 +2918,8 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	while (rptr != wptr) {
 		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
 		//uint64_t volatile *p = (uint64_t volatile *)data;
-		uint64_t temp;
-		uint8_t i;
 
-		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-			temp = *data++;
+		*data += DMUB_RB_CMD_SIZE / sizeof(uint64_t);
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.35.1

