Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49365A9ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiIASSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiIASSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:18:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AFD7B781
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:18:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l5so14035927pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3DXCPe1BdEtYuRHvCYZXZkquoUJcR5dxO1Uv98IS8Fo=;
        b=Aehod6L+M3ml0QOxN7x+0w3h0/6goHcKiCZebMRRRooSJP64c5JGUMmT0Xs0eXcJQX
         KAebQ+kqsEsjzxwwCuCi+sTSZ9ePGDRJ4Ke8LtzrvIc85ZUFTKXl6caEY+cTLN//OYSf
         0QqAgptsvqA+mNuSroupv9lAYWD/oiajx3bhNgTGjKE+5FJqGpp5hl75V/YPuX9vsEwJ
         H9pYqtwIfWdmAJsRJBDrKwHc/OkPFAj95m1JVMfBleKx9eJGlDea3htyn18Jqhle3msk
         1aFF1ndcoISes5UYjaPU1OELeWO86cea/I3zJ3XNGnx8Nc3DA33tRGi9jv4uXcMiqB7J
         p+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3DXCPe1BdEtYuRHvCYZXZkquoUJcR5dxO1Uv98IS8Fo=;
        b=A8kxaSfMeArJtOFgNZrhoE5ZuxmylFftEbC+chND1mSESCoLcy0IP7SFQEoP49xFqA
         BNUOK7qBGmvbhOx4t2dOxOhPVRjnGFZHMJkJlknYY1gOYNPlamZOjS8Jx4HCz+mq/b97
         gOhmNnoKkEb+Y5Zf16ThxNxL8yoUF7FgF0q7yh2pwnjS1rloHqS+di3HPXcfasduPazp
         tR0olhcM62VuCTOcJDp1PRQrNtEZEvnJ7eYGFzJ3Qeuf+S2+oQ0QxmjOarhy1S2YiECQ
         A4R1nvoKCozFdttlVl2PVgTsmW2tXftT1vsJiYX1Cpt1D+iqSH4/4OPo0UthsQI2B+LY
         Bj0g==
X-Gm-Message-State: ACgBeo0S2D2//FzhufH7L1gt1+n8llksf1m9iBEzdBFher0k8acztkPr
        6idEHuW517g39blhReoA91LCUw==
X-Google-Smtp-Source: AA6agR5k3r5xfxPxjuPBt32QIykPTxBunw1TVl9SKzFPTIijRtI9vvEivAH4/47P1EXXXpyDgDMWRQ==
X-Received: by 2002:a17:903:32d2:b0:172:f62a:2f33 with SMTP id i18-20020a17090332d200b00172f62a2f33mr31495269plr.16.1662056281071;
        Thu, 01 Sep 2022 11:18:01 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017519b86996sm6320538plh.218.2022.09.01.11.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:18:00 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, bhelgaas@google.com, ruscur@russell.cc,
        oohall@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] PCI/AER: Use pci_aer_raw_clear_status() to clear root port's AER error status
Date:   Fri,  2 Sep 2022 02:16:34 +0800
Message-Id: <20220901181634.99591-4-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
References: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statements clearing AER error status in aer_enable_rootport() has the
same function as pci_aer_raw_clear_status(). So we replace them, which
has no functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d2996afa80f6..eb0193f279f2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1287,12 +1287,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
 	/* Clear error status */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
+	pci_aer_raw_clear_status(pdev);
 
 	/*
 	 * Enable error reporting for the root port device and downstream port
-- 
2.30.1 (Apple Git-130)

