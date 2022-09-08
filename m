Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629DE5B1607
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIHHyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIHHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:54:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651E12088
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:54:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v1so3693694plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pEOR3JQfJb5bAPqeJhsVSKPLNxiI0x8dqxgcBgGfmAU=;
        b=FfIeBUvGG2WNrNe83MK1XhRJXFwdDcmvpoRqWFo/VCsIPohCH2Y+hImPYno85UavFM
         vbPrdI05cQLetYdvy//D/xOnEdk500ZYf5pfjSBnxxfAUq0tVgPVn1ES2atXkPmspuMp
         XYSY4bXLijVG/J/DK8qeNSwbu0/gcfb8nNo2JmTyP2njmqiVdmM8sylBaaK81A18qnaG
         OuzWpdNQAaCIve2qn1WGi2JYl58DcsJx/Ki2ciR+WHuvFcc9vEfBkMHBVdXj6Uoy7Se8
         DwEm5O5TcOAOJz9XabFQ1LABHCcUPr0ShzeU+dHdJgRX4PPTzd0zGtMqoQdzR+TIdED6
         wr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pEOR3JQfJb5bAPqeJhsVSKPLNxiI0x8dqxgcBgGfmAU=;
        b=0fJt2CRin0tj687kDFmcVIv5WOUnP3ZHWs/tqmVAUlannJi4knqFN73VTWWSdfKJRw
         9abiNcPUCh2sV49w51MRSVAaQmn8yfgqqreV66QMTSWED8jMIy7Mrgakm8LtIIviNmgL
         H1LI6+ZaBEEEBpW+A4AHsYj7tGJn+p4RADDmgK1T7GPjO/blvYncu+UC+hAA702OWaYJ
         tSnwXzEwFJoihDHN/T5Y1CjcBYgZ//6iilHlBv272bbAdGmGjla6Yrij0kxDv1bij7Ii
         rleTaoMwd6nBbS4ulHzUH7amt0eZhwgiUN0KZq8sM+ur7Jg8ZzOmvEPk6FD+PxpVNcv+
         YrAQ==
X-Gm-Message-State: ACgBeo34+cF340/dtaAKN1cjG5VC5LNBkBzOuyMQevCVwrHz689c/dnu
        s4M39CWFrogJBOaEbxTZaAA5bbAusTU0ozg2XpI=
X-Google-Smtp-Source: AA6agR54A38Com8CkRDHCsTq2sYN8eyY2eZxMZl02HWYEodW9HcYTAyRb8ikwkqvrmV4t1QwIGE7ew==
X-Received: by 2002:a17:90b:390e:b0:202:5d4e:c1f2 with SMTP id ob14-20020a17090b390e00b002025d4ec1f2mr2842543pjb.45.1662623675847;
        Thu, 08 Sep 2022 00:54:35 -0700 (PDT)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id y1-20020a623201000000b0053b850b17c8sm11645952pfy.152.2022.09.08.00.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 00:54:35 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        changlianzhi@uniontech.com, dmitry.torokhov@gmail.com
Cc:     linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] tty: vt: add a bounds checking in vt_do_kdgkb_ioctl()
Date:   Thu,  8 Sep 2022 15:54:03 +0800
Message-Id: <20220908075403.27930-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

As array_index_nospec's comments indicate，a bounds checking need to add
before calling array_index_nospec.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/tty/vt/keyboard.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index be8313cdbac3..b9845455df79 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2067,6 +2067,9 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
 
+	if (kb_func >= MAX_NR_FUNC)
+		return -EFAULT;
+
 	kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
 
 	switch (cmd) {
-- 
2.34.1

