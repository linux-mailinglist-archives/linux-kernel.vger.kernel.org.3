Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9640250D386
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiDXQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiDXQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:34:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AEBFDE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z21so3801496pgj.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6r7KK/tVAx0sjPVp3tILmKeJu/38lcENgltnQBPPgeQ=;
        b=fweOx7s7M54r9NkQZOlYnmgGnowpDNCRIhAzw/6OK12Xu63C4TtLHHXpnb/rHRjCUA
         gbnkjCEbaDWLU5lHZnTf8/I5eeUyfTkfaC5wL0ju/Nq58cD6VbfzbWH0P7vldzhagY7k
         cacBwsAIbSvrUnk3bR0VV/0I4CLdCK5QTCyIYnJHkw2B20zhSXfpOH39+gUULRP/ggsZ
         0KYfVV0Xf6s9fOP9CzNmAiimrF7K76B+/jCYr/j/Q4o/2toR3l31qJKa6OOuWuOs41/M
         LjjJU6cffPfAhEAJuMadPG95GIUB0r+pWkOTQcDquojmLSVaAEFt0J6quYqiyR9/yN0s
         Tebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6r7KK/tVAx0sjPVp3tILmKeJu/38lcENgltnQBPPgeQ=;
        b=ilXCez1tILZq6voa6IAeCcD+xPl7HVG7nMNeLshWtGCU00GXrlA+gJmmxq4AqE01Tg
         Xr3c2fesGbod3XJMI2V/a9dddPzBFW8oHo7Gs5CvxIBMpHpXdTlOaV3IneApW2vzhSyx
         JTkbhV3ShlVQkG8YXdO42N2Si61UyC3zlASLZnA8FYfgMsfA452oPdsfji7zNG9WGQC2
         o3jyHRpDJQYYdZthZzRslyuz3l+vkGxrM4cvr7bb/ukpL8TsjQanjmnRYwks5hai0hQ5
         +gICstLcffOWXPNv5iEn0p11LjA1ngBP1kmkaIGFnysQvnuKA2ScUde0PO9Pznxjh0e+
         MVwQ==
X-Gm-Message-State: AOAM5335rUHaM1GQHgRW/hJmz5Xbe9bWsUtUdAdA5OBtX/3obiw0HeMq
        qxos9juySMiCaG9rMK8rpRw=
X-Google-Smtp-Source: ABdhPJzIIQ0v51BOpVdy1phawtYwHXhzz9cwWVOjZbc1L6iXmxAf40wS1L03nHY4CWvlG261RaUyqA==
X-Received: by 2002:a05:6a00:198c:b0:505:c18b:3184 with SMTP id d12-20020a056a00198c00b00505c18b3184mr14649085pfl.82.1650817910032;
        Sun, 24 Apr 2022 09:31:50 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:b82e:45af:4bb0:4014])
        by smtp.gmail.com with ESMTPSA id i5-20020a635845000000b003aaba2d78c2sm7113472pgm.71.2022.04.24.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:31:49 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: fix null check in _rtw_enqueue_recvframe
Date:   Sun, 24 Apr 2022 22:01:31 +0530
Message-Id: <20220424163132.37007-3-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220424163132.37007-1-makvihas@gmail.com>
References: <20220424163132.37007-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a NULL check on padapter in rtw_recv.c:189 which makes no sense as
rtw_recv.c:184 dereferences it unconditionally and it would have already
crashed at this point.
Fix this by moving the dereference line inside the check.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 4cf9b4b8f..7d306a3c6 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -181,12 +181,13 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
 {
 	struct adapter *padapter = precvframe->adapter;
-	struct recv_priv *precvpriv = &padapter->recvpriv;
+	struct recv_priv *precvpriv;
 
 	list_del_init(&precvframe->list);
 	list_add_tail(&precvframe->list, get_list_head(queue));
 
 	if (padapter) {
+		precvpriv = &padapter->recvpriv;
 		if (queue == &precvpriv->free_recv_queue)
 			precvpriv->free_recvframe_cnt++;
 	}
-- 
2.30.2

