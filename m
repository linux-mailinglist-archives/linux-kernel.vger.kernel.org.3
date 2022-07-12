Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C8572119
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiGLQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGLQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:38:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4F111
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p4so5063299wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8lmaZ4yA3N+2Tr9olz+V+wBzdb6zjpc/4YMVJzfPW4=;
        b=P0DNVxXKag6AgXtprOy4l7YJS+89wlkyKE8K5SVwi923xmsQEAFaRQ536opF/PriyL
         dMbDPB26jWtM2oJpBaHUDyqNMhoTHZebb1fke2X6jIHihDjY5vCBlDylOQ9cdK11lqvX
         krikO6mEqD4tBQJXEucsgXFDvcrnAiHhvoaFU54BiW350VmkfsaPpltXivRzagOWtr6m
         Lr/vy87lmAxMrxn5D2TFgX9XWKvu8ltd4V1zt0q4sJ05MHUyfpbQ4pvHYM+n3cjay5UC
         /hoEfRJgit4UnZtjaoWdmkmXgMfkxF2Z8L2Hkib/PK/CwYjwDlJDrC6QdtJ78CzenIpY
         JhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8lmaZ4yA3N+2Tr9olz+V+wBzdb6zjpc/4YMVJzfPW4=;
        b=KJthHXfwhhm+ZTAoMBGwo6Jem09tlsUm4ZHBsxobm1kh3eptWSsorsQPZFihphsdz3
         cCVQt2yJwT0AO+nXIvWRJaT0Ex+4veTerOAbn4rpC8vLE50hOxnAFp0715MsvxBIE+pC
         bf1y2o/XPWoZyWC+M8nenTIB3GB1rsFXucKAxycwPmKyjS1TNHXcmE/FDApxwD+JeahH
         +I20HFlw2gEnLbAWCgvfV56wpdKVpbYqdXFaa6R1iufZXvvvACmj5D4/wngaIvphMtn5
         IVDaR+FEsxr52cSMqynkNJh8p4APPTLHIeIOYAjwfRN9u1GdW0q/B0EQT8U7eYtJjYKb
         X0hg==
X-Gm-Message-State: AJIora/bKJhjEfTFSmwKYyW6yRcCj1I7c5YdqtjGm86fQhNv7flMVvDU
        tv3XZNy5FahaILO8jNSjIjfYDQ==
X-Google-Smtp-Source: AGRyM1vvLeGSg1PfQa4JuYMksqO5aPjsbFbmxqBm+Y4FiwMSJVxequXnCmAnrqvUh3WpMx/2snJuLA==
X-Received: by 2002:a05:600c:1993:b0:3a1:918d:671b with SMTP id t19-20020a05600c199300b003a1918d671bmr4688804wmq.14.1657643910288;
        Tue, 12 Jul 2022 09:38:30 -0700 (PDT)
Received: from localhost.localdomain (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d424e000000b0021d4d6355efsm8623751wrr.109.2022.07.12.09.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:38:29 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 0/3] Add Quad Input Page Program to chips with no SFDP table
Date:   Tue, 12 Jul 2022 17:38:20 +0100
Message-Id: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
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

Some flash chips which do not have a SFDP table supports Quad Input
Page Program. One of those chips is is25wp256, and this series has been
tested with that chip. If the spi controller supports quad mode then the
chip can use Quad Input Page Program to give a much better performance.

Sudip Mukherjee (3):
  mtd: spi-nor: extend no_sfdp_flags to use u16
  mtd: spi-nor: add support for Quad Page Program to no_sfdp_flags
  mtd: spi-nor: issi: is25wp256: Enable Quad Input Page Program

 drivers/mtd/spi-nor/core.c | 7 ++++++-
 drivers/mtd/spi-nor/core.h | 4 +++-
 drivers/mtd/spi-nor/issi.c | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.30.2

