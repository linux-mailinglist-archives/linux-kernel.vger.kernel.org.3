Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D652025A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbiEIQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbiEIQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:27:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939BA267C30;
        Mon,  9 May 2022 09:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 526D5B817E5;
        Mon,  9 May 2022 16:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D49C385AC;
        Mon,  9 May 2022 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652113423;
        bh=FwXO3JACkg3sY4dA/R+BvoEHsuUOyXZesgC8uLp382Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8uSniqMZqOXFG9O7Nk2Dk2ArAW8XkksmnqlDJ+zFtLseUC0uM5wlwP6iQjVnEUtb
         GU09qu8I4chB+Kewwt7nmV0MfK05y2oikCySLw8TWXbzQr5n+xtn0KvG7XLB/bmXwj
         TkHu5PCrY6eiG+FiEAE2VTaeC+E+9FaXtfyxaWrGUAtmZP960adBkqjgORqnmAfVUz
         hXG1Rnt1WpNyLI+GVin684xH/TzgevDgdIbp1DdQ8r8T5QG7tcOcJ5rC6OV7VXjS/8
         TKGQZfVWW9yu9QzUI//IXm4wuqGyWWbGwv0Id5li44ruIR51jpCJuuWJzKhDBGmyON
         8mpI+NeW9WMXQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1no6Ae-006xVX-Jf; Mon, 09 May 2022 18:23:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Kai Vehmanen" <kai.vehmanen@intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@intel.com>,
        "Takashi Iwai" <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
        mauro.chehab@linux.intel.com
Subject: [PATCH v6 3/4] module: set holders when symbol_get() is used
Date:   Mon,  9 May 2022 18:23:38 +0200
Message-Id: <e8058ca7a0b84479f4075654cecff811916639ce.1652113087.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1652113087.git.mchehab@kernel.org>
References: <cover.1652113087.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Kernel modules use symbol_get() or symbol_request() in order
to bind into other drivers. That's the case, for instance, of
media dvb drivers that hook the frontend drivers via I2C using
dvb_attach() macro.

When such bindings happen, one needs first to unload/unbind the
driver that got the symbol before being able to unload/unbind the
module that contains the needed symbol.

Add a logic to document it via /proc/modules and via lsmod.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v6 0/4] at: https://lore.kernel.org/all/cover.1652113087.git.mchehab@kernel.org/

 drivers/mtd/chips/gen_probe.c           | 4 ++--
 include/linux/module.h                  | 4 ++--
 kernel/module/main.c                    | 3 ++-
 samples/hw_breakpoint/data_breakpoint.c | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
index 4d4f97841016..f1e97633ac09 100644
--- a/drivers/mtd/chips/gen_probe.c
+++ b/drivers/mtd/chips/gen_probe.c
@@ -208,10 +208,10 @@ static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map,
 	if (!probename)
 		return NULL;
 
-	probe_function = __symbol_get(probename);
+	probe_function = __symbol_get(probename, THIS_MODULE);
 	if (!probe_function) {
 		request_module("cfi_cmdset_%4.4X", type);
-		probe_function = __symbol_get(probename);
+		probe_function = __symbol_get(probename, THIS_MODULE);
 	}
 	kfree(probename);
 
diff --git a/include/linux/module.h b/include/linux/module.h
index a66b9be92ef5..07a77c2618b5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -298,8 +298,8 @@ struct notifier_block;
 
 extern int modules_disabled; /* for sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
-void *__symbol_get(const char *symbol);
-#define symbol_get(x) ((typeof(&x))(__symbol_get(__stringify(x))))
+void *__symbol_get(const char *symbol, struct module *this);
+#define symbol_get(x) ((typeof(&x))(__symbol_get(__stringify(x), THIS_MODULE)))
 
 /* modules using other modules: kdb wants to see this. */
 struct module_use {
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6044aeba0f18..ec1baa67d6e7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1259,7 +1259,7 @@ static void free_module(struct module *mod)
 #endif
 }
 
-void *__symbol_get(const char *symbol)
+void *__symbol_get(const char *symbol, struct module *this)
 {
 	struct find_symbol_arg fsa = {
 		.name	= symbol,
@@ -1273,6 +1273,7 @@ void *__symbol_get(const char *symbol)
 		return NULL;
 	}
 	preempt_enable();
+	ref_module_dependency(fsa.owner, this);
 	return (void *)kernel_symbol_value(fsa.sym);
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 418c46fe5ffc..30b3261a894b 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -41,7 +41,7 @@ static int __init hw_break_module_init(void)
 {
 	int ret;
 	struct perf_event_attr attr;
-	void *addr = __symbol_get(ksym_name);
+	void *addr = __symbol_get(ksym_name, THIS_MODULE);
 
 	if (!addr)
 		return -ENXIO;
-- 
2.35.3

