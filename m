Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AEB4D5BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346927AbiCKHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346916AbiCKHDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:03:16 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D881AAFEA;
        Thu, 10 Mar 2022 23:02:14 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o22so6636284qta.8;
        Thu, 10 Mar 2022 23:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvaYo2cimBpUC52A1zMiwrJzooNeMXFHyymI5Ni0pQY=;
        b=bOUtlZpsu4wVKoOC+ID+rxLV9D6EYjf4g/iYWDPPeOpwRsK+Fyqx1Yet4K7S4WQHFF
         AasMvFtO9ZI5hcBNDqkfu3mPyg8rJ/XrzsKRXkxLk7g5X0PFbwRmO6biYfT4YG47O+TA
         FmVFFUOvsdmZbz2fHIbs9zogimPS+c1TzWsu2fzbQfJGj9QAJjwVMjzsGRhiSfQT1c5O
         JvN+S1/vEva+vzVvLkaDbuzeQAWuBSTVEvHSPNKaWfExvdoLhd39RS16CV2mFUe94Pnu
         epe3dKFiXkjF2qOU3e/sBmctv3naGUIIGmz9CTN10gqs/bovizOOoQR70qzeNa8vBWUW
         V6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvaYo2cimBpUC52A1zMiwrJzooNeMXFHyymI5Ni0pQY=;
        b=jjNWlN8a7eldy735lhqBBDHc91jZ2Y7n+xlV54RwsvkaQv7DRbTfyCC6bXwhMK7hZR
         oUUCemBE+KTv1/ycl1LFR1EwlGa4xF1UTNxb/QjaHpSwZuJyOt+U1wav+UzFw6tG5zGC
         y5aBg2uxkcGC0isGhhyPDHF5cKhoSDMZ+QthXSyT75i9tXXdxvPJyR1xjIc53OfVm6+O
         UpoZrVsYvUu4H0m8/WZJZJegr2BAyC02xlZarbCltVnF7vvnK6hdIQmJVFi8uJBtGEpI
         4ojQXMsLY3y7E9Cc8aAnEY9IfW9ACLuN+07TjDz/QybD5kaiHz81OYGGgNmTQyzUBJq+
         qLZw==
X-Gm-Message-State: AOAM532FOt2mxvRL13IcxG/qdHb7moHtKdxfcqPHBheRNfdCRHyXarSs
        WOLery4vyXizJK5zXS4CXV4y/lowB/o=
X-Google-Smtp-Source: ABdhPJx2kZLNWgXhY+Tv5Ear02WQgXVRYuHG+84lw/Yvp1LZhPYxbxNGrxl045/ZGRpelOTw6ha56Q==
X-Received: by 2002:a05:622a:1c1:b0:2e1:b35c:2aa9 with SMTP id t1-20020a05622a01c100b002e1b35c2aa9mr4622353qtw.313.1646982133259;
        Thu, 10 Mar 2022 23:02:13 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a138800b00679fc7566fcsm3352834qki.18.2022.03.10.23.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 23:02:12 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH 3/3] serial: 8250_fintek.c: Clean up set_termios() message
Date:   Fri, 11 Mar 2022 02:02:02 -0500
Message-Id: <20220311070203.18159-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
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

Clean up the status message that is given in the case where a custom
termios() is not installed.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 03ad2354d808..dcab23d1965e 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -333,7 +333,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
 	default:
 		/* Don't change clocksource with unknown PID */
 		dev_warn(port->dev,
-			"%s: pid: %x Not support. use default set_termios.\n",
+			"%s: chipID: %x not supported; using default set_termios.\n",
 			__func__, pdata->pid);
 		goto exit;
 	}
-- 
2.34.1.75.gabe6bb3905

