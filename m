Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A6A550915
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiFSHJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiFSHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:09:21 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10C83E0D3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2PsZd
        jyzRgibkKcfmt7102zdLXKY1lTTAZOE+Is/NfY=; b=ZyWnJKg7i1LydfgwR3+bX
        MNsMFfGXnbaZ7KS+9bc1/zxhMeBq5mz1r8yYeO9454ZjuWxCrztVu0YMGJl+xDnu
        aSrxAvzk2JrYfb1kHZqz/omBY+HsyGRVrz5OxEPWviADSfqnHQAdgtKZJxYtylHH
        Qnd4CV/0jesR6dFybCeDkE=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgBnf4Bcy65ipKfMEw--.65437S2;
        Sun, 19 Jun 2022 15:08:12 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, npiggin@gmail.com
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: kernel: Fix refcount bug in legacy_serial.c
Date:   Sun, 19 Jun 2022 15:08:11 +0800
Message-Id: <20220619070811.4067215-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgBnf4Bcy65ipKfMEw--.65437S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF17ArWUZr1UuF4xAFW8WFg_yoW3uwb_J3
        s7Wr12kr1UWr4YvwnakFW5Gr4Yywn7Wa4FqFyq9343Ga4DKFsxGF17tFyqqr1DZws8JFZ3
        CF93JF97Jw4v9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjFdyUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBwlF2JVj7Po9gAAsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In find_legacy_serial_ports(), of_find_node_by_path() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/kernel/legacy_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 5c58460b269a..f048c424c525 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -471,6 +471,8 @@ void __init find_legacy_serial_ports(void)
 	}
 #endif
 
+	of_node_put(stdout);
+
 	DBG("legacy_serial_console = %d\n", legacy_serial_console);
 	if (legacy_serial_console >= 0)
 		setup_legacy_serial_console(legacy_serial_console);
-- 
2.25.1

