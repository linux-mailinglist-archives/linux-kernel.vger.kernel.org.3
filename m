Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D24C359D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiBXTRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiBXTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:17:12 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853C6586
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:41 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id x193so4429742oix.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvWS3oa5I3x2kAQ3Snct7Bstqa7gnrjNdhiuEziq/dU=;
        b=JkG9j4xtSW7YFux2DfQ1IWJkCHhW6PI9tpZ3Eolo5e3HTQjgG7/eJewkdn9n4nFLcJ
         LMv6iYPulUryfWvUfTDyp6uGHOFOvEWfPfY8a302Mstq7k4TVNT2OE5E3WybkWTZNDAM
         rPJVC5+IaLwafCUep7U8BUKAP/efw5JhRnbrMY0aD7jDXwkv4SBHfPdCaGVw+IkswTwt
         bUYNXfueXk0AlOKRAp4li5srTypoWsgWi+EjGN0erU6UrF7oN22gLb7B/7b6bd4flwGr
         +txPSk2EtRJjsDIMhBaZgBSmg2K/zmCNP3NEKZYfgV3ZP0xn8UGrIt6D9kCpUTU2eGGa
         rmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvWS3oa5I3x2kAQ3Snct7Bstqa7gnrjNdhiuEziq/dU=;
        b=Y2kwJLuKD89Ic9uG58qXD7T31UOhH8YRq7hVLg4FMCSxy8t20k2Gx7BdmeRdr64tFG
         MdgDJUrwHOBO7+P9Rh4ArVd16/LH5kvXESvfggMxfYrcaWH9yxYd4ISbasHldr3Vek6i
         cpEtMGP3cTtJ6cbiBd8jxh33AKnipHvtVlkyfgv8SuuBAM6nde9A+mHuC30HNSiNKEun
         5a4S1WKwjqkfMEKWLIa925YalXwwn7ZKyyNJ2K4wNqxAdIt9ePlcelxnbyN6AnFmXJIN
         1TI1PtIc7b0giYghBkWAXHqRSFniQ0NB3WeC+0oOXEjmDU9agVV0TTDsd5SxH0xhsG7s
         k0ew==
X-Gm-Message-State: AOAM533d1OPqxKCC0B6XutH2Fj5vTJonq2/lDuS2bSb6Cmvof+4iL8ZG
        37mcDWgFc1LIL41TMQwmUfU=
X-Google-Smtp-Source: ABdhPJwm/qYulK2RcECTOgOP4yxZGphxfccVIGc7Dihv+vNvytMvIjB30p9z1/iUQFqG7fhxa7wRhA==
X-Received: by 2002:aca:643:0:b0:2d3:fce2:d82e with SMTP id 64-20020aca0643000000b002d3fce2d82emr7942829oig.209.1645730200760;
        Thu, 24 Feb 2022 11:16:40 -0800 (PST)
Received: from localhost.localdomain (189-47-54-110.dsl.telesp.net.br. [189.47.54.110])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830110300b005af14392276sm79509otq.62.2022.02.24.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:16:40 -0800 (PST)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     siqueirajordao@riseup.net, mwen@igalia.com, maira.canal@usp.br,
        isabbasso@riseup.net, Magali Lemes <magalilemes00@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/amd/display: Use NULL instead of 0
Date:   Thu, 24 Feb 2022 16:15:50 -0300
Message-Id: <20220224191551.69103-4-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224191551.69103-1-magalilemes00@gmail.com>
References: <20220224191551.69103-1-magalilemes00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence the following sparse warnings:

../drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:865:16:
sparse: warning: Using plain integer as NULL pointer

../drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1588:84:
sparse: warning: Using plain integer as NULL pointer

../drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:2725:84:
sparse: warning: Using plain integer as NULL pointer

../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1919:16:
sparse: warning: Using plain integer as NULL pointer

Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c     | 4 +---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 4367a6e0c224..cc8e60ec35c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1924,7 +1924,7 @@ static struct audio *find_first_free_audio(
 			return pool->audios[i];
 		}
 	}
-	return 0;
+	return NULL;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index ace04e2ed34e..8378b80e8517 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1585,7 +1585,7 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 			hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
 	}
 
-	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != 0;
+	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != NULL;
 
 	pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
 
@@ -2722,7 +2722,7 @@ static void dce110_program_front_end_for_pipe(
 
 	pipe_ctx->plane_res.xfm->funcs->transform_set_gamut_remap(pipe_ctx->plane_res.xfm, &adjust);
 
-	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != 0;
+	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != NULL;
 
 	program_scaler(dc, pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index ee55cda854bf..8104c0c67f78 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -858,11 +858,9 @@ static struct clock_source *find_matching_pll(
 		return pool->clock_sources[DCE112_CLK_SRC_PLL4];
 	case TRANSMITTER_UNIPHY_F:
 		return pool->clock_sources[DCE112_CLK_SRC_PLL5];
-	default:
-		return NULL;
 	}
 
-	return 0;
+	return NULL;
 }
 
 static enum dc_status build_mapped_resource(
-- 
2.25.1

