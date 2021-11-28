Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E362A46153C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbhK2Mk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:40:59 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17577 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241690AbhK2Mi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:38:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638057926; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=k+N01kzcipbexhHQsG88X2M0FQGUx7o/+bnRg1X6P6lyVOiD8+BbReMlTn0+Oi3d1c7w9m6u7kcgTCTv6d+BOpVO36r0mVQQy1L/o97VJEK3ohLVz927iOckGst0cFmLQti4Chc/9y20bMbd+0kgLRNjeZ1TGdTUALgolDYT0dw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1638057926; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=k/axBYgs8ePu82NKai1qn+cHK8gQhlozWwXZnDXD8yk=; 
        b=OexewUidtTGMEGSPfuJVLpIck/dTD52CYt8S+WPys75HdmGs49nYiKODg5XEu699gIqo6TlVR7iU2GAApuAuR+8azPDH0YknNLHpDhsT7vOPmhaChYD8tKyUKjTb8/hx7tx2psFIBtsXZa3dxJz8poIP0FMO7ke5CSZtFmK+xno=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=szanni.org;
        spf=pass  smtp.mailfrom=angelo@szanni.org;
        dmarc=pass header.from=<lkml@szanni.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638057926;
        s=zoho; d=szanni.org; i=lkml@szanni.org;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:Content-Transfer-Encoding;
        bh=k/axBYgs8ePu82NKai1qn+cHK8gQhlozWwXZnDXD8yk=;
        b=Kn37IrDoVNidrb6X54m7LkCfk4fXsdTOh1vVjU4K3AaFUzv40tFX+7/y6FOyJiit
        +2Ds4yqz4mGD6AhFB16H8bryGG1OuVI2zQkSqpJ6kprfETH+K8YPj+CPxc0WBKJ6/hL
        FeasMNHSlJ8BPf4AO798O5gnGRu/2f/mEroY59iI=
Received: from [192.168.0.128] (200.60.135.218 [200.60.135.218]) by mx.zohomail.com
        with SMTPS id 1638057923743427.7880943683017; Sat, 27 Nov 2021 16:05:23 -0800 (PST)
Message-ID: <5475c3ab-a53c-8728-98c5-98fd948ff556@szanni.org>
Date:   Sat, 27 Nov 2021 19:07:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-rt-users@vger.kernel.org
From:   Angelo Haller <lkml@szanni.org>
Subject: sched: some non-GPL symbols becoming GPL-only with CONFIG_PREEMPT_RT
 enabled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings. I hope I picked the right mailing list, as this issue might 
be one that affects various subsystems and components:

When compiling kernel 5.15 (and 5.16-rc2) with `CONFIG_PREEMPT_RT` 
enabled, some of the symbols being exported as `EXPORT_SYMBOL` suddenly 
become `EXPORT_SYMBOL_GPL` through transitive effects.

In particular the symbols `migrate_enable` and `migrate_disable` are 
currently marked as `EXPORT_SYMBOL_GPL` - yet are called from multiple 
functions that are marked as `EXPORT_SYMBOL`.

Here an (incomplete?) listing of call sites I came across:

kernel/locking/spinlock_rt.c - rt_spin_unlock()
kernel/locking/spinlock_rt.c - rt_read_unlock()
kernel/locking/spinlock_rt.c - rt_write_unlock()
mm/highmem.c - kunmap_local_indexed()

The issue I'm facing in particular is kmap_atomic() calling 
`migrate_disable` and therefore suddenly becoming GPL-only. This breaks 
the out-of-tree CDDL licensed module ZFS and has been reported before 
already [0]. The conversation seemingly going nowhere - or patches at 
least not being applied upstream. Downstream issue for reference [1].

As the original implementation of `migrate_enable` and `migrate_disable` 
is apparently by Peter Zijlstra [2]. Peter would you be willing to 
re-license both symbols `migrate_enable` and `migrate_disable` as 
`EXPORT_SYMBOL`?

The bigger issue I'm seeing though is that there is currently no 
automated test to uncover exported symbols changing their license 
depending on build configuration? I am not intimately familiar with the 
API guarantees the kernel gives, but this seems like a violation. There 
might be other symbols with similar licensing problems.

I can open a bugzilla ticket too - if that is preferred.

Angelo


[0] 
https://lore.kernel.org/linux-rt-users/20201208212841.694b3022@orivej.orivej.org/T/
[1] https://github.com/openzfs/zfs/issues/11097
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/diff/patches/0009-sched-Add-migrate_disable.patch?h=v5.9-rc8-rt14-patches&id=9a89bfdb3bc77aecdd0ff8cc69b595541c7b50c4

