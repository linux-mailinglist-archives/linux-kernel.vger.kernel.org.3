Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02900563B33
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGAUcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGAUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011E14F66F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656707562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DwOaP2o/ijrgj8vUo4oYF/o/pPE6cbtbSwpHocDbRsE=;
        b=Nk6i3rinUlCOV5DvtWQ5uDHIEeb7WYBz04cdLoxdNIi7E5T5n5UYfiwCjdDp4fwGbHfQ+Z
        ShuaAdb4kiGJedNnobW1wjx1W7h3CD6xzrwV6I4elzYnL/7RGKFuzcCMlkBvOIi91n2QLd
        LJpxvg0OuLYE4IpVjakhSlsGhLO46aY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-pinSah4RNcqUEdxk9fT0Mw-1; Fri, 01 Jul 2022 16:32:40 -0400
X-MC-Unique: pinSah4RNcqUEdxk9fT0Mw-1
Received: by mail-qk1-f197.google.com with SMTP id w16-20020a376210000000b006af059b17b7so2768952qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwOaP2o/ijrgj8vUo4oYF/o/pPE6cbtbSwpHocDbRsE=;
        b=xHq31cJa7rd22j8tmfGsUofUCl/z6t6tSvblyo4hAO458UhkEKFsVJazVqPvBKnPqm
         DwuTxk3X/4tp1CFX4o/GMr+wROswcASDfnhw72yzUmb7aTOCzHhUAPp/u4mUI7A9ggSR
         CHoAS+HsAiDLX8zeMU5wlGMzGAhKw+NOjYaLTEHkkD1SuUjt0EvCPbHLLKLaa/HwhfuR
         17f3PHjHcZ0tjfBYTDwMiwRp/Tm5mx5hwJgGEaAlHXItvXHIh9BI2Rx8uRSkT7SLpnht
         IuH4G3/WxxtN6RPmH7qh28zkEEz8xbnzbYXACgovB5lDAQwnU/WxpbnxLKWTr2K4qVRs
         TiCw==
X-Gm-Message-State: AJIora+ERzMI98I1zuNv7G8DGpeQFo/4F0THy+KznBsgTYpBKCkE5zwx
        C27kMyaFqw6eOCvjj52P7beTJ7wfWl5gJRkxPPzrIJOO/CAUcG2DEG76v/836C3oXjJ9/J9rDo/
        755VEkXwStb+Z8J3ojSuGGKFx
X-Received: by 2002:a05:620a:75b:b0:6ae:e611:bd5 with SMTP id i27-20020a05620a075b00b006aee6110bd5mr11871042qki.319.1656707560371;
        Fri, 01 Jul 2022 13:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ugnMWyfmfVtM3ayR6RS9jLsuRyWUyzIriYbwM9D2BNQBRCrpDRP+IBJ4J8OiSPKazN46nuHg==
X-Received: by 2002:a05:620a:75b:b0:6ae:e611:bd5 with SMTP id i27-20020a05620a075b00b006aee6110bd5mr11871017qki.319.1656707560141;
        Fri, 01 Jul 2022 13:32:40 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c3-20020ac84e03000000b00304f55e56e4sm15139103qtw.40.2022.07.01.13.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:32:39 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, jose.souza@intel.com,
        jouni.hogander@intel.com, gwan-gyeong.mun@intel.com,
        ville.syrjala@linux.intel.com, matthew.d.roper@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/i915/display: clean up comments
Date:   Fri,  1 Jul 2022 16:32:36 -0400
Message-Id: <20220701203236.1871668-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spelling changes
resoluition -> resolution
dont        -> don't
commmit     -> commit
Invalidade  -> Invalidate

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 7d61c55184e5..e6a870641cd2 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -555,7 +555,7 @@ static void hsw_activate_psr2(struct intel_dp *intel_dp)
 		/*
 		 * TODO: 7 lines of IO_BUFFER_WAKE and FAST_WAKE are default
 		 * values from BSpec. In order to setting an optimal power
-		 * consumption, lower than 4k resoluition mode needs to decrese
+		 * consumption, lower than 4k resolution mode needs to decrease
 		 * IO_BUFFER_WAKE and FAST_WAKE. And higher than 4K resolution
 		 * mode needs to increase IO_BUFFER_WAKE and FAST_WAKE.
 		 */
@@ -959,7 +959,7 @@ void intel_psr_compute_config(struct intel_dp *intel_dp,
 	int psr_setup_time;
 
 	/*
-	 * Current PSR panels dont work reliably with VRR enabled
+	 * Current PSR panels don't work reliably with VRR enabled
 	 * So if VRR is enabled, do not enable PSR.
 	 */
 	if (crtc_state->vrr.enable)
@@ -1664,7 +1664,7 @@ static void intel_psr2_sel_fetch_pipe_alignment(const struct intel_crtc_state *c
  *
  * Plane scaling and rotation is not supported by selective fetch and both
  * properties can change without a modeset, so need to be check at every
- * atomic commmit.
+ * atomic commit.
  */
 static bool psr2_sel_fetch_plane_state_supported(const struct intel_plane_state *plane_state)
 {
@@ -2203,7 +2203,7 @@ static void _psr_invalidate_handle(struct intel_dp *intel_dp)
 }
 
 /**
- * intel_psr_invalidate - Invalidade PSR
+ * intel_psr_invalidate - Invalidate PSR
  * @dev_priv: i915 device
  * @frontbuffer_bits: frontbuffer plane tracking bits
  * @origin: which operation caused the invalidate
-- 
2.27.0

