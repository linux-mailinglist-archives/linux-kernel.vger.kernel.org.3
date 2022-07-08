Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB26856C2C3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiGHUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiGHUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:36:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240E9FE29
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:36:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id a17-20020a170902ecd100b0016c012c4cf3so3376642plh.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6l2CjPLXl85Q15DcTvzQiYj2hwKWjzB2O4EVtvxw9k4=;
        b=BePOGD043IgAR5e+hSZbNy1h9F5Y0m1k7v84h0obB/WrgkLEFoueASGq3zFANmGHOz
         Fqenh8TRKEczyYt13TyKQ/Ft75B26xUhSuGyvRQ1zAE6itMoB59ht02AEvEnakmLUxo1
         YrgKYzHPAUKlGfQtuamRhtSX+m7/2OihMg+kF6Vo0qNw8krFAz6tlcVoW3lneuVLIR/h
         GEyuzB8p4Kl6HFl5aYAKmtmecKC3zCIjOrhRDPP0KBARRNl50UsDmdCI3DwTygCZo8M7
         b40SJKdfrcVjMe9jgBYSzHx/b6Wb5XtUSgOuz6jyPFwQ9k+6mebwJ2kKzNw9KUQELzMt
         6jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6l2CjPLXl85Q15DcTvzQiYj2hwKWjzB2O4EVtvxw9k4=;
        b=rOBkD1dwUKnL840p0xJcDQnghzKcj/pZyHu53jXLVWm/qTartufhqu/KEsNncKcSPQ
         M9TtgxuzjQbxtLQRNYyEYCw9RvMXtKLmd58SM80ai1ACRSlwGn92122OCm9v1Se0Jtil
         Eu4/JJAMmtGvF0qipExAY4JKT7diFGrUCbNhc0Z095SAJbHwPZseCZ+4RpUTR27OKtbH
         ZCcB7kUoN6HeWxvdrED9lKl8Q5fDOS75vTryD9qBunbLOl6NSbwHe7oYcdUIpMyZUrDs
         qlpGaL23JtwjzevjYVvR8yyQ0ivl+FKpryD+vKYXRxlefIU4CESE2VhxO7/SLDdJ6ONG
         ONNA==
X-Gm-Message-State: AJIora/mx1jYD10HyWuBJwurkXrIYoGvScXhWx81hqAurQHzYNaxZvDA
        fVH3Uuptgtjcqb00a6bhcoELQqDAto95no2wPA==
X-Google-Smtp-Source: AGRyM1tWj8XkMwJhTmMQrFk7gxtfhZc4z1G9yxzQYISYkgHffEzjFg1VIhwaywiaaEPo5AH9Nu2FnTrjfLxNFc3emA==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:f21c:9185:9405:36f])
 (user=justinstitt job=sendgmr) by 2002:a05:6a00:8cf:b0:522:93a6:46e9 with
 SMTP id s15-20020a056a0008cf00b0052293a646e9mr5910494pfu.62.1657312564619;
 Fri, 08 Jul 2022 13:36:04 -0700 (PDT)
Date:   Fri,  8 Jul 2022 13:35:49 -0700
Message-Id: <20220708203549.3834790-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] mei: me: fix clang -Wformat warning
From:   Justin Stitt <justinstitt@google.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang we encounter the following warning:
| drivers/misc/mei/hw-me.c:564:44: error: format specifies type 'unsigned
| short' but the argument has type 'int' [-Werror,-Wformat]
| dev_dbg(dev->dev, "empty slots = %hu.\n", empty_slots);

The format specifier used is `%hu` which specifies an unsigned short,
however, empty_slots is an int -- hence the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/misc/mei/hw-me.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index befa491e3344..3a95fe7d4e33 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -561,7 +561,7 @@ static int mei_me_hbuf_write(struct mei_device *dev,
 	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
 
 	empty_slots = mei_hbuf_empty_slots(dev);
-	dev_dbg(dev->dev, "empty slots = %hu.\n", empty_slots);
+	dev_dbg(dev->dev, "empty slots = %d.\n", empty_slots);
 
 	if (empty_slots < 0)
 		return -EOVERFLOW;
-- 
2.37.0.rc0.161.g10f37bed90-goog

