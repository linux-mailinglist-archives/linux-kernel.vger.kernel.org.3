Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE04788F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhLQKcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbhLQKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:32:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82E6C061574;
        Fri, 17 Dec 2021 02:32:21 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639737140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJ5VKmBE6aYtM6tP8AN8uxVO3rPlVGrXg25kw/Z+Afo=;
        b=RXEX0iX6upQy+CBIb5CGl9lio3kt0NcivCWIyZWOtmaIcXzS3uKWMd4UeDNYJh3R/CFQL4
        pV55xkWghfsOTh0WQoV6kWBI5RZhtRgpXS9Dnjzc/sjK8HeCRj69ApUTqV8PF0L1ALlSx1
        Ey+a7Ezjau9eFh8Eh4k+hEtdhe+rVwKLRNryJ8zon1gcgQAqYo8J/XPWEeQg21dXbVmIo3
        aFgOPrXXPS5oBeo0s1NTaFbXmgZpvq1TWa1rwQ5DrywNqiogyoOk6VWSdHfMHZDsgaeTXO
        TggSA1qD0zXJZD5V/IN3OahogLiR8my42P3KPT3facE07Dbt3n8la0gSJkJw7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639737140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJ5VKmBE6aYtM6tP8AN8uxVO3rPlVGrXg25kw/Z+Afo=;
        b=VuFdtXtD6jYAuD5sTVrZJvy0S7SCWjOVnohrJtbo+Q/eL8RusQyJGJuc5Rbqyzwiuduw1f
        yv9gaeCRb1m/c+Aw==
To:     fcarli@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] stop_machine: Remove this_cpu_ptr() from print_stop_info().
Date:   Fri, 17 Dec 2021 11:32:08 +0100
Message-Id: <20211217103209.1122679-2-bigeasy@linutronix.de>
In-Reply-To: <20211217103209.1122679-1-bigeasy@linutronix.de>
References: <CAJuRqcAc19KZYik7T_dYFoqt_wX4QPHKBsh9A8BJwYE7uxs_1A@mail.gmail.com>
 <20211217103209.1122679-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This aligns the patch ("stop_machine: Add function and caller debug
info) with commit
  a8b62fd085050 ("stop_machine: Add function and caller debug info")

that was merged upstream and is slightly different.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/stop_machine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index dbf585cf4b9f8..971d8acceaecb 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -51,7 +51,11 @@ static bool stop_machine_initialized =3D false;
=20
 void print_stop_info(const char *log_lvl, struct task_struct *task)
 {
-	struct cpu_stopper *stopper =3D this_cpu_ptr(&cpu_stopper);
+	/*
+	 * If @task is a stopper task, it cannot migrate and task_cpu() is
+	 * stable.
+	 */
+	struct cpu_stopper *stopper =3D per_cpu_ptr(&cpu_stopper, task_cpu(task));
=20
 	if (task !=3D stopper->thread)
 		return;
--=20
2.34.1

