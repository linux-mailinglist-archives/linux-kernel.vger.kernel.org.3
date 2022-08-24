Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97C59FCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiHXONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiHXONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:13:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D498580;
        Wed, 24 Aug 2022 07:13:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661350391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrxIZp2OWCNMfWEANgjBqiar/YkoyaBIWoE8lstlXa8=;
        b=IJJ48jhqMPUUGaXsSiF59/3qtABdRfwvhNtedPvheVGi6HHjq1GFLOBt9j5n6esNiLISxT
        T9ClQa7ESL5GCD8CfZ8gk1geVM3c8e0X1VON04C2YaBC9laJxF4nTVobYJJK25J9ywDGXr
        PUthqta86T1db9t2IgyLczhWtgF7/DY8LFQNc7pUV4yURYl6bauLCAOJXRUCoysL6+Mfk3
        waa6XVrrudnwBd0VnWPL2hq8erQuRky/DeFJDlFKwjQW2m4L4HSWz069uqgQjJVUKvYWgI
        3Eaa48q+Vjzo3IhCV4zqWromUvEelBLK5pBl1pqFQI0fqfifOWdSYYnW0Q6flQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661350391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrxIZp2OWCNMfWEANgjBqiar/YkoyaBIWoE8lstlXa8=;
        b=F0Z6B9OcpNgqwHnNB+aKRjQvc27bef3GVZAqXIi8El/hWpCaOlNWTi2e7qIGCyUEoPXCJM
        YxsHu3Lnl4TxEYCA==
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Steven Noonan <steven@uplinklabs.net>, usama.anjum@collabora.com,
        kernel@collabora.com
Subject: Re: [PATCH 1/3] x86/tsc: implement tsc=directsync for systems
 without IA32_TSC_ADJUST
In-Reply-To: <20220808113954.345579-1-usama.anjum@collabora.com>
References: <20220808113954.345579-1-usama.anjum@collabora.com>
Date:   Wed, 24 Aug 2022 16:13:11 +0200
Message-ID: <87v8qhybk8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08 2022 at 16:39, Muhammad Usama Anjum wrote:
> From: Steven Noonan <steven@uplinklabs.net>
>
> AMD processors don't implement any mechanism like Intel's
> IA32_TSC_ADJUST MSR to sync the TSC. Instead of just relying on the
> BIOS, TSC can be synced by calculating the difference and directly
> writing it to the TSC MSR.

Why? This has been tried before and is known to be flaky and
unrealiable.

> Add directsync flag to turn on the TSC sync when IA32_TSC_MSR isn't
> available. Attempt 1000 times or for 30 seconds before giving up.

Looping 30 seconds with interrupts disabled? Seriously?

Thanks,

        tglx
