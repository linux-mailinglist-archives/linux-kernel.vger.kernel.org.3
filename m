Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9E9515ADF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381401AbiD3GwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiD3Gvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:51:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3E95A3F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:48:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mm2-20020a17090b358200b001bf529127dfso5077301pjb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GeQWWpb7hSenLoUe0GCOurCDS2buJqCf6mD/mdND6RA=;
        b=GxqtjU7z1/Yi7PPUrU3fh3jzvYEJRZI+4NwyLjJL6H7KZK/NwHn69HZu/oQqayd3mB
         TQ0y7ZUFxqpR9eEj+4Hhdg3a4neA82sL0wMS989rzvMfBeQUGRv6dapcxz6w93yJpXrO
         kh4vKgCiT91OsLVNLDTvj5m92gJ5uBgFLobq7awLraSVnv41JycyJWhzScnL1zLlIowR
         fXs/buiilbxV+PJzkWTFaex82Es3IvucpuZmpmhsZ/H7NusmGzDhH/D6GgbiDIiN9OYz
         VCrnMJ+1P/CCkSBww8wd0DT3drgI+stnixFy6IX9Js5lRhhOcXKtKRE8188uL4/6WsPH
         eWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GeQWWpb7hSenLoUe0GCOurCDS2buJqCf6mD/mdND6RA=;
        b=u16zAo+PM5D/tcp5k6NQagie/cHP/eIdOBfXHeM4GGzT3Pa0Y0oeNGfaRtK9oiPHcN
         iGDcEx7ABVAbEA744hDB1q1GISRvM/usZ/XdPlsfEMOBkgjEnOVGiU8AYiEcahfug8YI
         IkFqcz1RPXJ/CVS30j37TEXSJWUqhnoyuH3I0rmujMwmikTOhcEM4qbbt6aWPS3TopD5
         +UVdm7tRZuEOx5tyiLu6dbApru7R6Z/x+EH3fLQlo9wT3Fijym82xI30C9cU5OVRYLzu
         gaLnvZP1Na00jCEcraqbB5GLBSUbu8lt66uCy6AzIjJEO+eQ2DpE4DuFbg62yc9mho5H
         VAAw==
X-Gm-Message-State: AOAM530oFXkOTXehNsQp49zyLBc8ZuEQC6ADNRn3oE1XdaG88vpj3qy6
        9STwsN3ZmHXCrsFUD0EU61N7BBxAmNqih5ikonw9b6cUw1wQ3C5ERIhr3FakNX+QNdqTM2JlTRk
        j1MvMtyX67TQ5PdcR9TdX5TnkCITL9enC7+68Ra8Nt7GRLc57y4e71ZERj2FOhcdAnLsvuPs=
X-Google-Smtp-Source: ABdhPJwdx9Zc3SgUtmO7KHyUG5+D34SjTofR9ka1ov86dmBxeYKYd/6S4VCnUHN2xxaG78d+Ik0i+omoeiUq
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:b613:b0:156:7d82:c09b with SMTP id
 b19-20020a170902b61300b001567d82c09bmr2856411pls.80.1651301313794; Fri, 29
 Apr 2022 23:48:33 -0700 (PDT)
Date:   Sat, 30 Apr 2022 06:48:28 +0000
In-Reply-To: <20220430064828.2470989-1-jstultz@google.com>
Message-Id: <20220430064828.2470989-2-jstultz@google.com>
Mime-Version: 1.0
References: <20220430064828.2470989-1-jstultz@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC][PATCH 2/2] drm/bridge: lt9611: Use both bits for HDMI sensing
From:   John Stultz <jstultz@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Foss <robert.foss@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 19cf41b64e3b ("lontium-lt9611: check a different
register bit for HDMI sensing"), the bit flag used to detect
HDMI cable connect was switched from BIT(2) to BIT(0) to improve
compatibility with some monitors that didn't seem to set BIT(2).

However, with that change, I've seen occasional issues where the
detection failed, because BIT(2) was set, but not BIT(0).

Unfortunately, as I understand it, the bits and their function
was never clearly documented. So lets instead check both
(BIT(2) | BIT(0)) when checking the register.

Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index bf66af668f61..a11604a56e08 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -584,7 +584,7 @@ static enum drm_connector_status __lt9611_detect(struct lt9611 *lt9611)
 	int connected = 0;
 
 	regmap_read(lt9611->regmap, 0x825e, &reg_val);
-	connected  = (reg_val & BIT(0));
+	connected  = (reg_val & (BIT(2) | BIT(0)));
 
 	lt9611->status = connected ?  connector_status_connected :
 				connector_status_disconnected;
-- 
2.36.0.464.gb9c8b46e94-goog

