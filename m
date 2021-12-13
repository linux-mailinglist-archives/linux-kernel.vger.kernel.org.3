Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BF9472B19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhLMLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbhLMLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B1C061574;
        Mon, 13 Dec 2021 03:17:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t18so26352266wrg.11;
        Mon, 13 Dec 2021 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gh9g/hVG0rI1N3VHk0OoCcX2tUyzmtEm7HZfLqJJLcw=;
        b=cKg6PG4deGYG1ySeSu+L6jhx+0yzcAhyzrNyzJqrEcpm34L/1CkGJTo6JPNvXGPzri
         Cjsrwma9kdXHUMjPLj7XXLsz5n0i0pQ1uUOLqVq5Uk+jx3+2J2l9402eLFpzXhF+qWxJ
         bJJwOnnj6yef5NHX5IwGyk65ff0PGzPPi05/ro+nnnT+QIcnxClHFNQ8zAbAwxxn5WmD
         Pg6owOaGATZTKLfenpBEsBcza6GMON2/hrfTEyIhfNp/LQB/8uz1HcP+olUOgAh5KyeZ
         9r4H7VIHRlZTB46w5LVRbOVk5DZr9nl91Wcz8gUujbdGFumh3ab52z+3gqGYtRbh0wzP
         W0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gh9g/hVG0rI1N3VHk0OoCcX2tUyzmtEm7HZfLqJJLcw=;
        b=MoHS+IkUyUzLOKLHLZM36CJEusVaEbFJioQJu4hfgPN/6LSAsdTjrqZJl6Ymhb15wr
         4qW06xBYw8HFFRWPGXZ6E63U1S3WYdRT/aVK3mJcPuhma0NeyO95lxuGmSSn7rFft+vX
         mDg+zz11t9E9QSWC8aJQg504d+vuz+dLojZ5vDCqGVmYSPkZDYETUuAyA+qT6VL8/cIB
         LWrN0aLM6i06hwOh6Xac3O9GhqgJlf8nK1YgfWfUhqRUrayQ2MEhsb8qSATZzLkm/YFx
         AGE9Z84zYAPO3U6pi2ZXpXAA+EqBcndJyzuHrwrWJrTrNsvFtMMGD5hxeAjXW5TCYc5N
         GjjQ==
X-Gm-Message-State: AOAM530AuhKWQPjZTYQ+0R9Na2sFmDmPKd52dsX6oMCpddlbYxI/g8nm
        ws3xBn2aXQ+j+t3s5x1TtUE=
X-Google-Smtp-Source: ABdhPJzm1nLrJ12FEr0D8rL1q1mdBsYPVDdt6zlyZvkfjv+fpgOZVmeD9v4TrqkzatT8SDIrKx++ew==
X-Received: by 2002:a5d:4c51:: with SMTP id n17mr15572370wrt.359.1639394225704;
        Mon, 13 Dec 2021 03:17:05 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:05 -0800 (PST)
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
Subject: [PATCH 6/9] mips: remove obsolete selection of CPU_HAS_LOAD_STORE_LR
Date:   Mon, 13 Dec 2021 12:16:39 +0100
Message-Id: <20211213111642.11317-7-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 18d84e2e55b6 ("MIPS: make CPU_HAS_LOAD_STORE_LR opt-out") replaced
the config CPU_HAS_LOAD_STORE_LR by the config with an inverted semantics,
making the "LOAD_STORE_LR" cpu configuration the default.
The ./arch/mips/Kconfig was adjusted accordingly.

Later, commit 65ce6197ed40 ("Revert "MIPS: Remove unused R4300 CPU
support"") reintroduces a select CPU_HAS_LOAD_STORE_LR through its revert
commit, restoring the config CPU_R4300 in ./arch/mips/Kconfig before the
refactoring above.

This select however now refers to a non-existing config and is further
unneeded, as LOAD_STORE_LR is the default now.

Remove the obsolete select for the reintroduced mips R4300 architecture.

This issue is identified with ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e329214ac06c..dafc1d62c224 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1608,7 +1608,6 @@ config CPU_R4300
 	depends on SYS_HAS_CPU_R4300
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
-	select CPU_HAS_LOAD_STORE_LR
 	help
 	  MIPS Technologies R4300-series processors.
 
-- 
2.26.2

