Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A59953874F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiE3S3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiE3S3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B92A62A05
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653935380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ALrzFnb0YEuDamJlOSrZjOy/DY+2J0hn9MNRn5A9C4=;
        b=NDaxXrXxwYOKO0vShj6qmUwCsK/7orKdIE91AUGSS+YGGZKvNr24TpfDws1pY4QC2FDBRi
        OPz7vct0u5N7KtTHt9wbW4mhLnglqmnj8j6YhmaSebrNuG4hV5B5a7OqQkiVxnAjjCAEpC
        66tbQ1/29LYSgIGjctk6Plhmj8GA9BU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-piy_VhB-NEe-CFRmYgpw1A-1; Mon, 30 May 2022 14:29:39 -0400
X-MC-Unique: piy_VhB-NEe-CFRmYgpw1A-1
Received: by mail-il1-f198.google.com with SMTP id g8-20020a92cda8000000b002d15f63967eso8750272ild.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ALrzFnb0YEuDamJlOSrZjOy/DY+2J0hn9MNRn5A9C4=;
        b=K4r7O+WuMpVt4ULYXbFizhFDVuKN3q6eAITmUvOBHm4HX1scWkZJkBB1tO42MFFRrH
         DiF5KO3JRRkmhwwRukiuNtdotfiLYynKW27mPeVzB+kQlXP6Bm1UVnyKZClXREgiAUD2
         d/esc6LNCkCOaxc+keGLq1CjnvMSnr19RTB2tisPJq02jpD8Pv3nMJABZe+wqQveMlAi
         25ZkymkVvFktvKi4clNhaB7RH4iBd5g1JP+BUkfF1HzNph9WxlFQp0VqPzB/thfO0Git
         DTfa0aAUxFt894h+Cmhb/V7HKVqbApIXlPo6QHQpoTJJEAXvWRvMc7DwrUHrzJQiV/At
         PAtw==
X-Gm-Message-State: AOAM532lgl91PiZq+RvdamhwPdMyZ5a4Egug//ZoNB4vkHR2/wwh07Sw
        llZuJl9xNNCWZeJpvRzn4aeAd6oFMlvo82/QHGVP7X/BXGONy8AP5FAiEfqedqwzZDq7GE8+0ha
        OiB48vWZshJkMSUCx/YFEj718
X-Received: by 2002:a92:d785:0:b0:2d1:7ce6:b834 with SMTP id d5-20020a92d785000000b002d17ce6b834mr25171905iln.207.1653935377088;
        Mon, 30 May 2022 11:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3wrc9ZuPCRdn+Dbnr8a7+sDY/SXALiOk3qZ3Cm9Rs8SSVa+bj9UHR0EABkWjwoIvWxsPXBw==
X-Received: by 2002:a92:d785:0:b0:2d1:7ce6:b834 with SMTP id d5-20020a92d785000000b002d17ce6b834mr25171841iln.207.1653935376794;
        Mon, 30 May 2022 11:29:36 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id cn9-20020a0566383a0900b003313b7a5731sm183095jab.178.2022.05.30.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 11:29:36 -0700 (PDT)
Date:   Mon, 30 May 2022 14:29:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>,
        linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
        Jonas Bonn <jonas@southpole.se>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        Richard Henderson <rth@twiddle.net>,
        Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-um@lists.infradead.org, "H . Peter Anvin" <hpa@zytor.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        openrisc@lists.librecores.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-hexagon@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Stafford Horne <shorne@gmail.com>, linux-csky@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv@lists.infradead.org, Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpUNC6iGrZRlWMyA@xz-m1.local>
References: <20220527193936.30678-1-peterx@redhat.com>
 <YpPYkzbrQmy4FjrI@osiris>
 <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
 <YpToVpjXmdFqGOpY@xz-m1.local>
 <YpTqNKMTt8PoA41n@xz-m1.local>
 <YpT443jVZtM6p9OD@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YpT443jVZtM6p9OD@osiris>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 07:03:31PM +0200, Heiko Carstens wrote:
> On Mon, May 30, 2022 at 12:00:52PM -0400, Peter Xu wrote:
> > On Mon, May 30, 2022 at 11:52:54AM -0400, Peter Xu wrote:
> > > On Mon, May 30, 2022 at 11:35:10AM +0200, Christian Borntraeger wrote:
> > > > > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > > > > index 4608cc962ecf..e1d40ca341b7 100644
> > > > > --- a/arch/s390/mm/fault.c
> > > > > +++ b/arch/s390/mm/fault.c
> > > > > @@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> > > > >   	/* The fault is fully completed (including releasing mmap lock) */
> > > > >   	if (fault & VM_FAULT_COMPLETED) {
> > > > > -		/*
> > > > > -		 * Gmap will need the mmap lock again, so retake it.  TODO:
> > > > > -		 * only conditionally take the lock when CONFIG_PGSTE set.
> > > > > -		 */
> > > > > -		mmap_read_lock(mm);
> > > > > -		goto out_gmap;
> > > > > +		if (gmap) {
> > > > > +			mmap_read_lock(mm);
> > > > > +			goto out_gmap;
> > > > > +		}
> 			fault = 0;  <----
> > > > > +		goto out;
> > 
> > Hmm, right after I replied I found "goto out" could be problematic, since
> > all s390 callers of do_exception() will assume it an error condition (side
> > note: "goto out_gmap" contains one step to clear "fault" to 0).  I'll
> > replace this with "return 0" instead if it looks good to both of you.
> > 
> > I'll wait for a confirmation before reposting.  Thanks,
> 
> Right, that was stupid. Thanks for double checking!
> 
> However could you please add "fault = 0" just in front of the goto out
> like above? I'd like to avoid having returns and gotos mixed.

Sure thing.

-- 
Peter Xu

