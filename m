Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04718580A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiGZDtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiGZDti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:49:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548752980E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 20:49:34 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h132so12093911pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 20:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OeG3shfDltphYsSXUVO2yZlivCYznbwaGe0X6RqjkI=;
        b=37qhK9Bhn1qiGpmG4CWEWGKbTbOqHNBEpJpgV/5bqzvXYxYNfVlIBtgJGFztFIS+5T
         GkGHxjPGYwcvbk73I9MEIoeWHRdqIjDqkbxauFDCx53WRu1vZwraQlv8RXypCQ/vvZ48
         CElmBIaNUbIBHITNH/Bpuk8gRytuuLf/V+bQfTTVZ0MTesG5SdjNh030Vwxkt+NuzPfK
         Mb62T1yB8E/Up2JVipVOKnA7Bzj+F+yXzXayVxyhFxZig/MNx19js/xEZ0uSDXaUchA8
         MhTEQgxvkaDM/lpEopOiL80CyFUTg+CRFyVdq2HrItgy9WVfzAgFV1Iqro9yetBitc61
         U1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OeG3shfDltphYsSXUVO2yZlivCYznbwaGe0X6RqjkI=;
        b=X/A3C49mW2/23Tm00FovgtMepqPqf9W0PcPlnl2F7J+3r9HpYpkMGPZx1WhSBNKAjy
         d3eto7sU/Kkkkij1U+ZD+/GonM18gF5iB5Ptgq80xL+4O1rYrIcuZ0Zq3vT9HQJl6OGf
         MOMAeQC0+IhjSCh8ToJjacqfqwxiCRaZP5vNwT6vMlwgTkj737s5q5LrcHELJ79Eni+j
         zjbCIUeWwNawRjXkevaKF46IdBFZ2RNp0oxuu/E3bVyAHTqz4+FWU+O+vvSR+6ShO3lA
         6c1hUFipiybYUSABLLJLKZ8Vj5a5NqXOCTlNKj/pVonThKfq6ZKjhcPpJsTvaRH7lvGA
         C1AA==
X-Gm-Message-State: AJIora9g8wXUGAsQvYiShoxXiEUuRhAyGnlRHE4/bANReArnaWQWyS/9
        q3tVwJ6E0amjUqYmOlIl2lyBmg==
X-Google-Smtp-Source: AGRyM1s8NPWk6uPN7MO1gXTXN50qbPxl/yLjEX9Etam/Gi4XDgW9vTeNog9ONfPI/pfHeiNHwO522Q==
X-Received: by 2002:a63:ae03:0:b0:408:b78c:e284 with SMTP id q3-20020a63ae03000000b00408b78ce284mr13270424pgf.401.1658807373862;
        Mon, 25 Jul 2022 20:49:33 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id mh11-20020a17090b4acb00b001e29ddf9f4fsm9866214pjb.3.2022.07.25.20.49.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 20:49:33 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     wangzhou1@hisilicon.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     chenzhuo.1@bytedance.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: hisilicon - Remove pci_aer_clear_nonfatal_status() call
Date:   Tue, 26 Jul 2022 11:49:26 +0800
Message-Id: <20220726034926.4806-1-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to pci_cleanup_aer_uncorrect_error_status() have already been
removed after commit 62b36c3ea664 ("PCI/AER: Remove
pci_cleanup_aer_uncorrect_error_status() calls"). But in commit
6c6dd5802c2d ("crypto: hisilicon/qm - add controller reset interface")
pci_aer_clear_nonfatal_status() was used again, so remove it in
this patch.

note: pci_cleanup_aer_uncorrect_error_status() was renamed to
pci_aer_clear_nonfatal_status() in commit 894020fdd88c
("PCI/AER: Rationalize error status register clearing")

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/crypto/hisilicon/qm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b4ca2eb034d7..fc11e17abbfc 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -5431,8 +5431,6 @@ pci_ers_result_t hisi_qm_dev_slot_reset(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		return PCI_ERS_RESULT_RECOVERED;
 
-	pci_aer_clear_nonfatal_status(pdev);
-
 	/* reset pcie device controller */
 	ret = qm_controller_reset(qm);
 	if (ret) {
-- 
2.30.1 (Apple Git-130)

