Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDC5991BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiHSA3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbiHSA3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF3F6BD63
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660868954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdQAnurZVFdXXS4WbKVSyp7TafzRJAbZ0GKKLX98Mwk=;
        b=AKGvG4UwczM9Ggu1EsQ5nLqVKB5e8J0cW9ruXIZm6DO9xmPlhht20vU33tX3dOPVOpGAg6
        B5ieJLnwExZ1YlE7sXKdbUhGqBN7fKyfV91q0l8FSVNgh44F8NESjYkR9hD+v6/vOF1Eh/
        cdxEAPaYyy0xeCkuAfJ2pkYJ+9KpPBg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-5vILv9Y1M_O2GTz-en7-uQ-1; Thu, 18 Aug 2022 20:29:13 -0400
X-MC-Unique: 5vILv9Y1M_O2GTz-en7-uQ-1
Received: by mail-ed1-f70.google.com with SMTP id z3-20020a056402274300b0043d4da3b4b5so1834573edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZdQAnurZVFdXXS4WbKVSyp7TafzRJAbZ0GKKLX98Mwk=;
        b=LEWl1xXDKHDdCJmS4pyPLovMEeBLooZTC8mS+L4b+QPs1tzb2LgloHooRTYfdfU0bs
         iC1lriuTGaU8YQlRHV+EwkdR+/8/VjeddXLBwG84uuglt+Vru/G3M+zDM7rYkFH+61Ti
         3EAKN9fKIDXEC+LlPhdNes4iXGvp84Vb0KOCCdl5Br0ow2V9HSWlhdo4VeVTB3vwDJOy
         178f7jv/2EpRaPgD+/FoFGz19rPA3LhgMWhTdisY8FACTABM2aOkOiaAg0u6oLyJ1W6x
         VtUe9+lOYEn2fqajcWpSzPUzMnPZnRYPjNBLQOIXr0Q8/7rSPz0YCwgq7dTzTcKCyqs5
         dgkA==
X-Gm-Message-State: ACgBeo1j6U3x5fq0hNACon7oY1Mj3pzu9sF4m3q/qnqQaVyLRUoDK89f
        AzCJqhE7bEdHQnVHEN8C2gDbd6C9V+yrTVuMs2r+z6UeYqcgiR8dlYATzmdQkAkIWSoT3W2vYQO
        9/W6VDsSg0DYAZGP2Hw+ue4HX
X-Received: by 2002:a05:6402:554:b0:446:1013:c898 with SMTP id i20-20020a056402055400b004461013c898mr3898710edx.269.1660868951860;
        Thu, 18 Aug 2022 17:29:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7vEVnE89EQFAzGx7Rjk8MdzgcItMbGIbKShh9H17mhg7mQ2H1lZaOWswF7giUus2phpUqZew==
X-Received: by 2002:a05:6402:554:b0:446:1013:c898 with SMTP id i20-20020a056402055400b004461013c898mr3898697edx.269.1660868951704;
        Thu, 18 Aug 2022 17:29:11 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7cd1a000000b004460b020ffdsm2027913edw.83.2022.08.18.17.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:29:11 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 1/3] drm/vc4: hdmi: unlock mutex when device is unplugged
Date:   Fri, 19 Aug 2022 02:29:03 +0200
Message-Id: <20220819002905.82095-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819002905.82095-1-dakr@redhat.com>
References: <20220819002905.82095-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

