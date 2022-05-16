Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E6A527D28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbiEPFv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbiEPFvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:51:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91243140F5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:51:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c205-20020a254ed6000000b0064d5bd93479so4674326ybb.17
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rj2DNTSEF4Y6CMqqUHOol/JYY9CiWZuYkZ1EA5RjnFA=;
        b=bQEQ2a9QX8MXYt4Ipws2Mq8gYXiC1bHUE4f91fJJHmjYq8ABD4pTXLJAxZjSh82t6u
         ZQroHawELOQtYBUDoyu9IBcY2pumDAcS1l57/hnmVBEmYVZHerIAcJTkenK7B3O1XR7Q
         ihd16BNOlf4+KMEDQ3xk6Sb1kkvZZRW6EP5WLIUF7hCe2UO6BpxHT7IG7tXUi3FhixaU
         +bzcgFW6xotY25iovsHZQ9AnaH0UC5zGb0szMSjWv1YSm+Y9MpPXHJ2uMIjMLorpT6MK
         cyvZDfv4U1l528JsUrB6CjctRIp9vjmuNTaVEIAbuC7huOoFkdthr21hiJ/l6vRsgi5c
         lbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rj2DNTSEF4Y6CMqqUHOol/JYY9CiWZuYkZ1EA5RjnFA=;
        b=KAa/Qhp6jdXz6DHj0z8LL1IOaOUs5L0XD5m3Ry3zcORvROoyGVYAfqX9zDFOb2dZv5
         BSNfHdoXqlhhghH75A6JTBCnuag9SNQwuyFBiamF59stno8dfiAKt7XEU/CfkGkUAJeM
         znFo4WLcxN3PdcLmg28r+9u48rrU6Tf1C2izCe0JkjPcerxMqAtSWuvApkGkgH4TokHu
         VPVGeu/rjSU7AEJBKZAUUxc1os3+01Fm1msKxres+2nfdRHGCfC2fX3na3Ootb4ub99T
         Spq50jB6DboWqzCl36O/0XqI2pHzElguVTIJWXO3RbIiZsfic09MZgxb8xhtMoXOSg1H
         rZ6A==
X-Gm-Message-State: AOAM5335bgN+nRjecSKQijkMpPIWl5PTzjIpPLwyCF2B0xGHhQwOYsAl
        OkmaLeRUhi/fDV5/DFRj1PQgANeAIDFUtZ1xHViBlKVRrrWYZb052hrEs4QpprZ93Jsb+tkXwzj
        O+OnhKf/Lvjx4RMN1LuiFBYqVsBU/d4MEYbyVP056upY/Si+hkD5ajOrx9iqcyhmzKy4LqlG+
X-Google-Smtp-Source: ABdhPJziSEE1+ImTJhXEJnMoshgC9yhwvEfYqxYvsUN+uqbIa1wvBj6Zl6XXF8udipSDvtnOyih2XZ4zuAf3
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:ecf8:90b8:1674:c786])
 (user=eranian job=sendgmr) by 2002:a25:2a95:0:b0:64b:a767:944c with SMTP id
 q143-20020a252a95000000b0064ba767944cmr12928794ybq.518.1652680259765; Sun, 15
 May 2022 22:50:59 -0700 (PDT)
Date:   Sun, 15 May 2022 22:50:55 -0700
Message-Id: <20220516055055.2734840-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] x86/resctrl: fix min_cbm_bits for AMD
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com, babu.moger@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:

	r->cache.arch_has_empty_bitmaps = true;

However given the unified code in cbm_validate(), checking for

    val == 0 && !arch_has_empty_bitmaps

is not enough because you also have in cbm_validate():
	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)

Default value for if r->cache.min_cbm_bits = 1

Leading to:

$ cd /sys/fs/resctrl
$ mkdir foo
$ cd foo
$ echo L3:0=0 > schemata
-bash: echo: write error: Invalid argument

Patch initializes r->cache.min_cbm_bits to 0 for AMD.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bb1c3f5f60c8..14782361ebb7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -897,6 +897,7 @@ static __init void rdt_init_res_defs_amd(void)
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
 			r->cache.arch_has_per_cpu_cfg = true;
+			r->cache.min_cbm_bits = 0;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
 			hw_res->msr_update = mba_wrmsr_amd;
-- 
2.36.0.550.gb090851708-goog

