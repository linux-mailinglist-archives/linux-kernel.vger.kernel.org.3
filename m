Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AEE468660
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355533AbhLDRBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355453AbhLDRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:01:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E22C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6kcYT10sBhVy5DwYlzCSWp6r/Y2XZkdGIB6Lo+/QhjM=; b=PNH3Xk5FRKeRMwzogxc2VQayoY
        2JjJNArtiHYM3dpoisY5VTEIvvZAO27TDW6bl5muTUqUkqY7DOzivjQbIts8NHM9ouUcfCTjIsiFw
        Ks/I6NC3bDPad1bI9YS6vYsyQ6Vuc/V47lvBmLWe0XlTX4GKLCWWp5qsjiTl4AFpiS/aXtqAVczfV
        LDQgRVeQH76FDN3NN3feXczyPxXrQmM+27YWKl41EhYbmHMUuOPbmqR0lKSDusgIelK00BK9RwLiK
        ed1FRrILu24J3WJQ8ybwAvdHxbA90SDO/Dp2uQcuqo0UPDgbHJ653bXcFoY7D68w+O3XJF50ZFCQX
        XGJIEn0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtYMZ-00DpuE-7f; Sat, 04 Dec 2021 16:58:15 +0000
Date:   Sat, 4 Dec 2021 16:58:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <YaueJxgSJ9R4oOWf@casper.infradead.org>
References: <202111242331.x19Qywph-lkp@intel.com>
 <5166da50-e2af-139b-9f7f-a1bcabe10775@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5166da50-e2af-139b-9f7f-a1bcabe10775@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 05:45:45PM +0100, David Hildenbrand wrote:
> On 24.11.21 16:42, kernel test robot wrote:
> > sparse warnings: (new ones prefixed by >>)
> >>> fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *p @@     got char *buf @@
> >    fs/proc/vmcore.c:161:34: sparse:     expected void const [noderef] __user *p

> >    159				if (!userbuf)
> >    160					memset(buf, 0, nr_bytes);
> >  > 161				else if (clear_user(buf, nr_bytes))
> >    162					tmp = -EFAULT;
> >    163			} else {
> 
> Sparse is wrong as it doesn't see the bigger picture. "int userbuf"
> tells us what we're actually dealing with ...

Sparse is pointing to a deeper problem here.  We should be using an
iov_iter throughout vmcore.c, but that's kind of a big project ...
