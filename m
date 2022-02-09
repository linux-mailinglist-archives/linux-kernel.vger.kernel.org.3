Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5D64AEBBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiBIICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiBIICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:02:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0AC05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:02:23 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644393741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wif2+D8xIFS05ms3vC/tlw/Lp5Jixy0HFVXUKnCOTkc=;
        b=BKSpVDboAbB04c8UKWU3/3FN6+QZwIsMMrXG2MHWEUl44AznK97B3GxtTJQhyLriSbJRES
        OmjG3Pc2XlVgBO0uI/IcBSzYAvZVVOHbyxTWFemF76KKfebfzZfBP93GnSYhbYnFkMj0b9
        Cs7VaOsl9K4VXnpNPvMK3GzHw8v1AW0B4S0pvJumHINH4LV1XsOwPJZq2uM0hd1/WijN8R
        hqiPkTWlB+/DvR+WpOUs6H4NdHSog0phWMhXNKH00NsPQncCAleMEUgSS+TZFlJ2RYiX/o
        1ejwsFGwV2Qh1lbu/ebUTUVy8lyi/c8kKQ/o0PQKL+kQ67eNRBXJraMTr7vPxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644393741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wif2+D8xIFS05ms3vC/tlw/Lp5Jixy0HFVXUKnCOTkc=;
        b=3/KmyOIUIb9YbWeQ0TVKV5GTKlK6SuWXvl1XUdcTswqUY/80O9zfP7saKRH7wenDcSoKpU
        UdIbq3lrpAY/YQAA==
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Longpeng <longpeng2@huawei.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH REPOST v2 0/2 v2] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up again.
Date:   Wed,  9 Feb 2022 09:02:12 +0100
Message-Id: <20220209080214.1439408-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a another repost of the previous patch (#2) and adding Boris
(Ostrovsky)'s suggestion regarding the XEN bits.
The previous posts can be found at
   https://lore.kernel.org/all/20211206152034.2150770-1-bigeasy@linutronix.=
de/
   https://lore.kernel.org/all/20211122154714.xaoxok3fpk5bgznz@linutronix.d=
e/

Sebastian

