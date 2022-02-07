Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A7D4ACB1D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiBGVSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiBGVSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:18:30 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57559C06173B;
        Mon,  7 Feb 2022 13:18:28 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id bx31so21645750ljb.0;
        Mon, 07 Feb 2022 13:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYwVTByFSLm7YfC3rAtEhcduxeMNVifR9e2i3wvgr5g=;
        b=HqAim6ROW3H3RAUI6JqmL46IYzKE9NlDOTRG6J1xu043L3eH5tNcsDO5lQjrZfNFgJ
         GhM77obAQc7YIPLNXlTURP1HIuraaMdatOdYqaXxJGJY+ZJgtPNcAgen6YozHme8mrql
         bW7QR02ATyEI/m7h7Fx4Ab7/qMsaS5wZ7qPQgy4pddSyqUk/F+Yeq+6GyvaQ2WhBrmbX
         nhD2PqWeVO2BEs+/g6sohr6mCkfGxb8SjbDWSlpPLyQdTHxRLeT6CvhU0RH3H8x060Jo
         gNe6CL1hgDJMfrRhWVS1OrINPwYX5CfaaZHrpLQVLEtR+PiFwVoOsp3MzAYcJ89AB9SI
         o4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYwVTByFSLm7YfC3rAtEhcduxeMNVifR9e2i3wvgr5g=;
        b=yjGTb80SiGIvnJlq8cOCAIvqsgQLAUdv8pSR/pVrYwze8fiyxFsn83gDW83LA0GQkE
         a99xWqHTTewYCwEIrMJAjp7HaxDR8AfsppHONTCdM9xdrfIlD/q+sxDwSoDgipq+rz+a
         WBNhxBoHcL7yTqdHPSKJIHizpzP8dxYgQB4VBAdf9Nk4HZVXhZ3c+VL60vViBOkNM+WK
         c9c8ILCY7eq7NAQnnbWToioGfQfgAk6UcZsb5N3PV+DjSf6FXRJssWN9fYMjqkF16N9Y
         7qzUfybu3pzSY9piAQP+pjJ2QZxY2Qvj58uVrQVFnOCoB6M2zCmvDfsEQf5Kv2Br7wKZ
         6iKw==
X-Gm-Message-State: AOAM531eJv5jgKi5r/pR1UL0VNOxvuc+au+yO7/m0IPjX+q6QKAZertr
        T7oBmaKqQ2Q65+5EeMM51zCAGWfvaqY=
X-Google-Smtp-Source: ABdhPJxJnDWK5HUMhRsEhRXhMQsYpWkkEB1uDMpYiQjTEZQV8KDCiaAg3X+1t3NRXPlgeeackAA/ZQ==
X-Received: by 2002:a2e:150d:: with SMTP id s13mr836466ljd.468.1644268706628;
        Mon, 07 Feb 2022 13:18:26 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id s30sm1637978lfp.93.2022.02.07.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:18:26 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] MIPS: pci-ar2315: Constify static irq_domain_ops
Date:   Mon,  7 Feb 2022 22:18:16 +0100
Message-Id: <20220207211816.57860-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207211816.57860-1-rikard.falkeborn@gmail.com>
References: <20220207211816.57860-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of ar2315_pci_irq_domain_ops is to pass its address to
irq_domain_add_linear() which takes a pointer to const struct
irq_domain_ops. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/mips/pci/pci-ar2315.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index 9a4bfb4e63e3..30e0922f4cea 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -384,7 +384,7 @@ static int ar2315_pci_irq_map(struct irq_domain *d, unsigned irq,
 	return 0;
 }
 
-static struct irq_domain_ops ar2315_pci_irq_domain_ops = {
+static const struct irq_domain_ops ar2315_pci_irq_domain_ops = {
 	.map = ar2315_pci_irq_map,
 };
 
-- 
2.35.1

