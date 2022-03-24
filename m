Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34E84E5FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbiCXIJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348792AbiCXIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:09:01 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09739A9A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:07:30 -0700 (PDT)
Date:   Thu, 24 Mar 2022 08:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1648109247;
        bh=IwmYMVqeQSJTelQ71b3k0r9jC+rrpKjwIIRKPp2xmJE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=o9CLaglO3fAcHqtDJLEref4o7uuHxTugXa+B6fMVdt9Xy2h0MBcOMcoJzrTDvNoBU
         AIiLHT8u0+du93GINYfBaDlVNw0gIJyPc5wXVeOflt+OazYKhlk2wCX0XhUifeR1il
         5j1X2mCbOFAfim462VIpywfPbm3nymAEa8qZJhl8dnmWHtCExSSByLXkYR6bwVExeT
         Y9N4MCl0tZ06eohI+syhpwtxfBS+zZCnjAhVExZNYfQGB3GykGweQ31QX/OP9bHwD2
         1YFlkg0gIVEtWeQHS/LuBobZ6ErM16mfAhMAtEhZuitqVVcP0EoZqAsCkrP19S49cO
         HIOiGkXogSw4A==
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
From:   David Cohen <dacohen@pm.me>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Cohen <dacohen@pm.me>
Reply-To: David Cohen <dacohen@pm.me>
Subject: [PATCH v3 1/2] PM: narrow down -DDEBUG on kernel/power/ files
Message-ID: <20220324080653.454333-2-dacohen@pm.me>
In-Reply-To: <20220324080653.454333-1-dacohen@pm.me>
References: <20220324080653.454333-1-dacohen@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro -DDEBUG is broadly enabled on kernel/power/ directory if
CONFIG_DYNAMIC_DEBUG is enabled. As side effect all debug messages using
pr_debug() and dev_dbg() are enabled by default on dynamic debug.
We're reworking pm_pr_dbg() to support dynamic debug, where pm_pr_dbg()
will print message if either pm_debug_messages_on flag is set or if it's
explicitly enabled on dynamic debug's control. That means if we let
-DDEBUG broadly set, the pm_debug_messages_on flag will be bypassed by
default on pm_pr_dbg() if dynamic debug is also enabled.

The files that directly use pr_debug() and dev_dbg() on kernel/power/ are:
 - swap.c
 - snapshot.c
 - energy_model.c

And those files do not use pm_pr_dbg(). So if we limit -DDEBUG to them,
we keep the same functional behavior while allowing the pm_pr_dbg()
refactor.

Signed-off-by: David Cohen <dacohen@pm.me>
---
 kernel/power/Makefile  | 6 +++++-
 kernel/power/process.c | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 5899260a8bef..874ad834dc8d 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0

-ccflags-$(CONFIG_PM_DEBUG)=09:=3D -DDEBUG
+ifeq ($(CONFIG_DYNAMIC_DEBUG), y)
+CFLAGS_swap.o                   :=3D -DDEBUG
+CFLAGS_snapshot.o               :=3D -DDEBUG
+CFLAGS_energy_model.o           :=3D -DDEBUG
+endif

 KASAN_SANITIZE_snapshot.o=09:=3D n

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 11b570fcf049..3068601e585a 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -6,9 +6,6 @@
  * Originally from swsusp.
  */

-
-#undef DEBUG
-
 #include <linux/interrupt.h>
 #include <linux/oom.h>
 #include <linux/suspend.h>
--
2.35.1


