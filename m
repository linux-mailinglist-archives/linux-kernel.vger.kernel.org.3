Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76E56B14F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiGHERW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiGHERT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:17:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F426127
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:17:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 145so21347221pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNbzz6HqiT+aecUMfuE4HCVdk2tTR9rWqUJn0foYaOs=;
        b=oY7JqxN2PctvkKLjoYKFZyyXgicFmSo0BLEeEtO+de9X5TF3XFOdIHs2BRhVNO0+0e
         Wl+au6rKUin2DCSdQVaGmM605EOjQ38w7auKF7EAXjqgG6eZXyVfk6jJZXgH5hGOKIoA
         Iu20bdc2ZsNp7n0PZje8YFi2fCYvRVXOiKkiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNbzz6HqiT+aecUMfuE4HCVdk2tTR9rWqUJn0foYaOs=;
        b=DspOfqo2FMkwZ6FQre8BUnU57LEw4s8lyMK4GQZWIA1XT5AZMG7GcxjHneWVxg1QxL
         tpDMKYZFBUzL76daHAbZ2LJIrAOob8Aj/ik3wWTTF1gvbYik+Al2GrR9vzZH7r232VPD
         QErwrIsNabZb60eD1sra2oY8MOHWtN9rbRQClB7x15MprbJmhMOp+LGk1VfvY9BLUvpe
         62mJ+4FMv7qEP/ied+g6463DIqBryvkwbFNF9GXdIoKmJoqSjXfw6Bzjvw6UkPWb9tJ5
         xM0b6b9cWOE1pFzu5RlTNXS9H2ypAd7LreAZwmJaeEhZcEtP5jKFoWUeIxWO1sID9Ou+
         PbDA==
X-Gm-Message-State: AJIora9NJcmY/adub6e4cNWA3IYxB2MlR8Ct1LUN6cgPOnS8wKbhKu5J
        CWAz5WGZtEIxzmcwwUIcc0Tf6w==
X-Google-Smtp-Source: AGRyM1u3YRxbpHHoAR2gLio3os223bzxP+inwrZHFd21UtN01SzXjzuwNuJq0VZUjYZDjiasTgFdLQ==
X-Received: by 2002:a63:1759:0:b0:40d:5aba:4bb0 with SMTP id 25-20020a631759000000b0040d5aba4bb0mr1512690pgx.496.1657253836714;
        Thu, 07 Jul 2022 21:17:16 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id kk8-20020a17090b4a0800b001ef899eb51fsm435629pjb.29.2022.07.07.21.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 21:17:16 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: ufs: ufs-pci: default clock frequency for Intel's UFS controller
Date:   Fri,  8 Jul 2022 14:17:07 +1000
Message-Id: <20220708141612.1.Ice2e8173bd0937c7c4898b112350120063572269@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM platforms rely on 'ref_clk' of a UFS controller's node in DTS to set
up the proper bRefClkFreq for the UFS storage device. The facility is
not available on x86. To circumvene that, default the parameter,
responsible for carrying the value to the UFS storage device
initialization, to the one that Intel's controllers support. This is
required to support provisioning of UFS storage devices from userspace,
without relying on FW and/or bootloader to make the necessary
preparations.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

 drivers/ufs/host/ufshcd-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 04166bda41daa..a6f9222cbea74 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -336,6 +336,7 @@ static int ufs_intel_common_init(struct ufs_hba *hba)
 	struct intel_host *host;
 
 	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
+	hba->dev_ref_clk_freq = REF_CLK_FREQ_19_2_MHZ;
 
 	host = devm_kzalloc(hba->dev, sizeof(*host), GFP_KERNEL);
 	if (!host)
-- 
2.31.0

