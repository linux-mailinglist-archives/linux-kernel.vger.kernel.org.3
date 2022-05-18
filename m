Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1CD52C28A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbiERSnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiERSnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:43:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375B420D26D;
        Wed, 18 May 2022 11:43:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so3673583wme.5;
        Wed, 18 May 2022 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=629EuCNPVzAl5BBiBBvqoC7bqwWqe2HUHf+13KFi4EU=;
        b=N7x9i4oKZ4spJf0nC2xpourbHxhcMVu1vA8uxqp5db6agGtadWpvfKgcSZy22+razd
         khZ0cUQWoy5hjWYylmTD1NFHpSGizMg6fRaNDnQm2QlQ+aEarO4QJ32JZyYRTsyngtjX
         6dPEhuvVZUaye94Mqb90L+BRJwrvfHuiMaoC17GrGBnJ8e3R8mVi8MjvFDOMlUePZCD9
         0VfRzgsQox21clqN0799qYokGk+yT8mwnpyR3Uc1sSL1Bz8Dp3HffTJ+w0+tkV0l2T78
         rPoQT5NzN3z6Mn088Dl9UpHyCbOjYnttWzROnXrzuHSba7O4XP3RKFmu83NAVelwIKkC
         xTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=629EuCNPVzAl5BBiBBvqoC7bqwWqe2HUHf+13KFi4EU=;
        b=E5xBz0gefq7ItEmEWuw28CaIGSI8Mo+UyFoKPqNxHwzpf2j53A5nKO3JzjaQKdKsNn
         cRTkQi89aujPYD/WUYzkUC79PXLc1RQAbrSKUmu3XTvnl9ymksyKvOl7/NIwvVRuNMmE
         qKlLw/zzvYBJMEbrapoLPVEOZhqHFi2eI5p9ftnfnDybk3KGhPYbRy2coj1UPWDYCqTU
         rUo87VJ2oSjeWreYtA7zB0uf1nAf3pNJeNW42CMr6cD55Ak/znrc2H4YfB/9nsJ42+oK
         y1HD8zR570G/FR3vcIisCyJqE/uH6vKMhyUUd2OzFIQiYKZuhjqveio2tW0LqO9af4+V
         CAaw==
X-Gm-Message-State: AOAM532rbira6jZwiK82CKE6WHfic4g6HSDQB5YLpLUhdM0KCUGIjPi5
        vbiYDAkgMygzfcTJQSgQDgVhNfS1XNc=
X-Google-Smtp-Source: ABdhPJwv3JxgSmNPpRs7CVBBT2W/2LDoLrHtng0kDykKkolE2BmoGPlfR5Iwtvh5hNhPGcBkeIxznw==
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr1137496wmi.91.1652899386459;
        Wed, 18 May 2022 11:43:06 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id q9-20020adf9dc9000000b0020d02ddf4d5sm2768546wre.5.2022.05.18.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:43:05 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v3 0/2] Add support for unprotected spare data page
Date:   Wed, 18 May 2022 20:42:54 +0200
Message-Id: <20220518184256.21238-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Some background about this.
On original qsdk ipq8064 based firmware there was a big separation from
boot partition and user partition. With boot partition we refer to
partition used to init the router (bootloader, spm firmware and other
internal stuff) With user partition we refer to linux partition and data
partition not used to init the router.
When someone had to write to these boot partition a special mode was
needed, to switch the nand driver to this special configuration.

Upstream version of the nandc driver totally dropped this and the result
is that if someone try to read data from these partition a CRC warning
is printed and if someone try to write that (if for example someone
wants to replace the bootloader) result is a broken system as the data
is badly written.

This series comes to fix this.

A user can declare offset and size of these special partition using the
qcom,boot-pages binding.

An initial implementation of this assumed that the boot-pages started
from the start of the nand but we discover that some device have backup
of these special partition and we can have situation where we have this
partition scheme
- APPSBL (require special mode)
- APPSBLENV (doesn't require special mode)
- ART
- APPSBLBK (back of APPSBL require special mode)
- APPSBLENVBK (back of APPSBLENV doesn't require special mode)
With this configuration we need to declare sparse boot page and we can't
assume boot-pages always starts from the start of the nand.

A user can use this form to declare sparse boot pages
qcom,boot-pages = <0x0 0x0c80000 0x0c80000 0x0500000>;

The driver internally will parse this array, convert it to nand pages
and check internally on every read/write if this special configuration
should used for that page or the normal one.

The reason for all of this is that qcom FOR SOME REASON, disable ECC for
spare data only for these boot partition and we need to reflect this
special configuration to mute these warning and to permit actually
writing to these pages.

v3:
- Fix typo in Docmunetation commit desription
- Add items description for uint32-matrix
v2:
- Add fixes from Krzysztof in Documentation

Ansuel Smith (2):
  mtd: nand: raw: qcom_nandc: add support for unprotected spare data
    pages
  dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding

 .../devicetree/bindings/mtd/qcom,nandc.yaml   |  26 +++
 drivers/mtd/nand/raw/qcom_nandc.c             | 148 +++++++++++++++++-
 2 files changed, 169 insertions(+), 5 deletions(-)

-- 
2.34.1

