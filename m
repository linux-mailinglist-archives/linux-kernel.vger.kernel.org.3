Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AE485218
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiAELzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiAELzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:55:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE87C061761;
        Wed,  5 Jan 2022 03:55:20 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s15so1753147plg.12;
        Wed, 05 Jan 2022 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=tfM/oThxtZdT0kWK/p6dyocnph8PZgVSfg/3ZzUxc3I=;
        b=NmyHL4e6XdZUSrzE/KamPTHY7G0i83fiCTFEFgX3QDusJ1IFc8CVIjo1EBuoJIy6JF
         O80pfT+OFiwaQj2ZxO/MZJoMvnWn3BBrufhkDxsqEMruqOi8IvwlfoN2McyEVmCkkJwV
         PmUB0A9RnzK85IwWcb5EIQLmBaPLP03MHxpp9fUrdQs4ECf8eqiZe6uLK8z0dXYLE5FM
         Mxe9A/d0n4wbgEkk6c0aSXFBS1aYDTlNfEvfOpm0Q237f8Tgv8pMm7tOWpoL6L2ZLG0i
         z4PT0LFyCw2OR1fV+esVFFcgeOaxE+rYpdIpMayte9dwElI7J7yQBjLlJ/Q94VRGdmXi
         ATWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tfM/oThxtZdT0kWK/p6dyocnph8PZgVSfg/3ZzUxc3I=;
        b=ubHuO+RtC9/8+xhLU7dZTlITL0j3ch/1rGM+Kqo1SW03cTtV1dRJ3WaqI+QoTuEd4s
         PTQbVPfDPy0D+tk2Vh389ZFSTAgnByRA/zlktIVr5EfI6ouZ90297Tj3KSANXLVZY5Y6
         YzgdSlkxm7vR85UnaHNK2SyB7t+vrLi1FCJJpXP5814sVnJ6gtMgRXLdWCX+QUddx9yI
         8jvSiNQmP4hAKe0Iig/I76g7Ql/bhb8+nhoIXZAcI6/O5vSuCtv6PMc6lWI7j8TpVHtr
         IVj5Fsxe8E8MndQfaf01/MeHuu0H5PnU3vZ4KstOtKmdGY9EDm3ix94u2RifDBmLBVzT
         eSbw==
X-Gm-Message-State: AOAM530dFLuNCqXzIejIMG9qbsneuJfVpjlGylhCMuqd1pSIQSnozEat
        tC2NnsKYyCIc45W7ilwBUB+UOGIwUDSGbQ==
X-Google-Smtp-Source: ABdhPJxoBwzP/r2V2UoNp6nUCfWg8s7NKCgleoJO3xXpIcn6I8AN276yXcFfjsx3ApRUUJme5BMjOQ==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr3763804pjb.50.1641383719859;
        Wed, 05 Jan 2022 03:55:19 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x8sm48502967pfh.210.2022.01.05.03.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 03:55:19 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: st-delta: Fix PM disable depth imbalance in delta_probe
Date:   Wed,  5 Jan 2022 11:55:15 +0000
Message-Id: <20220105115515.12196-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: f386509 ("[media] st-delta: STiH4xx multi-format video decoder v4l2 driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/platform/sti/delta/delta-v4l2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
index c887a31ebb54..dbcfd0484da4 100644
--- a/drivers/media/platform/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/sti/delta/delta-v4l2.c
@@ -1898,6 +1898,8 @@ static int delta_probe(struct platform_device *pdev)
 	destroy_workqueue(delta->work_queue);
 err_v4l2:
 	v4l2_device_unregister(&delta->v4l2_dev);
+disable_pm_runtime:
+	pm_runtime_disable(dev);
 err:
 	return ret;
 }
-- 
2.17.1

