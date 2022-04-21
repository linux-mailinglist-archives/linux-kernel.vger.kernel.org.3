Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3A50A0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385725AbiDUNdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiDUNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABDCE18340
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650547836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kiIHIoB66u3RP+01+bNiod8V2ewZbyshShw0I7c9tlo=;
        b=fUgCLlAvXWZnHM5C7kaSGMiWVADZhP0m3GEtEYGnT9oNrLqMCcTHl/WPVW4V4WG7Cl/JYt
        oUe4H02lhDXMx+V7BkKoNfRHjGH3BBkt85npgwQlzUQRonZKSMiFmwRtRJpRP/VlrftrDL
        4hdbMNYT5qZFXYBEsTnaVq8NumzYjhY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-J1wptdD8PXuTd9JK6IC_ow-1; Thu, 21 Apr 2022 09:30:34 -0400
X-MC-Unique: J1wptdD8PXuTd9JK6IC_ow-1
Received: by mail-qt1-f200.google.com with SMTP id x12-20020ac87a8c000000b002f349b0c2c5so1477825qtr.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiIHIoB66u3RP+01+bNiod8V2ewZbyshShw0I7c9tlo=;
        b=tSQxjQDPSt66nZiOSDLYE7sZYU23+zObkCYHQ7b0fw9Ozv4XrpMV8yvqRccauQgNGq
         xpRMl0Jr2zszHrhtU+zSBgygD6CW0v3ubNuvvFiAkXpkw6Ztq4+85aG19d7/2QMmamVX
         I/E4U1XV7yTZrbwRCXXGp8A9rcRGf0I1PVwYVv9eKEni2FYzsLs6wTqO0S82ChZJFmDA
         sviezHPFa6FLSDfJrxRdWhSAELChU2c0PZPETQymaVvR1Lo1KUzfuhgmomZE37vQSze5
         K7QdPi3EU12TdS9x5H5fcrWHiHsZ8xfdXNJSuo6+Q1boIIa+wR5kour2GThI37wrLaRG
         DjTg==
X-Gm-Message-State: AOAM533J0LCfgh5uol9rQDh8k5t8KjA0PJQjrpW6Eum7Q+L3Fr4wJFpr
        tWE8vOUP/m/mUgdKVlEQh2e/BaRwx60f/DUzdl9vD3ycr6PS2cvXPkkCw55Ytgmw3dx1ScsJLG2
        tC9bzyxRBE58l02lQ7FyGsCil
X-Received: by 2002:ac8:58ce:0:b0:2f3:5057:569 with SMTP id u14-20020ac858ce000000b002f350570569mr1048209qta.367.1650547834133;
        Thu, 21 Apr 2022 06:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpPugCA4lCUt4oXKL9cMiCNteKlh+teO35BdZL1at8SyJW/uWnkJiuXZUWX83fHO6di9S8CA==
X-Received: by 2002:ac8:58ce:0:b0:2f3:5057:569 with SMTP id u14-20020ac858ce000000b002f350570569mr1048197qta.367.1650547833945;
        Thu, 21 Apr 2022 06:30:33 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm2706827qkm.66.2022.04.21.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:30:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/gsp: change gv100_gsp from global to static
Date:   Thu, 21 Apr 2022 09:30:28 -0400
Message-Id: <20220421133028.724954-1-trix@redhat.com>
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

Smatch reports this issue
gv100.c:46:1: warning: symbol 'gv100_gsp' was not declared. Should it be static?

gv100_gsp is only used in gv100.c so change its
storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
index 2ac7fc934c09..6c4ef62a746a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
@@ -42,7 +42,7 @@ gv100_gsp_nofw(struct nvkm_gsp *gsp, int ver, const struct nvkm_gsp_fwif *fwif)
 	return 0;
 }
 
-struct nvkm_gsp_fwif
+static struct nvkm_gsp_fwif
 gv100_gsp[] = {
 	{ -1, gv100_gsp_nofw, &gv100_gsp_flcn },
 	{}
-- 
2.27.0

