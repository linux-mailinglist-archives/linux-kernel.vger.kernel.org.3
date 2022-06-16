Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831E54DE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359724AbiFPJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359615AbiFPJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:34:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3055A35867
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IdZ9P0l3nWpjnGWfPtV/wrhTZhkFfoKTiNu/6UnWni0=; b=fAcBemFJ7ryTficeed5VZ9Jies
        0ciz1gmqVePqskvIT3SgaefkW/Tf3MIFMs5+fxas/pO/UXtRlVmhZ71/FH2IY3fVfhc8lV9wzfr+t
        /LtmfqmTxv+nOFdrGlGxft9R5UlTDun/khkDqHUSSrDwGdUFf5/lXZptbpuYJlr2i7DzxAMHmeCXK
        8/nANe3fC4f5dPpodu6ywHHI+6dEdtF+fmDfNhQapYVjwqDhZaYMoIktL7Egy9ZF/XDFcoORRnaYw
        ZjTr211tJ5xEoX8oBMVZ0IqvydeMCRRjpccJ2B5Iq48UbkcMGUl9dz+cTEePasjpARYGgYne/P6Vs
        ASrAgY8Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1ltH-008Nd0-Da; Thu, 16 Jun 2022 09:34:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DA9E30008D;
        Thu, 16 Jun 2022 11:34:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6F3B2014ABD6; Thu, 16 Jun 2022 11:34:14 +0200 (CEST)
Date:   Thu, 16 Jun 2022 11:34:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <Yqr5FmoBB5LZRhU5@hirez.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:36:43PM +0000, Edgecombe, Rick P wrote:

> Is this special kernel address handling only needed because
> copy_to_kernel_nofault(), etc call the user helpers?

It is to make absolutely sure we don't need to go audit everything, if
code is correct without untag_pointer() it will still be correct with it
on.

Also avoids future bugs due to being robust in general.
