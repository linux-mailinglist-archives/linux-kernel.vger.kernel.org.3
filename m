Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B715A1C43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbiHYWYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbiHYWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:24:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4194C5787
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id hf17so3012688pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vTaJzQMO9aQaSOztqsBCXeGz2f0zGMSY5MlxCdWwSg8=;
        b=XnjJkmq6u8U4v8LTvkmJXfZqTtNkoIPS2vXVr6w6A31HXSAKy3omT0D6Hu3vy/y9f6
         6KbNrzL6Ga/Kmoy3sYuKNkjTKnebJw5l7D0Yv02Cykq08nK4w60sV2Bl+bpDLdpNKC9W
         7DBjT6Q0EOF11ssVZu2d2SG4lFT8luTotjDuRhnNHvCTZITEDGgycasInYxso+/crnRW
         NzbsxC7dgiSA7+/9vC0IT+yyI9AVLb7Q/405BEhDIAWBAW9qCt54EwGLxumqvD44IxvD
         u3JMRl8ZEhv7LEVyiL4gMJ/z1cl+Cy7HJuQGVKO5eWp7NIL32gwvVJRvUnflJLAN+1Xv
         65Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vTaJzQMO9aQaSOztqsBCXeGz2f0zGMSY5MlxCdWwSg8=;
        b=FIipZbr0p5XYXuRLnjHiVbJtGEMPsef4NVoyO28hexuSUK4TRm2sH9Q9qmYsI+p3PG
         KuXAfkKN6PDyyW+FT/xgBTdqQHB0fx4xXWr0uXYd79VEhmEr7Hzon+yWSCeLvED0oMXx
         SQr11H5pxPQd3Z/Mh3FrjyzId2WXZeWgOgZkPPVnY2IY0sl+CnNStjHu3BsMPfA7sVE7
         1GvvbUPnaxpSC1adhhu9EEpr+V5ayHPfLG6Ok6i28Aoe3haSzs3aNiL9bn19L9cX/VnB
         +nHkufZqvhK1bKD4D19yau+oHDHhUXd8+LYF19Yp766gNgu/nMJ1PdZswZk2ZF1srJcX
         KQWg==
X-Gm-Message-State: ACgBeo3F8DE3DJiEEBLbTP5LSHWOWr2LgRL++nJd4VF/fx2KdpWHMpBW
        O6TurlMgPX2hL04RYed6CcU19qw7vL5E1Q==
X-Google-Smtp-Source: AA6agR4LjPJYprSCKGQdARvvaSzcXHKYqunWoN7K+wLtj3MBvKXjL3vhYsWfkFMNvHUT2JgeiTnMOA==
X-Received: by 2002:a17:902:7c8a:b0:16f:4d4:ced8 with SMTP id y10-20020a1709027c8a00b0016f04d4ced8mr1015727pll.15.1661466277179;
        Thu, 25 Aug 2022 15:24:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b00429b6e6c539sm81820pgg.61.2022.08.25.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:24:36 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: [PATCH v5 1/4] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Thu, 25 Aug 2022 15:24:17 -0700
Message-Id: <20220825222420.6833-2-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825222420.6833-1-nate@yocom.org>
References: <20220825222420.6833-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds correct VID/PID for this XTYPE_XBOXONE compatible controller to
xpad_device[] table.

Signed-off-by: Nate Yocom <nate@yocom.org>
Tested-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 18190b529bca..c8b38bb73d34 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -131,6 +131,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
+	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
-- 
2.30.2

