Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1454BEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiFOBAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiFOBAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:00:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74831204;
        Tue, 14 Jun 2022 18:00:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so1409491wms.1;
        Tue, 14 Jun 2022 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPvBp9veaI5j0wgP4lRzxiv/jhtEdPHh86ZsvlYvvWk=;
        b=O7y6uYU90jqfbSNsTlB0repg3747h+1OGzpcLS4p+taxXQ5mOoROD0ZrA3BKx03zIh
         x6ic9bG67oR+Hn4CGjgDcNqHiOC1tB3JyY29deWjKNBDHi0Lny+1JVxdDL86Q3Z1rXiG
         sPYC7Ll4cn5tP5lROYF4yzgUHRrcQyeG3Gdg1dk2MNnKQnQ0Msk06mz3FXXlvWZ1J4GY
         prQZyIxlRvgnx7sJ3KxZoUp0BuehOivPlpd8KKjIo1otZ+NNY3lK2Qx/6Dzi6BMoCMtp
         JXHJ0hcQ9NB+b+WLrURFuEOXMHU0p9m05lhAWwrf609ux7FjMyOE37F2yV1z+lGaEJoy
         qNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPvBp9veaI5j0wgP4lRzxiv/jhtEdPHh86ZsvlYvvWk=;
        b=bqNRse/kNXgI0VqatyZh5SJEiPH9lQG3/3lVXcqOfpfaE+uNHYdQtN0Fvz/pd7gVR/
         gjDKuSxP7Bj+qB3Kf8px8WcUxUEMCzL2Efi8Mwnp8ctLvIw5UzBhWDPdp5NRFlyY6Rz5
         DU/1h1ONuRp/1NfoqAnKUNWyhylfvzfvTAUGdSK2hoS4cElZbfU129Wt08euESTTfx5J
         BQO8IBz8x0bzxnJGk81+uuywRbX/3pIvE8uE04CZhGF3fC9zjajRKtcDWf9gneg/Vb3N
         VBBQqxTaD0spaYq4xNG9X/dXGcyqAQhM0C4nzuLqbo7j0sOiz9zAOh15Bx9E69o52qmk
         P1zA==
X-Gm-Message-State: AOAM531huv0i/Sh53OaBlSjRXMZR37LZpVSzgYE1IRY3MfT+r8YwfRLD
        l8KQtwgYi9FCmtSQfv6et58=
X-Google-Smtp-Source: ABdhPJw3nsHmOWgcV01ICc1xywAOTPzXiduoEAOuXtfuR71IxR8yM0wuWt2OnffiABSLJTmMf3RyFQ==
X-Received: by 2002:a05:600c:a47:b0:39c:7ef8:ed74 with SMTP id c7-20020a05600c0a4700b0039c7ef8ed74mr7054487wmq.160.1655254805268;
        Tue, 14 Jun 2022 18:00:05 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id g10-20020a5d698a000000b0021020517639sm12890265wru.102.2022.06.14.18.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:00:02 -0700 (PDT)
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
Subject: [PATCH v7 0/3] Add support for unprotected spare data page
Date:   Wed, 15 Jun 2022 02:06:09 +0200
Message-Id: <20220615000612.3119-1-ansuelsmth@gmail.com>
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

Ansuel Smith (3):
  mtd: nand: raw: qcom_nandc: reorder qcom_nand_host struct
  mtd: nand: raw: qcom_nandc: add support for unprotected spare data
    pages
  dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding

 .../devicetree/bindings/mtd/qcom,nandc.yaml   |  27 ++
 drivers/mtd/nand/raw/qcom_nandc.c             | 310 +++++++++++++++---
 2 files changed, 287 insertions(+), 50 deletions(-)

-- 
2.36.1

