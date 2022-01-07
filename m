Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47734487F58
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiAGXYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiAGXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:24:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9195C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:24:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so8076527pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qy2JglmDtKEX25BfCys0mtXkatOvBLOuMd4XNvWdVg=;
        b=I7OFYfW5o0mKsz8KBCrj50BVvUZXu8Av4K8Nb7LZJmbPFQNzDKC9zJxk3kXLzJpbDZ
         in6zsio0qG/n1rmhEQ7PiKd+tkb0YUt8VgMqwjxy+qmkcbPgnk0AwKak6zcqN2926FW2
         VgYSrBTEXKpBpkpPMHPcAVFPtKxYR0gqjpOos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qy2JglmDtKEX25BfCys0mtXkatOvBLOuMd4XNvWdVg=;
        b=1uOeJPfp6hjsanGoVR2pwMI0uOMpMWzZg+zZeOsT2oTk4rZ+1L409CBwFiSDYI6dFZ
         svEQR7pgmXgriPT6I5bc+qgzIpggkFsXmFA/7Gx3NzmlMvaJ7Z1g2s4dqJRQdu5CNEvq
         Zm+UHPiuLL0MS91tPCJ9XMPoiOcQlFu+EjTDx+ZL7wll6AY4f3kGxszi8Zuuw2pr/Euk
         6o34eACqr29URLBwA8xp0vLuz3sTE0Wvv9mmzDajzk9CPnl3kPIJFjT00/7Ct3uRua21
         BDvR2hibDKGAFKMZqX6cosSWkExKs5eBDMk4km4uCZ6eXLMaMNy0irhCNR63q9Yi9+4C
         LXMQ==
X-Gm-Message-State: AOAM532rX4blaGOuipmwraQo2761yzPpdqP9bYPGWd0oIdBtEaLTKMIR
        WJtrtY94vfA3aJrABAf4zM1B0A==
X-Google-Smtp-Source: ABdhPJxvCvnYPIhkG0RP1EEZuFwkeBjKJg+pCqo3mQKVoS3f+IukkTDjao2BIi5eoYXPF82B5XIXdw==
X-Received: by 2002:a17:90b:1b0b:: with SMTP id nu11mr9942128pjb.206.1641597851358;
        Fri, 07 Jan 2022 15:24:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 24sm17393pgv.60.2022.01.07.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:24:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] eeprom: at25: Restore missing allocation
Date:   Fri,  7 Jan 2022 15:24:09 -0800
Message-Id: <20220107232409.1331599-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073; h=from:subject; bh=pubESV6xh+DqdJRhgxOgBglvFmpd6PKy7X55dsZ+pys=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh2MuYbfck0i6z6InEhMzX9jE98WDwaHZW0xNopio6 /Sg/r8WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYdjLmAAKCRCJcvTf3G3AJg0oD/ 9YNrZYLszd62x+P5PxMGoJiPOXwzZx37+aB7HKfVLByVSyVhzc0nDOCqiCvEmLQVTtHlqs6QUTU0lh OXxiKyMnm1JFSoqE9ew+/OjB9YDphu6eQ+O/sJpCDXKLDUHRTXQMdEjpTv3k9LiZt3Nz+LvdujeaHQ zbiNSoFAeVBBsczImUGhA4iVi+5gJb3DyvZIp3uV88nMsPFCW+9X/AKSwc9XYf4EYvqyTWU4NMQpR7 H8PCiJZMXoCHU1/c4LO7ZQb5F5Y8ledKC0+i+TS1wjgFnbvwaxTntoAomMZVtvnPx9aHiYEnIJ427d jKYuMIE89a85hZrMW0c7rGw3mMiL8D9bCONoovF4JeaBupTYJlNImCkwL0v2RedN+52lqijTjYiAuB o6hJdLBP0Jvlo+YeDX5JdHjJ2g/9Z64tGxQ6u5vYwsDxs2+lS7A0vP1cfZSVIuHt1XX4cCGYPLHhQi jpN9Q/a7JHTHM+syXFR2tAGT0hB4JB1xlcudMRaZ55uSXYr1JxX9A6isd4jb9gYPNGkHm05mae0jq9 ru/MLoe3zwFnVh6NggwEU48/YeGjUA0ym9bma9vh+FYfAJUvBvTnIDV64DG3sSqw2RZSYkDLYybIlA Wj3WtCxlGs/lEQ32nkobPUv8kFPWGrWVbfdVTOSBf54EMc/W1e2iuM+AqICg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building under CONFIG_FORTIFY_SOURCE=y and -Warray-bounds complained about
strncpy() being used against an empty object. It turns out this was due to
the at25 allocation going missing during a conflict resolution. Restore
this, and while we're here take the opportunity to do another strncpy()
replacement, since it's use is deprecated[1].

Seen as:

In function 'strncpy',
    inlined from 'at25_fw_to_chip.constprop' at drivers/misc/eeprom/at25.c:312:2:
./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
   48 | #define __underlying_strncpy    __builtin_strncpy
      |                                 ^
./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
   59 |         return __underlying_strncpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'at25_fram_to_chip' at drivers/misc/eeprom/at25.c:373:2,
    inlined from 'at25_probe' at drivers/misc/eeprom/at25.c:453:10:
./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
   48 | #define __underlying_strncpy    __builtin_strncpy
      |                                 ^
./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
   59 |         return __underlying_strncpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Fixes: af40d16042d6 ("Merge v5.15-rc5 into char-misc-next")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/eeprom/at25.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index c3305bdda69c..1a19fa5728c8 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -309,7 +309,7 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	u32 val;
 	int err;
 
-	strncpy(chip->name, "at25", sizeof(chip->name));
+	strscpy(chip->name, "at25", sizeof(chip->name));
 
 	err = device_property_read_u32(dev, "size", &val);
 	if (err)
@@ -370,7 +370,7 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 	u8 id[FM25_ID_LEN];
 	int i;
 
-	strncpy(chip->name, "fm25", sizeof(chip->name));
+	strscpy(chip->name, "fm25", sizeof(chip->name));
 
 	/* Get ID of chip */
 	fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
@@ -440,6 +440,10 @@ static int at25_probe(struct spi_device *spi)
 		return -ENXIO;
 	}
 
+	at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
+	if (!at25)
+		return -ENOMEM;
+
 	mutex_init(&at25->lock);
 	at25->spi = spi;
 	spi_set_drvdata(spi, at25);
-- 
2.30.2

