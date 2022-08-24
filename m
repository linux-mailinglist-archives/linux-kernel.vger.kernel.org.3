Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512259FF37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbiHXQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbiHXQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56708E0C5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661357617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdQAnurZVFdXXS4WbKVSyp7TafzRJAbZ0GKKLX98Mwk=;
        b=JhymGsnvNIJdg2l//ypZEq3u3Z+lbFMmL2OI+xGSAvHf1kYe8juEoEephm8qQJYL/03Rrs
        RVxnlsyz2SOpFMwnOte0bcrtYAdgS2Qsy9zG3rpJZGm/+FKGkg7qKiiFV1SpkmrnEX1wil
        wRAt6/2xv/jJHQ9uiJQqR7qAwu7yCuE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-dHBXYkFmMBuguCvDS4zPKA-1; Wed, 24 Aug 2022 12:13:36 -0400
X-MC-Unique: dHBXYkFmMBuguCvDS4zPKA-1
Received: by mail-ed1-f71.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so9996257eda.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZdQAnurZVFdXXS4WbKVSyp7TafzRJAbZ0GKKLX98Mwk=;
        b=k7HqgsdglMOUC+OeJER/jFQtCj2exYoOi2g7t6iHRlBxHuuLYnxJAdpEU1OpxYFnmU
         2SL32J7pXScusAXf94PI1KMGiV1MGCK6UFXHN/hCAp4B2xe+bVoBejQQP80UMN3whtgs
         oH9pXOCsToYkfauyZIAgTinc8IsTqrbfVYdrL/dviw053i72H0WIcDN1r87esN+aDSnt
         JMAt+DnMMJb6tBYqwbCFxSXDhzKVQ1oRmKuo74qUiWl11j2j2/U/CDwdPZqlXBO3qzzd
         y3nb3w3GPNrTIDD2bE5LT3mm3fca5yCWTZ0DRRA3euK5OE0zNsfsIfLi712iS7I+36Vx
         7bgA==
X-Gm-Message-State: ACgBeo3ndmJwfw/71hcA0uOLGrx0zH641C/ekKmUBL3IkFQmfnlmI6yy
        KV5CAuijkJ2jeFgpOQORhuChV49Eexd5G/+0QDX5xQ9m8PMtR2ZX5dqdQgIY6Dvuc0WucJt7C+3
        ajmZSyRjzCdkREfLAoVzAiNZo
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr3454485ejc.64.1661357615184;
        Wed, 24 Aug 2022 09:13:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Mb+JsUJPSZ781aWuV8ZoottRuEPEwvAH6ZrSbdG24VdAHADDW9+L0oDsP/xOp2REIksyfBg==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr3454478ejc.64.1661357615040;
        Wed, 24 Aug 2022 09:13:35 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id da12-20020a056402176c00b004478fdbe190sm791536edb.10.2022.08.24.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:13:34 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 1/4] drm/vc4: hdmi: unlock mutex when device is unplugged
Date:   Wed, 24 Aug 2022 18:13:24 +0200
Message-Id: <20220824161327.330627-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824161327.330627-1-dakr@redhat.com>
References: <20220824161327.330627-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vc4_hdmi_encoder_{pre,post}_crtc_enable() commit cd00ed5187bf
("drm/vc4: hdmi: Protect device resources after removal") missed to
unlock the mutex before returning due to drm_dev_enter() indicating the
device being unplugged.

Fixes: cd00ed5187bf ("drm/vc4: hdmi: Protect device resources after removal")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 84e5a91c2ea7..4d3ff51ad2a8 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1425,7 +1425,7 @@ static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder,
 	mutex_lock(&vc4_hdmi->mutex);
 
 	if (!drm_dev_enter(drm, &idx))
-		return;
+		goto out;
 
 	if (vc4_hdmi->variant->csc_setup)
 		vc4_hdmi->variant->csc_setup(vc4_hdmi, conn_state, mode);
@@ -1436,6 +1436,7 @@ static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder,
 
 	drm_dev_exit(idx);
 
+out:
 	mutex_unlock(&vc4_hdmi->mutex);
 }
 
@@ -1455,7 +1456,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	mutex_lock(&vc4_hdmi->mutex);
 
 	if (!drm_dev_enter(drm, &idx))
-		return;
+		goto out;
 
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 
@@ -1516,6 +1517,8 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	vc4_hdmi_enable_scrambling(encoder);
 
 	drm_dev_exit(idx);
+
+out:
 	mutex_unlock(&vc4_hdmi->mutex);
 }
 
-- 
2.37.2

