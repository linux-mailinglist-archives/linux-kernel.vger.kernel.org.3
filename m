Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721C747763B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhLPPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhLPPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:45:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83419C061574;
        Thu, 16 Dec 2021 07:45:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so4163807wrg.7;
        Thu, 16 Dec 2021 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/jha9cndIkDUqDGzCuDAbGL68WCP4ZkFrCHCGFvS9NU=;
        b=hNqLAguz19bFoQGcAK15Ed/ccdjM/t5qAW0r6YVp6TCB744NduFAt1Wr2fQh840ANp
         Qzndl8emfxBMTODABRHNSiFA6Co21+dUL9NWwV3FBsvMtNxWSBI6mKXW3XOdNg0a9Yzn
         ABWvgB7kr5R5ntXlD7Euq4FkFM9W0n9W7/SHwCo2bYROYgGqhYsNkl5trXKu4xuErOW+
         AVbOuqvO2GSggoZaoQjK6q20w98sgY2dRz3QMGOcD0jwCDE0ATf2dEAN2644i0F8d2cB
         yv4cSlAAacjM6wckSPUoaGS1Qt2BD41TmjXVPW3UUgCJ22RZ+LFOw9oUyyM1/npWUZhK
         Wpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/jha9cndIkDUqDGzCuDAbGL68WCP4ZkFrCHCGFvS9NU=;
        b=z2VWy4iuqhw1kNe5jHH0+B9p7t8HxBuCpunnYd2x9exaAkjGIzTHWDntkuuY+9KaEY
         2K82Vv+BQxXL+dFTEngoJTZe4XiH83V0Bm61JN4mVbKvVAceFUkMAtkopJxAKDnZvkYr
         4Yq/+FROfnWPVyI2xmFRuGykRwvwAq8erywHUium6Gj01BovTWKLmO1xrX/vd9iyGset
         HqQxX6u5XqEsOuWQtuHiEtGS1NFHwmfdCkAN3S0kvoa9RVVdo/75pvENb1wqSk0F9n3Y
         dV9SWRvEo1oeGWJyWkqyV4dW8MvB99OYefVJUysLqm3MNi9wFtLoDttS8byK+98p7kWk
         lurg==
X-Gm-Message-State: AOAM533Uk31tT+d/c3Wa7hFAvv5eVfuw3ugKpipPHvdjmflEVcwvo6dZ
        dVs22eSWL4P6jpETlXL6alI=
X-Google-Smtp-Source: ABdhPJyolMr0OuFmVV0QPXqOQnaVM3//e6hsDhL+jeMG36K/I6zFfzga9OMOtAiZPnMin9pDbJ4prw==
X-Received: by 2002:adf:fa49:: with SMTP id y9mr7512398wrr.375.1639669503044;
        Thu, 16 Dec 2021 07:45:03 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:26ad:b100:414e:3655:7ee7:65c5])
        by smtp.gmail.com with ESMTPSA id y11sm6537075wry.70.2021.12.16.07.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:45:02 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] hwmon: prefix kernel-doc comments for structs with struct
Date:   Thu, 16 Dec 2021 16:42:57 +0100
Message-Id: <20211216154257.26758-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command ./scripts/kernel-doc -none include/linux/hwmon.h warns:

  include/linux/hwmon.h:406: warning: This comment starts with '/**', but
    isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   * Channel information
  include/linux/hwmon.h:425: warning: This comment starts with '/**', but
    isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   * Chip configuration

Address those kernel-doc warnings by prefixing kernel-doc descriptions for
structs with the keyword 'struct'.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/hwmon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 1e8d6ea8992e..fad1f1df26df 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -403,7 +403,7 @@ struct hwmon_ops {
 };
 
 /**
- * Channel information
+ * struct hwmon_channel_info - Channel information
  * @type:	Channel type.
  * @config:	Pointer to NULL-terminated list of channel parameters.
  *		Use for per-channel attributes.
@@ -422,7 +422,7 @@ struct hwmon_channel_info {
 	})
 
 /**
- * Chip configuration
+ * struct hwmon_chip_info - Chip configuration
  * @ops:	Pointer to hwmon operations.
  * @info:	Null-terminated list of channel information.
  */
-- 
2.17.1

