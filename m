Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9020259EDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiHWVFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiHWVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:05:38 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06D7C775;
        Tue, 23 Aug 2022 14:05:36 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g21so11289878qka.5;
        Tue, 23 Aug 2022 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=3cCXr8Wd/Y2HhMKIaqg0LsBk5BUYC7YkYkFrfstD7bU=;
        b=gNk2m7TGW1WnBFr0mCRq60sD3lnXI7qGLRNSMgkh0toUeNn294q8m5Z9Dfn4Gil3xI
         i0yIQNJlU0PYdVsy8xbzwQr4ducda0DDX50cSUDNjH5HyVm0Y4aPDZIKxZMgLtb3m9oE
         wiRfUqf2tuATlPTiq879D/Z8gyq45poiHibo0R8iIIO/fSOzquXf4F9i9Cg2gt7aJmfW
         1zoOQxmN1v1Fzleh0mG6GH+KOY2OFuZnxHlr5Wa9CLWFAcGw+yLzs4s/npXt+AUcMGaW
         bThZJsneaphuSCVHF2NO6CT+fx0lM7AqCyXZHsVc4lUZoDx/gXRrt2YqqBDOlI/wTCCF
         zsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=3cCXr8Wd/Y2HhMKIaqg0LsBk5BUYC7YkYkFrfstD7bU=;
        b=osOvOtN0BI/tY+E96y+rRUlzM940Mj8OTWpBP/m1Ez8rbep06sStDliiKwgwwMQUJZ
         SFR545N2cIVL0s8m6pXP38nmEMWaBcM6J/yvTXuieU6qkSVRliYHdslIwei+ayB6fcBt
         Ft5aYUzLRqTdR21WTfA5rOfbgYN2DAdaJrGvpU9HPpJGV9EKCsULYvM7ozmjjh120YsB
         SV3YDEsa7UaXqc4YpLp+FRlCeLOGaaNMCobTbahRjHoFeRlBOOGzjewVF4Evuj2ooCIO
         rUELAfUQEYEmdNpQY7dOSzXdUOX9caQs6K4RFA7n0Y3NYWKyAjBb1DRMAr5xm9s3Keti
         iYNA==
X-Gm-Message-State: ACgBeo2tS0uWyrqdIzmPrCjgrakXeNcpHNBa++qm5cBqYTdevodBfPeU
        WjfUEgBZq5MrccBgk4p0+IU=
X-Google-Smtp-Source: AA6agR5Ut86YONNsGhkN1YJJgYuaka93UP4z143jRVHXbk2Kb/pKkWRBlLAHrpOJDcqkFHS+dpR+tg==
X-Received: by 2002:a05:620a:4442:b0:6b2:844e:ee67 with SMTP id w2-20020a05620a444200b006b2844eee67mr17323680qkp.625.1661288735234;
        Tue, 23 Aug 2022 14:05:35 -0700 (PDT)
Received: from valhalla (2603-7081-5203-61c3-0000-0000-0000-1449.res6.spectrum.com. [2603:7081:5203:61c3::1449])
        by smtp.gmail.com with ESMTPSA id 11-20020ac8574b000000b003435bb7fe9csm12309573qtx.78.2022.08.23.14.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 14:05:34 -0700 (PDT)
Date:   Tue, 23 Aug 2022 17:05:32 -0400
From:   Christopher Carbone <chris.m.carbone@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: sm750fb: split multiple assignments to lines
Message-ID: <YwVBHM3z0QExtuXr@valhalla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: multiple assignments should be avoided

Signed-off-by: Christopher Carbone <chris.m.carbone@gmail.com>
---
Changes since v2:
 - Remove extra space in variable assignment

Changes since v1:
 - Assign literal value to both variables
---
 drivers/staging/sm750fb/sm750.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dbd1159a2ef0..3e09e56d3930 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -386,7 +386,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 
 	ret = lynxfb_set_color_offsets(info);
 
-	var->height = var->width = -1;
+	var->height = -1;
+	var->width = -1;
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
@@ -498,7 +499,8 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		return ret;
 	}
 
-	var->height = var->width = -1;
+	var->height = -1;
+	var->width = -1;
 	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
 	/* check if current fb's video memory big enough to hold the onscreen*/
@@ -723,7 +725,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
-	crtc->cursor.max_h = crtc->cursor.max_w = 64;
+	crtc->cursor.max_h = 64;
+	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
 	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
 
@@ -1027,7 +1030,8 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	if (!sm750_dev)
 		return err;
 
-	sm750_dev->fbinfo[0] = sm750_dev->fbinfo[1] = NULL;
+	sm750_dev->fbinfo[0] = NULL;
+	sm750_dev->fbinfo[1] = NULL;
 	sm750_dev->devid = pdev->device;
 	sm750_dev->revid = pdev->revision;
 	sm750_dev->pdev = pdev;
-- 
2.37.2

