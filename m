Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3400B497634
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbiAWW53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiAWW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:57:28 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12863C06173B;
        Sun, 23 Jan 2022 14:57:28 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id p37so14132381pfh.4;
        Sun, 23 Jan 2022 14:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YpaDt/y2c3/dUeLfnG7ff++Dq8k/QrMoesYhtwfYz8=;
        b=Jfeb4woSg0fNp15ri+VhTahx4p/I7+BmYJyNeRGYFOZj95O0pE1gVvRWV37IdkkIYe
         jmuMkmRhYFCOD3Glzleex6r/2wUIuW5kSMZy+6QXteITDA6IRhwxpigS+GhREnjisD8l
         RcQJGjjyoIfneXHi3ZrZ0kEiCJjhV3og9L6Bw9O+n+iXbrMDPqdSiYE2tY7Isyot1yd0
         mfPAgcYMX9x+waOCI+La4lqNCU3n5Bm1afnSTFeZBh/d9Vz1LPG1D5SFgSxgpC/TChYJ
         x2raLsi0iOZyIuIHHjO/PTzSA2+5Np6tbET2kAWJLAqaxOzPtuVBJK7PU7UnD6ZG8xnJ
         jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YpaDt/y2c3/dUeLfnG7ff++Dq8k/QrMoesYhtwfYz8=;
        b=fLWvkuLGOyFHfPEG9uvQ7my4B25EWcT39KljBc5aJDvxj9WXvOuOFAe+fuUCXmfQgq
         xSsFHOZUTUn3HxYHEaejmXh5DZBMZZCMuF22HXpiJJ8V2su/HX9/gRoTDaV3k3TEStCc
         YsM5whmLfVY2AY+F1gYPSYRtwq5wdDe8yRXGQokBzBSufNvcf/T+0vdxy7Kl8aBm7xd4
         7eyf+/+EhIKeTIYhbhLcgvEW2+74JSO8T0QCUJ0tY4yBAmI4o2MPolB2Uy3MjXPIrsWD
         WyuGKEX8WJ3451W3hgPswbrGoMYBEOHKJrqlrg9kIoY3La5DC/CQvc11uIPLPhlFxSB8
         GumA==
X-Gm-Message-State: AOAM530k5k3GAZ+EAxz851o+9/8TgfJqvlrugtgC35DQ6oASaBFno19d
        FwPmBl+gb6OtoOzi+cOCMw0=
X-Google-Smtp-Source: ABdhPJxiWeo8n8WyuKjPy1UxzAv9V5Jbbx4IUyYLBfi0hHSzMZiEVOvgyaOaqn4JQPTyvpAi/jKoXA==
X-Received: by 2002:a63:541a:: with SMTP id i26mr330814pgb.322.1642978647379;
        Sun, 23 Jan 2022 14:57:27 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id w1sm1826881pfg.162.2022.01.23.14.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:57:26 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v1] scsi: myrs: fix crash on error case
Date:   Sun, 23 Jan 2022 14:57:17 -0800
Message-Id: <20220123225717.1069538-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In myrs_detect(), cs->disable_intr is NULL when privdata->hw_init() fail
with non-zero. In this case, myrs_cleanup(cs) will call a NULL ptr and
crash kernel.

[    1.105606] myrs 0000:00:03.0: Unknown Initialization Error 5A
[    1.105872] myrs 0000:00:03.0: Failed to initialize Controller
[    1.106082] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.110774] Call Trace:
[    1.110950]  myrs_cleanup+0xe4/0x150 [myrs]
[    1.111135]  myrs_probe.cold+0x91/0x56a [myrs]
[    1.111302]  ? DAC960_GEM_intr_handler+0x1f0/0x1f0 [myrs]
[    1.111500]  local_pci_probe+0x48/0x90

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/scsi/myrs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 253ceca54a84..7eb8c39da366 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -2267,7 +2267,8 @@ static void myrs_cleanup(struct myrs_hba *cs)
 	myrs_unmap(cs);
 
 	if (cs->mmio_base) {
-		cs->disable_intr(cs);
+		if (cs->disable_intr)
+			cs->disable_intr(cs);
 		iounmap(cs->mmio_base);
 		cs->mmio_base = NULL;
 	}
-- 
2.25.1

