Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF34D4EE96D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbiDAH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiDAH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:59:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6726364D;
        Fri,  1 Apr 2022 00:57:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h196so1470350qke.12;
        Fri, 01 Apr 2022 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5srtj7khY+hVrjIWR3S7lQuVnq9rPhASABAlLq0xns=;
        b=VABeflTvTO1dTlQOVWd+GIzMXTHo6kxXqrnHQX8FkgG8JtABEoYQlgzr13JoPi361i
         p4d8tZM/JsrvsWOTSUkQ+fm3gTam4NJIO1vyegH550R/3+Y2r9LuBC7ADZfKEOZJp+pH
         m1heyw262ccEeUFpV21LQGM54eT4GF7RwL7flyGDHKKWzOI3XNYjyHaHSDHSW6xUmzUz
         0mXl1mUXCgT/N/tOYigbmnFYqjDHBW4dU7xZ5FQrtdnCp6LF74+h7LRuun0ZRrK9I/NP
         WbjKkGVtyLlXgZX1ZKFNCZ2MTwyICIzkjdHd0lJ6uYbgd7k7MUL6mNSZYcXwjLrZ9ihJ
         keKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5srtj7khY+hVrjIWR3S7lQuVnq9rPhASABAlLq0xns=;
        b=nObj2nA4rDhbdraQPaj1HEunCoPZOJIlNZ+rAGWmbWLeb2mA3mnkctL1EfIRxsTBXn
         XrR7LpH+iwgejFcV9aqpQqKwCVvEUy3wDwSv382XFxDW+X/GDEKX60Q1fAtR9zTIpJhM
         8djWO89f1hWVM0TeG6r/4deNFmdCnqk8bq/HrHioBrNaeQs2RUCECU+Pd2SA/C7+sanl
         +mTcMyq+zdUZWaQCS5+Y0pAXlpiGJpHohavue1y2+oCouW2ZF6ERLqFoVc+m3MmRHwX9
         q0AgJ+kv2lpxitSc0V94DH/MV/KgxXHpivt2gaFqvazuOwldSyaVuQfs7cF1AZrkIIPG
         lj2Q==
X-Gm-Message-State: AOAM532/keOnAV9UGL6w/QcpQa8InNXU9AIvVbkcyOjf8DcZEr3KmiLi
        yriyjyAjkiX4z4nAKf91NgQY2MZZpyg=
X-Google-Smtp-Source: ABdhPJwE6No9Bivwck4+4hL9Zno2MWfpmoTPPyFo7ZA1whlIs0Ib1Og+raGgcZ8OcPSqH9vKhFS51A==
X-Received: by 2002:a05:620a:424b:b0:67d:36cc:5afb with SMTP id w11-20020a05620a424b00b0067d36cc5afbmr5876252qko.598.1648799873270;
        Fri, 01 Apr 2022 00:57:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w17-20020ac857d1000000b002e19feda592sm1231557qta.85.2022.04.01.00.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 00:57:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     weiyongjun1@huawei.com, colin.king@intel.com, lv.ruyi@zte.com.cn,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: ftdi-elan: Fix undefined behaviour
Date:   Fri,  1 Apr 2022 07:57:47 +0000
Message-Id: <20220401075747.2407536-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The use of zero-sized array causes undefined behaviour when it is not
the last member in a structure. As it happens to be in this case.

Also, the current code makes use of a language extension to the C90
standard, but the preferred mechanism to declare variable-length
types such as this one is a flexible array member, introduced in
C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last. Which is beneficial
to cultivate a high-quality code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/usb/misc/ftdi-elan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 6c38c62d29b2..e818d2ed6831 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -171,7 +171,6 @@ struct usb_ftdi {
 	struct delayed_work command_work;
 	struct delayed_work respond_work;
 	struct u132_platform_data platform_data;
-	struct resource resources[0];
 	struct platform_device platform_dev;
 	unsigned char *bulk_in_buffer;
 	size_t bulk_in_size;
@@ -185,6 +184,7 @@ struct usb_ftdi {
 	int expected;
 	int received;
 	int ed_found;
+	struct resource resources[];
 };
 #define kref_to_usb_ftdi(d) container_of(d, struct usb_ftdi, kref)
 #define platform_device_to_usb_ftdi(d) container_of(d, struct usb_ftdi, \
-- 
2.25.1

