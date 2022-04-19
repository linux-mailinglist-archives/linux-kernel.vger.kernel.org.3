Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7B507AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbiDSUOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiDSUN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D78E40A22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650399075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+wPHJQZU8EGdYfueFz9b0UM3cK7M3jQjEoZVOhG1vs=;
        b=HOnMjhKbho+/MJ+8vuZ7uWkRLhWS3xpGDv8imuuJkRq4UgvyMuk4+N0HRSWS6+AO9sUHdD
        LrnQLiXM1TSJCdmxxddKD4EOoML4T/2PANq3cSCtYTShzDdRUoFaCHrrs7a2fRu4Fw8rMm
        IrDltCn3wu3t3NMQ4UKxVy76sM5OML4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-jbRoj2DYNBWjBoepUpKjfA-1; Tue, 19 Apr 2022 16:11:12 -0400
X-MC-Unique: jbRoj2DYNBWjBoepUpKjfA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A02FC38008A0;
        Tue, 19 Apr 2022 20:11:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 913BC469A43;
        Tue, 19 Apr 2022 20:11:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23JKBBKN019491;
        Tue, 19 Apr 2022 16:11:11 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23JKBBHe019487;
        Tue, 19 Apr 2022 16:11:11 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 19 Apr 2022 16:11:11 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86: __memcpy_flushcache: fix wrong alignment if size >
 2^32
In-Reply-To: <CAHk-=wjNHZ1_sT4iN_TVu+2cmd_n2W+EYfd9vSL3L82kNJTmPg@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2204191551430.16728@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204190948080.18399@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wjNHZ1_sT4iN_TVu+2cmd_n2W+EYfd9vSL3L82kNJTmPg@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Apr 2022, Linus Torvalds wrote:

> On Tue, Apr 19, 2022 at 6:56 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > The first "if" condition in __memcpy_flushcache is supposed to align the
> > "dest" variable to 8 bytes and copy data up to this alignment. However,
> > this condition may misbehave if "size" is greater than 4GiB.
> 
> You're not wrong, but I also don't think it would be wrong to just have a
> 
>         if (WARN_ON_ONCE(size > MAX_INT))
>                 return;
> 
> in there instead.

If you skip copying, it could in theory have security or reliability 
implications (the user may be reading stale data that he is not supposed 
to read). So, I think it's better to just add WARN_ON_ONCE and proceed 
with the copying.

> It' not like "> 2**32" should ever really be a valid thing for any
> kind of copy in the kernel. Even if that were to be what you actually

For example, the dm-stats subsystem (drivers/md/dm-stats.c) can allocate 
extremely large blocks of memory using vmalloc (it is only limited to 1/4 
of total system memory) - though, it doesn't use memcpy on it.

> wanted to do (which sounds very unlikely), you'd need to split it up
> with cond_resched() just for latency reasons.
> 
>              Linus



From: Mikulas Patocka <mpatocka@redhat.com>

The first "if" condition in __memcpy_flushcache is supposed to align the
"dest" variable to 8 bytes and copy data up to this alignment. However,
this condition may misbehave if "size" is greater than 4GiB.

The statement min_t(unsigned, size, ALIGN(dest, 8) - dest); casts both
arguments to unsigned int and selects the smaller one. However, the cast
truncates high bits in "size" and it results in misbehavior.

For example:
	suppose that size == 0x100000001, dest == 0x200000002
	min_t(unsigned, size, ALIGN(dest, 8) - dest) == min_t(0x1, 0xe) == 0x1;
	...
	dest += 0x1;
so we copy just one byte "and" dest remains unaligned.

This patch fixes the bug by replacing unsigned with size_t.

As the function is not supposed to be used with large size, the patch also
adds a WARN_ON_ONCE there.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/x86/lib/usercopy_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/x86/lib/usercopy_64.c
===================================================================
--- linux-2.6.orig/arch/x86/lib/usercopy_64.c
+++ linux-2.6/arch/x86/lib/usercopy_64.c
@@ -117,9 +117,11 @@ void __memcpy_flushcache(void *_dst, con
 	unsigned long dest = (unsigned long) _dst;
 	unsigned long source = (unsigned long) _src;
 
+	WARN_ON_ONCE(size > INT_MAX);
+
 	/* cache copy and flush to align dest */
 	if (!IS_ALIGNED(dest, 8)) {
-		unsigned len = min_t(unsigned, size, ALIGN(dest, 8) - dest);
+		size_t len = min_t(size_t, size, ALIGN(dest, 8) - dest);
 
 		memcpy((void *) dest, (void *) source, len);
 		clean_cache_range((void *) dest, len);

