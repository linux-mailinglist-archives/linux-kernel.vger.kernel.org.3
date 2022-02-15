Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7804B7321
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiBOPPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:15:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiBOPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:15:49 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048253F308;
        Tue, 15 Feb 2022 07:15:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o2so37529669lfd.1;
        Tue, 15 Feb 2022 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HjfjdaOOin/bN5gqnNUktr7hRS40a6cu6WZxUerm6Y=;
        b=HBgtjPThZvYXcJsedr1E+R8cFCEa4Ct3G2GricOHSJ9xUa3YJgvh49DpcSNcGVI8sp
         7BMqnwrjt1cSF9h7lrwZpETViuFDigKHItENjybR4Z0+f90r33dnD2T0fAWbI/KhX0Xu
         gHRKhYTHKBvphfWCcxCm2Z4MaozAE76wNiRYrEyb8ngDyHKZx/gakHAD5NFlq25PbRsy
         aYIOUqmuuB9vSRa8os4jzCBHi1ntmW+1zU2kH9fquK5Tn/9BuIUyPkVpGPiJ1YU3KOGv
         zU8kAvAWhNrUQbTlTnC6n6rSFGxznAaFxhFrnsjC6kBDjeNyWtdm3Vycx3SICt0CwJdb
         IVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HjfjdaOOin/bN5gqnNUktr7hRS40a6cu6WZxUerm6Y=;
        b=obvbQD4s8zLScMghhfZZsS+sNeOi/yI+VnoeI1Y9qKzzL4UmkGKOvhRL9Fbp4YTmCW
         DgsvhafXaQ/ON6g7WueeCCRcdFJIvtX+DkkDoRYOWzlrdEAxcxk0kRgtZdlwAlJSMXEk
         KQttf9+KYA32/aFPGMp5nC0g1YZiBD8nscTEcb3cBJQdpVT1SdG/2i6QkZuKRwMAY2kQ
         TEAMejw9wlYE41wPOnStrWcg9IIZHPOlhdVtaPERuapwW9FUwabQtkhiL++rvf8RPpXC
         PnAgpCMrg8LtUTDlivUYRSqwY/Rzd/pP4Bp/BT2yp2Gp3lVcLOyQqvNqrdelyPO0dhKw
         vrlw==
X-Gm-Message-State: AOAM531BIym+b4KEwgwxlTXIIoBOPUNtb8DOBPSUMrBj3FzcF16snFtO
        nCn2EwKWTgOHqBYCzgIXRfH7bN9HlF/2xsglXmM=
X-Google-Smtp-Source: ABdhPJzfmAs6GpMj4I35HRBE1sJHAgNLTgNO/8mLQXCtN22V56CmKVSUQSI6ZStRrZLbrhzY8U7fsA==
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr3459503lfg.674.1644938137123;
        Tue, 15 Feb 2022 07:15:37 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id t12sm4479598ljc.97.2022.02.15.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:15:36 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Add support for Imagis touchscreens
Date:   Tue, 15 Feb 2022 17:15:24 +0200
Message-Id: <20220215151527.84634-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <1644531943.391463.3262540.nullmailer@robh.at.kernel.org>
References: <1644531943.391463.3262540.nullmailer@robh.at.kernel.org>
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

Add support for Imagis touchscreens, used on various mobile
devices such as Samsung Galaxy J5 (2015), J3 (2015), J5 (2016).

v2: rebase on top of the correct tree
v3:
- prefix all defines as IST3038C
- use two tabs for all defines
- add missing <linux/regulator/consumer.h> header
- drop ADDR_LEN and DATA_LEN defines; use sizeof(reg_be) instead
- use __be32 type for reg_be
- add a comment about i2c read not being successful on first try
- use "ret" instead of "res" in read_reg function
- don't use the internal __cpu_to_be32 function, use cpu_to_be32 instead
- use "error" instead of "ret" in interrupt handler
- pass the slot state directly, without ternary operator
- drop the dev_err in init_input_dev function
- reorder the functions in _probe so that the chipid command is read as fast 
as possible
- don't use imagis_start in probe
- initialize the irq after the chip is powered
- save the return value in imagis_resume
- drop WIDTH_MAJOR since only TOUCH_MAJOR is reported
- the "chip detected" message is now dev_dbg
- reorder headers so they are in alphabetic order
- use GENMASK to generate masks for getting the X and Y coordinates and touch area
- drop *_pressure from device tree bindings since the driver doesn't
support reporting pressure
- fix the typo with i2c address in device treee bindings (48 instead of 50)
- add IRQF_NO_AUTOEN flag to avoid unbalanced irq enable

Markuss Broks (2):
  dt-bindings: input/touchscreen: bindings for Imagis
  Input: add Imagis touchscreen driver

 .../input/touchscreen/imagis,ist3038c.yaml    |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  10 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/imagis.c            | 329 ++++++++++++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/input/touchscreen/imagis.c

-- 
2.35.0

