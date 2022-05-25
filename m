Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55829533BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbiEYLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243096AbiEYLhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:37:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437499E9F7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BtatFXJHwOsF1iN9MX4tcAeOtxNVAo5gxULQ5AIMb08=; b=ZIakz9seohAXW9BDPKhZq7RgEW
        WG+5PgpE+MFFpgPJT9GYaqhQEzm0PGEOaofnt9p53k70ThXN7i3PdncwedqqQQFTfPxY4jz0aLXCf
        8sfTMDmh/mBspt/a1Dboh+rLEkAesPZHw4HOlEc9QWttfl9D9Ai0+OlitMOzJv7w5/uKWekH+btNP
        1QklzOjtFoli9LnPFUN3aBtjEX1rMqYMq3yaUKUAnzCQWxRH6Tvzhn1vSprgAy5C140kEalGWnV8w
        x6MDk+6O9E/7SzZShfzZAULNj6A9RLe4sxNEhjGUgFnDPZll3QVgnhfQCTn4Ji/EpFu9ctTVwLUsW
        zMURbl0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntpJj-001bMC-I1; Wed, 25 May 2022 11:36:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6D0A30022C;
        Wed, 25 May 2022 13:36:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6FF3207693A1; Wed, 25 May 2022 13:36:42 +0200 (CEST)
Date:   Wed, 25 May 2022 13:36:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 1/4] objtool: Add --mnop as an option to --mcount
Message-ID: <Yo4UysC69UCwhlYp@hirez.programming.kicks-ass.net>
References: <20220523175548.922671-1-sv@linux.ibm.com>
 <20220523175548.922671-2-sv@linux.ibm.com>
 <26c7bfc8-3089-034a-70c0-8857d7cd3a99@csgroup.eu>
 <1653386854.o7nss9hzc9.naveen@linux.ibm.com>
 <d45030be-3f6b-ebeb-3d63-bf7a96d3ff3b@csgroup.eu>
 <1653388084.w21cyb07gc.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653388084.w21cyb07gc.naveen@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 04:01:48PM +0530, Naveen N. Rao wrote:

> We need to know for sure either way. Nop'ing out the _mcount locations at
> boot allows us to discover existing long branch trampolines. If we want to
> avoid it, we need to note down those locations during build time.
> 
> Do you have a different approach in mind?

If you put _mcount in a separate section then the compiler cannot tell
where it is and is forced to always emit a long branch trampoline.

Does that help?
