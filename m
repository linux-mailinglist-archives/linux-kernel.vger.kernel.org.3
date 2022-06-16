Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944A654DE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359783AbiFPJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359460AbiFPJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:40:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C559309
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xe7EVTVfA/LYwJX1fqIJNYg/fd5ZMqoScXc4Hw5xwQc=; b=oqFOhI9n/euMEb6yHqNMZXCtN+
        JXj3RafSEAdQvbGKAHXQHOE5f56H8B1uBNQCQt6AA3+v7gxD+BD7jU+CrwBITfLkzM24eovGid8Tn
        E2S0CWp8H1z1zdhxQhiNsB8tABKSZsju3DBEgMWPPSgFKlsZ6ZsKKIh2qW3ESza3b0ImFSc/xl6/j
        ua4cNeuvFm0KeFDgwdK/V8lToG+myTHc336nOVpEdPm95Al4keI/ZqdTcgH1IdcrAJ9ggjxz9rmJK
        0Iz4cVWuyHzHJ+L5sFDqA1W3vQ50sU/FvWuMwrFrzRf8/rxm3HYRH/CI5FdhAvm80wTnnnR9mhl8S
        2cu+oXzA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1lyh-008Nh5-Mg; Thu, 16 Jun 2022 09:39:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDFFA300212;
        Thu, 16 Jun 2022 11:39:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7AFD2014ABD6; Thu, 16 Jun 2022 11:39:50 +0200 (CEST)
Date:   Thu, 16 Jun 2022 11:39:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <Yqr6ZsLEyFb+Bphf@hirez.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 05:35:25PM +0300, Kirill A. Shutemov wrote:
> Add a couple of arch_prctl() handles:
> 
>  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
>    of tag bits. It is rounded up to the nearest LAM mode that can
>    provide it. For now only LAM_U57 is supported, with 6 tag bits.

As stated in the reply to the other patch; this isn't a 'for now' thing.
Due to how the untag thing works. Supporting U48 on 5-level kernels is
going to require a more complicated untag.


