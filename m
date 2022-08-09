Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C221D58E19E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiHIVOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHIVOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:14:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE961B12
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:14:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660079660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHxEgVmEh6JR00sxeNhAi+8y/A6SXxBI7puVDuB6aJ8=;
        b=ak0yiCbdsTBynHZdeYORQKegIa2UyIGI6OUCB3TgNQKPV9Ho42GSJLH3vuzu6/4dAW9cMd
        s6bVFeZZ+y33hTAGFv9Lvp4aAVf1uC88Ykrj99TP40bppD3C9Ip8gfWdxrz+299BacacYl
        pQti81UurRaXYUnnvKs4Rf+FQDyq0mc/Ip9v901xTjokpF0jrX+6wSm8IdNyaYyHgWOB9k
        nFOsnhHy+lK3rWIGhzmGAgopj6g+/E80fGnDBO68iMVESezy5PW5u/xftqfRq8dTV3iqSq
        Esxk1vuJf2IC39v/hvkRmU25L9c4OBhqVxkyk+VvwknrM/pd+Fx9x1UySMnDmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660079660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHxEgVmEh6JR00sxeNhAi+8y/A6SXxBI7puVDuB6aJ8=;
        b=9aFCsYAtz0ZZLUdgN4XFNZQaNXmv6L6JEYVFHkP49xTswpUXVQvtba2CAkxREXoq2+rPy2
        VDS8ujDJOTlS1/AQ==
To:     Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
In-Reply-To: <YvKsS3QuOu4JVzZU@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com> <YvJNe2rzXfcogFFX@zn.tnic>
 <YvKpi/CVHko50PNQ@iweiny-desk3> <YvKsS3QuOu4JVzZU@zn.tnic>
Date:   Tue, 09 Aug 2022 23:14:19 +0200
Message-ID: <87lerxqfv8.ffs@tglx>
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

On Tue, Aug 09 2022 at 20:49, Borislav Petkov wrote:
> On Tue, Aug 09, 2022 at 11:38:03AM -0700, Ira Weiny wrote:
>> Thomas did a lot of work to make the entry code generic. So I was
>> keeping that work consistent. This also helps to ensure I did not miss
>> any places.
>
> How about you worry about the other arches when you actually cross that
> bridge?

Ira is right. If we want it for everything, then the generic code is the
right place.

>> I don't believe this is correct because instrumentation is not enabled
>> here.
>
> Why do you have to run
>
> 	arch_save_aux_pt_regs()
>
> with instrumentation enabled?
>
> Patch 5 does
>
> +       struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
> +
> +       aux_pt_regs->cpu = raw_smp_processor_id();
>
> only?
>
> Why does that need to run with instrumentation enabled?

There is no reason and actually _if_ we go there then this _has_ to
happen _before_ instrumentation comes into play as instrumentation might
want to have access to extended pt_regs. Not necessarily the cpu number,
but the other things which need to go there for a real reason.

Thanks,

        tglx


