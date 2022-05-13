Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3178C526CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiEMWSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEMWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:18:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF423669D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8JtPTpbwMx4ct7HBtuRJywYNUc9bl5kATeKA8vEKUd0=; b=cZq3JWlyH6i/2EkLSRV0Y5k4Zp
        qCfHbzXl1hbkHTYGErg/d8B5LI144/CuuZPDegiy/2tUnAo1MygBsoGgX53bY9m8vNUxIwPNQ6UeH
        QVxDCazlJOxxCEtQCOTf0dDzX3jJr1BuVlmpSPkGEP89aUAbPHOkHcg4ob1PXbNlmDKjzJe/AfNig
        /n0liQ41uCs12fzeJkGrJfqfuTNiEnzulXZLRBCySz9XnpoGvWqRArIIZZ6xvo1LwDkCntCErn0Hk
        pn7020oZOaoVXz5Jx287ZyXyo6LQyPp7QKgM4+ZwhwDzS5xjDW80+aJDeZeAdV7lSPehzoXzZXg0b
        ScwVo9KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npdc7-0009jQ-7I; Fri, 13 May 2022 22:18:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96BAB98103B; Sat, 14 May 2022 00:18:20 +0200 (CEST)
Date:   Sat, 14 May 2022 00:18:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 2/2] locking/atomic/x86: Introduce arch_try_cmpxchg64
Message-ID: <20220513221820.GK76023@worktop.programming.kicks-ass.net>
References: <20220513153009.228282-1-ubizjak@gmail.com>
 <20220513153009.228282-3-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513153009.228282-3-ubizjak@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 05:30:09PM +0200, Uros Bizjak wrote:


> +#define arch_try_cmpxchg64(ptr, po, n)					\
> +	((__typeof__(*(ptr)))__try_cmpxchg64((ptr), (unsigned long long *)(po), \
> +					     (unsigned long long)(n)))

That doesn't look right (unless it's so late I really can't read
anymore, in which case ignore me and I'll try again on monday). But the
return value of try_cmpxchg is bool, not typeof(*ptr).
