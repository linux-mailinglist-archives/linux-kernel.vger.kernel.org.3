Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACB536D50
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiE1Oe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiE1Oey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CECF192A0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653748491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XE622bwRFQLXoWlWGwkx558rDBHwnMuHGZROqrwvbw4=;
        b=dYY7a3Rv5ALiQXiIMK80psAzVlu3N8EupopmJBFch3cnbPNib7UDOkDxeVK+h9nMDuKU6+
        hBKAPzpg6klq3J0Gwf4UmTM42YOEkhiJQV/SM7qAvV6DqKc6Ew94HleHSxPHHjLBlCYHFu
        ZUaMsmNzvejQ+zhYurYgpz68HcLOHco=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-G0VVI4GrPzaKlIIJFBnDSQ-1; Sat, 28 May 2022 10:34:48 -0400
X-MC-Unique: G0VVI4GrPzaKlIIJFBnDSQ-1
Received: by mail-qv1-f70.google.com with SMTP id 13-20020a0562140d4d00b004624a316484so5605575qvr.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XE622bwRFQLXoWlWGwkx558rDBHwnMuHGZROqrwvbw4=;
        b=5LSh8g3ZQiosvhBuYqd61Zx7DsKh0ykPuY4hp32QUvjV1LqAu5xB/7dn7P3Dwj/4Xe
         PoDv0hiPItSZV1khIC9Xy+Sbq115lPzVIBHV73peIJaYtuw9exeqG60TaNkWweNceik8
         HBWDKIzrxhoWq99gbpBjKqPzOXPdvEN4iFcz2T/F+WIzEMM/saHxnwnPY6WPNHAP0gDh
         nA6OtZFFIYojakmNesvaMiXiaezbvoU2u94JNQ8JEB9qOwWK/u8Q998tVAhEGCf4/A20
         ICrOKSWqxeHEiWFSdMFUIVg88Jk6JY9d8JlTqNZT2opN02fPuPoqPttyliMqW8vYciBu
         Nzbg==
X-Gm-Message-State: AOAM532Bc25OxIzIGgOTfipGTf8Rz5qSp+ATtfZ915p3JsUD5Msj3mr1
        MGZvPeLfuf6ZKnjp36M0ytQ+cDpZ7J9k5pN7i0XBCcOlFcdjesTeOcrnC3UiSADGpMX62Vi6/xY
        aJF45K5a7oKgTMl6cscRKUR+3
X-Received: by 2002:a05:622a:186:b0:2f3:b5e1:8f2c with SMTP id s6-20020a05622a018600b002f3b5e18f2cmr37699904qtw.99.1653748487810;
        Sat, 28 May 2022 07:34:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfw+zDbPoW1PujPqrT77plf9K/dqh5eJc8Y+lAMBwBf227Q8xlr2ZkX6Cc6T3ziRTt2IzQLA==
X-Received: by 2002:a05:622a:186:b0:2f3:b5e1:8f2c with SMTP id s6-20020a05622a018600b002f3b5e18f2cmr37699895qtw.99.1653748487608;
        Sat, 28 May 2022 07:34:47 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c131-20020a379a89000000b006a098381abcsm4541947qke.114.2022.05.28.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 07:34:46 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/fifo/gv100-: set gv100_fifo_runlist storage-class to static
Date:   Sat, 28 May 2022 10:18:36 -0400
Message-Id: <20220528141836.4155970-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c:56:1: warning: symbol 'gv100_fifo_runlist' was not declared. Should it be static?

gv100_fifo_runlist is only used in gv100.c, so change it to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
index 70e16a91ac12..faf0fe9f704c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
@@ -52,7 +52,7 @@ gv100_fifo_runlist_cgrp(struct nvkm_fifo_cgrp *cgrp,
 	nvkm_wo32(memory, offset + 0xc, 0x00000000);
 }
 
-const struct gk104_fifo_runlist_func
+static const struct gk104_fifo_runlist_func
 gv100_fifo_runlist = {
 	.size = 16,
 	.cgrp = gv100_fifo_runlist_cgrp,
-- 
2.27.0

