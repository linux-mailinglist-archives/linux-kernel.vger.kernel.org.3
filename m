Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84D5877DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiHBHc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiHBHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B68F6556
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659425574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvz5t+oZNlSf7bcC71XjFFahU1M2khcyplx7wbP8UW0=;
        b=YYxyb6SfLIukGNUIlV77i9S8QqjV5rCLoZ68AhKAYPUEDiltqG3W/I8p03OuazMvPXqnmA
        fzIwNcoDVqSc1G2eNg/grFlvW43DDJTmb0TaoQBgdHgKpiQAZnHU4rDwIBbiaAwuY1/5oB
        veuu2naH3AEtZHgVc8713KvdiM1TJnk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-8CSRVKvEMFanEt-e__OItg-1; Tue, 02 Aug 2022 03:32:51 -0400
X-MC-Unique: 8CSRVKvEMFanEt-e__OItg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3228811766;
        Tue,  2 Aug 2022 07:32:50 +0000 (UTC)
Received: from localhost (ovpn-13-104.pek2.redhat.com [10.72.13.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E0FC04482;
        Tue,  2 Aug 2022 07:32:49 +0000 (UTC)
Date:   Tue, 2 Aug 2022 15:32:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Message-ID: <YujTHv0xVG8DirkW@MiWiFi-R3L-srv>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com>
 <YuiUzodsyv3hZAgs@MiWiFi-R3L-srv>
 <1923146.PYKUYFuaPT@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1923146.PYKUYFuaPT@opensuse>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/22 at 08:20am, Fabio M. De Francesco wrote:
> On martedì 2 agosto 2022 05:06:54 CEST Baoquan He wrote:
> > On 07/08/22 at 01:15am, Fabio M. De Francesco wrote:
> > > The use of kmap() and kmap_atomic() are being deprecated in favor of
> > > kmap_local_page().
> > > 
> > > With kmap_local_page(), the mappings are per thread, CPU local and not
> > > globally visible. Furthermore, the mappings can be acquired from any
> > > context (including interrupts).
> > > 
> > > Therefore, use kmap_local_page() in kexec_core.c because these mappings 
> are
> > > per thread, CPU local, and not globally visible.
> > > 
> > > Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
> > > enabled.
> > 
> > Wondering what arch you tested with.
> 
> I'm sorry, I forgot to say that I use x86_32 with 4GB to 6GB RAM.
> This is usually an information that I add in the commit messages of all the 
> recent conversions I'm working on across the entire kernel.
> 
> Another important information (overlooked again this time) is that (1) 
> kmap() comes with an overhead as mapping space is restricted and protected 
> by a global lock for synchronization and (2) it also requires global TLB 
> invalidation when the kmap’s pool wraps and it might block when the mapping 
> space is fully utilized until a slot becomes available.

Thanks a lot for update with more details, Fabio. Maybe these can be
added into log with v3 if you think they are worth adding, and with my
Ack since no code change related. You decide.

Thanks again for the effort.

> 
> More information about why these kmap() to kmap_local_page() conversions 
> are needed / preferred can be found in the recent changes I made to 
> highmem.rst. They are already in mainline since about two months.
> 
> A second round of additional changes has been taken by Andrew M. just few 
> days ago.
> 
> My goal is to convert the most of the kmap() call sites that are still left 
> across the whole kernel. I'm not yet sure that these kinds of conversions 
> can be done everywhere, especially if the kernel virtual address of the 
> mapping is handed to other contexts, because this would invalidate the 
> pointer returned by kmap_local_page().  
> 
> > This looks good, but may not benefit much. Say so because I doubt
> > how many 32bit systems are using kexec/kdump mechanism.
> 
> I really cannot say nothing about how many 32 bits systems are using kexec/
> kdump mechanism, however I still think that the conversions are worth 
> everywhere. 

Yes, agree.

> 
> > Anyway, 
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> 
> Thank you so much!
> 
> Fabio
> 
> > > 
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > v1->v2: A sentence of the commit message contained an error due to a
> > > mistake in copy-pasting from a previous patch. Replace "aio.c" with
> > > "kexec_core.c".
> > > 
> > >  kernel/kexec_core.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index 4d34c78334ce..6f98274765d4 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -814,7 +814,7 @@ static int kimage_load_normal_segment(struct kimage 
> *image,
> > >  		if (result < 0)
> > >  			goto out;
> > >  
> > > -		ptr = kmap(page);
> > > +		ptr = kmap_local_page(page);
> > >  		/* Start with a clear page */
> > >  		clear_page(ptr);
> > >  		ptr += maddr & ~PAGE_MASK;
> > > @@ -827,7 +827,7 @@ static int kimage_load_normal_segment(struct kimage 
> *image,
> > >  			memcpy(ptr, kbuf, uchunk);
> > >  		else
> > >  			result = copy_from_user(ptr, buf, uchunk);
> > > -		kunmap(page);
> > > +		kunmap_local(ptr);
> > >  		if (result) {
> > >  			result = -EFAULT;
> > >  			goto out;
> > > @@ -878,7 +878,7 @@ static int kimage_load_crash_segment(struct kimage 
> *image,
> > >  			goto out;
> > >  		}
> > >  		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
> > > -		ptr = kmap(page);
> > > +		ptr = kmap_local_page(page);
> > >  		ptr += maddr & ~PAGE_MASK;
> > >  		mchunk = min_t(size_t, mbytes,
> > >  				PAGE_SIZE - (maddr & ~PAGE_MASK));
> > > @@ -894,7 +894,7 @@ static int kimage_load_crash_segment(struct kimage 
> *image,
> > >  		else
> > >  			result = copy_from_user(ptr, buf, uchunk);
> > >  		kexec_flush_icache_page(page);
> > > -		kunmap(page);
> > > +		kunmap_local(ptr);
> > >  		arch_kexec_pre_free_pages(page_address(page), 1);
> > >  		if (result) {
> > >  			result = -EFAULT;
> > > -- 
> > > 2.36.1
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > > 
> > 
> > 
> 
> 
> 
> 

