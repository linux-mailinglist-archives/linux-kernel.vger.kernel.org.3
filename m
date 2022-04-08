Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F54F8E05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiDHET1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiDHETW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:19:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F582E5C7A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:17:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZQ205Sr9z4xYM;
        Fri,  8 Apr 2022 14:17:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1649391434;
        bh=+0mz5/6ccyYrJwsyIan2Rv2K8PJmRz01AUp5rFy9q2c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=USlpGx1tBA9iIs4Q2LQ35OtgE9MxSPMBZMdejToJ/HKg0u4IIUapwwfZTUc9RHRS2
         kJXvZiA1v99zXPlFmI4pF1FoucRYgJLk51lH3fDpnikZ8L6iZtBJfKPvUptqIqv6XQ
         7qBORcccG/DIs8go+zMdZFziiomZ2eKbr4aCx3XzOaL7o+l9cz2ln0vQR9Qz+N473n
         0KRdOKdSB8R6lZqSDnCtPzFsgUXXYLcXkGtnut1deS1htngyjkErdb4HXBhgzvJz5r
         Cb2UFe40ja9ZAezUX8YflBzlrmWlU9ws3oachrlRNcpke1xQaDlizRJHvGoIPB6ph3
         wZGCWRMikGC8A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 00/14] Convert powerpc to default topdown mmap layout
 (v8)
In-Reply-To: <20220310204917.3d42e6cf3088f7cf1c7fe7a6@linux-foundation.org>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
 <ddfed61b-e387-4554-eb88-6654b391d1a4@csgroup.eu>
 <877d91m7wd.fsf@mpe.ellerman.id.au>
 <20220310204917.3d42e6cf3088f7cf1c7fe7a6@linux-foundation.org>
Date:   Fri, 08 Apr 2022 14:17:12 +1000
Message-ID: <87v8vk6wfr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Fri, 11 Mar 2022 15:26:42 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> > What will be the merge strategy ? I guess it's a bit late to get it 
>> > through powerpc tree, so I was just wondering whether we could get 
>> > patches 2 to 5 in mm this cycle, and the powerpc ones next cycle ?
>> 
>> Yeah I didn't pick it up because the mm changes don't have many acks and
>> I'm always nervous about carrying generic mm changes.
>> 
>> It would be my preference if Andrew could take 2-5 through mm for v5.18,
>> but it is quite late, so I'm not sure how he will feel about that.
>
> 5.18 isn't a problem.  Perhaps you meant 5.17, which would be real tough.

Sorry, missed your reply.

> Can we take a look after 5.18-rc1?

Yes :)

cheers
