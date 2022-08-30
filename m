Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685365A5A15
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiH3Ddx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH3DdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:33:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EFD58DFA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AegjQ+c2RLhkoxY7qPbOU3nl+MXQe5Bj6KmEXlJT790=; b=AbBfcj0E38zqkhdNCr94y667xh
        i8bjL22ZUdWYBIRs+2cAjGbGLlnUYuQnpfS36XFCrBtm+lsK7cSKZbfrlvAx6nuSexYsF5g/nia8B
        qT/eFxOH8jz0+Wf0eDd/9AdoXtd2MKg+LqZndeCGuwgJnz9ohDE5Jyr1aP7R3IYWbdhXCW3VLjeyR
        ik17cti651e/xMvWShj11bu9novevTMO1g6MMHC01xLKC+ZXNImfyTl6XlPlYa4n5nTC+kIS0eWcd
        mS8nlIF+SKKXVBa7GHkRAanwQhnys5eyuMVRhNH+cIyEdwfojOcQFBNp+kddDQhLjhyn3aDMYKinA
        WXMBbu7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSrzz-003dvj-6d; Tue, 30 Aug 2022 03:33:11 +0000
Date:   Tue, 30 Aug 2022 04:33:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 1/7] mm/hugetlb: add folio support to hugetlb specific
 flag macros
Message-ID: <Yw2E937l+GARR3Vb@casper.infradead.org>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829230014.384722-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:00:08PM -0700, Sidhartha Kumar wrote:
>  #define TESTHPAGEFLAG(uname, flname)				\
> +static __always_inline								\
> +int folio_test_hugetlb_##flname(struct folio *folio)		\

One change I made was to have folio_test_foo() return bool instead of
int.  It helps the compiler really understand what's going on.  Maybe
some humans too ;-)

> +	{	void **private = &folio->private;		\
> +		return test_bit(HPG_##flname, (void *)((unsigned long)private));	\

I've made this tricky for you by making folio->private a void * instead
of the unsigned long in page.  Would this look better as ...

	{							\
		void *private = &folio->private;		\
		return test_bit(HPG_##flname, private);		\

perhaps?
