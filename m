Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADD50CAF6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiDWOF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiDWOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DDD66949A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650722535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6PrprjwNGAWhYgrjZkK+UokhMmTgkjR3u0Og/Iue6j8=;
        b=YnGXhbREUtGygw7GrFVc/vCbmnQZxN6W7DgpVMy6G+nx04PsGvZuU+ULsmW6C5hjLxl5YH
        HUx35EyfdLZhlR/BLqf/wkNdZvhaol0ECmyLixEsZbferWUBJ3krMpWcCGXSrC11Q29oy/
        OSo2LVGJAABF0TIVtxlaSqwJfSSNHkc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-fmV3_S8sNkOKt1zKuvur0g-1; Sat, 23 Apr 2022 10:02:13 -0400
X-MC-Unique: fmV3_S8sNkOKt1zKuvur0g-1
Received: by mail-qk1-f197.google.com with SMTP id p207-20020a3742d8000000b0069e80ba4a17so7383311qka.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PrprjwNGAWhYgrjZkK+UokhMmTgkjR3u0Og/Iue6j8=;
        b=TEY0pxiPPu38PhRHkdw0/oFYqYaHgDWUVH8PQOnKFL3OWBpmN1FWALKkgRn5PWnjU6
         WvWqVEIMB2f4IbpfklrWKN/SWEk9y/gP2tmOsvbtO097rq/oTteimlfHQmWHCkItSNDg
         a7Jq6kF0QM9xGAURXKhvByGwLMD1vgVHjRJ8hIJNfrCzDXtUTJ7OJtL1xl1rIBhER5xE
         ZxwUZ8hiDrOF50HLTLXL4xhbcgCKQ/AnU6OqN+v5Dny/GS5VJzhCFefMWRQukG/+gEnp
         YCXVO9zgTd1xWm0g3nVGHR7S0FnXsLR9g04CBGp6RZQToZ1MFXemCGB6Nx2uD+rVfApP
         zfcQ==
X-Gm-Message-State: AOAM531yBBfdQGFhDY/7WYjvJmMmraQFqogjHzswLgLtaytAOaT8SD8z
        0cyZ2i57oWsFpW0P6vJ2jYttZ3ia/FndyMC+ENdAXdpcm63jY6Fgd/nNYE7s0lBYPwUp3oEiQPo
        6/HGz3x3s9WvNvn6ltAnmueTG
X-Received: by 2002:a05:622a:5c7:b0:2e1:d599:9e0d with SMTP id d7-20020a05622a05c700b002e1d5999e0dmr6545938qtb.491.1650722533271;
        Sat, 23 Apr 2022 07:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcg5oz2LjpPWSLb0omDfjmbtM63wn8mXV481F9hAK+F7Pn2tt2BhYD5iGuvkhmnzKkvKeS6A==
X-Received: by 2002:a05:622a:5c7:b0:2e1:d599:9e0d with SMTP id d7-20020a05622a05c700b002e1d5999e0dmr6545919qtb.491.1650722533084;
        Sat, 23 Apr 2022 07:02:13 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a27d200b0069ecf023d1asm2300543qkp.129.2022.04.23.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 07:02:12 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     anitha.chrisanthus@intel.com, edmund.j.dea@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/kmb: remove layer_irqs variable
Date:   Sat, 23 Apr 2022 10:02:05 -0400
Message-Id: <20220423140205.3371025-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports these issues
kmb_plane.c:21:11: warning: symbol 'layer_irqs' was not declared. Should it be static?

layer_irq in not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 2735b8eb3537..8fe93d149491 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -18,13 +18,6 @@
 #include "kmb_plane.h"
 #include "kmb_regs.h"
 
-const u32 layer_irqs[] = {
-	LCD_INT_VL0,
-	LCD_INT_VL1,
-	LCD_INT_GL0,
-	LCD_INT_GL1
-};
-
 /* Conversion (yuv->rgb) matrix from myriadx */
 static const u32 csc_coef_lcd[] = {
 	1024, 0, 1436,
-- 
2.27.0

