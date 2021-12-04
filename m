Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2746844A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384811AbhLDK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384730AbhLDK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801FCC061359
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c32so12839903lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lyygTkATiuRhrYAmCBZB5JL9b+QAE7KNyFgVnfdr4xw=;
        b=J2kd6EO490vWFXaCl7LFrz/8P4u3qpQZpH4icbSfDlEUamdenfJwJSwk8sGUtbknNU
         MLTEFM/WH7wO+lfql7YAzXRrRXzeaTlEkeVU/quW2jFMOQASudPRH0m0Fx6EJIksdY/N
         Ds95sfVar2uzr2QXFuSYCzFMdbI2gfcT7ZUlD4LGLqf5RdIsdXTU5DhyONHPytVZr3Qs
         04MMOMAs9/y5MyggQ2hEBp5zlIbKblHt6OA7gU3NZYcslhUlajcw+akJ9/rf9eiesOd9
         9AurWHrFWDlaTD9xKWXsCbI4j9W0IFu0NdWapgtBgogA87bmW7KHmXQS0TYCXvhkas8t
         HQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lyygTkATiuRhrYAmCBZB5JL9b+QAE7KNyFgVnfdr4xw=;
        b=OtjYx+G+Zm6WKaaNaqDY66G0t7XaFvEL6KgtOtxRaoAwTyanpdgVvCOhJZySyILo+N
         iQDXj0PzMnQUcmi/lrQYw0qJAcO1xQut+lGqotd/mC1O7aYWf5ZGOLbJPA1BFQscXxSw
         BDsKc3t0qZH9Ov97gBc8z7ME3cTYyeOGvdLh20TYqUBr+LhE0PDZKNEpuMKIOxTpsjUQ
         NFVeCy3TAp+1MBZkwuCRSbUh2SWd0gMwHlWdd+7tOIrrXsN1TrQ/KAyibNYPjr3mBBlf
         FcvzyIKGRWoU84CuIAqLhwLOUzhYd14QAP3nTU5u+LTLUgJZpcWT0uQTym5Zq9vhrGvn
         wKiA==
X-Gm-Message-State: AOAM5337S4MNNm8th9yHcs+b48zrLhWkbKuwuysWaHDQxgTB++LPtV9j
        B+AiNFmhOm1nawq/RElkKw3s5BK7xVfKsg==
X-Google-Smtp-Source: ABdhPJwhZ8OGJIequinMhO9B6h+dZNF751Hz6WheXeDJ4m/rXPlCuS/K6i21b3Ua8MdNSlwkxOjpRA==
X-Received: by 2002:ac2:55ae:: with SMTP id y14mr23157543lfg.27.1638615340844;
        Sat, 04 Dec 2021 02:55:40 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:40 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 6/9] drm/i915/gvt: Constify cmd_interrupt_events
Date:   Sat,  4 Dec 2021 11:55:24 +0100
Message-Id: <20211204105527.15741-7-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never modified, so make it const to allow the compiler to put it
in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/i915/gvt/cmd_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/cmd_parser.c b/drivers/gpu/drm/i915/gvt/cmd_parser.c
index c4118b808268..ce9307546e7f 100644
--- a/drivers/gpu/drm/i915/gvt/cmd_parser.c
+++ b/drivers/gpu/drm/i915/gvt/cmd_parser.c
@@ -1144,7 +1144,7 @@ struct cmd_interrupt_event {
 	int mi_user_interrupt;
 };
 
-static struct cmd_interrupt_event cmd_interrupt_events[] = {
+static const struct cmd_interrupt_event cmd_interrupt_events[] = {
 	[RCS0] = {
 		.pipe_control_notify = RCS_PIPE_CONTROL,
 		.mi_flush_dw = INTEL_GVT_EVENT_RESERVED,
-- 
2.34.1

