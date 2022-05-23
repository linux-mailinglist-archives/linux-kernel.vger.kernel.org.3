Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1A531066
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiEWLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiEWLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B8504FC47
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653305746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=esB4CG60KOiYCNvFLfupKrK3na9cJg7bNU5W1vo473k=;
        b=XdP2wPXLJgo60T1Jw/V1P/JFJ78ZwBVylELNmhPXcIUCCdNlmyOqG2Z1rl2Ke30T8ziY8L
        bQxnQ/DyC1bYSbCmFv1RTBn9mvj61PD2ty5cV0UP7A+H4cMV6fEsm7D7rqh0bA7aiOlTdc
        LQr2ky0pKgVEElQYsBZzVcfoka1lx+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-hyWmSWMeNL-y2e6iRNrwNw-1; Mon, 23 May 2022 07:35:45 -0400
X-MC-Unique: hyWmSWMeNL-y2e6iRNrwNw-1
Received: by mail-wm1-f69.google.com with SMTP id r11-20020a1c440b000000b00397335edc7dso5855853wma.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esB4CG60KOiYCNvFLfupKrK3na9cJg7bNU5W1vo473k=;
        b=aH5dvL14O3AMr7SJ1AS4K9MUwaSzg3Hpfl9Ia+BJW82uRFSIBmxvztCtK6jQYnYZp8
         KEfZFSTfLmdKLXrhrAZgTkYEVz80HIcCzOainoGIegxelIpZP2S3j4lWvaPQbF9bUI4M
         qZoyLqprGv/4LDEdG5wGIQWnMbX3oOBZ2dSe7KbTIO0JAjHYvNNlsEIvXqQuZglmUpdF
         bBqR9E12QWO+M0NlU8X9hknA9ae9Cv7rZV+uDU5W1CGaYmCBQEv+6T8s78Nr5iU6nmX0
         WI7j1NIqsC3oNUF3lyuFxnZ2PIUR7X8Xdj1OgPly5db+DapiQXIjKcZHoeUQcjfasM6d
         Nzeg==
X-Gm-Message-State: AOAM532q+bOs5IEplg13yT8/aBd5htt576mgR3iJ7qyo8j2X+KPxSG8S
        I0tJcJNH3GMQhoZ4AUha94XFwRO7ayEom8mq4ZlQz1IgKHdr1P+iXrLu0I4QNFgUDswnz1EaPNE
        WqWigHE0Sx46m4bzGoO+ofiVtvetTedBD9jzrLCjOmrtwYZG8R7q9HKspO8PbaXyp1T9r8V69k5
        lS
X-Received: by 2002:a05:6000:1562:b0:20f:c999:fda7 with SMTP id 2-20020a056000156200b0020fc999fda7mr8843865wrz.65.1653305743948;
        Mon, 23 May 2022 04:35:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVT0wpZjAWWuYWqm00EefJbbozZgIflACNx9uqBlH4bB19uD4jcj1iQ0owk08/zmUDeBF02A==
X-Received: by 2002:a05:6000:1562:b0:20f:c999:fda7 with SMTP id 2-20020a056000156200b0020fc999fda7mr8843843wrz.65.1653305743764;
        Mon, 23 May 2022 04:35:43 -0700 (PDT)
Received: from fedora.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o16-20020adf8b90000000b0020fc3e24041sm7577841wra.106.2022.05.23.04.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:35:43 -0700 (PDT)
From:   Mark Menzynski <mmenzyns@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Menzynski <mmenzyns@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v3] drm/nouveau: clear output poll workers before nouveau_fbcon_destroy()
Date:   Mon, 23 May 2022 13:35:41 +0200
Message-Id: <20220523113541.10562-1-mmenzyns@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources needed for output poll workers are destroyed in
nouveau_fbcon_fini() before output poll workers are cleared in
nouveau_display_fini(). This means there is a time between fbcon_fini()
and display_fini(), where if output poll happens, it crashes.

This patch introduces another output poll clearing before fbcon
resources are destroyed.

BUG: KASAN: use-after-free in
__drm_fb_helper_initial_config_and_unlock.cold+0x1f3/0x291
[drm_kms_helper]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Menzynski <mmenzyns@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 4f9b3aa5deda..5226323e55d3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -39,6 +39,7 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_atomic.h>
@@ -605,6 +606,7 @@ nouveau_fbcon_fini(struct drm_device *dev)
 	if (!drm->fbcon)
 		return;
 
+	drm_kms_helper_poll_fini(dev);
 	nouveau_fbcon_accel_fini(dev);
 	nouveau_fbcon_destroy(dev, drm->fbcon);
 	kfree(drm->fbcon);
-- 
2.32.0

