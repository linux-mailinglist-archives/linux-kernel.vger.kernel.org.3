Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA348991B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiAJNBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiAJNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:07 -0500
Date:   Mon, 10 Jan 2022 13:00:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2mLaJ7RL4FN3+vVGbUJLhzkPrpRoSqBiJWS2PShcXk=;
        b=k1k1nr/WMIThs4njdGjmqTCre1xd8TrtZ7uT4+fAvgpThADX/zFpvSefwJh2uu2HHsGezc
        j0C3a9cUz0lB89hs24N1w4nlwLXuL9ZMNw/5aLyk9NNFYTSyZP8UVxUCIZ5nnTGVUhqwEG
        mkJr+n7QKLmiltGFX1Eaaj6lsGD/34a/SNKKd4e5+9ljDAsqjjr+ixlNiT4wl0PKDxYnR4
        UR2uG9yOtQXHVzDgKKtv/42/ry/k+fYBSeMIRW0zTQXVMP5U+GOgzJ5sL/Bh73JuG/3krW
        es+BNcstSHxJ1nW5El1qeXh+HVDQnQdtclGHJfDDFJSBbIMU/rncJIjknMk5kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2mLaJ7RL4FN3+vVGbUJLhzkPrpRoSqBiJWS2PShcXk=;
        b=0SOgNesnxsUdSFj8yUBzSb8so95HrFqGr0bm3kj3evxvY0LXO+eYNRKke5BrEJ2bp3poGw
        1qyDw1IotangjiAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.17-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e093c706-c98d-29ee-0102-78b6d41c6164@linaro.org>
References: <e093c706-c98d-29ee-0102-78b6d41c6164@linaro.org>
MIME-Version: 1.0
Message-ID: <164181960422.16921.7599880408437086645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6629c0769926306454b113effe1aad243bd49bde
Gitweb:        https://git.kernel.org/tip/6629c0769926306454b113effe1aad243bd49bde
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jan 2022 13:53:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Jan 2022 13:53:16 +01:00

Merge tag 'timers-v5.17-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clocksource/events updates from Daniel Lezcano:

 - Refactor resource allocation on the Exynos_mct driver without
   functional changes (Marek Szyprowski)

 - Add imx8ulp compatible string for NPX TPM driver (Jacky Bai)

 - Fix comma introduced by error by replacing it by the initial
   semicolon on the Exynos_mct (Will Deacon)

 - Add OSTM driver support on Renesas. The reset line must be
   deasserted before accessing the registers. This change depends on an
   external change resulting in a shared immutable branch
   'reset/of-get-optional-exclusive' from
   git://git.pengutronix.de/pza/linux (Biju Das)

 - Make the OSTM Kconfig option visible to user in order to let him
   disable it when ARM architected timers is enabled (Biju Das)

 - Tag two variables on iMX sysctr _ro_afterinit (Peng Fan)

 - Set the cpumask to cpu_possible_mask in order to have full benefit
   of the DYNIRQ flag on iMX sysctr (Peng Fan)

 - Tag __maybe_unused a variable in the Pistachio timer driver in order
   to fix a warning reported by the kernel test robot (Drew Fustini)

 - Add MStar MSC313e timer support and the ssd20xd-based variant, as
   well as the DT bindings (Romain Perier)

 - Remove the incompatible compatible string for the rk3066 (Johan
   Jonker)

 - Fix dts_check warnings on the cadence ttc driver by adding the power
   domain bindings (Michal Simek)

Link: https://lore.kernel.org/lkml/e093c706-c98d-29ee-0102-78b6d41c6164@linaro.org
---
