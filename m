Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2418A4B19D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbiBJXva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:51:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345898AbiBJXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:51:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35885F75
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:51:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c188so9467168iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5dCk4FzrvHhwMLJneJLOY/dcPEyndJPxlHaJYZoEpFk=;
        b=B1e0SDNthk73k00xBMHULPHNIG3scZT8MMQCtDDPnU+ASlc9VWbUNkMJUQyffY7IX3
         ivfLQgs2A0MMN67WzKhJN1yYRIeVxUbOJC97r1Uo7/Ud5PSY+sMUmiE3J2p98UTQG6GP
         YjbJLQlKrjHocWLIvy91hrv2GnSfof1DojUtZvNFpr9clikRnI5AbeBFI8/LzGFF8yvc
         PWBDZnWUwg3yTvitIhOsZbIsvGDr8RlY2ppLGa1yYFFJnLF0RsW89FGsn0vD0bLq0Qua
         O/Y5CXY31dui1uTHUtqZeyfGc1gsBTxupgmi1RZNfFmWHPLRsj52a+D//O0z3xR4USab
         Kklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dCk4FzrvHhwMLJneJLOY/dcPEyndJPxlHaJYZoEpFk=;
        b=PT3WSn7aZetEyB6g/82iMAbOqd285RIgUXzgjD5LgGXP+gIjtRB4GfFe0FC2GlgmBe
         H6aXXJB+c27ATtDx3ux2eL4Tv5NdWBaPTM54jZvbzfbrH7+XYgvj6TjoOyUY4sgomOaT
         AQIHzpH0L3cS+2OhQMqtEAf31OQCB9wuZ0Q9l1KpWcQTFg4Vi3d/75J2JIdJnXT5vo1T
         Wk5/ECRWMTBawJjhGs/hSlU/4q8AHqdby1DgG8yJ4/3eGigT6DBBi1t0yu86WnL+UEPw
         QVnSdG1ZPh7OmgTpX0I5rynFxE4dffVOCgo832YJoB1F1DTYCII0fP9Y4QcLgkqzAL/q
         8o0A==
X-Gm-Message-State: AOAM5317RTrqx914BWwHZb/bZ2R3URHblD6JJdbeCIsRqoqc9ZgB+WPp
        rrO0A6KWsSBDwsajsVZzEWc=
X-Google-Smtp-Source: ABdhPJysecqyF1xHXIb448cPo+Fqbe1UTP2z1seIWAOfE9T/8KCaZ4AyX268s5gQTwQDF3OArZz/Ag==
X-Received: by 2002:a05:6638:260b:: with SMTP id m11mr5150240jat.55.1644537088359;
        Thu, 10 Feb 2022 15:51:28 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id q2sm6614751ilt.33.2022.02.10.15.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:51:27 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 27/49] arch/x86: replace bitmap_weight with bitmap_weight_{eq,gt,ge,lt,le} where appropriate
Date:   Thu, 10 Feb 2022 14:49:11 -0800
Message-Id: <20220210224933.379149-28-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__init_one_rdt_domain in rdtgroup.c code calls bitmap_weight() to compare
the weight of bitmap with a given number. We can do it more efficiently
with bitmap_weight_lt because conditional bitmap_weight() may stop
traversing the bitmap earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e23ff03290b8..9d42e592c1cf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2752,7 +2752,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	 * bitmap_weight() does not access out-of-bound memory.
 	 */
 	tmp_cbm = cfg->new_ctrl;
-	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
+	if (bitmap_weight_lt(&tmp_cbm, r->cache.cbm_len, r->cache.min_cbm_bits)) {
 		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
-- 
2.32.0

