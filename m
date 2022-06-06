Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C3A53DF74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbiFFBnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiFFBnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:43:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D4637018;
        Sun,  5 Jun 2022 18:43:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v3-20020a17090a0c8300b001e862664a08so2760843pja.5;
        Sun, 05 Jun 2022 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gaObAl1davpaWK8mfs4rknFImeJO0Clxwne4OGIVgnU=;
        b=OKywvTXZJO3SG4a0nthNnL4RJKayjxIy4VqGQNXyA5WGzGVyYnLAmb/MfD6eBz5+3A
         BJMs9CNxsLB4gDHOH0e3DC8dv8vwmnVgogm+Kv3o7EW4ql1GqbzAVC+Zgy6UOGRLAeyu
         LfL0A9bczBftYg7Evec/fXsqieN3772yekCwz/oKM8Q8s60SiBNimhdGZjuXcDQkxZ5D
         dDXed9jZ13uUEhPYcCIl8jAaxg+EvY4zzREzuGQyaG+DmMjvjTU0ZmDGPIzHipFsTsmE
         VP+yihqfX3Pb5e6WGB40g0c2EBSn4I2o4gYXogtZz66Zs5x+z6uP+mix/KwQuC4DyZz9
         9xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gaObAl1davpaWK8mfs4rknFImeJO0Clxwne4OGIVgnU=;
        b=wEsfOuR/50CVKCxfxgyddAEnyrpgA+2ZgPUdVxlLTy98nLlwRbB4fNoFdH/JRWfkrr
         9heO+gDo6VdBQOtJQ9Y5IctZPilIRHSnmeNcmh8araFtISyPsbkysL9UwpMf0nsSN5D4
         AV9KyPijTaRYUVufsLd7b9c4eo0oyZ81xIb3PCR3J1TCrQLOWuKUe4y15p9Z/cZe4eTF
         ReMAZSQfhvmHQbN1Wf3TvjLzI3k/JE5eFx+840L8HDXBc7OLyHT3kIi1p13baOyxsVrt
         xuCTSomBRoGuqXu6vHdCb9o/I4gnt/WJghqtSMyXymewDj+K4fsfXiSoRbPDexOdQy7v
         C4Aw==
X-Gm-Message-State: AOAM530CKafeAqFFbVafae43NfSQgscXMTQTKkuDvwFtvY/A8wMrbTDL
        q+E4qYFx+xxVDAiM+UmpgKs=
X-Google-Smtp-Source: ABdhPJwlYWzXXakJW+sH4spMPRqGoEX14QImNoPI26mASw6g+PMMrv6OzjRiOUQSjhhECufVRP+fRw==
X-Received: by 2002:a17:902:f710:b0:15f:165f:b50b with SMTP id h16-20020a170902f71000b0015f165fb50bmr22467940plo.158.1654479798701;
        Sun, 05 Jun 2022 18:43:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a001c4800b005183cf12184sm9299315pfw.133.2022.06.05.18.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 18:43:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] USB: serial: Remove redundant NULL check before release_firmware() call
Date:   Mon,  6 Jun 2022 01:43:15 +0000
Message-Id: <20220606014315.290533-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

release_firmware() checks for NULL pointers internally so checking
before calling it is redundant.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/serial/mxuport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index eb45a9b0005c..eb9090ab900f 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -1109,8 +1109,7 @@ static int mxuport_probe(struct usb_serial *serial,
 	 */
 	usb_set_serial_data(serial, (void *)id->driver_info);
 out:
-	if (fw_p)
-		release_firmware(fw_p);
+	release_firmware(fw_p);
 	return err;
 }
 
-- 
2.25.1


