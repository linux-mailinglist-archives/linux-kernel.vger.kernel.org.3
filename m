Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D194A7CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348586AbiBCA0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348575AbiBCA0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643847973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNGL/w0+tirF2usaI8U9/uBI9LUpdeBs8wmNgjVnKDU=;
        b=RK9HCHHzfKQMriXIaLxhGh7FJyzNcslY6yUL9K64jtDXeBol0veubUAewhdw5sMJdsxxsK
        FBGvYI9ceQgQlzEeoRCP/xncSR+Gyv7dhUxpmcltylCPCAre3KPlbb8jVadYXIbPP0wqKD
        4LEhQKlInUl2VbF6XPO5CnnGG37p0hM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-4x8IU70dO2yLK2BuFDmMhQ-1; Wed, 02 Feb 2022 19:26:10 -0500
X-MC-Unique: 4x8IU70dO2yLK2BuFDmMhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2621091DA1;
        Thu,  3 Feb 2022 00:26:09 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 693694EC76;
        Thu,  3 Feb 2022 00:26:07 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 6/6] DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4
Date:   Wed,  2 Feb 2022 19:25:21 -0500
Message-Id: <20220203002521.162878-7-cmirabil@redhat.com>
In-Reply-To: <20220203002521.162878-1-cmirabil@redhat.com>
References: <20220203002521.162878-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shold not be merged - dtbs files are not stored in the
kernel tree. We just provide this file so the code can be tested.

This overlay is suitable for testing the driver, it can be compiled with
dtc and put in the /boot/overlays/ folder then specified in config.txt
by putting the lines:

dtoverlay=		#suppress loading of default overlay for HAT
dtoverlay=sensehat	#load custom overlay

at the beginning before any other lines in config.txt

Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 sensehat.dtbs | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 sensehat.dtbs

diff --git a/sensehat.dtbs b/sensehat.dtbs
new file mode 100644
index 000000000000..5f1a9d62c9f4
--- /dev/null
+++ b/sensehat.dtbs
@@ -0,0 +1,56 @@
+/dts-v1/;
+/plugin/;
+
+/ {
+	compatible = "brcm,bcm2835";
+};
+
+&i2c1 {
+	#address-cells = <0x01>;
+	#size-cells = <0x00>;
+	status = "okay";
+
+	sensehat@46 {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		compatible = "raspberrypi,sensehat";
+		reg = <0x46>;
+		interrupt-parent = <&gpio>;
+		status = "okay";
+		display@0 {
+			compatible = "raspberrypi,sensehat-display";
+			reg = <0x0>;
+			status = "okay";
+		};
+		joystick@f2 {
+			compatible = "raspberrypi,sensehat-joystick";
+			reg = <0xf2>;
+			interrupts = <23 1>;
+			status = "okay";
+		};
+	};
+
+	lsm9ds1-magn@1c {
+		compatible = "st,lsm9ds1-magn";
+		reg = <0x1c>;
+		status = "okay";
+	};
+
+	lsm9ds1-accel@6a {
+		compatible = "st,lsm9ds1-accel";
+		reg = <0x6a>;
+		status = "okay";
+	};
+
+	lps25h-press@5c {
+		compatible = "st,lps25h-press";
+		reg = <0x5c>;
+		status = "okay";
+	};
+
+	hts221-humid@5f {
+		compatible = "st,hts221-humid\0st,hts221";
+		reg = <0x5f>;
+		status = "okay";
+	};
+};
-- 
2.31.1

