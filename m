Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F2548993B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiAJNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:06:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42942 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiAJNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:06:49 -0500
Date:   Mon, 10 Jan 2022 13:06:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641820008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3RXTUrusYm+sz81iYsi3GrAcD2CmTtAlKUpJjLn/U0=;
        b=1hHLzUj5ViGJl1KNk68siIMVgrEc1KXwfNuJzumDkinOyIETR4VzHJu6D0rf70fhU8gftd
        xWfOUzceyn83+0Zd8NSN/v7DNtpRZZuqyV2peKCj8w0FUJmP9GQU91t3T4vNCT6DKCEGfr
        RlubPMYZ25nYEQE3/YWqOO+RuZvayB80GTT/ZB42EG/RbRh2YA8OSl/okwBn3DXqqXjd9S
        Ccwhf+CYvhu5pU3scFt0f7ZEZjs0ty0esd+wI+3JkgB1V1VLe5W+mLoJIPKmBdrkCmDWKI
        ZKlM8SoIepy8CGSyi+9RVpCUOeScems8Sl/5PPH1cQp2B4VFskJwDIVqliKOag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641820008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3RXTUrusYm+sz81iYsi3GrAcD2CmTtAlKUpJjLn/U0=;
        b=5JuBoj5HncrijPh/fbE6vNAh/ASznyxyh4IGIKs6sqIkAADIC9bemVAaGQNHzngCD09PRD
        kzj6kExG3jQoDMBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge branch 'clocksource' of
 git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into
 timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220105001723.GA536708@paulmck-ThinkPad-P17-Gen-1>
References: <20220105001723.GA536708@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Message-ID: <164182000711.16921.14224452347823356080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     35e13e9da9afbce13c1d36465504ece4e65f24fe
Gitweb:        https://git.kernel.org/tip/35e13e9da9afbce13c1d36465504ece4e65f24fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jan 2022 13:57:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Jan 2022 13:57:17 +01:00

Merge branch 'clocksource' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into timers/core

Pull clocksource watchdog updates from Paul McKenney:

 - Avoid accidental unstable marking of clocksources by rejecting
   clocksource measurements where the source of the skew is the delay
   reading reference clocksource itself.  This change avoids many of the
   current false positives caused by epic cache-thrashing workloads.

 - Reduce the default clocksource_watchdog() retries to 2, thus offsetting
   the increased overhead due to #1 above rereading the reference
   clocksource.

Link: https://lore.kernel.org/lkml/20220105001723.GA536708@paulmck-ThinkPad-P17-Gen-1
---
