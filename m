Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F15479A24
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhLRKF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhLRKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:05:24 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A328C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 02:05:24 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:e9c7:274f:a8f6:5f25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 1E674282FBB;
        Sat, 18 Dec 2021 11:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639821922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=auJPP3VEV6IR+9oakofmiczq/H4iU4bivONnXyJLUvk=;
        b=U8fA/8JpN4nLZGn8uXfPwAdmRJBQdg9U4YKH+N3+t8+uHvGJgftuiQfhXdOmvdSbkR4oyg
        9AkcmdftGXdjJrzFYzl1EhjrkyehzE2M1UtkpOYJzlkTM3JhlUzcoCsp5vN2Kjt70Fb6r2
        i3qqmSY2B4czJ/f1r42I3EPm/qFy5itmzI1s65WyAHNHzgzZ16ONL+GY/SgWBACEObSMIy
        Jw9nZ0KuqaQ7h4w2eWMrBWQyfmZDEVeJg6+JTUTNEoAeU2l+EPsrw+ZJF+c8SzrisDSRh5
        HTh4HXHFitgBLeei5TuxThufkIdctkyU+hBV9aqAFVL9q9rzXZ3qCJy+nRT+Yw==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-mips@vger.kernel.org
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 1/2] MIPS: only register MT SMP ops if MT is supported
Date:   Sat, 18 Dec 2021 11:05:10 +0100
Message-Id: <20211218100511.42508-2-sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211218100511.42508-1-sander@svanheule.net>
References: <20211218100511.42508-1-sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify that the current CPU actually supports multi-threading before
registering MT SMP ops, instead of unconditionally registering them if
the kernel is compiled with CONFIG_MIPS_MT_SMP.

Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 arch/mips/include/asm/smp-ops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 65618ff1280c..864aea803984 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -101,6 +101,9 @@ static inline int register_vsmp_smp_ops(void)
 #ifdef CONFIG_MIPS_MT_SMP
 	extern const struct plat_smp_ops vsmp_smp_ops;
 
+	if (!cpu_has_mipsmt)
+		return -ENODEV;
+
 	register_smp_ops(&vsmp_smp_ops);
 
 	return 0;
-- 
2.33.1

