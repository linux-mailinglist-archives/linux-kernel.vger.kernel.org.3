Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D067357E81A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiGVULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiGVULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:11:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF29FE0D;
        Fri, 22 Jul 2022 13:11:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w205so1996112pfc.8;
        Fri, 22 Jul 2022 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvRzSIuLpo8qUs/Z56TFb61lnUR/l2SSfQRWFsRNxOo=;
        b=KBV+yVGTi7LrJQhb3q8Y1WIbcDlcO7R1231q/8Vf/s9YggpUq6JUol0yAM8Pnu1lk7
         5x0hWyUgvgoT3OZSP4GZ7bvU/VlFLtuE8+pWrEPu9whRzlOnk2bMxT7gBlcsvZPTv77G
         My2hZEomMLQUuLshtyf4olqj0LCsB/iZNQvNXfoOKk0bHra1knwm6BFYyXhri6YyXHzA
         Cko57pRUn/kENXwCGRF9h5dGoCI/DL9MWEr99yy/LBDtu+J6dmk/8M13inp5SW5UcPbf
         PjpkxCAYZC8GlZCmORN6L9uwIGCCGZkEBq2AfXn9cvqiK7TOz2V3huSi9AJPm1D9c3Pt
         HwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvRzSIuLpo8qUs/Z56TFb61lnUR/l2SSfQRWFsRNxOo=;
        b=Ze785V/jN8VlntNbJ0Vm8tp22wUB6ELaRC6d+gnOpD31Px5d+TpCwztwdV+I5nPiAM
         hgAojFQR6si2tob6YVxOxVCaH2cAXNzPMJ1pfIq4X2UkmjRf0ILWLduedpd5XwuYvYoc
         0IxkiRsJT6HU7pOr+CXq9G0a8A4WetBL5dmQ3eovElsP6wuiVCswcq/zf/WO4iw/oWwp
         xfp99JTe5nw7rsnzA3Ykk4UibnjjAQxsJhoL8gzTHODamWu6mienaT6QuJoD0rWTyAgz
         OktuLaOie3yKuR8d3012Wjtjju+7xvGqs4T+jX7K8eo86f2qsH1zAlVnlFW0eaMPXE+d
         DSnw==
X-Gm-Message-State: AJIora9dGm5How9HpO6G0Cid0KQxscEWzRFgs5El0KZ+BYZc29SJt2JQ
        X8aZgpxLEY+ndn0IFszHWJ5UMjLffT8=
X-Google-Smtp-Source: AGRyM1vNr8H735Do4O7yk1G5NYPqRxNixvix2TGQDsirLjtHlIGmSRRyRe471J0hiMmrpDksGQscEQ==
X-Received: by 2002:a05:6a00:a29:b0:52a:c0c3:4379 with SMTP id p41-20020a056a000a2900b0052ac0c34379mr1547065pfh.15.1658520705657;
        Fri, 22 Jul 2022 13:11:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b0016c0eb202a5sm4098604pll.225.2022.07.22.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:11:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 2/3] Documentation: sysfs: Document Broadcom STB memc sysfs knobs
Date:   Fri, 22 Jul 2022 13:10:42 -0700
Message-Id: <20220722201043.2731570-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722201043.2731570-1-f.fainelli@gmail.com>
References: <20220722201043.2731570-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "srpd" and "frequency" sysfs attributes exposed by
the brcmstb_memc driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ABI/testing/sysfs-platform-brcmstb-memc       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc

diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
new file mode 100644
index 000000000000..2bf0f58e412c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
@@ -0,0 +1,15 @@
+What:		/sys/devices/platform/*/*/*/*/srpd
+Date:		July 2022
+KernelVersion:	5.21
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		Self Refresh Power Down (SRPD) inactivity timeout counted in
+		internal DDR controller clock cycles. Possible values range
+		from 0 (disable inactivity timeout) to 65535 (0xffff).
+
+What:		/sys/devices/platform/*/*/*/*/frequency
+Date:		July 2022
+KernelVersion:	5.21
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		DDR PHY frequency in Hz.
-- 
2.25.1

