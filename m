Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5924840B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiADLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiADLUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:20:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD66C061761;
        Tue,  4 Jan 2022 03:20:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u20so31943687pfi.12;
        Tue, 04 Jan 2022 03:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43jwoc03WEbmmZwioDwFkhGaJRKAIQrMfi2IPHILK2c=;
        b=PjPkB50c8TAK2w123ivcBHeD5VQY1n6OS9+Q3PHObFfYz1cIgJh3kck9v2UMzqGh3T
         VKPxxQMkcbDYgui5jRt40TxSxpvlnJvtCIG1zHz5S5TQ/vmBIMvvATXYWMlf/SwVruvv
         hNW+q09A32jeupKabYF3J7SlLweAc/NzdW7f0gKTEWaCGezBEscZ7W+BlrPSV21WWjJ2
         KM28ionkNcRpnpLOR2ZXiuYgwt2m7mDsCbroNQaAg3/zcIHxZ2QL/M4aIvKW8/Qbul5Q
         PXoZEgL9VqQbvX5y9NvZVhIy3Kds9kWt1fuYECNdQNIDTCUii/mfkhbZXVe1wsS2eUMv
         ot7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43jwoc03WEbmmZwioDwFkhGaJRKAIQrMfi2IPHILK2c=;
        b=ZfVFWnFAOqKRkARWnRf8lPSDt7MHePtYdA48AmhRJOBzGcB4L3XOTR2IY3NuN/by3I
         VEva0vxfW02bGRo1+d48azqAH2Xzn7Mk0sgXKMny+3mETpZo+DR4eo4bnLh3g75zfJQf
         u2bnvCLvZuNUgZKKseMWYG/RZ+A8D5/MubpTf06koe8Ux3e4tyqQuXH9N0FLL2qwPonr
         b0wMD0kGSBW+OsakZJzka1r2kcRAJrgGTiG2tb8cdJuV0/broYQI2qh6OJ0Npkv3j5Bm
         JSGGkwqUYyJiVBdEBwSMnwz6WWxlANFsHi64W+rdeLcMQhY6SOrPYkdl7k0mzPNmJxm1
         fgTQ==
X-Gm-Message-State: AOAM533YWVwQD0WmXvo0UuAcVa54BYX3Ssk/iLbFcQbT9yoLqRKGFmk9
        G6kpPzen/IKjU3g67oXKXQw=
X-Google-Smtp-Source: ABdhPJwSoNgMa51jrtEScKoF34mgUWtlr4CH+62tieINlCQozd4h/dSm7n5qf70w6uPNjpOuFIWW6w==
X-Received: by 2002:a63:575c:: with SMTP id h28mr43354858pgm.171.1641295243889;
        Tue, 04 Jan 2022 03:20:43 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r10sm37119288pgn.4.2022.01.04.03.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:20:43 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tsbogend@alpha.franken.de
Cc:     maz@kernel.org, ilya.lipnitskiy@gmail.com, chi.minghao@zte.com.cn,
        ryazanov.s.a@gmail.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] mips/pci: remove redundant ret variable
Date:   Tue,  4 Jan 2022 11:20:24 +0000
Message-Id: <20220104112024.601765-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from rt3883_pci_r32() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 arch/mips/pci/pci-rt3883.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index d3c947fa2969..e07ae098bdd8 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -102,14 +102,12 @@ static u32 rt3883_pci_read_cfg32(struct rt3883_pci_controller *rpc,
 			       unsigned func, unsigned reg)
 {
 	u32 address;
-	u32 ret;
 
 	address = rt3883_pci_get_cfgaddr(bus, slot, func, reg);
 
 	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
-	ret = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
 
-	return ret;
+	return rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
 }
 
 static void rt3883_pci_write_cfg32(struct rt3883_pci_controller *rpc,
-- 
2.25.1

