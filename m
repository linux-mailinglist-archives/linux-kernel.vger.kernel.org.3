Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A504A8C61
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353752AbiBCTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353745AbiBCTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:22:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696EC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:22:05 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p15so11813216ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=YnamjwK8jac8VMGcddEQMuZZzkDqdQtjPGT5HOzqnyA=;
        b=dZBRrD1sg7XDLYXmoaWYGCuuxOZbQmxERTngTz23xxfweSixACEGf+QcYQSNv7f7VG
         fFc89935UFYKIdky/sB3SOKdzrwp3gPryih05ZjqvaVj29WHTlFads7HSrt6L+OdH+gE
         StXpIJrNeZ56OKwgOVmgLQSCBHuVsgAEsv4/ESBRATUJ8/dQYcRl/mswRrW44UZI7Bta
         /3vkKIa/0GENSNLZVHMfnufFbPSPV1HveGDYHdAbUgvTUWeHBdO8qccGdlfMO3zLnSev
         XcfQcOxJahg3raWFGyAAFy216c1Asm3cZO0v5Bzj+kym7jxE+IvadrQEC86u8PEcQn3P
         QCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=YnamjwK8jac8VMGcddEQMuZZzkDqdQtjPGT5HOzqnyA=;
        b=cK2u+5NJVYHm+ov+bkZ4m0MglGJWx2I2Pj+jc1uj1Ecbwk3ya5GeYdO/ZC2KWzuFiS
         kruv43/aiRRGZ5h5Yub6LQhscGyGE9y0oObXN46hUy1deHh7VgQO3RAByHIFsCJPniJ1
         kv8HWYdDMvLNizgxrZVYONU/S1QO17mleVMoRxv57lNjVZchGo/1kUqqfwk6ePouFY/D
         Vd2mL78e/KcM1AYmQ0vDjBIQ6/0Qd+wwF+/WkfVxuVERCvxA7AYyYYdA9+AK8o+8V1qr
         6fUhBerWQ5uO0XbOly6F+1MYQt4H8nj9OERt6DVUKwJdyOtUkDGKJ+4UhCGtrZm8A7cZ
         UXoQ==
X-Gm-Message-State: AOAM5326tkdGrXIxsUMF3lgghQbb0i+3xtGWQCGUMGZm/y3cFdUuEceV
        xJk+YQS4U14XIOj4z95KLx4=
X-Google-Smtp-Source: ABdhPJzZGzBzocy0s6F8V3moHy8ukluUcy4G5rEs15hnduJD0mG3YyohXcWOILgzp3+ExFEmiRjUKQ==
X-Received: by 2002:a17:907:3e9b:: with SMTP id hs27mr30799212ejc.72.1643916123500;
        Thu, 03 Feb 2022 11:22:03 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e069597fe2fbbbc37c063.dip0.t-ipconnect.de. [2003:c7:8f4e:695:97fe:2fbb:bc37:c063])
        by smtp.gmail.com with ESMTPSA id lc22sm17055801ejc.74.2022.02.03.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:22:03 -0800 (PST)
Date:   Thu, 3 Feb 2022 20:22:01 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Fix crash when WLAN is turned off
Message-ID: <20220203192201.GA18509@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop submitting urbs before calling usb_kill_urb() and usb_free_urb().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6656/usbpipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 7f45734390f6..d505b4b69ba4 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -230,7 +230,9 @@ static void vnt_start_interrupt_urb_complete(struct urb *urb)
 	else
 		vnt_int_process_data(priv);
 
-	status = usb_submit_urb(priv->interrupt_urb, GFP_ATOMIC);
+	if (!test_bit(DEVICE_FLAGS_DISCONNECTED, &priv->flags))
+		status = usb_submit_urb(priv->interrupt_urb, GFP_ATOMIC);
+
 	if (status)
 		dev_dbg(&priv->usb->dev, "Submit int URB failed %d\n", status);
 }
-- 
2.25.1

