Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF047504DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiDRIT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiDRITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:19:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3E167D6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:16:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n8so11812178plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuqDicbY3kF4HQHdeFb/QPn21jDri/mLpJf4XQrwT3o=;
        b=Cf91qwkiOFKTt4qMLq9v73fay0oIWWa+PJlaAfoWlehlU4po3BhqsIN49MGh99uXsq
         4xQC18cXFAhYHB1KMlGLW2uhEljK5iDu1fsATHCWs1p/gPmzOQFmczki0721XqaT+IxJ
         GUEYGWevx06ZGeWVwXeL5peJ58NYCPqBOsHlPwjpyFTvoClq2WFVu42rZPe/44iBdBH4
         7InQgDLAq+z0Wm8/LOwqDZyiEg1NkqX/2Maj8gqEgvdXlCK/KnWE217YXd1spF3U4zHz
         xN4iBZ6o3LaF9zPmz8IGEDJnrN1PPTFYU9OMG6Sipf15vnV3P2T1es2G0lE+dbGV55As
         PK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuqDicbY3kF4HQHdeFb/QPn21jDri/mLpJf4XQrwT3o=;
        b=5EgGpAscmqVOmiRUviQmvpOCSnfPx4t/wPvOe3+QXdd7Gp4CNpyvAJNjRZzL4oPbFz
         4d4eFqJooIfb4OFnaHPEktdXkQ3Ta/paVCSywtn0nwcjUBuxv3COSBzwtZ5lr3Za9dU3
         x/O3kvvC8b3+wgm/wJKFhJA+znNhcAD6tQCpdBjAUPnxDi9q+X0L7ORQ3Z+vxoRgIuLp
         CuWpmQK3d1b7Ltuu7OvaV3sEKP63K30ub9nxWMJo3XmFvFYS6td+QtXzBEwkaOtN7UBv
         86rRoLpn5Da+lfTxLJaGfSOwlPMN9SEaZ/Lygnvu8lu+lXq2+S5+CywkhzjRFb2SR0u8
         SBKg==
X-Gm-Message-State: AOAM5324HsYudVSHYxpRI81hiykiyN9gTwSYyiwlFv9FM4IZxzzp4GgT
        RLry8RffEY3MbZ7ehr8pEdY=
X-Google-Smtp-Source: ABdhPJzwGQWOC0I6R9+OHjfZ/iZ3x1t3TfAOEyesjAPVx/oKo1R9eOfSpI5WOxjRu4mpqrgcWQm9AQ==
X-Received: by 2002:a17:902:f0ca:b0:158:d082:ee3a with SMTP id v10-20020a170902f0ca00b00158d082ee3amr10191448pla.151.1650269806945;
        Mon, 18 Apr 2022 01:16:46 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm11777600pgp.15.2022.04.18.01.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 01:16:46 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] hwtracing: stm: fix possible double free in stm_register_device()
Date:   Mon, 18 Apr 2022 16:16:32 +0800
Message-Id: <20220418081632.35121-1-hbh25y@gmail.com>
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

put_device() will call stm_device_release() to free stm when
stm_register_device() fails. So there is no need to call vfree() again.

Fix this by adding a return after put_device().

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/hwtracing/stm/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699ba08..403b4f41bb1b 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -915,6 +915,7 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
+	return err;
 err_free:
 	vfree(stm);
 
-- 
2.25.1

