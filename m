Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA55519D05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbiEDKjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348117AbiEDKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:39:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6061EED0;
        Wed,  4 May 2022 03:35:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651660530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YtpjsfhkygI7S5pL9OBtkEy2yJ8BSnIkwhIIs6sW/g=;
        b=z6KCFH4fDN5OigfyhbZBoy0TtffgA0ydbAqvM0VqAIqyhJF1YXSJd9hh4PGtadytYPN0Fd
        Z3MnGpf5qmRZEkXlwNs7AvgEu1F8G93Viw+hhgTOi7xveDnOrR2Bm7gNWXkIY7rPDLU0pA
        t6MAfFRfGmvA81k5BTacqbWyOJi45bcTC2FgYKMk98JMotxhN25mqc5kT2fw73O+Y3c2Ir
        s+XXhNVK68mBtoGVVwc2sWHaGe74CVkbU1WIUQwqlT2lGysKg8snIdsIofGoeS5E4KTT/d
        ndFjo6yzjBEZ63P6Pz/uV76Y3NNm0L4L1M0FqprB+BxCLWMRPaUCzst6vqED3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651660530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YtpjsfhkygI7S5pL9OBtkEy2yJ8BSnIkwhIIs6sW/g=;
        b=55S8Fd6NqUoznCWNQtSmKnWSpcWfMCCLpFs5dSrKQZkbbn41FNfk7PzSstbSIpjiCFk7T1
        j7Kd2D7UuZnEQVCA==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 03/10] platform/x86/intel/ifs: Add stub driver for
 In-Field Scan
In-Reply-To: <20220428153849.295779-4-tony.luck@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-4-tony.luck@intel.com>
Date:   Wed, 04 May 2022 12:35:30 +0200
Message-ID: <87zgjxk2kt.ffs@tglx>
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

On Thu, Apr 28 2022 at 08:38, Tony Luck wrote:
> +#define X86_MATCH(model)				\
> +	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
> +		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
> +
> +static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> +	X86_MATCH(SAPPHIRERAPIDS_X),

Why do we need a model match here? The core capabilities MSR is only
available when X86_FEATURE_CORE_CAPABILITIES is set:

    "If CPUID.(EAX=07H, ECX=0):EDX[30] = 1.
     This MSR provides an architectural enumeration
     function for model-specific behavior."

So checking for Intel Fam6 ANYMODEL and X86_FEATURE_CORE_CAPABILITIES is
sufficient, no?

We really don't need more match id tables with gazillions of CPU models.

Thanks,

        tglx
