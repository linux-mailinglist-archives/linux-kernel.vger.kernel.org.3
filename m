Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615F1558D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiFXC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFXC3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:29:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA2562F2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:29:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l2so230772pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTOc/d+oYEo3KCLS/ApdmDM5i1P831XT3HEgoNa9jFg=;
        b=XYqgC7SBFPlJmaT51rH7p5TmW21W/f3GTkx6yYyilD+uIM9ac3rLrrT3fh1m2HA0dJ
         8yO2Uo2vpIWo5uF6WEQa0RTfvmrbXpVh7NdGWTowuLMK26RD7wGgYuDivDsmTgkWPQnS
         biqnPZUqnZbzNdI2w5HzeKw73fT2ALFVOqimA/iWKm9JRRIR4siV9vhcJs2SCyU8+g82
         hL0ex9lTg6DnU3Wxf/SxvuafG8LLKUEWW3F8nPteMeQfDcpt7hiYck6sFz6yACy0CQpe
         AnU2dcRcsNviM4kvXavlekPs6OeQwJZ/6/eMXKLofpv6Sd5PsTY0oFmh4N+8/ONuvUv+
         iZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTOc/d+oYEo3KCLS/ApdmDM5i1P831XT3HEgoNa9jFg=;
        b=V8Zr5aVHcZXcHilJzR2wTEe7wma/5Rlx4ilugAe6Y0CwSOH1sYKW2GZFSms1VwpWr/
         bZcv12PsxOa3Izhio7y8N5wAW338NrWl/e0nU7YMWomjOYmvJGQJZT6FbMYbNDQk8ZAH
         hgIa1vixs1L+CP09yAuvxSFSeGSYvLdWdZAXKpd9ONwaGk+kA6XALY7RolpHnlZtaQTw
         EkGjl4Ti1n45S9vep7RfrGgXKdCduSRp6b3ChpjxE445hcFm4diiW3Mvom8YceGkIb7h
         iaDq1b0OISzSB7YGruTg7Ri/1OD4W4dFJyN+64E5rnWm+eLbHBjlrveUnpK2SmtJc+ud
         pCVw==
X-Gm-Message-State: AJIora+sTtwMHgaJHiN9c1Q4CQCLOxsQHyAEu+KgdKzBQkJ42SmAoBNc
        d+IJL8x9t++Qy3nC4ywlK/Y=
X-Google-Smtp-Source: AGRyM1tYmK815ZiopKTsyYzm2EOC5BJDMMDs0xwZPS+5x1ROtrsm8Oe2NhA10w597fwsTyA7ciKliQ==
X-Received: by 2002:a17:902:f7d3:b0:16a:208e:b2c4 with SMTP id h19-20020a170902f7d300b0016a208eb2c4mr24216887plw.64.1656037746397;
        Thu, 23 Jun 2022 19:29:06 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id n24-20020a056a000d5800b00517c84fd24asm348559pfv.172.2022.06.23.19.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:29:05 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        jose.souza@intel.com, lyude@redhat.com, matthew.d.roper@intel.com,
        anshuman.gupta@intel.com, heying24@huawei.com,
        james.ausmus@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH RESEND] drm: i915: fix a possible refcount leak in intel_dp_add_mst_connector()
Date:   Fri, 24 Jun 2022 10:28:13 +0800
Message-Id: <20220624022813.10796-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If drm_connector_init fails, intel_connector_free will be called to take
care of proper free. So it is necessary to drop the refcount of port
before intel_connector_free.

Fixes: 091a4f91942a ("drm/i915: Handle drm-layer errors in intel_dp_add_mst_connector")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 061b277e5ce7..14d2a64193b2 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -839,6 +839,7 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 	ret = drm_connector_init(dev, connector, &intel_dp_mst_connector_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
 	if (ret) {
+		drm_dp_mst_put_port_malloc(port);
 		intel_connector_free(intel_connector);
 		return NULL;
 	}
-- 
2.25.1

