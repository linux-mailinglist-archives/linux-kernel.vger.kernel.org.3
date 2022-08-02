Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75E587B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiHBLNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiHBLNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:13:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8831835B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:13:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w3so1496364edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOYjB3ibijmJne8XC2NfAKd6gYxNjDMlqLZRsTlFXeo=;
        b=Xzq2uvGTCf3ZjE5hpFyyQ48YKNNEos1fQOkkIrHPfcyOWyeq/hfD2b/B8iq/Oolvo2
         xFsjU7dDUiOH3C3rB63f2bDTLpB2u21ZwytZHKzQ6bNZ39/l4GQrEMiwnMUgvKJeuxUh
         3Xjthpt+WB/4xfosECS9jXX3bUpp7Bc9391eV2QsACbLvwCIYt8uEzprSBxwJX0+Ii3Z
         PN90Ds6Pxjawn6ySg/HpOu4J+YfyBU4jT2TpsiiRPssh/9MI4ut2NMWZvlonaLkflPdB
         sNWDF6H/3afiX5gIw05VONlyzclLJpiYBAifSNXMzYuJ82FWFcjq3N9X1U38m6WGo1+M
         hCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AOYjB3ibijmJne8XC2NfAKd6gYxNjDMlqLZRsTlFXeo=;
        b=2iA/pvRtY1M+BhQg2DAAvjKC7sjtbLPpUiLoeZ88BBgbND3DuWSCcJ2OGUsKO9JpaU
         XOzVdiy+gBPf3EIauThuYlItkDtJ8iovTxtuLCPfk2vJrCjARWSA7O12vAd+668kdgOE
         wN39Ws3QyPMIG3AS1cNsFjVZVkexCCP+bk8bCXYBXMS4WwGRG4LuaLaomyFHB8+3DDr7
         WFtPaIAMrgoF9a4R898HVhipzdUbjfwlSiMK7ZKbm31HpsugRBINu0HgV7lGqfd6ntg3
         oWZ+gPiPQGXYvNaP4HsBtOlHl8qdlNy4hDQGIqAlT08rWLu0P6R2W5d2EbtYyqMQZuTn
         pvzQ==
X-Gm-Message-State: AJIora94TD73g7F08d8yb/XMzsq4TUArzDNN92t4C7pWD57QOhuH8IUx
        HtEUOANWR8+nEiJscfWb6Gk=
X-Google-Smtp-Source: AGRyM1tzGAfAAmv6iXxgbbG7P9+hbgH05I5rdhsjpCFkOm1o4GE5CWL80Y4R4jqmoiTxvyW+pb4/aQ==
X-Received: by 2002:a05:6402:50d1:b0:43b:e03a:a32a with SMTP id h17-20020a05640250d100b0043be03aa32amr20515743edb.336.1659438789543;
        Tue, 02 Aug 2022 04:13:09 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906715700b007305b8aa36bsm3491195ejj.157.2022.08.02.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:13:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 13:13:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v5 1/5] x86/cacheinfo: move shared cache map definitions
Message-ID: <YukGwkzicp+aNLXx@gmail.com>
References: <cover.1659077534.git.sander@svanheule.net>
 <3181e52cb86b57f3a98dec4aaab8935f14b683a1.1659077534.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3181e52cb86b57f3a98dec4aaab8935f14b683a1.1659077534.git.sander@svanheule.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sander Vanheule <sander@svanheule.net> wrote:

> The maps to keep track of shared caches between CPUs on SMP systems are
> declared in asm/smp.h, among them specifically cpu_llc_shared_map.  These
> maps are externally defined in cpu/smpboot.c.  The latter is only compiled
> on CONFIG_SMP=y, which means the declared extern symbols from asm/smp.h do
> not have a corresponding definition on uniprocessor builds.
> 
> The inline cpu_llc_shared_mask() function from asm/smp.h refers to the map
> declaration mentioned above.  This function is referenced in cacheinfo.c
> inside for_each_cpu() loop macros, to provide cpumask for the loop.  On
> uniprocessor builds, the symbol for the cpu_llc_shared_map does not exist.
> However, the current implementation of for_each_cpu() also (wrongly)
> ignores the provided mask.
> 
> By sheer luck, the compiler thus optimises out this unused reference to
> cpu_llc_shared_map, and the linker therefore does not require the
> cpu_llc_shared_mask to actually exist on uniprocessor builds.  Only on SMP
> bulids does smpboot.o exist to provide the required symbols.
> 
> To no longer rely on compiler optimisations for successful uniprocessor
> builds, move the definitions of cpu_llc_shared_map and cpu_l2c_shared_map
> from smpboot.c to cacheinfo.c.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
> Changes since v3:
> - New patch
> 
>  arch/x86/kernel/cpu/cacheinfo.c | 6 ++++++
>  arch/x86/kernel/smpboot.c       | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Ingo Molnar <mingo@kernel.org>

I'm also fine with you guys carrying this in the bitmap tree - the x86 
impact is incidental.

Thanks,

	Ingo
