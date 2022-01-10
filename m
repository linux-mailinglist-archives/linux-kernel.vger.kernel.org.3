Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965D548990D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiAJNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiAJNAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:03 -0500
Date:   Mon, 10 Jan 2022 13:00:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gg2hqLRpEfuycfD3SFXIH8uDH369qHJtBGbElKCyiw=;
        b=lxo0AszhSTIdBodAqlHnff/Bdo02hwHHbkBWDzK+f8H65Za9YsYkGtuC9R7gnSUtlsThzR
        Myp8jElllhYRiCaO/dutEcj9iKeqWL5YV/KeHFmOf+EWIfoFtM47RnElQC3ZpEeqUOiJ7X
        JFU5ba19mgoykW6u6KVjFJBgHBCrQdl7xjjZ6Rry1/N8sdydN1f9HcsXlCO7PufF4mtIKZ
        zjuZXYzMD6V5dPLJNL/oCELhMIJBU60Rpzqy+10yXvFkhJqt9sMb9YJKHEuhdr+DWUtKyR
        2ddARP9HkpF+qJ5Vzj1sItb5Hf0vEJXdiszWCgsU4EJzEval7IiCfN9mLYaJqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gg2hqLRpEfuycfD3SFXIH8uDH369qHJtBGbElKCyiw=;
        b=G7P/Usfj0SAPndldEl9qY6PxDcn1k3+DFh2i3d/vrX0jHi47y/mcU49GALq+Cd28ActZYS
        N1BbU3KntVay94AQ==
From:   "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] reset: Add of_reset_control_get_optional_exclusive()
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112184413.4391-2-biju.das.jz@bp.renesas.com>
References: <20211112184413.4391-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <164181960008.16921.1670033423151054314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c4f5b30dda01f2f6979a9681142de454991182ee
Gitweb:        https://git.kernel.org/tip/c4f5b30dda01f2f6979a9681142de454991182ee
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Fri, 12 Nov 2021 18:44:10 
Committer:     Philipp Zabel <p.zabel@pengutronix.de>
CommitterDate: Fri, 19 Nov 2021 12:23:45 +01:00

reset: Add of_reset_control_get_optional_exclusive()

Add optional variant of of_reset_control_get_exclusive(). If the
requested reset is not specified in the device tree, this function
returns NULL instead of an error.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211112184413.4391-2-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/reset.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index db0e611..8a21b57 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -455,6 +455,26 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 }
 
 /**
+ * of_reset_control_get_optional_exclusive - Lookup and obtain an optional exclusive
+ *                                           reference to a reset controller.
+ * @node: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Optional variant of of_reset_control_get_exclusive(). If the requested reset
+ * is not specified in the device tree, this function returns NULL instead of
+ * an error.
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * Use of id names is optional.
+ */
+static inline struct reset_control *of_reset_control_get_optional_exclusive(
+				struct device_node *node, const char *id)
+{
+	return __of_reset_control_get(node, id, 0, false, true, true);
+}
+
+/**
  * of_reset_control_get_shared - Lookup and obtain a shared reference
  *                               to a reset controller.
  * @node: device to be reset by the controller
