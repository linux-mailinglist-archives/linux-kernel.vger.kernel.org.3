Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9D52DD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiESTBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiESTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:01:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD8286ED;
        Thu, 19 May 2022 12:01:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so8417876wrg.12;
        Thu, 19 May 2022 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AnHJhI+ziwlPwu5NQv9qfEIlA0yv7rIa46hdD1NJODM=;
        b=ZrADJC4tGLoNcGAx8Qx4Eb5CgbinQIveNghZ//NlZ8fWbRVGQ7LKm7TcI5hQhWwtIi
         CWxfO5AbVAJwpI1Vck1+m97SJaLJFmWp9HxcucF8wENR1bYBt4ZvM9eiT8PILEnjX1iz
         CR69gxZYZTZ0TdSPFAjmvTGRgWYczpVOkphmgREswSfNdrDeN4yKoqPjMnFDCX6E27Il
         yqIBAKkdVQ5/ONOLwuQlQk4lnDVyF/iLieKy9sjvEX3K/Zv3xIP72WPpV/21SzBnVqil
         Fx4bQKv2B5OhD9uENiKov8Co1Tufwqgbe8PQgh7qWPXXBkH90kFUWbbeA+qMBRqO0Ttc
         Bx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AnHJhI+ziwlPwu5NQv9qfEIlA0yv7rIa46hdD1NJODM=;
        b=FNVBhAUAOs/E9KMByFocCWNLp98FTebuYAC3L0Pdpm2eDd9bKzGSX19ToOVR18pugY
         OBtwCebua4Xdq9PDHpNTzkFOTzvSjbGDHvvm9GDmdloR7YsDXPtYQz0qZd4urNSv0TOb
         i0/NcflDhb7VnA13ykyB9DWSxPpyqbPxZ7ogwWdAQpMMXBMRW32Spksf242iUJ1ffSQP
         w75ni9ql5NfW4z20VM9MuVENogzyuU4+q4xL9hO85Jc8u1WwU/i+z0Cyg65qtWXxesWs
         72nKRkY9gxvPGVq/x8lQ3BQz1SbqfyyK0ASUTUOcfYetkCN3nofAdEiJOiyeMbuQLMdj
         iI8A==
X-Gm-Message-State: AOAM5333FZxmHbPbdQ/URFrHtN+wt15ZMw62OEGUojuuiBIWxi+HV/7k
        PwpnXXjM9xExLidwLDpjjkZAqAylusM=
X-Google-Smtp-Source: ABdhPJyvhOD959sAuMcgvEsVvIrvXhEaFh8Ke8XoUH7NYV+vpHFVBmrCAta15kxCI5oIdxA6psDWsg==
X-Received: by 2002:a5d:47c5:0:b0:20e:73a0:79a0 with SMTP id o5-20020a5d47c5000000b0020e73a079a0mr1901351wrc.632.1652986885110;
        Thu, 19 May 2022 12:01:25 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c414b00b00395b809dfd3sm333767wmm.12.2022.05.19.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:01:24 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add support for unprotected spare data page
Date:   Thu, 19 May 2022 21:01:10 +0200
Message-Id: <20220519190112.6344-1-ansuelsmth@gmail.com>
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

v4:
- Fix wrong compatible set for boot-pages (ipq8074 instead of ipq806x)
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

