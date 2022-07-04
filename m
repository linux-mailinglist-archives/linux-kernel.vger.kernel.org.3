Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C7D56526E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiGDKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiGDKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:33:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7334DFF5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:33:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso2889109pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 03:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAEfJl4UOkGeoQKG3Jzbkgk5YoutB15/ljohBagXkQ0=;
        b=kg7qypDoNH+WIJFjpZTDrJcvfscysQIUVIlnJS5HY+bmf25+LgK8uZdo21Azt+Mu0k
         R7c8ubwdz+j6d1O+rU3lkG73UBkDXTV/t/fMJB7IMU+w/cJBMRaKDVZ3wGDTls1ajo9V
         zWGwrMdTBcoXjPC6d+w3z6HKgKAnag0tZw7rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAEfJl4UOkGeoQKG3Jzbkgk5YoutB15/ljohBagXkQ0=;
        b=i01MfovmBNrbmcXp42too7Zia5oDj3prH3FH8hjwLubC52m5eDsPTtvJ1oMkxVGTfA
         KzVbvUe6R27hvRVjHER8Pdx/Z89WRf5oCtNDAlk1A5vxZqnuzjkedVABAxT6hTGVvmlE
         sIFnYwmAj0UPuAiaV9ZeBp2oBzRS2EGb/klGyIsq1FvA5LjgZxO1lNAtHokaFCnlCFLd
         OPNLZJuN6r0MsCI9QGAyxvJ4G/IM2EoRnD8pL+8U09Pb56eHgMpr3x75tDfJ8s4GrccW
         X7+/ozRgdW/MBwtOOHdixGQOFWNfZdJZosFCLnB+8HuoMT/NDfIyrVwbIFzDpVr9l3bp
         sidA==
X-Gm-Message-State: AJIora+j66RRXJATLtpjHEPqkPK6Zr9qaxGWcWKWzkU2/xWdy21r1yz/
        QGXMiUm/yJv5vjtr/SaHoyYgng==
X-Google-Smtp-Source: AGRyM1shkm04UiZgNjN1Pi4wfOUrQkZlLN9qJiBGOUPmxXbvlKWmJhoK3IBB+fOMNEw3BVDDs43AuA==
X-Received: by 2002:a17:90b:278e:b0:1ee:f086:9c9d with SMTP id pw14-20020a17090b278e00b001eef0869c9dmr35271127pjb.182.1656930809235;
        Mon, 04 Jul 2022 03:33:29 -0700 (PDT)
Received: from localhost ([2401:fa00:1:17:7b03:b0ef:74bd:729])
        by smtp.gmail.com with UTF8SMTPSA id rw5-20020a17090b2c4500b001ef9114eb9dsm218374pjb.42.2022.07.04.03.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 03:33:28 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Add default wakeup callback for HCI UART driver
Date:   Mon,  4 Jul 2022 18:33:24 +0800
Message-Id: <20220704183320.1.Ib7423c21f71003643a5bbe954ed0538ee532b29c@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bluetooth HCI devices indicate if they are able to wakeup in the wakeup
callback since 'commit 4539ca67fe8e ("Bluetooth: Rename driver
.prevent_wake to .wakeup")'. This patch adds a default wakeup callback
for Bluetooth HCI UAR devices. It assumes Bluetooth HCI UART devices are
wakeable for backward compatibility. For those who need a customized
behavior, one can override it before calling hci_uart_register_device().

Fixes: 4539ca67fe8e ("Bluetooth: Rename driver .prevent_wake to .wakeup")
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---
Tested this commit on trogdor (wcn399x) and hayato (RTL8822-UART).
For platforms with QCA UART connectivity, such as trogdor, we revert the
commit c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup
support") downstream as qca_wakeup() returns false and breaks wake-on-bt.

 drivers/bluetooth/hci_serdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 4cda890ce647..c0e5f42ec6b7 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -231,6 +231,15 @@ static int hci_uart_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+/* Check if the device is wakeable */
+static bool hci_uart_wakeup(struct hci_dev *hdev)
+{
+	/* HCI UART devices are assumed to be wakeable by default.
+	 * Implement wakeup callback to override this behavior.
+	 */
+	return true;
+}
+
 /** hci_uart_write_wakeup - transmit buffer wakeup
  * @serdev: serial device
  *
@@ -342,6 +351,8 @@ int hci_uart_register_device(struct hci_uart *hu,
 	hdev->flush = hci_uart_flush;
 	hdev->send  = hci_uart_send_frame;
 	hdev->setup = hci_uart_setup;
+	if (!hdev->wakeup)
+		hdev->wakeup = hci_uart_wakeup;
 	SET_HCIDEV_DEV(hdev, &hu->serdev->dev);
 
 	if (test_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &hu->flags))
-- 
2.37.0.rc0.161.g10f37bed90-goog

