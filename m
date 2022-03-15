Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF84DA042
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbiCOQlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350140AbiCOQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:40:59 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491B57169
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647362382;
        bh=SpliapCVlfa+D7lo3BSKvVkGgWUYrJC2HluZ0dliScA=;
        h=From:To:Cc:Subject:Date;
        b=j1gUfUjveD44+cikeEOvXTHgEEzZYSWXa/9Ey6IKnwyCTeWg1j+71vRFezMiSS/1D
         s30ULYiWLyh1clZSHN5iFQO+i2nHseuZUFhJbDslT+oUXyyVwZ5JEvfBICI929Vw4n
         fAaMkFCH3UQNEU3cSSfdxSEmr9ZQMHeFSCW4vgHA=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 9E6B06D9; Wed, 16 Mar 2022 00:39:38 +0800
X-QQ-mid: xmsmtpt1647362378te3kqnwz3
Message-ID: <tencent_7A338FE792721C51E887BB2A8DFC0B815C0A@qq.com>
X-QQ-XMAILINFO: MyHh0PQai9FptZrresos5TGYovrAI+b46m/OEFalwsYWPXYAt4CGzqGpH4qHzf
         2gZ+SVmeOSV+UivL+Bfa4Ikq2zTwtG+Z97smM5IdHLqkcNd+luPBz0Yb+eYpR7i0DFS3jCwESFsR
         m5tFS9SuWgxRbyJsQuBbym8kuCs7Cpwz3dW7XyK4yzc1hjTNFGwpRT25qBuMBFNIgOtrk4x/1Vsb
         ZfE4+seSM2vdiI69P51oSn4a0ocKVw44nJZgWtBWyrgbUzNerW7mhuNXY+QT+5f2oYZEBwq3FZtD
         hCJvQW7bb4mUKYry0ovwXK5UQO7v5NPbyHKtKFT0otiVgsp5TVOn4NO6snyt/0CkyDoFhfmgZw3U
         6VK/Y0i6M5mbbfP70ZKhA5/7pCMXmZfs02vRHzEkqv2HOW5Zt3FnQ8+UlATL0O648en5Id8H69pv
         42PRteqSxGASRIo9+7RB3ZJOgt+rEuhz01U9Mm17pZdCeSWvAmplhxrw9KbykJTmsK1Q8dBBFUD4
         t0FuTeXnxskrXnGqAOueZRCQRoRnYrM/vnxqNRCLEeo1dIE9noBWe60UBs/AT+D0E+Dw/xODQ3by
         rN8ZQrtJpAJv3F6DXS5r02PiyqzoOdET3nEE7ksHV3DYjAMtniHgvCHgPqmtnl/BvC/zwZbbuG1C
         /Weayy7PbYKZwaExiDThhLoiardMm2W56CGXKv6dZQgj1yM5W9M+a7b9L61E0D1WFFvUHjzYec8t
         pNpZkzrB188Jj76LomGTLX6/I/0HqURM7XhpmTpapQ3gWHOs/wLpVBsDiHQkA55vH7Z16TxDs/L2
         KVEUi1MmCoPBqc00STWVF+RDT2cCAdiF2uT1AA0W0wjo4ycMmGQ0JNtKdbw6Ih4B9v+IIsqsq2yo
         2SHgxsLj0g+7SV+nMKJF0r7lWIVVCh29/UM8db5wANkZQ5ci1FFOnBS1KmqiukFGmurUnR3Cr3
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        nsaenz@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] staging: mmal-vchiq: add a check for the return of vmalloc()
Date:   Wed, 16 Mar 2022 00:39:13 +0800
X-OQ-MSGID: <20220315163913.878-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

vmalloc() is a memory allocation API which can return NULL when some
internal memory errors happen. So it is better to check the return
value of it to catch the error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 jump to the proper location and remove redundant instruction.
v2->v3 fix the mistake bring by version 2.
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 76d3f03..24cc0fe 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1909,6 +1909,10 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	mutex_init(&instance->vchiq_mutex);
 
 	instance->bulk_scratch = vmalloc(PAGE_SIZE);
+	if (!instance->bulk_scratch) {
+		err = -ENOMEM;
+		goto err_free_instance;
+	}
 	instance->vchiq_instance = vchiq_instance;
 
 	mutex_init(&instance->context_map_lock);
@@ -1940,6 +1944,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	destroy_workqueue(instance->bulk_wq);
 err_free:
 	vfree(instance->bulk_scratch);
+err_free_instance:
 	kfree(instance);
 err_shutdown_vchiq:
 	vchiq_shutdown(vchiq_instance);
-- 
