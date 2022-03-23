Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC054E52B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiCWNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiCWNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:04:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B01F7CDC4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:02:36 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:02:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648040554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbCwVVRphwKFhHFjdgqzv4b5jAPDrPw5EXg1eflzqcM=;
        b=lTyix5maivfLw8E8Po9Y8v0iZkkEthoVdWxUAkacnuW0EcVIUXUU/gXp86tc8gzJW1L/9d
        IE1sZhoeNDz/df5gmlbGLLgOMTkZ7b0Yhuv+nx3cNEniAygTwrvIyC5v8oJZ+oBJdZeEGh
        eJ+CIs/Un9nFcO9gJcTYcTsVa2IBBjBC9hb8oc1PTPzF333H+1LoX0mqXANdTWMhr2sCG9
        WtR1y5ljZeyMxVkZEXbLcOHnuqZtIqFtcbSVpB/Jwdl5jjlEHi60d+fg4LteatHl3lNSrA
        wnMrsAbczhw5//ay4CFJisdm3qQh3CXF9MZ0xzyihH1ZU+FEqdBJcVYSf7p+vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648040554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbCwVVRphwKFhHFjdgqzv4b5jAPDrPw5EXg1eflzqcM=;
        b=VOsTdu5ZLZW0Wq76l4BUB69GXQpUMxEHlRDyF0Lcl3AtX6x/7peY+Wd+sltN7+9itzrpzd
        Dlkn6n4Th6PRY5Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 27/39] kasan, mm: only define ___GFP_SKIP_KASAN_POISON
 with HW_TAGS
Message-ID: <YjsaaQo5pqmGdBaY@linutronix.de>
References: <cover.1643047180.git.andreyknvl@google.com>
 <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
 <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-23 12:48:29 [+0100], Vlastimil Babka wrote:
> > +#ifdef CONFIG_KASAN_HW_TAGS
> >  #define ___GFP_SKIP_KASAN_POISON	0x1000000u
> > +#else
> > +#define ___GFP_SKIP_KASAN_POISON	0
> > +#endif
> >  #ifdef CONFIG_LOCKDEP
> >  #define ___GFP_NOLOCKDEP	0x2000000u
> >  #else
> > @@ -251,7 +255,9 @@ struct vm_area_struct;
> >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> >  
> >  /* Room for N __GFP_FOO bits */
> > -#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
> > +#define __GFP_BITS_SHIFT (24 +					\
> > +			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
> > +			  IS_ENABLED(CONFIG_LOCKDEP))
> 
> This breaks __GFP_NOLOCKDEP, see:
> https://lore.kernel.org/all/YjoJ4CzB3yfWSV1F@linutronix.de/

This could work because ___GFP_NOLOCKDEP is still 0x2000000u. In
	("kasan, page_alloc: allow skipping memory init for HW_TAGS")
	https://lore.kernel.org/all/0d53efeff345de7d708e0baa0d8829167772521e.1643047180.git.andreyknvl@google.com/

This is replaced with 0x8000000u which breaks lockdep.

Sebastian
