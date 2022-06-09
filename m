Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C229544D78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbiFINYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiFINYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:24:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13FD1B781;
        Thu,  9 Jun 2022 06:24:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d14so5638272eda.12;
        Thu, 09 Jun 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOp49jraaiqTwhYF0mD/jVJfnTt8MnTWTGqz+xRTGq0=;
        b=d4kQYyM0yvnckDXPuCHW9lAxap+AYxbPdjcG00CMIxwFvwa/g8Lxynqud3+wQGqBLU
         l8a4gAg0NSFJoO6339vafPYusRxUSh6YDbuyRNfn4RVLpOGnfLpbUoik54Z8DTlfZxqi
         6DZukQ43NvrbT3hKz311Ic9q+3xU7uF/NQOO1ocqqS58t5IGbzguWrhy3We2UUerPuOZ
         IiHpqMebjgvBXHOYsvnH0Jw0gDcU7RqdY4DXI0vBpS4+b1dbjEaYrx03NiEXLHnCEhvq
         k8XD2H2ERMGyz2vwABv7WCt1fXyoy/mbnkuxV7lUFTP7pVmvKZagNZY/vpVp7TXCObcf
         YJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOp49jraaiqTwhYF0mD/jVJfnTt8MnTWTGqz+xRTGq0=;
        b=CMc3Y4RiJb9nQTFNCE3F1IcTL7JVheMUpQuv5A4Ez3Taw8fCMBgo9H/UIxfCUodAIK
         4sAfrDSNjyUc+4cOwQ4lu/a/mMr5aaatkCoDiBWF2mtaQxTaw9a9yTRv8OWzbNKUBGaT
         o9B8mTjd1u+XlVrxfMmsegPDTtv1ZveaB8R/BWBsQg2na4WNw8bQmFegM06FUaj17ueH
         9G2mkCFFoVw7KIdIVWvLOtXnurUKpZ1HsNcn/9RvCflEMvH723Zt/Wlm1L9yb+yh165V
         UrwBcIwxDWNP6wIZzxzscj1Lpfsxj81/OR2dZ84a4uNcoTGzI9OmrdZHGUrlgDicRWEe
         5l2A==
X-Gm-Message-State: AOAM531L3h3BiqfXat9Nuxic66YjmCAJwJu2eQHdr0HJjNa832QUOWun
        xCArX95IraQkmJfhkO+nBIN9IDRwBnc=
X-Google-Smtp-Source: ABdhPJw+G30MAFfNqV3/fVSa6QC3D052TECaWZBqwRPk2jH0eVMb5bWimZSB9eMFpoY8YCgWaAEhiQ==
X-Received: by 2002:a05:6402:3207:b0:42d:dba6:8ef0 with SMTP id g7-20020a056402320700b0042ddba68ef0mr45929939eda.410.1654781054042;
        Thu, 09 Jun 2022 06:24:14 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i2-20020a056402054200b004315050d7dfsm8360263edx.81.2022.06.09.06.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:24:13 -0700 (PDT)
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
Subject: [PATCH v6 0/3] Add support for unprotected spare data page
Date:   Thu,  9 Jun 2022 15:23:41 +0200
Message-Id: <20220609132344.17548-1-ansuelsmth@gmail.com>
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
qcom,boot-partitions = <0x0 0x0c80000 0x0c80000 0x0500000>;

The driver internally will parse this array, convert it to nand pages
and check internally on every read/write if this special configuration
should used for that page or the normal one.

The reason for all of this is that qcom FOR SOME REASON, disable ECC for
spare data only for these boot partition and we need to reflect this
special configuration to mute these warning and to permit actually
writing to these pages.

v6:
- Add additional comments on boot partition check
- First reorder struct then make change
- Add additional changes request from Manivannan
- Add review tag for dt commit
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
  mtd: nand: raw: qcom_nandc: reorder qcom_nand_host struct
  mtd: nand: raw: qcom_nandc: add support for unprotected spare data
    pages
  dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding

 .../devicetree/bindings/mtd/qcom,nandc.yaml   |  27 +++
 drivers/mtd/nand/raw/qcom_nandc.c             | 214 +++++++++++++++++-
 2 files changed, 232 insertions(+), 9 deletions(-)

-- 
2.36.1

