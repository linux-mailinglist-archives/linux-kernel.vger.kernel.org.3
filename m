Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D898246BAE8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhLGMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhLGMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:21:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:17:48 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638879466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Scsls6OcNfhthZm/twIuF4ePRYqn7XCd/nxFXNHFm0s=;
        b=EZlgSWcdRLbOYsEgkTrD/NeQoQG1KafODnffi5e4CM2LMD0U2wsXnEz8o/uOYHu3z/NS+a
        KOjs7iG07OPZRY4gSfkqmL4A84b9hZCoEllI4thcVOpxULb2WITKzUa3yC4Og7xyVG34U/
        iVjcqxxOtwzcfgo1U3H6rAxn6MVQ/gHh/dSgjiqhXv7z+OAE/Oj5uKRFxn4M3VyuoVFuI8
        BFE5nib22K2hDR3Pa0g9Ju5CcUjtnB5saKGqGFg7/UtH/5huUb1LhgZ9MHOMemXFmX88Ir
        8DMu2CGXSfBgPjMiY+02jN+bShJbrTJ8UF9ESRhqYA4vLa5c/Dry6wQv/Ebnsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638879466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Scsls6OcNfhthZm/twIuF4ePRYqn7XCd/nxFXNHFm0s=;
        b=NO3KT6YB4/0mhi4C95DTijVFM+vf5VhkLqISwq9sIuQdEzdFuPzrFp1COnVnuw98HfSlLI
        bbvKMtA6HuCHASAA==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/5] random: Add PREEMPT_RT support.
Date:   Tue,  7 Dec 2021 13:17:32 +0100
Message-Id: <20211207121737.2347312-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entropy_store::lock can not be acquired with disabled interrupts on
PREEMPT_RT because it is a sleeping lock. The lock is acquired from
hard-irq context while the primary interrupt handler is invoked.
The series restructures the code a little so the lock is only acquired
in process context on PREEMPT_RT while it remains as-is for non-RT.

The first two patches remove unused arguments from functions. The
following two reshuffle the code a little while the last one addresses
the PREEMPT_RT related issue.

Sebastian


