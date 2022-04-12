Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2634FCCCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiDLDCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiDLDCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:02:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A054659E;
        Mon, 11 Apr 2022 19:59:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j17so14800914pfi.9;
        Mon, 11 Apr 2022 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4HEn9aQT2Xyo1V0+OmTqoITISvx7Z9FPkvjacOVf/Fw=;
        b=LfewqGbIa1uS12VTuj9doa2iMGKMNJJRqku3NZDmwJH6m35LpfdUI1T6lfr7i+kiJp
         jIWrXAZixia+5eNSGPQ/CJezPeKGjtrik6aE4NKeC5IC/sNqwcTMiRRbLaT4g6ZjAutC
         wcug6E3n5AOyEATsgiYOfOkCUhyU1u6JVaVYFKdpjiI80rYugp6SjlXY6ntcUyangnu5
         tyU99dj7gEv1yvQCVF80qo6NueplTtxJs42EgC5VCh/C1y640Lf7Ovm/j7GszXU1QUKO
         ratf+1cky8YOKvNcM/RZrtttX7wB9X9GcE+9IA8pTLl7ZhzwXuxtQgDxCQfTIOmpdLLS
         yqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4HEn9aQT2Xyo1V0+OmTqoITISvx7Z9FPkvjacOVf/Fw=;
        b=t06qvKQ6w01ZGEDuyf+QSRruRuLd2sheX595kwx/niWy21vcwYQ1SVsZfVMLoiy3QK
         gOv0aqw4+nqrDg+zcAASYuplpOqthiTK81EMl64vbQzN9qo6hsqJCIfT9o6LAC34NVbp
         VYp1Muj2m1JgSaWTTmS0/i6Nc0LnyPfxQLY9+DQ634ufYER7OzkLLirPHyV//Lg2fZsw
         rJFQXwzLbeZ05GJOznpmjf7Rh14dsVXe2E026/mWqG9XOstobdBWOPxFuUKbdlz5s5C+
         XSNy9XqVdJzhSyHie2GuNceFVF1gdcOLN88vWDGm07kY2RC7kI4nqvhsRv0TrzXTRLOW
         N43g==
X-Gm-Message-State: AOAM533ha4XenZM2uvB747qmkJVdVcLxeX96uH70kP8OUGa1Slc/6FB/
        D6nsXKqiIZlD9s44/B0qfNHlyxklpwUL+x7M
X-Google-Smtp-Source: ABdhPJzblnrYZ9X//RhXdmf23Z5K7RDDmHB+egY4r2Cheljm4QxBVyuOaOo18vdsxAcPdfG5tsWQTw==
X-Received: by 2002:a63:1d1f:0:b0:399:5cd:15b6 with SMTP id d31-20020a631d1f000000b0039905cd15b6mr27721571pgd.91.1649732397922;
        Mon, 11 Apr 2022 19:59:57 -0700 (PDT)
Received: from zeshkernups01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id kb13-20020a17090ae7cd00b001c7de069bacsm814941pjb.42.2022.04.11.19.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 19:59:57 -0700 (PDT)
From:   Surong Pang <surong.pang@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/1] usb/host: To get "usb3-slow-suspend" property, then to set xhci quirks
Date:   Tue, 12 Apr 2022 10:59:52 +0800
Message-Id: <20220412025952.21062-1-surong.pang@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Surong Pang <surong.pang@unisoc.com>

To set xhci->quirks value according to "usb3-slow-suspend" property

Signed-off-by: Surong Pang <surong.pang@unisoc.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 649ffd861b44..6bc456bc6468 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -302,6 +302,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
 			xhci->quirks |= XHCI_LPM_SUPPORT;
 
+		if (device_property_read_bool(tmpdev, "usb3-slow-suspend"))
+			xhci->quirks |= XHCI_SLOW_SUSPEND;
+
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
-- 
2.17.1

