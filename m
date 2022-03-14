Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA14D7EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiCNJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiCNJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC643EDF;
        Mon, 14 Mar 2022 02:28:40 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kct5w3pAr3SnV/Z5KA43cuwWR/uTU+US5DEyxVasOb0=;
        b=v3Fp3w1DLpa5kp3eI+g/PkM9uXXtf/nzEv/uVjIcJmqYf+cPfm7bJ7z43PwEDzysqHaijh
        t/oNPS6VezOiIN3zZ519dRgLw6y3VCgfadryt0M9soCQgQM+Bf5Q5NUaBYB2c0bh32JuXL
        Vum3dNIl89m4BjKbQ2zhAi5bhv9xcBsnV/rsJl7n7u6ri4zBtkevjyaH5NA5QFijfd/wYq
        8YNVSudY/Vb5I6JFEZAvLv02pFYRn777GZHKKOX15eHdzD26lsQ6dujrhRp503RR1b3Ncc
        nA7GAoRHPdGKN4nGAWY9IYJB/fmYEGb/v5HQxksolcBfWugX0ravjosbD+QdKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kct5w3pAr3SnV/Z5KA43cuwWR/uTU+US5DEyxVasOb0=;
        b=y+d9Rp3hFvZ1AfD+eeLJOfFa3/P0d1yw34RgfHVRIMzQfkcSur7bDT3syvuSXZpz+PodQY
        rQcdheus7I9ZSYCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge branch 'timers/core' of
 git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks into
 timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220307233034.34550-1-frederic@kernel.org>
References: <20220307233034.34550-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164725011736.16921.8383304620734292775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1f1893d78180c0c8bd4f53405420aa31eabfb263
Gitweb:        https://git.kernel.org/tip/1f1893d78180c0c8bd4f53405420aa31eabfb263
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Mar 2022 10:10:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Mar 2022 10:10:15 +01:00

Merge branch 'timers/core' of git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks into timers/core

Pull tick/NOHZ updates from Frederic Weisbecker:

 - A fix for rare jiffies update stalls that were reported by Paul McKenney

 - Tick side cleanups after RCU_FAST_NO_HZ removal

 - Handle softirqs on idle more gracefully

Link: https://lore.kernel.org/all/20220307233034.34550-1-frederic@kernel.org
---
