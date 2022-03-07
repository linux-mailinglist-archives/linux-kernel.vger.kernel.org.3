Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB854D0820
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbiCGUGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiCGUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:06:09 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F8710FF;
        Mon,  7 Mar 2022 12:05:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x5so21504905edd.11;
        Mon, 07 Mar 2022 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JSic4G9BWhZ4l2LjW4YQThwu0UhN9BignLM2I7ktfA=;
        b=Jp9lSDPX2x562WF7grbcrhO1bZPRVf302ccbWSRD3okEJpn7s+KYL4FEGj1tnfJDuP
         g+7aTjENeGusOUCxDXdn2yVpqyFBz4jJoKM4PpTSgQfkIWA/hwFJKaulBbdDbIovCAtP
         4zH4W7PDpPggblQGsIsOOtWxI56wa/yKUhVIqs5AETkQJ40LQj7BOi66+gBsX+Y5SbPx
         1MW8q3r358nhXqdBf8jtUBkhvt1gU10WGn3/+BShHM1KkIjaDZXSOjjwS8c97KnflEdr
         LIeRi428it/REP6tBuhO5maGw/Fat/VALnuz2pC3AETeLd+Rh+KQjQZscDlLOwjWOKP/
         dgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JSic4G9BWhZ4l2LjW4YQThwu0UhN9BignLM2I7ktfA=;
        b=bMjzOL9UQR8QQZxf1M1L/6SInDkv1ZWQ/jANrdkdKKhR7ffEpoatceb73Vqq071Hks
         omazlprSxEdxE2bFHv9EMGkUfikimFpJ4WYehlikDlw6hFxNnCtmHqCZe1mrCAEjpk8O
         cRVJO4vXIy8h831Uxm2xOJgCFhSZWU972/wWJQH8D19cQr4ZQLTcjDw7Ie6UgZU9c4lj
         WROPXDMHlWzroMB+XvpEIFu1g9sAq52oJO8SZWR38VpFMwYZhbfKEm8lYnLhJHzRXGXz
         m2KDX0QnlQYIMurhNRHkzaKhgiXQSl0OTTPefkuNPFKRwDVu5168/mdcYfc7quc1/PiO
         jwhg==
X-Gm-Message-State: AOAM532TqlkX+d08Hy0YIEsJeaK+/clu8ALEQPW1CilfxsvB3dJgnsCz
        cezPra7jJOhPIy3gXnt1q7I=
X-Google-Smtp-Source: ABdhPJw3BCkAVGibC3jnXLkH3b0Ln3luJGH0BZX6ZmrZXeBosz2SwHxyiFwpLqk8u8dkiFpKpyztaA==
X-Received: by 2002:a50:934b:0:b0:410:befb:cfd0 with SMTP id n11-20020a50934b000000b00410befbcfd0mr12751376eda.27.1646683512640;
        Mon, 07 Mar 2022 12:05:12 -0800 (PST)
Received: from osgiliath.lan (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170906234d00b006cf86bb0652sm5055354eja.121.2022.03.07.12.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:05:12 -0800 (PST)
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, pmenzel@molgen.mpg.de, swyterzone@gmail.com
Subject: [PATCH v4 1/2] Bluetooth: hci_sync: Add a new quirk to skip HCI_FLT_CLEAR_ALL
Date:   Mon,  7 Mar 2022 21:04:44 +0100
Message-Id: <20220307200445.5554-1-swyterzone@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Some controllers have problems with being sent a command to clear
all filtering. While the HCI code does not unconditionally
send a clear-all anymore at BR/EDR setup (after the state machine
refactor), there might be more ways of hitting these codepaths
in the future as the kernel develops.

Cc: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---
 include/net/bluetooth/hci.h | 10 ++++++++++
 net/bluetooth/hci_sync.c    | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 35c073d44ec5..5cb095b09a94 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -255,6 +255,16 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
+
+	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
+	 * HCI_FLT_CLEAR_ALL are ignored and event filtering is
+	 * completely avoided. A subset of the CSR controller
+	 * clones struggle with this and instantly lock up.
+	 *
+	 * Note that devices using this must (separately) disable
+	 * runtime suspend, because event filtering takes place there.
+	 */
+	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e31d1150dc71..c3bdaf2de511 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2812,6 +2812,9 @@ static int hci_set_event_filter_sync(struct hci_dev *hdev, u8 flt_type,
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return 0;
 
+	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
+		return 0;
+
 	memset(&cp, 0, sizeof(cp));
 	cp.flt_type = flt_type;
 
@@ -2832,6 +2835,13 @@ static int hci_clear_event_filter_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED))
 		return 0;
 
+	/* In theory the state machine should not reach here unless
+	 * a hci_set_event_filter_sync() call succeeds, but we do
+	 * the check both for parity and as a future reminder.
+	 */
+	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
+		return 0;
+
 	return hci_set_event_filter_sync(hdev, HCI_FLT_CLEAR_ALL, 0x00,
 					 BDADDR_ANY, 0x00);
 }
@@ -4831,6 +4841,12 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return 0;
 
+	/* Some fake CSR controllers lock up after setting this type of
+	 * filter, so avoid sending the request altogether.
+	 */
+	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
+		return 0;
+
 	/* Always clear event filter when starting */
 	hci_clear_event_filter_sync(hdev);
 
-- 
2.35.1

