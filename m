Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8504F08A3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiDCKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiDCKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:05:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB6EBAE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 03:03:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648980202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etAIjhpzn6m8cENvpuAm6m3b6pfIYJ+XIVCjDgk7EgA=;
        b=EmZs3QU9ylaYoHX+p4NFtWD41L40zABgJdIsocdhzxvpVUUAOmvGF+vdWvbqVfRLn2aSCE
        5OFdlix/U1GqiUr2VQxJrfIUvlnGP94tRPa1wqiVSfojq0jlAUaDuCmiuLtuPGZxhizofN
        rcHxKEQ5BWR+jWs1f+oIIZKLKvb21rMp89hiFVRxYJgpvj9PtFf/kybXBk8cfodcDGNlhD
        RGHKhbYEJJVbuxaHR8C1nPe+j0kpAgGNKp5nTfjpCRHhkOvvtnJXRgdj3Ejlewsoo420Qt
        Lri5ZlLZCAnzix+yMPr6MFjTQvRLXJNxpSvNv1jWmGSkkCUaJz2hKulHsNNywQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648980202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etAIjhpzn6m8cENvpuAm6m3b6pfIYJ+XIVCjDgk7EgA=;
        b=vPxxBqaypzQSSYlExQQGRgV97hC0RN2NXQEoWlmRCk/wmKYbJjxsbg9wjaUa2yuEaBtUaH
        oufBEqLAVbIMeGBA==
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>,
        Jirka Hladky <jhladky@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/2] x86/tsc_sync: Add synchronization overhead to tsc
 adjustment
In-Reply-To: <20220314194630.1726542-3-longman@redhat.com>
References: <20220314194630.1726542-1-longman@redhat.com>
 <20220314194630.1726542-3-longman@redhat.com>
Date:   Sun, 03 Apr 2022 12:03:21 +0200
Message-ID: <87czhymql2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14 2022 at 15:46, Waiman Long wrote:
> As stated in the comment of check_tsc_sync_target():
>
>   The adjustment value is slightly off by the overhead of the
>   sync mechanism (observed values are ~200 TSC cycles), but this
>   really depends on CPU, node distance and frequency. So
>   compensating for this is hard to get right.
>
> That overhead, however, can cause the tsc adjustment to fail after 3
> test runs as can be seen when booting up a hot 4-socket Intel CooperLake
> system:
>
> [    0.034090] TSC deadline timer available
> [    0.008807] TSC ADJUST compensate: CPU36 observed 95626 warp. Adjust: 95626
> [    0.008807] TSC ADJUST compensate: CPU36 observed 74 warp. Adjust: 95700
> [    0.974281] TSC synchronization [CPU#0 -> CPU#36]:
> [    0.974281] Measured 4 cycles TSC warp between CPUs, turning off TSC clock.
> [    0.974281] tsc: Marking TSC unstable due to check_tsc_sync_source failed
>
> To prevent this tsc adjustment failure, we need to estimate the sync
> overhead which will be at least an unlock operation in one cpu followed
> by a lock operation in another cpu.
>
> The measurement is done in check_tsc_sync_target() after stop_count
> reached 2 which is set by the source cpu after it re-initializes the sync
> variables causing the lock cacheline to be remote from the target cpu.
> The subsequent time measurement will then be similar to latency between
> successive 2-cpu sync loop in check_tsc_warp().
>
> Interrupt should not yet been enabled when check_tsc_sync_target() is

Interrupts _ARE_ not enabled.

> called. However some interference may have caused the overhead estimation
> to vary a bit.  With this patch applied, the measured overhead on the
> same CooperLake system on different reboot runs varies from 104 to 326.

Hmm.

> [    0.008807] TSC ADJUST compensate: CPU36 observed 95626 warp. Adjust: 95626
> [    0.008807] TSC ADJUST compensate: CPU36 observed 74 warp. Adjust: 95700
> [    0.974281] Measured 4 cycles TSC warp between CPUs, turning off TSC clock.
> [    0.974281] tsc: Marking TSC unstable due to check_tsc_sync_source failed

Can you please provide the output after your changes? It's hard to tell
what effect adding the lock compensation has. Ideally from several runs
for both patched and unpatched.

Also if the compensation value is at the upper end and the real overhead
is way lower then the validation run might end up with the opposite
result. I'm a bit worried about this variation.

Thanks,

        tglx


