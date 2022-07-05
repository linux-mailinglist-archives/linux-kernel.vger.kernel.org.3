Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722CA56636D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiGEGxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiGEGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:53:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807212641
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:53:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 67so1036712pfy.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eNaY7c0YwJ/R0zBgjZVAVLdZXo+kCXJ/VuomQlDevs=;
        b=f4PP3EBCNydITxRlaj9nRNf92/D2xYVaxMBKIUs0w+w4J9Z2bgxCcqhXMSIPhmF7pX
         hHk2rVW8C9AOKc27TCe67oF3HiQvOuB/+4mNZxjxVZm7ptvTHw3UJZVewf3TpOc2dwno
         o808WuuSpjLZ4nFIeH02X8q4iW0312jfRhY8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eNaY7c0YwJ/R0zBgjZVAVLdZXo+kCXJ/VuomQlDevs=;
        b=RIdPulLP0C6UMrgcjkaXoo3S5jPG9IxYWEhuj4IRtiMayi/H5dqnCibuJyhdAyjrhQ
         KhY3jKZRv3gNS5GLckTCNxi/i8nBFW3xjJ1YHcvaHaUU627Mn1anwV5t5ZF0LCQECCvl
         5/oxwATc7bSk7iL6ecO9kUZy1RC11gyWCvBpMZ0sAJMK0bSKid+aUc6Pa5eElldK2lGO
         dJ1PqacmYCn6bjTkg4Q2Dh8USwdZ6EEK/8shIUoXN9EN4T++MiG5+6EM6cia5HIbiq64
         WYnUx3nF5SMTkWJMvQHJ2ZH+uz6j0pdhjWdUUVA3uKDnXDv8kjXm15EMTcgxwpx/yGvt
         n0MQ==
X-Gm-Message-State: AJIora+I9ZiJPPbuPpU74P9iTEl3ntV4q+C86qTBJKmLg/r2yMsQoQVy
        p13NygzrqyW8sdLDeDzWvd+EwA==
X-Google-Smtp-Source: AGRyM1vqPCOIa3mDo2BSwVN7PTIYIhI1Wgv1WavR9Z0i5FMx3CdSBqP8R+vMqOhXe2ypQzXNGbuoNA==
X-Received: by 2002:a05:6a00:1687:b0:518:6c6b:6a9a with SMTP id k7-20020a056a00168700b005186c6b6a9amr40044531pfc.81.1657004014947;
        Mon, 04 Jul 2022 23:53:34 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a4f000000b00408a9264b36sm21611610pgm.3.2022.07.04.23.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:53:34 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v2] scsi: ufs: ufs-pci: Enable WriteBooster capability on ADL
Date:   Tue,  5 Jul 2022 16:53:26 +1000
Message-Id: <20220705165316.v2.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
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

Sets the WriteBooster capability flag when ADL's UFS controller is used.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

Changes in v2:
- Fixed typo in commit message

 drivers/scsi/ufs/ufshcd-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index e892b9feffb11..fb7285a756969 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -425,6 +425,7 @@ static int ufs_intel_adl_init(struct ufs_hba *hba)
 {
 	hba->nop_out_timeout = 200;
 	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
+	hba->caps |= UFSHCD_CAP_WB_EN;
 	return ufs_intel_common_init(hba);
 }
 
-- 
2.31.0

