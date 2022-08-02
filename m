Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679DC588166
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiHBR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHBR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:58:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3538F222B0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:58:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m13so14869607wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5VB2FOmZFu7Zd41ltdFac1q4e5aLoaLQgroB4OX9/s=;
        b=aamoHvNa6141WrHA4zpN7rbydohy1lauVLA0F4AswnJ6fgLWB2VPeU5WlX7+7en22D
         VpNOl5B7V/AYoUbgHVnx1jiDfjPg4lK7SdoXvUKo6FT/rYhP9g9qM/Qw2bQB9Bn2PyuR
         JjxhBUpDiomTg1xNyyL3WrCak0hUXuCIwTS0sCZpZlygha/idyNKAYA0BDKkBOOR8mxA
         EczL8nhi5U2gTrW+XW1GS/S+QyS05o2cNw0Q8+PslQfalu6SzOYxXn4tFf5ql/eBmjFo
         zcEE87sC6W2K+01GTE8NqeMXZ6VIALDc4dmZVLwgvUG76wYSelhiqGO0iYME2P4ZfSf5
         Sf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5VB2FOmZFu7Zd41ltdFac1q4e5aLoaLQgroB4OX9/s=;
        b=uD64EGCrtoembQm9m6FH9wM2U+5tnzTgloCojBapDqZV8a78L+dgSiiqIxoZJmE2PF
         BZOgaiUuj6dyd18RUYiVj7MFIVlwiRsDrflKvJodOhcZBWk9jyM3ctSukCIvc4egDHyu
         ntH8c/NZnV4u2ylMp2llaUaVBSCXtYCwzFy+rvqpo9V2mf4Ya7lspG7De7ITSxilFNoj
         TzxyWdViRcE1t1PV/Fg5KQB7fNjQAI0OPUwcsO+TDCAV0FqnFua11FehEzf3NmCN/FAq
         ahjRY8mQ4Gq1I+xbsEkQa1fkSJJtwHjr1UJHE9OPCro2VbSaeYjJadvdFEvm09P/6g4b
         lQbQ==
X-Gm-Message-State: ACgBeo0G2RzBEgsMZmgCZKy2TO1uk08rIw+G0FRTfH7aezwDAr8c+eiv
        zYaj71fpGKnaJkcPoNqRFhSfmA==
X-Google-Smtp-Source: AA6agR6rAMlfiAvC3j2BDeH7AB7wHWhuUx276d06qGtylAw+ckAidJAvLeFkbbt7zeFLNcua1pXstQ==
X-Received: by 2002:adf:e6d0:0:b0:21f:156d:1a8c with SMTP id y16-20020adfe6d0000000b0021f156d1a8cmr12685521wrm.177.1659463096802;
        Tue, 02 Aug 2022 10:58:16 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:16 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 00/11] Add support for enhanced SPI for Designware SPI controllers
Date:   Tue,  2 Aug 2022 18:57:44 +0100
Message-Id: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Synopsys SSI controllers support enhanced SPI which includes
Dual mode, Quad mode and Octal mode. DWC_ssi includes clock stretching
feature in enhanced SPI modes which can be used to prevent FIFO underflow
and overflow conditions while transmitting or receiving the data respectively.
This is only tested on controller version 1.03a.

Ben Dooks (1):
  spi: dw-apb-ssi: add generic 1.03a version

Sudip Mukherjee (10):
  spi: dw: define capability for enhanced spi
  spi: dw: add check for support of dual/quad/octal
  spi: dw: define spi_frf for dual/quad/octal modes
  spi: dw: use TMOD_RO to read in enhanced spi modes
  spi: dw: define SPI_CTRLR0 register and its fields
  spi: dw: update SPI_CTRLR0 register
  spi: dw: update NDF while writing in enhanced spi mode
  spi: dw: update buffer for enhanced spi mode
  spi: dw: prepare the transfer routine for enhanced mode
  spi: dw: initialize dwc-ssi-1.03a controller

 .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
 drivers/spi/spi-dw-core.c                     | 288 ++++++++++++++++--
 drivers/spi/spi-dw-mmio.c                     |  10 +
 drivers/spi/spi-dw.h                          |  19 ++
 4 files changed, 291 insertions(+), 27 deletions(-)

-- 
2.30.2

