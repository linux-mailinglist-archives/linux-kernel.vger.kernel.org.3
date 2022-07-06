Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5175684A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiGFKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGFKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:06:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BA25293;
        Wed,  6 Jul 2022 03:06:42 -0700 (PDT)
Received: from localhost (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB715660199B;
        Wed,  6 Jul 2022 11:06:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102001;
        bh=0Vx7w+A2wpneNiu7FdnG/JSWCVbPU6JgE7qD9xE3/Jk=;
        h=From:To:Cc:Subject:Date:From;
        b=hlRsQMTmANFWprjVUrKnscQp5SQvpIUomWNL94+r58JY1zXjb4Kuva7WHF1UNkvgf
         L6NadiQgVhNIIdoiz3SZLdC9tMwoif7rEGY7XoBItwEeWBgTg5h3It0BM9984Ah01B
         EXsND9dK3PzkaKhMAkcbodPbCO0j/bpHn4ExPKcyvO1QTyFNH9LCoJeCCPAHIgH89L
         Ppfe7QLGnuhrjxdGvK2Oukppgc+8rftR8JhRwLm7hxHqJx73TQ4GBZZmseogYTmISa
         ZGP0EQxGiZOQIQQW8MiapTdVYG9c6M0MFYlzxPA4zxLrm60BdLsiC2Cse3qgmg8a9x
         wBZs1RIDsqumA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Anastasios Vacharakis <vacharakis@o2mail.de>,
        cristian.ciocaltea@collabora.com
Subject: [PATCH 0/5] AMD SPI controller driver bug fix and cleanups
Date:   Wed,  6 Jul 2022 13:06:21 +0300
Message-Id: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses an issue in the spi-amd driver and, while
there, performs some additional cleanups, like simplifying the error
handling in the probe function and removing an unused struct member.

For improving code readability, it also adds some kernel-doc comments.

Cristian Ciocaltea (5):
  spi: amd: Limit max transfer and message size
  spi: amd: Make use of devm_spi_alloc_master()
  spi: amd: Make use of dev_err_probe()
  spi: amd: Drop io_base_addr member from struct amd_spi
  spi: amd: Add struct and enum kernel-doc comments

 drivers/spi/spi-amd.c | 53 ++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

--
2.36.1
