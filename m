Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5D5295E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiEQAMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiEQAMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:12:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF1E0BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:12:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p2-20020a25d802000000b0064d9002a5abso4248429ybg.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=POSUQDnHPrpNehehyVbBQzZS/bdNcKX8LMqXFHOPYiQ=;
        b=F7MTUDzBqqXmZTgOG1Blw7YHBcIMvU3AZ+oaermvjpTkUV1IcxqB0FaQN+BZFIXdOT
         tbcybxWl0hiGKWQMuApoHEL1nWa0GMmMHktHEW8naewTRLqMC20k/5J0bkgxxLIefWAa
         uwSRZts3L5DxRlFnsRPjYP99jXzjhtkB0XnXzAlcLWZXZsNURpOBs3/wvSu8m3EdG9zZ
         bCzgD4TliZUNwBD6Rr0zMOE9lsPmb12auG2iA/XtXRDnYWkUyeUAohBSwSTVxAfoP9Px
         MIPRxClfRDrQzjEthWUNNBYYSqhUERXGbDQLgYGGYcyoh85xGMTyEx8Ll98X+R72vLLQ
         SK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=POSUQDnHPrpNehehyVbBQzZS/bdNcKX8LMqXFHOPYiQ=;
        b=N3NS2sEX8RvaWfBp7o9DN9NAH1F8YOMadQ653bjfbhYmRAgSC6STr7onw/oFBUDCf5
         TO+BbWlh2vXyQ2MifwMwKKsUqrjbb+hJ+X2Z7RuJi4u7PlovjSfS7wDCo8p7DmhAeN1j
         Tuc++Q0YztcJvP8TZOgamxKAHrDVTgwis42lSrwSEOGr16zVu5plbGDtVmzAjKSUwetn
         LNQDcaLxJX/s4VGRSy5G+Rn6GruuqxW95TTwZWihW/XmflFLZX2GlRrYt1kfNJMcuA1N
         A0LHx0ouwrN47IoqiO34POu3i/Zz3XXeg72YPkqpplxqpO8X9q8irCQ+XrV73MNaIf8o
         OEtQ==
X-Gm-Message-State: AOAM5327s+3sBi6AAaDs96JyDHMDlet7qsi2uRSdTgszhJ2Z59VC30Qg
        s1d2Mv/sAgLJnwdVpKjBDBJkBMa3mS84oQsG/rc2MoViJr7Fa6m94eyoyOKJEcj1daO7ja/DOto
        NxNOM8C9MzArHcZZzBlW2NaB+TSFkNV/7XZq9iZOJkt35ZBmck9/DRjNqdNMCvYSXoIqMurS8
X-Google-Smtp-Source: ABdhPJw7wkOQEnebG0bKDEfy+HO9/dT6x/P8BAv9r1r6AFgai6HwZg0ceermgPNfExmtjbfP+GG2DmGNXpJW
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:666:6be0:2971:54bb])
 (user=eranian job=sendgmr) by 2002:a81:200b:0:b0:2f8:5866:9eb0 with SMTP id
 g11-20020a81200b000000b002f858669eb0mr23219985ywg.269.1652746357705; Mon, 16
 May 2022 17:12:37 -0700 (PDT)
Date:   Mon, 16 May 2022 17:12:34 -0700
Message-Id: <20220517001234.3137157-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        babu.moger@amd.com, x86@kernel.org
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

However given the unified code in cbm_validate(), checking for:

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

Patch initializes fixes the logic in cbm_validate() to take into account
arch_has_empty_bitmaps when true and cbm value is 0.

Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 87666275eed9..f376ed8bff8f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -107,6 +107,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
+	/* no need to check bits if arch supports no bits set */
+	if (r->cache.arch_has_empty_bitmaps && val == 0)
+		goto done;
+
 	/* Are non-contiguous bitmaps allowed? */
 	if (!r->cache.arch_has_sparse_bitmaps &&
 	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
@@ -119,7 +123,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 				    r->cache.min_cbm_bits);
 		return false;
 	}
-
+done:
 	*data = val;
 	return true;
 }
-- 
2.36.0.550.gb090851708-goog

