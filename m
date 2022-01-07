Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD5B487D29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiAGTiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:38:17 -0500
Received: from albireo.enyo.de ([37.24.231.21]:42532 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbiAGTiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:38:15 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2022 14:38:14 EST
Received: from [172.17.203.2] (port=45459 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1n5uxR-000s6r-7X; Fri, 07 Jan 2022 19:31:25 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1n5uxQ-001JbN-SR; Fri, 07 Jan 2022 20:31:24 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos@redhat.com
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com>
Date:   Fri, 07 Jan 2022 20:31:24 +0100
In-Reply-To: <20220107170302.8325-1-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Fri, 7 Jan 2022 12:03:02 -0500")
Message-ID: <87a6g7ny0j.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Allow rseq critical section abort handlers to optionally figure out at
> which instruction pointer the rseq critical section was aborted.
>
> This allows implementing rseq critical sections containing loops, in
> which case the commit side-effect cannot be the last instruction. This
> is useful to implement adaptative mutexes aware of preemption in
> user-space. (see [1])

Could you write the program counter to the rseq area instead?  This
would avoid discussing which register to clobber.

Thanks,
Florian
