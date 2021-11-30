Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA9C463F67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbhK3Ule (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhK3Uld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:41:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1FC061574;
        Tue, 30 Nov 2021 12:38:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so19201364pjb.2;
        Tue, 30 Nov 2021 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ong6/4IL92LMdcOa16LOw6DP2Z1AN5gi8h8irI+N774=;
        b=oPLcJF5LzzUDBcgWGwP0janfoey9R+26kFDoReV4IyoPwejgUAK/30bXsL2Bgz0I/v
         ajNCWxibs05dyVXJxHonDGgk2TRcrVFKTKSozeN4UIC1UMRbJrSGxI2bYzw7+IoSCMaJ
         /PcymVKwkCkc6H3ciMnFdkZC6Ei5jqin6+WYYPYFyx4bqyCB2cGUl7bDXPh7dqOiP3f7
         usShl2zs2Cz72bjeCafwLFsiCqnmga8MhzQPO1zT76NSdwEsSS2XN5q3b9P6Yfi8tHwp
         Qu5V/AKZu5/f1RJvcmhR76BVU75p2SeMBmf1enKpE2Uw984QOEWHqh0CsPcgVz0eSwu7
         j7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ong6/4IL92LMdcOa16LOw6DP2Z1AN5gi8h8irI+N774=;
        b=zJVRDZa7m1Clt3oHdfKUAtiU4g+DZkikNbySh0m1XFvcrbltPSXCQLhXGH41rXuyaG
         iIekdm0pgp7Va37UUsIuWH9mwgLTAoL7a1hNEkXvktZmSVTp1YOSTT+6pBC5S+x2SFY7
         apQKioImEsaks2ZxxDSS0KB4FBvTsFDe2CyzuBCPs9T/bVIYPBIJvBx0KC8arAHj4eFf
         d7bkmj38fnOV3f/cBWWzL0S61oZpFyxPoj85ZU6yXZ32XJ0hfX++ocRG5uwi35fMhegP
         8SaNvEMpIzBnaif7M5pmQSSgP6+pCqObnpYE5bQfRBw32AHPqZdThmGn0Q9BvHTlgEfN
         l2kQ==
X-Gm-Message-State: AOAM530r+nxEfiyRHIXExxB93ZPD27bystERl2+Vaaylip7R0BWGdwxz
        38Gujs9i9lClEopvbURWL5UcNXrZqoA=
X-Google-Smtp-Source: ABdhPJwjWo2BmePL72i5dZrndZNwGD2t3EetRa6onOAuGkW/LbPJSwwPajueftrXirWUovYnmN4Zvg==
X-Received: by 2002:a17:90b:1c06:: with SMTP id oc6mr1665408pjb.126.1638304692634;
        Tue, 30 Nov 2021 12:38:12 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j7sm23071520pfc.74.2021.11.30.12.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:38:12 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QL41xxx ISCSI
        DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QL41xxx ISCSI DRIVER)
Subject: [PATCH v2 0/2] SYSFS_FLAG_FW_SEL_BOOT formatting fixes
Date:   Tue, 30 Nov 2021 12:38:11 -0800
Message-Id: <20211130203813.12138-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Manish,

This patch series aligns the formatting of SYSFS_FLAG_FW_SEL_BOOT
between qedi and qla4xxx.

Changes in v2:

- fixed incorrect format in second hunk of qla4xxx

Florian Fainelli (2):
  scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
  scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte

 drivers/scsi/qedi/qedi_main.c | 5 ++---
 drivers/scsi/qla4xxx/ql4_os.c | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.25.1

