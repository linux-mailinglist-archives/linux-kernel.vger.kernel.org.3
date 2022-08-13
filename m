Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC73591C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiHMSyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiHMSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:53:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E0513F0A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:53:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f192so3606983pfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xBc1OKt9I3SLTG+JSnIOohJmCNuxJDzx5yrVOi1WQ5g=;
        b=gFkfVq3heDZv6+NCYcbU95EvMqKh7JgRkMH2EOqhQxU5qOscEjNd5Y6zU/0eDH2qXF
         y/j0Mhyxtj8mCZ0ykvtW4qrISl83PA8rLepoxJquISxO+t0Wdslq8GPjZQkRUAmWF3rK
         ZshvkHKmcF3qAv1vKLhAYSUEGt/v0MDp58PmTnQJJadhHQd+ab796Tm3tczZXdxW+Rb+
         qjuNNMwlOeiLiDKkPhdX2lyKUG6O/1tdMnOxRcSzeNI5dlXLtifEoEuWSJCH5M+7KGrr
         5J441B35deMrjAoW6Dm8a4ra3h5Jj4yEOX7gYLczJg7BOCC9cJdihu7OU1VeRK8m2hKt
         z0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xBc1OKt9I3SLTG+JSnIOohJmCNuxJDzx5yrVOi1WQ5g=;
        b=ZhRfHg4VzyTR4i9Vb32k23c3HKUkYg4aBi61qzqyFz4VWSNOF2NJ55LVI+fQ1xCvsk
         gGVBsayItpvgoSzVPo3iubrAoYKUGlXA8dmOyETeAHuXu457hOsQla/xofJ2MHpS2le6
         IL+d5VQF8a4i7N3k4Ti/cI/fZW0ViBdHqU+N+3pranAlSwnewWFC7wJC3vTjT8Xj2IYS
         ZjwZnh+ZIcbzgyowg4yT0MKMIKgfanVQwCcwp2+X4qlpwhs8YLdEdi0w6JarHLRx/csg
         SiHA3schyrkzf9MgSAAdjHGAneRdtierH3lFou/Zf/iYdFCpF/9ylqg8IXEQQk5c0ZyE
         HSUQ==
X-Gm-Message-State: ACgBeo2c5E5AAZuUjC4Q9V6u7HrBK1zGY545psVEFlExwZav/5TDXW5y
        aqsVoLIq4iw8b5XauhIykBtJUw==
X-Google-Smtp-Source: AA6agR5MrdT1tVRhOp1Smd4NzHHWvrKLPQO6HtTAYRd7SKSQ0UDuXcBfq7fbLbcd9SGYPpzF0XBXjg==
X-Received: by 2002:a05:6a00:b41:b0:52f:59dc:75 with SMTP id p1-20020a056a000b4100b0052f59dc0075mr9404888pfo.33.1660416835330;
        Sat, 13 Aug 2022 11:53:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:a07f:e6ac::1c])
        by smtp.gmail.com with ESMTPSA id fs1-20020a17090af28100b001f246f2a423sm1972183pjb.17.2022.08.13.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 11:53:55 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net
Subject: [PATCH v3 1/3] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Sat, 13 Aug 2022 11:53:41 -0700
Message-Id: <20220813185343.2306-2-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220813185343.2306-1-nate@yocom.org>
References: <20220813185343.2306-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds correct VID/PID for this XTYPE_XBOXONE compatible controller to
xpad_device[] table.

Signed-off-by: Nate Yocom <nate@yocom.org>
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

