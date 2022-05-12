Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B7525036
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355403AbiELOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355400AbiELOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B6260861
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2H6oOa1Jm7efg8vMAP01Huzry7NOm7+jsbscO12jXSc=; b=qNMp9lA/tjtK+U8Y5Q5aoToURn
        4ky/lfzh8PITgJopNm+26oJXcFvGZGwGViRjWwZMCPvo7zhlzyRU1phujiAKznYAi0+KA7eZ4M2Pg
        vwn75jgd+ehaSDWnLfr6Gn3ki7/fPY6B0+Ro9iE9bFWw97Y4kMISOleOfSX2aGzbPVg+Jk4WQJ64H
        mU43UkFm7MDRODr/dVE/8yKjo2EaQqA+J2cCuLtbeikumtJKJlU0EcyEyjMl20odnZzn6YR0X2SbX
        6SQcM4hBu40I7i7e3DqmDLIAWxy1sM+vdaZXcjIlhtqat3CAUJTjDG5/sOEHP3JjwHkEe/NBEsfXb
        LzMsJYPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np9uO-006TT7-4P; Thu, 12 May 2022 14:35:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A0A130080B;
        Thu, 12 May 2022 16:35:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D2AB201E235B; Thu, 12 May 2022 16:35:15 +0200 (CEST)
Date:   Thu, 12 May 2022 16:35:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Implement Linear Address Masking support
Message-ID: <Yn0bI2W7JnZnHmj+@hirez.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
 <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:01:07PM +0000, David Laight wrote:

> > +static inline int64_t sign_extend64(uint64_t value, int index)
> > +{
> > +    int shift = 63 - index;
> > +    return (int64_t)(value << shift) >> shift;
> > +}
> 
> Shift of signed integers are UB.

The kernel uses -fno-strict-overflow, all the signed UB is gone.
