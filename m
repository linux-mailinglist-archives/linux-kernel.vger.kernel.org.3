Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF458E0CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiHIUOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiHIUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:14:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ECE1F2FE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:14:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q30so15469892wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6Qonm6iaHiCG37E9Vy+iyvt+Lcl9E0+zQmTyp2y5GN8=;
        b=MA/SLCzGbcsdtjX0pFpdjQSE9cMe4j2H3ERl3C2t4PacMtVR90dl1kamzZQEmUtS8d
         nYLjkj669ey764cGjq7aU2h7vm27uhO/cQmglBcIsFmyitGXIidZkhM77jScmlThXvpp
         ELCQDGOfzPnf5Vs3Cymmg7kq1H/eAr+K3X/zzGKw7WDejZ/vkUeJizniuGRwfMzk+RR6
         zEGXVkV6ZbZOKmLlgsfa5Nj+GElHb+uk3SIxu/kQSPCxqwcxuCwJOKvCXs16yppGn1Vj
         OSVk4YiNEkMjcFUpicon95mSOJIzgMXNjdeknuTslak7AHEzrlvmwKDpmR7E+fSg5ufP
         g+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6Qonm6iaHiCG37E9Vy+iyvt+Lcl9E0+zQmTyp2y5GN8=;
        b=rs0cNiuriohuPOovxmAh5HqbOYR0pPakmOFL0RFEvsjuwJNDQcUTVRjJxDRPTqNpL2
         FpR2j/oKFQqkP5ageUQSbIDUqhagwRGyqIfW9nGaR3ehiNhSOx9W1EAq2ClwtuL7oFHC
         C6/rQyrAWPAmgOUh6Q8R2HPOtQLHJgM3NpO5bAoExfeiUaSPwnearTxmBRRaeBfAOqlt
         /Rulr/OYomgVDKgwMLub/78CcbF0dCiHQOzO8AxGfXQuVFOe3TEd8NXwX4yV4FdAX83U
         ruitPMKk6GGxHs+KDeavjDmz6zjih5pNuOOJZgWCDI2rSl8LJkgU6Ft3krGp+OMxDlH2
         mLgQ==
X-Gm-Message-State: ACgBeo2nowuRY3mYxswYbVIjRR8Xcoch3l9i2sil1jVvmyu+09J6EZYw
        Vda/AXL3MTmOlpxJajWcwet8cVzftMiXdg==
X-Google-Smtp-Source: AA6agR6S8ASd/btWcHQaYoP+no/BZLMyuwD9cCluX0U4Jf6RkxELiN64K4xWSUPO04XqbcZj4GNelw==
X-Received: by 2002:adf:f30e:0:b0:21f:afbb:db23 with SMTP id i14-20020adff30e000000b0021fafbbdb23mr15241313wro.490.1660076082904;
        Tue, 09 Aug 2022 13:14:42 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003a53e6c5425sm24041wmj.8.2022.08.09.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:14:42 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 0/3] Add support for Quad Input Page Program to is25wp256
Date:   Tue,  9 Aug 2022 21:14:25 +0100
Message-Id: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables SFDP support for is25wp256. And also adds
Quad Input Page Program capability as its not discoverable from SFDP.

Changes in v2:
Enable SFDP instead of using no-sfdp-flags.

Sudip Mukherjee (3):
  mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
  mtd: spi-nor: add SFDP fixups for Quad Page Program
  mtd: spi-nor: issi: is25wp256: Enable Quad Input Page Program

 drivers/mtd/spi-nor/core.c | 9 +++++++++
 drivers/mtd/spi-nor/core.h | 2 ++
 drivers/mtd/spi-nor/issi.c | 4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.30.2

