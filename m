Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6734D5572
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbiCJXef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbiCJXec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:34:32 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A191470E4;
        Thu, 10 Mar 2022 15:33:30 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 25so9924922ljv.10;
        Thu, 10 Mar 2022 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUJ4ImL9tf6/f5vEAu829D+42Y3bnObwD/XuK2B3r0k=;
        b=DUgOevoktxeMoR8rpla4IBMUnrX6U3wJsTO1Epxm9BT2htpZfFSnxrnc4Z6SDeN78n
         V0ghTTgf6rRRiJOd8sOjxmxz26iELMD1Dq4EBoF6+9/2ffWi4hMWMy7Z/2HlQEY56p1M
         p9oDS/TN5+zbIhFIiZQHabWQf72mHC1silRuLvlrrUfHgAYsfoVxOc6B+X/MZ4k4GS1a
         fzoIKHeJXawQcFyB+qWGkRJJEbVr8cswWNPMlD2usO5BTrOxpEczRWFhJkxZ03URexEc
         2nTfQTmzxTBGbUvnWLPz7lolN/DzSTuFzm6kVws+9e6Eq4ivXZq9OBiX6iEnPODcYzBy
         vAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUJ4ImL9tf6/f5vEAu829D+42Y3bnObwD/XuK2B3r0k=;
        b=Ph8oms5+JxyhzjMNd5WlHHG29UM362gwv0FyqzmM9+FStT8A8f1AY6ECw5gLW92sdU
         9xLp/fQx4YD0NLM8/5STaK1MImI7eyQQEZX/v3tmSn51kCKvQuNU/ckMXEg8yscVtPfm
         dGSUHmFIv2AICElDUct5AitajswvpNwBSRLS0AHdQG/R5yuTQyfl/i7c0QCTzQ1nTlNd
         UGWVslHcCQcjEPpcXOTm3pNLfhJlWSh603wEcDKaTL9gBqXOXsTJvAahopXoAfLOs7In
         SAjgtycNFTPuhjin+TfiPM36JLzMZ3ccQjoodeEHD9R3beipuqZ5TTFjfuTvXJfJZpua
         pzPg==
X-Gm-Message-State: AOAM5335ql7Juo1t1v9h5ZUfwUzz2MrYvYvlzBLeYQA68nZNTJEdVu/l
        k026jXHW4fPvtMMXU+d1YNg=
X-Google-Smtp-Source: ABdhPJyZTgGXsWDcKgPB7kqQNoQ2tCUw1aInmaepISZgVgnRArl/bCV5+Br67z00AbckGjVd+4QadA==
X-Received: by 2002:a05:651c:1403:b0:246:34e0:bc16 with SMTP id u3-20020a05651c140300b0024634e0bc16mr4472223lje.98.1646955208843;
        Thu, 10 Mar 2022 15:33:28 -0800 (PST)
Received: from dell.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id s5-20020ac24645000000b00448628b8462sm598481lfo.249.2022.03.10.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:33:28 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 1/4] ARM: OMAP1: clock: Remove unused code
Date:   Fri, 11 Mar 2022 00:33:04 +0100
Message-Id: <20220310233307.99220-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310233307.99220-1-jmkrzyszt@gmail.com>
References: <20220310233307.99220-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code of OMAP1 clocks contains quite a few unused elements:
- functions and function like macros never called: clk_reparent(),
  recalculate_root_clocks(), clk_enable_init_clocks(),
  omap_clk_get_by_name(), omap_clk_disable_autoidle_all(),
  __clk_get_parent(clk), __clk_get_rate(),
- unused structure fields:
  - clkops: .find_idlest(), .find_companion(), .deny_idle(),
  - clk: .src_offset, as well as .clkdm -- no longer present but still
    mentioned in comments,
- definitions of unused flags: INVERT_ENABLE, CLOCK_CLKOUTX2,
- definitions of unused data types: struct clk_functions,
- prototypes of functions with no implementation: clk_init(),
  omap1_watchdog_recalc().
- declarations of never defined global variables: clkops_dummy.
Drop them.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/clock.c | 81 -------------------------------------
 arch/arm/mach-omap1/clock.h | 53 +-----------------------
 2 files changed, 2 insertions(+), 132 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 9d4a0ab50a46..5622ad487c8b 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -734,17 +734,6 @@ unsigned long omap_fixed_divisor_recalc(struct clk *clk)
 	return clk->parent->rate / clk->fixed_div;
 }
 
-void clk_reparent(struct clk *child, struct clk *parent)
-{
-	list_del_init(&child->sibling);
-	if (parent)
-		list_add(&child->sibling, &parent->children);
-	child->parent = parent;
-
-	/* now do the debugfs renaming to reattach the child
-	   to the proper parent */
-}
-
 /* Propagate rate to children */
 void propagate_rate(struct clk *tclk)
 {
@@ -759,24 +748,6 @@ void propagate_rate(struct clk *tclk)
 
 static LIST_HEAD(root_clks);
 
-/**
- * recalculate_root_clocks - recalculate and propagate all root clocks
- *
- * Recalculates all root clocks (clocks with no parent), which if the
- * clock's .recalc is set correctly, should also propagate their rates.
- * Called at init.
- */
-void recalculate_root_clocks(void)
-{
-	struct clk *clkp;
-
-	list_for_each_entry(clkp, &root_clks, sibling) {
-		if (clkp->recalc)
-			clkp->rate = clkp->recalc(clkp);
-		propagate_rate(clkp);
-	}
-}
-
 /**
  * clk_preinit - initialize any fields in the struct clk before clk init
  * @clk: struct clk * to initialize
@@ -827,42 +798,6 @@ void clk_unregister(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_unregister);
 
-void clk_enable_init_clocks(void)
-{
-	struct clk *clkp;
-
-	list_for_each_entry(clkp, &clocks, node)
-		if (clkp->flags & ENABLE_ON_INIT)
-			clk_enable(clkp);
-}
-
-/**
- * omap_clk_get_by_name - locate OMAP struct clk by its name
- * @name: name of the struct clk to locate
- *
- * Locate an OMAP struct clk by its name.  Assumes that struct clk
- * names are unique.  Returns NULL if not found or a pointer to the
- * struct clk if found.
- */
-struct clk *omap_clk_get_by_name(const char *name)
-{
-	struct clk *c;
-	struct clk *ret = NULL;
-
-	mutex_lock(&clocks_mutex);
-
-	list_for_each_entry(c, &clocks, node) {
-		if (!strcmp(c->name, name)) {
-			ret = c;
-			break;
-		}
-	}
-
-	mutex_unlock(&clocks_mutex);
-
-	return ret;
-}
-
 int omap_clk_enable_autoidle_all(void)
 {
 	struct clk *c;
@@ -879,22 +814,6 @@ int omap_clk_enable_autoidle_all(void)
 	return 0;
 }
 
-int omap_clk_disable_autoidle_all(void)
-{
-	struct clk *c;
-	unsigned long flags;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-
-	list_for_each_entry(c, &clocks, node)
-		if (c->ops->deny_idle)
-			c->ops->deny_idle(c);
-
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return 0;
-}
-
 /*
  * Low level helpers
  */
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index f3b8811f5ac0..7bebd488f1be 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -43,56 +43,28 @@ struct omap_clk {
 
 /* Temporary, needed during the common clock framework conversion */
 #define __clk_get_name(clk)	(clk->name)
-#define __clk_get_parent(clk)	(clk->parent)
-#define __clk_get_rate(clk)	(clk->rate)
 
 /**
  * struct clkops - some clock function pointers
  * @enable: fn ptr that enables the current clock in hardware
  * @disable: fn ptr that enables the current clock in hardware
- * @find_idlest: function returning the IDLEST register for the clock's IP blk
- * @find_companion: function returning the "companion" clk reg for the clock
  * @allow_idle: fn ptr that enables autoidle for the current clock in hardware
- * @deny_idle: fn ptr that disables autoidle for the current clock in hardware
- *
- * A "companion" clk is an accompanying clock to the one being queried
- * that must be enabled for the IP module connected to the clock to
- * become accessible by the hardware.  Neither @find_idlest nor
- * @find_companion should be needed; that information is IP
- * block-specific; the hwmod code has been created to handle this, but
- * until hwmod data is ready and drivers have been converted to use PM
- * runtime calls in place of clk_enable()/clk_disable(), @find_idlest and
- * @find_companion must, unfortunately, remain.
  */
 struct clkops {
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
-	void			(*find_idlest)(struct clk *, void __iomem **,
-					       u8 *, u8 *);
-	void			(*find_companion)(struct clk *, void __iomem **,
-						  u8 *);
 	void			(*allow_idle)(struct clk *);
-	void			(*deny_idle)(struct clk *);
 };
 
 /*
  * struct clk.flags possibilities
  *
  * XXX document the rest of the clock flags here
- *
- * CLOCK_CLKOUTX2: (OMAP4 only) DPLL CLKOUT and CLKOUTX2 GATE_CTRL
- *     bits share the same register.  This flag allows the
- *     omap4_dpllmx*() code to determine which GATE_CTRL bit field
- *     should be used.  This is a temporary solution - a better approach
- *     would be to associate clock type-specific data with the clock,
- *     similar to the struct dpll_data approach.
  */
 #define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
 #define CLOCK_IDLE_CONTROL	(1 << 1)
 #define CLOCK_NO_IDLE_PARENT	(1 << 2)
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
-#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
-#define CLOCK_CLKOUTX2		(1 << 5)
 
 /**
  * struct clk - OMAP struct clk
@@ -113,9 +85,8 @@ struct clkops {
  * @fixed_div: when > 0, this clock's rate is its parent's rate / @fixed_div
  * @flags: see "struct clk.flags possibilities" above
  * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
- * @src_offset: bitshift for source selection bitfield (OMAP1 only)
  *
- * XXX @rate_offset, @src_offset should probably be removed and OMAP1
+ * XXX @rate_offset should probably be removed and OMAP1
  * clock code converted to use clksel.
  *
  * XXX @usecount is poorly named.  It should be "enable_count" or
@@ -126,7 +97,7 @@ struct clkops {
  * clocks and decremented by the clock code when clk_disable() is
  * called on child clocks.
  *
- * XXX @clkdm, @usecount, @children, @sibling should be marked for
+ * XXX @usecount, @children, @sibling should be marked for
  * internal use only.
  *
  * @children and @sibling are used to optimize parent-to-child clock
@@ -153,36 +124,18 @@ struct clk {
 	u8			fixed_div;
 	u8			flags;
 	u8			rate_offset;
-	u8			src_offset;
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 	struct dentry		*dent;	/* For visible tree hierarchy */
 #endif
 };
 
-struct clk_functions {
-	int		(*clk_enable)(struct clk *clk);
-	void		(*clk_disable)(struct clk *clk);
-	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
-	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
-	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
-	void		(*clk_allow_idle)(struct clk *clk);
-	void		(*clk_deny_idle)(struct clk *clk);
-	void		(*clk_disable_unused)(struct clk *clk);
-};
-
-extern int clk_init(struct clk_functions *custom_clocks);
 extern void clk_preinit(struct clk *clk);
 extern int clk_register(struct clk *clk);
-extern void clk_reparent(struct clk *child, struct clk *parent);
 extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
-extern void recalculate_root_clocks(void);
 extern unsigned long followparent_recalc(struct clk *clk);
-extern void clk_enable_init_clocks(void);
 unsigned long omap_fixed_divisor_recalc(struct clk *clk);
-extern struct clk *omap_clk_get_by_name(const char *name);
 extern int omap_clk_enable_autoidle_all(void);
-extern int omap_clk_disable_autoidle_all(void);
 
 extern const struct clkops clkops_null;
 
@@ -208,7 +161,6 @@ extern int omap1_select_table_rate(struct clk *clk, unsigned long rate);
 extern long omap1_round_to_table_rate(struct clk *clk, unsigned long rate);
 extern int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate);
 extern long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate);
-extern unsigned long omap1_watchdog_recalc(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 extern void omap1_clk_disable_unused(struct clk *clk);
@@ -278,7 +230,6 @@ extern __u32 arm_idlect1_mask;
 extern struct clk *api_ck_p, *ck_dpll1_p, *ck_ref_p;
 
 extern const struct clkops clkops_dspck;
-extern const struct clkops clkops_dummy;
 extern const struct clkops clkops_uart_16xx;
 extern const struct clkops clkops_generic;
 
-- 
2.35.1

