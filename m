Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5574496AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiAVHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiAVHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:32:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBDC061748;
        Fri, 21 Jan 2022 23:32:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id az25so3779096wrb.6;
        Fri, 21 Jan 2022 23:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1dbRvYlFYtDwYEmVyaZdpxRConwrNczxL4pzjyGKTeM=;
        b=Ymq+X6yZH67bhxLGQvvvDuVW5WuGuC05+9SEuvh6VzWhqxI++n4PQMwKI72DonXbcv
         Jm1o3bTvlY79AHPM887eoZqOPufKTfo2WXBKHXlEQan+/+G1Pr4wODrRZOat2ksVsYlO
         kM9wwDeVjTuEFa5UzkLetEXfqdVHy6Jlm4fPQwOt6jX19mCa4T4ASEPAqS0ZwQ7ZW96U
         X2UCA59NYW9nsaO0zopnRQ16BSUpL9UxssDfNCT6Ef9wO/vFqweejM9k77tS5OVommWD
         ptKQRFDpo2cVA+6kVDuRI7TuWdlQLtNv1F9n2F2J9OjRcoKY9C0Te8cQSHuB+cSMUY8J
         CFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1dbRvYlFYtDwYEmVyaZdpxRConwrNczxL4pzjyGKTeM=;
        b=FUveiuNVmiUy1TPgN68aT8q/6S5oKer3i/RlqoFjSDURvq2l52B4hGQSGP0b25e43h
         G8XmM3VtuK3fIn0/LXIcGCEldvh7mLMlTFcpbmLCbV6+qUmjTB5bJF7vFj+uxnXJvZ38
         KUHWVwE8lYgPFteMB4nVIhkLKVDMby02fKgXmOv9t6KkmKK123u9C0NKuhl6xpWWHvMK
         m9w8FoFL3b04QwdbAyR2gSV4V7+3IoQBEi1ZQu9Zx1AFrmR4UvDPvLgu09gydQLgp0Ns
         uBU1HUvwVBH9JGK+hLFacRED0aNHxi8VXQj5gF6CoXDdslGqecMEYCXqg7+t9MMiDaif
         2c9A==
X-Gm-Message-State: AOAM53374BQBomekV9HyY1ZMI2Vag505g2vGh+VO9FaMiK+WhfrJavgP
        ioYH1FYdQLXuGI3boLQQw0I=
X-Google-Smtp-Source: ABdhPJxmD/1s884WHFC5qHJ6DlhRLHZ4vDsrKm089DWjneV2lKc4wGWAIDh9CiSAcCQ2LKPzv5eQ/Q==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr6440779wrz.155.1642836752312;
        Fri, 21 Jan 2022 23:32:32 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8sm8970485wmq.23.2022.01.21.23.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 23:32:32 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: [PATCH 3/3] arm64: dts: meson: add BL32 reserved-memory region to GS-King-X
Date:   Sat, 22 Jan 2022 07:32:21 +0000
Message-Id: <20220122073221.2398-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220122073221.2398-1-christianshewitt@gmail.com>
References: <20220122073221.2398-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional reserved memory region for the BL32 trusted firmware
shipping in Beelink g12b devices. This fixes a long running issue with
boxes booting from Vendor u-boot where the board wedges during boot or
soon after due to the (un)reserved region being overwritten.

Fixes commit 93db2ce05204 ("arm64: dts: meson: add initial Beelink GS-King-X device-tree")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Furkan Kardame <furkan@fkardame.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
index 6c7bfacbad78..c6178cbe3a9b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
@@ -20,6 +20,14 @@
 		rtc1 = &vrtc;
 	};
 
+	reserved-memory {
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
+
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
-- 
2.17.1

