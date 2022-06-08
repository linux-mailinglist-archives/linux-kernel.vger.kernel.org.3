Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD33542700
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446655AbiFHCZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445059AbiFHCLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:11:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63608B58;
        Tue,  7 Jun 2022 17:11:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so38216959ejj.10;
        Tue, 07 Jun 2022 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ar1MDgtA0wB8Ds/6E+9yGeeWGB8hd9IIOZtnBP3qtQ=;
        b=IM1XkXyqw7gnD/Ee2HrDRknwqvnksbwocKVipuKtHHy7V9A7QvPfIZ0SdUBxhAsjiA
         2BXgxrF+ABiZacrrEk7rf5Jmn6J56FT0/j2EH3nvI+LTdS5KOCGUAz+t5KinebT+0bBz
         wjF2JVvw1/fEjKL9G1z7s58dQZzhGIBq7uKK6v8uic/rNEmvW+vLPK6QfjJaxjLPhNh/
         7XSQzjJFcXkUepwkB0wQ0LJITyMSYPE8yNV6S2LPIK6U1Xs37gkKQe/mJfbL3vx5tafE
         LLoCPYhAw2FuN9cXol7v380sGD2OdKGqAE78H7J5dSxF6i0HzseJC77uHcDnuw/QkHv/
         TnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ar1MDgtA0wB8Ds/6E+9yGeeWGB8hd9IIOZtnBP3qtQ=;
        b=Bj1ztGO2xLarav4m7mCsHXuAvrxZ0NkN4WEbu1sckPZfkG2VW3mmk1E4z/LmugDeNG
         lgvc0jaKkWFCvvpQzKETkP9UGAr+MbPsMRqAFp0cxbb97mEja2ktM5oDVzN813E86+7a
         rZFMHBh4Ud+Jx6vGmjuGRzdErnvDkvAWpksXotqSTL1ge6TiDRoGvVmE8xyWPwxYj2Uz
         7mp0ZFeEVk6+vYIpxcwR8oPaYRq8TDtvT57W7DWj7x3I2HG9PJxfOmwilWA6z4OcA0gr
         r0yZJxwNOL1ghTpfeOa77ZSMJbPJSWHlDM3cmjGTlqOhnMcNK4URVAAYjApX5Bzo0kxH
         0k5A==
X-Gm-Message-State: AOAM53021JadDckoCBZbDtlPO/zadqLG8N6YmqOJNehwbQLKbpoerD6a
        SJ9eyncyFuNBoCdoOyAClEI=
X-Google-Smtp-Source: ABdhPJx0X5+zVB5NX0PKmpIScjirJeMXRAiXjVqt/5EDlTUmwRA+OrHGmIWDdCPgNj58WTScuMxtfw==
X-Received: by 2002:a17:906:449:b0:711:c975:cfb8 with SMTP id e9-20020a170906044900b00711c975cfb8mr14330370eja.58.1654647091688;
        Tue, 07 Jun 2022 17:11:31 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id o19-20020a1709061b1300b006fed85c1a8fsm8434947ejg.202.2022.06.07.17.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 17:11:31 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add support for unprotected spare data page
Date:   Wed,  8 Jun 2022 02:10:27 +0200
Message-Id: <20220608001030.18813-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

v5:
- Rename boot-pages to boot-partitions
- Add additional check to parsing function
- Rename unprotect_spare_data to codeword_fixup
- Add additional info from Manivannan
- Add patch to remove holes in qcom_nand_host struct
v4:
- Fix wrong compatible set for boot-pages (ipq8074 instead of ipq806x)
v3:
- Fix typo in Docmunetation commit desription
- Add items description for uint32-matrix
v2:
- Add fixes from Krzysztof in Documentation

Ansuel Smith (3):
  mtd: nand: raw: qcom_nandc: add support for unprotected spare data
    pages
  dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding
  mtd: nand: raw: qcom_nandc: reorder qcom_nand_host struct

 .../devicetree/bindings/mtd/qcom,nandc.yaml   |  26 +++
 drivers/mtd/nand/raw/qcom_nandc.c             | 179 +++++++++++++++++-
 2 files changed, 198 insertions(+), 7 deletions(-)

-- 
2.36.1

