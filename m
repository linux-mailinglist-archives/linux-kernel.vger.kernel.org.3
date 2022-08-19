Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB1F59A943
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbiHSXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbiHSXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F66DB066
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFFGKxt+Rynb6H3rLFquNUiuipOW4GaSN2+USkzDWw0=;
        b=djyuI2kx3GJL3V+WioTbWxkfrJMauburDl4tEVw4/jG2LPuFiK12iPtOhDTXJWoJMCu2CB
        CJOmXeH9OgLJreZMy63e/oZrjL2HfSu7HJuBOxwZ2hBPmbTrkuVGSORxpuwgeVvsnUHpDz
        u4bYweeof3DhYvqxXqpj3CMccJJvgKc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-251-Gif5761qMau8eh-agGmS2w-1; Fri, 19 Aug 2022 19:11:14 -0400
X-MC-Unique: Gif5761qMau8eh-agGmS2w-1
Received: by mail-ej1-f71.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso1952435ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AFFGKxt+Rynb6H3rLFquNUiuipOW4GaSN2+USkzDWw0=;
        b=r7zjmM0OJvzq5G+t7aNUAbUPTxDm4WIVtj4UXlR+JeGxtheM0j6NXtGVI+/mLyIQV3
         HUyU59dH5LSeN/T7Zjh0OM6DvILO6gMy/jwewiorqqioFL349pw74nGCHd8YKmWBzxDp
         f6rhy2KteSYaZGcSFX4ClXkyUoyHmNZUkJjdCiGkAC1jnkj7We+1ZygxNaaoqP8n/QLx
         qgt9vdl+JevCukS2gysEPm9pvUXPwAQkxMHfBvBDH7ilCb/sWPdbQ1atr6HHHD3Qnw6z
         t1EIry4BznD/RsZ9qgM2nRlIFiP3Q+oAMMIt3AwGpnrfwwx+a5QGPr5Pb/Y7ta90FgIg
         79tg==
X-Gm-Message-State: ACgBeo0TqqrMUZdH/l/KTY58SUdfCCXMKDLNa+4wpQCUvZYpm+9e/FQl
        4ZoriR1Yf+IX0QzFvIIR/NsZ9ZZ7VOpw4uHiuTIbIuc+iwQTuaD10xDetPhrwiilDbrOlAgmhEe
        aN2XOqbrwrlnOlN//XKwv5KGu
X-Received: by 2002:a05:6402:b37:b0:446:79cb:8ed2 with SMTP id bo23-20020a0564020b3700b0044679cb8ed2mr22589edb.265.1660950673505;
        Fri, 19 Aug 2022 16:11:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6I47xkeEdQdkJwg0IElCbZlxTvQ3PAI/2KK3WH2jBuBVpkk+QFYyUaoLDoZHy4tthJHuyR9g==
X-Received: by 2002:a05:6402:b37:b0:446:79cb:8ed2 with SMTP id bo23-20020a0564020b3700b0044679cb8ed2mr22583edb.265.1660950673381;
        Fri, 19 Aug 2022 16:11:13 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id da7-20020a056402176700b0043a61f6c389sm3761651edb.4.2022.08.19.16.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:12 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 5/7] drm/arm/hdlcd: use drm_dev_unplug()
Date:   Sat, 20 Aug 2022 01:10:56 +0200
Message-Id: <20220819231058.647658-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819231058.647658-1-dakr@redhat.com>
References: <20220819231058.647658-1-dakr@redhat.com>
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

When the driver is unbound, there might still be users in userspace
having an open fd and are calling into the driver.

While this is fine for drm managed resources, it is not for resources
bound to the device/driver lifecycle, e.g. clocks or MMIO mappings.

To prevent use-after-free issues we need to protect those resources with
drm_dev_enter() and drm_dev_exit(). This does only work if we indicate
that the drm device was unplugged, hence use drm_dev_unplug() instead of
drm_dev_unregister().

Protecting the particular resources with drm_dev_enter()/drm_dev_exit()
is handled by subsequent patches.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 120c87934a91..e41def6d47cc 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -325,7 +325,7 @@ static void hdlcd_drm_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	drm_kms_helper_poll_fini(drm);
 	component_unbind_all(dev, drm);
 	of_node_put(hdlcd->crtc.port);
-- 
2.37.2

