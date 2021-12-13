Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F06472B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbhLMLRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbhLMLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDC5C061751;
        Mon, 13 Dec 2021 03:17:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so26381017wrr.8;
        Mon, 13 Dec 2021 03:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wqsag2uxVnTuI/QAGHRmj3exQQebAtaq7D6d3UaUwo=;
        b=YOWf+5In5JEHLkyH0tZKIUsbRMR8F07CsQg25aGFCI8BJKg7vOUqNabuTQHS7uyAJt
         YbeT/VcxSaBXA5MEeu4EWH/XYjUEfn+b2Cd5nEFgBB9V0qrd50cyI0efdw4zJnXGNTsu
         bGCgKApNJo+fnpRSuMeE6yZmGWy4yv9I7Uj409+5tGkZGY12/sxq3Vw7mAGZCjd9mHOJ
         hjnUrpmgqB24o77uBlGrbHlScJcrPKcfzWWIKLGq/egHI4keICKJO3wqH9xBhJg+2gWG
         0VicSdIIAk4dg+BsCw9wCaDetG1jgapS9RRPMHbHscIyKuwhrIN+juui/RnklaV/PU/Y
         Fqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wqsag2uxVnTuI/QAGHRmj3exQQebAtaq7D6d3UaUwo=;
        b=sjF0oznHsXw/q/dMSPKIaUe2sFKtUGQawo5Xbv8ekjO68iQoeUXG/5yNFFpDbt8SVg
         yYo832H+dePxhBzuHE60tN0bQGxeAwhcMBgW6XQJ5RClWDPp2iV4SQ4HDLGwSRX0jSuP
         kqfgiU5axYi1K/rgc7aHZ8lbbMPeGo5rkBGwBEP9Ye56MZ6ZNPEJllUTXxfWflLlpgb9
         e80vD4cZmseUZ63jClVoTIHFfCRo0YlMHknL3pRUMI0f8ZBOzBnt/BbcvLTldavtgKiH
         jahGqsIVzHRqSKW9JVJ6DbJe+UfQkDPrGVlyKu98xMbwzo57viP0XFvda3rhglOqtTni
         Y5iA==
X-Gm-Message-State: AOAM531G2bV6hqHIRlZEVv9Y9l7n4OCwwYboWDecNsQSWn1UUnwwhyiq
        NxdjXR0CqJbDV4DcdeB2LWk=
X-Google-Smtp-Source: ABdhPJzM0MwxJtfv5lacI04lRH8UZylULPttANur9UjAL92TmaH2qyu5nQ70YKy541M+4nGfrgOK0w==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr29826451wra.557.1639394228763;
        Mon, 13 Dec 2021 03:17:08 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:08 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 9/9] mips: fix Kconfig reference to PHYS_ADDR_T_64BIT
Date:   Mon, 13 Dec 2021 12:16:42 +0100
Message-Id: <20211213111642.11317-10-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d4a451d5fc84 ("arch: remove the ARCH_PHYS_ADDR_T_64BIT config
symbol") removes config ARCH_PHYS_ADDR_T_64BIT with all instances of that
config refactored appropriately. Since then, it is recommended to use the
config PHYS_ADDR_T_64BIT instead.

Commit 171543e75272 ("MIPS: Disallow CPU_SUPPORTS_HUGEPAGES for XPA,EVA")
introduces the expression "!(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))"
for config CPU_SUPPORTS_HUGEPAGES, which unintentionally refers to the
non-existing symbol ARCH_PHYS_ADDR_T_64BIT instead of the intended
PHYS_ADDR_T_64BIT.

Fix this Kconfig reference to the intended PHYS_ADDR_T_64BIT.

This issue was identified with the script ./scripts/checkkconfigsymbols.py.
I then reported it on the mailing list and Paul confirmed the mistake in
the linked email thread.

Link: https://lore.kernel.org/lkml/H8IU3R.H5QVNRA077PT@crapouillou.net/
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Fixes: 171543e75272 ("MIPS: Disallow CPU_SUPPORTS_HUGEPAGES for XPA,EVA")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dafc1d62c224..affa31d055d0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2065,7 +2065,7 @@ config CPU_SUPPORTS_ADDRWINCFG
 	bool
 config CPU_SUPPORTS_HUGEPAGES
 	bool
-	depends on !(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))
+	depends on !(32BIT && (PHYS_ADDR_T_64BIT || EVA))
 config MIPS_PGD_C0_CONTEXT
 	bool
 	depends on 64BIT
-- 
2.26.2

