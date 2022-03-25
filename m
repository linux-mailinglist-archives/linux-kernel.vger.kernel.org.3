Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F014E6C81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357713AbiCYCZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353004AbiCYCZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:25:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888266CA7C;
        Thu, 24 Mar 2022 19:23:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so6468205pjo.1;
        Thu, 24 Mar 2022 19:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLPbTGedm4xr/YTn/u6ZSt27apCCg2RLzYht4m+x68o=;
        b=V1i+SnrtMgJ7lLWBomo/2Ip+LLFtZv2g/WRVA+iqMed4KOxfjZi1tXdpo5m/MCJzhC
         SMZD+DBWmmgH1V8UqFEsIUl2U8QqhS4T+MfVnIgD2zZsfjGk9rk7eKRdntaBTNEQTtu4
         wdWW60eyuNApWvfhZcPyaTf2bU0lsbuBQaHkraZM/yWSJq8gNmfX/QZBExKQuSgWtwyx
         m+ZxoB/A1QNrDQTPePFHVSHqe8HsfStSRDQneWwdKDBPP+AYHipbTh50nHmtClDSDL9H
         L8uDNegbiduYtOWQW9iBKOQOKHJafeBZsGLJnu8bq0naxJFvoIsPiikxuZoinxboRWbt
         +wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLPbTGedm4xr/YTn/u6ZSt27apCCg2RLzYht4m+x68o=;
        b=cywcjrkxDphJ24cPWWlRxYfls/idZUBCt4q0Zqz09mZNajEwSKA7dEbq+2A2otQTl/
         6IULDR/qmHc9HxdQ3n3x7pA53ZeZxWzn+oBgwgYrqZ92SQwcW6qiepPczDNDSSUyxP+i
         3KISR8pdrdTSHdhQ1nTwboyDXZs6YCKqowShAMrvHYiGiJE3mFqWbhMvK5D/XFXRC4fI
         UXDO9xuPpLULrFd7hTMTut5gAUEHgEHH0eSCn6uOv7sZ6AyAuaxXsSGnvMt5+YfO7g/v
         PS4ysA26uU8cS0djRDpNAu76WM90N+BND3wJE/wjIVkwg2Bzrit9zYfEPD0S5PCGvDaF
         zTmw==
X-Gm-Message-State: AOAM531AK6BYtuFZ17sl31qBKZLUJBY/dcaIrx4bJObS0ujPJuuzE33d
        nU5yl99j8yECnHkHj2IPT0cTsAyxlcY=
X-Google-Smtp-Source: ABdhPJzoZFV98tQ3i/NAHIRdScom8EceGtWwsMEzSLzr+ggr4h1NasdOCAMEhqxz0trrX/+Lx+rOWg==
X-Received: by 2002:a17:902:c401:b0:154:1398:a16b with SMTP id k1-20020a170902c40100b001541398a16bmr9132984plk.67.1648175031065;
        Thu, 24 Mar 2022 19:23:51 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id l192-20020a6391c9000000b003861d9431c7sm3729069pge.62.2022.03.24.19.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 19:23:50 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] media: uvc_video: fix bit overflow in uvc_probe_video
Date:   Fri, 25 Mar 2022 10:23:37 +0800
Message-Id: <20220325022337.10893-1-hbh25y@gmail.com>
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

probe->dwMaxPayloadTransferSize is a 32bit value, but bandwidth is 16bit. This
may lead to a bit overflow.

Fix this by using probe->dwMaxPayloadTransferSize directly.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

v2: 
Use probe->dwMaxPayloadTransferSize directly instead of changing temporary 
variable.

 drivers/media/usb/uvc/uvc_video.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1b4cc934109e..e016f88bdf96 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -383,7 +383,6 @@ int uvc_probe_video(struct uvc_streaming *stream,
 	struct uvc_streaming_control *probe)
 {
 	struct uvc_streaming_control probe_min, probe_max;
-	u16 bandwidth;
 	unsigned int i;
 	int ret;
 
@@ -421,8 +420,7 @@ int uvc_probe_video(struct uvc_streaming *stream,
 		if (stream->intf->num_altsetting == 1)
 			break;
 
-		bandwidth = probe->dwMaxPayloadTransferSize;
-		if (bandwidth <= stream->maxpsize)
+		if (probe->dwMaxPayloadTransferSize <= stream->maxpsize)
 			break;
 
 		if (stream->dev->quirks & UVC_QUIRK_PROBE_MINMAX) {
-- 
2.25.1

