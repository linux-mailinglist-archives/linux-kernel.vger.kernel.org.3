Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC09589AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiHDLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiHDLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:08:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EEE5A3C7;
        Thu,  4 Aug 2022 04:08:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so5208533pjk.1;
        Thu, 04 Aug 2022 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1WTUJxXNd4y9VxJgSQhRnUUALsKU3r7nbFNOlA+9JoE=;
        b=Qi7Dus/hcqb+JCiHf9wHXwdlyHzthQwqzMA8vIHvCzY2PttDTMWqbaoeBBz0BXAbz3
         v2aQe2Zw9v1vPb3tbFIHb69ccz78MA92QJXV7Ww/3DzFWepm9UfwcTlP6UOAOBPab0AC
         e3Y1a6oU4LqCz49LhcOlvzCZS7VqTxbs7UEZnSkImPK0arfpp3nq4d20DBHW4/ghKfiL
         5xl6/H6CEiHkktLRMYy2fDei393r4Hu78IN02U+RchEcV6oWoxqe2wTS6dr1ogfigHMJ
         F7MkLxwALSdq5f4b3tumRbG8scKReOAx40T3s0H4reCuYYwoHINtMAxpxMAVXv300wfK
         6Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1WTUJxXNd4y9VxJgSQhRnUUALsKU3r7nbFNOlA+9JoE=;
        b=OjoaalkmC5MM6kYh2WTVFH5pWmW8E4BYPnKjq2LhcZeapZZlhGiBIaYvcfXba0poBG
         IsuEKIFHJtTMJAHaCY0e7g+Px60R0QXTfJaB1UMWJqBHLv8bROufPxVcKy2wBv19VPtW
         /4U7dDOEgIHCdyKRPfQzc3BSA/Dpg8ma8/MAPgObigVIWlhhEoHBnpwWXFWvW+7VLehf
         uw19ABlvcnDMWqM3t7ONY4wIuLItdZkDfBKoLi/2aMjgguBAQjDCwjE5zWZVbXihTFKA
         t2dlEmVao5kBhHjtqWyfeYecJC5H/YHEfUF3PKLZElebF8zWd/6WnMZziVK6SabZfPoC
         BwOw==
X-Gm-Message-State: ACgBeo1ycKs2zJ0+yaJYy/KdfKdU3Rl2kllpYfURXQy1yCtDrbSy73zw
        4HYY1sjyq9TCumvOo/M21Rs=
X-Google-Smtp-Source: AA6agR4IhTi7XNuBZ1Z0cjBXlSnZandgi+5VyiGJvb6w0ZxjCuvduibLeNHjE7AvsZXbTMs+FrxNSg==
X-Received: by 2002:a17:903:2684:b0:16f:846c:7a36 with SMTP id jf4-20020a170903268400b0016f846c7a36mr829627plb.84.1659611335223;
        Thu, 04 Aug 2022 04:08:55 -0700 (PDT)
Received: from rayhung-virtual-machine.localdomain (220-135-237-176.hinet-ip.hinet.net. [220.135.237.176])
        by smtp.gmail.com with ESMTPSA id f71-20020a62384a000000b0052d96d86836sm668127pfa.50.2022.08.04.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 04:08:54 -0700 (PDT)
From:   Ray Hung <tw.rayhung@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        tw.rayhung@gmail.com, dh10.jung@samsung.com,
        songmuchun@bytedance.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: rndis: use %u instead of %d to print u32 values
Date:   Thu,  4 Aug 2022 19:08:36 +0800
Message-Id: <20220804110836.138614-1-tw.rayhung@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The driver uses the %d format to print u32 values. The correct
format is %u. Fix it.

Signed-off-by: Ray Hung <tw.rayhung@gmail.com>
---
 drivers/usb/gadget/function/rndis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 713efd9aefde..10ba339bcea4 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -1105,7 +1105,7 @@ static int rndis_proc_show(struct seq_file *m, void *v)
 			 "used      : %s\n"
 			 "state     : %s\n"
 			 "medium    : 0x%08X\n"
-			 "speed     : %d\n"
+			 "speed     : %u\n"
 			 "cable     : %s\n"
 			 "vendor ID : 0x%08X\n"
 			 "vendor    : %s\n",
-- 
2.25.1

