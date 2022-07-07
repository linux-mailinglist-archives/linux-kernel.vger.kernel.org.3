Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D274256AB81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiGGTGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiGGTGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:06:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2198157230;
        Thu,  7 Jul 2022 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=05SlPgOjw8Ge7G3S7ysnQzpGsSQeCNpy+r8rpobhENo=; b=Vbk/7NvhWFnJ0xBPYy409PU2F8
        kH3S9RPlLO4ChI+L3vk7Awx/gNAS8+F2row0fMBq+SKGAuDiu2wy62hQlZWqyNgGPUW+72uzuFdPU
        GXlGo2d+FU8Ot9NIKmZLzmW6vc3MpiNUYehYjIzf0mkLtJoxyjcLI+Roj6gzQrQP71ELtAJpa7DJG
        j6VOZpP+WyZxGY403J/cpIJ0nCXlcYxJJXqgp4RqxM0oBBl/mMJR3Walhj34C1/qOyxtoZQ2CVctp
        5xgRVQmJiNiFCjEBn0kP/OUKZIYlNJIf+EXxWjYqpubrKnKAcqykBp9oF4TJbgJN+XQzlkVz5fUK9
        X+nOKZLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9WpQ-002qNW-3O; Thu, 07 Jul 2022 19:06:20 +0000
Date:   Thu, 7 Jul 2022 20:06:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/crash: allow multi-segment iterators
Message-ID: <YscurHynz2jO1qoe@casper.infradead.org>
References: <cover.1657172539.git.agordeev@linux.ibm.com>
 <613f63d652bb4fa6fb3d2bb38762de6bb066b35a.1657172539.git.agordeev@linux.ibm.com>
 <YsbXfh3e2rDEKSNw@casper.infradead.org>
 <YsbgQLNXbHH30phb@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsbgQLNXbHH30phb@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:31:44PM +0100, Al Viro wrote:
> > @@ -73,10 +73,9 @@ int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count)
> >  		}
> >  		offset = src % PAGE_SIZE;
> >  		bytes = min(PAGE_SIZE - offset, count);
> > -		if (copy_to_user(dest, hsa_buf + offset, bytes))
> > +		if (copy_to_iter(hsa_buf + offset, bytes, iter) != bytes)
> >  			return -EFAULT;
> 
> Umm...  Then you want iov_iter_revert() on short copy...

... maybe better to change the calling convention to return the short
write and have the caller do it if they care?
