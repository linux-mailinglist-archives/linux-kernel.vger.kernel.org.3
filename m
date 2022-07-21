Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342AB57D5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiGUVRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiGUVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:17:36 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9266074362
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:17:35 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdY2-001tWU-2x;
        Thu, 21 Jul 2022 22:17:30 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 3/3] arm: fix undeclared soft_restart
Date:   Thu, 21 Jul 2022 22:17:29 +0100
Message-Id: <20220721211729.451731-4-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721211729.451731-1-ben-linux@fluff.org>
References: <20220721211729.451731-1-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soft_restart() is declared in <asm/system_misc.h> so
include that to fix the following sparse warning:

arch/arm/kernel/reboot.c:78:6: warning: symbol 'soft_restart' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 2cb943422554..3f0d5c3dae11 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -10,6 +10,7 @@
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
 #include <asm/virt.h>
+#include <asm/system_misc.h>
 
 #include "reboot.h"
 
-- 
2.35.1

