Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EA52FEE6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbiEUTHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344530AbiEUTHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F027E5C341
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653160058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wjy70z3rYdJmy6N/G7PkmPiJBr+st53+xede1hwp8ZM=;
        b=fC57Rssv3QpbYjxqFX1ZMqVr+TOfAWodrj2/XueobvR8lwDbHdEQ7/V7f6tlcl3pXWUEDS
        xN7oRk1gDFSz47Az1dTaUNP01jMFY0DvZWR7puP8z3WXQkgiZCmXr9a5bxGWXWj3K7QfFU
        ghyXcNTarXLe2eBvGiZyFB/SR8RzEcc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-IIdljDfDPdGhvVoGHt-MZw-1; Sat, 21 May 2022 15:07:36 -0400
X-MC-Unique: IIdljDfDPdGhvVoGHt-MZw-1
Received: by mail-ot1-f72.google.com with SMTP id 32-20020a9d06a3000000b0060afe7e222bso988510otx.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wjy70z3rYdJmy6N/G7PkmPiJBr+st53+xede1hwp8ZM=;
        b=B4chB4f4b9F+4GuGlXdunbNvQAF5x7Mx8fVknIL6OGfP//Q/zCG7RvuvqvpdOyHgDl
         YNULZc2zs4IuUrWqmQZGtcTGqajBPwxJ9qocB+OR7VxEf6RcLnb+8pqJTZvu5U52Swvd
         FEqqWxUaWWtSAXJhnto0KjoKXDRqL+secM7bCLVF4o4HEbqOClWhP+8Kgq2KAPHKHhV8
         +wMeO9398otO6b9W0HwRVd7DU5GefZObHHAX/m64yxkn31/kyNcXzm6+M3rBh7vx8Hk5
         2Z80tQDkAB2vHDAFX/RjDwEFNa1GKiXbNlA13+zZDSUpwL4aLLwXazYZHUlZ9cyeL00H
         J/Cw==
X-Gm-Message-State: AOAM530tSVLs4wkLx/CIa7JV89k64vWDj+PLyTw2VgQbVRlwnvRMf2h+
        z/y/EhNAmmecJ4LsDiBefwOczfT0ZRldcNCTstUhpCNwBzZwyuCc1iGXrzrkaQiFL1b/vER/Uq9
        5EEYsvhjdWPtgwXkoPOY63Mmy
X-Received: by 2002:a4a:d40d:0:b0:33a:33be:9c1e with SMTP id n13-20020a4ad40d000000b0033a33be9c1emr6340068oos.96.1653160056074;
        Sat, 21 May 2022 12:07:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQFuSj7FFYoeGmIJnrtvUhAvMCbQ7XefIximmy8LWnPFdHFdaJq2T5go68pyrOKFdwywHEYg==
X-Received: by 2002:a4a:d40d:0:b0:33a:33be:9c1e with SMTP id n13-20020a4ad40d000000b0033a33be9c1emr6340058oos.96.1653160055856;
        Sat, 21 May 2022 12:07:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q203-20020aca5cd4000000b00326cb6225f8sm2495564oib.44.2022.05.21.12.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:07:35 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/rockchip: remove vop_writel
Date:   Sat, 21 May 2022 15:07:16 -0400
Message-Id: <20220521190716.1936193-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
[drivers/gpu/drm/rockchip/rockchip_drm_vop.c:186]: (style) The function 'vop_writel' is never used.

vop_writel is static function that is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 74562d40f639..d1026e78feff 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -183,12 +183,6 @@ struct vop {
 	struct vop_win win[];
 };
 
-static inline void vop_writel(struct vop *vop, uint32_t offset, uint32_t v)
-{
-	writel(v, vop->regs + offset);
-	vop->regsbak[offset >> 2] = v;
-}
-
 static inline uint32_t vop_readl(struct vop *vop, uint32_t offset)
 {
 	return readl(vop->regs + offset);
-- 
2.27.0

