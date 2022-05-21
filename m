Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB752FC73
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbiEUMxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiEUMxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:53:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A85675C
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:53:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v14so9634120qtc.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DE/WToa0e5XYlV1QXXvzcE1ao0/d5STyFLpJOri88qc=;
        b=kHvYoXKLcNGtqh6+CqpQmgUBQ4Ejzk2sjSNRF5NaSapKWg0H3zGrgnEDKGniT1xM1m
         j+MnQYeJtCRV7I/gHv8+h7dTizohynfhL4BmYxpDAdq6xc+W0nVgpow5ekbYW4ZoVuxI
         B4khJO3/M2RtBVeezoi0CTwaCNEpWbD2x8eoMXwAanXwRvzMIVlYhYElYjNRpwVXEfl0
         G5iEYRiust1kp46aESktXFzoM+TFmvmvL2Qr+1/UeTWJNS9P5wfQmcjMt7xeKDhXn4je
         hoL73fJY1+9UspigUuXkGt8hrCNpHH22ofDueJwGMBltCS3CFNnsGKtlMozP+NFOB8aC
         bN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DE/WToa0e5XYlV1QXXvzcE1ao0/d5STyFLpJOri88qc=;
        b=Y2kohIfB/CKaQXgvn0VFInoJpJF0+r/bSqZPO5JJyowby2GOKO5/9ruvkCFPfyDdmi
         PJUz6jEof4RNeNApiOK77AHK29vDHmrhAfng7e66eY03yZUIhbenD/1tw/ok7CAoj8zF
         4W3fRBObAM61DdtSobw2AbnIVOTydIShQbzqf49du/jAdq5bd7vRyNKggDVb59YAIuAg
         FGvReLKPL+b4Bey2NarkYS1+gO0k84f3rlSviZwajCzYzaWvswfxocG6kCBEkVBTHLOy
         2VNrUqcxnw/IErHQTE8HwD2pGjeyivD9bVzdSjM50zSBaRu6hp6yoK4nZQUoEnaGnO+n
         OGYA==
X-Gm-Message-State: AOAM533KAqYVqiachMNLxU9dqz4Al/qR9FsBeC9qHNEL0me01R7OeldA
        8tYVrepmtwIMcxux1ZByAVuBZ2o+RE4=
X-Google-Smtp-Source: ABdhPJy9/3Qcn1P8r3hcgv6xlr+ig6EwRIHDfOTu6g7nSrtOwjPk5tp8RSaHAISsfXO4RNLQk9M7Iw==
X-Received: by 2002:ac8:7d07:0:b0:2f3:c5eb:61a6 with SMTP id g7-20020ac87d07000000b002f3c5eb61a6mr10881514qtb.231.1653137624518;
        Sat, 21 May 2022 05:53:44 -0700 (PDT)
Received: from Sassy (bras-base-oshwon9563w-grc-26-142-113-132-114.dsl.bell.ca. [142.113.132.114])
        by smtp.gmail.com with ESMTPSA id g21-20020ae9e115000000b0069fc13ce22fsm1323278qkm.96.2022.05.21.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:53:44 -0700 (PDT)
Date:   Sat, 21 May 2022 08:53:42 -0400
From:   Srivathsan Sivakumar <sri.skumar05@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rts5208: spi.c: clean up dynamic debug code
Message-ID: <Yojg1nXXTIL3G82l@Sassy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've condensed the three dev_dbg() lines into one as you requested in the
previous patch thread; and sent them all as a singular patch.

fix the following checkpatch.pl warning:
WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Srivathsan Sivakumar <sri.skumar05@gmail.com>

Changes in v2:
        - Condense three dev_dbg() code lines into one
---
 drivers/staging/rts5208/spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index f1e9e80044ed..ea736a73e58c 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -460,10 +460,7 @@ int spi_set_parameter(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	spi->clk_div = ((u16)(srb->cmnd[4]) << 8) | srb->cmnd[5];
 	spi->write_en = srb->cmnd[6];
 
-	dev_dbg(rtsx_dev(chip), "%s: ", __func__);
-	dev_dbg(rtsx_dev(chip), "spi_clock = %d, ", spi->spi_clock);
-	dev_dbg(rtsx_dev(chip), "clk_div = %d, ", spi->clk_div);
-	dev_dbg(rtsx_dev(chip), "write_en = %d\n", spi->write_en);
+	dev_dbg(rtsx_dev(chip), "spi_clock = %d, clk_div = %d, write_en = %d\n ",                               spi->spi_clock, spi->clk_div, spi->write_en);
 
 	return STATUS_SUCCESS;
 }
-- 
2.34.1

