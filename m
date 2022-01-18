Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F233492D20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbiARSUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiARSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:20:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC66C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:20:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e9so4353834pgb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYi71jp6Hzp20fzb6LpdTO3OtuPX8i22MeWwZkyzU8c=;
        b=K7u3eFsE0JUPvhFjTXE8EE1Z6iRAUz3VhdFGrWzZ2TKzWvOziVvh62iVGBJ7FDhS6w
         WDlSshlBxFtktU5e17zMRFxWqfiIpfsBZx2uRZjQQkGVzRUwuAzesS6E5kQ/zBGTOOs2
         qjoFztzc1zH0kW2jtAgpxL9Kaw3QOUTI1CEow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYi71jp6Hzp20fzb6LpdTO3OtuPX8i22MeWwZkyzU8c=;
        b=GrECoat90kxdYUfCM7aC0V1mjrRIpNZA8dnRfvtaKNrJzaaFRly+yN5eWjpLJr3ZKA
         6FGjmUHiTnRBCby/mvb7tA7RM51dCyAN7LDvTqvPhRXL12NTZ3EGiEK7fgSPLSBF3tq1
         78uYvsxUXdArFwjun4vZobAwO41isXHA+2/NjS6ilbwuCflnGFoZGTE1YqfF4ZZ4+fc2
         JSS/Z22aWMqUwvw+qpw+HXaX3ObMIr1oz8S+SUZOEq5bqDhzIEMB2R/VSUMFvPwwFVsV
         x4GMhKmS/7VLgr6U5ECwDB9sFxoxvVKuVza+qEvd45ODd9cPRrfwRxSWNLBpu91SzkUo
         9+/A==
X-Gm-Message-State: AOAM5328JzItJeECvo4649fPmah7MkbNrcdIQGIrXxAcY5wm2AUHKyqd
        Sbu/OivTvaMqpFZAKALgg11ge9LKHJA+zA==
X-Google-Smtp-Source: ABdhPJx1yTSE4mJ3JfwxhpVU1yiXSVKa293wOioMUmELGMtsd7qx4zq4qaAqhbdle2VEzcSlBJ6y2g==
X-Received: by 2002:a63:b50d:: with SMTP id y13mr24303181pge.286.1642530008535;
        Tue, 18 Jan 2022 10:20:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6sm9544405pfv.170.2022.01.18.10.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:20:08 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 5.17-rc1 v2] eeprom: at25: Restore missing allocation
Date:   Tue, 18 Jan 2022 10:20:03 -0800
Message-Id: <20220118182003.3385019-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545; h=from:subject; bh=VxoXfF4kj9IwoedY+gLWJVoxXvz3K9BMYYOPksczBfw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh5wTTK5PDZaKE/2cldqscaNj38Cyl0lzcdoaVobT0 OoGkX/yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYecE0wAKCRCJcvTf3G3AJqhCD/ 4s8l4oOX/P9z2ApXy0raxoTyGKabrM0F5/rrfSeRL8CulIYWmCD4BmeOyZFLwOwBKGNORG7xIIvXMH 9vH5o1Oc8dBxHWspL5435Zx3uhz730ZvTxi6qKWk5Uz40sWZtzHSxlxohSzC/6pgO9ajJ+X7uiFMka Z2patTMEiUX2GJucR4Z3TInFNvmo2VvnM9J9Nzumk2y+J+QbqN67tebo8fY9dS8F30vjOFj+stcU3O iSOXOSTjWcwbzysWnUEFIz3LvmabdpfYHlPR+PZZoxTAYjIBpMbLgpkdNYCNyClq8JSPlYIYu2T8YH BeLKj6IRp+5SGDylP7k7F1SVg1Co5Bdz7su5LRR7aiQ9Oa79XOyneITYWunHxYF/sk5XmZuKBbtcSo lZO2IINg3rECK4UTC9VfYxTAmxamTehEOVYNU2D7aOvxRTaUZy3HrjJDoOHGNcp5dweD2Ro4SRXFoi G04oPxtTQI3m8trLew0B+gJdqNwP8VxEQuFxSQkvjw/m4yVtaDSrF02K+4vMECgLhmXK827TWprNKU +FwvfW5e/+DI8hVV7C72vtcMaszzlosXApERMrbrCeKpvvyE97BKqaS6ZetxilEhfVFOKCzoFwPB6B Ia5Mwijblj8dTxSN4vUSiIb0dI7gzROSsILMpKXHcULmM2gKoT27MUn0D1Pw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The at25 driver regressed in v5.17-rc1 due to a broken conflict
resolution: the allocation of the object was accidentally removed. Restore
it.

This was found when building under CONFIG_FORTIFY_SOURCE=y and
-Warray-bounds, which complained about strncpy() being used against an
empty object:

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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
Fixes: af40d16042d6 ("Merge v5.15-rc5 into char-misc-next")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/lkml/CAHp75VdqK7h63fz-cPaQ2MGaVdaR2f1Fb5kKCZidUG3RwLsAVA@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220107232409.1331599-1-keescook@chromium.org/
v2:
 - remove strscpy() replacements (unrelated)
 - use sizeof(*at25) (Andy)
---
 drivers/misc/eeprom/at25.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index c3305bdda69c..bee727ed98db 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -440,6 +440,10 @@ static int at25_probe(struct spi_device *spi)
 		return -ENXIO;
 	}
 
+	at25 = devm_kzalloc(&spi->dev, sizeof(*at25), GFP_KERNEL);
+	if (!at25)
+		return -ENOMEM;
+
 	mutex_init(&at25->lock);
 	at25->spi = spi;
 	spi_set_drvdata(spi, at25);
-- 
2.30.2

