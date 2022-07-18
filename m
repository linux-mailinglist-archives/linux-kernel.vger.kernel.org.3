Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFDE5786E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiGRQCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiGRQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:02:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470B525E86;
        Mon, 18 Jul 2022 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JiL6On/p2ud1FotqFbiWA7JFUGDeQK+yOXFl6fRc5is=; b=s0exI5Sx2V3+vZYnUmlTTw2ry+
        a//WXhB+vKuLjLJTT52OzsL7rygI0OFsGp0f26X85U6OLRxHGWMF1Id20Wm+w9fMjmerHCm4AiL/b
        eym5DdJsd+P2kVDW16ftjP4v8G8QyvZyPxPx9upr+wUrqerhh4M0uLmu5Y2Kkfoz2Q357az9l2iYq
        pl14X2RuBj9lKxjzSmKePsTXTTJyucZ1yhdDtSqZhu3eJOqBvchC/Rk8xTU0rOyjo0sEiqf5Qqi9c
        KgeX5rabfeqOftzq+5XRSY+z/DGPjVEThj1W6OrZKttMUZp0I7za8U/M96kOtCU9elPbE5Iq1+6mh
        QzcB4TZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDTCA-00Co98-Sv; Mon, 18 Jul 2022 16:02:06 +0000
Date:   Mon, 18 Jul 2022 17:02:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/3] s390/crash: use static swap buffer for
 copy_to_user_real()
Message-ID: <YtWD/u2cIafi+vsf@casper.infradead.org>
References: <cover.1658148067.git.agordeev@linux.ibm.com>
 <77d50b4a2359d1791835b6111edaa155eb11c5ea.1658148067.git.agordeev@linux.ibm.com>
 <YtVkpRJ7jvLFuKs4@casper.infradead.org>
 <YtVzj5W5xr/UwjLT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVzj5W5xr/UwjLT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 04:51:59PM +0200, Alexander Gordeev wrote:
> On Mon, Jul 18, 2022 at 02:48:21PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 18, 2022 at 03:32:40PM +0200, Alexander Gordeev wrote:
> > > +++ b/arch/s390/kernel/crash_dump.c
> > > @@ -53,6 +53,7 @@ struct save_area {
> > >  };
> > >  
> > >  static LIST_HEAD(dump_save_areas);
> > 
> > I'd suggest you need a mutex here so that simultaneous calls to
> > copy_to_user_real() don't corrupt each others data.
> 
> We stop all (but one) CPUs before calling into the capture kernel -
> one that calls these functions. Similarily to racy hsa_buf[] access
> from memcpy_hsa_iter() this should not hit.

Could you show me how that works when two processes read from
/proc/vmcore at the same time?

> As you noticed last time, it is a pre-existing race and I was
> actually going to address it in a separate fix - if the problem
> really exists.
> 
> > > +static char memcpy_real_buf[PAGE_SIZE];
> > >  
> > >  /*
> > >   * Allocate a save area
> > > @@ -179,23 +180,18 @@ int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
> > >  static int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
> > >  {
> > >  	int offs = 0, size, rc;
> > > -	char *buf;
> > >  
> > > -	buf = (char *)__get_free_page(GFP_KERNEL);
> > > -	if (!buf)
> > > -		return -ENOMEM;
> > >  	rc = -EFAULT;
> > >  	while (offs < count) {
> > >  		size = min(PAGE_SIZE, count - offs);
> > > -		if (memcpy_real(buf, src + offs, size))
> > > +		if (memcpy_real(memcpy_real_buf, src + offs, size))
> > >  			goto out;
> > > -		if (copy_to_user(dest + offs, buf, size))
> > > +		if (copy_to_user(dest + offs, memcpy_real_buf, size))
> > >  			goto out;
> > >  		offs += size;
> > >  	}
> > >  	rc = 0;
> > >  out:
> > > -	free_page((unsigned long)buf);
> > >  	return rc;
> > >  }
> 
> Thanks!
