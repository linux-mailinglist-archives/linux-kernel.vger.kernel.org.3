Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCA47C1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhLUOsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:48:20 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C72C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:48:20 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id p19so12993756qtw.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZuDkRiIkR9ys/6q9NNmS5Lq8rxb7QfIIo9v52hklq8=;
        b=QwYotQVAOw8t142MhQtL5+mbjmyHKWsbUStue/SPP7IY9tm5RYJdi7gtxSTCyIJo/O
         IpimVtyfCBPML408CUBDpht1PQswdsEokBKl4jg4euhi6pg7H8MChYJVNbG//xr39NTn
         d/mRWIWTEQdTKq1LODzeNdA1yAAr8aTM2zrV/VClEpZ+g5CxLtjFf/p776IDItuOYed5
         a5UbzizCDkLkmFJvjF4D3wVXNwSuff/olsX1y7V2yWn2J4b3juMBRyIHQ25wjMsUFWMW
         uqrJEYrVQSv01yGAAE7tbvifskxNi4PZVXJy8CGhSiMnmkG+z5RtB+AP8jfKA5LQ0UkK
         kEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZuDkRiIkR9ys/6q9NNmS5Lq8rxb7QfIIo9v52hklq8=;
        b=A0KEXrSA5lTo9hbKPpbrTDpdeAcuj0QlJ23GmGqy3/aCOZQkwGEPORnHkmVpUVsGcY
         oX++bQnD+pz1Y2hHQ8G7AhsQ9v4THddx190iih78FU8CGh7KDBX6/dmSxjCaJxTmY0ji
         HRTov9nPv2Zw6LN0df8Qo1A4aw3uCd2YAZteyQi88LkUNj0x3Pz7yv63V7dOpdJ7SljH
         qZXOdz5pWihDL5V9tPdd4jZ9ZPLaSrTHCrQ/uQC1ctKNb4oPIaNhpVHC2YQw6ve97QL5
         6khrCroRid8Usvu2uZsCviEwNL2w4MJFuOTEcUd0+KM2DlVFS6l7piAHItnJnPUlPq29
         XOBg==
X-Gm-Message-State: AOAM533wKHLYzMxD/6Ri6afA5ux9xNF5Ph4WBCethuJYM/9GtKGrTV5K
        +4ytEbYlZMNjT2tHXMsGJ+c=
X-Google-Smtp-Source: ABdhPJycfYQf2KP5PZ7xjWj+VSDFrXKBOwWd5EsILfz2JTg5hj204QyNxDQyiJNBB5Ho2MIZXAm3Pw==
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr2483288qtw.52.1640098099976;
        Tue, 21 Dec 2021 06:48:19 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y11sm18110177qta.6.2021.12.21.06.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:48:19 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     arnd@arndb.de
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc/cell/axon_msi: replace DEFINE_SIMPLE_ATTRIBUTE with  DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue, 21 Dec 2021 14:48:14 +0000
Message-Id: <20211221144814.480849-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck warning:
./arch/powerpc/platforms/cell/axon_msi.c: 456: 0-23: WARNING: fops_msic
should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
debugfs files.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/powerpc/platforms/cell/axon_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 354a58c1e6f2..47bb0ae8d6c9 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -453,7 +453,7 @@ static int msic_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
 
 void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 {
-- 
2.25.1

