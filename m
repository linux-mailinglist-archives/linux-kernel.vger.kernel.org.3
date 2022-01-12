Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF848C2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352724AbiALLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiALLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:06:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307D6C06173F;
        Wed, 12 Jan 2022 03:06:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id pf13so4175734pjb.0;
        Wed, 12 Jan 2022 03:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=efnCwJ4wgzV+ae0TxSAq8p0i4hZZzCH5LWLiMt2dAJE=;
        b=f/1n3avpzsj/EuXCiZYRr48U0S3OM7RPnCSuk27DXVwMQM7Ju+p8IUkhwDhgg6Ml4j
         Gj5IFn5u3bC9FduiQO+qhtHpneaxd4WstAIuj6KV58CNEiN5gfaF5m/WY6fCmSE8iwKg
         o8C/HzigxznDVMQ8XvaWb0N/dvbVUMcsaMBsKYc+UQ924jXYs2guYlYwlcBsOn9GVmW4
         3txrEZ3xiOb8TrziW5OO/M04KJsTURXSMIcsdodIobGfi6KrooqAgqhUJ651FECGBhRQ
         P4Wb+ccLav2WUBa6T92m39vulNuoLCkLyj43bK2Yekkmby/5xiTmXVmkw8FxZCv9qjvf
         bv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=efnCwJ4wgzV+ae0TxSAq8p0i4hZZzCH5LWLiMt2dAJE=;
        b=yL7z+6ZpCYKMPTAR/ut3iVY0FM4Ydvlqt0gZUgdgq7Xd7og/Ry+TySvKgfVpAGIIMr
         liURm9wvhdvCCn9Csre5neeiH7YddBFDyqhx/He6tvsdZpuyljFOHpzApDtH4tMSPvVF
         nZYPK0ACcWzzokXKfEBDZUlTUqgEVMczRw/JsbDEFxG0+unC5AG4MqUIC18OeRbj52Cm
         cLR+S1qO+b5B0Rh0lNewFJscF+8atzEZ6np5cTJNS2tCe9U+ymMvCJC2LfNnk+i2WPcJ
         97wnTF5udeJo8QgxFKWvJ7GBbO3PTOYXcPYQ359B5SWo73rcra77OKEzBwxiyK7b9but
         IflQ==
X-Gm-Message-State: AOAM533f/C6BL3Rw5DH8MQrPf5qS8P3g9dJy7WZoWQ7l0TtiO2zmiDUQ
        ozkOyQURzxhfasY0j2eUhaA=
X-Google-Smtp-Source: ABdhPJwZ7JmlpvrmkxPo12gxEGrApToWsgG2LYg4nmFl+Su9WKF1tD+v6QwVtUq2UJN2XeJ7stIizA==
X-Received: by 2002:a05:6a00:8cc:b0:4a8:262:49e1 with SMTP id s12-20020a056a0008cc00b004a8026249e1mr8715366pfu.28.1641985559757;
        Wed, 12 Jan 2022 03:05:59 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l3sm2291605pgs.74.2022.01.12.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 03:05:59 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     hverkuil@xs4all.nl
Cc:     hans.verkuil@cisco.com, linmq006@gmail.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        m.tretter@pengutronix.de, mchehab@kernel.org,
        p.zabel@pengutronix.de
Subject: [PATCH v2] media: coda: Fix missing put_device() call in coda_get_vdoa_data
Date:   Wed, 12 Jan 2022 11:05:54 +0000
Message-Id: <20220112110554.1862-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5454a150-7b11-dbce-02c4-d300c6629b1e@xs4all.nl>
References: <5454a150-7b11-dbce-02c4-d300c6629b1e@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: e7f3c5481035 ("[media] coda: use VDOA for un-tiling custom macroblock format")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- remove the goto and unused label.
---
 drivers/media/platform/coda/coda-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 0e312b0842d7..c3942b0abb00 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -408,6 +408,7 @@ static struct vdoa_data *coda_get_vdoa_data(void)
 	if (!vdoa_data)
 		vdoa_data = ERR_PTR(-EPROBE_DEFER);
 
+	put_device(&vdoa_pdev->dev);
 out:
 	of_node_put(vdoa_node);
 
-- 
2.17.1

