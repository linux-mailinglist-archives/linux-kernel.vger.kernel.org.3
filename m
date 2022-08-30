Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88025A5E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiH3Ic4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiH3Icy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:32:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0C6D568
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:32:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa2so2745753pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7DbBF1+oaDwBQvC8cRC9cxy+Yq2Vsxw50yfZErPMASA=;
        b=QHRjtpH1TXzAXZ6WC+IKgw21HECpC8KBem/uLNhOg0vQcIwSamzdyqro17MpnY/0/W
         LvlANBt2PduRRiB5Tn9XQ7zQhJhU0LUUjVom+bXKdg1086zex3X82U0Flur5UsOQGzO6
         +QtnBOATJesYl7DjuZ6hl6yl71xHogrA8gWVPHIyO+eFfj+Dlki/SmrZ7f23827S/0eB
         1scPzxQu5OlizfrcK9q5M7lPlo34XwwKNqOkED0Fm/1/xzBF1PdLS68DXQokPtbCXS7a
         QNO3pOGfxSo+Dlx/pulyQ4IE6dQroCZGR2024tTr5rgb15rzKV9xwSxEjE4wMy/Y7K+j
         DJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7DbBF1+oaDwBQvC8cRC9cxy+Yq2Vsxw50yfZErPMASA=;
        b=8DT6RIAe0bJcplP3HJZydjLqjPaeycFYFcqQkyKq1RISzEjsBEEbmkFz3Kfq2XjjEo
         8GkDHAv7CYBkGDwQmZ+3FLMhWtc4FF8fqFaKll69MZIjtgOlObTxwtdkrhXrmcmHAVzJ
         78Diy7A8rNNQ1lRn1nYq/sLScuw9hZlkyebknFW7lt9/DvWN6nuj9SMS7AaoXPNJUjmW
         JkJ50acne4Cus2RNLwJ7eqbZ/OTOSdzyJlPu0sqKoCKYrG7d+rVb1nWSN+R6c5VPb1k9
         QGi+yLmsJd1OUA9IU3Li7FJ/TXzFude9PswJK9efCC/McFsMxRBsFGNatGe27Zcq2B8L
         kGqQ==
X-Gm-Message-State: ACgBeo36J/D9TjCLUgYic1czwpjir8bhJyjeILii/mbKq0lQMmTrDYw3
        ESfBHPO680VqLhxN0uieGQq8n0tJgXw=
X-Google-Smtp-Source: AA6agR4Is8dMqZl7uCk/1vuQ+NNemcLnEcQJRsIuv652D6FMEB1n52aGDtSlrjjQDs4ov4EvP0MG2g==
X-Received: by 2002:a17:902:c949:b0:172:d2cd:a9b2 with SMTP id i9-20020a170902c94900b00172d2cda9b2mr20599799pla.38.1661848372968;
        Tue, 30 Aug 2022 01:32:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b00172f4835f65sm7032761pln.271.2022.08.30.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:32:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, tao.zhou1@amd.com, YiPeng.Chai@amd.com,
        Hawking.Zhang@amd.com, rajib.mahapatra@amd.com, Jack.Xiao@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amdgpu: Remove the unneeded result variable 'r'
Date:   Tue, 30 Aug 2022 08:32:43 +0000
Message-Id: <20220830083243.276646-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value sdma_v4_0_start() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 65181efba50e..0cf9d3b486b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2002,7 +2002,6 @@ static int sdma_v4_0_sw_fini(void *handle)
 
 static int sdma_v4_0_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->flags & AMD_IS_APU)
@@ -2011,9 +2010,7 @@ static int sdma_v4_0_hw_init(void *handle)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_0_init_golden_registers(adev);
 
-	r = sdma_v4_0_start(adev);
-
-	return r;
+	return sdma_v4_0_start(adev);
 }
 
 static int sdma_v4_0_hw_fini(void *handle)
-- 
2.25.1
