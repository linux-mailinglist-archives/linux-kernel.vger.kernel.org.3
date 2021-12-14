Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB7473A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbhLNB1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbhLNB1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:27:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FDEC061574;
        Mon, 13 Dec 2021 17:27:02 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so14791768pjq.4;
        Mon, 13 Dec 2021 17:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+jlMJzeNFSas4GV+hezSK4rMaaQSNcgMNgG+aLQtKs=;
        b=aTvfRrmQtkIEbkxV6Zt5mfo/F3Ma4tVTdIJ9W2SmsUI4qnAbLsxvPZ3SwOWGr2fi3o
         1P2/rIkbalIHq/7LIe1WX0B0Vj9Zw4QWzkTuAwdBwrxsjD2UBQbhznfx7aSfsrGfKF/V
         8IEifDt3RFnYMiygqVR/+VpbUbzXKPy1sp+lALPrpPZpPMgEB4oRZSCCDaOLmbEomV/9
         1vEln6VWBuDduI0/0C/Rz/6MwSoOXcApdh7u88DDQpMKw148EYA+NBrmxF8UEdXZSmVn
         9jSga8yYJ+3fu4hPtIfTbHB7eNDzXxBefNJqow6YLy3j7+Yed7uGOJleago7oaMyurIk
         5a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+jlMJzeNFSas4GV+hezSK4rMaaQSNcgMNgG+aLQtKs=;
        b=DqiIY27v/BXEf+EF4D6gVqkR4I1ujmuEimIQlSZ0G/B0jJMxuKzY8FclXXfFA8kv4C
         71iGZEp5r39dCOwUCltKWLpCmqo2RyXc/4tDllERYo3QbrS3/5fzeqPk4moLzrIWzBqZ
         M04wGH26sLGJuJyLV9vlvPyUKR69iQWv2iS1ljhKKqhgz97jSpCct68LvjHDdyc2jwtp
         lqxFXhLyP+Gc445queOv/Opx3xloxC3elQfofuRNYM2cGIFT+3W1e/TQGVYGyj1U6Nnh
         qTGRBpQLGypUJ6UD/Ldt1WblwCtCvKxQLFeYMJWJnfcu5gw0p98OUM/dYDW96Lqc0RRU
         TIRw==
X-Gm-Message-State: AOAM532ZZEkiE8/P3m/UKe+uOqF/UUnIlOEEYFjhj8smvXaOCAAIox+X
        nRREh8j/Bi7tUC/2YTQOhPo=
X-Google-Smtp-Source: ABdhPJz06MvLMMiXdDX7Sx2FS6Ofl4e5bEqY+2zRVI1Uo+hl+Sx9zSlwiI/FOXrvHLwfJtepJ9PYwg==
X-Received: by 2002:a17:902:684b:b0:143:84c4:6561 with SMTP id f11-20020a170902684b00b0014384c46561mr1969050pln.33.1639445222001;
        Mon, 13 Dec 2021 17:27:02 -0800 (PST)
Received: from fedora.lenovo.com ([103.30.235.251])
        by smtp.gmail.com with ESMTPSA id n71sm13944680pfd.50.2021.12.13.17.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:27:01 -0800 (PST)
From:   Jimmy Wang <wangjm221@gmail.com>
Cc:     wangjm23@lenovo.com, markpearson@lenovo.com,
        Jimmy Wang <wangjm221@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Ole Ernst <olebowle@gmx.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chris Chiu <chris.chiu@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: NO_LPM quirk Lenovo USB-C to Ethernet Adapher(RTL8153-04)
Date:   Tue, 14 Dec 2021 09:26:50 +0800
Message-Id: <20211214012652.4898-1-wangjm221@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device doesn't work well with LPM, losing connectivity intermittently.
Disable LPM to resolve the issue.

Reviewed-by: <markpearson@lenovo.com>
Signed-off-by: Jimmy Wang <wangjm221@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 019351c0b52c..d3c14b5ed4a1 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -434,6 +434,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Lenovo USB-C to Ethernet Adapter RTL8153-04 */
+	{ USB_DEVICE(0x17ef, 0x720c), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Lenovo Powered USB-C Travel Hub (4X90S92381, RTL8153 GigE) */
 	{ USB_DEVICE(0x17ef, 0x721e), .driver_info = USB_QUIRK_NO_LPM },
 
-- 
2.33.1

