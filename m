Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8DE553CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355618AbiFUVFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355982AbiFUVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:03:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28FA3527E;
        Tue, 21 Jun 2022 13:53:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655844748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nb5dLcX7krWQuD6zSqBNNfRwXIDlKoAFhGKnYz0pyus=;
        b=poyjZf3m9GJDdbHcAdbqc30s9c+rDUxQp7mpaG31RnP3wDDL+wcPVuo+TFKb5FWS6qKdCZ
        GTC4htJ9T9aYZ69nkdK3uQecEjzyvxl2iyfVlKjQv56zdLGgwz73e2PKvuCG5w9Ehle+D4
        u6lkclTEH/ZQs8D19VRcyMhHfF9rVynMtAwEgMwZ3CjtOZ0/nwmaO1GjcyWR2T7M+Z5SMx
        7yaICC2yWZeJeVydVlb5L0wxNgYn2S42rdJPeRzsPiwD8n3h5P2g5qNymuu4oV6rvWfazE
        Uy+OJt8b0nVlsVDmk3juHlZu1LxIu5tJZABrfCY4lSLXn1sE5m7X7KvNA2KKGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655844748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nb5dLcX7krWQuD6zSqBNNfRwXIDlKoAFhGKnYz0pyus=;
        b=cV8ms7gdEr44A8gH7coFpKz1whmzqybo6L1e7KaFOk/Oltr3Ii5uGgHeVFUvBwYMD+UleV
        N6AH5qV01G3xYcDw==
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 11/12] torture: Flush printk() buffers before
 powering off
In-Reply-To: <20220621181335.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
 <20220620225817.3843106-11-paulmck@kernel.org>
 <8735fyc42v.fsf@jogness.linutronix.de>
 <20220620232838.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <87v8suphdy.fsf@jogness.linutronix.de>
 <20220621181335.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 21 Jun 2022 22:58:27 +0206
Message-ID: <87ilotagdw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-21, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> The patch below will cause rcutorture to implicitly test this
> functionality, unless told otherwise, for example, by using the
> --bootargs "torture.printk_shutdown_bug_workaround" kvm.sh
> argument.
>
> Thoughts?

I feel like this is dirtying the torture.* bootarg namespace a
bit. Also, I am not sure how useful it is as a dynamic option. I assume
that users would generally avoid using it, so its very existence might
just be more noise in the documentation and code. It is an unusual
feature:

"In case some bug shows up, here is a flag to avoid it."

I personally would just drop the patch and rely on a correctly
functional kernel. But I am also not an rcutorture user. If _you_ think
that such a flag is useful, feel free to include the patch.

> commit 204bf1e2a5a2fb68c15b4b64793ad0896db6f705
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 21 11:02:25 2022 -0700
>
>     torture: Optionally flush printk() buffers before powering off
>     
>     The rcutorture test suite produces quite a bit of console output at
>     the end of a test.  This means that the new-in-2022 printk() kthreads
>     are likely to be in the process of flushing output at the time of the
>     torture_shutdown() function's call to kernel_power_off().  Normally,
>     rcutorture relies on printk() to flush any pending output upon shutdown,
>     the better to detect bugs in this area, for example, the one introduced
>     by 8e274732115f ("printk: extend console_lock for per-console locking").
>     However, once such a bug is detected and reported, it is necessary to
>     test the rest of the system, without noise from the already-reported bug.
>     
>     This commit therefore adds a torture.printk_shutdown_bug_workaround
>     kernel parameter, which causes torture_shutdown() to invoke pr_flush(),
>     and print an informative message on the console, immediately before
>     invoking kernel_power_off().  When this kernel parameter is not specified,
>     it is up to printk() to flush its own buffers.
>     
>     Suggested-by: John Ogness <john.ogness@linutronix.de>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
