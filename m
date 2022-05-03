Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4285188F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiECPtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbiECPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:49:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C785015FD7;
        Tue,  3 May 2022 08:45:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y3so34176882ejo.12;
        Tue, 03 May 2022 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mINKKACEUSc3nz+5DZb97F3BUF/I57s2OxAWUmNfvkI=;
        b=CtOHYiswVqrgLZHaIvLLcJVTDwKunZ3vcO9GDZyyGL9OsouVQRjUzC6okDPrLMMbO6
         cjmw+dSZidAG0zEKjylz97DYzb8FWeO/vgwz53Ctd3iFpMR7we5kKNOo3hHKWukX/tE/
         LogxrcMw+GHPD5VEDuWKkRpR7zIuMm/qUVLehApFmEpx8BPQAB5kcQeVJtLuucse9QYK
         6pbwUHVFPAUgXvkc3up19qOfM/cdb+M2GE8a3U1SqYufTaWOYZi0UlnFmxEJD2UuqZN6
         hubN3Rs+FlvRh2uOPAwGu3W8YYd6AQvuLx847bUhukuqPG2F4hSUuF3DsEAddbvLVbEG
         J8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mINKKACEUSc3nz+5DZb97F3BUF/I57s2OxAWUmNfvkI=;
        b=v92WvXWDfjZ15PXZAbdraxmRU2CcCkGcUXCRWQ/4m536Yw74OYu7Jg8PLMMcjFDdhZ
         RUnIP+QEwfZH89542kYNScqJ7vWuaJYnUuw5Q4GNzzsYWFnt79jKIvYOWHi6GO9/zsdx
         A60549kh5zYfSLj1jKS6IFadK7RATXWHtI4cKWWyQJ+ubOFx+A6+T1YHLLjGPm9RY5vi
         NGV3R8hq7U2IZWxpwd0pALgeP4XgGZ+Hf15Lnaj8nwR1xtU6D4fiZFQ2kO0SKvSzrwwD
         LU3Ssbn5Sc7levth/pbtrEam6MUlKkTL5nrZRztNU8vO36/CV/SGSup2X01hSC4d6s1s
         iAUg==
X-Gm-Message-State: AOAM531fqsB1UDpLqPeHtebr9mRBA7cU/FEvhH3iFWp/Lndj+Jl7dziF
        bChU9mdKnecZxiKbgNDJcVc=
X-Google-Smtp-Source: ABdhPJz02pBN9VWvWZakAo8EyGCtLIpnR5f9jaXZwXt64fPpWKFXYnVJ/WyG4ipB+qpc5sSjErRu3Q==
X-Received: by 2002:a17:907:3c81:b0:6e6:cf3e:6e14 with SMTP id gl1-20020a1709073c8100b006e6cf3e6e14mr16468035ejc.181.1651592729117;
        Tue, 03 May 2022 08:45:29 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id zp26-20020a17090684fa00b006f3ef214e62sm4723961ejb.200.2022.05.03.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:45:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 0/2] Add support for unprotected spare data page
Date:   Tue,  3 May 2022 17:43:51 +0200
Message-Id: <20220503154353.4367-1-ansuelsmth@gmail.com>
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

v2:
- Add fixes from Krzysztof in Documentation

Ansuel Smith (2):
  mtd: nand: raw: qcom_nandc: add support for unprotected spare data
    pages
  dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding

 .../devicetree/bindings/mtd/qcom,nandc.yaml   |  22 +++
 drivers/mtd/nand/raw/qcom_nandc.c             | 148 +++++++++++++++++-
 2 files changed, 165 insertions(+), 5 deletions(-)

-- 
2.34.1

