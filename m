Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5558F48CD23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357653AbiALUiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357655AbiALUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:38:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31978C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:38:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u15so5989889ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXEuA78tHa8OG6WX+svmtO4V0nZdM7kQVDQ3t8swxFM=;
        b=Gb+bKoQcu9s52iCDHmppZrE5eenmKqfYetcUMYRDayPX4js2rVPhDF2q23JETt+hNl
         902UexZOvk4dn5i+yL2sFG1zR8N6fA3eftxL+QONpDARKm+pp2eg5KHc7LlqfcOpMDrV
         /Tycp4FTjw6qiw8SMmcLXM+cbT7owZBWfx8SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXEuA78tHa8OG6WX+svmtO4V0nZdM7kQVDQ3t8swxFM=;
        b=e83IGX3jtLNavTCifbi+nMS7OqVDQtElguVjEM974jgPhSK9RuzB0AIws36MJdQ4HI
         7PNDziq3RUT9cXyFRMSOdNoarImPMeqc+LDyqowoyZjoWFPojyGYm0UTQ/j43ZkfQCtJ
         Nozj4EiEjeFyP/54yiWmYx5GVIQs+LkppuNdwybuCjv0omxbVQcUK0qlWheQF6WZqwBO
         BjA4I+dxLDeQnsQoHCuJ1qYQ5Cj6yhwGi6ju9FTe34UGAOuXXH4+QfquVAXszwXxXh3q
         Y/5N9kHI8feC9kheOwsLCkTGZPA5opvc1yF3Okjm8aUv4D+CuCfT+kGQYBF/+lS678y+
         rLvA==
X-Gm-Message-State: AOAM532qRdRlesB937HJ5HNR/SZy8t9nzv5P/gGcp4d48eA2KFshsEt4
        gYGgQoUz3FqR/glgTx97SeibCA==
X-Google-Smtp-Source: ABdhPJxU/y2DtjYkNXrpmMymPd6+q28hpSkRbKDXEZbkXIJQIffEdPMetF3V+BBu7/jnEVudB0CQTQ==
X-Received: by 2002:a05:6a00:1309:b0:4bc:c640:73f9 with SMTP id j9-20020a056a00130900b004bcc64073f9mr1279526pfu.50.1642019893730;
        Wed, 12 Jan 2022 12:38:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm430492pgp.76.2022.01.12.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:38:13 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Suheil Chandran <schandran@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] crypto: octeontx2 - Avoid stack variable overflow
Date:   Wed, 12 Jan 2022 12:38:11 -0800
Message-Id: <20220112203811.3951406-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990; h=from:subject; bh=24l0V2SW4hG2ReYs2bH4yrryloA0CF7/+v3/Mn8IdFk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh3zwzSlJZlf/2YQT57WwROp5xjXUdokUVP82L8vDu udHFTueJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYd88MwAKCRCJcvTf3G3AJpdWEA CIfVU8vLjPvokqNqy4WQTJ5pwoNW4g777CwcSRlGvIqYT6TMsHTaX1Z5ziGqiaD1wsWH5Oa2R22kaK 4KBGnoaYP4YOa8qHTIEebqYPwPO5VKekhnt41eRqU/Tt4Pm2VtwlsPR38dx0NE4YxHseu7eEXsOMKr qdPsvjzKYiGoD68e577avJ+KX91tyG01Ix0p0U+hM9A/SivRP5GKojF6GWdlNBgyVz7DXAi4M3Me8U HIXoOiheDpiB+v/+tdC+QBuEM2K56R5hDAxUVcoq1xNNj4YfzQ/Ze2xCAFqXO8vB9/kBHeEYoFhBP7 20c0Uk6c0b2GIS9xu33rqld81u1zjoRdfqeEj6Lh5zEG3e/MoqpwQHWc3skrDJ+qh9eGe9kkMs3YlW bQNuI2o6K4MH6aH1JsOohfE2xeaSVTCgzU9aEHcI6rYO4WHM6+8Srbs6b9SJcp/EdmHGQh1QKy1qNc Zqh1H99M9bBmzvNOHqWu+eJNdkrAw3re+RizZNW1RxXqNc3rzQWQRasauRLRx07NDnvLiJqwte4bDc eYr1cRQtJ7//Ctjm7JB6y03sWJLw2l5VXYAF7cvwkmCcvH6x0yJ03+uEITrUucdNJ4nqIPNVZtnOlJ +NQ3TtNORhl2h0JU/1SLM8YdGthh6kmIBNTjLPvi3l4aWCvainrPv83D49Wg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with -Warray-bounds showed a stack variable array index
overflow. Increase the expected size of the array to avoid the warning:

In file included from ./include/linux/printk.h:555,
                 from ./include/asm-generic/bug.h:22,
                 from ./arch/x86/include/asm/bug.h:84,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/firmware.h:7,
                 from drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:5:
drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c: In function 'otx2_cpt_print_uc_dbg_info':
./include/linux/dynamic_debug.h:162:33: warning: array subscript 4 is above array bounds of 'u32[4]' {aka 'unsigned int[4]'} [-Warray-bounds]
  162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |                                 ^
./include/linux/dynamic_debug.h:134:17: note: in definition of macro '__dynamic_func_call'
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                 ^~~~
./include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
  162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:570:9: note: in expansion of macro 'dynamic_pr_debug'
  570 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:1807:41: note: in expansion of macro 'pr_debug'
 1807 |                                         pr_debug("Mask: %8.8x %8.8x %8.8x %8.8x %8.8x",
      |                                         ^~~~~~~~
drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:1765:13: note: while referencing 'mask'
 1765 |         u32 mask[4];
      |             ^~~~

This is justified because the mask size (eng_grps->engs_num) can be at
most 144 (OTX2_CPT_MAX_ENGINES bits), which is larger than available
storage. 4 * 32 == 128, so this must be 5: 5 * 32bit = 160.

Additionally clear the mask before conversion so trailing bits are zero.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Srujana Challa <schalla@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Suheil Chandran <schandran@marvell.com>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Lukasz Bartosik <lbartosik@marvell.com>
Cc: linux-crypto@vger.kernel.org
Fixes: d9d7749773e8 ("crypto: octeontx2 - add apis for custom engine groups")
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20211215225558.1995027-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20220105174953.2433019-1-keescook@chromium.org/
v3:
 - Fix commit log math typo
 - Add Ack
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 4c8ebdf671ca..1b4d425bbf0e 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1753,7 +1753,6 @@ void otx2_cpt_print_uc_dbg_info(struct otx2_cptpf_dev *cptpf)
 	char engs_info[2 * OTX2_CPT_NAME_LENGTH];
 	struct otx2_cpt_eng_grp_info *grp;
 	struct otx2_cpt_engs_rsvd *engs;
-	u32 mask[4];
 	int i, j;
 
 	pr_debug("Engine groups global info");
@@ -1785,6 +1784,8 @@ void otx2_cpt_print_uc_dbg_info(struct otx2_cptpf_dev *cptpf)
 		for (j = 0; j < OTX2_CPT_MAX_ETYPES_PER_GRP; j++) {
 			engs = &grp->engs[j];
 			if (engs->type) {
+				u32 mask[5] = { };
+
 				get_engs_info(grp, engs_info,
 					      2 * OTX2_CPT_NAME_LENGTH, j);
 				pr_debug("Slot%d: %s", j, engs_info);
-- 
2.30.2

