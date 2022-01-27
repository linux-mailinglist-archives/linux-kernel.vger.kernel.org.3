Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0749E4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiA0Oog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242569AbiA0Ooa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:44:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268ABC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so6263235eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnHinaSgUE18rkPMZ1aFduRfZMI+OtEhMFoYUzMwbTA=;
        b=EbQ2NJ/RzPeKfZfdAnEKG97k07/wdjUDJCEiKPf+Z9dgKs5yEYNDyoak3gcXuIOEch
         a/AeTZz/wlvTDPUXA0+mSuvbuKWkDwqPna2j/MErIGcalruduA8Ms0XW6geB7TGtJ2dR
         PcJIjmvnBL4WqLpMcEUpttzLTiZKIAwTrtIHzb/6recZl9CazvfGRC+gh3gFsvg5Hnmn
         CXhNwSPHGK1c/usJCd4AdV5klZZpBN16UMwz7bSSqSKhkb2+vq1+uKo/9lNixTolrrOi
         gNEDh2aq1oGzeOmpPQ5O+VniLGpUkjFg9CDkGvOXdTFuvoouKVajzVc/4YRfNxI1vAm7
         D3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnHinaSgUE18rkPMZ1aFduRfZMI+OtEhMFoYUzMwbTA=;
        b=zjfmUqgrw3IbXGibhRX3f9WpaMWweTD+JJRExcnocaEPceJJ4aukui5jJA+EP2kzLp
         Jn++diJPEvAXOd+tm8ToL4ixl3eAvMq2e3r5e/M7wwacsiXm4LkY5lm6mQ03wJvzvq02
         WPTZ/jnZfdCtVfaRRF7YDIAqivlthfMY62adVEODfm8yee1AtmdxzC45lkW9V7d6ciQU
         iIN37wM3DFjvek5PibBwVV/WoEBHeJ3GG8keBo8/fcOmXJ9wNBc+7okK0Vpgzj2cqu7/
         00lz5zcPBP6/dYZ9SbCoqlGPdbM5S2MGJliyNhTSzeGbGHaTe2RIDKr4T1jQTXdpbaH4
         eRSw==
X-Gm-Message-State: AOAM532BdIYzwc2XWu1uQbLjkfnoVPae0JASJdPFDjBxHUjbCuNWRw81
        ggvPbhcv9CNXXhMso0Iv8HgmXkG1fqw6Sujj9Tc=
X-Google-Smtp-Source: ABdhPJw13uuEdgUzA1mugc803Smf4taE87YLu2mDAsIMOorI2Vij2Ml2w+/wuI0TXBzfo9gafp1Lfw==
X-Received: by 2002:a17:906:c110:: with SMTP id do16mr2577693ejc.175.1643294668666;
        Thu, 27 Jan 2022 06:44:28 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id lo15sm8746533ejb.28.2022.01.27.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:44:28 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Bos, H.J." <h.j.bos@vu.nl>, Thomas Gleixner <tglx@linutronix.de>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] vt_ioctl: fix array_index_nospec in vt_setactivate
Date:   Thu, 27 Jan 2022 15:44:04 +0100
Message-Id: <20220127144406.3589293-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

array_index_nospec ensures that an out-of-bounds value is set to zero
on the transient path. Decreasing the value by one afterwards causes
a transient integer underflow. vsa.console should be decreased first
and then sanitized with array_index_nospec.

Kasper Acknowledgements: Jakob Koschel, Brian Johannesmeyer, Kaveh
Razavi, Herbert Bos, Cristiano Giuffrida from the VUSec group at VU
Amsterdam.

Co-developed-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/tty/vt/vt_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 3639bb6dc372..e0714a9c9fd7 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -599,8 +599,8 @@ static int vt_setactivate(struct vt_setactivate __user *sa)
 	if (vsa.console == 0 || vsa.console > MAX_NR_CONSOLES)
 		return -ENXIO;

-	vsa.console = array_index_nospec(vsa.console, MAX_NR_CONSOLES + 1);
 	vsa.console--;
+	vsa.console = array_index_nospec(vsa.console, MAX_NR_CONSOLES);
 	console_lock();
 	ret = vc_allocate(vsa.console);
 	if (ret) {
--
2.25.1

