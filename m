Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438C24633CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbhK3MIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:08:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbhK3MIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:08:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8146BB81846;
        Tue, 30 Nov 2021 12:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940D1C53FCF;
        Tue, 30 Nov 2021 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638273915;
        bh=BKaO6kLYHyi6gZ59PeSbDaTBZNbumFvE8rNJV7KzBlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOF11PwF8K02hkwjdiO7NNATq3dgnUdSInx6jH8I2MQrgB14tcs6k1ABlD5nF09Kk
         YQevQKXR/0LMspeXSihyjYp+weSiCKaNtt2SYK7aEaSYk6rApaJ6x4M3JRTDejckk9
         0TSBp31MYGDXStoZhwTz/J1PfdJzZsnallQrkqLRsF8KRy5N3zeMxK1SgTgF8OzAJ/
         0IkmYPur0X91lab3GZ/relF9o28mWTSdSO2/0wnmTjFuwCmIRXA4HiUq2AARUA28q1
         ZA4MjzIiazd1BYwA07/g5ALL77md8TEcC2jkNCZxDifGIWT80v/UW/bQ6fhZbx2lmV
         nKwBMfWClWjLw==
Date:   Tue, 30 Nov 2021 13:05:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        mtosatti <mtosatti@redhat.com>
Subject: Re: Question WRT early IRQ/NMI entry code
Message-ID: <20211130120511.GB599355@lothringen>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:28:41PM +0100, Nicolas Saenz Julienne wrote:
> Hi All,
> while going over the IRQ/NMI entry code I've found a small 'inconsistency':
> while in the IRQ entry path, we inform RCU of the context change *before*
> incrementing the preempt counter, the opposite happens for the NMI entry
> path. This applies to both arm64 and x86[1].
> 
> Actually, rcu_nmi_enter() — which is also the main RCU context switch function
> for the IRQ entry path — uses the preempt counter to verify it's not in NMI
> context. So it would make sense to assume all callers have the same updated
> view of the preempt count, which isn't true ATM.
> 
> I'm sure there an obscure/non-obvious reason for this, right?

At least I can't find an immediate reason for it either :-)

Thanks!
