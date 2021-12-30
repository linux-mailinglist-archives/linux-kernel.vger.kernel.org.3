Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295F4481AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhL3IRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhL3IRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:17:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C1FC061574;
        Thu, 30 Dec 2021 00:17:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q16so49001464wrg.7;
        Thu, 30 Dec 2021 00:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=geuEd/JcVeINOoHDxuDR/f+b5PFdApW3RHaOzhYDz4g=;
        b=pourZ0bKL9XPfFz/dG0H1gKSiqKzUvd7BDl1XzO6XAtsHctTIiLIskunz5V8qe3n1z
         kTuR6hOUZHez5KIqbbf9IrKWWkKGgW426b7+6HdgnBF4GLtSiDP8EoxxNbrzE/saR6cs
         0B1G0wyxrXRdCqOKl+2fDOis9F+QxAgvYpyTobEy5Gpm8xQddxrzIsxr9zzebp4Y37z/
         BKfdE2DOBLC7IVsO4tZGf0WZc59YhejjaaSq6KNMx3Iqe8WwJIt2pKDC1aZqb+nedj/x
         gcRfmWokftEvX5Zt10OO07+PTeDTSx1USlI+BlfTqvup4QLOdR48eQVqiZ7TJpHcZter
         iUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=geuEd/JcVeINOoHDxuDR/f+b5PFdApW3RHaOzhYDz4g=;
        b=gsExNCTfmvJi5goAOiKcomottNgbKcdtaht21yVG5FfOsNEp5nw25byU+E6blUNx9A
         3wWk+UJcqa0h4RiZmxkv/LjT7P8NzHLT022yfWDE71sUPVmdj57oGnLGKBoUoVrngiK4
         7FrYPYlk2Lec3ThESTPHneEiBAa/a6Ef6+mNBPyxahTE6Fl7xNDfmuR4bwOZkrnDAaBm
         SuSe1MJKZChGW3bV9zth/mmIrAe+WPmxbfj9eUVInTDzh9OLdLFostqOrXadKHlsrJqr
         /zZHRKhM903fm6hanQaE8lXHwpVzE9mMPQyaArzLZkLe77+HM78vgCOsaGsT4q6aAQqg
         otaA==
X-Gm-Message-State: AOAM530sd8AoTmyBZ3e1s4t+iVxmTOxIzhF9V9Rwf9iVb5HwM4pE2q7m
        kTVHOu29pka6tT4sfzYARA8=
X-Google-Smtp-Source: ABdhPJyR7kaVjSgs+djhL3tFHlq05F2u70kbJgoT2AcELMTnDfIQzYICWJaKD3bIoq8xV0fARDl8Yw==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr24161840wrx.49.1640852241270;
        Thu, 30 Dec 2021 00:17:21 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2626:5600:789b:54e9:fc28:95aa])
        by smtp.gmail.com with ESMTPSA id u12sm22736319wrf.60.2021.12.30.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 00:17:20 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] powerpc/ptdump: fix conversion to GENERIC_PTDUMP
Date:   Thu, 30 Dec 2021 09:17:03 +0100
Message-Id: <20211230081703.31162-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e084728393a5 ("powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP")
replaces the use of the powerpc-specific config PPC_DEBUG_WX by the
generic DEBUG_WX. The commit misses the use of PPC_DEBUG_WX in the
function note_prot_wx().

Replace this last occurrence of PPC_DEBUG_WX to complete the conversion.

This issue is identified with the script ./scripts/checkkconfigsymbols.py.

Fixes: e084728393a5 ("powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/powerpc/mm/ptdump/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 031956d0ee84..be120e09aa3e 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -183,7 +183,7 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 {
 	pte_t pte = __pte(st->current_flags);
 
-	if (!IS_ENABLED(CONFIG_PPC_DEBUG_WX) || !st->check_wx)
+	if (!IS_ENABLED(CONFIG_DEBUG_WX) || !st->check_wx)
 		return;
 
 	if (!pte_write(pte) || !pte_exec(pte))
-- 
2.17.1

