Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254354743F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhLNNye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhLNNyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:54:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5360BC061574;
        Tue, 14 Dec 2021 05:54:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13961B819BD;
        Tue, 14 Dec 2021 13:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E0DC34601;
        Tue, 14 Dec 2021 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639490069;
        bh=CFSSHRmfjaMqqbUJcEc7poqXaoNhUH2xA9KZNHxIbos=;
        h=From:To:Cc:Subject:Date:From;
        b=gP8m5WyJ6WOcQXKS3ff5BZwURbVUs7ncZxFb3BEX3QERZSZC4G0Rkn35jNch0fhkk
         /Q/7gG98fPoMuE85UC5t8SoniDouNQkuZTNf6xSsUQbD3BFAtBvIaRokYK6fLbWXW9
         Y/UvxCvwActxfi1CVZ+NAAm06JXNi9Lus1LjLD4GmJo9xCA3GNhovI2AOefHngyCUD
         VAKEZvC+y1lXrcdBI73Jjgb1ovpGx+/XFHCfvKUW/dEXFFz9me+4CsckAQRQZq7Wdf
         tqsxy7lstZnhAArQFCR4VazyX9hr1X9SJxJjJzCEGqVSgnZOcx4O6DLlblgbTdndLM
         EFqSJP57tVs3Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mx8GB-003f6Q-Ju; Tue, 14 Dec 2021 14:54:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: saa7146: fix error logic at saa7146_vv_init()
Date:   Tue, 14 Dec 2021 14:54:26 +0100
Message-Id: <841b07a8738778e3db88afc7c18757edf22f89c2.1639490063.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the first thing this function does is to call
v4l2_device_register(), it should call v4l2_device_unregister()
if an error occurs, the same way as done at saa7146_vv_release().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/common/saa7146/saa7146_fops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index be3215977714..e9a15de6126e 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -487,6 +487,7 @@ int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv)
 	if (hdl->error) {
 		err = hdl->error;
 		v4l2_ctrl_handler_free(hdl);
+		v4l2_device_unregister(&dev->v4l2_dev);
 		return err;
 	}
 	dev->v4l2_dev.ctrl_handler = hdl;
@@ -495,6 +496,7 @@ int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv)
 	if (vv == NULL) {
 		ERR("out of memory. aborting.\n");
 		v4l2_ctrl_handler_free(hdl);
+		v4l2_device_unregister(&dev->v4l2_dev);
 		return -ENOMEM;
 	}
 	ext_vv->vid_ops = saa7146_video_ioctl_ops;
@@ -521,6 +523,7 @@ int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv)
 		ERR("out of memory. aborting.\n");
 		kfree(vv);
 		v4l2_ctrl_handler_free(hdl);
+		v4l2_device_unregister(&dev->v4l2_dev);
 		return -ENOMEM;
 	}
 
-- 
2.33.1

