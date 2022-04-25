Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4411150D913
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiDYGCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiDYGCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:02:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F639167;
        Sun, 24 Apr 2022 22:59:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j8so24639064pll.11;
        Sun, 24 Apr 2022 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fi7c2Ax/VCFNVFgm2nwELIS3JlCMe6WYe6H9+qK+G/U=;
        b=cLVmPjqmCvUEDd4fjcseFK6HQjuoPAQB3y1G78k2XJC68fMNrW4Gdo6y3TSMqS08LW
         LTjWAKPSwDh/KE/ozu8vxNpq+7UWmn3lUz6iVamBgeHJMv57A+LNGZG6basaSgdWfRIP
         zv/NxzSucM/VD/z2xsy6BzOpPtE01eBUy2F9HIiaRuTRyaQQ/1YQW8lrN89FRMcajlVc
         URcmq3gbgC15lt8n+iroJ1xmhDplodSb1kOKbqBkcwOysbGbaLN5fDdHqSnGXCfegH+f
         iCpH/owWlr2cN0Y7lWA+GmmVfFuK5hWtisTSIi7yZtxo69lne4Hom8eCBEdcG1+UDjNo
         BC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fi7c2Ax/VCFNVFgm2nwELIS3JlCMe6WYe6H9+qK+G/U=;
        b=Vuv5L0q5yHv1ovlzgQyeAbYXmMVOrWApg22GoBt2l4XRrkBwsexU3p6sFeU5/XXat0
         m8d+pLhA6KvUXDZtQlgcriV+28OnmGB/niIOvwEtJRNadOSIjkjdIoDQCVWVORv0HhOY
         k0eHRS+h0HfFTNEBrCI7JQ1xD9Rfmli/OelpeciibYKsbbgIJVnKHKfxaChUV0ZFZmJX
         foqKg4iVBCk6EYW8+5oeWR8KhByvTsiB7otWFD7uKTOMJbJiGs4innzhZFmJZioLCS8t
         UmYj8RsneyL0f61Gdfhry29jMxTtPkWueItwo2fGabJZAKR8FVuGzIiZC3i4RL9tBbea
         Sj7w==
X-Gm-Message-State: AOAM531xIa4x6PC4PkaIC+kn4Q54OCY3eZA8RxQsYQfBEW57DpdHBsJR
        0vJj3F0KiUWWO2Lkt1LJNqI=
X-Google-Smtp-Source: ABdhPJwkx4IuJWr3uzNSEZGGA6UERFPRYUBcQ/tmL1ZMH7YujU7Bz9EWin5t1K6GxoyOQsiYuxG6pg==
X-Received: by 2002:a17:90a:3d02:b0:1ca:7f92:1bf1 with SMTP id h2-20020a17090a3d0200b001ca7f921bf1mr29785221pjc.177.1650866344096;
        Sun, 24 Apr 2022 22:59:04 -0700 (PDT)
Received: from ethan-Latitude-7280.localdomain (125-228-239-174.hinet-ip.hinet.net. [125.228.239.174])
        by smtp.googlemail.com with ESMTPSA id t29-20020a62d15d000000b0050d42864753sm1445595pfl.49.2022.04.24.22.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:59:03 -0700 (PDT)
From:   ipis.yang@gmail.com
X-Google-Original-From: etyang@sierrawireless.com
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gchiang@sierrawireless.com, ipis.yang@gmail.com,
        Ethan Yang <etyang@sierrawireless.com>
Subject: [PATCH v3] usb: serial: qcserial: add support for Sierra Wireless EM7590
Date:   Mon, 25 Apr 2022 13:58:40 +0800
Message-Id: <20220425055840.5693-1-etyang@sierrawireless.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YmYvPXeqQzyms91m@kroah.com>
References: <YmYvPXeqQzyms91m@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ethan Yang <etyang@sierrawireless.com>

add support for Sierra Wireless EM7590 0xc080/0xc081 compositions

Signed-off-by: Ethan Yang <etyang@sierrawireless.com>
---
 drivers/usb/serial/qcserial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index c18bf8164bc2..586ef5551e76 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -166,6 +166,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
+	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
+	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
-- 
2.17.1

