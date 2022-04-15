Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB1503113
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355668AbiDOV3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355123AbiDOV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:28:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121536E37;
        Fri, 15 Apr 2022 14:24:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so10661198ljr.9;
        Fri, 15 Apr 2022 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xC9M13pgoSaGOx2W/G3KE41A3zFS9etpgImmns7Xikk=;
        b=pIdhc9wMHvSmTKuY9sOqz6OLGHA39eskxFYT4khQXG2MrgvqsPIFG/Fg5ImrYqoVrL
         KH7395K4HTuXqFoJp5QZXMo/TBAzwIPdBpzQmJzSMdbFFveL8TRP03YqlEOPSX0nmA3a
         Liuv+r9Q19hx81bFI0s4EC+UMXBu20YnQkO9qRuth7vQzKJKxxQPSctKqUx6+nGmmhKS
         igVf55975B5+pi9h4J5wp5Kjm7jMxVVOquK9zoCVO41ZHZG769+hi086vpAeOkQ7TxuH
         jsjzx06EhkhHHRoc6yDpRbHU6rBFTUVh6DKFhbxX/uL64fZzjJMexEhrczSesqY+ExuS
         n05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xC9M13pgoSaGOx2W/G3KE41A3zFS9etpgImmns7Xikk=;
        b=FfneGfA+0Bs8QewToUYQhOAv4ieGNAzGq+maKbxnenJ1oBBLcoQwGEE9iJmPoJ/rM+
         +gbBXpteXaTkyYLuS8iGtdU3qy9EIDSWVaenzD52Ay3IoQILLvURFEWPggh6h4jBNBPt
         kN3zuyxsFiO+e0L8xw0xe4Y1JICOwyDtZhe24Qr/N2ZbL8/koykvL9KS4ngvQ5FALo0g
         uQHjGVPoeK+ndKxU5YZBr7RjQQBwmTrNJC+0uXxpxnl+ZCQTMfQM4v0nQ0X1iBYW7z2h
         bhNZJuqF+0UzG27rJjCUCVYE9RROVbryrkyVWhbveAoJjuO+hWNz83Rr6i9jkMp+TTW7
         pB3g==
X-Gm-Message-State: AOAM531LpdqagjvSvd1Y6x2Tdq4Xw9xgiQgtmZaM56kE27rlcBqYHGCA
        yHMKDI/62gtpN9PJ2weDQDY=
X-Google-Smtp-Source: ABdhPJxU9VJCryFGYRMhBONyWo+rg81k3Gmt2hMdXkjcHuqAepjCBIbyQqPXy0yhiDmn7Kg8bHjhSw==
X-Received: by 2002:a2e:b8c2:0:b0:24b:6b07:fafd with SMTP id s2-20020a2eb8c2000000b0024b6b07fafdmr534896ljp.207.1650057890790;
        Fri, 15 Apr 2022 14:24:50 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id m20-20020a194354000000b0046f8c68f965sm217432lfj.166.2022.04.15.14.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:24:50 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     isely@pobox.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com
Subject: [PATCH] media: pvrusb2: fix array-index-out-of-bounds in pvr2_i2c_core_init
Date:   Sat, 16 Apr 2022 00:24:48 +0300
Message-Id: <20220415212448.7290-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Syzbot reported that -1 is used as array index. The problem was in
missing validation check.

hdw->unit_number is initialized with -1 and then if init table walk fails
this value remains unchanged. Since code blindly uses this member for
array indexing adding sanity check is the easiest fix for that.

hdw->workpoll initialization moved upper to prevent warning in
__flush_work.

Fixes: d855497edbfb ("V4L/DVB (4228a): pvrusb2 to kernel 2.6.18")
Reported-and-tested-by: syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index cd7b118d5929..a9666373af6b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -2569,6 +2569,11 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 	} while (0);
 	mutex_unlock(&pvr2_unit_mtx);
 
+	INIT_WORK(&hdw->workpoll, pvr2_hdw_worker_poll);
+
+	if (hdw->unit_number == -1)
+		goto fail;
+
 	cnt1 = 0;
 	cnt2 = scnprintf(hdw->name+cnt1,sizeof(hdw->name)-cnt1,"pvrusb2");
 	cnt1 += cnt2;
@@ -2580,8 +2585,6 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 	if (cnt1 >= sizeof(hdw->name)) cnt1 = sizeof(hdw->name)-1;
 	hdw->name[cnt1] = 0;
 
-	INIT_WORK(&hdw->workpoll,pvr2_hdw_worker_poll);
-
 	pvr2_trace(PVR2_TRACE_INIT,"Driver unit number is %d, name is %s",
 		   hdw->unit_number,hdw->name);
 
-- 
2.35.1

