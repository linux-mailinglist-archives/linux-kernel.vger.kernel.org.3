Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C849CB05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiAZNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiAZNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:39:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8870AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j3mxqba4lJDf0RPplJMQZZKNpeYszCRsoXdpeIzlqG0=; b=aFQ57o3xObWckwSj3FOIpyUQdD
        A6K24Xwi7js7rprKwslmoaHnxVAzmc4vuzBdCneEN8VlJhoJ0t9M1CG86bYf0WJeSuGs8EQdD/iq7
        58lgsejIvm/9M7bds0TmyJKb0/ohvJG6qrwSe9eoSxwFu5bz9oMQip9jmrAf36++2Aoy7un39C2+G
        tFyuHL+cCQKlr1yUzvtYTNXAbKUGiiFAoEQrwKLdx8zf99ESymVdOpBEhf78jbMlVww8oCp4m0nrM
        Nb4ONUM/fq2wo69UZmKjTKJHx6pjKsRyJpx0506AKFl1iWfXDFNGWVY8eZGa9oD4GYdJnFH0HyY+/
        yfk1WNvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCiVd-0045DA-GF; Wed, 26 Jan 2022 13:38:49 +0000
Date:   Wed, 26 Jan 2022 13:38:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        akpm@linux-foundation.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YfFO6VyMTrW1bWuu@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
 <e164d7f4-406e-eed8-37d7-753f790b7560@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e164d7f4-406e-eed8-37d7-753f790b7560@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:16:42AM +0100, David Hildenbrand wrote:
> A while ago I talked with Peter about an extended uffd (here: WP)
> mechanism that would work on fds instead of the process address space.

As far as I can tell, uffd is a grotesque hack that exists to work around
the poor choice to use anonymous memory instead of file-backed memory
in kvm.  Every time I see somebody mention it, I feel pain.
