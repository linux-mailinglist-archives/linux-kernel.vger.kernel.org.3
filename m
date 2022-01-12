Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26A48BF72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351371AbiALIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiALIFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:05:05 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A774DC06173F;
        Wed, 12 Jan 2022 00:05:04 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id y17so2131533qtx.9;
        Wed, 12 Jan 2022 00:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mX58k7wGho97Y8qH2nxAgkm3miNmVOmu/qIE3BiGfD8=;
        b=pVYyM7tn4EJ9mmnoSSYJUqh+HgkZToErbRTUapxwbADX0u4WL8CdKvGaDX7I9cgRur
         fAfWEM1PazmPDwPxQipDkOlDHqm9sBLkpvUsdwSbnOZnSfTo4qqqYH/CMefQVNJb3CSi
         j7Hi44/MtLxQh50UMwBN84/GFoRHSh5LTDdnmgElfrtj0z6cKruhMkK+PdFG1fLMbD/L
         aAG+hkECI+SVgr7RnhvaTneNbDSLQiMi8q+eluRBoXI1zYk+gUsfdR3qkf1zxjwFd2I2
         W8XqFHBsJGwla525sO09ACNtd2352DBy8ac/qxTwPAL4CKYbNGrOGfprtxn3HRmJWV+i
         CEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mX58k7wGho97Y8qH2nxAgkm3miNmVOmu/qIE3BiGfD8=;
        b=4k/OwWiAWQhqm5ki+pq8M4I9L5MW8xg81D+eIQxouFsCwlWR1DTxyyF7DIym4DgQp1
         PfOctol6bsvvluntoMo0/1BSfJEx7wfxF3rvrtiOh4aJTaR8OWQk7uPd252sbhULaTVC
         Xfgsln0Ugti/NUjz4vRpksbudFGG8H8EHFJghvIo5RmprnUc4bXWz/1GPLkPKIavqe2U
         X501c5D8Em2asFszQstL3jC9nNWGg4TFW9nCYaPL8mkYGzUQda2WKJmgwunETtlbk5O5
         3eE/yiL/H1NvzEdYkYKniE2yDrSCt1DxeTVf3YVyYlkgb6hgmXclqTahqw/Sxtrz2+xf
         ca5g==
X-Gm-Message-State: AOAM530G0xSY2HyOg3jSRHqPzsT4r0LSqqYZbRSzJJOUSvYmXCNOxl9j
        5/IKZuFNSPR3F4ntTNjVKdo=
X-Google-Smtp-Source: ABdhPJxVnEJK5emKrDFsqI7mB9uRjjKSWfAoMptS80gvdL4Kc8qcxPPrrAFDosjbt9WvKK1jIizFSA==
X-Received: by 2002:ac8:4e4f:: with SMTP id e15mr6654074qtw.168.1641974703918;
        Wed, 12 Jan 2022 00:05:03 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d11sm8035371qtj.4.2022.01.12.00.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:05:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/message/fusion: remove redundant rc variable
Date:   Wed, 12 Jan 2022 08:04:57 +0000
Message-Id: <20220112080457.667063-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from mptctl_do_mpt_command() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/message/fusion/mptctl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index ae433c150b37..dd1170cde5a8 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -1696,8 +1696,6 @@ mptctl_mpt_command (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_command __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_command  karg;
-	int		rc;
-
 
 	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_command))) {
 		printk(KERN_ERR MYNAM "%s@%d::mptctl_mpt_command - "
@@ -1706,9 +1704,7 @@ mptctl_mpt_command (MPT_ADAPTER *ioc, unsigned long arg)
 		return -EFAULT;
 	}
 
-	rc = mptctl_do_mpt_command (ioc, karg, &uarg->MF);
-
-	return rc;
+	return mptctl_do_mpt_command(ioc, karg, &uarg->MF);
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-- 
2.25.1

