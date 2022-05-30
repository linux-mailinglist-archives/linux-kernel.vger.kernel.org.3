Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128B1537540
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiE3F7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiE3F7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:59:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1726D858;
        Sun, 29 May 2022 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=FV6ixAgxONc97M+SI7U62WEMY00WEGgbcBEcX4KiHVQ=; b=4wohNBWacToPDLeDkf4XlTX1IE
        TXygurGB/B02n3EPQE3XWySSgIxr9iB/ux9RnN6rt3Qj874QlM1HRTDvdbUUlZ+pWGcDE98Ln8zMY
        GKOMGJG7QJxbQXdMSYoPUeDgA5waiScQCX5KbdDnpLc7u8qYXKxVTsnSnxCy+8RsjpafBZseLJfdS
        JkZGSnll1MYz6PQP87Crb898/AuJ5zDtykIZRX7t7EG6Qv57dqNHCOgCbzEt/abFujge2edN+AVSR
        cp6T58S2dRdLKc6X4x+ImbS3GX5l0Mlg7z7KU50Q8FlYi6s7BPvk7vGGCurhFp/NjilCP7AyXsddR
        1zfiU1Pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvYQp-005U5K-Aq; Mon, 30 May 2022 05:59:11 +0000
Date:   Sun, 29 May 2022 22:59:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 12/17] md/raid5-cache: Move struct r5l_log definition
 to raid5-log.h
Message-ID: <YpRdL+2e7gngOYPa@infradead.org>
References: <20220526163604.32736-1-logang@deltatee.com>
 <20220526163604.32736-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220526163604.32736-13-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:35:59AM -0600, Logan Gunthorpe wrote:
> Move struct r5l_log definition to raid5-log.h. While this reduces
> encapsulation, it is necessary for the definition of r5l_log to be
> public so that rcu_access_pointer() can be used on conf-log in the
> next patch.
> 
> rcu_access_pointer(p) doesn't technically dereference the log pointer
> however, it does use typeof(*p) and some older GCC versions (anything
> earlier than gcc-10) will wrongly try to dereference the structure:
> 
>     include/linux/rcupdate.h:384:9: error: dereferencing pointer to
>                  incomplete type ‘struct r5l_log’
> 
>       typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>            ^
> 
>     include/linux/rcupdate.h:495:31: note: in expansion of
>                   macro ‘__rcu_access_pointer’
> 
>        #define rcu_access_pointer(p) __rcu_access_pointer((p),
>        __UNIQUE_ID(rcu), __rcu)
> 
> To prevent this, simply provide the definition where
> rcu_access_pointer() may be used.

What about just moving any code that does the rcu_access_pointer on
conf->log to raid5-cache.c and doing an out of line call for it
instead?
