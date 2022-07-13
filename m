Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8255731A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiGMIzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiGMIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52404BA3A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657702508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3fERHzEDfrpIpAaHxv/FCy1Dds4VbBEuXgTRXd5v5g=;
        b=VPhlK9s0SyW8hABtWdXy3Y6mSmFT6Wwg6TRyrhg2YzQxkoxMzBJEkxmE3MaNGHGnnXlW3q
        6Sb8yJXfdTbr9E6k1qRXNxYzBGxxxQXwgWMOHRKbaLVlSX2vtj4yThATpxIgq3p4PbBGwb
        vhxo2+4MVsbvGv4yXCrifyssn1hZFuE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-_wlwvWm8OnGH9kZFXRrHNw-1; Wed, 13 Jul 2022 04:55:06 -0400
X-MC-Unique: _wlwvWm8OnGH9kZFXRrHNw-1
Received: by mail-ed1-f70.google.com with SMTP id c9-20020a05640227c900b0043ad14b1fa0so5796360ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3fERHzEDfrpIpAaHxv/FCy1Dds4VbBEuXgTRXd5v5g=;
        b=MVabH5ubFuGQ99h/g1+PorTgDU8dnMstktpTh0IJpfve7EA7OjHyWXXJd8nJzJon4P
         NucrZp8arnwrVHdgkFfqL5b7jyOcMqdIlgiVmu43OpdvmZltxAqENt9BYjiWfmL+jzDZ
         LYpUG3ENAQu6wV+eweDEl49tNcdv1Q7N6XM8yZqAhEb5sZ07sYY8qnLPHs79sroWvSHL
         Znj7GHoBKW5YdiqiLMS5kvwTJQKHt9Kpow+bafGjVbrV7YRReoMCAaGgZBNZQpCpUevy
         zma9B7qn883iqid/blW52uAjPB3sZILkGvXZO2HTejfJarWRp+a8W8FBhjpw6h/3l0SK
         vMBg==
X-Gm-Message-State: AJIora8C9t2AjLDDQJG80lDB4bK5FvW6b2ytnh28oUyV7I3PFP1rCUVl
        ksAEPJGL6nH3yFdOF9NQ1/B7x1Vh1ozwh6mPvKOYLM3qlFB1Utc1aYABckP4dLfPaVP5B5hzKQa
        Tk63V7h/UvjSOAV8ThDWiIopj
X-Received: by 2002:a17:907:7ba2:b0:72b:57da:a76e with SMTP id ne34-20020a1709077ba200b0072b57daa76emr2335169ejc.210.1657702505820;
        Wed, 13 Jul 2022 01:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uksIFx91JCqDk9omGQxTIKHtiTQi4JvUWD17uzFSAXXgmV3IwYsfa6uUC48C2qiTpru10riw==
X-Received: by 2002:a17:907:7ba2:b0:72b:57da:a76e with SMTP id ne34-20020a1709077ba200b0072b57daa76emr2335162ejc.210.1657702505630;
        Wed, 13 Jul 2022 01:55:05 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e2-20020a056402088200b0042dcbc3f302sm7547655edy.36.2022.07.13.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:55:05 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     emma@anholt.net, mripard@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 2/3] drm/vc4: crtc: use drm managed resources
Date:   Wed, 13 Jul 2022 10:54:59 +0200
Message-Id: <20220713085500.1970589-3-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713085500.1970589-1-dakr@redhat.com>
References: <20220713085500.1970589-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate the crtc objects with drmm_kzalloc() in order to tie the release
action to the underlying struct drm_device, where all the userspace
visible stuff is attached to, rather than to struct device.

This can prevent potential use-after free issues on driver unload or
EPROBE_DEFERRED backoff.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 drivers/gpu/drm/vc4/vc4_txp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 9355213dc883..4b0c61cc3265 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1273,7 +1273,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	struct drm_plane *destroy_plane, *temp;
 	int ret;
 
-	vc4_crtc = devm_kzalloc(dev, sizeof(*vc4_crtc), GFP_KERNEL);
+	vc4_crtc = drmm_kzalloc(drm, sizeof(*vc4_crtc), GFP_KERNEL);
 	if (!vc4_crtc)
 		return -ENOMEM;
 	crtc = &vc4_crtc->base;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 3579d487402e..ae2193fe3b29 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -479,7 +479,7 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 	if (irq < 0)
 		return irq;
 
-	txp = devm_kzalloc(dev, sizeof(*txp), GFP_KERNEL);
+	txp = drmm_kzalloc(drm, sizeof(*txp), GFP_KERNEL);
 	if (!txp)
 		return -ENOMEM;
 	vc4_crtc = &txp->base;
-- 
2.36.1

