Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E690598233
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbiHRLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHRLY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:24:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3045C36B;
        Thu, 18 Aug 2022 04:24:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e20so882332wri.13;
        Thu, 18 Aug 2022 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=BfkpuYhWWV3z0UBvbVgMJJbzhNR8JpIXBKTTsE8aT90=;
        b=BCcruAbNhnvE2FO99nIU8oKrInNU391CRjvwpRjdMG2qMb6mV59maUjV62qGUUrS6J
         9AifLDn8+lcaxSN81r3KI1uSfEPhNc1k70FxPAXW2+XQhz/47iRXEpte3XuRdMbgSbxm
         S/2XoFcC73UyKVyjEmZKElU7CFEMryxk8V4xtiyy87hgW7/tUUEL3mvs2IxmzKLBAWDX
         bPJDMmjRZlAeEZNVp2+3qBp4Pqn7tVn/Ecm9ZqlwrNnCWXRtCgui9aUCkN7KbnOpjHQp
         U9hElOPmPJSbh4hT6CQ1LDtzMVLQy77Al5y2UQChm1IfzWh0avE3TxmuCDy2/ay6IWiR
         pJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=BfkpuYhWWV3z0UBvbVgMJJbzhNR8JpIXBKTTsE8aT90=;
        b=XSdBPOijK+HeNL7ogtlOS/rj4vOJ8UG9PkEdR7hhy8CeSshmT0KKQ7lqTQXE6OvHB4
         nHiPXzX/Z9Sa93ZaeXi9HWIc8Xx62hol6LeKr9qpg1FjvTWmaf3dTYw+YZKRVV+89X+h
         DgTdzgPGvkRlp7notRHS4ne9VJwO3uNIUNjDi8G5/cIXrUF621H6R8vtWcDMrnx4tWzV
         flLXrrX5njY5R2uqM97tNbd87bIjoVJsLdcwdm5YNy4t+xwcgVrSXYE3/eAQBZqgxpV9
         tLLEV487Q93Y9ScYqORv7ZKZ+06KgdV3yhWD6UHX0WCOi2TUBJ3RgeIAduqrmO30ae4N
         IoGQ==
X-Gm-Message-State: ACgBeo3puvdFYnaoWFp067z5cWoEHGTol4Y3s5BfL+1vBCMCtEAo9W8O
        1H0xEyUbb3NNr2XV/Ip2J/k=
X-Google-Smtp-Source: AA6agR4IoZ6AZQzAK9nsfNkFBUH4LqxEKtZcnlG6DCMZ0TYxSKyfUFlJcXqwdQu6InBFtrblolkI2Q==
X-Received: by 2002:a5d:5983:0:b0:221:7cbd:df50 with SMTP id n3-20020a5d5983000000b002217cbddf50mr1356294wri.420.1660821896767;
        Thu, 18 Aug 2022 04:24:56 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b0021eed2414c9sm1157080wrs.40.2022.08.18.04.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 04:24:56 -0700 (PDT)
Date:   Thu, 18 Aug 2022 12:24:54 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: build failure of next-20220818 due to 81c0386c1376 ("regmap: mmio:
 Support accelerared noinc operations")
Message-ID: <Yv4hhoTTcRuk/2Kl@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of alpha allmodconfig have
failed to build next-20220818 with the error:

drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_noinc_write':
drivers/base/regmap/regmap-mmio.c:221:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
  221 |                 writesb(ctx->regs + reg, (const u8 *)val, val_count);
      |                 ^~~~~~~
      |                 writeb
drivers/base/regmap/regmap-mmio.c:224:17: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
  224 |                 writesw(ctx->regs + reg, (const u16 *)val, val_count);
      |                 ^~~~~~~
      |                 writew
drivers/base/regmap/regmap-mmio.c:227:17: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
  227 |                 writesl(ctx->regs + reg, (const u32 *)val, val_count);
      |                 ^~~~~~~
      |                 writel
drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writeq'? [-Werror=implicit-function-declaration]
  231 |                 writesq(ctx->regs + reg, (const u64 *)val, val_count);
      |                 ^~~~~~~
      |                 writeq
drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_noinc_read':
drivers/base/regmap/regmap-mmio.c:358:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
  358 |                 readsb(ctx->regs + reg, (u8 *)val, val_count);
      |                 ^~~~~~
      |                 readb
drivers/base/regmap/regmap-mmio.c:361:17: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
  361 |                 readsw(ctx->regs + reg, (u16 *)val, val_count);
      |                 ^~~~~~
      |                 readw
drivers/base/regmap/regmap-mmio.c:364:17: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
  364 |                 readsl(ctx->regs + reg, (u32 *)val, val_count);
      |                 ^~~~~~
      |                 readl
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readq'? [-Werror=implicit-function-declaration]
  368 |                 readsq(ctx->regs + reg, (u64 *)val, val_count);
      |                 ^~~~~~
      |                 readq


git bisect pointed to 81c0386c1376 ("regmap: mmio: Support accelerared noinc operations")
And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
