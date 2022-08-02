Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431805875F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiHBDaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiHBD36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:29:58 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CB220E7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:29:57 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id c12so3446432vkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0OeG3shfDltphYsSXUVO2yZlivCYznbwaGe0X6RqjkI=;
        b=EU7FRMol2oZb8rxXgI4zEUJOXkVWUo/91fIoGU7Z2xS4hMCSYL4MX+SDkyHUQahCkX
         F0YLwFAUY62SuL6wbqVd0iwaKzavQqrBOjiKVa+mddt/8dfoA+4eZ9ts9PpaP0GGIeSB
         CaPU77OHQArUbz+pWCh3rMBB4yU4Nz2sgHwSbyXwyD5DNnjmej0rxVBUHYmMJhJtYeHb
         mQmPqF0GiD33M3I9fkdGJ2OZ2CqiV3tU1pP/Os++5LxVpE0QBJlb6ZyrcKP8rDvhMKmP
         sw5T/2mQy/EtfifaVX0UXfVUB0sdxPM9D8KE8kI+i5WxbYscp11O0PcyA66KWX3Gf668
         WxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0OeG3shfDltphYsSXUVO2yZlivCYznbwaGe0X6RqjkI=;
        b=Vn0TX0Iz6rhHLjGC1nu8VmDEUjoh1yvxdbe4aDShjbG2xoGpUnpvYRr3hoyQWgMmOP
         XA1u8nN7qn8uN5bb7TBNwxDgo0roV7olkldaFhs+6BwHKdziQ36HsrbBbFWyqD2uNSaG
         29En5CBY3qC+hBC7mu9kVr9ItmaC6gr/kEuZQdfGhLyZbs8Eb/3AIwQTwzD0upTXKTbe
         onVUXS4ESjVvNoRbZGjDbpy5EgVPBwBi3Z5ZqrERt0FYnKWezI1ii50hMFBPZb/yVu5N
         c4Ah/pd8fiOmjcxo8o1RxjvCUrCMBOFi5VPr9N2R8CR0X9yCUFUlQmh6TzgUKFSdFWyp
         89Dw==
X-Gm-Message-State: AJIora9jw7GD63RiclsFjhkR52UuwgVKuI9o4zVCNdGnbXeLtv1kbExe
        dqVLe1nt6nmJQ+ndpUmjv5Q5RZK531IcAN0W
X-Google-Smtp-Source: AA6agR57o6Xc13fPW4A4+k8d0xGrSl0ws4HnUEn9veeLE0b5mTFHy+E//FCCnvfhHVb+9tjXlGkIHg==
X-Received: by 2002:a17:902:f787:b0:16a:1e2b:e97 with SMTP id q7-20020a170902f78700b0016a1e2b0e97mr18686767pln.27.1659410985435;
        Mon, 01 Aug 2022 20:29:45 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id 139-20020a621991000000b0050dc76281e0sm9433003pfz.186.2022.08.01.20.29.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Aug 2022 20:29:44 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     wangzhou1@hisilicon.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     chenzhuo.1@bytedance.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] crypto: hisilicon - Remove pci_aer_clear_nonfatal_status() call
Date:   Tue,  2 Aug 2022 11:29:37 +0800
Message-Id: <20220802032937.27117-1-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

