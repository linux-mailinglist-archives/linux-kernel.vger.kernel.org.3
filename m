Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01D463F47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbhK3Ud0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbhK3Ucz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:32:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00097C061746;
        Tue, 30 Nov 2021 12:29:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id np3so16185339pjb.4;
        Tue, 30 Nov 2021 12:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VB9teT6Cl4h1tJlDOXewermQwPLU9e4KtcdbwVtXxl0=;
        b=gINDA2ENvERiby19/745Zy1OnI+kx4dPZd5vvP6V6Yr5OsO9fQukKfTBCP26fDNw9s
         f+6Ij7FuO6B3hYoQP478/nsSFZWxIk+xhnRHh1jpt8x991dsM2t5jZTtkdb40dUrtJbS
         wrfATgapKdAnZj75Z2HyWv7eKnnsCk2RoolExVcr+HMbd2PJReJwS1VC3J9fnuxngrGe
         F1GGX/26o4GZhzcbyX//lK/tdMNE5/pjnoD2FkTaKBszoBwz19IHBBlC2naSWLPfuXsg
         pNxTVUJt1hq6dVTasFOGp17DPfaEtezTDSkCsDZriQvCxLm1VrO5rMM12zkZY58zZbza
         u1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VB9teT6Cl4h1tJlDOXewermQwPLU9e4KtcdbwVtXxl0=;
        b=1I5y776c+Dcf+7NQgJNFWqw837ChCTrKYr9TTDyofIRUnAYMd5L6q0Ya/4IbFeXQRq
         eMeJsuAVQwzZkg13Zp1tjpzaZjfvKtyFBEvxocMlT77AqUyjPMuJ3X0sGJfOoXCbijHd
         srJCQ4x8ER6IkPMVHjGlFrPgG80c0uoW7Rd72ciWBuQpYgHa67ZgHqssKO5hYcnBSkbb
         k6r9ifMegBXFQpZVUd/urgCKdvS6ma9+tDET/Yf4uDfM0UY5Fts9BTeb0uWzXgb32+UB
         +8FqgMDbDDe1exLRr7Qkb1kkaLpp9dSjZKAxm21UQaOLr71DTHtY+m+yqiAqVmD78vZo
         kBwQ==
X-Gm-Message-State: AOAM533/cOQNbwF+woBMs4h6mQ0ociHJR6Pfbii6lRjFHXGyIks+ekyR
        O3theepgVjpNYFG0cM1vULTKH24kbvU=
X-Google-Smtp-Source: ABdhPJxOgyLr9bL4HauGjmYt9cqWjz8fZQnD4fJ1YNLjv/s5DT4CeshsgGvIdeycJE0tZWfRM9CTbA==
X-Received: by 2002:a17:902:a584:b0:143:c2e3:c4 with SMTP id az4-20020a170902a58400b00143c2e300c4mr1657445plb.69.1638304175135;
        Tue, 30 Nov 2021 12:29:35 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id lw1sm3512435pjb.38.2021.11.30.12.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:29:34 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QL41xxx ISCSI
        DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QL41xxx ISCSI DRIVER)
Subject: [PATCH 0/2] scsi: SYSFS_FLAG_FW_SEL_BOOT formatting fixes
Date:   Tue, 30 Nov 2021 12:29:32 -0800
Message-Id: <20211130202934.5023-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Manish,

This patch series aligns the formatting of SYSFS_FLAG_FW_SEL_BOOT
between qedi and qla4xxx.

Florian Fainelli (2):
  scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
  scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte

 drivers/scsi/qedi/qedi_main.c | 5 ++---
 drivers/scsi/qla4xxx/ql4_os.c | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.25.1

