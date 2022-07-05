Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12D7567518
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiGERCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiGERCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:02:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A221F611
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7v/ZqsGsmcIWhos8q1V9yrzf2DBDa8vXIkaH9fJX1IU=; b=NtVtqq7EIOVnOnlKwKwpX/HxDF
        YDHxFCpKzu6hropCuVmJdpKieMN3E7AeKawOF9KVG/dNeUK8lUH6nlKKB+kUnW1wR/XJPqletxI1S
        24EO7QvbJNL9fg1hBgUa62PqM9nc9xTjpptnkoTM80QsODAvKeKTgnR9K2UiXjAIjs9w8vWVT7czA
        fwfxcddzEnTZzuiCnCIgQHPje7FGvAOUA8ykIj5nMHeHTZi3rLBF1aquuG/URS8ZweVck+FSBkef1
        2iErMPbrXbd834jZOt6CPkb/aIW2QupXV2R1M0tkjBzt5JEFup0ohTACrOboJ2gFiN/kkQVKXRofr
        PMSsGsaQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8lvf-0004G4-0K; Tue, 05 Jul 2022 17:01:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 343D0980059; Tue,  5 Jul 2022 19:01:37 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:01:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] locking/qspinlock: split common mcs queueing code
 into its own function
Message-ID: <YsRucXLUueWlAeJC@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-4-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:10AM +1000, Nicholas Piggin wrote:
> +void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> +{
> +	if (pv_enabled()) {
> +		queued_spin_lock_mcs_queue(lock);
> +		return;
> +	}
> +
> +	if (virt_spin_lock(lock))
> +		return;
> +

This reminds me; at the time I meant to make queued_spin_lock_slowpath()
a static_call() and redirect the function appropriately at boot time.
But that was before static_call() was merged and I never seem to have
gotten around to doing that afterwards...

