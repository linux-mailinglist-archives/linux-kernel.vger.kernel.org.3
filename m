Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7992472B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhLMLRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhLMLRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21485C061574;
        Mon, 13 Dec 2021 03:17:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso13769517wml.1;
        Mon, 13 Dec 2021 03:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qU1UBVrn4PcqYz3gmC7srrln/dlA5hxmpnlorvZMQn8=;
        b=hx49G9pOHE8U63mXCkRA+DsbcuWa3XBPY5tYcSD+Pr/UN+IoTMyONu0iJO5TwqvW2x
         ab8WdmNrvI4Fmm90rJdyM3VmR+wBJxXwj8nplzmKS7/hhYeoxwmmswKU/6rzQ0RjG+Zn
         NuCuzC7UtYjd/643MsHuYiTrzKNG8eCOULWcjs1crL1XQ/btuXIKH+ncKkLfKiBmgxjj
         h9z94qzpOutfC8gDs89TPQLus731OIVaS8hOm8LL1WzEF1P4ccw6mBG2pScNE/j/dMxq
         GhkIQ4emeij+AakhUwPXusFng5HJxmzaFEv335EoW7DkF467K2qBFglv4OpN9XM0o9S9
         XJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qU1UBVrn4PcqYz3gmC7srrln/dlA5hxmpnlorvZMQn8=;
        b=3gsMCUxTo4TtRpa5lO0MULhfWAXodcIXrfy7fd56fmVh4SWSMQQdkzz2Oy6EurL2ou
         4md1WHWUFK1NIqiS/bYT0o+okQAF4Blkb7m96zuzeLJevJpc/Q7VgDtoJDUi4zrftcH3
         U/quO6yzidAgYWnfX8v9Pr0fxDzOBEKopk6HE/nTvKxULXuD0RSvm+Lc8jenSN5Va9SI
         ue57OISJ7ay7w1+V3xBfmgH5m/sNtYuStjM9TlXu/s+H1ytCzpcduPfSuKG6oJr+tS+T
         lyEJmdq1/sliLABf10CxKozJQ+JVXzWBzBkff8lqMPdfXK3T+s2fGINr5Dn7Xx2/fGRB
         wUGQ==
X-Gm-Message-State: AOAM5314B2gQO0As8YMN7aHGeiIvKMBBNAm/wq61ioMlCGsr48OpdzGY
        KEuxNd5e4ABXiR/AmERU+XA=
X-Google-Smtp-Source: ABdhPJzB3IIVAx23ZARxDyIUmTdRWd4eQEsNSd0G9brti2OloW6k3iN52nCu79cq/P/jOmFPIKsPrg==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr37971568wmb.51.1639394224608;
        Mon, 13 Dec 2021 03:17:04 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:04 -0800 (PST)
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
Subject: [PATCH 5/9] mips: kgdb: adjust the comment to the actual ifdef condition
Date:   Mon, 13 Dec 2021 12:16:38 +0100
Message-Id: <20211213111642.11317-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment refers to CONFIG_CPU_32BIT, but the ifdef uses CONFIG_32BIT.
As this ifdef and comment was introduced with initial mips-kgdb commit
8854700115ec ("[MIPS] kgdb: add arch support for the kernel's kgdb core"),
it is probably just a minor issue that was overlooked during the patch
creation and refactoring before submission.

This inconsistency was identified with ./scripts/checkkconfigsymbols.py.
This script has been quite useful to identify a number of bugs with
Kconfig symbols and deserves to be executed and checked regularly.

So, adjust the comment to the actual ifdef condition to reduce the
reports made the script and simplify to use this script, as new issues
are easier to spot when the list of reports is shorter.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/include/asm/kgdb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kgdb.h b/arch/mips/include/asm/kgdb.h
index 4f2302267deb..b4e210d633c2 100644
--- a/arch/mips/include/asm/kgdb.h
+++ b/arch/mips/include/asm/kgdb.h
@@ -18,7 +18,7 @@
 #ifdef CONFIG_32BIT
 #define KGDB_GDB_REG_SIZE	32
 #define GDB_SIZEOF_REG		sizeof(u32)
-#else /* CONFIG_CPU_32BIT */
+#else /* CONFIG_32BIT */
 #define KGDB_GDB_REG_SIZE	64
 #define GDB_SIZEOF_REG		sizeof(u64)
 #endif
-- 
2.26.2

