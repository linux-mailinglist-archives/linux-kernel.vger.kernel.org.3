Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2164857A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiAERuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbiAERt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:49:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6062C061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:49:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so158272pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avw5HSrXY0Vlq51idfwQnJ2MBQ3Q9JHHhfd/FHxvDQA=;
        b=O23DmkMTAnO55Ze2LqGoBS8Pagi8aGpW0waPSaCpjGuIydNewyEh9vByfs23we2pA2
         QvgmKsU7HR/7OuLU8CsTCQjneLrigA0mAuDIniyg2dZj+XpI4mmCBkdohPITC/opVdQV
         1UnbUjV4wxPgYQPpQ+QemLIukL8cI7txLwB+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avw5HSrXY0Vlq51idfwQnJ2MBQ3Q9JHHhfd/FHxvDQA=;
        b=qInXYlSKwmQlEo82Pf34gyyEGrmCRy0wA7KX2eRD7tQUMYCuPWys/8E1MgoHxGq1FM
         nxpi/boup/NZgCGVOZXjAeKTQZuMNB1Z8PwO86Rz/VFNkV1B32r29v+tZGNUV/AwD9c0
         yn+B0H600mY6VZ9m5vddRISteGrRinzHQzxeAG6dgc8jsWrVaCUDBgrC/V82eESeNSm6
         hp/ul6BXRCcjzCVs4vzUaL8TTzf9vd6cWTFTGugxwGrIXiVeTk16eucQSd2lpTtd/tDt
         qdg45Km+rTo//mpRvdG5ak/2MtHOSYD+o+2Q5J9KUWqg8ZxG3riaVgqkHggejLuA/80o
         MTUg==
X-Gm-Message-State: AOAM532tJYM+ohAjr0vxJfUjzOiysck9tQX/Exzc95qN2B0le7EV1WD0
        7j0eC1GW6Gw3SJnBQCXRZTLNOg==
X-Google-Smtp-Source: ABdhPJz/dxRRRh4uPw6QnXdozlZ9uMNkiwOK9hyg7OhOyJ5idyGSBpiy/K0VcdePtHbUTugZT6cH/A==
X-Received: by 2002:a17:90b:4b0e:: with SMTP id lx14mr5384530pjb.132.1641404995383;
        Wed, 05 Jan 2022 09:49:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15sm31852199pfh.86.2022.01.05.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:49:55 -0800 (PST)
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
        linux-crypto@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] crypto: octeontx2 - Avoid stack variable overflow
Date:   Wed,  5 Jan 2022 09:49:53 -0800
Message-Id: <20220105174953.2433019-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3920; h=from:subject; bh=TAb+RjlCN1zMWQVj1GkCs/zmVHixIJXI70KMPnc0yjA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh1dpBUQ47BXPtqm+Ra117gf9RyNvDqxFztuIfpAis XR/PcHiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYdXaQQAKCRCJcvTf3G3AJrDED/ 9D+LJxsDS9TLmkWXQLJQOs7R7T1lKCChisZoQP8qL59/raHyHD1eamIDLpFnJK3XMq9u9iRRuJjHfm kZotmq5ofVo/C6Hi7OSl3fTPzyAkwkZ7k0wIU9zvevlOzy1aiMK8GvqqvSi/J1gVk+8kGCXEyUYk2u r4XaawMyP2zk4TI5dcXTxZzd6kRsiTNsav79ueWGKDFVq4THMg9TW6ed0HRuMGKgDZ8ZAc+yRQx73m 1bEoXpGe+SLSOkXMKQq6vE9uFrKHNM8rj5T8xqk/vcQGqzlvHY4Ux8eYxq2sbZ86l4obQvLReof17k 22eVZScMddmMt1ce0WO3PXigZRECI6UlPH6TVS/91axJjfAXBF7+6gxT5SlpdTv4S0ro2enT/O+BBC /+f7FmjCeYZmyZupnR7qIwEn5fA8N2o7LD32Z8UfrkXY0uE1iVxw+bHBKBFrNzuPbn5yPZ5zDPsI1i 574wMDMDYBBOXN3uwMY7iq/tZf2dEvD5avJRtXt4mtcgcS/dL2QcXsma0tv4h41QcGaGkxxX1Np/Gq bqYSmpA6fZ7WB3J2cA+2qTxFYWSzCCycRjMkn9bwT/I/4vk0dibj/CJQIPy4/9sdWM/0O43d7TqHID iFv6gJkVJNi5u1hAFOZPVC7XyiOSll9E3YDw2PyC0kynz8vTw/IiUQIyBBWQ==
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
storage. 4 * 32 == 128, so this must be 5: 5 * 32bit = 150.

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
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20211215225558.1995027-1-keescook@chromium.org/
v2:
 - expliticly zero "mask"
 - explain math in commit log
 - move definition into local context
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

