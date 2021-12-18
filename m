Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFEC479818
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhLRB7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLRB73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:59:29 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73270C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:59:29 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id a23so3787721pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVlk8piyOncRQf0Vy0aH37o8z8Dj5DxGoG5amdt9lsA=;
        b=bpyyDNicyNZYeQ+gK+FvcGv4/vRMQil0DH4TDuR4cKiKlyAFhGQRIa78YZAx4MuL2i
         Z4xrwgXbryvlBKG0np+AylvkDBL/V6Rs47TkAPylafPvGrJngqPtR+rYxKh9zWf7uC+5
         tmRuzeCVKGWiI+ZLbsUe3eyBpuyUD4SQMH8KOtrXLKb03tmflDEYpMw53ZLAtVa4fV3Q
         39WgCRUY1OuOfhRmw51pWaA4vWxKZpFgS8K2jfIh3whoyZ5OWwohwxgZPvyhUkSZX1t7
         W634r6Npj0gqE5liOcqRj30I3IZjK3+psNfAbNNqgkUja6/VsH34R4xJp1pQQSUiFr+B
         Sicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVlk8piyOncRQf0Vy0aH37o8z8Dj5DxGoG5amdt9lsA=;
        b=xjBYNdHYwWJhh6+kmbjQDqY+n9dsd1M37NXtYlPZuBWc0sdeZUzbFQi4wGz9EsL+/e
         gMTldA49TNe69LLhVI6c/aPGjSYCEkJAOccyIXPSCLjLTXjAhBgN7AcQQ3z2Tp6jChK1
         URRhHcNAAW8Z8fGRyrtXRiVIjPOSpA/nn9EFVMQdgDI8fooPOptU8izbRE/61SNggrrY
         bnc1SEm1rxf0IlL+SEsGnFleJuXlG4d/ygB0J+gSJs6icl2euJP74tX/HejJcLwYpV1K
         UM5wdWiYChmELyfxI2fYVYcB1Bv7YCvnwaksB7XcDbDWppSDubQLNED/PILshddqwff1
         6t1A==
X-Gm-Message-State: AOAM530VwpJCNPVZzV7EEsBDY1oCgMBK5xWi2GyOGAzGHxh3aRiHluxJ
        LjqtIfo9RW3JNQzz0juytJ0=
X-Google-Smtp-Source: ABdhPJyBqCekNiUjEspqKM7jETsY9zDQI35fJmq1qyL1ZOX0v7lNOqbOqPrESNTQqHfSxBvS3OrFXg==
X-Received: by 2002:a05:6a00:22c3:b0:4b6:197:ae5a with SMTP id f3-20020a056a0022c300b004b60197ae5amr5729243pfj.42.1639792769011;
        Fri, 17 Dec 2021 17:59:29 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id mm22sm9613733pjb.28.2021.12.17.17.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 17:59:28 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     benh@kernel.crashing.org
Cc:     davidcomponentone@gmail.com, mpe@ellerman.id.au, paulus@samba.org,
        yang.guang5@zte.com.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc: use swap() to make code cleaner
Date:   Sat, 18 Dec 2021 09:59:17 +0800
Message-Id: <71a702c2189b16c152affd8a8cda1d84ce32741c.1639792543.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/powerpc/platforms/powermac/pic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 4921bccf0376..75d8d7ec53db 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -311,11 +311,8 @@ static void __init pmac_pic_probe_oldstyle(void)
 
 		/* Check ordering of master & slave */
 		if (of_device_is_compatible(master, "gatwick")) {
-			struct device_node *tmp;
 			BUG_ON(slave == NULL);
-			tmp = master;
-			master = slave;
-			slave = tmp;
+			swap(master, slave);
 		}
 
 		/* We found a slave */
-- 
2.30.2

