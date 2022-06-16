Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F405254D5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347536AbiFPASq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345352AbiFPASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:18:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D26255AA;
        Wed, 15 Jun 2022 17:18:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d14so18379134eda.12;
        Wed, 15 Jun 2022 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuQWYPbc/OKysWG+8KVbbbEGN0Ppij1GHgjiSvnpV3A=;
        b=TCZ+sWTQQYpyTC6odYkDQAf+GiOHnMVl42mduUd0mEhre7BLS8XAum+K/I0rVZAuUD
         N74nIA/78HROu33aNo8D+X5EgMjcBGLbB6SqS/G84zLB0bbBogEYSGnIrKdr9BwABPv3
         tkCi5TTQOb7D1v6SGxWtLfn4SL0+3gYBs0V7my5O6qhoeKz1uIi7qSXZo9jxinEL6Q/u
         icaUfcM/QTuSxcvNZ692w8jh3pReZ6PKhY7zcMQLJLfrjV8dw98v9C/l/gAuGDNi9GEx
         YvX5vwkU51eq/bFqGQQ6k+hE7wj/Xy0iDCQHWKQiMYmaomrJ0PMdjmSfqONXmG0F8joB
         QUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuQWYPbc/OKysWG+8KVbbbEGN0Ppij1GHgjiSvnpV3A=;
        b=TZy/ld2JW9ZrW+3j0Ll39BMQpAiMoc4hG28cQvW+Mr9LjAqKQwM9YymTmjyJs87eQ6
         FrO5a//w1cVveeC7iDKpyn+s4imr+ZLnZH3HsdeaD3I02Gc6+BjnzvVASqaJrgeKIBf8
         QeloKNRQQMhOQnV+I6DMO5dAWjiRG88sn4XmEQ+3N8mYnBLPIAWzvUZfz1X3MWNkO8fA
         37aqVNTgv+wWZdif2gxFZ6aR1hjAS2GGc5ZM7wGUeR+LantpWdpjVVU6zXOY2xkE9ghS
         ynWj2AewMDzklxZ+d+DdwiYghNv8KCiluuQbmFH9cUYTjpLyz46ks5tWvrlK6X3mj2iM
         aHdQ==
X-Gm-Message-State: AJIora9qmzzv0OH5foeBsovejZ5ZgCA6rjKy7Qm/g/ajlDA2OU2m5ncN
        G6q5vRuIZbbcT0O51GgC9Qk=
X-Google-Smtp-Source: AGRyM1sv4BnG3H7y2/HU0FIZfqqfIe0vHANefvBQmQp5YxAoP+7NKwli1Wu65a5aLIJupLmGGL06bw==
X-Received: by 2002:a05:6402:1d4a:b0:42e:9ec8:320b with SMTP id dz10-20020a0564021d4a00b0042e9ec8320bmr3010322edb.119.1655338722204;
        Wed, 15 Jun 2022 17:18:42 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056402270b00b0042e1cbc4471sm542546edd.3.2022.06.15.17.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:18:41 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
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
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v8 0/3] Add support for unprotected spare data page
Date:   Thu, 16 Jun 2022 02:18:32 +0200
Message-Id: <20220616001835.24393-1-ansuelsmth@gmail.com>
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

v8:
- Removed all review tag (sob changed)
- Change sob from Ansuel Smith to Christian Marangi
- Address small fixup suggested by Manivannan
v7:
- Add missing nand_cleanup
- Fix wrong error return
- Actually implement suggested boot_partition check
- Remove unnecessary comments previously added
- Add missing new line in dev_err
- Reorder structs with suggested order
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

Christian Marangi (3):
  mtd: nand: raw: qcom_nandc: reorder qcom_nand_host struct
  mtd: nand: raw: qcom_nandc: add support for unprotected spare data
    pages
  dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding

 .../devicetree/bindings/mtd/qcom,nandc.yaml   |  27 ++
 drivers/mtd/nand/raw/qcom_nandc.c             | 306 +++++++++++++++---
 2 files changed, 283 insertions(+), 50 deletions(-)

-- 
2.36.1

