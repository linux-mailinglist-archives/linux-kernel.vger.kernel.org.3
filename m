Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970B564767
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGCNLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGCNLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:11:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E936361;
        Sun,  3 Jul 2022 06:11:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so7043453pjv.3;
        Sun, 03 Jul 2022 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WBURuHC5mRla7M7QE53l3il2hg02K+3swVq5Mb4kxGU=;
        b=l3o/GAc5mAI9f3eMVju3efbPbaUpr3pjrGJGjdtGwB5vsKjznNHKc/e01SjjHfLx45
         DKYl8KXkfzsyMtnRD26zN79d0ZlchwbHI0RfQlKiJkoQLwtZI6Mct9iCkz8OVgQUOfHZ
         7QLRZSLPtIFqyAC9G9GAWjkDNTr+LD1ofa/zE1OkiAFieTQTxk1WX1bK30vauzzTV4v0
         Os4IDl12ECHKuIwPc/5zrbi34gJ/oMsVj5OjpngQGKyI74khrcMk38a3sZa7o6QggQG8
         TKf5zDsrrT/SMb9UcNdnakHuFTnvgeDgfUkHvhf1qCvQNkiWN9HCimdU4tD1RkU6Ps2H
         +qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WBURuHC5mRla7M7QE53l3il2hg02K+3swVq5Mb4kxGU=;
        b=5WonbFRA6OLxU/GFLmWSbuelWEieCZhXDxYm6UrVXGjbb0THihhrOWhdsKeDlMA/W7
         WJ2NPR53vZ3MYgNmpQBBZb4NP3Skjq78tgFWc7D33wuY0YFgGBNj1KEzQir3ILxYNNI9
         zGPII1yPdMZBvkexYl+1lriUY8ScmxWe0Ja1VJZUGRdN8SAhyxk/EqPUTLe7ezOLpL/q
         jdxO1CO0Vs+fssd34kjNZrdfg0V8Z10p66OxzIuTatHXNYnaalcgedN6ivPvadumwhn+
         0ND8Pm5vMrx6v6Fb+oHJY7e96Hw9TY9r0PdmE/eap2WDurBmNrnymP5jX3i437qFlXr8
         s0vA==
X-Gm-Message-State: AJIora9ajnxLtCIWXrfor/cmMnLK/pmXjIrJPWTR9IFYacHC+tuscDqZ
        2+24kBNQ3djn369Gq93wuazHf0SI1JCbsA==
X-Google-Smtp-Source: AGRyM1tW2mY/4yurSSym3Kl2YwoLsrtyk6xn2oUq/RmDzgd1wb1ojBLXCR5Mc3jyivbPnN+1EhrEHw==
X-Received: by 2002:a17:903:2012:b0:16a:856:96a7 with SMTP id s18-20020a170903201200b0016a085696a7mr31735068pla.109.1656853873545;
        Sun, 03 Jul 2022 06:11:13 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79881000000b0052844157f09sm3291228pfl.51.2022.07.03.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 06:11:12 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 457341036AC; Sun,  3 Jul 2022 20:11:07 +0700 (WIB)
Date:   Sun, 3 Jul 2022 20:11:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     andrea.merello@iit.it, jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kbuild-all@lists.01.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org
Subject: Re: [v6 14/14] docs: iio: add documentation for BNO055 driver
Message-ID: <YsGVa8KFmdvGY92e@debian.me>
References: <20220613120534.36991-15-andrea.merello@iit.it>
 <202207031509.DlBrHyaw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202207031509.DlBrHyaw-lkp@intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 03:58:15PM +0800, kernel test robot wrote:
> Hi,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v5.19-rc4 next-20220701]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/andrea-merello-iit-it/Add-support-for-Bosch-BNO055-IMU/20220614-203754
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> Documentation/iio/bno055.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> 
> vim +2 Documentation/iio/bno055.rst
> 
>    > 2	==============================
>      3	BNO055 driver
>      4	==============================
>      5	
> 

Here's the fixup:

---- >8 ----

From bb8524aa4719e54389065548c86155cbee638357 Mon Sep 17 00:00:00 2001
From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Sun, 3 Jul 2022 18:37:44 +0700
Subject: [PATCH] fixup for "docs: iio: add documentation for BNO055 driver"

kernel test robot reported htmldocs warning:

Documentation/iio/bno055.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

Add missing blank between SPDX line and the page title to fix the warning.

Link: https://lore.kernel.org/lkml/202207031509.DlBrHyaw-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Cc: lars@metafoo.de
Cc: robh+dt@kernel.org
Cc: andy.shevchenko@gmail.com
Cc: matt.ranostay@konsulko.com
Cc: ardeleanalex@gmail.com
Cc: jacopo@jmondi.org
Cc: Andrea Merello <andrea.merello@iit.it>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/iio/bno055.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
index af21376d7a2533..9a489a79d8f5a8 100644
--- a/Documentation/iio/bno055.rst
+++ b/Documentation/iio/bno055.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+
 ==============================
 BNO055 driver
 ==============================

---- >8 ----

-- 
An old man doll... just what I always wanted! - Clara
