Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4E4DB5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiCPQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiCPQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:20:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D46D4C2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:18:43 -0700 (PDT)
Date:   Wed, 16 Mar 2022 17:18:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647447521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLiWlJxNu5tEJIowHXDFed8QcF9G6PLDtmgVlnwcn/E=;
        b=3rs5MbOPYqXmpiWUZMOxVUHEGxu57IWf2Wys0ZRtOUZH4wgYqKy3Cb0oierRNFnASCw+Fa
        0/w7y79FllqHisKPLhuCwvMl4WsyOM6Oas/+TksMpIGrHNWa2JYCbgTi8IOmNrIho3iAGM
        pKQliSoLdF6neXXUcF6Re7hvwesMUMLnm2+AeQJF5rhMFUQ19OnpSVC/cQEbNlzeatBtvf
        WY7sBaNK/WseU0j0oq86gzHcExHAto9yL5ezHxj9/juF0r9VXto1155hzf1fULMVH/PKKf
        4hXj4q93Bq01lUu8bxRTFqEKU5Hqauo2tzBFgHVSxwUOerZpebfXA3hwNaVBbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647447521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLiWlJxNu5tEJIowHXDFed8QcF9G6PLDtmgVlnwcn/E=;
        b=P5zd6s5J7rtECeYbyxCPWHuhQ0RhkQC8EL372SzNFmMAjrPVK3zIpnZxWhw+Y6H9HeXDtO
        EWTqqClQa6nVEeCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <YjIN4C8EFIOOR+o4@linutronix.de>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <YjIKQBIbJR/kRR+N@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YjIKQBIbJR/kRR+N@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-16 17:03:14 [+0100], To Steven Rostedt wrote:
=E2=80=A6
> which looked right but RT still fall apart:
=E2=80=A6
> | =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | WARNING: bad unlock balance detected!
> | 5.17.0-rc8-rt14+ #10 Not tainted
> | -------------------------------------
=E2=80=A6
=E2=80=A6
> It is always the local-lock that is breaks apart. Based on "locks held"
> and the lock it tries to release it looks like the lock was acquired on
> CPU-A and released on CPU-B.

with

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 33ce5cd113d8..f4675bd8f878 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5968,6 +5967,9 @@ static bool try_steal_cookie(int this, int that)
 		if (p =3D=3D src->core_pick || p =3D=3D src->curr)
 			goto next;
=20
+		if (p->migration_disabled)
+			goto next;
+
 		if (!cpumask_test_cpu(this, &p->cpus_mask))
 			goto next;
=20
on top my problems are gone. Let me do some testing and then I would
patch unless PeterZ does the yelling :)

> > Thanks,
> >=20
> > -- Steve
>=20
Sebastian
