Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C79599ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348680AbiHSLJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348647AbiHSLJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D4EEF29
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660907341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeNvcv3iZHDY3QjzCkS4zy97GwENP8IMr7bik18mtU0=;
        b=Gln7bXqrcbCIqhdBa/susbfo05myEyPHCUJe/Xl4+J5OsemjA3V93GzgBL7+AOT5FmSzju
        lAloRTbw2/8agFsPO4sKi32OOUIvSQ8ebgWHgJ0bKY6IW6S+lw6zzwuv4Hvpps8P4kRKdo
        SkVqbHdEB50cQKhpVzdmn6Dw5TI3vrg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-Tpu2x3-yOcqoLf6nmKL_2g-1; Fri, 19 Aug 2022 07:08:59 -0400
X-MC-Unique: Tpu2x3-yOcqoLf6nmKL_2g-1
Received: by mail-ej1-f72.google.com with SMTP id gb41-20020a170907962900b00730961131a7so1388531ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xeNvcv3iZHDY3QjzCkS4zy97GwENP8IMr7bik18mtU0=;
        b=PX08sWFhB7cxhokWkz4YhQl3JWa2NUonWUY1IHo+UEaxg4H3u/7FWvCOvj7bdwD4I7
         oD92tAb0RBHuuosjxx+gB5X8Hx9+r0CQvQ0I2qfajhxtzH+r3pm0OL6xdeHJYQlbxu2A
         nmOLuwi1e2adLOT4qzOGry5ZRCVAatIbdcbdvGjYw22bmsXNUz/9ZBfyUre311QEMN4A
         kZVQOeIBpnJmYXyADn6w1I1+JfWUZoZBP4FmxPtTUvoczho/UbTs7RW7aHJz9YBppr2E
         3DoeQeoxqD4ZyerdJju4Z11jg4NWvXen6Kd9lZte5tAnvOsjKSPVvtUtCOBz9mJrvSvu
         PyCw==
X-Gm-Message-State: ACgBeo0RLHyJlGAhdxNGSxwr8OsGdurVpqiH4AUQBJ7BC6LN4wZmnT6b
        TYN/Pww5l1i9shd/ZaElNDXsu5QgokD0/HrCfFOSh/lBAmNAIHq1kspU5KTDnY6Z2rdu+78zmn6
        Ux2rScLaV3SYL3v/zFiRwxJ6b
X-Received: by 2002:a05:6402:1603:b0:446:5617:55dd with SMTP id f3-20020a056402160300b00446561755ddmr537911edv.170.1660907338838;
        Fri, 19 Aug 2022 04:08:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4JCMLkkgfrx66zUb5RMS4kd93el/Xb9OFRWhrYuzNFFkdMFyxj+rXOpo1fErhN9Ev0M+lasA==
X-Received: by 2002:a05:6402:1603:b0:446:5617:55dd with SMTP id f3-20020a056402160300b00446561755ddmr537899edv.170.1660907338647;
        Fri, 19 Aug 2022 04:08:58 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b007308fab3eb7sm2167827ejh.195.2022.08.19.04.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:08:58 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 4/4] drm/vc4: hvs: protect drm_print_regset32()
Date:   Fri, 19 Aug 2022 13:08:49 +0200
Message-Id: <20220819110849.192037-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819110849.192037-1-dakr@redhat.com>
References: <20220819110849.192037-1-dakr@redhat.com>
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

In vc4_hvs_dump_state() potentially freed resources are protected from
being accessed with drm_dev_enter()/drm_dev_exit().

Also include drm_print_regset32() in the protected section, since
drm_print_regset32() does access memory that is typically mapped via
devm_* calls.

Fixes: 969cfae1f01d ("drm/vc4: hvs: Protect device resources after removal")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 9e823e0de197..4ac9f5a2d5f9 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -71,11 +71,11 @@ void vc4_hvs_dump_state(struct vc4_hvs *hvs)
 	struct drm_printer p = drm_info_printer(&hvs->pdev->dev);
 	int idx, i;
 
-	drm_print_regset32(&p, &hvs->regset);
-
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	drm_print_regset32(&p, &hvs->regset);
+
 	DRM_INFO("HVS ctx:\n");
 	for (i = 0; i < 64; i += 4) {
 		DRM_INFO("0x%08x (%s): 0x%08x 0x%08x 0x%08x 0x%08x\n",
-- 
2.37.2

