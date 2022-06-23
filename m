Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F558A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiFWVNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFWVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6C506DB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r20so547593wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzKqjiM8Hcmn0TSrgi/Y0FzUJz1V9STkyDvnMylp0MA=;
        b=DSh4ixxnuo2JqnHnaIWLtTqhDfoQ8SsCFQMojXaEdsE6hI0cihnTpacZXPNDH3uZOO
         b3IiPoNKt69fO17wl6CKoUM8b/en9dCAf7hgbd7wJ18cgwAEcGmjtbJorH8kmz60uY9v
         5C2jzlkONK4sMiqwE65FX3fwbXBRoezhmYPPT1KUm7qRGgqfcuZTDO01UbimyaTicPLc
         sU8nF014XTXsIJHRGEq25gsi4WZr+utYzszJ154tukvuDjD6UFTonlYxIywmRfvi8+w8
         zBCh93wZO6hVSUB83O3UBxjTNh1350mBZzZVKBskl/MlQ8Y4MFPif60CDvOsijTwU5l6
         1YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzKqjiM8Hcmn0TSrgi/Y0FzUJz1V9STkyDvnMylp0MA=;
        b=1nbppTuIrH7EEOTl5MTelyminGnrg4ReLFIbYMilXpgOQdPnmzIbrZaVwYS3yy1th/
         lPqp8WDVo4N5bJlZflVHanLROZIj1XNPtlVLmbEyCqlgvDKXd0TrJBURqrR8/8NSlQ3N
         iC28mCjiIredEkYHgFHF5qNTRClE4Ztaqlcpzr02iJv+p7BMilC+yQIZBJp0Y4JhwZXH
         FMPrErfe76K0S29JOqJkEjqcetMgE8SLynAWSBMTXg/zitF1tnoBsu05QYYcCt1AlE3t
         FeUCdtFqMrXWWaYIojDLokYaanKw4QttfBx8T68AygKnUalCeBasmE2ikJrbkyGC1s5h
         9rAg==
X-Gm-Message-State: AJIora9/SuwOh1UJQFiJfljtLM53KMl640Rgf3Wip2lmKOhSxR94qDua
        /F4y0T16sEr4LchOQk8hhM8=
X-Google-Smtp-Source: AGRyM1uFYdbf8MgcNdvhVzaaZ88Xds8QSyD//TuZfXROPEJSRID4BbVX9mYbnxDwcbID0aqJi5IUug==
X-Received: by 2002:adf:e448:0:b0:21b:80e4:e0e2 with SMTP id t8-20020adfe448000000b0021b80e4e0e2mr10129361wrm.133.1656018806133;
        Thu, 23 Jun 2022 14:13:26 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id j3-20020adfe503000000b0021b8a0d680esm400021wrm.86.2022.06.23.14.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:25 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] regmap-irq cleanups and refactoring
Date:   Thu, 23 Jun 2022 22:14:08 +0100
Message-Id: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an attempt at cleaning up the regmap-irq API in order
to simplify things and consolidate existing features, while at the
same time generalizing it to support a wider range of hardware.

There is a new system for IRQ type configuration, some tweaks to
unmask registers so they're more intuitive and useful, and a new
callback for calculating register addresses. There's also a few
minor code cleanups in here.

In v2 I've taken the approach of adding new features and deprecating
existing ones rather than removing them aggressively. Warnings will
be issued for any drivers that use deprecated features, but they'll
otherwise continue to function normally.

One important caveat: not all of these changes are tested beyond
compile testing, since I don't have hardware to exercise all of
the features.

Note that this series only applies cleanly on top of two patches from v1,

[01/49] regmap-irq: Fix a bug in regmap_irq_enable() for type_in_mask chips
[02/49] regmap-irq: Fix offset/index mismatch in read_sub_irq_data()

which are already in

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

(NB. I'm not too sure if I should be including them here or not.)

v2 changelog

* Drop driver patches, these will be sent as separate series to the
  appropriate subsystem maintainers.
* Drop patches that remove deprecated features, that should be done
  in a separate series.
* Various fixups to address Andy Shevchenko's v1 review comments.
* Drop patches that changed the behavior of mask_writeonly; instead
  just remove the flag.

Aidan MacDonald (12):
  regmap-irq: Convert bool bitfields to unsigned int
  regmap-irq: Remove unused type_reg_stride field
  regmap-irq: Cleanup sizeof(...) use in memory allocation
  regmap-irq: Remove an unnecessary restriction on type_in_mask
  regmap-irq: Remove inappropriate uses of regmap_irq_update_bits()
  regmap-irq: Remove mask_writeonly and regmap_irq_update_bits()
  regmap-irq: Refactor checks for status bulk read support
  regmap-irq: Introduce config registers for irq types
  regmap-irq: Deprecate type registers and virtual registers
  regmap-irq: Fix inverted handling of unmask registers
  regmap-irq: Add get_irq_reg() callback
  regmap-irq: Deprecate the not_fixed_stride flag

 drivers/base/regmap/regmap-irq.c | 432 +++++++++++++++++++++----------
 include/linux/regmap.h           | 104 +++++---
 2 files changed, 367 insertions(+), 169 deletions(-)

-- 
2.35.1

