Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD98C4969EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiAVDzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiAVDzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:55:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5EC06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:55:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o64so10894074pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSHSygtJut5TGIpsbPHquOs8UiVBB7gZ8MMyr0HLxhA=;
        b=pxTopgDTCq/4/RyR8bgeUrroIY/dn2T2qOjzvEdL1ExK/feeNz42koPIGiLijAbL7r
         6bjBgw7ti8sAXuF0dZ53ruqennL2uCcd1wd5VLjcxyG2F1l8gE+NvDUETIAK20q0JUUi
         Yrs38dxxIX2JscAba0h6gA9zYtSPueLgea6Crv2iwLZWHgTrMp+OqCOZOAgjDv9y7ZCx
         u4Nwdn/xfMZ4Xois6SwXaqx39YJl9YlQwNQ0MY9zAoAyxAt94aUVKYGwpFdPJ0m/GbTn
         gWv4jdDtVgjfkZoHEKWR+gPV4WqE1BqkV5KCSw0x669UB125BI1dabFCE+aKQoJd2BUg
         Qy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSHSygtJut5TGIpsbPHquOs8UiVBB7gZ8MMyr0HLxhA=;
        b=ZX97XeOhKGMjchN4QDkWFwYwaJfiXsPWo75Ot/TAt+J+dN4lCsy7Fn+YjExZfHsaj+
         csnLhC8KqXsDxr6bw+SVh2Wbtliem6QgAO43XCqw86TA7h7y+JBGl8W9lU8D50MHSI9v
         Yvxa6nCUx0w4EUVX7NgzKsUtyWwolWpcNNDOwp5HbH2dX4YJYhduIAkAIXu6PfQ/lQFV
         Hd6lYih0K/0trnQYN9CR9ydRFs4PKMwkcTt/zhrjnxJ/CgSzDWNVnlPsjnGvA/y54Zsd
         qtFysXYR53D3CGQ5AJSzDB3lh0N4wVFgR4OKswX9/6Pw8HlKU7W7cp1L47vh6SSq1YPq
         Kshw==
X-Gm-Message-State: AOAM5322AL4mbh2Yqv7HtgxwkNRrLk6iNvhEIRqtW2naUYJtZxHDPjDL
        YhBQ+gE5skjBlpmaZLMj0QA=
X-Google-Smtp-Source: ABdhPJwMh9tdnpgpsp7RJ2vAuQBR9vxQQF4uqg3jTKIf08TidhAM79AiyArX+tO5ELVaO4K4mwizfQ==
X-Received: by 2002:a17:902:7844:b0:14a:9cff:66c7 with SMTP id e4-20020a170902784400b0014a9cff66c7mr6639721pln.14.1642823701421;
        Fri, 21 Jan 2022 19:55:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a1sm667255pjm.1.2022.01.21.19.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:55:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] Documentation: ABI: Document Broadcom STB PSCI firmware files
Date:   Fri, 21 Jan 2022 19:54:21 -0800
Message-Id: <20220122035421.4086618-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122035421.4086618-1-f.fainelli@gmail.com>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the attributes created by the Broadcom STB PSCI firmware code
to allow retrieving the firmware version and the control of the CPU
retention upon system suspend entry.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/ABI/testing/sysfs-firmware-brcmstb | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-brcmstb

diff --git a/Documentation/ABI/testing/sysfs-firmware-brcmstb b/Documentation/ABI/testing/sysfs-firmware-brcmstb
new file mode 100644
index 000000000000..5ebd8d0a34be
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-brcmstb
@@ -0,0 +1,16 @@
+What:		/sys/firmware/brcmstb/mon_version
+Date:		Jan 2022
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		Reports the ARM trusted firmware (monitor) version running on
+		the Broadcom STB platforms under the format:
+		A.B.C.D
+
+What:		/sys/firmware/brcmstb/cpu_retention
+Date:		Jan 2022
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		Allows the toggling of whether S2 standby should be entered
+		with (default) or without CPU retention.
+
+		Accepted values are 0 or 1.
-- 
2.25.1

