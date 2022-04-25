Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F2950E14D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiDYNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDYNQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93E5D35DEB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650892398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OV5M88ExrHBJLlDEVqDhMiG8Kzj0MFYt6DBHZT5ejGQ=;
        b=WwfqwWuJElflgMtspe5HpTUo+BOaTmCLmDyqYMsJDUxDl4Dk3xxLp7S/IcCEV6k1CJ4UQ/
        D3nvzSSPd8uESrO3FOLbiqHXPXaQj/Jgdi43OC5Uf+rG2ZUGxSV0keYKj1+pX4sMm/6Rv/
        WNW/9S8aI30meIbFO1By+MW9k86CHtk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-7qkZ546dN_GyN6eTrqEX7g-1; Mon, 25 Apr 2022 09:13:17 -0400
X-MC-Unique: 7qkZ546dN_GyN6eTrqEX7g-1
Received: by mail-qk1-f198.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso9645315qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OV5M88ExrHBJLlDEVqDhMiG8Kzj0MFYt6DBHZT5ejGQ=;
        b=lcah2QMzhFJeNJEz4uy8RdprFa1merH//5nalNS8F+hhRLMmKFEasgXY4WEbqp9rQd
         NbEaBs+qdk7xa9Q1hpEYuawTpSTejoHAxJLQdnFk+qi6NKGJvrMtfulS6HBL6weT0zgb
         /sv56+IwKi+M0T3kFW/rJqvPa5S1oHLqgZuiRgk/LmEkqUZSkroGNP8SVXmYa4a15Ri6
         rzGSxvlTeRbv3Lmj2roE7iC6pp+fTpNp/HsmfMmRhHZaDhhnL//cLX5xSt3EHMFxdhXC
         ZQUDp9et8mzGlJ+IJu3y06IyFgki3s1yxXs1hkOsvzOU5a8+Iz4pdk89hWevnN4R4vX9
         mqXg==
X-Gm-Message-State: AOAM531CbnoNZ6fdkaGrOZWMzFrY24qY+Sb+fJ4TsX+YnAOd+KA9YGv6
        fGowZQfWbuttyaTEvyUIOR+6YTBCBOqEnZWnzOc0+rmduLjVklw3PRo36JABmm8PWoo5T1K42VN
        7IJGLlfqsByTVUgxvhzvnR0Dd
X-Received: by 2002:a05:6214:1c87:b0:42d:20cb:e484 with SMTP id ib7-20020a0562141c8700b0042d20cbe484mr12145218qvb.10.1650892396727;
        Mon, 25 Apr 2022 06:13:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPOqTD8cO+BzlbfrXGx8bSpW2fXt9dKS1tp8Lcv1B7tS2bEgBAUJkY4Q26CjFWa0jOYCeRbQ==
X-Received: by 2002:a05:6214:1c87:b0:42d:20cb:e484 with SMTP id ib7-20020a0562141c8700b0042d20cbe484mr12145207qvb.10.1650892396506;
        Mon, 25 Apr 2022 06:13:16 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s195-20020a37a9cc000000b0069ca29ab6f4sm4961900qke.26.2022.04.25.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:13:16 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/disp/gv100: make gv100_disp_wndw and gv100_disp_wndw_mthd static
Date:   Mon, 25 Apr 2022 09:13:08 -0400
Message-Id: <20220425131308.158635-1-trix@redhat.com>
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
wndwgv100.c:120:1: warning: symbol 'gv100_disp_wndw_mthd' was not declared. Should it be static?
wndwgv100.c:140:1: warning: symbol 'gv100_disp_wndw' was not declared. Should it be static?

These variable are only used in wndwgv100.c.  Single file variables should be static.
So use static as their storage-class specifiers.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
index 5d3b641dbb14..e635247d794f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
@@ -116,7 +116,7 @@ gv100_disp_wndw_mthd_base = {
 	}
 };
 
-const struct nv50_disp_chan_mthd
+static const struct nv50_disp_chan_mthd
 gv100_disp_wndw_mthd = {
 	.name = "Window",
 	.addr = 0x001000,
@@ -136,7 +136,7 @@ gv100_disp_wndw_intr(struct nv50_disp_chan *chan, bool en)
 	nvkm_mask(device, 0x611da4, mask, data);
 }
 
-const struct nv50_disp_chan_func
+static const struct nv50_disp_chan_func
 gv100_disp_wndw = {
 	.init = gv100_disp_dmac_init,
 	.fini = gv100_disp_dmac_fini,
-- 
2.27.0

