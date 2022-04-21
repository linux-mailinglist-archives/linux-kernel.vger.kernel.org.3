Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C750A934
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391958AbiDUTbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383185AbiDUTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:31:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A824D61F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9IfvoAG120Xgb0ZbzjsvhpbJeEGLGitWg1JM66E4oo8=; b=X69r0Etcj/6B3+sy90BSY4NKEL
        7ldBpId57FaQpleHIc5wnOp9OSVRPI8jxXpzTq92xcXe0m1O6x6dZsEHyo3NNJviVfUZe22gHrdpo
        TkwQix6AKUtTV5h5hjmf8sm5jszsMWL7C3pmc9cZLakFf8c8ovtKxDqaA6TN9EgaEeWL699gqsXPl
        mgHV8FK3GJU7BxGum4X82lLs3rT+ydvbo2/IH5+LVaJ4SZ54lDRm8vjOhCurZxj6BQ+cM1rcVYjP9
        /5iUvIXT4fEJ4yTJVbrsKtBaSMP5IbLkJN3aNMWksyqjAlmrCDGldgJ+derwVK0WCoukgLMpSrzMw
        ivpXRSvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhcTg-005Nww-42; Thu, 21 Apr 2022 19:28:32 +0000
Date:   Thu, 21 Apr 2022 20:28:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC 1/3] mm: change vma_is_anonymous to vma_is_private_anon
Message-ID: <YmGwYKtz3sFkJlcv@casper.infradead.org>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-2-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421190533.1601879-2-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:05:31PM -0400, Nico Pache wrote:
> The vma_is_anonymous function isn't fully indicative of what it checks.
> 
> Without having full knowledge of the mmap process, one may incorrectly
> assume this covers all types of anonymous memory; which is not the case.

Is your complaint that anonymous memory can also be found in file VMAs
that were mapped with MAP_PRIVATE?  ie COWed pages?

I don't think renaming this function is appropriate.  It's whether
the VMA is anonymous, not whether the VMA can contain anonymous
pages.
